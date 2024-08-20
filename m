Return-Path: <linux-kernel+bounces-294415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737C9958D61
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A700C1C237DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F01C7B6D;
	Tue, 20 Aug 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BUWxYGX1"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228121BD02F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174933; cv=none; b=g4lt+7QbvAAPG6lIUQM5AgXZveDBc4KBpNQDxKrEIa52L9rrsZ4mMigMkaj4JZZJQEaPWveWqnXHOTuzcUzGs30dm9vphQzA80EPmL6xqJL9e/p/XCjfm36AKS3R70ihQuRvZlI5v+WnDuZjvgndYqC6qT1h42GmoG4KXwm/2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174933; c=relaxed/simple;
	bh=Q5fYmKYULDka1ncQXVT9J1I9G53oKjobX1TMEDueu1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJTyG17picxp7sFwhldCYUaVOFgRUn+QqwAX/cQl5li0Kum2IPPU3Qd1G2/SDJGAGPCagRvgu+ku1IIkw3+OJ9YTlc3jbcAEzKx+D1vRamuOCGii2lmn5J1FxZFePsDCVKRQLZTQVoM3zYpgpJju6vf4SCs63osE2mlbh7RcR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BUWxYGX1; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724174929;
	bh=Q5fYmKYULDka1ncQXVT9J1I9G53oKjobX1TMEDueu1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BUWxYGX1TkD2MC1s7lyyPMpi+tLofjd5CaP0KPSLYVDYK0orviQh250R/oIDleyjE
	 +XsH9c4cGxLQmul//d+EdIB9ZjlsySw5LU4UseSLnM/CQzEzyi69LeeV1t4u/nBPCE
	 9s1LnRHMsL0jwJ0vocoJb5DuUhgiDmloRrox+XD5JoPCJq+WpQ3CBMF9HUC1Ysi60W
	 WyxzzPshLQMEDlp4ZQ5MqXzQVOP8DV2lNCSAmp8xgrKSIF241RFnULJTCJNVP/obsr
	 4lJxJi6AD1i+/1l7+a25rJVLiGjyyAtv5tcaQZrPC/DqEI4iZoeid+UCOWGvZY/aUV
	 wzGZG09Cqqd1g==
Received: from [192.168.1.5] (109.56.13.38.mobile.3.dk [109.56.13.38])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WpGf80Zmvz1Hk9;
	Tue, 20 Aug 2024 13:28:47 -0400 (EDT)
Message-ID: <95696d34-99ed-4911-a247-20ae42848451@efficios.com>
Date: Tue, 20 Aug 2024 19:28:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] cpumask: Implement
 cpumask_{first,next}_{not,}andnot
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
 <20240819142406.339084-3-mathieu.desnoyers@efficios.com>
 <ZsOcC_6S3_GviaIJ@yury-ThinkPad>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZsOcC_6S3_GviaIJ@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-19 21:24, Yury Norov wrote:
> On Mon, Aug 19, 2024 at 04:24:03PM +0200, Mathieu Desnoyers wrote:
>> Allow finding the first or next bit within two input cpumasks which is
>> either:
> 
> "first or next CPU..." here.
>   
>> - both zero and zero,
>> - respectively one and zero.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>   include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>
>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>> index 23686bed441d..57b7d99d6da1 100644
>> --- a/include/linux/cpumask.h
>> +++ b/include/linux/cpumask.h
>> @@ -204,6 +204,32 @@ unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
>>   				      cpumask_bits(srcp3), small_cpumask_bits);
>>   }
>>   
>> +/**
>> + * cpumask_first_andnot - return the first cpu from *srcp1 & ~*srcp2
>> + * @src1p: the first input
>> + * @src2p: the second input
>> + *
>> + * Returns >= nr_cpu_ids if no cpus match in both.
>> + */
>> +static inline
>> +unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
> 
> Please use __always_inline to enforce a compile-time optimizations.
> Check for this series:
> https://lore.kernel.org/lkml/20240719005127.2449328-4-briannorris@chromium.org/T/

I'll use __always_inline in both bitmap and cpumask patches.

I'll update this patch to rename notandnot to zero_and.

Thanks,

Mathieu

> 
> It's already in -next.
> 
> Thanks,
> Yury
> 
>> +{
>> +	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
>> +}
>> +
>> +/**
>> + * cpumask_first_notandnot - return the first cpu from ~*srcp1 & ~*srcp2
>> + * @src1p: the first input
>> + * @src2p: the second input
>> + *
>> + * Returns >= nr_cpu_ids if no cpus match in both.
>> + */
>> +static inline
>> +unsigned int cpumask_first_notandnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
>> +{
>> +	return find_first_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
>> +}
>> +
>>   /**
>>    * cpumask_last - get the last CPU in a cpumask
>>    * @srcp:	- the cpumask pointer
>> @@ -246,6 +272,40 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>>   	return find_next_zero_bit(cpumask_bits(srcp), small_cpumask_bits, n+1);
>>   }
>>   
>> +/**
>> + * cpumask_next_andnot - return the next cpu from *srcp1 & ~*srcp2
>> + * @n: the cpu prior to the place to search (ie. return will be > @n)
>> + * @src1p: the first input
>> + * @src2p: the second input
>> + *
>> + * Returns >= nr_cpu_ids if no cpus match in both.
>> + */
>> +static inline
>> +unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
>> +{
>> +	/* -1 is a legal arg here. */
>> +	if (n != -1)
>> +		cpumask_check(n);
>> +	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
>> +}
>> +
>> +/**
>> + * cpumask_next_notandnot - return the next cpu from ~*srcp1 & ~*srcp2
>> + * @n: the cpu prior to the place to search (ie. return will be > @n)
>> + * @src1p: the first input
>> + * @src2p: the second input
>> + *
>> + * Returns >= nr_cpu_ids if no cpus match in both.
>> + */
>> +static inline
>> +unsigned int cpumask_next_notandnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
>> +{
>> +	/* -1 is a legal arg here. */
>> +	if (n != -1)
>> +		cpumask_check(n);
>> +	return find_next_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
>> +}
>> +
>>   #if NR_CPUS == 1
>>   /* Uniprocessor: there is only one valid CPU */
>>   static inline unsigned int cpumask_local_spread(unsigned int i, int node)
>> -- 
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


