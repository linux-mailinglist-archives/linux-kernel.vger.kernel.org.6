Return-Path: <linux-kernel+bounces-224973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6E2912954
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D52280EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B46E2BE;
	Fri, 21 Jun 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HMpmWCH0"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E32C697;
	Fri, 21 Jun 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983275; cv=none; b=TjjfeDL8WI3k7l5A6gZ0Wo+gB63Fj9b2/ZPPaz9Op4vFF+XBFwBpZ7Ll8aS6m4A9DhtENBGRpwADUgh4LUCibd/mvQfDvi4bWn3LpB/qg1S4ExBBMQOQ3+u+ZjlcLM87GQ0XUPQzqlqdFVkaeb2uTQWSzuLZIIwkuoMpMLAOVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983275; c=relaxed/simple;
	bh=z9ErfZMgisqbQa9A69KBsr80kL7RXY1vNML7JfLRgTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bo8oh4BteWwIstt1NdBhAXUGA3Vrd7Q4IZRgWINaQdq/eYnWoeoA3qlJEPyx2uWacsvqEqdCJ3YzUdsr0PhHOKDhxrEfl6+BnhRLDJoar4CtVAT8HTuLML1ykyIecOpRxBRrYA/8dnTekW1/Yu4pViANmLr55Ex5bTzRyi00fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HMpmWCH0; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LFL6UR029146;
	Fri, 21 Jun 2024 10:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718983266;
	bh=gAwWwxKAzOtWrctk/Daj6SikSCuXnBnACf15WJ0/PS8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HMpmWCH0PYzF3b9tNy++OvzFNtS0Y+HHn7hrx1FftAR5ydiizvt4ys7L34flMrsah
	 JNSTk8W/9xYew5mkoVKOmka+pBEjuSdg6dEF+SaKIbkufdNcgVW0kkegR5MRNTKfXQ
	 zG9WgruiBRwzHedGUL3GfjHdHXiekc/56kRbY814=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LFL6Gc008219
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 10:21:06 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 10:21:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 10:21:06 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LFL2re072209;
	Fri, 21 Jun 2024 10:21:03 -0500
Message-ID: <71126a8f-7a6d-4561-bb13-a403fe580ab2@ti.com>
Date: Fri, 21 Jun 2024 20:51:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Add node for EHRPWMs
To: Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dasnavis Sabiya
	<sabiya.d@ti.com>
References: <20240603112938.2188510-1-u-kumar1@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240603112938.2188510-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 03/06/24 16:59, Udit Kumar wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> Add dts nodes for 6 EHRPWM instances on SoC.
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 6a4554c6c9c1..f6fc2ce55f9b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -75,6 +75,72 @@ serdes_ln_ctrl: mux-controller@4080 {
>  				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
>  				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
>  		};
> +
> +		ehrpwm_tbclk: clock-controller@4140 {
> +			compatible = "ti,am654-ehrpwm-tbclk";
> +			reg = <0x4140 0x18>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +
> +	main_ehrpwm0: pwm@3000000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;


This needs to be ordered as per

https://www.kernel.org/doc/Documentation/devicetree/bindings/dts-coding-style.rst
(compatible is immediately followed by reg)

Will fix all the nodes locally before merging

> +		reg = <0x00 0x3000000 0x00 0x100>;
> +		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 219 0>;
> +		clock-names = "tbclk", "fck";
> +		power-domains = <&k3_pds 219 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm1: pwm@3010000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3010000 0x00 0x100>;
> +		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 220 0>;
> +		clock-names = "tbclk", "fck";
> +		power-domains = <&k3_pds 220 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm2: pwm@3020000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3020000 0x00 0x100>;
> +		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 221 0>;
> +		clock-names = "tbclk", "fck";
> +		power-domains = <&k3_pds 221 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm3: pwm@3030000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3030000 0x00 0x100>;
> +		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 222 0>;
> +		clock-names = "tbclk", "fck";
> +		power-domains = <&k3_pds 222 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm4: pwm@3040000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3040000 0x00 0x100>;
> +		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 223 0>;
> +		clock-names = "tbclk", "fck";
> +		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm5: pwm@3050000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3050000 0x00 0x100>;
> +		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 224 0>;
> +		clock-names = "tbclk", "fck";
> +		power-domains = <&k3_pds 224 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>  	};
>  
>  	gic500: interrupt-controller@1800000 {

-- 
Regards
Vignesh

