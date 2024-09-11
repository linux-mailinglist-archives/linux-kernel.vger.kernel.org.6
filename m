Return-Path: <linux-kernel+bounces-325451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E19759D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614FE1F2417F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A81B5304;
	Wed, 11 Sep 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="muBJwXlh"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AD1B791A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077615; cv=none; b=qTD+iheZgsucGTSYnhE9R4wlyml1FRM2q8t0zhiUZfNIJGT8e916ltkCgNOWz/W1o2kN2q3eHumdmGTOizeW0C8Qx9W5ChMFDKb1Q6xktK323wOBq/iPcGEf6zPVNML51eSuVkSbkCgUMpGUA4SWUpP9l6QAPoxrA9rGVyQdARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077615; c=relaxed/simple;
	bh=WNpg1zAsY1hWYJWrTK0CWSeHviozREIE1okw8+oxAQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tD/e74psVvDBfxsIOS09DOID68fj+6O5SePKGgpWiiAnw6HsXFt055dCkHEXZHqfVTtCrtT0JBXLTFPrSGCSQFr1biE/ONpDwfi+QIEjRmrmG+TUj7vHnZGzrXgf75gySTtz42jmm+PNfcrZl0K/x/9u0SEKGWGAHbqLa6RqQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=muBJwXlh; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20570b42f24so1667205ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726077613; x=1726682413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oi1ycBl7Zo/pcrvjxctEWR3H8TSj6fTGuiJIc535U80=;
        b=muBJwXlhtQE5JCbuSckZ9FC9J3ufvxylQzBme8UcBKwPaLmdIFnoSddqJ5V6AjN+jv
         eep2BIZ23KPav/7IUBVLdP+TQ+5hCHvJTta515ofPn/1IwcAhrEd8hR9ijHdqo1GVSuZ
         qWmrdIfarysNcBYPJmxuS3G480xFcq4YTMsgnunyvOu0dGJPXQA8gWdnZssrcEeg1OB/
         6VAc6DKsLvn8vBInnLsWo5ZcSYdLLhR/kVxH7KOedvYGvs5u2XqlgKg6AK5XtLDu+uwS
         8+lSwpRhn4/posiwIghgIPAz8lCwPvhs15efhZEPr6YyH0qRc0q7XEG3j/EIfvTIUCs7
         mG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726077613; x=1726682413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oi1ycBl7Zo/pcrvjxctEWR3H8TSj6fTGuiJIc535U80=;
        b=sAOs53IuevnSXPIVI7x8hHsnmflXbYj+W5tHB3u02+LhgAmy/YIh29S0nj46FzcVye
         /j6TL/7K0rDrN9CDd2bpcR677Xg6EIroQxV2yTWbDdbqGMTLqR80ejN4/YKQ3orT0ksH
         kT+SFlGyXbqi/DIaZ4p5VnwqoZ+8tbJf7XdkV4ReNBTogsaAtNbJk6ELnAQjN75Fp9aG
         2/xHfDjbMyKotOHxqJJSVrpc51u56fOhg+do+ZdDf1LffDHZfNeBq06siH468hbSXsu2
         2liGtezbh1sejYA/y7YX4A7DJGSfiIezNAZBeOp6iUBuOYGa7D1QkxWX28u/kVrMAc72
         J2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Zk/2tFIfiT0B+Xbz9mV08WUItH+WhI+jJBw2CFybekQEpfI1AlCFtA+Rqla3dHjw6fo+iEI5KeaUo18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQmbDr+ZTiF/gacUJWHi1VM5EkQ6zJwn2r2Ga3uxhgAQOcnqW
	rPiLXrA/l2quKm4rmMcdn/2ea/5mJp83QfAdl7R1DSYeAm+o1kYYcLdAUNDu6w==
X-Google-Smtp-Source: AGHT+IGHMbSQUJFzu4dp7JtqdcyOhvxEYRG1Urbc0wxUZecfk89IK2jJJvDZYYh7dccxukx7Xnx2Jg==
X-Received: by 2002:a17:903:41c3:b0:207:1de9:1014 with SMTP id d9443c01a7336-2076e38f304mr3245735ad.34.1726077611683;
        Wed, 11 Sep 2024 11:00:11 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afec4fdsm2268195ad.228.2024.09.11.11.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:00:11 -0700 (PDT)
Message-ID: <45b1894b-0a15-4efc-95a0-596aa6728fd7@beagleboard.org>
Date: Wed, 11 Sep 2024 23:30:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: connector: Add MikorBUS connector
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-2-3ded4dc879e7@beagleboard.org>
 <20240911172626.GB915638-robh@kernel.org>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20240911172626.GB915638-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 22:56, Rob Herring wrote:

> On Wed, Sep 11, 2024 at 07:57:19PM +0530, Ayush Singh wrote:
>> Add DT bindings for mikroBUS interface. MikroBUS [0] is an open standard
>> developed by MikroElektronika for connecting add-on boards to
>> microcontrollers or microprocessors.
> Typo in the subject...
>
> Isn't this v6? Where's the revision history?

Well, at this point, it almost has nothing in common with [0] (the 
previous patch series was about making mikroBUS a Linux bus) and is more 
of a continuation of [1]. So I thought it would be better to treat it as 
a new patch series.

>> MikroBUS connector node will optionally act as nexus nodes for routing
>> GPIOs and PWM.
>>
>> For GPIOs, the following pin numbering should be followed:
>>
>>    0: PWM
>>    1: INT
>>    2: RX
>>    3: TX
>>    4: SCL
>>    5: SDA
>>    6: MOSI
>>    7: MISO
>>    8: SCK
>>    9: CS
>>    10: RST
>>    11: AN
>>
>> For PWM, the PWM pin should be on channel 0.
>>
>> I am not quite sure how to deal with the nexus node properties
>> (#gpio-cells, gpio-map, gpio-map-mask, gpio-map-pass-thru) since they
>> seem to conflict with upstream gpio schema (gpio-controller is a
>> dependency of #gpio-cells).
>>
>> [0]: https://www.mikroe.com/
>>
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>>   .../bindings/connector/mikrobus-connector.yaml     | 40 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  5 +++
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>> new file mode 100644
>> index 000000000000..603e4627076c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +#
>> +# Copyright (c) Ayush Singh <ayush@beagleboard.org>
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: mikroBUS add-on board socket
>> +
>> +maintainers:
>> +  - Ayush Singh <ayush@beagleboard.org>
>> +
>> +properties:
>> +  compatible:
>> +    const: mikrobus-connector
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: true
> Cannot be true. You're schema must be complete. I don't understand what
> happened to everything else in the binding.


So the current dtschema makes `gpio-controller` dependency of 
`#gpio-cells` which should not hold true for nexus node [2]. I also 
wanted to understand if the nexus node schema should go in upstream 
dtschema or be in kernel tree.

I will try to figure out how nexus node properties should look by taking 
interrupt nexus node bindings as a starting point.


[0]: 
https://lore.kernel.org/linux-arm-kernel/20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org/

[1]: 
https://lore.kernel.org/linux-arm-kernel/20240702164403.29067-1-afd@ti.com/

[2]: 
https://devicetree-specification.readthedocs.io/en/v0.3/devicetree-basics.html#nexus-nodes-and-specifier-mapping


Ayush Singh


