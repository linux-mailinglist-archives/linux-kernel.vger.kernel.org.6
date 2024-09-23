Return-Path: <linux-kernel+bounces-335834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2697EB52
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AF5B216AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96881991D7;
	Mon, 23 Sep 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9EDCjqy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BEE762D7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093243; cv=none; b=AN/WzUzBRrkINW2u3JWFbF3FiANM34Ow/nab244n6sQfkMlNq1Sv3gjOIvPr13SBHNQ2K16EL6EkN5LjQf6ohMYuojf8kwxksHpNWP8CUx9rC946sBUdswqRBbcLR210XC56xca1M/PD7lcdqTp1yN0QERU+yf+DBcWqBzKmfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093243; c=relaxed/simple;
	bh=zM1bZyYHd70M8JaWJ1L5fpeK7Sz60CEwLfpmaTylnDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEzKaiqW6Bg0+BSzmgkmEmsROz/bZA+BPgG91SKOK6LXK+a11YCdzD/nTjaZ/RC21v9IxdWLUS1vPqldRNyVf3GVK1vxJZiNJlgIKIJmo+PIaHkaRS/D2CkZ0BVDen1Hw9G9KXo9Wh1CYZahVhY7b/4wPt+t4JoIFD9W455YzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K9EDCjqy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so38719545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727093239; x=1727698039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2gTdIRa+4av8ZO1VEuKDTF8d0ArdIdZUGvGfp1ZLPQ=;
        b=K9EDCjqyumhkTqR4mP8jcxWi5YSeKN8FjZn4LEtC+cQxZdjFAExfSQVIG8a6k04kAp
         LW9psiJNByGCx74yEVcwCJwxgzqf1rI9uevsp6uxxA0HEPNy0McJeo1JeC8tFNmLnEWB
         DSGxdbUn/Oqxkv11L1B62hcJMNzxMWK7i2TRylaMZstHcBcK3oRRp1JmWj7I7aES2iQO
         RKS5DQ7yNxktrbxm5N/i/PFI7NYeN6L77ajFnzatz6F5Qj73u+IUtrWfIi8LuJ/L9MT1
         6azh/Tx7GUgYFRbck9oGSSqtrKG4fAbwIL/iIN6wZlaYgyUkyF0NHDXYn/Z7WlbfIlkX
         Bo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093239; x=1727698039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2gTdIRa+4av8ZO1VEuKDTF8d0ArdIdZUGvGfp1ZLPQ=;
        b=CjlmLXMvqSiZj4kUnEDhQjUJlM7C5Mk/yr1b7uC8u4/MjdB/IyelcGYJ+XGBcPsSNY
         vr2h/Wv1sgMuFjKGsFDsclqrVlN2Z4iN2YJ7LLoPoCMlilwZ1NTuXVE/u17GipL6nJku
         G9amFN5g5w1DReRsJPXXr61QvpqDXpJv2QKKyEYLAaAWAc1NUVEo5VrblcuSxqyhBKzA
         2kYM1dlFsfC19NO4NoEL5nByRZhpMQg8ntYVmkF6WegTjb5atx9xHEVSPMlQ3I79qr84
         iJjWPlbEICSqa6QPsGkQBM51vh8BT8okcWLTX+Uk5ous96dyMxVHf28N1WxANLCMvUTI
         q37Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB3oCM2qWJ6YPEz3NC49dBynWYC8h+bK2Z9gWrrDfPFi9/A527udzb3LoGJMbUffXZet9KPQAAxXUe/B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxphmeaPKYUKR615oFBxatCt8757BgJtHrSfupO5iLfl8vXA3k7
	LEk+bCrvjZl3DyZAaeOD1Mvbcope5OWwmlebNd8mpdfp7zFuUWzqSkrnrO7QcAU=
X-Google-Smtp-Source: AGHT+IHxeKCoN6oEL8DDvB657+8nV3I1QTbZQvrmTpr8AD2mgbnDig66H3xC4+6FS9+s0nXhE2pmaQ==
X-Received: by 2002:a05:600c:3553:b0:42c:bae0:f059 with SMTP id 5b1f17b1804b1-42e7abe1274mr72494645e9.5.1727093239338;
        Mon, 23 Sep 2024 05:07:19 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7543f3f4sm125405035e9.16.2024.09.23.05.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 05:07:18 -0700 (PDT)
Message-ID: <2c87568d-3caa-4162-91de-094684f1b268@linaro.org>
Date: Mon, 23 Sep 2024 13:07:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Erez <erezgeva2@gmail.com>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
 <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/24 11:31 AM, Erez wrote:
> On Mon, 23 Sept 2024 at 08:04, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Hi,
>>

Hi!

>> On 9/20/24 7:12 PM, Erez Geva wrote:
>>> From: Erez Geva <ErezGeva2@gmail.com>
>>>
>>> Add flag for always trying reading SFDP:
>>> Some vendors reuse all JEDEC IDs on manufacture table
>>>  with new chips that support SFDP.
>>>
>>> Add flag for reading OTP parameters from device tree.
>>> Some vendors reuse JEDEC IDs
>>>  with several chips with different OTP parameters.
>>> Alternatively we read parameters from SFDP.
>>> But the OTP parameters are absent from the SFDP.
>>
>> Do you have some specific flashes that you try to identify? Why can't
>> they be differentiated at runtime?
> 
> You can not figure OTP parameters based on  JEDEC ID and SFDP existence.
> I did send a few examples.
> 
> One of them:
> "How?
> 
> When using mx25l12805d, we do not read SFDP.
> As it uses the no-SFDP flags.
> When using mx25l12833f hardware with mx25l12805d driver, it did not
> try to read the SFDP.
> Yet mx25l12833f does have SFDP, when I remove the no-SFDP flags, the
> driver fetch the SFDP.
> 
> Secondly SFDP does not contain OTP information.
> 
> mx25l12805d has two OTP regions of 128 KiB and 384 KiB (yes asymmetric).
> While mx25l12833f has two OTP regions of 512 KiB.

Ok, so you want to add support for mx25l12833f which shares the same ID
as mx25l12805d and has different OTP settings. Is that correct?

Which flash do you have at hand, both, none, just one of them?
> 
> How do we handle it?
> I would gladly remove the obsolete mx25l12805d.
> And skp compatibles all together."

I need to understand first what you're trying to do. Don't assume that I
remember what we discussed one month ago. Describe the why in the commit
message.
> 
> 
>>
>>> So there is not other way but to add the OTP parameters in the device tree.
>>>
>>
>> If there isn't any way to distinguish the flashes at runtime (which I
>> doubt/challenge btw), then as a last resort we introduce a dedicated
>> compatible for the flash in cause and specify all needed parameters in a
>> dedicated flash entry. This shall be more generic as further flash
>> parameters can be statically specified in the dedicated flash entry,
>> less invasive for dt, and less confusing for people when they decide
>> whether to use OTP or not. OTP params in device tree is a no-go.
>>
>> But again, you have to prove why you can't distinguish the flash at
>> runtime before introducing a new flash compatible. So don't go this path
>> before sharing with us what you're trying to achieve.
> 
> You keep sending me contradictory messages.

when? Please accept my apologies if that's the case, it's not in my
intention. Provide better commit message, help me help you.

> 
> I told you we can not "guess" OTP settings based on JEDEC ID and SFDP existence.

When? And more importantly, why?

> It may be partial and Macronix may add new chips in the future.

I don't understand what you mean by partial, please elaborate.

And we don't add support for what we assume new chips will look like.

> They reuse JEDEC ID only retaining flash size and blocks.

Yes, I know macronix shares flash IDs among flavors of flashes or new
chips altogether.

> This is why compatibilities work with new Macronix chips . Although by

In the last 7 years we haven't add any new compatible for SPI NOR, I
don't understand what are you referring to.

> reading the SFDP, we can use higher speeds.

I don't see what's your point with this sentence.

> We can use SFDP parameters to read  flash size, blocks and speed.
> But it does not contain any OTP parameters.
> I found only one Macronix chip with an enterprise SFDP table with a
> boolean flag for OTP, this does not help us much.

So you say that there's a specific vendor SFDP table that contains a bit
indicating whether OTP is supported or not? Use that then.

> Macronix technical support was explicit on OTP settings. You can not

Provide us the answer for your specific flash. I don't care yet about
all their flashes.

> deduce them. You must know what chip you use.

And I think I already said that you can differentiate between the two
based on SFDP presence. mx25l12833f has SFDP, thus when SFDP present use
the mx25l12833f-OTP configuration. When SFDP is not presence one may add
support for the mx25l12805d-OTP configuration.

Is there any case that I miss?

> As far as I can see, Macronix does not reuse module names (god thanks for that).
> 
> I do not mind using flash compatible.
> Just clarify that point.
> And I will send the patches accordingly.
> 

I'm afraid I haven't understood yet what you're trying to achieve to
provide some guidance.

