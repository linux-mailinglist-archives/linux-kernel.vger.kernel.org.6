Return-Path: <linux-kernel+bounces-531552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982D2A441C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0857B16CB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B0A26B093;
	Tue, 25 Feb 2025 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKWz4F6d"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFEE269CF5;
	Tue, 25 Feb 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492343; cv=none; b=JNlnMjyE+h6+2Fo5RUziVWs1OKydFyazytqv9f+md+wQPTLM52g/khblKl1mrmqFouzxtXDSrEKC46aRLNwqYrOSLqmiR+tBjtn7ph+mO5b/z30ZCKjWuABJH9+r/bSrCblyuvG5wfdulqyColhxHB0vsocirzbYOtY8e7GkKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492343; c=relaxed/simple;
	bh=kwghDFALfMvkIRmE1HPwrpB/0PzINC5FZ1kBkLfD77w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQC34gRgR8o34ZFl6+FTSiL4mDDzNNakEWfJpAdoapv9MgqdIFeZc2qwXsJu/Z/+mzJ+EwZ0Y3mgmkfKWHAHDdDp1dDPV7iLlAlXvDSJPOofFb2940jNRucsfzQHslmCXMe/3KANVFjEInT/l/X6OozowHZ8/pNnH2Af1KLc3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKWz4F6d; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so8747093a12.0;
        Tue, 25 Feb 2025 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740492340; x=1741097140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPd/d1lS+e5D1SoZ8oB+qy8yBKc1e4tlJLwqgs9YB9g=;
        b=dKWz4F6dk5lcJFaLBki+JN5UBVuaAQY1bcAQMbEHEjabOwHFF8PyJ4iVn+Yrda91Vr
         9NAgHqKrPfpk511jRJNdFZCrwsFHAYMITy9WEkI0Xk59lxx43MNSmCvnfUdaQAH62OfZ
         Yo2Yyx9OTL1UXnaOjasd3epKhrz4ZsfdfZ3HOb2mLmgMo+MQMLnO4c+GZcvindiSAyga
         pJ2Qtf6mTdvD/3UeEZAVGgaLurjesTux5gj/CJpCn9PKcBwUZjC1wp5bN5BvCoKtqPFK
         cQrlKFVhLwJk4Ywf21NbLRL7NAbCHXoCL+2AT1ic2Sx5izUVgYa4oh83Jktx8tnYRKGj
         +AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740492340; x=1741097140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPd/d1lS+e5D1SoZ8oB+qy8yBKc1e4tlJLwqgs9YB9g=;
        b=mJXJgDpgVOxkQntWSIijd85kV8qT1edhNJLfiGwf9icD8p+m5+KQVfD/pQlGk/OMSh
         nQTORtuWIiKLpaOqa517UTBXrob1XpB5wZ4KMXQ65ZwrC2sWFfI+OdrykUGml5YTxCFQ
         GzGAGsP1dv4CWUU1zPhjI1OBXHNzfTzc7BMuXiqV0PCBVBe5eiFgro8NVfO4eS+gDSoW
         IjY6VPhlpNe0icRMpRaCMYMWvLRq2e365gkW+dUFbe/UEob63xpfNhXhSPYfl8cSa4Zh
         rYrt76yxuPE68r/Ot7c5E3EReStzpWO68YaqKvRTDMa50X0tNM5k9+6hkDkrpw0a28CC
         lWIA==
X-Forwarded-Encrypted: i=1; AJvYcCX/UhE2PykRkw8QfFgGU+isRRMso4EMtx74GzyVhugHKowsV6XbuiERD/Jz2QMK2TJ5yCE+0bMNpYRTLEZv@vger.kernel.org, AJvYcCXN60XqyjMR+hDGNJe2drnGi/5X+XlP3NxdubYXTezWB3JX65kjtWiLYH6qNwug/webVBaKWK+XrgZH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8l8v4D5OlVUvztb5hDGz7tkg8xqFwHlpc2niC0sWJ7wS3syU
	LcKz0pDQvVDwdLbXhTopAA1qiXMfOTnuRtlzjRtw1WtdhvY6iEiMCYFnmVoF
X-Gm-Gg: ASbGnctVWrk/7so07eUAIAPrgwkjsq9ikJxoE2hWv4qwDZ5qzmSPQkEbIRw83M5sjCW
	3BkVRUbiuMyfrCelQAkF+8S3riG51Wdxvzvzs3bgI6K1fiNjHV7ryIfzgGFKMWKmMemLYo6SxW/
	3osKtNdp6jg8XcoAnSPmmno0Ati8xdp9CQPo9MEK9fffcKeIolzj9a6t8l/sKpJIGV832AV9Qo0
	h0Yn8rF9XYpSU/7MbmGZ/BxUIiMhOCJsG/7NEh06Px1R0R08ngsx0f/pTq+BMQFWQLFBofOsjG4
	dCnWW75NNKT3iIoJYOQoSEZstp3Ag8W2yUdOC/soqbjjJfOfMI8=
X-Google-Smtp-Source: AGHT+IEduCdNbL7IFjCYL/sa3Uw1eSpI/ch7S+DMg3yhWwQhhBhMD+Xp89Ze8+kev4lk/55fC5U9WQ==
X-Received: by 2002:a05:6402:1e8c:b0:5de:3478:269b with SMTP id 4fb4d7f45d1cf-5e44ba3ff2emr3170354a12.32.1740492339723;
        Tue, 25 Feb 2025 06:05:39 -0800 (PST)
Received: from [192.168.6.238] ([92.120.5.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45b716aadsm1258001a12.36.2025.02.25.06.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 06:05:39 -0800 (PST)
Message-ID: <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
Date: Tue, 25 Feb 2025 16:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Content-Language: en-GB
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-5-laurentiumihalcea111@gmail.com>
 <Z7jahtO3bxjkMfnc@lizhi-Precision-Tower-5810>
From: Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>
In-Reply-To: <Z7jahtO3bxjkMfnc@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 21.02.2025 21:56, Frank Li wrote:
> On Fri, Feb 21, 2025 at 02:19:08PM -0500, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> AIPS5 is actually AIPSTZ5 as it offers some security-related
>> configurations. Since these configurations need to be applied before
>> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
>> be their parent instead of keeping AIPS5 and adding a child node for
>> AIPSTZ5. Also, because of the security configurations, the address space
>> of the bus has to be changed to that of the configuration registers.
> The orginal 0x30c0_0000..0x31200000 include 0x30df0000, why not map only
> config address part in your drivers.
>
> Frank


Any concerns/anything wrong with current approach?


I find it a bit awkward to have the whole bus address space

in the DT given that we're only interested in using the access

controller register space.


I'm fine with the approach you suggested but I don't see a

reason for using it?


>
>> Finally, since AIPSTZ5 belongs to the AUDIOMIX power domain, add the
>> missing 'power-domains' property. The domain needs to be powered on before
>> attempting to configure the security-related registers.
>>
>> The DT node name is not changed to avoid potential issues with DTs in
>> which this node is referenced.
>>
>> Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> index e0d3b8cba221..a1d9b834d2da 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> @@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
>>  			};
>>  		};
>>
>> -		aips5: bus@30c00000 {
>> -			compatible = "fsl,aips-bus", "simple-bus";
>> -			reg = <0x30c00000 0x400000>;
>> +		aips5: bus@30df0000 {
>> +			compatible = "fsl,imx8mp-aipstz", "simple-bus";
>> +			reg = <0x30df0000 0x10000>;
>> +			power-domains = <&pgc_audio>;
>>  			#address-cells = <1>;
>>  			#size-cells = <1>;
>> +			#access-controller-cells = <0>;
>>  			ranges;
>>
>>  			spba-bus@30c00000 {
>> --
>> 2.34.1
>>

