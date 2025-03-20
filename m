Return-Path: <linux-kernel+bounces-569666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD340A6A5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40101888D62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACD22371B;
	Thu, 20 Mar 2025 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFdAT1Bw"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ACA221546
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472220; cv=none; b=LROyJYlvNaaTOByvWpnCzpQBnGszhnpWThmgkrGa1rH/KGKsCIRxVKt5JcHXhZ8b1fRsatNBF2z3Nr5I1J+a6zDFCE5pOA5Z4itlJcYP4i5xpBqpw8an5m9hvymY221s/RoyQ7HcED4uAZ7EgfRIgBMG8uKpFHq6VMgTWUbYuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472220; c=relaxed/simple;
	bh=92z/B3k0LvkLtTwHzbNic9BJKlpRVe7yNxElqbPm4Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VALDfd+x0vCwCYRmc3NyTSevglqeZHdxKn9tEUaeTlq54Fwc5HJhDTyMNBdLX+4jbJy8m4rANsQ4cJBdrkEzuwbS9byV/f9V4mjVAwbPrNNJVNtBjC7VlCq9F8siKu8ZAyhxtPtJ7U4n9SvP04KFMWspijLeIuhHUDSpy7q0DhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFdAT1Bw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39130ee05b0so634272f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742472216; x=1743077016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQDLeTVQO60i129NwHZhgyuH4YLDfE0eRqlKn+9+84M=;
        b=YFdAT1BwFgjqCCng/IZVf43Xe7UKa6Yr63ncNOia/dyx5oqkSW/pIK89R7FtZxhfBB
         A1gZOTbRBf4tQf+REATdlexspNGA4b3eXlGw8r889GcdiY3ybfnNQi2LNShqxbXS2FsH
         DWLeN+bwPnwobTGOVdxGaq4tYJSDArHWVLnDmEPTgLT2cJf3dUGy9YY7xnoazutdbmeE
         pXa1hPwy1fjicCsljgwJXCyOY6LCICpRRRMnNAd6VyROZbIE4kvnw2Bp8eJVWigtmtlP
         8LQTrwP2TNGoxOwlN14DxNx6z1mPa7odO+ecuKJHvQBxUZw6dkl2x+mCX6Wsq7icSgRd
         lNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742472216; x=1743077016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQDLeTVQO60i129NwHZhgyuH4YLDfE0eRqlKn+9+84M=;
        b=Xzs9WH5JmFnWVf4AVHPR4JB85nvttrstLLWXcZJUX4Jcm4yUaWgflht/RaDoQtvO86
         ksApp/V/dkwzAGcvI+49q0kpjIcKv6V/VWkGWZOzeVdTT4vhTMzj4T+N5CYh5EP/tyB7
         TF8PbEeSp1hgumVNg7a8Wnld+AtI7SKbG0EGtuDfSheyutYSaB2iWIC6i1uu/2hhZg4M
         vjKSXh9olziWWHA2qiN62od9y0O20Au+kxu7JiNT59VJoixXW/oUawGfC2b6OmtrSrq5
         4AxI+Ia2DIshRe/HziemXxlub9eLCkV5oNnvlu9atdOicyWl1u6qXw+/k6ctnmhpVpjU
         oIDg==
X-Forwarded-Encrypted: i=1; AJvYcCXJk4vcXSibGqFm7aYBTu19Fya7OYFwsOkRyjPlEdcTe4zpeTbC8V6iJVHcpOR7aAfNczB0l7a027gWj3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYd32sKWldW5ZI82Bco9Zf4StawjNxw2F5XbyShBOWAa2S2sYy
	dTzPk8nkx556uZeOmDJzIQZfscwc5Ck91GvHiF4fvReFk4hpBQf2PIm4HYNo9Ws=
X-Gm-Gg: ASbGncsVWDSS5SrNqedCuL8jSGvc9Rpwt9qn/btjqiebShcbAn+OLSDsJ3tZJYK2Vfb
	3Iy92L/vE/UcHrDay04AifVzS8EUAJgEPFmCXB3y8C9+xIXjnGrTk9vjpahsSPwbwVno9yN/FIU
	bm0+BCd/jbzkgzYkkmPz4a8DBNJBGpzcE3yMVy0bj2WW9KbPGBRAEX1TW3jJ0Y1xdBBZITaQ2VN
	jgDyP+2gSHmdBgyUq+wLR6zMu6iEX93B7E1oiMillmORUSle+TvDV1/N5Gm1gWxaVKlJyE3TQXz
	L6+UAdz9MLfFn0Oko7kxbxD7JwDFedAoW4Wovuui6j66LbP6f24hDw==
X-Google-Smtp-Source: AGHT+IEK+xwmyzpLH4fUFYAK8pkY/PJG3xFWTRmMVVaoYGY6Hu+ouzrAyy9TiUC/EdmpUdoPxqvXIQ==
X-Received: by 2002:a05:6000:1fac:b0:391:4835:d8a8 with SMTP id ffacd0b85a97d-399795a7e4cmr3253293f8f.1.1742472216356;
        Thu, 20 Mar 2025 05:03:36 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df402esm23250656f8f.1.2025.03.20.05.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:03:35 -0700 (PDT)
Message-ID: <4d36e51f-323c-451c-afeb-a6e378e3ed53@linaro.org>
Date: Thu, 20 Mar 2025 12:03:33 +0000
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
 <ba99ef52-0c98-45a9-91e0-4fd205649e00@linaro.org>
 <87msdgvsyc.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87msdgvsyc.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/20/25 11:31 AM, Miquel Raynal wrote:
> 
>>>> How do you feel about a OP-An-Bn-Cn-transaction-format,
>>>> 	where A, B, C is {1, 2, 4, 8}
>>>> 	n is {S, D}
>>>> 	transaction format is {0,1,2,3}{A,B,C,...}
>>>>
>>>> Care must be taken care of at the transaction format, as I see there are
>>>> a few, depending on the xSPI profile and protocol mode.
>>>
>>> I must admit I really dislike the transaction format abbreviation because
>>
>> I'm not in love with the "transaction format" either.
>>
>>> it is specific to a spec we do not follow and is not explicit. I have a
>>> strong preference towards keeping just "An-Bn-Cn", like I did in this
>>
>> Okay.
>>
>>> series. If people are in doubt, they can check what is in the op, it is
>>> self explanatory. I chose this in the first place because it is more
>>> explicit than just "An" which may feel like a cropped
>>> acronym. Furthermore, most octal capable datasheets I've looked at seem
>>> to use the "An-Bn-Cn" format, even for single opcodes.
>>
>> So for RESET, WREN, WRDI and other opcodes that don't require address
>> and data, are those datasheets referring to these opcodes as 1-1-1 commands?
>> Can you point me to one of these datasheets, please?
> 
> All Winbond datasheets use this convention:
> https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> See 7.1.2 Instruction Set Table p.25.
> 

Nice, thanks!

> I checked Macronix and Gigadevice datasheets, they simply never "name"
> these opcodes clearly.

okay

> 
>> In SPI NOR, WREN is just WREN, regardless of the number of lines it is
>> sent on, 1, 4, or 8. How would you model it here, 1-0-0, 4-0-0, 8-0-0
>> using the same opcode?
> 
> I guess, yes.
> 
>>> So unless there are strong arguments against, I'd prefer to keep the
>>> current formatting. TBH, it is not set in stone and can still evolve
>>> later if that's needed.
>>
>> I find the naming scheme An-Bn-Cn good, I'm arguing that it's not needed
>> everywhere, opcode only commands are better off with it, I think.
> 
> Ok, I can drop the -0-0 in this case if you prefer.

Not needed. Just wanted to make sure we have a unified way of dealing
with the protocol modes. Having WREN-1-0-0 and WREN-8d-0-0 is not that
bad after all, it allows you to specify the number of lines directly,
without mangling the op afterwards.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks for the patience. I'll check the other patches next week.
Cheers,
ta

