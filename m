Return-Path: <linux-kernel+bounces-267446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2809F941193
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590BC1C22DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3619E7CF;
	Tue, 30 Jul 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BKg4QjDR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0F86AEE;
	Tue, 30 Jul 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341414; cv=none; b=Lcc7sfJF+hQJqs1Hln5ytLNi0r70j8mCNF6WNVAQJ17Yvu6lXuv6dk3qIb+mHFYylBIVONCwMzJ9CvFAPYxP/zLBRufuhtZGl/kZCnamGDF5eXuTRd4clnm8ew+zaEo1wUyIZbquUNwZSt2ib9xdw0dO6FHTmib6I1862RCD3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341414; c=relaxed/simple;
	bh=XpuiQDPO6zhZXLDLx7KGADddv6C7QoWX5co9A65kSM8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgbxqkSa3/R+rHNyqQk1xr4SWIJZnUvYFEjjnV3qapQKGCV/scPgedCuslpY5DqDwvCEZvJUdcPrTaE7c2G196gDvz31A+iI0NT0TpxLs+qN/e7Esz/n+jEEDQMR6SZY0WqzLeQGIaect3UtSA5CWWUiioJHRJW5bCNAlPi4tN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BKg4QjDR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UC9w9m041594;
	Tue, 30 Jul 2024 07:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722341398;
	bh=NKaijFX/skcZj5R+wBZvbPlLYC9R2fvY17JaQt5pux4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BKg4QjDRZ0KZNbKx2fFO4s+nzd/0qlZ6JtUxu9DJVcQCTXR40o8lOMREsMA7NYQgF
	 zdfC/VZfr2BJHyDD4CWJgVyfKnt61Wua+BCUhfGJyVgtYzf9BsCigFd4URyjkiSzQZ
	 wP/ElzN2/q1A4bXSh/Z2IomTemOIsaFbFka2+oOM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UC9wv2004650
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 07:09:58 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 07:09:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 07:09:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UC9wvK079871;
	Tue, 30 Jul 2024 07:09:58 -0500
Date: Tue, 30 Jul 2024 07:09:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
Message-ID: <20240730120958.inq73rx6dfmwh6vz@hemstitch>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-4-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240729080101.3859701-4-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:00-20240729, Markus Schneider-Pargmann wrote:
> WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
> in that case.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 22b8d73cfd32..dd4d53e8420a 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -12,6 +12,7 @@
>  #define PULLTYPESEL_SHIFT	(17)
>  #define RXACTIVE_SHIFT		(18)
>  #define DEBOUNCE_SHIFT		(11)
> +#define WKUP_EN_SHIFT		(29)
>  
>  #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
>  #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> @@ -38,6 +39,8 @@
>  #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
>  #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
>  
> +#define WKUP_EN			(1 << WKUP_EN_SHIFT)
> +

Are we using this?

>  /* Default mux configuration for gpio-ranges to use with pinctrl */
>  #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
>  
> -- 
> 2.45.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

