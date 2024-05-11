Return-Path: <linux-kernel+bounces-176734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C788C33DF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0EE282232
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593A24B28;
	Sat, 11 May 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEgKZYrG"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D85224DD
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715464028; cv=none; b=qWmrdzvezOGcz2pB+vw13XK2VxYf/RUJQG16nzpCNG8hzmQaCg3DaQ81A1+HwI625l4iJBj3ZL5YWaemq2MQR6N8LxnljRCW1IOemfMdLVV0p6aYY4XW8AF5TK5roF6niU1x7yTh0rl/oOCJ/MSpJGQidb8uIvyC19BNUgCsnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715464028; c=relaxed/simple;
	bh=kgtbFy2eSnTzPw4xjY4seg/MJRPmqlcxNeoaq47N8Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8jC8Q903qY90O7ObTIWx172RuslLttV4GZm8IKf6elh4ecpnU2yTqqw3H2sjGxrw9/ooh9AYuBn5eHk6Awr6/vZq6WauirFnbNWKWnr0xQkO1JTWPfQMidQCH27GAHpNuUHsvJ9zDVvAFzDnq6mSD+O6E9bRPzVZov+mhlo8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BEgKZYrG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6203f553e5fso33599307b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715464024; x=1716068824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UUDDnmzrxB3l3/4aj031ZrzOLNCmAjmO9rvghUTgzkE=;
        b=BEgKZYrGIq4p1gVZha/Nkjls8UFtnAoxf/pmEWRTU49101eUNy185HBfBJ2t5QRcSh
         hRGKFGj46lBuNfo0wDAJiD/GgDxp2m1J4/eKl9BVbNnWk5buU0UF1JK5VZrYwPYkC+Tw
         vmTxlTd0h7/K/hs0CO/MJr6nImqzM1P5FmA0PgCjfXGgeVEB2QHDcli1PClfTvtdhUFk
         ER2q0tfPiEODu6jF16axWbiQDWPOmNCscW2uLxO1sZ78V4Gk5x40TBIdHtdJ7oUKe3aA
         kphslASG6qqBBHnv+BC37fKtWQQ9yEvtps+MQtoAz3nbL/TVFWVkpo2zHKeqZ8HZXWqG
         kkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715464024; x=1716068824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUDDnmzrxB3l3/4aj031ZrzOLNCmAjmO9rvghUTgzkE=;
        b=A699rTFNZkBZsRHVwrGwcX8rmgvjZQ7nvi2s2iMhF0UtSNhnlodC5tjRD1VvvUQXuK
         4NHi4rKECKXAjFTWKfx+xUuBWdUezubUCcGCBDhD9gGXfbk6quKwlseSJ80Ucwgoic9N
         UH4Qse7qtkFx6Fwe+BwCqxL17RJVTXHtp0FrmYqrcONKGVWhxXE3eoVh/2TNdRJwQfVB
         SGcTQ7On1ov1fzQjLcew0oAzD/YBqR5zYZ2WD352B7l75EBPggDUFabwSv7Z8uN5mJHp
         UkwyH5vvLv7voA2AFZh7N2IG1uUzYjOP/RmqINaOHN8FQcWeB9Kjb7HTNErxuij76iQI
         zHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo3RhZk/z8e241sCrSSgY4Ud2LkWah2ZcyBaBfzGLCYKTniz0zNcI0ILAbD9IrQmEl1jFUqjGux6C1CeqFvab4EyrGCIfWGKbz+wtH
X-Gm-Message-State: AOJu0Yz5YgLTajgmSyIwUrSvDeRr3aK9vANDLatzHEurim+NUUcxZ9xe
	4EElCb/5hrTZ/mlsNaS/1yi+vGtQ8zgnx2Gy1ePu2eyzERQKif/LkMBZpkr19gyJGXhVEyxO+RH
	URbPBoJ5+W5W57JrJRt4RimRJwL7jK5uXZa/TXg==
X-Google-Smtp-Source: AGHT+IGG3nr3fWq7oYomiHLISDdigDRI73rcAWer5xHynouZBj9dhN1hlkvK3TDT9c5wAPBOWXNGkt1XOlWrmP10/T4=
X-Received: by 2002:a05:690c:ed4:b0:61a:e9f6:2b1b with SMTP id
 00721157ae682-622aff774d9mr84631617b3.8.1715464024566; Sat, 11 May 2024
 14:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511-msm-adreno-memory-region-v2-1-9f33f42e7b99@gmail.com>
In-Reply-To: <20240511-msm-adreno-memory-region-v2-1-9f33f42e7b99@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 00:46:53 +0300
Message-ID: <CAA8EJprMULN1BbRvUjh81f7x02cdg7UeNzuEnw2nUNrmKC7eFw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/a6xx: request memory region
To: Kiarash Hajian <kiarash8112hajian@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 22:56, Kiarash Hajian
<kiarash8112hajian@gmail.com> wrote:
>
> The driver's memory regions are currently just ioremap()ed, but not
> reserved through a request. That's not a bug, but having the request is
> a little more robust.
>
> Implement the region-request through the corresponding managed
> devres-function.
>
> Signed-off-by: Kiarash Hajian <kiarash8112hajian@gmail.com>
> ---
> Changes in v2:
> - update the subject prefix to "drm/msm/a6xx:", to match the majority of other changes to this file.

Same comment as I posted for v1 of the patch.

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 8bea8ef26f77..aa83cb461a75 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -636,9 +636,9 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>
>  err:
>         if (!IS_ERR_OR_NULL(pdcptr))
> -               iounmap(pdcptr);
> +               devm_iounmap(&pdev->dev,pdcptr);
>         if (!IS_ERR_OR_NULL(seqptr))
> -               iounmap(seqptr);
> +               devm_iounmap(&pdev->dev,seqptr);
>  }
>
>  /*
> @@ -1503,7 +1503,7 @@ static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       ret = ioremap(res->start, resource_size(res));
> +       ret = devm_ioremap_resource(&pdev->dev, res);
>         if (!ret) {
>                 DRM_DEV_ERROR(&pdev->dev, "Unable to map the %s registers\n", name);
>                 return ERR_PTR(-EINVAL);
> @@ -1646,7 +1646,7 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>         dev_pm_domain_detach(gmu->cxpd, false);
>
>  err_mmio:
> -       iounmap(gmu->mmio);
> +       devm_iounmap(gmu->dev ,gmu->mmio);
>
>         /* Drop reference taken in of_find_device_by_node */
>         put_device(gmu->dev);
> @@ -1825,9 +1825,9 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>         dev_pm_domain_detach(gmu->cxpd, false);
>
>  err_mmio:
> -       iounmap(gmu->mmio);
> +       devm_iounmap(gmu->dev ,gmu->mmio);
>         if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "rscc"))
> -               iounmap(gmu->rscc);
> +               devm_iounmap(gmu->dev ,gmu->rscc);
>         free_irq(gmu->gmu_irq, gmu);
>         free_irq(gmu->hfi_irq, gmu);
>
>
> ---
> base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
> change-id: 20240511-msm-adreno-memory-region-2bcb1c958621
>
> Best regards,
> --
> Kiarash Hajian <kiarash8112hajian@gmail.com>
>


-- 
With best wishes
Dmitry

