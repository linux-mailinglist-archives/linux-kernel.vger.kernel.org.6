Return-Path: <linux-kernel+bounces-409358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B89C8BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44213282C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CE1F8EE1;
	Thu, 14 Nov 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HdXDqE5y"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4911F9EDA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590379; cv=none; b=OUWPfSqEKyVsC+XUZKmJYKPgxYOldIDntrWrjx2mYQLEduGbh5VzbDZaRqamsMdMPMWdBLMaXJJs9Vpk67S5eAANLqI/+mI2eew2srwhvoYyhUB9xPoQv45BeJOhWyNJe3oLiC9fdaULHtTTXvIln4ToJu+Et4yeCDr1AQCxl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590379; c=relaxed/simple;
	bh=k5bdHEkHI+7qm16BcckWB6olotXkJAzzCTF6gVzaHpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRCkKlNQbn1Wz9ay1AMectRnamucwHh8CgjRHNpAiwrM6tAZGLWQHXD2J2vq4lZhZUyoFepiJaXk3/ez3rVmxjbZIP4bxILV1+PVikZCFG99J/x18zd+EFTwGke2gwkxwqlLpXy4c6S2gqwsnl64hP4bdAi9vbnjIiH2yJBPyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HdXDqE5y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314b316495so5569945e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731590376; x=1732195176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y256fO/7FLvsIPtMyIQsdIYn0IXGJMedZoA52rfCGR4=;
        b=HdXDqE5yYAEEaP8V9Coe2/6e+YOegPXzHe3HDK1LzybPuAdAlXh77p2zQD5GMOOYm9
         qU7mtQZZjbtQ37vZ8hYKOCgEmY9HATPt962tXaKNzWTJ9xokIvPrsdp8/JBTph68uK1P
         ARJEwGNfohQPow59f4unbq6WPnMWi0S4ruCydFxp90QTCl/D2OPEydjvbU/4Xa5jmJP7
         feL+9K9+ydqgVuKxK33d8JlWM+50KXNT6vT1WL6LH3SAfCf+cwJgn0FQwSU/0gH9fSA7
         i4coYROwv6ucsrc5XaiD+csmkDccBkluKLoggXbQ6OKZVewLe95CovMKuNdHS+udFThD
         4Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731590376; x=1732195176;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y256fO/7FLvsIPtMyIQsdIYn0IXGJMedZoA52rfCGR4=;
        b=snBOGvTgZ+f+wrdZFm/WFBGIwtfhUvY5EqUOIA/OE/UefEzTA2zIVY553+l5Lu20OL
         OqcJNC832z3CnySTVoqkd/CpsMVlOqhGx+2zbqbABYhSPCek8YvnfVzOgmfq4J92xFky
         cHEIlFdj++nUMsY47B9rPhnr1Cwq0j0cX8/Vr/ik/nVo9D+xLHM6psZSN/RenYtdEpYo
         krmVm4NetKMcjB5Ni7Tj8jo1fZK6By3BA8YslquXNpiPZA+wNn9GdjOPgfSgLDqxa5Zi
         eoyxQjmkqN9lWmpaXBV3MYgESUPOFHXwAwiE+67k1S7m36s/VQKkZK23YmoZaUYd6o0x
         Jg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXefIwDKhRSz5Pgv8ZugTvIivGKwKzt9bK3Gs9UtYsvmkBAN5FkpcV4gjAeTrTvd0AWeeODboEen+BlOi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5KkT1jVbLWuvnYYmCKARCrV5oCGwcSVyk816iiOhr5sXF1rV
	IvamGICgRYLwXg2lcXhVdiVb03+2OsdI8phri3fFA9wWFbhLz3MgMwV9mYEP/wIjQtNrqVf2LnV
	a
X-Google-Smtp-Source: AGHT+IH43n6j+63XUTW/SUFmWSG22ER/itpfF+9ApEvdxGJZx4vj55nly+HXGsJTMqFoz6cPC+IILQ==
X-Received: by 2002:a05:600c:46c8:b0:431:51e5:22fb with SMTP id 5b1f17b1804b1-432d4aaf30fmr65184235e9.14.1731590375784;
        Thu, 14 Nov 2024 05:19:35 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265e16sm23740885e9.12.2024.11.14.05.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:19:35 -0800 (PST)
Message-ID: <d5708abe-40ed-4885-919c-b491f61cceb7@suse.com>
Date: Thu, 14 Nov 2024 15:19:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] x86/microcode/AMD: Make __verify_patch_size() return
 bool
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <20241018155151.702350-1-nik.borisov@suse.com>
 <20241018155151.702350-3-nik.borisov@suse.com>
 <20241114125818.GFZzXz6vdhwPdSa4dk@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20241114125818.GFZzXz6vdhwPdSa4dk@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.11.24 г. 14:58 ч., Borislav Petkov wrote:
> On Fri, Oct 18, 2024 at 06:51:50PM +0300, Nikolay Borisov wrote:
>> The result of that function is in essence boolean, so simplify to return
>> the result of the relevant expression. It also makes it follow the
>> convetion used by __verify_patch_section(). No functional changes.
> 
> convetion used by __verify_patch_section(). No functional changes.
> Unknown word [convetion] in commit message.
> Suggestions: ['convection', 'convention', 'conversion', 'confection', 'conviction', 'connection', 'confession']
> 
> You need a spellchecker. :)
> 
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   arch/x86/kernel/cpu/microcode/amd.c | 11 +++--------
>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
>> index 9986cb85c951..37a428b109a2 100644
>> --- a/arch/x86/kernel/cpu/microcode/amd.c
>> +++ b/arch/x86/kernel/cpu/microcode/amd.c
>> @@ -282,7 +282,7 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
>>    * exceed the per-family maximum). @sh_psize is the size read from the section
>>    * header.
>>    */
>> -static unsigned int __verify_patch_size(u32 sh_psize, size_t buf_size)
>> +static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
>>   {
>>   	u8 family = x86_family(bsp_cpuid_1_eax);
>>   	u32 max_size;
> 
> You missed a spot here for the >= 0x15 families. And I think this is more
> readable and more precise what is supposed to be checked here:
> 
> ---
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 8bd79ad63437..0211c62bc4c4 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -289,7 +289,7 @@ static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
>   	u32 max_size;
>   
>   	if (family >= 0x15)
> -		return min_t(u32, sh_psize, buf_size);
> +		return sh_psize == min_t(u32, sh_psize, buf_size);

Indee.

>   
>   #define F1XH_MPB_MAX_SIZE 2048
>   #define F14H_MPB_MAX_SIZE 1824
> @@ -306,7 +306,7 @@ static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
>   		return 0;
>   	}
>   
> -	return sh_psize <= min_t(u32, buf_size, max_size);
> +	return sh_psize == min_t(u32, buf_size, max_size);

For the older families we have a hard upper bound so we want to ensure 
that the size in the header is strictly <= than buf_size, which in turn 
must be <= max_size .


i.e Is it not valid to have sh_psize < buf_size rather than strictly equal ?

>   }
>   
>   /*
> 


