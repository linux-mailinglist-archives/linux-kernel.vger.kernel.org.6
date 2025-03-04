Return-Path: <linux-kernel+bounces-544895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4CA4E68F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175834235C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31137265600;
	Tue,  4 Mar 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfgSm8XR"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C027C174;
	Tue,  4 Mar 2025 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104724; cv=none; b=Ni34oGnqSAt16FhbftVYrw6DSMBKPwzE8DS7nEQKMLyAJGodwnyNvR2qEMUfTz44QKgW9+/PICETRclkx3jbBrhZegGMB6+kHxTjYupkuVN6EyRatGW+MZSZo+cjoYaxSqdMciowG534T2Oz38KVL81JvNoCuq69x7wPnNiLJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104724; c=relaxed/simple;
	bh=Mgqplim4+FgE7Eq9tRQi5Q91N0eNK1oBMLtKZ3qAXZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lhx5fR71GqMwdywBqF+hTAtCej3CpFCvZXIkYEKsVbJagPGnNN5r/CDx27kAUZIfzXocCoTmPfpI46cyME5ykbK65Lz9IteAoyJXDDVAGCFLu46e4RBZbjKFGfdJJHDXAAt0H39eDSIW266PrcPgqUblZ6PbzU/xCAmCa+Y1guk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfgSm8XR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390f5f48eafso1920761f8f.0;
        Tue, 04 Mar 2025 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741104720; x=1741709520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKFVl5Wcef8C2g2vOUYpWd1OHCoI6tR79rGAxjSDkuk=;
        b=lfgSm8XRQmQgl19HWH/Cqvp0e0fKcUlvp4lW1ypfi8QChuKaAm6RDSeyY7ydsQybx5
         NP6REQGKUA9k76UpMBm7DvoabrTffB24SYeXIN6OblawEJ1gUrsyfPMTIDBrxVrOFjWv
         eSYU5BUU9ExrLWoAzRFMGCF3W9+l2mKtOnTRe+SrmUzAn30GCx8zdH8WtghKl8sQ7sqn
         6uuTi5aSmoSDDRIahrZRueCds3QNiQjN17Xj1KOuwWO9uioAtuc/1nauKfyOvqi933cH
         d7qo58daghmwpNgsLwxwzlAhSTr/LnfLvAWjOCzSZ+isRm8eFSMZb7Hn0W4MnhVzowrr
         4bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741104720; x=1741709520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKFVl5Wcef8C2g2vOUYpWd1OHCoI6tR79rGAxjSDkuk=;
        b=F/7IB/u5tHE/WNC+Lx4lriaJcJPXwqAcrqNPnZmnynOQ0bPm+wiwcwszKba00U5wem
         whYjKoyjjKNOXETaWzhkITxHpxnU3g6w1zqEUEgiMb5VyoL7+3yicLDuMnFpW8pCjMSQ
         XGDFc33T+yaknE3sovITPztJJRej+4XXfj4ak5NwTKZI7F8tzXLWA+lpE5ksoYjf3Ds1
         2ztoxD7KKt/QnCDMTYbAlLDmMNkOADbZ5rtOoyoxnQSLjTNPGGIIuBE9Oeqv+6VAMbMR
         ahFEnlbxczXkum6mBYdsFVOMkUucAbjhhz3ZVy+bKF6n4IN++FoxG615sv1bhRpAtH2x
         EepQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdXEhcH0uHXqmERjdsNn/A8O35AT28p07dX9FLoTZYdGWYK8S9C6Q+9V7U+AvbFBAik026uUVcclxs@vger.kernel.org, AJvYcCXXMOB4UvhL4HI6usiM7inbYGpFFZTPdPR2/DauAvktVm48LOUIuGg4X/sulqzqvNXMhxRFNfnjqNFN9Mf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27whwWuFp49wWqIgMQUbfinOZ/q5hsYB2fQ4mKPMu/phiAF3N
	jGKbcBSmVOo+EPaiB4WJCkfc9ktmELLM4EpLYBNEuwuw6FAcs7Dy
X-Gm-Gg: ASbGncscEd8rEjjgU5VSTpWiggKsbQgKOCaY/WmsqmJ4HQD9Uh4yNGrN3/GddSxS2GY
	2JlGoZzIt5xQl4rzPDSbXIJDw9DN+Cq+aDjbAWB6T58nRsiqeBYNOntEn5cB8jjNfpUE8tJZVzk
	5m8oA7b8fUzpEtxtmsPX1inFHKyvambeKkZtqVPGJTcyPQTl2/ExiWRQeDyQFI1+Csva3nsZUQ2
	x/XkvvgV7/eBVlz48g5dzhgwkEwPoSGBLIwbFYXF3dmSFTvOFnTSsgCDr0Xp1xmwZftyUJ5h1+P
	2v3ZNYZxTohzi1Fweb33nsLXJy/cPskWwResEaCbf39WVMQOAFaf669MIFDTkzvW3gl5FImtQA=
	=
X-Google-Smtp-Source: AGHT+IECucg6TxRY/3+YaDVr6S0Oivym8EfoWcFrWoYt/S7uuLYkulzezOXsbiAvNlHj/uTIVPGYjg==
X-Received: by 2002:a05:6000:1a88:b0:391:139f:61c2 with SMTP id ffacd0b85a97d-391139f6478mr5227327f8f.31.1741104719480;
        Tue, 04 Mar 2025 08:11:59 -0800 (PST)
Received: from [192.168.1.132] ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479609asm17853950f8f.2.2025.03.04.08.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:11:59 -0800 (PST)
Message-ID: <bfe3c719-f1c5-4ae5-9a40-45ad75cd5855@gmail.com>
Date: Tue, 4 Mar 2025 18:11:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>, Frank Li <Frank.li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Daniel Baluta <daniel.baluta@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-arm-kernel@lists.infradead.org
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-5-laurentiumihalcea111@gmail.com>
 <Z7jahtO3bxjkMfnc@lizhi-Precision-Tower-5810>
 <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
 <20250227-monumental-whale-of-security-b1c84e-mkl@pengutronix.de>
 <Z8CWsI/DKZtDBkzE@lizhi-Precision-Tower-5810>
 <20250228101952.g6tae3ni5xrhjk3y@pengutronix.de>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250228101952.g6tae3ni5xrhjk3y@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/28/2025 12:19 PM, Marco Felsch wrote:
> Hi,
>
> On 25-02-27, Frank Li wrote:
>> On Thu, Feb 27, 2025 at 11:57:54AM +0100, Marc Kleine-Budde wrote:
>>> On 25.02.2025 16:14:34, Mihalcea Laurentiu wrote:
>>>> On 21.02.2025 21:56, Frank Li wrote:
>>>>> On Fri, Feb 21, 2025 at 02:19:08PM -0500, Laurentiu Mihalcea wrote:
>>>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>>>>
>>>>>> AIPS5 is actually AIPSTZ5 as it offers some security-related
>>>>>> configurations. Since these configurations need to be applied before
>>>>>> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
>>>>>> be their parent instead of keeping AIPS5 and adding a child node for
>>>>>> AIPSTZ5. Also, because of the security configurations, the address space
>>>>>> of the bus has to be changed to that of the configuration registers.
>>>>> The orginal 0x30c0_0000..0x31200000 include 0x30df0000, why not map only
>>>>> config address part in your drivers.
>>>>>
>>>>> Frank
>>>> Any concerns/anything wrong with current approach?
>>>>
>>>>
>>>> I find it a bit awkward to have the whole bus address space
>>>> in the DT given that we're only interested in using the access
>>>> controller register space.
>>>>
>>>>
>>>> I'm fine with the approach you suggested but I don't see a
>>>> reason for using it?
>>> Looking at the "AIPS5 Memory Map" (page 34/35 in i.MX 8M Plus
>>> Applications Processor Reference Manual, Rev. 3, 08/2024), the
>>> AIPS5_Configuration is part of the AIPS5 bus. IMHO the bus is something
>>> different than the bus configuration. Why not model it as part of the
>>> bus?
>>>
>>>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>>> index e0d3b8cba221..a1d9b834d2da 100644
>>>>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>>> @@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
>>>>>>  			};
>>>>>>  		};
>>>>>>
>>>>>> -		aips5: bus@30c00000 {
>>>>>> -			compatible = "fsl,aips-bus", "simple-bus";
>>>>>> -			reg = <0x30c00000 0x400000>;
>>>>>> +		aips5: bus@30df0000 {
>>>                        ^^^^^^^^^^^^
>>>>>> +			compatible = "fsl,imx8mp-aipstz", "simple-bus";
>>>>>> +			reg = <0x30df0000 0x10000>;
>>>>>> +			power-domains = <&pgc_audio>;
>>>>>>  			#address-cells = <1>;
>>>>>>  			#size-cells = <1>;
>>>>>> +			#access-controller-cells = <0>;
>>>>>>  			ranges;
>>>>>>
>>>>>>  			spba-bus@30c00000 {
>>>                         ^^^^^^^^^^^^^^^^^
>>>
>>> This looks very strange: The aips5 bus starts at 0x30df0000 and has a
>>> child bus starting at 0x30c00000?
>> @30df0000 should match controller reg's address.
>>
>> subnode address 0x30c00000,  should be descript in "ranges", which 1:1 map.
>>
>> So it should be reasonable. another example:
>> i2c@1000 {
>>
>> 	device@1c <- which use difference address space.
>> }
>>
>> The similar case also happen at pcie.
> I'm not really convinced that pcie and i2c are good examples here. I2C
> does have an other addressing scheme by nature and the hotplug-able pcie
> is dependeds on the pcie device memory map of course.
>
> Here we're talking about an access control IP core on a bus which is
> static.
>
> But.. it looks like from DT abstraction it's fine because STM did
> something similiar with their st,stm32mp25-rifsc or st,stm32-etzpc
> albeit it does look strange and I don't know why we have to limit the
> address space since it was already mapped but used by the fsl,aips-bus
> driver.
>
> Regards,
>   Marco

The address space of the bridge was changed to that of the bridge's configuration
space because I think it's very awkward from the software's point of view to have
to hardcode the offset and size of the configuration space inside the driver. I also
looked at what STM did with "st,stm32-etzpc" so I thought this would be acceptable
from the DT's POV.

Regarding why I chose not to model the access controller part as a subnode of the
bus:

    1) The access controller is part of the bridge itself (not a separate module accessible
    via the bridge like it's the case for its children) so I think the current approach
    should also make sense if we take the hardware into consideration.

    2) The access controller configuration also impacts the AP. As such, we needed a way to
    enforce a dependency between the children of the aips5 bus and the access controller
    (we could have used the 'access-controllers' property like we did with the DSP but having
    to do that for all children of the bus is not ideal I'd say.

Of course, argument no. 2 is somewhat brittle in the context of i.MX8MP as the reset
values of the AC's registers already allow the AP to access said peripherals. Despite this,
I think the current approach would be more scalable given that the IP offers some more
configuration bits which we might want to toggle. For that to work, we need to make sure
the bits are toggled before the AP accesses the peripherals on the bridge.


Note that we don't do this for aips1-aips4 because it's really not needed. If I'm not mistaken,
they're not really attached to a PD so we don't need to re-configure them each time the domain
is power cycled (which is why we can just do it once from ATF during the boot process)
  

