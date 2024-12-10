Return-Path: <linux-kernel+bounces-439205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9D9EAC33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859911882D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B95223E7E;
	Tue, 10 Dec 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Brkr8lCH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D0223E65
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823040; cv=none; b=EOwW5rsVLMYWqitGKyCkiJx54F2m2cuSxPg55ow8fYljZYg52yz1T7Sd94B13Vl17YQ8c/SHY+e9OYwI3Ch5VYsn+lT83KWVb3YGHLDNVvKGoOFrPGt01wdqKpYRqMxl9CgqdFT0ndWaokSLh4SFiD2iOpUsWvUSTriNBinsl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823040; c=relaxed/simple;
	bh=1aVr7WaW7AVrtBKAZNTFli8yAA/tY65kHXeKnnM9i4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3L1XjMy8tsiQ4DvcDGlgom68pm1Rn4VarMDo5jwPJOhvoo74/TobqcbP6Vb6bj/l/0XYBDmW7PJjO29pThGIA+Hd2W7lG/NfS2ox04SGrUjuNnAhkZWHIdMT3AHZjYd4KlCUQbDtOjC1YTsoBhgpcc8VPRUMrzf/9aHlOyk9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Brkr8lCH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2162c0f6a39so23925035ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1733823038; x=1734427838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuEZCnX1zEs0QfMkkvDGMJQ3l6/xzWh86h1XJKAeYKw=;
        b=Brkr8lCHAdlSIw62+Ge7CmB30Ibt5mcJaLTLBvgPzJRd9q8D9f4HQUAhYaoHo+VTrg
         t9tf8YOKUWl0vLTUVsVtnTlHx5OalJT7e6iRS1kOTzM7N0UMmRjrm/dj9CoyF8395OYj
         +FK9vLTKt1WSJczSST64xKYQDuz3/ctfTxEI1ZkpHjHr7EOb3c8iPP/QG1wnzRUukbRx
         avVWa3lLwSk0v+pyD/e+vq3iYYjuBNHqiLNi+MJObd9diW9gcA646M+XL+TFSVKaCODa
         HHbCie4knXxEpsvHw5hPTbB4QQqqB7bWS6J9N9oj4rT8s4wU3zywoGv7qXyOcCjmEcRk
         oDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823038; x=1734427838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuEZCnX1zEs0QfMkkvDGMJQ3l6/xzWh86h1XJKAeYKw=;
        b=qxQWXMGKFjiITaIzhCPruOrQOE3C3Sw8B4PtFiLKR/e0pNBoulPtQNHK4jvlxyviL1
         BvP7uSSg4+wQkUWgfbSWU5Hk1tQL94eNZaWw1aLNVwAqoFI/qFr1gjHP8FeDVsK1SvpM
         DpckBp+EOLfQf9kYWuyP3VtAheWKLHD7762m3nVVJ96O3mXJVN5Uu9kOrBXUhDB4esVE
         ogwMaH6ZLHEzAsT5Pop3clg5xKCo1Z2QsFi0g9t4rAwP8lBQWy9/yxdrSdOYVkUHz10S
         oSFXtT9SDjlGo6M70Y6HPAGkmJOL4+GY2sZ40sfebnCnrKELsPeQ0t1qq9qiW9ujnsDV
         5jnA==
X-Forwarded-Encrypted: i=1; AJvYcCVg0mRzC2cMKdSe+cuAt6ImA88cBOxtCafAK6t8IbsMng4LgF0ivdPvJjQ4sl3UeoWLh/rkYuSY0kXRnHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhc55Tu4ll0lY6zZM8hr8Be+VQG7KJcU0amMwW/e8tpxudSZf
	JIiPil3RrqonJphunUWCM/I91511C72L42OwUzQtxy6Ua2TI+ec0DLZQ88W5hA==
X-Gm-Gg: ASbGncvEAF16a6SeZ+SYEG/ayrHusCDWNWZCU8Ijj+xMGVf5o+BH+TEKkRG2lfyljdb
	5VjkPWq7pYzZWDcK1osqfZjdTb+f1QK8A4ExZh/mnoIW7cB+vmhVs+rVTzIXQOySe9vyxPeu111
	Zm90m4nfYOFl6pO9q/1I9IXBhWl4qxI4RlzcnrQt5w3QfYRGgnRoECopE4GWPg8AoOJglo1YwLP
	6gWl5Ik6WBEKgK/JyKG5qU7ntd6h4KQunK/6jSkkGeP9mWKDWqz/Gbdm0yeUtVuiQfe80o2RTN6
	XRsnsrxK/jISmEgombrRaOKtsEMN
X-Google-Smtp-Source: AGHT+IE858bZAFY6Ni69IFrDeupoKpXueWLb4hZQwH6yg9nnfK7H5B1GEU6qzvoDGVqnyhqXO4YLTQ==
X-Received: by 2002:a17:902:d2c7:b0:215:58be:334e with SMTP id d9443c01a7336-21670a06c6fmr38959545ad.10.1733823037913;
        Tue, 10 Dec 2024 01:30:37 -0800 (PST)
Received: from ?IPV6:2401:4900:4451:8982:a0c3:dcc6:3a8d:184? ([2401:4900:4451:8982:a0c3:dcc6:3a8d:184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216634dd69esm23001735ad.40.2024.12.10.01.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:30:37 -0800 (PST)
Message-ID: <bea47f98-30ed-47d1-a1a2-0b56d4133bad@beagleboard.org>
Date: Tue, 10 Dec 2024 15:00:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
To: Andrew Davis <afd@ti.com>, Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
 <5889e0aa-15f9-41fe-9d80-ec59fee2f62b@ti.com>
 <20241209180320.30fc0da6@bootlin.com>
 <2912af91-6012-4e6a-9439-737e319b7724@ti.com>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <2912af91-6012-4e6a-9439-737e319b7724@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/24 23:17, Andrew Davis wrote:
> On 12/9/24 11:03 AM, Herve Codina wrote:
>> On Mon, 9 Dec 2024 10:47:50 -0600
>> Andrew Davis <afd@ti.com> wrote:
>>
>>> On 12/9/24 9:18 AM, Herve Codina wrote:
>>>> Hi,
>>>>
>>>> At Linux Plumbers Conference 2024, we (me and Luca Ceresolli) talked
>>>> about issues we have with runtime hotplug on non-discoverable busses
>>>> with device tree overlays [1].
>>>>
>>>> On our system, a base board has a connector and addon boards can be
>>>> connected to this connector. Both boards are described using device
>>>> tree. The base board is described by a base device tree and addon 
>>>> boards
>>>> are describe by overlays device tree. More details can be found at [2].
>>>>
>>>> This kind of use case can be found also on:
>>>>     - Grove Sunlight Sensor [3]
>>>>     - mikroBUS [4]
>>>>
>>>> One of the issue we were facing on was referencing resources available
>>>> on the base board device tree from the addon overlay device tree.
>>>>
>>>> Using a nexus node [5] helps decoupling resources and avoid the
>>>> knowledge of the full base board from the overlay. Indeed, with nexus
>>>> node, the overlay need to know only about the nexus node itself.
>>>>
>>>> For instance, suppose a connector where a GPIO is connected at PinA. On
>>>> the base board this GPIO is connected to the GPIO 12 of the SoC GPIO
>>>> controller.
>>>>
>>>> The base board can describe this GPIO using a nexus node:
>>>>       soc_gpio: gpio-controller {
>>>>         #gpio-cells = <2>;
>>>>       };
>>>>
>>>>       connector1: connector1 {
>>>>           /*
>>>>            * Nexus node for the GPIO available on the connector.
>>>>            * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC 
>>>> gpio
>>>>            * controller
>>>>            */
>>>>           #gpio-cells = <2>;
>>>>           gpio-map = <0 0 &soc_gpio 12 0>;
>>>>           gpio-map-mask = <0xf 0x0>;
>>>>           gpio-map-pass-thru = <0x0 0xf>;
>>>>       };
>>>>
>>>> The connector pin A GPIO can be referenced using:
>>>>     <&connector1 0 GPIO_ACTIVE_HIGH>
>>>>
>>>> This implies that the overlay needs to know about exact label that
>>>> references the connector. This label can be different on a different
>>>> board and so applying the overlay could failed even if it is used to
>>>> describe the exact same addon board. Further more, a given base board
>>>> can have several connectors where the exact same addon board can be
>>>> connected. In that case, the same overlay cannot be used on both
>>>> connector. Indeed, the connector labels have to be different.
>>>>
>>>> The export-symbols node introduced by this current series solves this
>>>> issue.
>>>>
>>>> The idea of export-symbols is to have something similar to the global
>>>> __symbols__ node but local to a specific node. Symbols listed in this
>>>> export-symbols are local and visible only when an overlay is applied on
>>>> a node having an export-symbols subnode.
>>>>
>>>> Using export-symbols, our example becomes:
>>>>       soc_gpio: gpio-controller {
>>>>         #gpio-cells = <2>;
>>>>       };
>>>>
>>>>       connector1: connector1 {
>>>>           /*
>>>>            * Nexus node for the GPIO available on the connector.
>>>>            * GPIO 0 (Pin A GPIO) is connected to GPIO 12 of the SoC 
>>>> gpio
>>>>            * controller
>>>>            */
>>>>           #gpio-cells = <2>;
>>>>           gpio-map = <0 0 &soc_gpio 12 0>;
>>>>           gpio-map-mask = <0xf 0x0>;
>>>>           gpio-map-pass-thru = <0x0 0xf>;
>>>>
>>>>           export-symbols {
>>>>             connector = <&connector1>;
>>>>           };
>>>>       };
>>>>
>>>> With that export-symbols node, an overlay applied on connector1 node 
>>>> can
>>>> have the symbol named 'connector' resolved to connector1. Indeed, the
>>>> export-symbols node available at connector1 node is used when the
>>>> overlay is applied. If the overlay has an unresolved 'connector' 
>>>> symbol,
>>>> it will be resolved to connector1 thanks to export-symbols.
>>>>
>>>> Our overlay using the nexus node can contains:
>>>>      node {
>>>>         foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
>>>>      };
>>>> It used the GPIO 0 from the connector it is applied on.
>>>>
>>>> A board with two connectors can be described with:
>>>>       connector1: connector1 {
>>>>           ...
>>>>           export-symbols {
>>>>             connector = <&connector1>;
>>>>           };
>>>>       };
>>>>
>>>>       connector2: connector2 {
>>>>           ...
>>>>           export-symbols {
>>>>             connector = <&connector2>;
>>>>           };
>>>>       };
>>>>
>>>> In that case, the same overlay with unresolved 'connector' symbol 
>>>> can be
>>>> applied on both connectors and the correct symbol resolution 
>>>> (connector1
>>>> or connector2) will be done.
>>>
>>> I might be missing something, but how is the correct connector 
>>> (connector1
>>> or connector2) selected? Let's say I connect my addon board to 
>>> connector2,
>>> then I apply the addon board's overlay to the base DTB. What connector
>>> just got referenced?
>>>
>>
>> A driver for the connector is needed.
>> The driver applies the overlay using of_overlay_fdt_apply().
>> The node the overlay has to be applied to is passed by the driver to
>> of_overlay_fdt_apply().
>>
> 
> So every connector needs a driver? Most connectors are dumb connectors,
> just a bunch of wires broken out to a header.
> 
> What if an addon board overlay uses multiple connectors?
> 
> If you need a connector-specific driver, and that driver needs to know
> which node this overlay will be applied to, then why not just do a
> fixup directly to the overlay in the driver?
> 
> Andrew

Well, even in the symbols based approach, a driver is needed since stuff 
like nexus nodes does need a dummy driver (else the device enters 
deferred probing). So it is not a big deal.

> 
>> Even if obsolete because I added one more parameter (export_symbols_name)
>> in of_overlay_fdt_apply() in this current series, you can have a look 
>> at the
>> following patch to see the connector driver:
>>    https://lore.kernel.org/lkml/20240917-hotplug-drm-bridge-v4-8- 
>> bc4dfee61be6@bootlin.com/
>>
>> Best regards,
>> Hervé
>>

Ayush Singh

