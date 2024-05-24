Return-Path: <linux-kernel+bounces-188344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A798CE0CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D740D282D89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D3D127E1C;
	Fri, 24 May 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KGp8tiQF"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5A79C2;
	Fri, 24 May 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530293; cv=none; b=uZn8jpT8vX6w7bA6GlkMyHFjT1Kw3JctX74REnKbuF9IXxuqYrMZuGkJ562YZOvMU9csMiuiFt+PSk37Nfn4YrwWdeuylxBNHckVx+K6uiJCHjdU7KrTJFNAPPBZRE3veCObMFZ0MqzYs6Q3Tel6k6GRirMx1mc05Cty4L3nuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530293; c=relaxed/simple;
	bh=zqmWyT5XwAhbtRngwyPiBMOXtotvPkloxXBZNoKMW+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko39eO1M1lkT3vWZZmpl0nrumlGxGSQ6ZA0beb5k5wn4mLSu73EelBcgxiWLTlNQRGmGHfgvrPxCn+6iVh56RKsdJfhhhuknwI56MKLlXpYNcTh1i+6Vz3pJ3KgK2y4999qyWHua1dsVNcU2zeE2t34CZGa7LTEcJGyTCmsYixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KGp8tiQF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O5w4FF125439;
	Fri, 24 May 2024 00:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716530284;
	bh=SkPy4urpmv3fU5kSZvDPITCR09Jyyd6rQyRybc5i+nA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KGp8tiQFmR6UjMXUIyc6QUAQKiBUsvAXusRcDgwAlMld0uNpxiPf+xINmfgWUGzFU
	 qE3Z/DDOYft8Zf9S3iu57Xj7UaVIjZmSPGY2vG9n+3JVJdvTLZZeujDmcIS9EmjQcT
	 eD4Fxts2D2L5UKt2FySzXqriGAQ8FHGrNFTOee+0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O5w40P109055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 00:58:04 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 00:58:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 00:58:03 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O5w3wB105880;
	Fri, 24 May 2024 00:58:03 -0500
Date: Fri, 24 May 2024 00:58:03 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
Message-ID: <20240524055803.dce33y47qzryveh4@napkin>
References: <20240523080225.1288617-1-msp@baylibre.com>
 <20240523080225.1288617-4-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523080225.1288617-4-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:02-20240523, Markus Schneider-Pargmann wrote:
> WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
> in that case.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 4cd2df467d0b..e36bce881f44 100644
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
>  #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))

Could we do the due diligence in ensuring that there are no SoCs (like
tda devices) that may vary from the above definition? Please provide
that information in commit message.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

