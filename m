Return-Path: <linux-kernel+bounces-309125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB2966679
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35628B21B23
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51A1B81C3;
	Fri, 30 Aug 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SR/9c5JA"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAB4D8AE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034101; cv=none; b=F42cHGHVv/nKpL5bBvjZOhYc2hZUDqwZulGcRNZqjKZbacD13iInhEDj/kuQ6qoD4IdF89gRteKh8CcGE6ntkrHABtY5cVY+nxWbvhFhIPjhlTZDndEVX5r+uyyDtoTVWzrouqAYLd0eVwtyz4HS2iq5Ke3wYWy5R1ACFbnsnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034101; c=relaxed/simple;
	bh=d7bW5ItJ77tkm4VSI99P2mukTBHVVYrpWlCNCSdu7SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehhuoYDp9iHtR3wsRQeuH2bSqSqJsy8vIAc7K5Mxw7RsBVMYV+9SmCNa+aXP4LWZFTM9LK/nq8qHHlXjgBC+Ik7xF3+F0AHk7WGyRfqaVnvFzBgthLt35f4oyD+ZDhjwKMPHv3PXWqbTzvdSaWZu3XePR7FNdHjVcs5MZRNATt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SR/9c5JA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725034096;
	bh=d7bW5ItJ77tkm4VSI99P2mukTBHVVYrpWlCNCSdu7SA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SR/9c5JA/ODFyClK/vXDthYPXr8mdiv6PwiJ4f9h4IZtNabaFYpY18Y4X00pcIIiK
	 6l91Z+Bg5NlLCkGKWUgO7EhpoMz6Nb2qAvjNuMeCyivv6RWCvb9Gr7Aa+wNXfrYdhK
	 80jWhUcDfp8GM9QxNun03ohi8SNnlGhOyC8F3QqFIHDUNYBPgz2kznn6puNWIh+kDo
	 DbqZerm697r9pS+NDbNtoFIXqHzts+qx4HEFQJmtVvyFIK4nSKujldRxW/SqUtFK8s
	 QqcREcZjOBZdkTXG8am5C/cFaH1qftS+nvnNteItoTlFJ57vbT5rMayINXsvHSon7C
	 AAFYwAV0rURYA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwNNb6sT9z1JXT;
	Fri, 30 Aug 2024 12:08:15 -0400 (EDT)
Message-ID: <ab577998-946a-4844-a67f-60d17a31ed3c@efficios.com>
Date: Fri, 30 Aug 2024 12:07:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] lib: benchmark bitmap sets binary operation find
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
 <20240829135926.926603-6-mathieu.desnoyers@efficios.com>
 <ZtHptgtLhgpGQTga@yury-ThinkPad>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZtHptgtLhgpGQTga@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-30 17:48, Yury Norov wrote:
> On Thu, Aug 29, 2024 at 09:59:25AM -0400, Mathieu Desnoyers wrote:
>> Benchmark the following bitmap find functions applying binary operations
>> on sets of two bitmaps:
>>
>> - find_first_andnot_bit,
>> - find_first_nor_bit,
>> - find_next_andnot_bit,
>> - find_next_nor_bit,
>> - find_next_or_bit.
>>
>> Note that find_first_or_bit is not part of the current API, so it is not
>> covered.
> 
> Can you please show how the test output looks on your system now? I'll
> add that in commit message.

Start testing find_bit() with random-filled bitmap
find_next_bit:                  576314 ns, 163810 iterations
find_next_zero_bit:             626847 ns, 163871 iterations
find_last_bit:                  465050 ns, 163810 iterations
find_nth_bit:                  2720718 ns,  16329 iterations
find_first_bit:                1409431 ns,  16330 iterations
find_first_and_bit:           15216406 ns,  40975 iterations
find_next_and_bit:              324624 ns,  81708 iterations
find_first_andnot_bit:           23856039 ns,  40955 iterations
find_next_andnot_bit:              327734 ns,  82103 iterations
find_first_nor_bit:           21911075 ns,  40956 iterations
find_next_nor_bit:              345315 ns,  81919 iterations
find_next_or_bit:              886338 ns, 245762 iterations

Start testing find_bit() with sparse bitmap
find_next_bit:                    8870 ns,    656 iterations
find_next_zero_bit:            1188951 ns, 327025 iterations
find_last_bit:                    8380 ns,    656 iterations
find_nth_bit:                  1110068 ns,    655 iterations
find_first_bit:                 455799 ns,    656 iterations
find_first_and_bit:               6521 ns,      2 iterations
find_next_and_bit:                3540 ns,      2 iterations
find_first_andnot_bit:             785844 ns,    655 iterations
find_next_andnot_bit:                8950 ns,    655 iterations
find_first_nor_bit:          338646832 ns, 326373 iterations
find_next_nor_bit:             1264144 ns, 326372 iterations
find_next_or_bit:               14020 ns,   1309 iterations

Relevant lscpu output:

Architecture:             x86_64
   CPU op-mode(s):         32-bit, 64-bit
   Address sizes:          52 bits physical, 57 bits virtual
   Byte Order:             Little Endian
CPU(s):                   384
   On-line CPU(s) list:    0-383
Vendor ID:                AuthenticAMD
   Model name:             AMD EPYC 9654 96-Core Processor
     CPU family:           25
     Model:                17
     Thread(s) per core:   2
     Core(s) per socket:   96
     Socket(s):            2
     Stepping:             1
     Frequency boost:      enabled
     CPU(s) scaling MHz:   100%
     CPU max MHz:          3709.0000
     CPU min MHz:          400.0000
     BogoMIPS:             4799.80
     Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
                           fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc cpuid extd_apicid aperfmperf rap
                           l pni pclmulqdq monitor ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_leg
                           acy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb
                           bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgsbase
                            bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni
                            avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local user_shstk avx512_b
                           f16 clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushby
                           asid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pku ospke
                           avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq la57 rdpid overflow_recov succor smca fsrm
                            flush_l1d debug_swap
Virtualization features:
   Virtualization:         AMD-V
Caches (sum of all):
   L1d:                    6 MiB (192 instances)
   L1i:                    6 MiB (192 instances)
   L2:                     192 MiB (192 instances)
   L3:                     768 MiB (24 instances)
NUMA:
   NUMA node(s):           24
   NUMA node0 CPU(s):      0-7,192-199
   NUMA node1 CPU(s):      8-15,200-207
   NUMA node2 CPU(s):      16-23,208-215
   NUMA node3 CPU(s):      24-31,216-223
   NUMA node4 CPU(s):      32-39,224-231
   NUMA node5 CPU(s):      40-47,232-239
   NUMA node6 CPU(s):      48-55,240-247
   NUMA node7 CPU(s):      56-63,248-255
   NUMA node8 CPU(s):      64-71,256-263
   NUMA node9 CPU(s):      72-79,264-271
   NUMA node10 CPU(s):     80-87,272-279
   NUMA node11 CPU(s):     88-95,280-287
   NUMA node12 CPU(s):     96-103,288-295
   NUMA node13 CPU(s):     104-111,296-303
   NUMA node14 CPU(s):     112-119,304-311
   NUMA node15 CPU(s):     120-127,312-319
   NUMA node16 CPU(s):     128-135,320-327
   NUMA node17 CPU(s):     136-143,328-335
   NUMA node18 CPU(s):     144-151,336-343
   NUMA node19 CPU(s):     152-159,344-351
   NUMA node20 CPU(s):     160-167,352-359
   NUMA node21 CPU(s):     168-175,360-367
   NUMA node22 CPU(s):     176-183,368-375
   NUMA node23 CPU(s):     184-191,376-383
Vulnerabilities:
   Gather data sampling:   Not affected
   Itlb multihit:          Not affected
   L1tf:                   Not affected
   Mds:                    Not affected
   Meltdown:               Not affected
   Mmio stale data:        Not affected
   Reg file data sampling: Not affected
   Retbleed:               Not affected
   Spec rstack overflow:   Vulnerable
   Spec store bypass:      Vulnerable
   Spectre v1:             Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers
   Spectre v2:             Vulnerable; IBPB: disabled; STIBP: disabled; PBRSB-eIBRS: Not affected; BHI: Not affected
   Srbds:                  Not affected
   Tsx async abort:        Not affected



> 
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>   lib/find_bit_benchmark.c | 93 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>
>> diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
>> index aee2ebb6b3cd..3b16254dec23 100644
>> --- a/lib/find_bit_benchmark.c
>> +++ b/lib/find_bit_benchmark.c
>> @@ -70,6 +70,44 @@ static int __init test_find_first_and_bit(void *bitmap, const void *bitmap2, uns
>>   	return 0;
>>   }
>>   
>> +static int __init test_find_first_andnot_bit(void *bitmap, const void *bitmap2, unsigned long len)
>> +{
>> +	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
>> +	unsigned long i, cnt;
>> +	ktime_t time;
>> +
>> +	bitmap_copy(cp, bitmap, BITMAP_LEN);
>> +
>> +	time = ktime_get();
>> +	for (cnt = i = 0; i < len; cnt++) {
>> +		i = find_first_andnot_bit(cp, bitmap2, len);
>> +		__clear_bit(i, cp);
>> +	}
>> +	time = ktime_get() - time;
>> +	pr_err("find_first_andnot_bit: %18llu ns, %6ld iterations\n", time, cnt);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init test_find_first_nor_bit(void *bitmap, const void *bitmap2, unsigned long len)
>> +{
>> +	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
>> +	unsigned long i, cnt;
>> +	ktime_t time;
>> +
>> +	bitmap_copy(cp, bitmap, BITMAP_LEN);
>> +
>> +	time = ktime_get();
>> +	for (cnt = i = 0; i < len; cnt++) {
>> +		i = find_first_nor_bit(cp, bitmap2, len);
>> +		__set_bit(i, cp);
>> +	}
>> +	time = ktime_get() - time;
>> +	pr_err("find_first_nor_bit: %18llu ns, %6ld iterations\n", time, cnt);
>> +
>> +	return 0;
>> +}
>> +
>>   static int __init test_find_next_bit(const void *bitmap, unsigned long len)
>>   {
>>   	unsigned long i, cnt;
>> @@ -148,6 +186,51 @@ static int __init test_find_next_and_bit(const void *bitmap,
>>   	return 0;
>>   }
>>   
>> +static int __init test_find_next_andnot_bit(const void *bitmap,
>> +		const void *bitmap2, unsigned long len)
>> +{
>> +	unsigned long i, cnt;
>> +	ktime_t time;
>> +
>> +	time = ktime_get();
>> +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
>> +		i = find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
>> +	time = ktime_get() - time;
>> +	pr_err("find_next_andnot_bit:  %18llu ns, %6ld iterations\n", time, cnt);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init test_find_next_nor_bit(const void *bitmap,
>> +		const void *bitmap2, unsigned long len)
>> +{
>> +	unsigned long i, cnt;
>> +	ktime_t time;
>> +
>> +	time = ktime_get();
>> +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
>> +		i = find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
>> +	time = ktime_get() - time;
>> +	pr_err("find_next_nor_bit:  %18llu ns, %6ld iterations\n", time, cnt);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init test_find_next_or_bit(const void *bitmap,
>> +		const void *bitmap2, unsigned long len)
>> +{
>> +	unsigned long i, cnt;
>> +	ktime_t time;
>> +
>> +	time = ktime_get();
>> +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
>> +		i = find_next_or_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
>> +	time = ktime_get() - time;
>> +	pr_err("find_next_or_bit:  %18llu ns, %6ld iterations\n", time, cnt);
>> +
>> +	return 0;
>> +}
>> +
>>   static int __init find_bit_test(void)
>>   {
>>   	unsigned long nbits = BITMAP_LEN / SPARSE;
>> @@ -169,6 +252,11 @@ static int __init find_bit_test(void)
>>   	test_find_first_bit(bitmap, BITMAP_LEN / 10);
>>   	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 2);
>>   	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
>> +	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN / 2);
>> +	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
>> +	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN / 2);
>> +	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
>> +	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
>>   
>>   	pr_err("\nStart testing find_bit() with sparse bitmap\n");
>>   
>> @@ -187,6 +275,11 @@ static int __init find_bit_test(void)
>>   	test_find_first_bit(bitmap, BITMAP_LEN);
>>   	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
>>   	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
>> +	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
>> +	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
>> +	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN);
>> +	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
>> +	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
>>   
>>   	/*
>>   	 * Everything is OK. Return error just to let user run benchmark
>> -- 
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


