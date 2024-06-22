Return-Path: <linux-kernel+bounces-225569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C5913264
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 08:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA841F23337
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 06:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DE14B078;
	Sat, 22 Jun 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o+3AZQO8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4009B2913;
	Sat, 22 Jun 2024 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719038219; cv=none; b=OiNLOSPhZo4YI1ejbR7YFs7c8Wh9VFydP9S5X07h8a1QBe+l9spfoJLwMgvOEJAoCjbubM9oniITjyvGlUUX1QaKbYY8FAO+jOmof1SzZp4qR25UpqxCVwWtaQmHla1azszfDkhaSJ9sLwJDi0LdWYrhFHw7KihP+pYszDQ3hw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719038219; c=relaxed/simple;
	bh=En0xQ3RKF8jSBoMVs3ZQhUwsz+l78Ptp4jBZjcOlVTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lZzelEtRyGGLRY4/Ut/akWgZtLG4QE0zRCDCYjSukD5FTDbQ8PIqw5cOC+HeqDLkMge+cFMtVA+kZ3XMLFLswE2yNYv5QTiWkCgcHV4n4yskO+c5MWAvr5fku0V81WnBdpdVee/iJkleA1b7DUDswci5ArW32Ff06zcmtCNNaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o+3AZQO8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45M6apPV096204;
	Sat, 22 Jun 2024 01:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719038211;
	bh=hdNZUlhSUuH1uog2xu4MNTo3MrR9ECsiWjQqU/6nbbo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=o+3AZQO80mRi4+9c2mZ2laC9XPQclxFYCvZTyX8yYTFT19Ruwwz5NfyRdDIYM3Wjz
	 7hPMm0H8pwMZqei+Ra5+bcPMzIRY6Z/DQZUh1m7+b+DbP/CcOvVxofANl6tCwxsL5K
	 x0ai4glSJTllqZGAGAxo1XZo7lTuv2cGEI3qllHM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45M6ap5m005066
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 01:36:51 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 01:36:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 01:36:51 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45M6alVJ027842;
	Sat, 22 Jun 2024 01:36:48 -0500
Message-ID: <cfab6475-9224-44a6-b140-59f6ec243ab1@ti.com>
Date: Sat, 22 Jun 2024 12:06:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j722s-evm: Enable analog audio
 support
To: Jayesh Choudhary <j-choudhary@ti.com>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <robh@kernel.org>, <j-luthra@ti.com>, <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20240612051246.41117-1-j-choudhary@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240612051246.41117-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 12/06/24 10:42, Jayesh Choudhary wrote:
[...]
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index bf3c246d13d1..426ae3e8a839 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -105,6 +105,16 @@ vdd_sd_dv: regulator-TLV71033 {
>  			 <3300000 0x1>;
>  	};
>  
> +	vcc_3v3_aud: regulator-vcc3v3 {
> +		/* Output of LM5140 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>  	vsys_io_1v8: regulator-vsys-io-1v8 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vsys_io_1v8";
> @@ -122,6 +132,35 @@ vsys_io_1v2: regulator-vsys-io-1v2 {
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> +
> +	codec_audio: sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "J722S-EVM";
> +		simple-audio-card,widgets =
> +			"Headphone",	"Headphone Jack",
> +			"Line",		"Line In",
> +			"Microphone",	"Microphone Jack";
> +		simple-audio-card,routing =
> +			"Headphone Jack",	"HPLOUT",
> +			"Headphone Jack",	"HPROUT",
> +			"LINE1L",		"Line In",
> +			"LINE1R",		"Line In",
> +			"MIC3R",		"Microphone Jack",
> +			"Microphone Jack",	"Mic Bias";
> +		simple-audio-card,format = "dsp_b";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,frame-master = <&sound_master>;
> +		simple-audio-card,bitclock-inversion;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&mcasp1>;
> +		};
> +
> +		sound_master: simple-audio-card,codec {
> +			sound-dai = <&tlv320aic3106>;
> +			clocks = <&audio_refclk1>;
> +		};
> +	};
>  };
>  
>  &main_pmx0 {

[...]

> +&main_conf {
> +	audio_refclk1: clock@82e4 {
> +		compatible = "ti,am62-audio-refclk";
> +		reg = <0x82e4 0x4>;
> +		clocks = <&k3_clks 157 18>;
> +		assigned-clocks = <&k3_clks 157 18>;
> +		assigned-clock-parents = <&k3_clks 157 33>;
> +		#clock-cells = <0>;
> +	};


Shouldn't this be in a SoC level dtsi? If the clock selection is based
on board design, the only move the assigned-clocks* to board file and
keep the rest in SoC level files.


> +};

-- 
Regards
Vignesh

