Return-Path: <linux-kernel+bounces-360088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D931399944D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4527028477A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470091E1027;
	Thu, 10 Oct 2024 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FJTmMfbv"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B240C03
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595101; cv=none; b=iwomKFRxxsfJd5HrBqw49yUDouvQ+L+0aFGj0YjkTJDG14i/9rQgw16aPUfvfkDGBSdE4IHB4QpLNaro084C6W+U/jnpxDAXlNBms505qALuGAl4MpFWNutlTAcxETRzggCy/qnS2s/EzWiYn1MBl0aKlDPVb23rpt0r/h/jb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595101; c=relaxed/simple;
	bh=66X7MJvhjwaIv9v0E9icVdF/S0iijJDVhOZL5QIOXXk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvBaGWqHakT+b4uFeLePuxPu980KSGfIyzVd0K2IvLkHCCsHtG8sGenH1gnIcKPMmMD317O5lkcJIdcxqtGUXFiEOkUWbsQXNUWvVNvfbOnSa+lAJDeMM6zp+DuMBUzAnJ95kOhs70BodOct9uONQmhyGuC8gLLqbI2r13bjrx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FJTmMfbv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49ALI7c7112136;
	Thu, 10 Oct 2024 16:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728595087;
	bh=hPunnxnKCLa8EHZzqLSh89WeqAPCnHq4nbcLWVjyu5E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FJTmMfbvbnrdG29lDzOIQZfkRLUMPhteP+m6UQWPndOqdumTfYhpn2xIO6tPzzRo0
	 F545yCRaye0ENBVnfzFb/M2epBwlcuFOTk66YdgHL4mJR1M+0z3koEkR/Zooh9ChIc
	 Zygr6N+lRmRsZFGkigJrIaCfIn86YqavHVvn3xn0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49ALI7V7017044
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Oct 2024 16:18:07 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 16:18:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Oct 2024 16:18:07 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ALI7Ls040027;
	Thu, 10 Oct 2024 16:18:07 -0500
Date: Thu, 10 Oct 2024 16:18:07 -0500
From: Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: Re: [PATCH RESEND] clocksource/drivers/timer-ti-dm: Don't fail probe
 if int not found
Message-ID: <20241010211807.ibxatajiwyqchid4@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241010144440.24654-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241010144440.24654-1-jm@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On October 10, 2024 thus sayeth Judith Mendez:
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
> +			dev_err(dev, "Did not find timer interrupt, timer usable in PWM mode only\n");

Is this really an error? or more of a dev_info() type problem. It looks
like we changed how we integrated the timer in K3 chips that broke some 
assumptions made in OMAP.

~Bryan

