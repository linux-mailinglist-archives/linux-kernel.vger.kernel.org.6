Return-Path: <linux-kernel+bounces-514435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F902A356FD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3255316E31A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBBA1FFC5D;
	Fri, 14 Feb 2025 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CQNrKKdK"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5B19007F;
	Fri, 14 Feb 2025 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514126; cv=none; b=XSb+J/AMYe3g84O4XiUAQ560iVHVBAwzFXJnR4Cu8G1su6emryQDlOl3KOsfR7D8U0YTLEdP15zIa/9uHVHldG/V0yw64NOD/n6tXTCoox6v9wcC0DTpSkEqdcdSISH73+ju4vkPzu6ouQ2BixeIQFrVFJWEQDhoppyazmCr+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514126; c=relaxed/simple;
	bh=qLpItKHu9j50rCm1popfAhEiMrTrcNNa2zmH5UiH/es=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF3CxjMh9imF88IOoT8JXfynzCJkZxsfS8Y31matcfgvyKn9dJeqx4PTB6nOmL/MQpVB2erb35Gr+ZPMqp3XZCk8J8nZHI+zS0Fyl+Ims6wTedeDZmjfw1ag4x6YJ05jelWvD/jj0WhmrhdNtR1HC/vI+FMdkVZX1BsFb3uSiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CQNrKKdK; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51E6LgKK795495
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 00:21:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739514102;
	bh=8ohhDmYgT4iRXwmxU5hvtsiljsDCgkDmDEH4pQmV+YA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CQNrKKdK0J55rF7Yz/91T70Rsnl1AHvipTeT3OaZ4GThpta5XOaGRTP2LFP5KPqHF
	 /78No/Q1Q3KBj3qcKD7w/5h6c5PPCvJr8gKpKK/dsSCti1kuQsl2MlT+ziT1nxji3X
	 1wvJMEAIvRhGfrI78g1RS2MGHFRMLlmrM+IUoyOk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51E6Lg99012724
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 00:21:42 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Feb 2025 00:21:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Feb 2025 00:21:42 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51E6Lf8n123354;
	Fri, 14 Feb 2025 00:21:42 -0600
Date: Fri, 14 Feb 2025 11:51:41 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kendall Willis <k-willis@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <msp@baylibre.com>,
        <khilman@baylibre.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Add alias for RTC
Message-ID: <20250214062141.gdmkepuuyqb22xuh@lcpd911>
References: <20250212210604.745175-1-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250212210604.745175-1-k-willis@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Feb 12, 2025 at 15:06:04 -0600, Kendall Willis wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
> Adds alias for SoC RTC so that it gets assigned rtc0. PMIC node is
> assisgned rtc1 so that PMIC RTC gets probed as rtc1. This makes it

Nit: Fix the spelling of assigned please.

> consistent for testing rtcwake with other AM62 devices where rtc0
> is SoC RTC.
> 
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> [k-willis@ti.com: Reworded commit message]
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
> Tested with rtcwake on AM62A.

Any test logs you can provide would be great!

> 
> Original patch for AM62A existed in the TI Vendor tree with Vibhore's
> authorship:
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.6.y&id=f745d9063212d1088dcfb068ecb4b16648b96487
> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index a6f0d87a50d8..51ea961f166e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -22,6 +22,8 @@ aliases {
>  		serial3 = &main_uart1;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
> +		rtc0 = &wkup_rtc0;
> +		rtc1 = &tps659312;
>  	};
>  
>  	chosen {
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b

It's nice that you've mentioned this, but it seems to be from Feb2.
Can you please base it on latest linux-next when you send in future?
This will avoid any merge conflicts in advance.

For this though, you may get away with it because nobody else may have
touched this file so far...

If you do send a v2, feel free to pick:
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

