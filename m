Return-Path: <linux-kernel+bounces-299642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F295D80C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA971F22C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C320192B89;
	Fri, 23 Aug 2024 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="T/oDff3n"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1C1953BA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446174; cv=none; b=HvwWQQtLcAw0vCkFLcFLcenQr/xQpC+2DJxyRm0Speq7EVXLJxttZJgYsK4crqBpw4GVbwVbKBjcZxNBzINs/SJI2zyO3qbGumoYSArxU0w4Sm+uLk+BH8uhMWFCJC9z9FHqxMohBzDKS+pIHnv3cHfavM1Tzu7pK7MWh0tDPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446174; c=relaxed/simple;
	bh=fkYApqLOliW+Q8396E7qo7Gv6YIt7/8l+N5wYKTXeRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dbf63Mh6/y3QzmbjROHg3tEjal33bn5DKctwQEcTkNC6NL+Yo91PkldeE+dWhl/Hgwfrh/aJle27yKLXpfHhGpWjnrYTlMfnWGYSG7oWriEcAM99dNKkIIldYeDfs6ms+5F3LNrY1FBeoKnmeMgPkjzD9DTOXlaNDpK1WLsBtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=T/oDff3n; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724446170;
	bh=fkYApqLOliW+Q8396E7qo7Gv6YIt7/8l+N5wYKTXeRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T/oDff3n9QEwwbT2kyBE9WqoilqxyvEYLJ64Gf0QZtNvfWDqqzGUwAGz4r7pQep4X
	 QX2NmFwLYAUxKzG7vSUbyhoCf7BGBidTi/djwPZJwAjb+243ahGISuUCTeqQeAo07J
	 24W+UNZgmdUb2BYdTzl1eWXa1MQN0VSmL40JdQNRzDUGy3yWM0WMznFBEku0nzwtxZ
	 sIetRTHVZdsJwORo2ugYYj8apUl6YzF1bZTm9FWppMxtQ8rAMyjNdZGAA44wnLkDpm
	 rMDKGKYIxvPOlpWe3C8Ucd7rO7zREvL2JbPew+DdzVbgTLVZ2FGjgNGJISYhcHYcCe
	 e5cEFdjJticmQ==
Received: from [IPV6:2606:6d00:100:4000:b243:804e:3bbd:91c9] (unknown [IPv6:2606:6d00:100:4000:b243:804e:3bbd:91c9])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WrByL0hw5z1J6g;
	Fri, 23 Aug 2024 16:49:30 -0400 (EDT)
Message-ID: <c494e91f-abb1-4d09-acec-a6003bf8270b@efficios.com>
Date: Fri, 23 Aug 2024 16:49:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/6] cpumask: Implement
 cpumask_{first,next}_{nor,andnot}
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-4-mathieu.desnoyers@efficios.com>
 <Zsjgjh1V3wf0gwbd@yury-ThinkPad>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Zsjgjh1V3wf0gwbd@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-23 21:18, Yury Norov wrote:
> On Fri, Aug 23, 2024 at 02:59:43PM -0400, Mathieu Desnoyers wrote:
>> Allow finding the first or next bit within two input cpumasks which is
>> either:
>>
>> - both zero and zero,
>> - respectively one and zero.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> Changes since v0:
>> - Rename "notandnot" to "nor".
>> - Use __always_inline.
>> ---
>>   include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>
>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>> index 23686bed441d..5573e75c13ec 100644
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
>> +static __always_inline
>> +unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
>> +{
>> +	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
> 
> 
> Here should be a small_cpumask_bits. This is better optimized for
> NR_CPUS < BITS_PER_LONG.

Will fix the 4 instances here for next round.

Thanks,

Mathieu

> 
>> +}
>> +
>> +/**
>> + * cpumask_first_nor - return the first cpu from ~(*srcp1 | *srcp2)
>> + * @src1p: the first input
>> + * @src2p: the second input
>> + *
>> + * Returns >= nr_cpu_ids if no cpus match in both.
>> + */
>> +static __always_inline
>> +unsigned int cpumask_first_nor(const struct cpumask *srcp1, const struct cpumask *srcp2)
>> +{
>> +	return find_first_nor_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
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
>> +static __always_inline
>> +unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
>> +{
>> +	/* -1 is a legal arg here. */
>> +	if (n != -1)
>> +		cpumask_check(n);
>> +	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
>> +}
>> +
>> +/**
>> + * cpumask_next_nor - return the next cpu from ~(*srcp1 | *srcp2)
>> + * @n: the cpu prior to the place to search (ie. return will be > @n)
>> + * @src1p: the first input
>> + * @src2p: the second input
>> + *
>> + * Returns >= nr_cpu_ids if no cpus match in both.
>> + */
>> +static __always_inline
>> +unsigned int cpumask_next_nor(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
>> +{
>> +	/* -1 is a legal arg here. */
>> +	if (n != -1)
>> +		cpumask_check(n);
>> +	return find_next_nor_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
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


