Return-Path: <linux-kernel+bounces-361986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6460399AFAC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F6D1F23A35
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2163C881E;
	Sat, 12 Oct 2024 00:24:50 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3814C80
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728692689; cv=none; b=EfW5BnwZY/ffjvrvyM5rVzz86XU2GblvgAloHKy3vOb7POfOpwW4qyAhHWqTzRi3gB6ZEU4EQ8cUk2ptQ0BAWac0mIK/6yWPHbXLEDpOlqLG8w3QvdLlfpXin44oh77y96aRY0Wm4qqgokpjksTgd4foqwgBvh+rXe7R8GnCams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728692689; c=relaxed/simple;
	bh=w5m7xIpPq9n27pVrnZvHMSmCl7Lq8BfqSCsS2lt/j80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KhL8vfC1vRBifLiKr3p3Fbkh5Y/8LDYXV5yMNPdgYix0TuZ9yHUUjqn+xemD9R/WZogUS4H/MaDCh42SkMGqTWoXBbSnH6AQd3Ou999SfdWzEsyGrTIqjH9FnfQa+CiKL3bePkhY7i2mZxhkpBLmIJEE/lcnUFwM3muE/+sOskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e483c83dbso744357b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728692688; x=1729297488;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/cmzVR/UUriGAzriXH7elMbvGVPWogWGsRm5/0gBdI=;
        b=puF/2xTuNfsbk9dSPJDeJGdXhjp+hBQiD3q1G9i9wIozVtpBARcnW9wraTCcfSJxkS
         k68oo8Zy/JjVCfrwDIhdheIKNHNQmAvubF+m7U34l7XQZ3jEuDxzD5kyQCPIfAO4ktAZ
         OxfPE9V9oyhBlmT/n5nCflUDitcNGUyUluG0s0TW/VUJFeqMn21KIdDSBrLJ1s1F+kUr
         brbc0Rr6Vy0683i1+eZ2kUec2Eo7O6hesxGCDngYWw0oYoSSQ/NJPDAfuQ0LGViZIB6M
         WSq6bTNBpNgBOCIhY93IcjqLvqCkzvsMdiS6rcLf30dJevpJp1+ottyz751dopeg48Rp
         SFgw==
X-Gm-Message-State: AOJu0YySrcsQPOk/VBhuwH4Z0nCBN7D5D/fDRzOlEn6v7nqdUdFjYWSm
	yO1UXa8aWXmOlBVTa7jTI9pf0flJKELrLD1g1I99APZQ6XRPxiOvJ/cUGNh5KrBm7PjbrGJ1ui2
	9
X-Google-Smtp-Source: AGHT+IEvezfzp5ckTvxnwbrXmllR4+1t1FwkAbPk1Hjsjpf8QIUzoh8As5OAJH7JCC/a2zATQte0ig==
X-Received: by 2002:a05:6a00:2396:b0:71e:4df3:b1d3 with SMTP id d2e1a72fcca58-71e4df3ba4amr1123208b3a.4.1728692687723;
        Fri, 11 Oct 2024 17:24:47 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa9390dsm3210227b3a.129.2024.10.11.17.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 17:24:47 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Judith Mendez <jm@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH RESEND] clocksource/drivers/timer-ti-dm: Don't fail
 probe if int not found
In-Reply-To: <20241010144440.24654-1-jm@ti.com>
References: <20241010144440.24654-1-jm@ti.com>
Date: Fri, 11 Oct 2024 17:24:47 -0700
Message-ID: <7hwmieuq0g.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Judith Mendez <jm@ti.com> writes:

> Some timers may not have an interrupt routed to
> the A53 GIC, but the timer PWM functionality can still
> be used by Linux Kernel. Therefore, do not fail probe
> if interrupt is not found and ti,timer-pwm exists.
>
> Fixes: df28472a1b28 ("ARM: OMAP: dmtimer: platform driver")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v1:
> - Rebased, add to CC list, add fixes tag
> ---
>  drivers/clocksource/timer-ti-dm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> index b7a34b1a975e..1b61fefed213 100644
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -1104,8 +1104,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  		return  -ENOMEM;
>  
>  	timer->irq = platform_get_irq(pdev, 0);
> -	if (timer->irq < 0)
> -		return timer->irq;
> +	if (timer->irq < 0) {
> +		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))

nit: this propoery is read from the DT again just a bit lower.  Rather
than parse the DT for this property twice, can you move this after the
DT properties are already parsed, and then just check for
(timer->capability & OMAP_TIMER_HAS_PWM) ?

Kevin

