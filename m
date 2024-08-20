Return-Path: <linux-kernel+bounces-294392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9775958D21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FBA28600B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2359719EEC9;
	Tue, 20 Aug 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Cf/ZNmFT"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AF18C92C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174405; cv=none; b=NrLLZt0od6DaFHt1SVCRaMpyH09HG3o3E9fNscqWI2c2uHp84f3HczCXbnXNXa5l9NRMoKzRq3THBWrGiueZfMaHaXjVOhlhKCldPPS4BtB9keMv+bodYq5RBi7TWr1GTRx4bzuKZg5N5hVx6tAoeCVvAyUFqc9UF3/+SVt2Fjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174405; c=relaxed/simple;
	bh=ZBjM3oDbzYEB1m2KtRhu294y2K5/gwNRYjPLvCdzvSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWQZ5U4yohMBTjLHqMTljhqEtVg531zMeweBdydhwod9NwDXgUj8O/fADXqKI7fV5/rcP8in5hJ+XRx470hEsYo1XX1wB1aGLQDzXpdAAbUi4pPovNt8HX9yLOQwv0No8+Z8nDKmIoUo1eVkuhXdCp91k4gM9lU0yZ01oRpynxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Cf/ZNmFT; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724174395;
	bh=ZBjM3oDbzYEB1m2KtRhu294y2K5/gwNRYjPLvCdzvSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cf/ZNmFTlf+AaeUWY6AQUeX1a/I4bhArk7ZD+qKF8dEttnoobwDZrAduBtla3W9+v
	 Eq1CjOqmvPgV5iOWE6k0wVtiyK3JUO1FxpGdY2Lbt0FcY6fZgtltQ/WKM0uv4VGKt3
	 wb20U4WUEANKeFrbQqM4zkxovpdlbHEWtO8U4tAr+7d4XDq88o22FX4Jwc4W88ZfzB
	 aGqR4UMjNKL9Y11MNeCe2CCwODWeeFaNxklz6UkPtzGWSk5Ueq/OnlVZEAuzS4ILG6
	 AUo/8Cr6z7Rel73W7b9wqN/CflwZih1IdniBiiJv2vAEY366PjRC2GjJgatfoCDwCK
	 lGVM0UC4//AFg==
Received: from [192.168.1.5] (109.56.13.38.mobile.3.dk [109.56.13.38])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WpGRs1Bgzz1HsD;
	Tue, 20 Aug 2024 13:19:53 -0400 (EDT)
Message-ID: <1207b505-0842-40cc-a581-44e595f67601@efficios.com>
Date: Tue, 20 Aug 2024 19:19:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] lib: Implement
 find_{first,next,nth}_notandnot_bit, find_first_andnot_bit
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
 <20240819142406.339084-2-mathieu.desnoyers@efficios.com>
 <ZsOatkpPqzMF6B_c@yury-ThinkPad>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZsOatkpPqzMF6B_c@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-19 21:19, Yury Norov wrote:
[...[> Can you split rewording of existing comments out to a separate patch
> please?

Will do.

> 
>>    */
>>   static inline
>>   unsigned long find_next_andnot_bit(const unsigned long *addr1,
>> @@ -131,6 +138,36 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
>>   }
>>   #endif
>>   
>> +#ifndef find_next_notandnot_bit
> 
> Don't protect new functions. This is only for those having arch
> implementation, and it's only armv7 now.

OK

> 
>> +/**
>> + * find_next_notandnot_bit - find the next bit cleared in both *addr1 and *addr2
>> + * @addr1: The first address to base the search on
>> + * @addr2: The second address to base the search on
>> + * @size: The bitmap size in bits
>> + * @offset: The bitnumber to start searching at
>> + *
>> + * Returns the bit number for the next bit cleared in both *addr1 and *addr2.
>> + * If no such bits are found, returns @size.
>> + */
>> +static inline
>> +unsigned long find_next_notandnot_bit(const unsigned long *addr1,
>> +		const unsigned long *addr2, unsigned long size,
>> +		unsigned long offset)
>> +{
>> +	if (small_const_nbits(size)) {
>> +		unsigned long val;
>> +
>> +		if (unlikely(offset >= size))
>> +			return size;
>> +
>> +		val = (~*addr1) & (~*addr2) & GENMASK(size - 1, offset);
>> +		return val ? __ffs(val) : size;
>> +	}
>> +
>> +	return _find_next_notandnot_bit(addr1, addr2, size, offset);
>> +}
>> +#endif
>> +
> 
> It's not said explicitly, but some naming conventions exist around bitmap
> searching.
> 
> If you're looking for a clear (unset) bit in a mask, you'd use a 'zero'
> modifier. We have only 2 such functions now: find_{first,next}_zero_bit,
> both taking one bitmap. I think it's time to extend this rule for
> many bitmaps and write down the naming rules.
> 
> With the following, the find_next_notandnot_bit() should be named
> like; find_next_zero_and_bit(). It's not perfect, but still sounds
> better to me than 'notandnot' thing.
> 
> If we search for a set bit in bitmap, we use find_first or find_next
> prefixes:
>   - find_first_bit;
>   - find_next_bit.
> 
> If we'd like to pass an additional bitmap to AND, OR or XOR with the
> 1st bitmap, we provide as corresponding logical operation as
> suffix(es):
>   - find_first_and_bit(b1, b2) : b1 & b2;
>   - find _next_and_or_bit(b1, b2, b3) : b1 & b2 | b3.
> 
> If additional bitmap must be inverted, we provide a 'not' after the
> corresponding logical operation:
>   - find_first_andnot_bit(b1, b2) : b1 & ~b2;
>   - find _next_and_ornot_bit(b1, b2, b3) : b1 & b2 | ~b3.
> 
> If all bitmaps have to be inverted, or in other words, we are looking
> for an unset bit in a bitmap or a combination of bitmaps, we provide
> a 'zero' prefix in the function name:
>   - find_next_zero_bit;
>   - find_next_zero_and_bit;
>   - find_next_zero_and_or_bit;
> 
> Functions having 'zero' prefix should not negate bitmaps (should not
> have 'not' in names) because of commutative property. For example,
> find_next_zero_andnot_bit(), which is ~b1 & ~(~b2) is redundant
> because it's the same as find_next_andnot_bit() : b2 & ~b1.
> 
> Iterators over unset bits in bitmap(s) (those based on 'zero' search
> functions) should have a 'clear' prefix in the name:
>   - for_each_clear_bit;
>   - for_each_clear_bit_from;
> 
> I should probably put the above on top of the file...

I'll do this for the next round. Yes, it would be good to add
those explanations on top of the file.

Thanks for the review !

Mathieu

> 
> Thanks,
> Yury

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


