Return-Path: <linux-kernel+bounces-561664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA7A614A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E2A3B005D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E1520110F;
	Fri, 14 Mar 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh6r6abY"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25014C92;
	Fri, 14 Mar 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965436; cv=none; b=sTu3bdlZDqQ9L2+3yndJYGOyhGOKqlFFBuw5lxRBddTWNcJtKAyBXnuvwnr1kftnvfjDdzrQ9/31N6qQ8d9ILhIr6/CN+9Sxlcmi59pPO0eRsF0Kd2cLbs2hJ1TmZHA65fnhPaA5s0JEIgR4oth1XiznO+W8jHlerQ5jl09B34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965436; c=relaxed/simple;
	bh=9Ovcf3ZBr4VguOpgZ3LyqjraWY44XRz8PTWX0dEmfaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwtaknpMVXBcGNfyLWiaSqtWjhQm4nPHJxvEm81841t5u5IIYSg4cdmOljYPk52j753bDygs4fqbEPsiY6SvMh4hgSehDK+ZT7gOW62cL65CvCk/0JBmaQ7rOGEfiEJ1xY53BQpd8XF0gSY2uteNkvCkwp5SYTWhM5Y7sg0ZTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh6r6abY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so3893294a91.2;
        Fri, 14 Mar 2025 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965434; x=1742570234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ARa48UJeOnruk4y6hfaItaqVnAuMM94e4bCCTCC0nD8=;
        b=Dh6r6abYC1y/UAFU1RMWx5lFOXPi+OfLxSo4Vu01Sh8ekIL3SEgZP8vG6kBnhr3N78
         UhErtLc+vJwQsBd4mIdXaHtylB33sgqmDiNM3QOp4l+0D1vrZPuB9l2gcv+7yygZ7wPv
         G16BkrW5FyugqOS2QbF45Opr+hC0MLVZIHtD4GRtppx9AVKJArTtTGVT6Jzx6u5KO+kx
         n+b4o3KDzI9udkGmSgmDrM/tc5DDIqp1RLLku6opWZEpx5cE8jsxmu3NFHU0bz5oTpja
         XXkKPsbeYGcF9zEbe/mpSnMDIJyAfHCReaHDfrMeUEMWY9ibfu8dzD7qfMnkB7cGqMGX
         JtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965434; x=1742570234;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARa48UJeOnruk4y6hfaItaqVnAuMM94e4bCCTCC0nD8=;
        b=k5ocyeXSU6H7PfzFZB/bQsvxLWwhlqZs11I3D/a9QifTa7bMLsqYNBTk6SnMCk/AVo
         DOgvC23faOy0EIVRC5yV3E8vy/Yyrb32tjU4jf0Y2LCvs3oxF305iVzfGAiQtu8abkNM
         nQ/cVT839suCZ/Lqzn7DeUzSZbl93uXwQaLWdlhONUnxaxWyupvQHbe2r5aa2+ZeBVv3
         MFDeuFxcw6OfxhGnsRrP0Z6L6kA5ldcgdVvyvFzPOcK9pWzw7VciR6fH0RI9JvFBrQ6C
         BEadUwImlC3E3ksPmRa4nhv1fgagPXHe5zwOJBo5O8SusTRy/L7finQwnZjChhTl5klN
         WPtg==
X-Forwarded-Encrypted: i=1; AJvYcCUq5oMZpLEe9ykIyNk3O4ppfeg+1/BEjxP9fJD0DBilCM0btHdmsFeLHycY4FBuXl73qstCZWcYwNHneGY=@vger.kernel.org, AJvYcCVly6v5dVd51kUb3uKQXU1mc5UIgIxBqaumQQNyk2L4Hw+zCRlV4D3TOBVAsyb79oNIOQuJg9i5pQ81@vger.kernel.org, AJvYcCWyEoFLOO/aR8owbE7JZTUh0cPo8Hp7qWq1wPgq1Ns6VNyum9SqwikOQj+dR/jzPbCF6h/b0UamANS6PN+w@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpG2tDimobueGc0pYfeMVdtqp1GPHdQ0GwG6fSM+q0oZb+9o0
	0p9RywMP/3TxovBHTor67W0d113SFpE4Ivflc+xIMf1O9h0CWGWE
X-Gm-Gg: ASbGncuHN/egbdiVBj0H/QJ/FjgzZsVLSz3K4h9jqNdpHfW4pPqqaoTZ5NA3+mpW9+q
	Nu0aypmUDVixR4BtjYKaAZp2vXS5QS3Vbc324S0Ub5Ldhe1WKJQKl0bQ8lwZl0o5WPZtlWOhx8c
	n2QkHLzGOEdfrC+LncJ2dqGw8Wq+Ug8dk0EmDSab2v231QQEWu5QZ6QCOhBes52iXkCZVwqlggY
	zQOTow1FR75MBAWrRhrEw6OiYQtMxwEm0uEgJVx4j7A8/3i+1W490b8kXa27hGX7Q5hivHdLZA8
	HIFhKYwnQY/k198aji8sy+c/VptwWMPncRf+W8vP47Jbh6astTREJnWAc9Tzw1kTfzHJkeLEpNM
	UfwOQw9zS7MGoA9wAxA==
X-Google-Smtp-Source: AGHT+IG2jRdPaGI0FWtVKjiiomdk6D9DJZF/EZKSpoKP8xh69ls7UwRCiGvxWs2pkQtYbrkW+pYPKg==
X-Received: by 2002:a17:90b:5608:b0:2ee:d824:b559 with SMTP id 98e67ed59e1d1-30151d9d704mr3737985a91.28.1741965433831;
        Fri, 14 Mar 2025 08:17:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539ed283sm1234279a91.18.2025.03.14.08.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 08:17:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c3d438aa-504f-4d13-909e-ed9be0394b75@roeck-us.net>
Date: Fri, 14 Mar 2025 08:17:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
To: "Florin Leotescu (OSS)" <florin.leotescu@oss.nxp.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Viorel Suman <viorel.suman@nxp.com>, Carlos Song <carlos.song@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "festevam@gmail.com" <festevam@gmail.com>,
 Florin Leotescu <florin.leotescu@nxp.com>
References: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
 <20250313125746.2901904-2-florin.leotescu@oss.nxp.com>
 <20250314-encouraging-fabulous-ant-e1f7b0@krzk-bin>
 <DU7PR04MB11163B2B2D8D429B2667DAA65FFD22@DU7PR04MB11163.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <DU7PR04MB11163B2B2D8D429B2667DAA65FFD22@DU7PR04MB11163.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/25 08:02, Florin Leotescu (OSS) wrote:
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +  '#pwm-cells':
>>> +    const: 2
>>> +
>>> +patternProperties:
>>> +  "^fan@[0-4]$":
>>
>> Keep consistent quotes, either ' or "
>>
> 
> Thank you! I will correct that.
> 
>>> +    $ref: fan-common.yaml#
>>> +    unevaluatedProperties: false
>>> +    properties:
>>> +      reg:
>>> +        description:
>>> +          The fan number.
>>> +
>>> +    required:
>>> +      - reg
>>> +      - pwms
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        fan_controller: fan-controller@2f {
>>> +            compatible = "microchip,emc2305";
>>> +            reg = <0x2f>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +            #pwm-cells = <2>;
>>> +
>>> +            fan@0 {
>>> +                #cooling-cells = <2>;
>>> +                reg = <0x0>;
>>
>> Please follow DTS coding style, so reg is here the first property.
>>
> 
> Ok, I will correct it. Thanks!
> 
>>> +                pwms = <&fan_controller 1 1>;
>>
>> It's the same PWM for all fans? So isn't it basically one fan? How do you exactly control them independently, if the same PWM channel is used?
>>
> 
> It is the same PWM controller, but each fan has a different PWM channel. According to datasheet, the EMC2305 could control up to five programmable fan control circuits.
> The driver will parse all fan child nodes during probe and use reg to differentiate the channels, similar as it is done on max6639 hwmon driver.
> The 'pwms' arguments in the example are used to select the polarity and pwm output, which will be parsed in the driver to generate the bits for the registers used to select pwm output and pwm polarity.
> (... <&fan_controller [pwm_polarity] [pwm_output]> ...).  Now, I realized that I should use: <&fan_controller [pwm_channel] [pwm_frequency] [pwm_polarity] [pwm_output]>. I will also document the arguments in #pwm-cells description.
> Thanks!
> 

Please also document that the channel assignment is fixed. Technically it
doesn't even make sense to specify the pwm channel (it is fixed and
matches "reg"). I don't know if the channel number can be omitted from pwms.
All you really need is polarity, frequency, and output type.

I am not really sure what to do if the channel number is mandatory.
If it is, I'd suggest to document it as mandated but not needed/used,
and then ignore it in the code.

Thanks,
Guenter


