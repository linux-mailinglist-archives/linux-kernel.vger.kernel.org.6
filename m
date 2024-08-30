Return-Path: <linux-kernel+bounces-309130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9396668B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C18B2824E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456141B81AB;
	Fri, 30 Aug 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sQT/VZHi"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CB1B4C51
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034285; cv=none; b=tTwlYacQCL/u9IPRDp5NkrId6vR2Rmp0BW5RNzWts/yqZ/GDtj7q12fQl8mK7lKY32bAIpFqWI0Je+hSuO2RhS7a0+s0bsguo9M7fAhi90YUuA2dfujl6VRHZJ6w+HJUA7iBQok9AN3MQcOnD/F6l7xPflyubAuhj2lKgp/d9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034285; c=relaxed/simple;
	bh=SazL0GeHUvqITaELsOdk/Z+Qai6Y7zQpEB/FKqn5ElQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNusk6nSBuRF5HfZdu3NNIoNTVFqvS7ocUJhVtilUs2mKK54oAu+Chgh6T+5DdPiIV5932TmPBXlMK2di9hc3ykoKA9luQHrVz1LeRDpPKz9/EYurdlBGyyC6ZWJinVTtfB9rNOKf2k0y8Dl/7xgMNtYfQuUFYrzrnitYT0uwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=sQT/VZHi; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725034282;
	bh=SazL0GeHUvqITaELsOdk/Z+Qai6Y7zQpEB/FKqn5ElQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sQT/VZHi90WwfGh1B6N76OUNrjSRk+4McPwu5/2Zya56g6FV/sS7fht1n0FR2GM/n
	 whJ5t5Y1rUX7eiWMJFcCSW1D4dIhZ5jGsxu+OKot9gyvyDi2qiZQAIC/XvHANKifoR
	 NC/zQoMeP5EA5vnFXQw1+K5p40LYS7puPSeeS+hRb8B/zv0kd74R0bOL1I61JqWiec
	 WnBMyS+1uCcgzABoh5zk8ckzT8djH8ehofy/frFDDTjD3uRjSY2oSQwsmgTUe7Irsl
	 JDvloiKAqPpXTN0+eebKfTNnSuP2G+noqLFZCH1GAc1KYRqUcCYvbr+aogriGYBQLt
	 pbRGcCuhZXk0w==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwNSB1tFdz1Jjq;
	Fri, 30 Aug 2024 12:11:22 -0400 (EDT)
Message-ID: <3469aa9d-5883-4e02-bfa6-b36f49c207c3@efficios.com>
Date: Fri, 30 Aug 2024 12:10:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] lib: Extend bitmap find binary operations
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
 <ZtHrl_1DEku-VeQV@yury-ThinkPad>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZtHrl_1DEku-VeQV@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-30 17:56, Yury Norov wrote:
> On Thu, Aug 29, 2024 at 09:59:20AM -0400, Mathieu Desnoyers wrote:
>> Extend bitmap find.h and cpumask.h with additional binary operations
>> such as "nor".
>>
>> Also extend the testing and benchmark coverage of those bitmap find with
>> binary operations.
>>
>> This is useful for NUMA-aware rseq concurrency IDs which depend on this
>> series.
>   
> Hi Mathieu,
> 
> Thanks for the series! I appreciate your time nailing it down, and
> especially the tests provided. A couple nits is that we don't need
> an 'extern' specifier,  and would better avoid local statics, even
> in tests.

OK. I've mostly followed the style present in the files I modified.
I'm OK if you change that in place.

> 
> I'll fix that inplace and apply in bitmap-for-next. Can you share
> a link for your work that requires the new API? I need to point it
> when sending a merge request.

Here is the latest version posted, before I split the bitmap patches
into a serparate series:

https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/

Please note that I am currently doing additional tests/benchmarks/schedstat
instrumentation and bug fixes on the RSEQ numa-aware patch.

Thanks,

Mathieu

> 
> Thanks,
> Yury
>   
>> Mathieu Desnoyers (6):
>>    lib: Clarify comment on top of find_next_andnot_bit
>>    lib: Implement find_{first,next,nth}_nor_bit, for_each_nor_bit,
>>      find_first_andnot_bit
>>    lib: test bitmap sets binary operation iterators
>>    lib: Fix test_find_first_and_bit and test_find_next_and_bit benchmark
>>    lib: benchmark bitmap sets binary operation find
>>    cpumask: Implement cpumask_{first,next}_{nor,andnot}
>>
>>   include/linux/cpumask.h  |  60 +++++++++++++++++++
>>   include/linux/find.h     | 124 +++++++++++++++++++++++++++++++++++++--
>>   lib/find_bit.c           |  36 ++++++++++++
>>   lib/find_bit_benchmark.c | 103 ++++++++++++++++++++++++++++++--
>>   lib/test_bitmap.c        |  81 +++++++++++++++++++++++++
>>   5 files changed, 396 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


