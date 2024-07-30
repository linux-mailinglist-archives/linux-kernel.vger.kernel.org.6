Return-Path: <linux-kernel+bounces-267477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF91D9411F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E72B1F21A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20A19EEAB;
	Tue, 30 Jul 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hrf6xTK4"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4201990DA;
	Tue, 30 Jul 2024 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342832; cv=none; b=hd9gBN6DlyicSPjasLqPHX6D/Df+u89CyLNGYC/GEg7hCE7dipe1UaGsM4QzCDWpK1Yv6iZqIq4GZAtjxWqXJ+vS9HmC+zdtHmXTwWcxW0Itz92EFawbhwlZkaCOgIuykdc3cgdOA6jt0qH8Mxc4a135hx9AqWvF9Ip2dg7uEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342832; c=relaxed/simple;
	bh=cghdu0WVPnCKLb8b5VkFOXUqNIHtjNV/AagD+WdN8I4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoYwOqzOeelE8l/BR3qvQHee2O3QuOwcibK4Q7/B5k2nyFPgirio1OCojZjsH/d2KCWVe1CiwwiV5wus2rzdhSZH3Xu0WdG2jtJlLzA3YT0kow3LMsO2wEBaeNerhrnvFCd4qHOH2wwbUk1CU6TB9A66COJjMprwzhIit01l2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hrf6xTK4; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UCXiqX072577;
	Tue, 30 Jul 2024 07:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722342824;
	bh=dluvDJb8e/OiW6IPhliSRXmc/hbTMkMHQ/+KEIQ0eXI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hrf6xTK4JT87isfGr9o3JSztEEOKJ+WNEicoqHbd7hK0EbsVXLPnPHL/MitDIEhnp
	 eRaU7oWgsVjQ0ttmJzMOhC0c8TJT6ukRJEf4X/M7AahXD7JWCJqnRxbaarXjl82xsy
	 Xge+6G9zANXEqtGGVRvDsrtBL3B4ELvKSMO3kXkw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UCXijS018090
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 07:33:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 07:33:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 07:33:44 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UCXhsQ118404;
	Tue, 30 Jul 2024 07:33:43 -0500
Date: Tue, 30 Jul 2024 07:33:43 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: Introduce J742S2 SoC family
Message-ID: <20240730123343.mqafgpj4zcnd5vs4@plaything>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:43-20240730, Manorit Chawdhry wrote:
> This device is a subset of J784S4 and shares the same memory map and
> thus the nodes are being reused from J784S4 to avoid duplication.
> 
> Here are some of the salient features of the J742S2 automotive grade
> application processor:
> 
> The J742S2 SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration in automotive, ADAS and industrial
> applications requiring AI at the network edge. This SoC extends the K3
> Jacinto 7 family of SoCs with focus on raising performance and
> integration while providing interfaces, memory architecture and compute
> performance for multi-sensor, high concurrency applications.
> 
> Some changes that this devices has from J784S4 are:
> * 4x Cortex-A72 vs 8x Cortex-A72
> * 3x C7x DSP vs 4x C7x DSP
> * 4 port ethernet switch vs 8 port ethernet switch
> 
> ( Refer Table 2-1 for Device comparison with J7AHP )
> Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi | 44 ++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j742s2.dtsi      | 26 ++++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
> new file mode 100644
> index 000000000000..13b83560d5a2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0

and MIT please.

> +/*
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001

Point to SoC trm here.


> + */
> +
> +/delete-node/ &c71_3;

here and below:

> +
> +&c71_0 {
> +	firmware-name = "j742s2-c71_0-fw";
> +};
> +
> +&c71_1 {
> +	firmware-name = "j742s2-c71_1-fw";
> +};
> +
> +&c71_2 {
> +	firmware-name = "j742s2-c71_2-fw";
> +};
> +
> +&main_r5fss0_core0 {
> +	firmware-name = "j742s2-main-r5f0_0-fw";
> +};
> +
> +&main_r5fss0_core1 {
> +	firmware-name = "j742s2-main-r5f0_1-fw";
> +};
> +
> +&main_r5fss1_core0 {
> +	firmware-name = "j742s2-main-r5f1_0-fw";
> +};
> +
> +&main_r5fss1_core1 {
> +	firmware-name = "j742s2-main-r5f1_1-fw";
> +};
> +
> +&main_r5fss2_core0 {
> +	firmware-name = "j742s2-main-r5f2_0-fw";
> +};
> +
> +&main_r5fss2_core1 {
> +	firmware-name = "j742s2-main-r5f2_1-fw";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
> new file mode 100644
> index 000000000000..0b20c992d664
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0

Same - and fix anywhere else as required.

> +/*
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001

Same

> + */
> +
> +#include "k3-j784s4.dtsi"
> +
> +/ {
> +	model = "Texas Instruments K3 J742S2 SoC";
> +	compatible = "ti,j742s2";
> +
> +	cpus {
> +		cpu-map {
> +			/delete-node/ cluster1;
> +		};
> +	};
> +
> +	/delete-node/ cpu4;
> +	/delete-node/ cpu5;
> +	/delete-node/ cpu6;
> +	/delete-node/ cpu7;

I suggest refactoring by renaming the dtsi files as common and split out
j784s4 similar to j722s/am62p rather than using /delete-node/


> +};
> +
> +#include "k3-j742s2-main.dtsi"
> 
> -- 
> 2.45.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

