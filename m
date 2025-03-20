Return-Path: <linux-kernel+bounces-570324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BAA6AEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9D53BD89D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B762288C3;
	Thu, 20 Mar 2025 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+qHwmxS"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6911E47C5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500155; cv=none; b=SWHkRHfPhgxzbS1EutNNtdqr1hogbMXIjC3VxsmOQ9jWMesF+Yy+oUY7U02XYugECXSdnq3fh1rtPx4l+/1/64eC6pdmFFtDqtdeD5RaYXlwYuvF1r+eyALHFaL51oassH6YoEam5Arb3PoK1gqANwWXmImsMSIkhyPLe4Z5TCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500155; c=relaxed/simple;
	bh=KFQpkAFiRwi5JvgaGkgUS3XMJL1ly4AUO7zYJrorCgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgY+/QJphbnWdsEs2unK7GmqRATmvHso0CGhzs++ftZRoU/pUjYq27r+1w47ZF4bEbA16ueXzhUUrQF7xlXTHIjoqiZ23YCvt4zkRLW10f738gGP3JSwDgzVSV9x6wqaSQqLtLM4ztDuzbbKtAcTf8CaVJC05j1+sme4dl6lxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+qHwmxS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso25748995ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742500154; x=1743104954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMRUp5Qyehm/UHkEF8vmSOmZ085ovglSkPUzMHQiUvE=;
        b=V+qHwmxSsRylMh683u3emKvxWHIoiCfzb0J94EAEEx6slNleLpoQOa0wGz8bnfQFiW
         533g0RUXQ+d02JJehu12OU3dPX5/BzcU0gOovi75YSPHGhuxRTbu0NEsR85EYRWYi6Gb
         s1tc4FRq32rncn5rnYyrIbij2DWdtAnqUIPixMhf7LkaViRD2+33exE2AbA6Xi8/6Rvp
         KAJvDrFVwEq/hfHb8FWHz1mwmwfPWLqejW86PsHBkCuR7sGB+0S40tJxX0FGILYhXCCQ
         BnQe+Opx0+bD3g3ip6zx8UsPdSc5L7/+mHDGVzk+z+H8m/EyGZISyB0kYOlWFGBCrHLO
         UT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500154; x=1743104954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMRUp5Qyehm/UHkEF8vmSOmZ085ovglSkPUzMHQiUvE=;
        b=vkHOQ5wC0JY2vRem6JGmAJtDJKG90AbDcIMbSYVyoalDBB4UcvjSlw1xg1azP+FACK
         GpNORqAw1ifc2rFIVjjYGGbDh4+ZnDhLRdk6Zry9uvng2BfGKNF0mZ/kiqR2YVOIwO7P
         l/i+HP4lT5+8shdsHg4vIwmRDnUyAojGE2QDcgJONmkbzzjByLYl3N4Av0IhvLvxJjfb
         iSFY/McE4VXf8Smn1/jrpwtQKt/7SEL2AG47c+BqGcfqXSbz/mhuExa3YlgW5tgu9B5y
         Dj1760uU0dQGEt4McTnrp7KkZqFDlGCHqGDCc57teVr8YnjL+Pi+Q532zi7SlxNCFXAs
         otdw==
X-Forwarded-Encrypted: i=1; AJvYcCVH5IxHYDbqk77xewS9LdmPnx78e3kiJ9Oh96+3Z1Ghijw7ZgkKDqc5I1Y+LDi1k/zj51FUGBT2TRUYGlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9KUv5Dgp8tTpx6jGbK2YsSEcpMXcCkR5Ktnh14FbEdJd1rLO5
	cPy7mlOJugcvCoLUSDkD3xZTe+6A1NGSZqghUTmw5UIOp72zGWKM17pK42sxHA==
X-Gm-Gg: ASbGncu24q7dzdcf11OB/uWjODcYEv71EdRjmUkIstdYZ4m/Bhe8enlLYi0voCN33iO
	ZbVMCXHhAS0xV4a9Puoiho9E4FTdkrdEjsxTu75dGVTTgatAYYCCOKERz+KRHumax5Nlin+ig8b
	VbJseCiqooN41zY0X8yYnGE66jnUN68tPJfSq3Np8c4rdZKc9UJcxuPgTfvOwGx/G/9ArSYXJmH
	kdZQ5kXcrCMT682UX9WrMmsGpgiTkcGqtePOTDuUD7/p4y2jUtFRF0KVaeqjEIhvXZ6DTC+o0+9
	6f5AynEM07DmP2G6ov6CW0PxtNg9GAfpyyhbM2ptC07SptozOEeBzAz5ctQVxABTGDN4qgOSzU2
	uUnHZI4NZb+MNH+crFbL19PSttV2wG16lDpg4MjlmyQY=
X-Google-Smtp-Source: AGHT+IHyrk2bDjkLhMnhglpF2WvxGIuU+CuD3iaUBnBbz39xc/6Rxc5vq7lRwV1BiFP3IbQR23VrGQ==
X-Received: by 2002:a05:6a00:4b12:b0:736:755b:8317 with SMTP id d2e1a72fcca58-73905a501e4mr1105162b3a.21.1742500153484;
        Thu, 20 Mar 2025 12:49:13 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:c50a:4138:6122:653a? ([2a00:79e0:2e14:7:c50a:4138:6122:653a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d1dasm210916b3a.106.2025.03.20.12.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:49:12 -0700 (PDT)
Message-ID: <747d9492-b3be-46b0-9e26-5ba45f2e6662@google.com>
Date: Thu, 20 Mar 2025 12:49:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: connector: add fixed-batteries property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Sebastian Reichel <sre@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
 <20250312-batt_ops-v1-1-88e0bb3129fd@google.com>
 <20250313-tidy-kakapo-of-abundance-eebf91@krzk-bin>
 <85c6de6a-f8b4-4e4e-8fa2-da53816abc89@google.com>
 <3a33dab7-87b2-4b74-b138-e368d4cbc358@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <3a33dab7-87b2-4b74-b138-e368d4cbc358@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 3/16/25 9:49 AM, Krzysztof Kozlowski wrote:
> On 15/03/2025 01:56, Amit Sunil Dhamne wrote:
>> Hi Krzysztof,
>>
>> On 3/13/25 1:48 AM, Krzysztof Kozlowski wrote:
>>> On Wed, Mar 12, 2025 at 04:42:01PM -0700, Amit Sunil Dhamne wrote:
>>>> Add a new "fixed-batteries" DT property to connector class. This
>>>> property is populated with nodes associated with battery type power
>>>> supplies powering the USB PD connector. This is needed by the Type-C
>>>> Port Manager (TCPM) to query psy properties which are used to feed
>>> What is "psy" in terms of bindings?
>> In terms of bindings this should be a phandle to a device that
>> owns/manages the battery (whose driver will eventually call
>> devm_power_supply_register to register the battery). This could be a
> So a charger? Please rephrain from putting Linux names into the bindings
> description.
Noted, thanks!
>> fuel-guage ("sprd,sc2731-fgu", say), charger ("ti,bq24190") or a
>> platform device ("cw2015") containing "monitored-battery" property to
>> manage the simple battery.
>
>>>> Battery_Status & Battery_Capacity AMS.
>>>>
>>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/connector/usb-connector.yaml | 8 ++++++++
>>>>    Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>>>>    2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..5e15bc060f5a2cfce842f83de738f1e8bae3ce2d 100644
>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>> @@ -300,6 +300,14 @@ properties:
>>>>        $ref: /schemas/types.yaml#/definitions/uint8-array
>>>>        maxItems: 4
>>>>    
>>>> +  fixed-batteries:
>>>> +    description: Contains references to nodes associated with battery type power
>>>> +      supplies powering the USB PD device. These batteries are fixed type and
>>> What is a "battery type power supply"? If you just link here batteries,
>>> then we have type for it - monitored-battery - but I doubt connector has
>>> direct connection to the battery.
>> Regarding "nodes associated with battery type power supplies", I meant
>> something like a fuel guage or a charger OR platform device with
>> "monitored-battery" that will manage the battery lifecycle. If I use
>> monitored-battery for this, I will be restricted to only querying 1
>> simple battery. Also, I don't mean PD connector device to be a fuel
>> guage or charger that manages a specific battery. It should just be able
>> to query any FG/Chg for the battery status to relay that info to the
>> connector's port partner.
>>
>> The intent of the patchset & this change is for the USB Type C protocol
>> manager module (that consumes these bindings) to be able to get info
> The intent should be rather to accurately describe hardware and maybe
> that's the problem - you focus how to bend it for your drivers.

Acknowledged!

Thanks,

Amit

>
>
> Best regards,
> Krzysztof

