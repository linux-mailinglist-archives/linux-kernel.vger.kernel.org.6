Return-Path: <linux-kernel+bounces-562338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E64A62380
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1735420B53
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E54FC1D;
	Sat, 15 Mar 2025 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00AEhJey"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A14C8E0
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742000202; cv=none; b=Tk73tYF+e99pX/8brHyA85zenM90fZ4QUGvvh+cgltQPnKWr4K7mbbovxLbyxANPfgB83caZ9slwEXMpp5/6tANVx2kslbFJEzS0Vkn8lc2PdlSqkOHIp5/ckxfJu8d7Hp+rSZv0IuftJBTADo7NkzKsahSgOsl22hOMGKw5Zs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742000202; c=relaxed/simple;
	bh=dFv//A/N53hUD/dKk0EKx9Sd5ho6SwDR5GWOeJGznwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaftdHRZ4UptqsG/dmShXKxfF363FbR36f3GW/IeQJS9vfIX2swyfxGJEZ6FnFm5Nfuxt2KZqXiesKTtK5uVCAXHTbohge9Al0XWQkgqJe20twMsJsDhOxpYK03th7MAqXcFPujXHNy65MXcrxK+bf5LSj0KgWqqbjorDkvU0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00AEhJey; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22548a28d0cso76838025ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742000200; x=1742605000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlPzh6p1/5lGDsISw1+G4tFXT2WVaPLY/RSip+CLZfo=;
        b=00AEhJeyHoC7TUYh0Es8UhYq8q/4iGYgJSXNWRgqPBTcNiAKtibh5POQA35s/4Xqcj
         NKe703McvRb69PzQbFBJhfsu7LkfGBI7ibXbBtfb1QN4k05wz6SqNMyklkqRD8Wsn/il
         CGrJdnAVXBE1OvBSzC6GkLSl4KB0RKaTs60+p8eCXpFKkM9+g78pMf73aCxnkaJ4VEAO
         knpqzaw3NMNcdbAEIQr7wmRPqptGaSn9ZJfpTIOBORK/euDt7SBp+OQpuXLxr6hDTmiz
         A3oTZT/y5R6WlEgq7krBNkIeGVLMOy9PzQjbfTsQRUxI0X6lmflPO1VqPKzherZpjJpq
         CY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742000200; x=1742605000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlPzh6p1/5lGDsISw1+G4tFXT2WVaPLY/RSip+CLZfo=;
        b=qxEzGyFGqcBUcTcBk5LqjELBbTFTDNKlwPAxan0aGwIIpvfhg2Nr3quxZi5HLz8Srk
         GvyAwdenmfl4xJyZ4c2mBhucsJTGo6HkTJJ5jSSrd0V2DzDU3kWFJoRlPveohV5OADyN
         xsm8ZfDz29t04x1VrGKrHX0/pmLOr7jsAwQvdO52KTJ6scExodX0vnhRJPDOyX4SgeS8
         i49IRSNNCSd5ZCNtG3OFDYU4xyMeKv0y022NxGTXG1XWFUwdBtOWL4ativaeQLaP5wip
         +1ST3d9IjJ6d0XpvdWdjB0ob0gNDI2PD/gS+L6gkpbT2Nj7enwLOll/IUFphe7oBw0/h
         LSOw==
X-Forwarded-Encrypted: i=1; AJvYcCWeex0cR4uNKIOyFYLY44y7A+jtD4+onNXoALYrJbQPHuFUdfBN3F0cEGDjrped8Own+pwLfmBVbU0BzjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3EJ/GXmjwaIi6wWt1FZ6UQ53vPjwyDP+Z5u9jygsFfos0rgt
	aReAR4zMzzNCd4D+GV4J9IFuBR5r7G3O9VYjDYsB0Agvx8MSPUyz1pvsOG5GkQ==
X-Gm-Gg: ASbGncvV3SNoGuJOcaPVc9aPFIG+iqQqoD6NgQp6gZsKwUfc/LaFhSNY1HCM6qWMBkl
	CUuzilUNOmyQpJkM2F2F3JhSDZzcy4ttgs8isVVhpWS7mZC4fMhlaEm05qqp2W4dp4OP+H56w6+
	8rckWUBGzAftQGoklaYZKajo2XbQINapEUeeZXgbwBl1N9SVtqSCgyibXT7BXsuj/FXYKWb4UgO
	DfVF70SISOLFT/oxKEt8R60PoVQBpMBhhihB/pDpuUxICb9RPLXiwGftPxKzS5YDWUhLAgjL+mY
	crRuTokiAEtWX2WYxS6hTk3s8H0C/oe4iBXjt1jfJIz5jUT9eInefi3YVV8S2PKB0EHmdeD/68t
	90J2qnfoVCbzRcODTX4g77Ha1Q4NzO/FfRx9DmiVA+Vs=
X-Google-Smtp-Source: AGHT+IGLAZyr9y6XFIkao+qhVXq299qSBu0NyjP0SxDe+I/hBmyjWfLdod7q25DFZQQHCPjxfpF0Vg==
X-Received: by 2002:a17:902:ecc5:b0:223:f7ec:f834 with SMTP id d9443c01a7336-225e0a840camr50486775ad.31.1742000199456;
        Fri, 14 Mar 2025 17:56:39 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:1790:6e62:92ba:cb2b? ([2a00:79e0:2e14:7:1790:6e62:92ba:cb2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883d0sm34730585ad.10.2025.03.14.17.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 17:56:39 -0700 (PDT)
Message-ID: <85c6de6a-f8b4-4e4e-8fa2-da53816abc89@google.com>
Date: Fri, 14 Mar 2025 17:56:37 -0700
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
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20250313-tidy-kakapo-of-abundance-eebf91@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 3/13/25 1:48 AM, Krzysztof Kozlowski wrote:
> On Wed, Mar 12, 2025 at 04:42:01PM -0700, Amit Sunil Dhamne wrote:
>> Add a new "fixed-batteries" DT property to connector class. This
>> property is populated with nodes associated with battery type power
>> supplies powering the USB PD connector. This is needed by the Type-C
>> Port Manager (TCPM) to query psy properties which are used to feed
> What is "psy" in terms of bindings?
In terms of bindings this should be a phandle to a device that 
owns/manages the battery (whose driver will eventually call 
devm_power_supply_register to register the battery). This could be a 
fuel-guage ("sprd,sc2731-fgu", say), charger ("ti,bq24190") or a 
platform device ("cw2015") containing "monitored-battery" property to 
manage the simple battery.
>> Battery_Status & Battery_Capacity AMS.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 8 ++++++++
>>   Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..5e15bc060f5a2cfce842f83de738f1e8bae3ce2d 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -300,6 +300,14 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/uint8-array
>>       maxItems: 4
>>   
>> +  fixed-batteries:
>> +    description: Contains references to nodes associated with battery type power
>> +      supplies powering the USB PD device. These batteries are fixed type and
> What is a "battery type power supply"? If you just link here batteries,
> then we have type for it - monitored-battery - but I doubt connector has
> direct connection to the battery.
Regarding "nodes associated with battery type power supplies", I meant 
something like a fuel guage or a charger OR platform device with 
"monitored-battery" that will manage the battery lifecycle. If I use 
monitored-battery for this, I will be restricted to only querying 1 
simple battery. Also, I don't mean PD connector device to be a fuel 
guage or charger that manages a specific battery. It should just be able 
to query any FG/Chg for the battery status to relay that info to the 
connector's port partner.

The intent of the patchset & this change is for the USB Type C protocol 
manager module (that consumes these bindings) to be able to get info 
(such as State of charge, design capacity, etc) from drivers that manage 
the battery/batteries in the system. In order for such info to propagate 
I need to hook up the references of these battery manager devices (fuel 
guages, etc.) to connector.

I have addressed the connector <-> battery question in the cover letter.


> If you mean chargers, the OF graph is already there for this and no need
> for this patch.

No I don't mean just chargers in this case. Also, I didn't follow you on 
the OF graph. Please can you explain further?


>
>> +      not hot swappable.
>> +    minItems: 1
>> +    maxItems: 4
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
>>   dependencies:
>>     sink-vdos-v1: [ sink-vdos ]
>>     sink-vdos: [ sink-vdos-v1 ]
>> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> index 3de4dc40b79192b60443421b557bd2fb18683bf7..66c99f0131f074f1c08e31d7481f555647e3b2f8 100644
>> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
>> @@ -75,6 +75,7 @@ examples:
>>                                          PDO_FIXED(9000, 2000, 0)>;
>>                   sink-bc12-completion-time-ms = <500>;
>>                   pd-revision = /bits/ 8 <0x03 0x01 0x01 0x08>;
>> +                fixed-batteries = <&batt1 &batt2>;
> Two phandles, so two <>.

Ack. Will fix it in the next revision.

Thanks,

Amit

> Best regards,
> Krzysztof
>

