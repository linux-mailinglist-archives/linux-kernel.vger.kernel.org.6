Return-Path: <linux-kernel+bounces-566565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D138A679B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273A67A4CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15425211486;
	Tue, 18 Mar 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG3i7Rdb"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEBA2116E1;
	Tue, 18 Mar 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315858; cv=none; b=ZC7cEvAs6GM4JOS7Dz7py0fmEepn/x6/vqAfZXY0QjTZ7C4q5PAU8RqS+RVXOUHzsKbeOlOPVjZCI4yBp1LXFTTjTYZ4Z4Z1cRbls6TgtaiXi/oqISCb3M7eOAixbAIm1xCH0qgFzlapqQnwPjjmSEEcWErkBTLlNHgDtLgPQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315858; c=relaxed/simple;
	bh=0qDP6EQsWN062W7kH85IFiHUOEPw6iXqikml60E1P6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJocqENtd+Exg2bTNED4nW9yNrFsoYwstDc42vF1d6J+KwATh45VIMIJM4nrUQeQWSKGDDX4fMq6aFMlYIgDeybIgY+7jhm/REkG2ZXzFKj0IrZPFOtib/xf4qJXnO9NCon0ZFNlCAoj5ShsMNqcB0Y6741GWdFt5C8DraLD1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG3i7Rdb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3011737dda0so4669161a91.1;
        Tue, 18 Mar 2025 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742315852; x=1742920652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RX5YGFbVgU4B7bQVgIXWTMqxSJNIzkC7ef+oNs3DsRY=;
        b=bG3i7RdbECR6YIORTpSoz8C1XCJkE1By3hu0NE4Kaxe/IsRqVY84r8SafmhjnVDQO5
         EtapI5sZqdZHz3qo7FiyPRdl3t78SIHx9nI3m59uIRgz49GBH5UO/oBHxHjfi0BJRB02
         zVt4ztlbzPvxJntmlG+9BzUDP5KWC4esdK97BCLNpnirOrhM3IFCgjEmgslb/U6Bl6gR
         cOY7EqugVnVbw4rIYzmiJYmuYC7aUUmw7cqwVsnWtx9jy+n8rBB6yD7G3ClPwp4pUj1K
         SP9LK4jca6SSOEDbUIMxVjvToo93shTJNQpWALsUqZy13/cy8ON03yaC3lsdCNGsS038
         PdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315852; x=1742920652;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX5YGFbVgU4B7bQVgIXWTMqxSJNIzkC7ef+oNs3DsRY=;
        b=vCE+8JPzobjmIEbfUcE8jpUFoXUBUFGI0+OnQwIPAYNWFPnr9crbZucwqGabQ7PY8l
         CFYuvJRV2LkbeQXMd1vDB13+bo4nhSkH3ZENTJ4gTw3qwLJXfCU5TPC3eU7ed1MiHXV+
         KvjhLUjACLodt4ikL9kzd7aPg8hY1Ccy5KX2NfddtRJOLcFzfquX3F5QEseXff+aV9sV
         gzRJcKzi84r2KQFzHrd+B2QTH1HuJZ4kT9BcaXhaHa3ubiO3oxIdWkITA9ZpGKjHAbD9
         5Bqos+lS4kMwdumHwmuwAsdUDTGzw29f3oQ++7pL5+FaGmSZHrZaaTlKc8+fY2QGwBpD
         E6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU71GJcynZ68NC4nbZpLDxve7JyTT3IUehaZmSDVe5H+CE9qvrAtvENdpw8P2d6tWJMmMxgSmtDZNcs@vger.kernel.org, AJvYcCVQOIhYq6xDqCjioXz56PJ9sDEQSBQKgJ2Ki2wEIUF0leOjbP6EAz39h1/ICxCe9FaGVhIhd3Pf/iBCAKo=@vger.kernel.org, AJvYcCXtFEEUs4i1BzUkBC1Br5jGrwwzljakYHQOh0hQDpJ+88yZ5hN5zFWItNBo6DDn/iSHTFTa1DB5jQ/PTzLe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxi33WPLQ1b9KTFLNDTZpYsV4UXovwAJpGqaGfIyv0JxtqM/0b
	to20iMMPYLf4LoQMBMdF+SBMPaN+f5+UEwyzUEAh3flH5L+XWzsf
X-Gm-Gg: ASbGnctYG9nhjmtPNF/hchpr4jtwcPK8qqp0gl64NxJbVjMUUQrU0aDO0WotInOAyFQ
	xq+cPFXYUzdSUn6OfJU6Kvz/SgpvOTDq9gWZ2ErOfZvD7sNJT5lA+fZzM1HKMumKqN+FKCxcs+0
	Fc8/SkjygCKsYcCE/uQWlmaf7e9gPeCAW3fUW7AiYkT3KPjkvm37s68sBqqvvnL+NQrPZafbDf6
	oaO+dFRGDLQIvbGsrlJOdiqOXtUX2OY0iQOte4Q09rQ4jggkJ4rq552+akYk8BDG68T9B+Fda0O
	nFvXr3Uen5PePhbgZ5FvJj15OQ0gQwD68l7SJBanFkXHb3Hwxkubm6raFz2jHQjsrmMvNrVVscb
	f9EctXMOuQxLSud0EWA==
X-Google-Smtp-Source: AGHT+IEz2mE1n6qLna/bcwWtLqNzBsV58RfTXND5Fpx8ZSvD076I5rzelZDBeEfv4UsqUmvwKng7lw==
X-Received: by 2002:a17:90b:1b47:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-301a5b14938mr4268197a91.8.1742315851830;
        Tue, 18 Mar 2025 09:37:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153532d7asm8443252a91.21.2025.03.18.09.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:37:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ca734f66-593f-4e7c-bc76-e343a7eb88d7@roeck-us.net>
Date: Tue, 18 Mar 2025 09:37:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: florin.leotescu@oss.nxp.com, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, viorel.suman@nxp.com, carlos.song@nxp.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>,
 Frank Li <Frank.Li@nxp.com>
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
 <20250318085444.3459380-2-florin.leotescu@oss.nxp.com>
 <7afcd224-1154-4e2f-b383-10f6a89fdae0@roeck-us.net>
 <CAEnQRZBmYdLh29ha1FKz8=CbxjFBFFTgDkjrEmwTxW2WcxodfA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAEnQRZBmYdLh29ha1FKz8=CbxjFBFFTgDkjrEmwTxW2WcxodfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/25 08:33, Daniel Baluta wrote:
> On Tue, Mar 18, 2025 at 5:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/18/25 01:54, florin.leotescu@oss.nxp.com wrote:
>>> From: Florin Leotescu <florin.leotescu@nxp.com>
>>>
>>> Introduce yaml schema for Microchip emc2305 pwm fan controller.
>>>
>>> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
>>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>    .../bindings/hwmon/microchip,emc2305.yaml     | 113 ++++++++++++++++++
>>>    1 file changed, 113 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
>>> new file mode 100644
>>> index 000000000000..e61ef97e63af
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
>>> @@ -0,0 +1,113 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +
>>> +$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Microchip EMC2305 SMBus compliant PWM fan controller
>>> +
>>> +maintainers:
>>> +  - Michael Shych <michaelsh@nvidia.com>
>>> +
>>> +description:
>>> +  Microchip EMC2301/2/3/5 pwm controller which supports
>>> +  up to five programmable fan control circuits.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - enum:
>>> +          - microchip,emc2305
>>> +      - items:
>>> +          - enum:
>>> +              - microchip,emc2303
>>> +              - microchip,emc2302
>>> +              - microchip,emc2301
>>> +          - const: microchip,emc2305
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +  '#pwm-cells':
>>> +    const: 3
>>> +    description: |
>>> +      Number of cells in a PWM specifier.
>>> +      - cell 0: The PWM frequency
>>> +      - cell 1: The PWM polarity: 0 or PWM_POLARITY_INVERTED
>>> +      - cell 2: The PWM output config:
>>> +           - 0 (Open-Drain)
>>> +           - 1 (Push-Pull)
>>> +
>>> +
>>> +patternProperties:
>>> +  '^fan@[0-4]$':
>>> +    $ref: fan-common.yaml#
>>> +    unevaluatedProperties: false
>>> +    properties:
>>> +      reg:
>>> +        description:
>>> +          The fan number used to determine the associated PWM channel.
>>> +
>>> +    required:
>>> +      - reg
>>> +      - pwms
>>
>> Is it necessary to make 'pwms' mandatory ? The current code works
>> just fine with defaults.
> 
> The code adding OF support is added just in the next patch, so the
> current code isn't event
> probed when trying to use dts.
> 
> Or am I missing something?
> 

The patch introducing devicetree support to the driver doesn't evaluate
the pwm property. That makes it quite obvious that, from driver perspective,
it isn't needed. I don't immediately see why it would add value to _force_
users to provide pwm frequency, polarity, and the output configuration
if the defaults work just fine.

Guenter


