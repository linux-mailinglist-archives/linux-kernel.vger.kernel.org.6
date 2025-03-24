Return-Path: <linux-kernel+bounces-573803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F96A6DCA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FD916A81D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891725F96B;
	Mon, 24 Mar 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8Mp20dy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720A2505C5;
	Mon, 24 Mar 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825537; cv=none; b=RDMAfbE9SAJKVYA2EC3LIVDjk5tVxkYRSwoDcAxHQlDQ+wY4O5839jf+WHQiS2fBdgvnQeaTiSDO2wq9sZVSC1MzrXD89ZAF/CSLBVQoSFvrEtugBaatjus9+kwqIRx9qg7WbPFpxlCEu318LQ4uBYzqozrFaPesgeLKOyIgH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825537; c=relaxed/simple;
	bh=hIlci/ejHPKu2NoO0xwOe+65FMTZn3FzjTVWnTvLsUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDQzsE53TZbLpbzTaB43UhkdNorZLZaFyN5kmfKnALFMoQXX5eS2xR8aM+/XqnoXMxUkUgwR4bPTcq8KWdU7YAIQOt1fsCKqld4RrknazhR0mXyuMFrpz85nvwvMq+1Gi7bfpbNmncZOD7e7VK2GPOECEgxSY4rKN3jxX0VhU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8Mp20dy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2260c91576aso73619405ad.3;
        Mon, 24 Mar 2025 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825534; x=1743430334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7o3URVbvXtzI6YwkjrSDC5zCoxRK8EtHeWUGbXbB0SI=;
        b=h8Mp20dyyd4mlbhpYcbkh1fV8R2KA7G6jNGa2Q1xe6Q9vecvozvtRo6jxpA5b7jXOY
         54EPfYVf+lZbpVDzilMlgT/0mfohyrBbImWKt/A2UfwQ2Tvy6wtVKGyxV5YYzQtDSoyE
         WxzlMnSIJ/O2EPpCvFUKfJMozH18haJpa87IOphYJZtmR0Vm82W668dFvXXOpj+vxcBZ
         lyE8ea3H9cu1sEVDwbCBOTT2yY3E2KHWNKBf4OliBGR0Q6g1nMXbmMqvqfRVXNUggSjh
         XWgYQV4sJQGRoEKJT7TyG89rxo++ngCvhCnJi1yGSPXp5GPWf1YBD273MFLMvkmTXRou
         fb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825534; x=1743430334;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o3URVbvXtzI6YwkjrSDC5zCoxRK8EtHeWUGbXbB0SI=;
        b=AV7T+HtEG4jTKbjkPwbIBBwPiSemptylNFlFoXD11oJfLC4L3ZDb/CBSHwmb5YX+nA
         RTvD/cZYp5vX56/7ymqpxtUqcbm/n80rf/9ZfROxX2+Q+YLG/WCfoMiC5gC5pA/yY82h
         RwVe9oCgEoHyKjqiGsXVyHfKNdHtIAqZaSdqzU02S26Y5eQx6RTruuo0+RdH6XYgJUuZ
         5UkUlJjzNJ/p9ugZg2bya+qwHKwu3yEMDNo0Obp5DqY828u06BXL6JLw1W620w+i4FHw
         PofB5xx9ye8uhwYZc5rZdVHgTX7Q38ri1HbQa6JoOcX+T+sZBNypk3H2VsdWMcVewnWh
         +Zjw==
X-Forwarded-Encrypted: i=1; AJvYcCVisDBXPjFXc4IKXdsRNUGXG+9QgwXWnhJOD+w64RP+LDNlCTe0HJ4A8ntaguqvEJWq2NN3zxxftM0yMA==@vger.kernel.org, AJvYcCXuCJSz5wbv28Od+LkyVzv63vuwRr+Ll3zcJfO7vzuS4GrPk78Fi/I6oQD3oQajBxUIcTcabvYzv2OKj1Jg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1tmD6SwKO4h+p8wnCJESfCgJ1EWdoAN76eX/oVlPvbgenuMWo
	h0FEJJnDnR8VJQ72xPrbmToE4G6WoESIr0v4xVBB/GnqOLemzowL
X-Gm-Gg: ASbGncvApHRstCUC8RS5XBSVUGWfqh5GLXPMG1w+/AAPyBodQz+MpQ+JynATmRCpEC1
	CE2Dpvi77jjhs702fCYkBU2+ExzYGEglvD1uZCCY03JxPCsXAhl0mpULPRiMswt+q8nOGlunY4W
	+ITRoP4+b8TKd00xs8UN2iBY5AHdC+HN2vz/a1EmBaCWdiqz31VZ76vmY10m4dS+JD23TZ9htIb
	cZdBMTwH77nQ+94RWfckmrSLornuyn9M0xP0Mt8pYdjG/7hicmFwbJJaNf3MBk19zM2M7FJFSzZ
	Hyri6LIymBtL2ThwVFYSDdvm7YCiFZyY05VcVpVC01stxw3NF3SrUJpLNTJyqzVkI0pLi0LUGwo
	eneNAZ2HCYrawcgiWrg==
X-Google-Smtp-Source: AGHT+IG7XorWqAx6k7knkJ37HFVJXY/lOIzBSxPdYHJJ0fvVsVxkCOpj/ciraFpciZ/nunpJ23DM7w==
X-Received: by 2002:a17:902:e887:b0:224:1074:6393 with SMTP id d9443c01a7336-22780e1fab8mr215452435ad.43.1742825534118;
        Mon, 24 Mar 2025 07:12:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da8b8sm70630815ad.189.2025.03.24.07.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 07:12:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <164922f5-d7d9-4e36-b0d4-5ba4c30597e3@roeck-us.net>
Date: Mon, 24 Mar 2025 07:12:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] hwmon:(ina238)Add support for SQ52206
To: Wenliang Yan <wenliang202407@163.com>
Cc: christophe.jaillet@wanadoo.fr, conor+dt@kernel.org, corbet@lwn.net,
 jdelvare@suse.com, krzk+dt@kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org
References: <801599a6-81d9-4e06-8fc6-e959132eef24@roeck-us.net>
 <20250324123852.4120-1-wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250324123852.4120-1-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/25 05:38, Wenliang Yan wrote:
> At 2025-03-23 01:25:11, "Guenter Roeck" <linux@roeck-us.net> wrote:
>> On 3/13/25 01:02, Wenliang Yan wrote:
>>> Add support for SQ52206 to the Ina238 driver. Add registers,
>>> add calculation formulas, increase compatibility, add
>>> compatibility programs for multiple chips.
>>>
>>> Signed-off-by: Wenliang Yan <wenliang202407@163.com>
>>
>> The patch unfortunately combines adding support for a new chip
>> with adding the necessary infrastructure. I finally found the time
>> to look into this further and split the changes, trying to find out
>> what actually changed. Unfortunately there are some problems.
>> Some of them are listed below.
>>
>> This is not a complete review. Also, I'll have to write module tests
>> to ensure that support for existing chips is not broken.
>>
>>>    #define INA238_SHUNT_VOLTAGE_LSB	5 /* 5 uV/lsb */
>>>    #define INA238_BUS_VOLTAGE_LSB		3125 /* 3.125 mV/lsb */
>>> -#define INA238_DIE_TEMP_LSB		125 /* 125 mC/lsb */
>>> +#define INA238_DIE_TEMP_LSB			1250000 /* 125 mC/lsb */
>>
>> This is not correct. The unit is 10ths of uC.
>>
> 
> Since the temp_lsb of sq52206 is 7.8125 mC/LSB, in order to express it as an interger,
> my original intention was to use 7.8125*10000 to represent 7.8125 mC/lsb.
> At the same time, for the consistency of different devides, using 125 * 10000 to represent 125mC/lsb.
> 

Yes, I understand. The problem here is not the code, just the comment.

>>> +#define SQ52206_BUS_VOLTAGE_LSB		3750 /* 3.75 mV/lsb */
>>> +#define SQ52206_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
>>>    
>> ... expressed in 10ths of uC.
>>
>>>    static const struct regmap_config ina238_regmap_config = {
>>>    	.max_register = INA238_REGISTERS,
>>> @@ -102,7 +114,20 @@ static const struct regmap_config ina238_regmap_config = {
>>>    	.val_bits = 16,
>>>    };
>>>    
>>> +enum ina238_ids { ina238, ina237, sq52206 };
>>> +
>>> +struct ina238_config {
>>> +	bool has_power_highest;		/* chip detection power peak */
>>> +	bool has_energy;		/* chip detection energy */
>>> +	u8 temp_shift;
>>> +	u32 power_calculate_factor;		/*fixed parameters for power calculate*/
>>> +	u16 config_default;
>>> +	int bus_voltage_lsb;    /* uV */
>>> +	int temp_lsb;   /* mC */
>>
>> No, this is not the temperature in mC. It is the temperature in 10th of uC.
>>
> 
> This is indeed a problem, I need to handle temp_lsb appropriately.
> 
Same as above. The problem is (as far as I can see) not in the code.
The comment should state the correct units.

>>>    			/* gain of 1 -> LSB / 4 */
>>> -			*val = (regval * INA238_SHUNT_VOLTAGE_LSB) /
>>> -			       (1000 * (4 - data->gain + 1));
>>> +			*val = (regval * INA238_SHUNT_VOLTAGE_LSB) *
>>> +					data->gain / (1000 * 4);
>>
>> The slight benefit of this change is that the divisor is now a constant,
>> which may enable some compiler optimization. Still, it is not a necessary
>> change and just makes review more difficult.
>>
> 
> The original formula takes effect only when gain=1 or 4, but sq52206 has a gain=2.
> The principle of this formula is the same as before.
> 

Thanks for the clarification. It might make sense to separate this and the
calculation change below out into a separate patch and explain the reasoning
in the commit description.

Thanks,
Guenter


