Return-Path: <linux-kernel+bounces-328050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD00E977E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770B21F2784E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147E61D86E0;
	Fri, 13 Sep 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bqw1FcDb"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396E1C175F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226187; cv=none; b=tcZgxUfjA5ej+D2Rn6pv2Yd4i7OLY26fjc1l4dQMmv7P4x0N/8d/cRmo+xDF4UdmooHy1SUY4UI1gUL25+71BEFivVgeMX7KgKd/1vUl9Z0bDfIYMC4ZWwOOZTGIwWpBEi/ws94Tk8yO5vsGEed3HlNZEYN3h1t56IWvhSwyeks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226187; c=relaxed/simple;
	bh=no8cMr3ePk9LJ/3lkIpxYb7h0R6BUgzEu83uCJjOdiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcF0yMUoYaxZVQZCMTIqV+h4OGx1S/vGulsj76/pk7d5FYXAV42pUtbSsWsRa1XON2D/LPRBZSOaEIXyiI1SkQlMHkprBxDCLClJ08zN/m/0Gfp7/ZgYkFiQ6iVBtL/7uLCCzRSHVpbPxtfaOBPN4c0RVKcb9AiviDwQRGPN2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bqw1FcDb; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1d0e74f484so1824234276.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726226185; x=1726830985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kfj0B1rEvFEwykb18qvJWsW+ZHNQdJ8Sji9YjsbtgGo=;
        b=Bqw1FcDbyJMUY6XV4KTQdiolgtX1qCV0uSj3vpEE12DnFhMvNi2ZMJeQxtdfpPgrcq
         LKTfsWTawP6yUgeoCZZIZyRoH4S2EYtqCxNYI1+zPFjx2sbVt3IFtUL/wASkQVz/kY0k
         1YHx2WJArJlbDc/u+/w5CXG8SuiQPpIMvIx8IQ3PKi4DYB+4ABCDDz21PDrcrPD8q63L
         0Jtwcf0lD6si8TADhwkxmrrrlfsJrQUUQim7O79xfQP2VMOmRp3EDTM8HAZpMY0D1FK3
         ElPKpHXkYLOh1KgdSdxKI7hksETn4m7QjwUgOGOmJx3LY+A3OsendXsJxfHQtPJS8zI1
         NqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726226185; x=1726830985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfj0B1rEvFEwykb18qvJWsW+ZHNQdJ8Sji9YjsbtgGo=;
        b=s7qpkd4DpQL0FTykvzNlDJq/v6CDtS3bOhQ94jeG49jyfo6PkjkGTzKk/gP3T4OV1K
         zrmKEhrdTpeB0xVmImXw58M0yAnw0g7DcFQg3wlY+2aftRqd/MUNlPppRuMnvrjjBRIf
         Lde2utQFqA9sLOPN7NoiWYsjYzkCeU/jpo4s8q3lLISUhp0muLVoUwJHmQDiwC3Xay48
         UI79he8ouMDNy70ypatWeMhf/gMmYS2BHgOHmhikABCIdjmzUrsy3W3GRXPwgVPzFe2q
         54BcdD613TRbuABLIk3DTYpjkKCwuY47nRVV4heFW+d1Kf/x9tf5aTTu/psL0RCT9k+h
         2e/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvaBfMwi57a7kd9IjPKYkIb1Ezd2o/zoGQe0WM9otIh6q7FsXaJnUGe93yf/sM0zO9+wPgWAy6aefdA9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPmtQ/ahUuocN7K75z+yqsUlRsrCacEvLYQoFhh20TeDNVWma
	NnkTa4jGi92PofVrsn0kpRw4ogSPSoBBEHLDi27p0VzwNatKIeX5J8gUNp27o00XDhTn2Y1P5wA
	3RHBaC2Nrqg/4P+XvjeQMwd7m/QR82iStE+eoUQ==
X-Google-Smtp-Source: AGHT+IEYCGHUiSriLP+TxUHCpZ6MkIpDjCEtPjY2L8ZF6q3B+z2xf1TWd3AH3+cPAuEhbWh/ZgQq5TV5kANKgnjIDso=
X-Received: by 2002:a05:6902:2783:b0:e1d:1434:98a4 with SMTP id
 3f1490d57ef6-e1d9db98a6fmr5058804276.9.1726226184945; Fri, 13 Sep 2024
 04:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830110421.62980-1-shenlichuan@vivo.com>
In-Reply-To: <20240830110421.62980-1-shenlichuan@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 13:15:48 +0200
Message-ID: <CAPDyKFrGxH_q1V5=oqfcK84xCcXzWQ-v_XcfZPPj+i048Tv=bQ@mail.gmail.com>
Subject: Re: [PATCH v1] pmdomain: bcm: Simplify with dev_err_probe()
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: florian.fainelli@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 13:04, Shen Lichuan <shenlichuan@vivo.com> wrote:
>
> Use dev_err_probe() to simplify the error path and unify a message
> template.

In this case the simplification is questionable, I think.

>
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
>
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.

Right, which I guess boils down to what people preferes.

That said, my take on this is that we should move from dev_err() to
dev_err_probe(), at least there needs to be some simplification
involved too.

Kind regards
Uffe

>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
> index d2f0233cb620..be07ab8a663c 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -643,18 +643,16 @@ static int bcm2835_power_probe(struct platform_device *pdev)
>         power->rpivid_asb = pm->rpivid_asb;
>
>         id = readl(power->asb + ASB_AXI_BRDG_ID);
> -       if (id != BCM2835_BRDG_ID /* "BRDG" */) {
> -               dev_err(dev, "ASB register ID returned 0x%08x\n", id);
> -               return -ENODEV;
> -       }
> +       if (id != BCM2835_BRDG_ID /* "BRDG" */)
> +               return dev_err_probe(dev, -ENODEV,
> +                                    "ASB register ID returned 0x%08x\n", id);
>
>         if (power->rpivid_asb) {
>                 id = readl(power->rpivid_asb + ASB_AXI_BRDG_ID);
> -               if (id != BCM2835_BRDG_ID /* "BRDG" */) {
> -                       dev_err(dev, "RPiVid ASB register ID returned 0x%08x\n",
> -                                    id);
> -                       return -ENODEV;
> -               }
> +               if (id != BCM2835_BRDG_ID /* "BRDG" */)
> +                       return dev_err_probe(dev, -ENODEV,
> +                                            "RPiVid ASB register ID returned 0x%08x\n",
> +                                            id);
>         }
>
>         power->pd_xlate.domains = devm_kcalloc(dev,
> --
> 2.17.1
>

