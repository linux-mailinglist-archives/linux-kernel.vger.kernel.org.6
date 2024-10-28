Return-Path: <linux-kernel+bounces-385049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092EF9B31C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDBB1F21CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0202AE8C;
	Mon, 28 Oct 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyTVySn/"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4638DC0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122444; cv=none; b=rGg4q6TL17AMmqW9mWCxbTOqHT7l2veAlICmAB+Q3YCFViSutd84nvz5I5UO0lTT141LM78B11pXoGnwkYeYjnorlQcMKCxshHWKk1R7Ldlc/ObCGEcueFz2WQP6OV1YL3HhpCLrAT5GcJ/I6hE9dSTnugMQtMFQkW/HWOEsEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122444; c=relaxed/simple;
	bh=Hkuw0HsMZTAZzklGG+SikM47Il8Z/dFPLYepO7YC7uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaKWuRRePZ2Pr+v710PlNeuxIIRLzKvKxekApxSLTGn0Llm8l4/TpiGXGrqcI52DRrj793pV5DrGIhlgPRedqk1jvQmIiGkPwWrtUlJh3tETr+xBHg4OY0hCf7SGkz2ppbjgm9iCs5brJr5YE9iJpX9Obt2zAhuS4an+xn1dldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NyTVySn/; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2e444e355fso3885085276.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730122441; x=1730727241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SYzKzo66BsIMu267mtmk0h5Sc03Gos4rGGJcCGOcJ3w=;
        b=NyTVySn/a4X4rsWFgjV2jYHKDYMFaTtHiA2YY61hovGuftbkuMZAxxGxOAn/Z3QkaV
         JH3ntNhALj/ar5LjiI6CTIFYaryWrVqr0JuY7MXvsJGveFL46Q/nvvQRnNemEWYoZv2a
         cPAdXMJWm11xLbqYHuwoSE7OWSo4wzkf+s4K+9CSn1LOVnNYhkRf/kin92AS80vLrZUB
         v+ZHHruxJwuttKJ4VK7inU/wGfsjqZ7soP/FTbTYHSk9Lw/Tm8HwQohI4OZzYhr+rS9+
         wodSnDRgqjIx+KfQk8fQA4W2rbPTwClj8h6asw90PldjaXxXmhfTORAESQuU8HIEAotx
         xXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730122441; x=1730727241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYzKzo66BsIMu267mtmk0h5Sc03Gos4rGGJcCGOcJ3w=;
        b=OG5fOOKaRoXXqPAhXj9hJLLLhxKfidUpyY1gdVRh8jEPhyG7z+VquxF6/wVkmpC9W3
         wjJ9DTxhuBI4qpD7MnrsvDQiiJq16G2mNeSfj3t1D6nCj64p1wto6a9xwJG1WnZWSX55
         9h3oku7zRKnt4dZE6/Us04oezI/PvBuSv/aS7wRbovuZPsJeW4k5odZsnuoyZj60mWHP
         ngl/Ixip7zP6bfRjKhTJD514rWAuOSbPK5nHAeYEj28I4GGX1cP03Hy8m1Q13DmAoFoC
         LEM1piVKsNRQtWnaOFMcz8Ps2CtcEA58b7So+w7qTH4zgEFHOFb3HBpPyDaFHSUJUIPI
         X9Qg==
X-Gm-Message-State: AOJu0YzZA6RHFpeyWFALMZf0WSDgoVFoEZ8BgAOmrxKRq+30XQrPU81L
	7WXYRK572a7W+IugepgEfrgt2OebLUBl6/YpDd1/n0TpGOirsSEBe7cVhI2LLav8KjSyBZVq+Gt
	bfgPW57mMYcdxXqGYkxsXlFdYC54BdxR9Lci5sQ==
X-Google-Smtp-Source: AGHT+IGGrnEkq2Csv9Fhr7cK77KAAx+dwPKc2XqpKhV7C1rM6wW93+Gue8eEnm4PDIutRTr2OvSsfClmR3e9JZ5bqVs=
X-Received: by 2002:a05:690c:6b0a:b0:6e2:451c:df02 with SMTP id
 00721157ae682-6e9d8aa1064mr68679197b3.16.1730122441097; Mon, 28 Oct 2024
 06:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 14:33:25 +0100
Message-ID: <CAPDyKFqqCWt5oCj6qBuP_oZ=O1kmkfMirYETPXEeW-AmiA9P+g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: fix "sd_count" field setting
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Michael Trimarchi <michael@amarulasolutions.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 11:49, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The "sd_count" field keeps track of the number of subdomains with power
> "on," so if pm_genpd_init() is called with the "is_off" parameter set to
> false, it means that the power domain is already on, and therefore its
> "sd_count" must be 1.

genpd_sd_counter_inc() is being called when adding subdomains. Doesn't
that work correctly for you?

>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>

Kind regards
Uffe

> ---
>
>  drivers/pmdomain/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 5ede0f7eda09..2df6dda98021 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2221,7 +2221,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd_lock_init(genpd);
>         genpd->gov = gov;
>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
> -       atomic_set(&genpd->sd_count, 0);
> +       atomic_set(&genpd->sd_count, is_off ? 0 : 1);
>         genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
>         genpd->device_count = 0;
>         genpd->provider = NULL;
> --
> 2.43.0
>

