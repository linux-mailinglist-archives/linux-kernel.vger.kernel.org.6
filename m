Return-Path: <linux-kernel+bounces-204537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DEB8FF0A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B24B30A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ED6198E63;
	Thu,  6 Jun 2024 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wH+V+yHr"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2D1A38D5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685564; cv=none; b=UeDKnA9a1jgnv5PfUrdYvvUYMYNt9klvpizgXgY0OYqP3Qxe96gEvaQBIttxRHxyjH8uFtZgaqkVy5PffaXdONMCW7WluOgKCz8qP0bVChSDmvqZUjQbVtzVWEpPocqw47+e3ReJ4TJOCuyiME8YPaGG31MvOdj7z/RRzTNN/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685564; c=relaxed/simple;
	bh=k79YCzazeOdNIxSjb/y4BIQNbI4IPx0L7GI9H+oZirg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paBU9HOaA5T+AFIeB0sFGu9Ie2wwTnJ40WyKOCXQu8U6A6pvxaqjkVSYBo0tiJFM2vjt9OCz4Q7jYJcG4bEdL1UJoEqaHKeq1gg2cdr5CNlX98qp7t82TIhuu5C8Ti3fo+pWe9JUCjRTikK+NXQkdJ91K15qPq59TwHIEeKjjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wH+V+yHr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a9a3bc085so1468736a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717685558; x=1718290358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGCRKwKRmXUWhTx00oNcButD2nQ+Saa5TZxkHFCVpsQ=;
        b=wH+V+yHrQPx9w80fn3L/o4zSxZleSFjkuGMQPBHn1euiCavwPzpljubO7DSpB5cMA4
         3L/1MPRSFTbkLiGugVnkXw77tknbvewN0Wv8qqJ9a0ecZQjW/0QkKo8e6RL+tCL0Wirz
         JpyP1KLxIBi/1WFWgtvIJpIE8UWamajf8+74RG918PrZTNVNeAzp8qO080JOmDl9A2ah
         pZFTgGVln9i5BoU6FAwelsx4e6lCPDeZn225XjZVsafmWA3tFvc+Ixkk20qVCUZYc624
         W5eeDqJdbYVq+NirDAZgs0JkrvEUM6LztB3OrFvm7jJlLwpoofWhiiWY8Q7ZEJABNj0Z
         pNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717685558; x=1718290358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGCRKwKRmXUWhTx00oNcButD2nQ+Saa5TZxkHFCVpsQ=;
        b=Z1Ik9KNSXO5XbcpXvuHQdAtxWnEy14SyaOuamuLLF3bpPkdn24NH9rjlm32oKoTFod
         WSYyRj2ZUsY4xHzP3t79crMNvWtP2lBHWaJdgfL97Hgu2npKgVUGWtUt/zknDvc5YdR3
         cBHPBndjUjMiwcjneS3iHPVmGwBreYRStaMGMb3AWtNNUpoP6IDLYjdv4NUCpIdpDRNc
         hQTneTD6MHXXJ7X00Mf7EQgpL6CpdKjh+SNAnE0hnena3NGEr+NQqlWbfoCU2D8E7+70
         ciJHM+kVTD8d00GRo0VLriFH6NXdTmVFYMmK/6h3G0TyLKmR9nu7k62Q3FMP8erBM54+
         /MHA==
X-Forwarded-Encrypted: i=1; AJvYcCV3gNzJ/ZPVOCD7AK7LCqfuOxLOZegd2wJoaXefShF7fESrh478Gq9u/hTvB2sswxEwnHCqTtD+NiBScd7tBNZtn3lfcp/Gixoeezwt
X-Gm-Message-State: AOJu0YxbbRVd0WDX7dg52X5VdZnBjdZTy8wRe31I1DC5i4coFAH7vnYs
	jnGtFMlgYVNQPvW41jPFY9F9oIi1FXWZGB2mmwFar6YCHQJQa+VposAlT8ghr78=
X-Google-Smtp-Source: AGHT+IHqQQw7O0OBRYnOeA/8BGBR9rC3YntBdKFGChqnPpJwodZEx81cRjSeCp8zfYk3krebBnLanQ==
X-Received: by 2002:a50:bb03:0:b0:57a:1c44:581c with SMTP id 4fb4d7f45d1cf-57a8bc91223mr4966328a12.32.1717685557803;
        Thu, 06 Jun 2024 07:52:37 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.17])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae202341sm1197473a12.70.2024.06.06.07.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:52:37 -0700 (PDT)
Message-ID: <48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org>
Date: Thu, 6 Jun 2024 15:52:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
To: Michael Walle <mwalle@kernel.org>, Esben Haabendal <esben@geanix.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
 <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
 <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
 <D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/24 14:59, Michael Walle wrote:
> On Thu Jun 6, 2024 at 3:31 PM CEST, Tudor Ambarus wrote:
>> On 6/3/24 14:09, Esben Haabendal wrote:
>>> A dedicated flag for triggering call to
>>> spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
>>> and parse, with fallback to legacy flash parameters, without having dual,
>>> quad or octal parameters set in the legacy flash parameters.
>>>
>>> With this, spi-nor flash parts without SFDP that is replaced with a
>>> different flash NOR flash part that does have SFDP, but shares the same
>>> manufacturer and device ID is easily handled.
>>>
>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>> ---
>>>  drivers/mtd/spi-nor/core.c | 3 ++-
>>>  drivers/mtd/spi-nor/core.h | 1 +
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 3e1f1913536b..1c4d66fc993b 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
>>>  
>>>  	spi_nor_manufacturer_init_params(nor);
>>>  
>>> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
>>> +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
>>
>> I don't like that we update deprecated methods. The solution though is
>> elegant.
> 
> I actually had the same concern. But currently there is no
> non-deprecated way to handle this case, right?
> 
> Right now we have the following cases:
>  (1) pure SFDP parsing
>  (2) non-SFDP flashes with static configuration only
>  (3) legacy implementation, where the magic flags decide whether we
>      use SFDP
> 
> Which case is eventually used depends on the ID of the flash -
> assuming there will only be IDs which either fall into (1) *or* (2).
> That assumption is clearly wrong :)
> 
> I'd propose a new case in spi_nor_init_params()
>  (4) try SFDP with a fallback to the static flags from the
>      flash_info db.
> 

that's not that bad, but I would avoid doing it if it's not common. You
also have to update the core a bit, you can't use no_sfdp_flags &
TRY_SFDP, it's misleading. Does it worth it?

I won't oppose too much, but to me it feels that we're trying to keep
alive a dead man.

