Return-Path: <linux-kernel+bounces-205714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCB8FFF49
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354E0B248A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F0B15B99A;
	Fri,  7 Jun 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVaQ/7sU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45034152511
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752182; cv=none; b=iicNrqqXXRPYJTDxiEih+6G4TwERPzoTaT4eMpdWPJFwbibtYBU1SI9Ghja7LclDxaO+Swcq8HvfY3X6mZ1y7WuHHHwJ/F5Z84Wwxs45G3Dix8KqCoCc38WXDW3CFeZwTjDVl4iZRjVVqoKXK4K3Lrob7jTfqAt5+sbXYmkZ9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752182; c=relaxed/simple;
	bh=pW19M4Z8uPuV3OotvM8eJ6bmDM8QFbb5Z79aTBxR69k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxu1rChLi+jD9J5+2f2wntw6XRAucxntHRu2RbzLmZu7IeaSX9a6DdGG5UGtJb8/Lo/W3Yv+6qSB7C/cR3RsmiJI880UoSpAo5xywP3i+jZQz4C1qS5Mam8qKJMImkuvoFUuGj8USUJieR9AAwrGowOR5u4gOc7o25V/CHp+Rio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVaQ/7sU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a20ccafc6so2184974a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717752178; x=1718356978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYf6bGHbHxgNM+h3wZ+n4+ATjohhMtxeUnq9ZlPjUBQ=;
        b=lVaQ/7sUSp2PdFK1YukUCcoKjrgamq8w1Bb74+vWoWGUFm5m9q5FGzUoKyfJttktq7
         yTDFul6Ne9vUBdSB0xLPVPYc16YNIOln8rrJJMvvIncoGVsBB0YlMmtvBSi228TuNz9U
         sqsneG1mZ1CkPdfb9Sh4zKB5wkoZBARUDwfGChUKqPh2s1SDGCxAlBjsnbLU06RrH/3H
         e03hiiookfFLBXTL+rMSjeH9lG5tanUAalBl1Xr4M+BGQFCFVSp9nNofWJOOubLKZmMU
         dVU3dsb/VW+UCyiQMKnOe21moUPTWvAVckGA8+rCmHlboMVSYCu2GWQUEuQDdYQkPDC3
         HA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752178; x=1718356978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYf6bGHbHxgNM+h3wZ+n4+ATjohhMtxeUnq9ZlPjUBQ=;
        b=QbQOO5S9ggoi5c1eFkYHvf065Qs2FKCyd8N9bRiDEsiC0XR2Vtg9eUWawFtYpZjWMl
         IrMlQkx2/ekeNucUehFocQRnDrXS4WQumTOkfe9myBFeDxArWyfaXcN7AGaaF0rbXEf6
         7zYnKcfat0GPXVyTd+TPEGQqIKWv8FkD0oHiiVVpLZNlRNE46apulyIgmNnYtUIE8W0y
         HZkjdM2a7maXWbv7OMCpV8CKo7WZthIFcfqFMN5brP54AMvvMMGzsl4uwUUDBkS76eNW
         8L+yumh5xISL7xezgRKVh2StFaVe0InYHKYfRzPPOCMGj7oQqydYgSgT4zFq8Tft6WMC
         QmYg==
X-Forwarded-Encrypted: i=1; AJvYcCWwBBf4p/vmQqjnUehGygwKJEJX2tD2rxU0WGRA5iDOTg4QbGni+JZ+TrlUV9vZRBAmjo1yUaOqI1jJNxC/Hl82z3PR6HZmm6RsNF3j
X-Gm-Message-State: AOJu0YzV3OOZntZOia+bapGL2i4G5NKQGOPTH5BT1v8ktd/tAPjTWOKD
	BQODcDtVIOLjm7UaKhEs3A5uft4YvRZ8A9EmSO9aoVpR+sVykkGWQtyIcXE67os=
X-Google-Smtp-Source: AGHT+IG2lEF0vcwlSPmvTy/nHy1p/PsYovaJS1vMKm64l/eji2pqdm/IS5rE0XGcO2f/qHPX3HCDWg==
X-Received: by 2002:a50:9b11:0:b0:57c:605c:e23f with SMTP id 4fb4d7f45d1cf-57c605ce464mr179336a12.33.1717752178488;
        Fri, 07 Jun 2024 02:22:58 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae229712sm2456652a12.81.2024.06.07.02.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:22:57 -0700 (PDT)
Message-ID: <1d683b33-16db-4d81-92cb-d98e35b87cba@linaro.org>
Date: Fri, 7 Jun 2024 10:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
To: Esben Haabendal <esben@geanix.com>, Michael Walle <mwalle@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
 <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
 <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
 <D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org>
 <48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org>
 <D1T10API5U80.1OKB56YTFGMTN@kernel.org> <874ja6aszh.fsf@geanix.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <874ja6aszh.fsf@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/24 18:20, Esben Haabendal wrote:
> "Michael Walle" <mwalle@kernel.org> writes:
> 
>> On Thu Jun 6, 2024 at 4:52 PM CEST, Tudor Ambarus wrote:
>>> On 6/6/24 14:59, Michael Walle wrote:
>>>> On Thu Jun 6, 2024 at 3:31 PM CEST, Tudor Ambarus wrote:
>>>>> On 6/3/24 14:09, Esben Haabendal wrote:
>>>>>> A dedicated flag for triggering call to
>>>>>> spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
>>>>>> and parse, with fallback to legacy flash parameters, without having dual,
>>>>>> quad or octal parameters set in the legacy flash parameters.
>>>>>>
>>>>>> With this, spi-nor flash parts without SFDP that is replaced with a
>>>>>> different flash NOR flash part that does have SFDP, but shares the same
>>>>>> manufacturer and device ID is easily handled.
>>>>>>
>>>>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>>>>> ---
>>>>>>  drivers/mtd/spi-nor/core.c | 3 ++-
>>>>>>  drivers/mtd/spi-nor/core.h | 1 +
>>>>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>>>> index 3e1f1913536b..1c4d66fc993b 100644
>>>>>> --- a/drivers/mtd/spi-nor/core.c
>>>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>>>> @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
>>>>>>  
>>>>>>  	spi_nor_manufacturer_init_params(nor);
>>>>>>  
>>>>>> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
>>>>>> +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
>>>>>
>>>>> I don't like that we update deprecated methods. The solution though is
>>>>> elegant.
>>>>
>>>> I actually had the same concern. But currently there is no
>>>> non-deprecated way to handle this case, right?
>>>>
>>>> Right now we have the following cases:
>>>>  (1) pure SFDP parsing
>>>>  (2) non-SFDP flashes with static configuration only
>>>>  (3) legacy implementation, where the magic flags decide whether we
>>>>      use SFDP
>>>>
>>>> Which case is eventually used depends on the ID of the flash -
>>>> assuming there will only be IDs which either fall into (1) *or* (2).
>>>> That assumption is clearly wrong :)
>>>>
>>>> I'd propose a new case in spi_nor_init_params()
>>>>  (4) try SFDP with a fallback to the static flags from the
>>>>      flash_info db.
>>>>
>>>
>>> that's not that bad, but I would avoid doing it if it's not common. You
>>> also have to update the core a bit, you can't use no_sfdp_flags &
>>> TRY_SFDP, it's misleading. Does it worth it?
>>
>> IMHO no_sfdp_flags is the correct place (maybe TRY_SFDP is wrong,
>> maybe SFDP_FALLBACK?)
> 
> TRY_SFDP might not be the best choice. But SFDP_FALLBACK sounds to me
> like it is fallback _to_ SFDP, so rather counter-intuitive.
> 
>> because the flash is first treated like in
>> case (2). Then SFDP is tried based on that flag.
> 
> It is first treated like in case (2), and then tried for case (1),
> falling back to the result from case (2) if/when case (1) fails.
> 
>> Is it worth it? I
>> don't know, Esben is doing the development here ;) So up to him.
> 
> I am not sure exactly how it should look like, but I do like the idea
> proposed above, case (4). It is easier to describe and understand than
> the current legacy implementation.
> 
>>> I won't oppose too much, but to me it feels that we're trying to keep
>>> alive a dead man.
>>
>> Maybe, but we'd have a readily solution if we face a similar
>> problem in the future. I'm really not sure, how many flashes there
>> are, but I think these magic bits (which tells the legacy
>> implementation to try SFDP) will mask quite a few of these.
>> I.e. in an ideal world where we could finally drop case (3) and
>> you'd need to split the flashes between case (1) or (2), I think
>> there will be quite some in (4).
> 
> I like this. Judging by the way Macronix is handling this particular
> chip, I strongly assume that there are several other examples of this
> for other Macronix parts. Of-course, as long as the original part using
> the particular flash id supported SFDP, and all later flashes using the
> same id also does, none of this is needed.
> 

okay, let's implement 4/


