Return-Path: <linux-kernel+bounces-386678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106E9B46CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CEE1C21C88
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5386204950;
	Tue, 29 Oct 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jItWNOR+"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0D1DED5A;
	Tue, 29 Oct 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197581; cv=none; b=EtY2dcRde7e1VUMamITOI86HBJW2xgFO9nPiYlwZF1hyJ3JTNvTd5KuCznnDngHaV9wrhBrPcPliiDIwbb9Aar6XS4nq+ZIya46wdum1ZsNc+jINRJlgTc3NNsLawgGNRgE3jSQut1xU/pIvzUcTFWVbcs2rxWhYSOs525Qle78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197581; c=relaxed/simple;
	bh=AZI30ymhUe6g/plTTE976jSmoGpBKSqYBb9ZbFskwpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecoJDnHH5gM+tmiiWFi/gQ+rudu070GNS0AJvPbJsJsqkejmVLyC/VRoTQn97ejPV54ron2jeniBWmVYOkL5iy1T8kNdyeqPPqDsi/LD3/5hDIYECc6zX+o9Q/EYrloxMpAQrmmM47iGBIFD6hQFu1lGVv6RbowHFptCzY+xhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jItWNOR+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539ee1acb86so5271225e87.0;
        Tue, 29 Oct 2024 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730197575; x=1730802375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjBBOufzswfPzjN88tjgJvguTz0vPy0qYODLjS59384=;
        b=jItWNOR+FKzVba11XweyajLnQsz8biBgodGWMmTaNzFad8D+Dt4mVRDCwC/DGPgpDs
         NiFSI5QwpXFWUYAICEGGFiqIZbITZERP6oTeU1f1P/voQio/MzgXCQIn1u56SXG2HoS0
         r2LB5Ln9YajHGIM94JOb83Hscy4O3krB/qxjF/0Cbv+KlmhlQcdWVQf1hUg+bp2IBVp3
         wTjma/sHm2Gg8lREyRwWD5krHX/Tg6gBbXlydycRBZNYWE3Zv8IMCbsytbqMwCE6rlXR
         p09Jfbv5LqJiOUSdawSY9b22tIB6D1vK0E7KJecp4OgsOcaFuzauMff9XNdVa8SJeuiK
         mo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730197575; x=1730802375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjBBOufzswfPzjN88tjgJvguTz0vPy0qYODLjS59384=;
        b=Vtw6zj8mcNb3oLP37qp6E84jx7TKS0WEw65sd5UUdm1krpW8ueY2/wjSz2ToT3fVke
         ULGvZx5p5YaQd8klngD6pLD1w6Jg70Us6gk7M5rsN+xEX2ZldU62Pa9Q58EoVr+Xi0Ua
         oHeF3xYypz1DmZQCUr1oW0eYyLtk65XdYrQcdDL2iB5avQ8ZS62xbEufr7EjrX+Dyenj
         OydQBv2v5L/kdw25KICxlYBnP6tVzimitEHwSiBLXC3bW2Dy85Ahx2QTDdQyiCT30Vmh
         vOLqaTeS+vtXwG23J+JjAgNHjGrc0AtbGHTHcvETI2VqKAXR6VvCIC8VvuhMAalBeuyD
         efAA==
X-Forwarded-Encrypted: i=1; AJvYcCVcsXzRbef1xDqRSth6X1sr9EmmCYbWmdkGf8+kXQsDeTE77HmzwCsmERl1kYYWocnUv+K5UHNBF01o@vger.kernel.org, AJvYcCXbF79fPIYMolJntxKWU2eh7MYwipbTglgLuWYbYYrCGb4z8qZu1oAYRLmZTqTlIDY1VBt3ABiGvEdutO/H@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Y6OWH2Qipd9IIVWRRQLy59RnN7sZEkYc5SHrb6vYyliy3T6v
	2z3TluMHt3K2sCD+XRAsFflQnBkOjs6abSYmg3ROyVscN2TXKV4p
X-Google-Smtp-Source: AGHT+IFSaVE8Bb2ztypg1vV5TPaMkpmoxaGxHP7ZN6Sh+HLWct1YR8ykARX3BL3Ag/JAqyp24gXrDw==
X-Received: by 2002:ac2:4bc5:0:b0:539:8bde:eb90 with SMTP id 2adb3069b0e04-53b348deb87mr5516093e87.32.1730197575158;
        Tue, 29 Oct 2024 03:26:15 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a670sm1323272e87.20.2024.10.29.03.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 03:26:13 -0700 (PDT)
Message-ID: <6dcd724a-a55c-4cba-a45b-21e76b1973b0@gmail.com>
Date: Tue, 29 Oct 2024 12:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: dts: imx: Add devicetree for Kobo Clara 2E
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, imx@lists.linux.dev,
 sre@kernel.org
References: <20241024142206.411336-1-andreas@kemnade.info>
 <20241024142206.411336-3-andreas@kemnade.info>
 <f2bb661d-8ef5-43d4-aece-c7fec01ff9fe@gmail.com>
 <20241029094402.382594c5@akair>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241029094402.382594c5@akair>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 10:44, Andreas Kemnade wrote:
> Am Tue, 29 Oct 2024 09:53:33 +0200
> schrieb Matti Vaittinen <mazziesaccount@gmail.com>:
> 
>> On 24/10/2024 17:22, Andreas Kemnade wrote:
>>> Adds a devicetree for the Kobo Clara 2E Ebook reader. It is based
>>> on boards marked with "37NB-E60K2M+4A2" or "37NB-E60K2M+4B0". It is
>>> equipped with an i.MX6SLL SoC.
>>>
>>> Expected to work:
>>>     - Buttons
>>>     - Wifi
>>>     - Bluetooth
>>>       (if Wifi is initialized first, driver does not handle
>>> regulators yet)
>>>     - LED
>>>     - uSD
>>>     - USB
>>>     - RTC
>>>     - Touchscreen
>>>
>>> Add human-readable comments for devices without mainlined driver and
>>> binding. Such comments can e.g. be help to find testers if someone
>>> starts to work on the missing drivers.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>
>> ...
>>
>>> +
>>> +	pmic@4b {
>>> +		compatible = "rohm,bd71879", "rohm,bd71828";
>>> +		reg = <0x4b>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pinctrl_bd71828>;
>>> +
>>> +		interrupt-parent = <&gpio4>;
>>> +		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
>>> +		system-power-controller;
>>> +
>>> +		clocks = <&clks 0>;
>>> +		#clock-cells = <0>;
>>> +		clock-output-names = "bd71828-32k-out";
>>> +
>>> +		gpio-controller;
>>> +		#gpio-cells = <2>;
>>> +		gpio-reserved-ranges = <0 1>, <2 1>;
>>> +
>>> +		rohm,charger-sense-resistor-ohms = <30000000>;
>>
>> Well, now that I got this out - I suppose this could be
>> rohm,charger-sense-resistor-milli-ohms = <30>;
>> or
>> rohm,charger-sense-resistor-micro-ohms = <30000>;
>>
>> I further guess there is no upstreamn binding doc for this property.
> 
> The binding doc is upstream. So an impressive amount of maintainers
> had a look at it...

Oh. So I have upstreamed it at some point... I suppose there is no users 
though.

> Well, everyone seem to entrust Rohm Semiconductors to do magic...
> wonderful reputation.

:)

> So how to proceed? As this property is not required, I can simply
> remove it and add a comment.

I would like to suggest adding:
rohm,charger-sense-resistor-milli-ohms = <30>;

and a binding with minimum 1 and maximum 50. Those should be sane enough 
limits. At the same time the 'rohm,charger-sense-resistor-ohms' could 
probably be deprecated.

This, however, is an extra mile for you. So, if you don't feel like 
doing it, then dropping the entry is Ok as well.

> 
>> I think there is also no upstream charger driver for the
>> BD71828/BD71879 - only an early RFC and some downstream mess - but
>> stil it'd be nice to have the property in place as the size of the
>> sense resistor is needed when converting coulomb counter register
>> values to current.
>>
> What are you upstreaming plans here? For all:
> I rebased the charger stuff to v6.11 on
> https://github.com/akemnade/linux branch kobo/power-6.11

Excellent question.

The reason why this driver is not upstream is that (as far as I know) 
the PMIC variants supported by the driver have always been tailored for 
a specific customer's needs. I don't think these PMICs have been sold 
for anyone else besides the specific customers. Hence, there has been 
little benefit for creating an upstream driver.

For the charger there has been additional complexity because the 
bd71827-charger driver implements also an in-kernel battery fuel gauge 
which computes the SOC values and sends them to the user-space. Like you 
know, this is very battery specific and requires correct battery 
parameters to be given.

I think your work changes things a bit. Seems we will be having an 
upstream board (kobo) using the PMIC drivers - and it might also use 
some information from the charger block. I know you also implemented 
some control logic to get the charging working with limited power-supplies.

(I think the BD71815 is also used in some projects which wanted to have 
upstream drivers - but I haven't seen upstream dts using it).

Furthermore, we still seem to be having new variants - I am right now 
writing drivers for another customer specific PMIC using somewhat 
similar charging logic. Having upstream driver would help in work like 
that. (By the way, I took your rebased kobo patches and continued my 
work on top of those - so thanks for the rebasing!)

So - in my opinion, upstreaming would be beneficial and I will push for 
this direction - but it will be slow process.

Also, I think that maybe the downstream driver shouldn't be upstreamed 
as such. I am not 100% convinced the SOC should be computed in-kernel. 
It'd might be easier to implement the SOC computation in a user-space 
library which just gets the details from the kernel. On the other hand, 
I think the driver should support a few currently unsupported features 
like setting the currents for different charge phases based on 
device-tree properties.

Giving I am the only guy at ROHM working on these Linux drivers (and not 
only these drivers), and knowing I don't have a system which is equipped 
with a real battery - I wouldn't hold my breath waiting :(

Yours,
	-- Matti

> Regards,
> Andreas


