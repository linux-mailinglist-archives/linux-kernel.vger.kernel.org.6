Return-Path: <linux-kernel+bounces-567920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B395A68BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA6C7AA63A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98888255226;
	Wed, 19 Mar 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqtzeUX/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B611254B01
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384442; cv=none; b=pmTpueqlw9qkaKyr9hoOoC+2adinywFZvNLPSpzBml6bNbiGiCFj70oTLF33bNjn8uELDlOMR0sFyEb/MmSf71Fi5/0kCn1UNM3HZJMp+huRFbQIagGELa5AlulyARtQp7aTECkqcFquI4b2hd7SHQYkJyDScED1AnaKxOfoFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384442; c=relaxed/simple;
	bh=nqIrR5gsf+WAV1exZh0bkciSxO/FVA36+RLDOmghAPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNHb+bIDq4LSE2LXVH+ikXbj4JYKjTRLtRM3/K8gqSas89RpAoKttsXfFO2FJb5O1gxXIONWJO6VT4UR1vfGIW9XblJr+DA6SNlubRZMc0kn6aa9OoAjAUZyFW/XOgWcs5a6EkfjvzfPUJTvh08psHY36IdOlMmt1fkt17nXqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqtzeUX/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so9480685a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742384438; x=1742989238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mnFp/IlyQSmTN11coM6CacS2HH63qWF1P6HQesyvvvY=;
        b=IqtzeUX/xMCj0BV6NwRCRHv5/5FOdcGlFwp1s6bgmE2w4+wMDhmHTKw/fCS04x9wd9
         PEWFC2SQNq7CkoN7cl7DiToNOlTGJ4Bml3XpwNZzuRjZqBoo9+pyL7hDCX2oJPrfXLc/
         /3NX8TYi2yjyEO+5/7C1YhIpbJElQ3zUCmNho61/AezMtVgYXcXkRPWQb0Hfw6tqaJLn
         1hYA/Uju1QwF6A0Z/RIrHkByWzm+7SyveKW8Zoc1Hc6K/Wau7SZ2jflxl2Jd3bUAt8sI
         vUC++ikd5QQ55VNXxiWt4GKJIVLT6zNsxZuT48GBlPAI+plUXuG0hCWOlo1Muzs3Zh2Q
         g9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384438; x=1742989238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnFp/IlyQSmTN11coM6CacS2HH63qWF1P6HQesyvvvY=;
        b=J5kIgKNJMOR6maeHoJqWU5ugkGLsdYECR17EXBW5XY1tvEPCewdecs9G0q2gnmHctC
         caAoO4zbEL/xUcbUYs5nQ32mkk7O40JtOR/mbZ3BKWdE9zMNKNWRt8fcD6r8jRM33eiS
         ol6F5pv1FBv0wj8ZjiWg0ux6Hp7CgYMae2miN2vfJh2MweA3yzXszG7PDy+zgOqZRr23
         aAYZkGpS+5o850dgMy6N6zEei3+X0sxq0lXpsr2YKCmk/2vUCN+wsIz8OwVVRVVqaij9
         96kgVfeT4I+X2/OuJmYfhZzfbAnwBY0Crd01FVMNs2jHEUHaJFS7gcZ3GnsT+xC8znb+
         zs0w==
X-Forwarded-Encrypted: i=1; AJvYcCWygZZGfg8K0nor6nh9M7wBUNF8PWeMjX49LFq4QXYxOE3Yf6d1cPsUlupbftHXdp5YqYAaDVfiKV+AWYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSmyiCxMZI3JonS+URCgpg1sz+9uhTdGIYAKPfM1icK/lGpaY
	coSIr2+Ua4gfhC1pg+A2HHjsesL8W/ak1Y9DHDXnAHl125xlih/smDXr0mtlZyTU01khsRgtOxV
	AuuaF8ypPcP95W60y5JoaiejJBSx8mYNQr2KeVA==
X-Gm-Gg: ASbGncvdisRWonsw1cq7CgikBzjGKth8wfzqVh5ZUBfZ4SQBU37ykiulQmNul0iRhVR
	3dFFXqHN6mxWDf/rHidGO68NKarCYZiViBE2F50s/kZMmgCb89+s+XDG1xqZbSUxcHaugGm2vln
	S/boh18WWN+z2J4/AblN+ChzFSPO4=
X-Google-Smtp-Source: AGHT+IF0PzKaNKAL7SPqWhs9UxBZVmDcGAhQ39w6MNvnxwI7NAxBaxdfkqg2A7NnvQaWeAw8MONWf7mWrGQhnF9ndlg=
X-Received: by 2002:a17:907:3e1d:b0:ac2:aa51:5df2 with SMTP id
 a640c23a62f3a-ac3b7f91d17mr235997766b.47.1742384438476; Wed, 19 Mar 2025
 04:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318140226.19650-1-linmq006@gmail.com>
In-Reply-To: <20250318140226.19650-1-linmq006@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Mar 2025 12:39:58 +0100
X-Gm-Features: AQ5f1JpZhZOJWrjReMX_ekwAE_r0NF0Q1GA_lYDgPOQJ7eXkzTyG3252h8Kv8jI
Message-ID: <CAPDyKFreSxNRF7ZuokqjxJQQsAxHOvX8VBS8C5usyDJuvT4p+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: Fix memory leak in mmc_omap_new_slot
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Aubin Constans <aubin.constans@microchip.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Christian Loehle <christian.loehle@arm.com>, Allen Pais <allen.lkml@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 15:02, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> Add err_free_host label to properly pair mmc_alloc_host() with
> mmc_free_host() in GPIO error paths. The allocated host memory was
> leaked when GPIO lookups failed.
>
> Fixes: e519f0bb64ef ("ARM/mmc: Convert old mmci-omap to GPIO descriptors")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 62252ad4e20d..3cdb2fc44965 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1272,19 +1272,25 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>         /* Check for some optional GPIO controls */
>         slot->vsd = devm_gpiod_get_index_optional(host->dev, "vsd",
>                                                   id, GPIOD_OUT_LOW);
> -       if (IS_ERR(slot->vsd))
> -               return dev_err_probe(host->dev, PTR_ERR(slot->vsd),
> +       if (IS_ERR(slot->vsd)) {
> +               r = dev_err_probe(host->dev, PTR_ERR(slot->vsd),
>                                      "error looking up VSD GPIO\n");
> +               goto err_free_host;
> +       }
>         slot->vio = devm_gpiod_get_index_optional(host->dev, "vio",
>                                                   id, GPIOD_OUT_LOW);
> -       if (IS_ERR(slot->vio))
> -               return dev_err_probe(host->dev, PTR_ERR(slot->vio),
> +       if (IS_ERR(slot->vio)) {
> +               r = dev_err_probe(host->dev, PTR_ERR(slot->vio),
>                                      "error looking up VIO GPIO\n");
> +               goto err_free_host;
> +       }
>         slot->cover = devm_gpiod_get_index_optional(host->dev, "cover",
>                                                     id, GPIOD_IN);
> -       if (IS_ERR(slot->cover))
> -               return dev_err_probe(host->dev, PTR_ERR(slot->cover),
> +       if (IS_ERR(slot->cover)) {
> +               r = dev_err_probe(host->dev, PTR_ERR(slot->cover),
>                                      "error looking up cover switch GPIO\n");
> +               goto err_free_host;
> +       }
>
>         host->slots[id] = slot;
>
> @@ -1344,6 +1350,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>                 device_remove_file(&mmc->class_dev, &dev_attr_slot_name);
>  err_remove_host:
>         mmc_remove_host(mmc);
> +err_free_host:
>         mmc_free_host(mmc);
>         return r;
>  }
> --
> 2.39.5 (Apple Git-154)
>

