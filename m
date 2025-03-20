Return-Path: <linux-kernel+bounces-569283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EDDA6A0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1238836AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E65209695;
	Thu, 20 Mar 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cX4qF7c4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108E20B1F7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458138; cv=none; b=qZH/PsTng1FNM2WN850wQkX1MTYGxdywSYb72zGykApIQh1JeePIJ2ZNJsUzjYkS484zWzIYK9cGSoRlB34b2nRitR8R9vgL9Z4t7PSi+SF9jpdYsbHFh5goFGHovIHak6SRg7RfzphKOV9NMp1ia+WsApR3A3MtC79wRmTCnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458138; c=relaxed/simple;
	bh=26Jb3c57Pyjjzb6NhZeV8XvMaObF1YLKZUJx21bP91o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmjSejaOzmPHtU1jE+W64cmGn+Eh5bxqi+0iWFJ+EN4bkhHSFl6Xtnsd94RsagAUAhWBhQibRtu3ZncXVlsCWZS1TLQM3RUbwOYth7yAxukQ143zcZdtk8wZQyJkjcqY1MrVsRKlxTlAXDXk3D0ly/KudhZKsVMNQgCgxHSyBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cX4qF7c4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so4762705e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742458133; x=1743062933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dNQaouy98Tj7Lc86GQRnTj99bQ/YCGVWlDSr8eJwdc=;
        b=cX4qF7c4PcHkKCu4g6aCNWVTKOLQ3o2JGwr0O5n7Gl1xRokfN2T1KYrDwgBw1gP+7N
         4iarUb7EALJLHb9iuHd35SIKSSZEDawOJep2Mkt42QIiVb494k5ZkTFjq//wFtVxCV80
         /5DfaPnMcyHOnQlwlLfle+C/EpEcMwSMQJ28gzHTiAJisTzPG219Q/iai05n/Lbru2p/
         /rr1BhBwkCs3kscZOT6x2wlat5WEfo+tgIdGA/WaU15EroRZT/HWL9z0DNJeeN3AZ7z+
         w3oALMGp50OJFsEiXAT/ntNrWYHDYtIa2cZ23gwEJdDPiLuDHbo8imCWlzdUpYjKMdwH
         Ashg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458133; x=1743062933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dNQaouy98Tj7Lc86GQRnTj99bQ/YCGVWlDSr8eJwdc=;
        b=i97O/9k6SSdk+SzLKXYG7Fw/MWDg9w3YZ6HbuJF/kOb0ZJFdyrco4oTfao3J85Xhf6
         62u7RUPeLh5H1HgulVF9Hgy5jc0Ba7FT/SvKohntzen4DGkv+ccDxn+MewGXyDNV6Lug
         CCdh7hKod0aa7eVTt9hH697eIiwsFbAfqy9azfUam+o/HIfLaOE/YeO34J0fKPOBopL1
         uSb0ukcF8gtlOSGR9YGLZBwm6Q5l+R1VnvjncLVMRRGGeW5pgLGCs/oa66/Bz8O80EaE
         WH5vCKWhb8NMflfThOd4Ca+R3dJKoGzo0oq+qzBbzeMxR7B95rWkCHTXBpL9MMFGhUgS
         PBkA==
X-Forwarded-Encrypted: i=1; AJvYcCX3RCnmZtxbzCIjRwc48/rycf+28L6voU5IDlmeXhMqq4RQV9+C1phuyGK5XeaAsPxYpU5VxrSS1JX8Tg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4u3tgvuqwcFm6BbexaDFoonF6uwPzYQNWT0dgrFnCGjehC2m
	r0YGoxO563LTeGZSMd6FVIedsjmb3fDQkekfsNBVAkuB2IrNnj16wXHPTprIbEg=
X-Gm-Gg: ASbGncsXXnNTA5Rv6SPA7SqMRDs67XNC6FStdTh3jaKJmv5f0kTpr+9TYwiriJL5G5g
	8QlQUzlPj7fzP16rq8p5BzU/daJhb1jMaCHeeVgjnX7ECHRivVQJcGr8Nhj8OEr1LGp/FDZkChj
	1lMgto2/RiWgRXneoX/aZn2jexucI7DGgm6WnmfiVEUQB6GglpI6FiOYpuHT1KXuIKrkOKLYRmG
	3ywB4nQKOpfWquA/8/+xgOac1m5WFgk/HeKS+zFcVN4fB4vOeI9qR3ElPQMa/lj/1tafPt9jfi4
	hiMMfMbFDMtqO4age1TkEXXhDhO6YflBUN10r7C64bfGlrn9jJlkjw==
X-Google-Smtp-Source: AGHT+IEpNphOUcl8BMlObgU3154HRqgtwN4r8WKPgpi9ZDbKaMMX9iBtJ2Z82iqYT+hxjWitnw7qvg==
X-Received: by 2002:a05:600c:3b83:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-43d4954da8cmr17714315e9.13.1742458133406;
        Thu, 20 Mar 2025 01:08:53 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f3328bsm40596905e9.1.2025.03.20.01.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 01:08:51 -0700 (PDT)
Message-ID: <ba99ef52-0c98-45a9-91e0-4fd205649e00@linaro.org>
Date: Thu, 20 Mar 2025 08:08:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] mtd: spinand: Use more specific naming for the
 reset op
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-1-45c1e074ad74@bootlin.com>
 <9004166e-5535-4024-8114-9fdb217407bb@linaro.org>
 <87v7skrgjl.fsf@bootlin.com>
 <f1111d1b-a111-4171-9467-450d90a14c0a@linaro.org>
 <87iko50vvb.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87iko50vvb.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Miquel,

On 3/19/25 5:32 PM, Miquel Raynal wrote:

>>>>> -#define SPINAND_RESET_OP						\
>>>>> +#define SPINAND_RESET_1S_0_0_OP						\
>>>> Hi, Miquel,
>>>>
>>>> Have you seen any reset op with address or data? If not, I'm not really
>>>> sure whether we shall change the name for these basic operations.
>>>>
>>>> Changing them to 1S-0-0 may also indicate that there are resets with
>>>> address or data fields, which I find confusing.
>>>>
>>>> I think the change is good for reads and writes. I'll check further in
>>>> the series and let you know.
>>>
>>> I want to rename this macro for two reasons:
>>> - We might see in the near future the addition of 8D-0-0 ops (I plan on
>>>   working on it).
>>> - I would like some kind of harmony among these macros.
>>>
>>> Now, whether is should be named like I proposed or just
>>> SPINAND_RESET_OP_1S, I have no strong preference and I can change that
>>> in an upcoming version.
>>>
>>> Which one would you prefer?
>>
>> I don't know. Which one is backed up by a standard?
> 
> Well, as far as I know, none of the SPI NAND devices follow a very
> specific standard. Most vendors in practice follow similar conventions,
> but they all deviate a bit from it.
> 
>> JESD216F defines
>> "(An-Bn-Cn): Command mode nomenclature used to indicate the number of
>> active pins used for the instruction (A), address (B), and data (C), and
>> the data rate used for each. Data rates(n) can be single (S) and dual (D)."
>>
>> Also, "(x-y-z) nomenclature is equivalent to(AS-BS-CS) unless otherwise
>> noted."
>>
>> What's an "active pin"?
>>
>> Then if I look at JESD251-1.01 and JESD251C, (An-Bn-Cn) is referred to
>> as "protocol mode". Write Enable, which is just an instruction command
>> with no address or data, is seen as a required command in both 4D-4D-4D
>> and 8D-8D-8D protocol modes, and it's defined as a "1.A" transaction
>> format command. And the transaction format is:
>> '''
>> The following transaction formats are used in Profile 1.0 mode 8D-8D-8D:
>> Format 1.A: Command and Command Extension
>> Format 1.B: Command, Command Extension, 4-byte Address, ‘n’ Latency
>> Cycles, and Read Data
>> Format 1.C: Command, Command Extension, and 4-byte Address
>> Format 1.D: Command, Command Extension, 4-byte Address, and Write Data
>> '''
>>
>> So according to these standards maybe we shall refer to it as:
>> WREN-8D-8D-8D-1A? This seems less intuitive than 8D-0-0, but I think it
>> all depends on what's an "active pin". I think it describes the protocol
>> mode, and not what's actually sent on the line. As we saw, WREN is
>> considered an 8D-8D-8D command, and not an 8D-0-0 command.
>>
>> For dual mode, which is not covered by xSPI, I guess we can use the
>> single spi transaction formats 0.{A,B,C,...}.
>>
>> How do you feel about a OP-An-Bn-Cn-transaction-format,
>> 	where A, B, C is {1, 2, 4, 8}
>> 	n is {S, D}
>> 	transaction format is {0,1,2,3}{A,B,C,...}
>>
>> Care must be taken care of at the transaction format, as I see there are
>> a few, depending on the xSPI profile and protocol mode.
> 
> I must admit I really dislike the transaction format abbreviation because

I'm not in love with the "transaction format" either.

> it is specific to a spec we do not follow and is not explicit. I have a
> strong preference towards keeping just "An-Bn-Cn", like I did in this

Okay.

> series. If people are in doubt, they can check what is in the op, it is
> self explanatory. I chose this in the first place because it is more
> explicit than just "An" which may feel like a cropped
> acronym. Furthermore, most octal capable datasheets I've looked at seem
> to use the "An-Bn-Cn" format, even for single opcodes.

So for RESET, WREN, WRDI and other opcodes that don't require address
and data, are those datasheets referring to these opcodes as 1-1-1 commands?
Can you point me to one of these datasheets, please?

In SPI NOR, WREN is just WREN, regardless of the number of lines it is
sent on, 1, 4, or 8. How would you model it here, 1-0-0, 4-0-0, 8-0-0
using the same opcode?

> 
> So unless there are strong arguments against, I'd prefer to keep the
> current formatting. TBH, it is not set in stone and can still evolve
> later if that's needed.

I find the naming scheme An-Bn-Cn good, I'm arguing that it's not needed
everywhere, opcode only commands are better off with it, I think.

Cheers,
ta

