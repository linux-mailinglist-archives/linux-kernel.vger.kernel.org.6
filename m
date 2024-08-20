Return-Path: <linux-kernel+bounces-293876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D132C958613
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE7F1F23205
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FF18EFC7;
	Tue, 20 Aug 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p34sWvix"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A518EFFE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154628; cv=none; b=pPIZRE7+PNmsd2rGpOx/q6yJvKB4rgufdqXQs3FhCTGrG71eXCcCHVmkTmonYundEpeEUfnUV9f3V/a69RK/zOCrD4SeNhtBVHsbJ2ll9y5efxotnGBa3vdS+oqIRcMKoLIOQ1EKFldKIMLJCV0xqM8BEJgSx0cqzr03vcrJakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154628; c=relaxed/simple;
	bh=jc4YbaPRYJlRTbIr8emUt1zth9qkb8yubEiCcaAbw6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mocTsOZSZT6jr5cIIlFPfk8CWNaCXF9epkGlE6kV/FfKIZg3jFfODliPaudWFj2kHpUh5ZE/yllRPKpzy1TW3IWyOPLTZ2yKLgdccTNRy0zLkKLszEld191P09ivp9ccEuXpQbqv553M2QUoGQ1eEvdfnRv8YIkH8d+FDDyM9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p34sWvix; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0e76380433so5556690276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724154625; x=1724759425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCaQiWU5R51EtsPQihcu+5p2olyuei5P9S0S0wyS3fU=;
        b=p34sWvixS3VPAMKJMuwGILNfhseG4bDA/e8rC2LogE6lZXZl4GFjrT1wmLmyR6EYYP
         ZFLgmd0AR6qrrMqcNV+MiF1cgNWeLedRwSt9rOeMtkHvH8FLZO4JxJCCjdxYVoPCV6IL
         SBJAgdBfys6Pzg3P58hpqFov7nUNrY4Y1nyjlZamOHKxMH/XNOGHzni1TuT7zcrAFMYz
         1SxiX7kkXpT+UPj1OEqtluN053vioW4coesu/WeWznuDM/uVcL/81yZZ9qDTPqE8rEuY
         oeDH9iNP7CITUOdh1Y+TLCxaHY9T8i2E+mnTWiVcy47nZ01tr5y21hAvXXfg9ZjeIuPF
         c4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154625; x=1724759425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCaQiWU5R51EtsPQihcu+5p2olyuei5P9S0S0wyS3fU=;
        b=oIRt8BLydP6yXOkevK87crLJ/DgcRYUIzyq/0Z/OkiEdy/aEyWvpewy8nBHkd8SjL8
         JQPCmRzfR2C7HYKxtPkewOXWGpp4IN0zNDAWZG5daEGymIHj+Ev6klXn/xsk3U5PSgym
         ZhToz7/9QWlUVDTArhXeznzTppjEfeWGhxLFkc2vkomG8WzkWhYhf+UrIn/EX4VvbBfv
         RJQkzF6NYXNUxZ9OdCx9U/wJ9H7Q4E7iVvQgAAjnQLha29S4hu65fQsT8TngXyZ9gHnC
         Y8O8WH3Z0sQhAQBDksrFRtZDJ7rpJugHHCZc1GTIrypOUd4LYWklwqH/FX7NYLaU81ZG
         iPtA==
X-Forwarded-Encrypted: i=1; AJvYcCWL34K9pvtIJy3bTFnwUu1QpHi2rNBb22bXrJb0ZjpEooTqVwG/4dHS40dnRQFwxDa8XsXg9j6kIhG6tC7FmiCzpKMpDjBrinybkAMC
X-Gm-Message-State: AOJu0YwPSTAWACL9DQ+uspRPUg1QP81IqAWy79JGhcRAyXRj/+Dj3J3b
	G+eyEitH4seBjmo8NW3qSWDcRE0/X4hQU+267QvzHl/u1nJGKs2k2UKIOEBYLUoi9MSorRgAM/n
	ly1P5KFoDF2gaI2bmFj6B5ODmHRJZmxshB0G3Mw==
X-Google-Smtp-Source: AGHT+IEka4PQNOEQmCKqMTvhJ9/pQoM0AhHYZChG82pN+Q9gnQ5GIfCWaEK++BDwrG/zXoovAAiy4jJe/GkM5ZNmT/E=
X-Received: by 2002:a05:6902:70d:b0:e0b:eb79:d49 with SMTP id
 3f1490d57ef6-e1180edeb7fmr18992461276.18.1724154625483; Tue, 20 Aug 2024
 04:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811212212.123255-1-ben.whitten@gmail.com>
In-Reply-To: <20240811212212.123255-1-ben.whitten@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:49:49 +0200
Message-ID: <CAPDyKFpibjfVuSyuYzkkxxHRoabyZTAbgJJ01TdquC2EeTZ7Kw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: allow biu and ciu clocks to defer
To: Ben Whitten <ben.whitten@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Will Newton <will.newton@imgtec.com>, 
	Thomas Abraham <thomas.abraham@linaro.org>, Abhilash Kesavan <a.kesavan@samsung.com>, 
	Chris Ball <cjb@laptop.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Aug 2024 at 23:23, Ben Whitten <ben.whitten@gmail.com> wrote:
>
> Fix a race condition if the clock provider comes up after mmc is probed,
> this causes mmc to fail without retrying.
> When given the DEFER error from the clk source, pass it on up the chain.
>
> Fixes: f90a0612f0e1 ("mmc: dw_mmc: lookup for optional biu and ciu clocks")
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2333ef4893ee..e9f6e4e62290 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3299,6 +3299,10 @@ int dw_mci_probe(struct dw_mci *host)
>         host->biu_clk = devm_clk_get(host->dev, "biu");
>         if (IS_ERR(host->biu_clk)) {
>                 dev_dbg(host->dev, "biu clock not available\n");
> +               ret = PTR_ERR(host->biu_clk);
> +               if (ret == -EPROBE_DEFER)
> +                       return ret;
> +
>         } else {
>                 ret = clk_prepare_enable(host->biu_clk);
>                 if (ret) {
> @@ -3310,6 +3314,10 @@ int dw_mci_probe(struct dw_mci *host)
>         host->ciu_clk = devm_clk_get(host->dev, "ciu");
>         if (IS_ERR(host->ciu_clk)) {
>                 dev_dbg(host->dev, "ciu clock not available\n");
> +               ret = PTR_ERR(host->ciu_clk);
> +               if (ret == -EPROBE_DEFER)
> +                       goto err_clk_biu;
> +
>                 host->bus_hz = host->pdata->bus_hz;
>         } else {
>                 ret = clk_prepare_enable(host->ciu_clk);
>
> base-commit: 5189dafa4cf950e675f02ee04b577dfbbad0d9b1
> --
> 2.43.0
>

