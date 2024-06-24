Return-Path: <linux-kernel+bounces-226978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324391469E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40081C22224
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A318133406;
	Mon, 24 Jun 2024 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rHXq0BT5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3212F592;
	Mon, 24 Jun 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222344; cv=none; b=X2tZmRW8RlbHgqZ8h/Fxsk/KtnimA9/gYZIWe1YoRc5UdhRCrDnWIvurQwovBKNeoUJxNqEi7G8w2xOgm2SDyihOYx7c3WMcRv27pCB1qBozpF0YOAkEMg4q6yRE09F5krZn4csOUrIyWWizWiNlWc3pyemKlwbj20GVmNZaCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222344; c=relaxed/simple;
	bh=13d/ilyNNAuNPFJQyhVbyEzEDPGUkVOOt5eLEDKdv1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fewj1Gd2MJtappjBD6aL0sJn8ILSiE22diPMezUaBMnr3i45G9ZFiWilSUFXCMc7Pu3o5R6N0BHHd5I4s4C2USjIk5cjtMS9MBVmH/kj9VuAmrBd6L5ee2VsLaaTzCJeqx3WQJQlLYLedwv8R28sYtAqra9udX457plZ2QbEDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rHXq0BT5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45O9jZdB117440;
	Mon, 24 Jun 2024 04:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719222335;
	bh=8O89IBLwiQrWcMfXqNuDgSbw45ubGzoaPk3beQnyx24=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rHXq0BT5/n0explM07rlrvqo7sEUtgtcGPYgr6uOGDqlZDMXE7pTFnsD/7Qw/vtO5
	 9M4FCAT+fczZDz4gQ8fspHA1F1P+RvOKyYXD+XWAJhYPOMGfq2sudmyKMw4PZg6cz5
	 E6Omoxd6Y2fYX1Z3fJtsLLIhOg6Hy0+ycTHME1DU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45O9jZiu002810
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 04:45:35 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 04:45:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 04:45:35 -0500
Received: from [172.24.227.55] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45O9jVBO005521;
	Mon, 24 Jun 2024 04:45:32 -0500
Message-ID: <b3587597-0b0b-493e-baa7-16f9b87231be@ti.com>
Date: Mon, 24 Jun 2024 15:15:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j722s-evm: Enable analog audio
 support
To: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <robh@kernel.org>, <j-luthra@ti.com>, <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20240612051246.41117-1-j-choudhary@ti.com>
 <cfab6475-9224-44a6-b140-59f6ec243ab1@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <cfab6475-9224-44a6-b140-59f6ec243ab1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Vignesh,

On 22/06/24 12:06, Vignesh Raghavendra wrote:
> 
> 
> On 12/06/24 10:42, Jayesh Choudhary wrote:
> [...]
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> index bf3c246d13d1..426ae3e8a839 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> @@ -105,6 +105,16 @@ vdd_sd_dv: regulator-TLV71033 {
>>   			 <3300000 0x1>;
>>   	};
>>   
>> +	vcc_3v3_aud: regulator-vcc3v3 {
>> +		/* Output of LM5140 */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc_3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>>   	vsys_io_1v8: regulator-vsys-io-1v8 {
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "vsys_io_1v8";
>> @@ -122,6 +132,35 @@ vsys_io_1v2: regulator-vsys-io-1v2 {
>>   		regulator-always-on;
>>   		regulator-boot-on;
>>   	};
>> +
>> +	codec_audio: sound {
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,name = "J722S-EVM";
>> +		simple-audio-card,widgets =
>> +			"Headphone",	"Headphone Jack",
>> +			"Line",		"Line In",
>> +			"Microphone",	"Microphone Jack";
>> +		simple-audio-card,routing =
>> +			"Headphone Jack",	"HPLOUT",
>> +			"Headphone Jack",	"HPROUT",
>> +			"LINE1L",		"Line In",
>> +			"LINE1R",		"Line In",
>> +			"MIC3R",		"Microphone Jack",
>> +			"Microphone Jack",	"Mic Bias";
>> +		simple-audio-card,format = "dsp_b";
>> +		simple-audio-card,bitclock-master = <&sound_master>;
>> +		simple-audio-card,frame-master = <&sound_master>;
>> +		simple-audio-card,bitclock-inversion;
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai = <&mcasp1>;
>> +		};
>> +
>> +		sound_master: simple-audio-card,codec {
>> +			sound-dai = <&tlv320aic3106>;
>> +			clocks = <&audio_refclk1>;
>> +		};
>> +	};
>>   };
>>   
>>   &main_pmx0 {
> 
> [...]
> 
>> +&main_conf {
>> +	audio_refclk1: clock@82e4 {
>> +		compatible = "ti,am62-audio-refclk";
>> +		reg = <0x82e4 0x4>;
>> +		clocks = <&k3_clks 157 18>;
>> +		assigned-clocks = <&k3_clks 157 18>;
>> +		assigned-clock-parents = <&k3_clks 157 33>;
>> +		#clock-cells = <0>;
>> +	};
> 
> 
> Shouldn't this be in a SoC level dtsi? If the clock selection is based
> on board design, the only move the assigned-clocks* to board file and
> keep the rest in SoC level files.
> 

Ok.
I will need to rebase on top of Siddharth's patches[0] which I see are
now merged.
Will do that and roll v3.

[0]: 
https://lore.kernel.org/all/20240615081600.3602462-4-s-vadapalli@ti.com/

Thanks,
Jayesh

> 
>> +};
> 

