Return-Path: <linux-kernel+bounces-285108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4C950972
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B4DB21CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DA1A0732;
	Tue, 13 Aug 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYYxFd6F"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348D2AF0D;
	Tue, 13 Aug 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564348; cv=none; b=u8sRCrKJpiXix9+Z7/HdwvVtzZyhIQ4voXRffHM746UrQ68o/DYo3KaVZYzDgmZ5lWXhC0g4juqJlzSbnd9RV/VP2mmmQF199SeFzzw2sPabAtMZKxdOMnNmDBzwST9LzntK5RN8pmRkxgsSAV6TGjgH6cVAzGJVZZ4d41/Xs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564348; c=relaxed/simple;
	bh=G51j+6mgixsrvrTEkFw6+wGXbpg01Kkx5ZnpqrwxpZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiWTEMa0rFN5ThmTJNv/l2thAmdiwjELwdEfpHTbGoXqtrnkh31MY4t2eyIepWSBfdcI6LDvfvwsZF4ARStIMLYRmu5R4tVypcoro+zCRTq3tcyv3khLtMwbf49PSxGsRFQI37wJLPGYtYdd1Eo9UnPaUYd2djxeBV/j8CE8HpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYYxFd6F; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70eae5896bcso5077133b3a.2;
        Tue, 13 Aug 2024 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564346; x=1724169146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yFY6eLVhFGsgfmIcw0L1TquWMQDeEJOfidswP04YC2c=;
        b=FYYxFd6F4S3B4sYKbpeekrdXX1dUF4o+N6bhhMURhit67QEH/9pR4qNk/99ITMWZM6
         cR3H41vLq5NhyTteeCjc+EqlVv6uDlkP4Z8I/e+W+KZJ/AFoMSnSMFwkmEtjMZbRu8Yk
         whWRjtC0mpCkCqItOygZhtT6rN2CEoEJ3w50ggQ4DnKjWf3x7vum0hOQ+8zVWqmZftcT
         qU/GqEs1KSTBrI5davVi38/w4LhgNVvYp1jmrKo4t9ZYTBtikVXoonUuDSRl3VkhUafY
         ESLaqWyEFfGQkDHyPJJQVCnvqzzuDn82wVy/kwx9D+ZfNKULvEVTnPP2GW5GScAI1ZWk
         OscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564346; x=1724169146;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFY6eLVhFGsgfmIcw0L1TquWMQDeEJOfidswP04YC2c=;
        b=FkJSw1jcfBk7N4m3y1FE6519ZGSnhRyR47eTPWEQxt01/uNH7a3uN96n/XM1WgmDiq
         m6zXqXj24QDfFTM40Nr6e/Fdv7WpCyeaQofLG440VSgcArqdH9NNtUfroo5QX4TbyV/O
         bKVwr2hIfZO9KfIv59ftH9SktiCEcih5g18SAOxKpteFSvCqd4n2Xwxm8VoBa7k0RE9r
         3qjqVrriiMsk0nIw+l2RPWTNT8T8m6BsVu+CztR7T3wQTGea52SwPJINwDwanpE9WRUL
         hamfjQ1/2hBrDPOISxvxd4rnpPxi6wbqGwoPqtq5IuPKjeGCyA4i1VF3+YNNym8EGqhZ
         IJ7w==
X-Forwarded-Encrypted: i=1; AJvYcCV+0E9ZSY3dvofPD/FF/nRr3jVP8/bI29blfDgRxOXinQH6wpuGTyMWHyiMBrKpI9DhoLQqgVH5+9l13nRyhwrbvbLbAXB3Dgoa9+jOwMdWrFo/nvO1jpgNYdY+BSusLk7gyTnpV+iVY79IN0JgUrK6eVJwjmy125H1C+EsNxGmy8C/NmJf
X-Gm-Message-State: AOJu0YzUZX4ngWK7QZvzsgmwImZ5vf7kkBgHTFa5sACuM6Tx8f59EEd0
	fNRXuSyXs71qHAcm3s3Oehm+q7LKWx394dEpreV0Gh5e/Lv51yd3
X-Google-Smtp-Source: AGHT+IErq0HKb41NmWWelk0AEt/7g6IKL/rQ2BIKehRQQCwE4wQnHSqUR6unWrjrfHbC3RtCIF/r6w==
X-Received: by 2002:a05:6a20:9f4f:b0:1c6:ed5e:24f with SMTP id adf61e73a8af0-1c8eae8dd84mr166176637.23.1723564345570;
        Tue, 13 Aug 2024 08:52:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979d3d58sm1638489a12.18.2024.08.13.08.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 08:52:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <10680d13-442d-4f12-a77c-2bd05f11dc10@roeck-us.net>
Date: Tue, 13 Aug 2024 08:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] dt-bindings: hwmon: Add maxim max31790
To: Conor Dooley <conor@kernel.org>,
 Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240813084152.25002-1-chanh@os.amperecomputing.com>
 <20240813084152.25002-2-chanh@os.amperecomputing.com>
 <20240813-sister-hamburger-586eff8b45fc@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240813-sister-hamburger-586eff8b45fc@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 08:33, Conor Dooley wrote:
> On Tue, Aug 13, 2024 at 08:41:52AM +0000, Chanh Nguyen wrote:
>> Add device tree bindings and an example for max31790 device.
>>
>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>> ---
>> Changes in v2:
>>   - Update filename of the maxim,max31790.yaml                        [Krzysztof]
>>   - Add the common fan schema to $ref                                 [Krzysztof]
>>   - Update the node name to "fan-controller" in maxim,max31790.yaml   [Krzysztof]
>>   - Drop "driver" in commit title                                     [Krzysztof]
>> Changes in v3:
>>   - Drop redundant "bindings" in commit title                         [Krzysztof]
>>   - Add the clocks and resets property in example                     [Krzysztof]
>>   - Add child node refer to fan-common.yaml                           [Krzysztof, Conor]
>> ---
>>   .../bindings/hwmon/maxim,max31790.yaml        | 81 +++++++++++++++++++
>>   1 file changed, 81 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
>> new file mode 100644
>> index 000000000000..d28a6373edd3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
>> @@ -0,0 +1,81 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: The Maxim MAX31790 Fan Controller
>> +
>> +maintainers:
>> +  - Guenter Roeck <linux@roeck-us.net>
> 
> Why Guenter and not you?
> 

Fine with me, actually. We don't expect individual driver maintainers
in the hardware monitoring subsystem, and this chip doesn't have an
explicit maintainer. Forcing people to act as maintainer for .yaml
files they submit can only result in fewer submissions. I prefer to be
listed as maintainer over having no devicetree bindings.

>> +
>> +description: >
>> +  The MAX31790 controls the speeds of up to six fans using six
>> +  independent PWM outputs. The desired fan speeds (or PWM duty cycles)
>> +  are written through the I2C interface.
>> +
>> +  Datasheets:
>> +    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
>> +
>> +properties:
>> +  compatible:
>> +    const: maxim,max31790
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 1
>> +
>> +patternProperties:
>> +  "^fan-[0-9]+$":
>> +    $ref: fan-common.yaml#
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      fan-controller@21 {
>> +        compatible = "maxim,max31790";
>> +        reg = <0x21>;
>> +        clocks = <&sys_clk>;
>> +        resets = <&reset 0>;
>> +      };
>> +    };
> 
> What does this example demonstrate? The one below seems useful, this one
> I don't quite understand - what's the point of a fan controller with no
> fans connected to it? What am I missing?
> 

Just guessing, but maybe this is supposed to reflect a system which only monitors fan
speeds but does not implement fan control.

Guenter

> Otherwise, this looks pretty good.
> 
> Cheers,
> Conor.
> 
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      pwm_provider: fan-controller@20 {
>> +        compatible = "maxim,max31790";
>> +        reg = <0x20>;
>> +        clocks = <&sys_clk>;
>> +        resets = <&reset 0>;
>> +        #pwm-cells = <1>;
>> +
>> +        fan-0 {
>> +          pwms = <&pwm_provider 1>;
>> +        };
>> +
>> +        fan-1 {
>> +          pwms = <&pwm_provider 2>;
>> +        };
>> +      };
>> +    };
>> +
>> -- 
>> 2.43.0
>>


