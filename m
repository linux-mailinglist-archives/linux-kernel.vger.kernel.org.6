Return-Path: <linux-kernel+bounces-283015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3594EBF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D651C21529
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94E176FB8;
	Mon, 12 Aug 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tb5uOir4"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30416A948;
	Mon, 12 Aug 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462880; cv=none; b=S3z5jPK2ZXlLFIZrLsS3nJQKBj9M7q7ez7iP4FSoiFOtmC7XFkhmCqXgn1ZO7PbO02kZuvBpHR2k231djKEOhK59tix44R07F5+10aeU19qjw0YBcFF3cNhw5dpdO5yDFku8T5fGPjHE3fnaQsz4gT0xml8tBvQuFQegBDgmoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462880; c=relaxed/simple;
	bh=Yw+G4Sje4M/5GQQnrrvFiYUSOVuKgDQLf6KpU1ejAqA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCYIHtFXRie+NupDNzPapLnYcoN5bxhXDDIWWSyU/erm6OTAB9A1vky7IlhZcAl22NfmQs/ctV+gwdvYKHqHsQwogb7cDGnl+piVMxTbk6lu4u0rFqqbBSlJArWJuv+mAwlmLw66NTAEnbApFL9x6vvODic/ALOVuFSH3amXfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tb5uOir4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47CBf9WH039900;
	Mon, 12 Aug 2024 06:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723462869;
	bh=4BVWuyzVLFipf+XPVpqPQNlSSwh4z2z4zvmeAgd320c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tb5uOir4ZZVS6QAbOhjHdOVS6/ckMg2uJNPTQpfytMYhxx8LkoKW8+eO1Yg3xiCT5
	 IExsSGc+dNoq/P5U/YDOl7JvGp/t8cDxvRbB/zF3VTXEQQme+tGZkNc1djjpUYZmKu
	 nNp/IWgdVJmn/s/VsgBjcxo9h1bVlQUmg+Cf01aA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47CBf9Se004385
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 06:41:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 06:41:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 06:41:09 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47CBf9WW120381;
	Mon, 12 Aug 2024 06:41:09 -0500
Date: Mon, 12 Aug 2024 06:41:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62p: add opp frequencies
Message-ID: <20240812114109.woyowj5en2ombx7h@deafening>
References: <20240809-opp-v1-0-fea8efeaf963@ti.com>
 <20240809-opp-v1-2-fea8efeaf963@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809-opp-v1-2-fea8efeaf963@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 17:01-20240809, Bryan Brattlof wrote:
> Add OPP table for the am62px-sk allowing us to slow down CPUs when idle

Please fix the commit message. This is a device tree hardware
description. what the OS does with the frequencies is upto the OS.
Please also add documentation that provides the following information.

> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |  9 +++++
>  arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> index 315d0092e7366..6f32135f00a55 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> @@ -20,6 +20,11 @@ chipid: chipid@14 {
>  			bootph-all;
>  		};
>  
> +		opp_efuse_table: syscon@18 {
> +			compatible = "ti,am62-opp-efuse-table", "syscon";
> +			reg = <0x18 0x4>;
> +		};
> +
>  		cpsw_mac_syscon: ethernet-mac-syscon@200 {
>  			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>  			reg = <0x200 0x8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index ff65955551a32..ab5d7a5fc6118 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -128,6 +128,15 @@ led-0 {
>  		};
>  	};
>  
> +	opp-table {
> +		/* Requires VDD_CORE at 0v85 */
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			opp-supported-hw = <0x01 0x0004>;
> +			clock-latency-ns = <6000000>;
> +		};
> +	};
> +
>  	tlv320_mclk: clk-0 {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";

Please keep the board dts changes separate.

> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> index 41f479dca4555..140587d02e88e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> @@ -47,6 +47,7 @@ cpu0: cpu@0 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
>  			clocks = <&k3_clks 135 0>;
>  		};
>  
> @@ -62,6 +63,7 @@ cpu1: cpu@1 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
>  			clocks = <&k3_clks 136 0>;
>  		};
>  
> @@ -77,6 +79,7 @@ cpu2: cpu@2 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
>  			clocks = <&k3_clks 137 0>;
>  		};
>  
> @@ -92,10 +95,54 @@ cpu3: cpu@3 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <128>;
>  			next-level-cache = <&l2_0>;
> +			operating-points-v2 = <&a53_opp_table>;
>  			clocks = <&k3_clks 138 0>;
>  		};
>  	};
>  
> +	a53_opp_table: opp-table {
> +		compatible = "operating-points-v2-ti-cpu";
> +		opp-shared;
> +		syscon = <&opp_efuse_table>;
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-supported-hw = <0x01 0x0007>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-supported-hw = <0x01 0x0006>;
> +			clock-latency-ns = <6000000>;
> +		};
> +
> +		opp-1250000000 {
> +			opp-hz = /bits/ 64 <1250000000>;
> +			opp-supported-hw = <0x01 0x0004>;
> +			clock-latency-ns = <6000000>;
> +			opp-suspend;
> +		};
> +	};
> +
>  	l2_0: l2-cache0 {
>  		compatible = "cache";
>  		cache-unified;
> 
> -- 
> 2.45.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

