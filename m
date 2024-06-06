Return-Path: <linux-kernel+bounces-203601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49C8FDDB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BB61C238C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41FE208B6;
	Thu,  6 Jun 2024 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SepihYV8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ADB2114;
	Thu,  6 Jun 2024 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717646744; cv=none; b=hIuQHlXZ5j0VTNINbC5K/vQzPJVw+GADKePlPWtSyCGwN1thWp1IxrdZLkjixa/1HXBIA+3Wpe2G5al2879y8cjBHaXpbBhgFeR89D92lDsL1z7VNmm5X/o/UELR9IdBlrO30YT6YFr7aBsza8BZzuABbTZUBWj3dShdeBRCX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717646744; c=relaxed/simple;
	bh=p6a5pdP9a15oGecBROZueV3dKmS8yv8D3takQtLrHnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B6ZldnPaMG4yt/jTUUhwOKKZpcce0nVb09ysgETg+n5t3aAF0MSCz6yPdI2EFs6mlBqgldTaiXaDxFW1vg+B/nThqDEak91O74pyY5MH1JRDzGaknT8obX4tIQ7/FtXvXDGN+rmtQ7OU1Yk5+EQiC+MmWbdYPKNyqpliBzd8Nac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SepihYV8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45645VF7105201;
	Wed, 5 Jun 2024 23:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717646731;
	bh=mdvTzOkLikM46VzU6/78jqQPkp9ny5FpHczJhZOmO88=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SepihYV8gXDemmp40p69RPrQxdvGztmfZYX5aXwW7xPjfaQG+fM4bYbdODfAKJavH
	 wvmoyMJdGYYDo0glj1fz+FTSrVzGR/mHuUKNOd68AlpnSpILmJFlFKo1IZt6nzvWdP
	 BxOWW5nwkDTdVXEseldeiJXTZtCvHus8sXb+7DJw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45645Vs8044068
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 23:05:31 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 23:05:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 23:05:30 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45645QhE031850;
	Wed, 5 Jun 2024 23:05:27 -0500
Message-ID: <79eedaea-bf4f-4a20-8a52-751ce7187523@ti.com>
Date: Thu, 6 Jun 2024 09:35:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] arm64: dts: ti: k3-j722s: Switch to
 k3-am62p-j722s-common.dtsi
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-5-s-vadapalli@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240604085252.3686037-5-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 04/06/24 14:22, Siddharth Vadapalli wrote:
> Update "k3-j722s.dtsi" to use "k3-am62p-j722s-common.dtsi" which
> contains the nodes shared with AM62P, followed by including the J722S
> specific main domain peripherals contained in "k3-j722s-main.dtsi".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> v4:
> https://lore.kernel.org/r/20240601121554.2860403-5-s-vadapalli@ti.com/
> No changes since v4.
> 
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi | 97 +++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> index c75744edb143..9e04e6a5c0fd 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> @@ -10,12 +10,107 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>  
> -#include "k3-am62p5.dtsi"
> +#include "k3-am62p-j722s-common.dtsi"
> +#include "k3-j722s-main.dtsi"
>  
>  / {
>  	model = "Texas Instruments K3 J722S SoC";
>  	compatible = "ti,j722s";
>  
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0: cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x000>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			clocks = <&k3_clks 135 0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x001>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			clocks = <&k3_clks 136 0>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x002>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			clocks = <&k3_clks 137 0>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			reg = <0x003>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			clocks = <&k3_clks 138 0>;
> +		};
> +	};
> +
> +	l2_0: l2-cache0 {
> +		compatible = "cache";
> +		cache-unified;
> +		cache-level = <2>;
> +		cache-size = <0x80000>;
> +		cache-line-size = <64>;
> +		cache-sets = <512>;
> +	};
> +
>  	cbass_main: bus@f0000 {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;


You would need to move the rest of main domain overrides and cbass_main
definitions to k3-j722s-main.dtsi and limit this file to CPU definitions
similar to k3-am62p5.dtsi



-- 
Regards
Vignesh

