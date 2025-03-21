Return-Path: <linux-kernel+bounces-570936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42CA6B665
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A5188C101
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7621C5F2C;
	Fri, 21 Mar 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX06Xk1g"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE68BEE;
	Fri, 21 Mar 2025 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547321; cv=none; b=SWKWD2Wo7HA2cetEkFix9ev+ZjFONoeGOOZ4BM/p18GQvtScANuYv4JfUQJdOrnnQ0tXGDUlWHTxJ+ALo+moqUshOWeepEMpQ3KHNAeaRKmHRV8dXrrlb+YQK4f9iFYDUpvnIZpkeVbEPfBOfrEUZmePU+gvYe3H6lQMkVMgFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547321; c=relaxed/simple;
	bh=sebcp1PCEBjf3/oCTpgeg6/dx21uouh40AzS99rxiOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTCEwmC649TFcRxB1W70L61vB7tcT8f+2BhywQmDUz+ZxiBHseO31MsOPf383MQVdJn9zVk8YfweqgGuXHVaVmdkqIVvLlinwiJKEhUgq/j5a1xpZx2vjT/DZxKpULs/72XZRnX2UKqZzhmYUxE2Z+62LCCznWxLMEEY8u2f2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX06Xk1g; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so33888035ad.2;
        Fri, 21 Mar 2025 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742547319; x=1743152119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJKvcArfphhGJ6qkMORPEc4KtGrr1vGvXCT60cabfro=;
        b=bX06Xk1gWq36HNdPtqyeacCnzq+2FyDQwuE4Yv31Sx+Xqzd6+d6oT7yiODlW+144Ah
         ParVW65xO5nfD0Uq1Ctni+GMAkpvHDUErjUQvjAdcQ7ab45ppfa2No8/3NMN5l3uSc69
         EwWRSJdKpX5nV6ZWzUfMrPIsoSEpx9Kq2F5iPWsS2TEX3FdfiaaDqDpIcKgsBCIHwzOC
         dUzth9+R5g+j7mCgInPClh5KrcniJJf6fOzziAHY5IQ+xcfWS/s1iRlUeLm0hdxQ0pdt
         /tsBgYMSSgCIvISy2bIKo6s7S+yMYsm6DJhQ/bQbxyheDDYkh/hgnjYpZ9CpRokrwRoo
         n8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742547319; x=1743152119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJKvcArfphhGJ6qkMORPEc4KtGrr1vGvXCT60cabfro=;
        b=V7gD+hUHZBQr8P2eM5uSr0CrPkLwuXME6zKgmwGhbOLmGGJXhfOJ/YqrR+/ycnv72m
         y6OM5N6b6HGhGekgjyWPVozQfAMfMnjfJ8TtjB/YOgKMH3Gtyfcet6wWkNXG6/7gHB+z
         GtQ9m6P5gIC5kjUQJQTbc3HKLoHHaqLDW9UWwlnDL9DATw6AoMPkd2sCcNagKVJA9xN9
         ZxR4kxxkgt3B3+vd30K/lmIzvgFCAl4e33vsoXpDNmnY6n9vcd7/fpzb6k6Fb/JCsebH
         LJij2JnpJaRXW/21LB45ezRThfeslCt19UeUk5Yogp7ngr7EnA3tOhZa9bkA+49cXuJ7
         HAvA==
X-Forwarded-Encrypted: i=1; AJvYcCUiQvs14y4+9CP/qkmtItaGdZ4ogQIIQFeQrAfosC/5l4wDs7Pbiq8t2Q5ok3Ec79r+9OZs6jhxxFIh@vger.kernel.org, AJvYcCWaGvVRxWamFn0SMnniToo3Xz8p4X+jAGH6EZ+0XqIkPygdGjlNgNPBeL8N7FFE2mcWOPYCdRhuAy07Xj2U@vger.kernel.org
X-Gm-Message-State: AOJu0YywAujfm6Dl60MvJx8YyanUG3J214Kcl6XKY6l99e+NKobaQoJx
	KKh1lQFRRg3V9ap1urkT2wQpJZo0m/rxPWzrySnvPkjrtBKGRk40FTBysA==
X-Gm-Gg: ASbGnctUqIsVOJGqd7u2U3Jc0dtHgabhw+Z1N7EmcFnkKpj2kYzhKDY1GNcqUxCTSb2
	vOT2h8iZHXASdAQy4sfVP5vMtcpctcPETqyaqHPAZDWXCAw44bl9C6/y+0CWYQKwCuKxKwZtmst
	gr1P0nTPOVKyniH6dk/8rHnPYLk4/rQoo/yJlORVGDeIWT0Npdm4XBejGfpAmfF0HFJ/tmRozDE
	in1F5cQf84LEfNlTCYoHKo81cqZDQ/2R9EYA9CRJJxgZ+TbSm9sWasgteCmtWneLOdyzxV7gLo2
	uwRDQ72SgMkM+4d2dHbTBZs0kjo2j1dl7WcgS0L9e4alTjXtI52f/Grzjp74cXeKXZa9CVziL8k
	8EK7RYgXXbvotz9CSZWM=
X-Google-Smtp-Source: AGHT+IGyCMWa37Dvs/TzLf7iByEW28q3MViZ+Q6mT039F5INAer/8VtuAML2MoSCgOzIkzs+v33v8w==
X-Received: by 2002:a17:902:d481:b0:224:1074:63af with SMTP id d9443c01a7336-22780e10a2dmr35388865ad.34.1742547318930;
        Fri, 21 Mar 2025 01:55:18 -0700 (PDT)
Received: from [192.168.127.151] (sp49-98-248-31.mse.spmode.ne.jp. [49.98.248.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da3fdsm11276525ad.183.2025.03.21.01.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:55:18 -0700 (PDT)
Message-ID: <d19a0265-a95a-48bb-9020-9f3b2f938bba@gmail.com>
Date: Fri, 21 Mar 2025 17:55:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mtd: spi-nor: use rdid-dummy-ncycles DT property
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bacem Daassi <Bacem.Daassi@infineon.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Mark Brown <broonie@kernel.org>
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
 <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com>
 <20250319233024.GA2625856-robh@kernel.org>
 <a3818477-5a67-43ad-8961-88fa02916968@linaro.org>
 <CAL_JsqKtz5+R1kjEzjo6bVicOX2c=UauC0_STAF0T02rSDqO+w@mail.gmail.com>
 <50de19f7-2021-433e-b8f8-d928ed7d5d57@linaro.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <50de19f7-2021-433e-b8f8-d928ed7d5d57@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/21/2025 12:45 AM, Tudor Ambarus wrote:
> 
> 
> On 3/20/25 2:06 PM, Rob Herring wrote:
>> On Thu, Mar 20, 2025 at 2:44 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>
>>> Hi, Rob,
>>>
>>> On 3/19/25 11:30 PM, Rob Herring wrote:
>>>> On Wed, Mar 19, 2025 at 06:47:44PM +0900, Takahiro Kuwano wrote:
>>>>> There are infineon flashes [1] that require 8 dummy cycles for the
>>>>> 1-1-1 Read ID command. Since the command is not covered by JESD216
>>>>> or any other standard, get the number of dummy cycles from DT and use
>>>>> them to correctly identify the flash.
>>>>
>>>> If Read ID fails, then couldn't you just retry with dummy cycles? Or
>>>
>>> I think Read ID won't fail when the op requires 8 dummy cycles, it
>>> probably just reads garbage on the first 8 cycles, so we risk to wrongly
>>> match other flash IDs.
>>>
>>>> would unconditionally adding dummy cycles adversely affect other chips?
>>>
>>> Adding 8 dummy cycles to chips that don't need it, would mean ignoring
>>> the first byte of the flash ID, thus we again risk to wrongly match
>>> against other flash IDs.
>>>
>>>>
>>>> Otherwise, add a specific compatible to imply this requirement. Adding
>>>> quirk properties doesn't scale.
>>>
>>> Do you mean a flash name compatible, like "cyrs17b512,spi-nor"?
>>
>> Yes, but that's not the format of compatible strings.
>>
>>> The
>>> problem that I see with that is that we no longer bind against the
>>> generic jedec,spi-nor compatible, so people need to update their DT in
>>> case they use/plug-in a different flash on their board.
>>
>> This chip is clearly *not* compatible with a generic chip.
> 
> I think it is compatible. The chip defines the SFDP (serial flash
> discoverable parameters) tables. At probe time we parse those tables and
> initialize the flash based on them.
> 
> We don't even care about the chip ID, if all the flash parameters can be
> discovered via SFDP. Unfortunately these tables do not describe all the
> flash capabilities (block protection being one). Or worse, manufacturers
> mangle these tables.
> 
> So vendors need to identify chips to either fix those tables via some
> quirks after the parsing is done, or to specify support that's not
> covered by those tables.
> 
> For basic ops, flashes that get the SFDP tables right, don't even need a
> flash entry defined, we don't care about their ID, we just initialize
> the flash solely based on SFDP.
> 
> In this particular case, this flash needs identification to fix some
> wrong SFDP field, it corrects just the mode cycles for the FAST READ
> command. All the other commands seem fine according to patch 3/3.
> 
>>
>> You have the same problem with a property. Users have to add or remove
> 
> True. It's the same problem. Even if we specify the dummy cycles via a
> property, the next plugged-in flash will use those. We can of course
> fallback to the SFDP only init if the ID doesn't match any flash entry,
> but the problem is the same.
> 
>> the property if the flash changes. Anyone thinking they can use this
>> chip as a compatible 2nd source is SOL.
>>
> 
> I think the property vs compatible decision resumes at whether we
> consider that the dummy cycles requirement for Read ID is/will be
> generic or not.
> 
> I noticed that with higher frequencies or protocol modes (e.g, octal
> DTR), flashes tend to require more dummy cycles. I think with time,
> we'll have more flashes with such requirement. Takahiro can jump in and
> tell if it's already the case with IFX.
> 
Infineon SEMPER flash families (S25Hx-T/S28Hx-T) requires dummy cycles in
Read ID, depending on Configuration Register setting. That is to support
higher frequencies. By factory default dummy is 0 in 1S-1S-1S and it works
up to 133MHz. Users can change the setting to support higher frequencies.

> Thus instead of having lots of new compatibles for this, I lean towards
> having this property. I'm still open for the compatible idea, I just
> wanted to explain better where we are.
> 
> Thanks,
> ta
> 


