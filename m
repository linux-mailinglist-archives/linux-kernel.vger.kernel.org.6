Return-Path: <linux-kernel+bounces-555049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E758FA5A4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2803A88D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC771DE3DF;
	Mon, 10 Mar 2025 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyVAvyGG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCDDEC5;
	Mon, 10 Mar 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638294; cv=none; b=uaK67lyzR8OAojHwiFW2F9nmWRHU6IzrY1l5GSd6HLxWh7tL5BcVz/Z11gnpHTE5H8qp1VcExnRWBYKyLYLshvKW/KiIlb1tHvjqZ+5+cUuMa36OoA52JAH6R/f4n1KrDO5LxCN5i4yYFFKYPpTWMvzjBAEBgt+wbOQyx00HrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638294; c=relaxed/simple;
	bh=zRAETu+vtx7OO3I4ymMlEe8g3nZQLbUML46LRlTlR6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzBqK2HerCmGfFDmIbkkKXiTbQZwxcXACQT+GSxkcFuluu17Ci0rxk8nihvDey8lMWMxcrZ557f7KM4lvLAO8dJZTmD1dgkJwPYw9/eaIUz6QXA7AeUFFFLJvETiDCMlMf6ikNvbaySM90KjtvRF6+Ehh1wyEsi6pQUHtofLC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyVAvyGG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so8541975e9.2;
        Mon, 10 Mar 2025 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741638291; x=1742243091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+ktPkSgcUGUlkY81X04oFnn6Ho1f2nUx2ZGQe0I0/8=;
        b=EyVAvyGGVWN+W3UCbrOSnOPOBxhmdIJkWvYod/JoYJAo4P16Lz/VGyytlF5+bunAjb
         qRBN2dvLRjD7qSDiHlYHUL/Njybmx1/+cGSEpzG8CaXegbKsUgXnyDXbmBJzvA+ux6ZZ
         8QuNTJ3+/j0r8tBMq2XDC+fqAVMkz/oFK9irToP3IP5OZHStgInpsfXRETS8MGgA3mVs
         X5VbPr/YPKLFFqjl9Tg/0xi/a8pTjOFLL95T3m1p0fJd0BASLvkdCuk9vjvOG/eNoF0O
         mjRiu2MUvXUYr65PKKgMT0soWW93q+6a0Uon72/7iBCEs1UkrbJzUd7B0gkSKdVDnxxs
         1H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638291; x=1742243091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+ktPkSgcUGUlkY81X04oFnn6Ho1f2nUx2ZGQe0I0/8=;
        b=NLQ904RIWk6wBPfmw11h9xjX/+yf133XnnwUJldfuB2iglQ9bGmljvIVybtVyNM9Hk
         PoNtrCK+JfbQ18AeAkGx0izge6q5DndoOJWPWnSvUEAu0hU6tNYR5JhLbD5qWrfYwBL5
         mhKNtXnocSXSMnOXmLr91ZceK47duWm3Rt06bJAn/nSElOh72V+gdfxWai2398kK9wFk
         O9sxI4w/wFmmoh7jZyTmULBZmktBJB43nyJJehxtTSNPoC2N1ir0v5NyCuVa44rPJCcK
         B+A5qj3jjGMv5jEpNBtGkxdmbZvGDmH533VySO2lWDAWulPh7AqLpat5ZZq9nw0LEBrF
         66ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVczLlZLpZFGgoT2jrC7ZJcvwu8xXuR7jST2oIxeosANT7rlCPQvP2a9NC0dSe6daj+GUZuy5ffWCy+@vger.kernel.org, AJvYcCWYIJ6N1o9h88CJavVb5yaTHcZNX/RoXaESqW1dm0kH0gcTQRy79EZDrXsqfZQyKlCLgs1ycO5WdM4wKdAk@vger.kernel.org
X-Gm-Message-State: AOJu0YxBAFSfLcDd9hgI03jjKLVBfjkKOTUhYbUkWXs+r4vhWpXdMbR1
	zKd9FaVCUWbT25X7Qgg7typiEWW0XIuMKIaKzeKYrHkI6USr7uZW
X-Gm-Gg: ASbGncuqk5SzM6VF5ltAcnGd9kcB+gN0fnM60aBTwsMFbAOEzB4kYtuI8KgMmEkeodU
	NrYrkxPJcheT68Quf+D3SeuLv/uCFwf0B7u8iTaKz1izArYQlWoShgob8R6o7TW5Pe7znSWP4Gh
	PfVBgsP6BJFnIqDr9ppIHzvMKcmSnddeXM83VtUvoM6qm97VhEF2UuimBWlihLETKbQJX1UKtkK
	zog8XnxU1dOoqjl9hnkqRn/NN59kS0FDDoqgYEPOz0xBOadbyMGkqQjO8q2/EEFhHhjnJeX9Bym
	9ruC+7BPshhJ677FTwfO4vQeDfDaeayeI5KkxI/Ck9nElviWgcdsT1swqL7a1S4kYQbD96fkYA=
	=
X-Google-Smtp-Source: AGHT+IHSzh7GZzsKQtSd3xfRZgUnU3VBKg01JBP3XWDNFJWhCbZmJMR+PhPG67a9gA+EwukcX+lhbg==
X-Received: by 2002:a05:6000:144d:b0:391:139f:61af with SMTP id ffacd0b85a97d-39132d8c768mr9284588f8f.32.1741638290675;
        Mon, 10 Mar 2025 13:24:50 -0700 (PDT)
Received: from [192.168.1.132] ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdff72sm16179790f8f.36.2025.03.10.13.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 13:24:50 -0700 (PDT)
Message-ID: <ec38d41d-f2ce-4a98-bb02-d1ae9beb0b3b@gmail.com>
Date: Mon, 10 Mar 2025 22:24:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Frank Li <Frank.li@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, Pengutronix Kernel Team <kernel@pengutronix.de>,
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
 <bfe3c719-f1c5-4ae5-9a40-45ad75cd5855@gmail.com>
 <20250307152236.3ayulbjqnu3vn7mf@pengutronix.de>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250307152236.3ayulbjqnu3vn7mf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/7/2025 5:22 PM, Marco Felsch wrote:
> On 25-03-04, Laurentiu Mihalcea wrote:
>> On 2/28/2025 12:19 PM, Marco Felsch wrote:
>>> Hi,
>>>
>>> On 25-02-27, Frank Li wrote:
>>>> On Thu, Feb 27, 2025 at 11:57:54AM +0100, Marc Kleine-Budde wrote:
>>>>> On 25.02.2025 16:14:34, Mihalcea Laurentiu wrote:
>>>>>> On 21.02.2025 21:56, Frank Li wrote:
>>>>>>> On Fri, Feb 21, 2025 at 02:19:08PM -0500, Laurentiu Mihalcea wrote:
>>>>>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>>>>>>
>>>>>>>> AIPS5 is actually AIPSTZ5 as it offers some security-related
>>>>>>>> configurations. Since these configurations need to be applied before
>>>>>>>> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
>>>>>>>> be their parent instead of keeping AIPS5 and adding a child node for
>>>>>>>> AIPSTZ5. Also, because of the security configurations, the address space
>>>>>>>> of the bus has to be changed to that of the configuration registers.
>>>>>>> The orginal 0x30c0_0000..0x31200000 include 0x30df0000, why not map only
>>>>>>> config address part in your drivers.
>>>>>>>
>>>>>>> Frank
>>>>>> Any concerns/anything wrong with current approach?
>>>>>>
>>>>>>
>>>>>> I find it a bit awkward to have the whole bus address space
>>>>>> in the DT given that we're only interested in using the access
>>>>>> controller register space.
>>>>>>
>>>>>>
>>>>>> I'm fine with the approach you suggested but I don't see a
>>>>>> reason for using it?
>>>>> Looking at the "AIPS5 Memory Map" (page 34/35 in i.MX 8M Plus
>>>>> Applications Processor Reference Manual, Rev. 3, 08/2024), the
>>>>> AIPS5_Configuration is part of the AIPS5 bus. IMHO the bus is something
>>>>> different than the bus configuration. Why not model it as part of the
>>>>> bus?
>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>>>>> index e0d3b8cba221..a1d9b834d2da 100644
>>>>>>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>>>>>> @@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
>>>>>>>>  			};
>>>>>>>>  		};
>>>>>>>>
>>>>>>>> -		aips5: bus@30c00000 {
>>>>>>>> -			compatible = "fsl,aips-bus", "simple-bus";
>>>>>>>> -			reg = <0x30c00000 0x400000>;
>>>>>>>> +		aips5: bus@30df0000 {
>>>>>                        ^^^^^^^^^^^^
>>>>>>>> +			compatible = "fsl,imx8mp-aipstz", "simple-bus";
>>>>>>>> +			reg = <0x30df0000 0x10000>;
>>>>>>>> +			power-domains = <&pgc_audio>;
>>>>>>>>  			#address-cells = <1>;
>>>>>>>>  			#size-cells = <1>;
>>>>>>>> +			#access-controller-cells = <0>;
>>>>>>>>  			ranges;
>>>>>>>>
>>>>>>>>  			spba-bus@30c00000 {
>>>>>                         ^^^^^^^^^^^^^^^^^
>>>>>
>>>>> This looks very strange: The aips5 bus starts at 0x30df0000 and has a
>>>>> child bus starting at 0x30c00000?
>>>> @30df0000 should match controller reg's address.
>>>>
>>>> subnode address 0x30c00000,  should be descript in "ranges", which 1:1 map.
>>>>
>>>> So it should be reasonable. another example:
>>>> i2c@1000 {
>>>>
>>>> 	device@1c <- which use difference address space.
>>>> }
>>>>
>>>> The similar case also happen at pcie.
>>> I'm not really convinced that pcie and i2c are good examples here. I2C
>>> does have an other addressing scheme by nature and the hotplug-able pcie
>>> is dependeds on the pcie device memory map of course.
>>>
>>> Here we're talking about an access control IP core on a bus which is
>>> static.
>>>
>>> But.. it looks like from DT abstraction it's fine because STM did
>>> something similiar with their st,stm32mp25-rifsc or st,stm32-etzpc
>>> albeit it does look strange and I don't know why we have to limit the
>>> address space since it was already mapped but used by the fsl,aips-bus
>>> driver.
>>>
>>> Regards,
>>>   Marco
>> The address space of the bridge was changed to that of the bridge's
>> configuration space because I think it's very awkward from the
>> software's point of view to have to hardcode the offset and size of
>> the configuration space inside the driver. 
> You mean the access-controller IP core. I could also arguee that it's
> akward to put the bridge access-controller IP core into the middle of
> the bridge address-space instead of placing it at the very beginning of
> the bridge. But this doesn't help here :)
>
> I see what you mean but from DT abstraction POV it seems more reasonable
> to keep it as it is and just adapt the compatible. The current driver
> maps the whole address space too, so I don't see why we need to change
> it if we change it to the aipstz driver. If you see the
> access-controller IP core as part of the bus I don't see any problem and
> would argue that the offset detail needs to be handled within the
> driver.
>
>> I also looked at what STM did with "st,stm32-etzpc" so I thought this
>> would be acceptable from the DT's POV.
>>
>> Regarding why I chose not to model the access controller part as a subnode of the
>> bus:
>>
>>     1) The access controller is part of the bridge itself (not a separate module accessible
>>     via the bridge like it's the case for its children) so I think the current approach
>>     should also make sense if we take the hardware into consideration.
> I don't like this approach if you see the controller as part of the
> bridge because the offset could be handled within the bridge driver.
> I also that the register offset needs to be supplied else we can't reuse
> the driver and we don't want to adapt the driver for each SoC.
>
> What came into my mind is the following:
>
> 	spba-bus@30c00000 {
> 		compatible = "nxp,imx8mp-aiptz-bus", "nxp,aiptz-bus";
> 		reg = <0x30c00000 0x400000>, <0x30df0000 0x10000>;
> 		reg-names = "bus", "aipstz";
>
> 		child-nodes {};
> 		child-nodes {};
> 		child-nodes {};
> 	}
>
> This way we can abstract the access-controller register space and the
> whole bus register space and a generic driver could be written just by
> making use two reg fields.


by changing the compatible, we've also effectively changed the programming model.
I don't really see why we need to stick to the old way of configuring the bus node (i.e:
specify the whole address space of the bus as well) when all we really care about is the AC
configuration region?
 
anyhow, I'm not going to insist on this. I think the proposed approach will work just
fine. If there's no other comments on this then I'll just switch to it in V3.


>
>>     2) The access controller configuration also impacts the AP. As such, we needed a way to
>>     enforce a dependency between the children of the aips5 bus and the access controller
>>     (we could have used the 'access-controllers' property like we did with the DSP but having
>>     to do that for all children of the bus is not ideal I'd say.
>>
>> Of course, argument no. 2 is somewhat brittle in the context of i.MX8MP as the reset
>> values of the AC's registers already allow the AP to access said peripherals. Despite this,
>> I think the current approach would be more scalable given that the IP offers some more
>> configuration bits which we might want to toggle. For that to work, we need to make sure
>> the bits are toggled before the AP accesses the peripherals on the bridge.
> Please have a look on my suggestion above.
>
> Regards,
>   Marco
>
>> Note that we don't do this for aips1-aips4 because it's really not needed. If I'm not mistaken,
>> they're not really attached to a PD so we don't need to re-configure them each time the domain
>> is power cycled (which is why we can just do it once from ATF during the boot process)


