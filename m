Return-Path: <linux-kernel+bounces-309091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8CC966616
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169A41F23D87
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21CEEEC3;
	Fri, 30 Aug 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SjD9dN+d"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B11B252B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033078; cv=none; b=kChxkIe/I1+LwodMB7g0h7UUMg8WvSS2fGwDJ/Fb9I3+GjhJMccbh5QAFjExH5m0N5gn4njkyHr/J9oCmtC9Bks2JigOFpQOQiN2ExUIVBMIHwc3kleLUXfXlxr1zIFRkxHsPeFcNTSQ1/1TFmiYpp24qaJ5vMisApYIcgMT7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033078; c=relaxed/simple;
	bh=M470PoS6Oq4sCGdF76Au7i7QwRTmAbmd8J4ltRBQsBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6p9dOpwX5HX9ILOYqWJ9dEwjxCJKEZyg279d+u6gtF70jNYH0jZbv6uD+FEOiGe99BPUcolh0KjGyl93aikiSPhBY4HV3a4C+1nuc9nJzFRrcJlzLn9k6/RpUvNbj4wPHZV1FWY70q8XThiBGjh5X1gze4FU4imVZfAg7pNakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SjD9dN+d; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725033063;
	bh=M470PoS6Oq4sCGdF76Au7i7QwRTmAbmd8J4ltRBQsBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SjD9dN+duK2XIKi+fBN1tQmDRKWFbWOf/EFBxkeESmcbsr9SVc5NBlvKKCF/ZESW8
	 Ju7YzgNWZgVV+ORVFPr1bb3rQDinyBdgHN7syvgpDXTjc2k2Khpfho3LL+SY065AiA
	 q9K1OcKDNUJ5bSnbTFnknyEsn+9muKUSHZueYqIXlnJq+JEcaq9MHGfTULTHnUtrm0
	 oXeaWw4T94ejl4ZMtafOGToXTwqq3Stln0+J/sxVKxPtuZKPPow9Ur3JxEw4FI7PEf
	 ipsjCy/1V28brKVxjTWMmEH2E246cQ/BBh8ACzGHfQEM67LQclsSO2dbCiTe19xV55
	 Cwtv7+6cPx5SA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwN0l0kMWz1JZJ;
	Fri, 30 Aug 2024 11:51:03 -0400 (EDT)
Message-ID: <86bb4c08-5706-4902-9ef5-a336123ba8e1@efficios.com>
Date: Fri, 30 Aug 2024 11:50:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] lib: Fix test_find_first_and_bit and
 test_find_next_and_bit benchmark
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
 <20240829135926.926603-5-mathieu.desnoyers@efficios.com>
 <ZtHpZzYE62qMvIFY@yury-ThinkPad>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZtHpZzYE62qMvIFY@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-30 17:46, Yury Norov wrote:
> On Thu, Aug 29, 2024 at 09:59:24AM -0400, Mathieu Desnoyers wrote:
>> Modify test_find_first_bit so it modifies a local copy of bitmap rather
>> than modifying the input bitmap, which removes the requirement of
>> placing it last in the tests.
>>
>> Calls to test_find_first_and_bit and test_find_next_and_bit are placed
>> after test_find_first_bit, which makes them use a bitmap entirely filled
>> rather than the expected bitmap (random-filled or sparse).
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>   lib/find_bit_benchmark.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
>> index d3fb09e6eff1..aee2ebb6b3cd 100644
>> --- a/lib/find_bit_benchmark.c
>> +++ b/lib/find_bit_benchmark.c
>> @@ -30,18 +30,20 @@ static DECLARE_BITMAP(bitmap, BITMAP_LEN) __initdata;
>>   static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
>>   
>>   /*
>> - * This is Schlemiel the Painter's algorithm. It should be called after
>> - * all other tests for the same bitmap because it sets all bits of bitmap to 1.
>> + * This is Schlemiel the Painter's algorithm.
>>    */
> 
> Good to drop it, moreover, the comment is incorrect - we set all bits
> to 0, not 1.
> 
>>   static int __init test_find_first_bit(void *bitmap, unsigned long len)
>>   {
>> +	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
> 
> This days we can allocate automatic variables, which is better than
> statics:
> 
>     unsigned long *cp __free(bitmap) = bitmap_alloc(len, GFP_KERNEL);
> 
> If no objections, I can fix it inplace. The rest of the series looks
> good. I'll add it in bitmap-for-next for testing shortly.

I'm ok with the in-place fix, thanks!

Mathieu

> 
> Thanks,
> Yury
> 
>>   	unsigned long i, cnt;
>>   	ktime_t time;
>>   
>> +	bitmap_copy(cp, bitmap, BITMAP_LEN);
>> +
>>   	time = ktime_get();
>>   	for (cnt = i = 0; i < len; cnt++) {
>> -		i = find_first_bit(bitmap, len);
>> -		__clear_bit(i, bitmap);
>> +		i = find_first_bit(cp, len);
>> +		__clear_bit(i, cp);
>>   	}
>>   	time = ktime_get() - time;
>>   	pr_err("find_first_bit:     %18llu ns, %6ld iterations\n", time, cnt);
>> -- 
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


