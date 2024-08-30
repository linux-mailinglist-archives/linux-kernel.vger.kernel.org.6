Return-Path: <linux-kernel+bounces-309246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0303B966808
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2DD281D32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D11BA86F;
	Fri, 30 Aug 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpuTA05M"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4515C153
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039199; cv=none; b=hZe7Akk2K/lOXHpFVxyt6hMwAGHZGdEQC6+PSRHZUOlPCvG++lV71Cwc7lxuYSswIPsfvhY8xFUrNxIVSNrvmrrMOuARRbrbMwaWDuhU5DXOJk0hghU8YEmrfmR3RngKE2AOiSzsSb70AXt+khMsosC5uQh/0tLtrDJZWsaMV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039199; c=relaxed/simple;
	bh=cMyRDfKyhHQtKZukwkD37KVKnyiAk84cu9cwVX6XobY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4f4Be6sT1niHef0TIugznq4lSRRxOqniFLW5aYXkpVOjwGvN+qzcpBD7M46KFi7SQucVg415lcFJOWk6sKktNS6Rx1yphEz5ajdsy5k0rRhA6vUvk4eh/GR2sTbBLk9L+OEOAlqr9/l3wlRo9r+fCvZQKflPwwdwhawNMttqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpuTA05M; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cd9d408040so1524687a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725039197; x=1725643997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F39e+bMIkfPX4WRuBw2mb+AJTkcDejFN4PI0EYbN7q8=;
        b=dpuTA05MYJT9FPl96XGQX5Ta9dJ1kTTAsu+MBB4RnusoLaymeOacbMpJ7HZvitl7v4
         jTbrGradBPdz9YOlIyDq4UZTe3dBoLexoxuuNFpe7gaBrIEZMx8iC+GVn59FZad9JUmZ
         EUzKMXX0oUXzYI4PQomgc5GprITIEBWXDwyjoHuRwk0hDufLhDJGJWDntQkF8ZL/rjym
         JGaMcE3kGGI11EisExamaUQkm81Ql7zV2eAAh6ngZZjkG38oDzCt0k7v3OA1m4xeTxCo
         h9HvWCpS8zsbaI13cbLq/74Ps3vtcB4pwDLC3WnsPLHz7xcVZyo+c2jie0fCVSaJkOce
         I1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039197; x=1725643997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F39e+bMIkfPX4WRuBw2mb+AJTkcDejFN4PI0EYbN7q8=;
        b=DVjTOavlEvAmoHDIc+z/ts3f/FlsEC1lIY+f0TO5/JDTp33KQ90TQXxmSl1PUMLu0V
         NBUJn49hdphQOyDeS5pP+716vXN9EsGTPmTOtxL0/SIu6+NL755kyUiTYo+eEJ4tQcct
         7cIjrMZbItE5t22dDRbV2MkMLvbdemRgst6NYl7Bj0QbU0Z2zLG3aqVBQIwS5kUkhqbw
         oOtM7t8okscpHl6rybzcBM5QxrBnEpdncgQ8s0gZ2m0ZBdqLi2AAb2GKY74Ot+Hw0GAF
         okDH27al1ZwwxRJO97CdAsrXx64PQNujdh2EjdZ5pfC9RiLu0V7LnMfjQPoE3f/jwdWd
         pEdw==
X-Forwarded-Encrypted: i=1; AJvYcCXrhGQGoTBT8dPlu5bGS7S8StRo7iU5pqsyPov+QeWM9FmpX31lpQa/OLxTCmY8zTCAJaa+GK4JcVRJHwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+83ont9bimIE5Y6p+lQD4cJF4pgNV18QRLTHXjoddqo2FS4zP
	ZPxThDd6rljbJsBG0YR/8I6fV/wuVQuG/DhxAlcOJlfqPooiSj2J
X-Google-Smtp-Source: AGHT+IEGzmWBT7+AS0gRi5wgz9yELMzMlyj/gK+m8LMRNdQILA4SvlWqNsNbnJqBbvESPqAQCZIkbw==
X-Received: by 2002:a17:90a:5143:b0:2cc:ff56:5be3 with SMTP id 98e67ed59e1d1-2d8561ce627mr7177701a91.19.1725039196641;
        Fri, 30 Aug 2024 10:33:16 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b145b61sm4128478a91.32.2024.08.30.10.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:33:15 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:33:13 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] lib: benchmark bitmap sets binary operation find
Message-ID: <ZtICWbRiTuPcN6mT@yury-ThinkPad>
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
 <20240829135926.926603-6-mathieu.desnoyers@efficios.com>
 <ZtHptgtLhgpGQTga@yury-ThinkPad>
 <ab577998-946a-4844-a67f-60d17a31ed3c@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab577998-946a-4844-a67f-60d17a31ed3c@efficios.com>

On Fri, Aug 30, 2024 at 12:07:53PM -0400, Mathieu Desnoyers wrote:
> On 2024-08-30 17:48, Yury Norov wrote:
> > On Thu, Aug 29, 2024 at 09:59:25AM -0400, Mathieu Desnoyers wrote:
> > > Benchmark the following bitmap find functions applying binary operations
> > > on sets of two bitmaps:
> > > 
> > > - find_first_andnot_bit,
> > > - find_first_nor_bit,
> > > - find_next_andnot_bit,
> > > - find_next_nor_bit,
> > > - find_next_or_bit.
> > > 
> > > Note that find_first_or_bit is not part of the current API, so it is not
> > > covered.
> > 
> > Can you please show how the test output looks on your system now? I'll
> > add that in commit message.
> 
> Start testing find_bit() with random-filled bitmap
> find_next_bit:                  576314 ns, 163810 iterations
> find_next_zero_bit:             626847 ns, 163871 iterations
> find_last_bit:                  465050 ns, 163810 iterations
> find_nth_bit:                  2720718 ns,  16329 iterations
> find_first_bit:                1409431 ns,  16330 iterations
> find_first_and_bit:           15216406 ns,  40975 iterations
> find_next_and_bit:              324624 ns,  81708 iterations
> find_first_andnot_bit:           23856039 ns,  40955 iterations
> find_next_andnot_bit:              327734 ns,  82103 iterations
> find_first_nor_bit:           21911075 ns,  40956 iterations
> find_next_nor_bit:              345315 ns,  81919 iterations
> find_next_or_bit:              886338 ns, 245762 iterations
> 
> Start testing find_bit() with sparse bitmap
> find_next_bit:                    8870 ns,    656 iterations
> find_next_zero_bit:            1188951 ns, 327025 iterations
> find_last_bit:                    8380 ns,    656 iterations
> find_nth_bit:                  1110068 ns,    655 iterations
> find_first_bit:                 455799 ns,    656 iterations
> find_first_and_bit:               6521 ns,      2 iterations
> find_next_and_bit:                3540 ns,      2 iterations
> find_first_andnot_bit:             785844 ns,    655 iterations
> find_next_andnot_bit:                8950 ns,    655 iterations
> find_first_nor_bit:          338646832 ns, 326373 iterations

0.3 sec is too much. Consider a slower CPU where it may be 10
times slower... Can you keep that in a range of few milliseconds?
It's more than enough to grab stable perf results.

> find_next_nor_bit:             1264144 ns, 326372 iterations
> find_next_or_bit:               14020 ns,   1309 iterations

Before the columns were all aligned. Can you please send a v3
with this fixed, and address the other comments?

Thanks,
Yury

> 
> Relevant lscpu output:
> 
> Architecture:             x86_64
>   CPU op-mode(s):         32-bit, 64-bit
>   Address sizes:          52 bits physical, 57 bits virtual
>   Byte Order:             Little Endian
> CPU(s):                   384
>   On-line CPU(s) list:    0-383
> Vendor ID:                AuthenticAMD
>   Model name:             AMD EPYC 9654 96-Core Processor
>     CPU family:           25
>     Model:                17
>     Thread(s) per core:   2
>     Core(s) per socket:   96
>     Socket(s):            2
>     Stepping:             1
>     Frequency boost:      enabled
>     CPU(s) scaling MHz:   100%
>     CPU max MHz:          3709.0000
>     CPU min MHz:          400.0000
>     BogoMIPS:             4799.80
>     Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
>                           fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc cpuid extd_apicid aperfmperf rap
>                           l pni pclmulqdq monitor ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_leg
>                           acy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb
>                           bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgsbase
>                            bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni
>                            avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local user_shstk avx512_b
>                           f16 clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushby
>                           asid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pku ospke
>                           avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq la57 rdpid overflow_recov succor smca fsrm
>                            flush_l1d debug_swap
> Virtualization features:
>   Virtualization:         AMD-V
> Caches (sum of all):
>   L1d:                    6 MiB (192 instances)
>   L1i:                    6 MiB (192 instances)
>   L2:                     192 MiB (192 instances)
>   L3:                     768 MiB (24 instances)
> NUMA:
>   NUMA node(s):           24
>   NUMA node0 CPU(s):      0-7,192-199
>   NUMA node1 CPU(s):      8-15,200-207
>   NUMA node2 CPU(s):      16-23,208-215
>   NUMA node3 CPU(s):      24-31,216-223
>   NUMA node4 CPU(s):      32-39,224-231
>   NUMA node5 CPU(s):      40-47,232-239
>   NUMA node6 CPU(s):      48-55,240-247
>   NUMA node7 CPU(s):      56-63,248-255
>   NUMA node8 CPU(s):      64-71,256-263
>   NUMA node9 CPU(s):      72-79,264-271
>   NUMA node10 CPU(s):     80-87,272-279
>   NUMA node11 CPU(s):     88-95,280-287
>   NUMA node12 CPU(s):     96-103,288-295
>   NUMA node13 CPU(s):     104-111,296-303
>   NUMA node14 CPU(s):     112-119,304-311
>   NUMA node15 CPU(s):     120-127,312-319
>   NUMA node16 CPU(s):     128-135,320-327
>   NUMA node17 CPU(s):     136-143,328-335
>   NUMA node18 CPU(s):     144-151,336-343
>   NUMA node19 CPU(s):     152-159,344-351
>   NUMA node20 CPU(s):     160-167,352-359
>   NUMA node21 CPU(s):     168-175,360-367
>   NUMA node22 CPU(s):     176-183,368-375
>   NUMA node23 CPU(s):     184-191,376-383
> Vulnerabilities:
>   Gather data sampling:   Not affected
>   Itlb multihit:          Not affected
>   L1tf:                   Not affected
>   Mds:                    Not affected
>   Meltdown:               Not affected
>   Mmio stale data:        Not affected
>   Reg file data sampling: Not affected
>   Retbleed:               Not affected
>   Spec rstack overflow:   Vulnerable
>   Spec store bypass:      Vulnerable
>   Spectre v1:             Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers
>   Spectre v2:             Vulnerable; IBPB: disabled; STIBP: disabled; PBRSB-eIBRS: Not affected; BHI: Not affected
>   Srbds:                  Not affected
>   Tsx async abort:        Not affected
> 
> 
> 
> > 
> > > 
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > ---
> > >   lib/find_bit_benchmark.c | 93 ++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 93 insertions(+)
> > > 
> > > diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> > > index aee2ebb6b3cd..3b16254dec23 100644
> > > --- a/lib/find_bit_benchmark.c
> > > +++ b/lib/find_bit_benchmark.c
> > > @@ -70,6 +70,44 @@ static int __init test_find_first_and_bit(void *bitmap, const void *bitmap2, uns
> > >   	return 0;
> > >   }
> > > +static int __init test_find_first_andnot_bit(void *bitmap, const void *bitmap2, unsigned long len)
> > > +{
> > > +	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
> > > +	unsigned long i, cnt;
> > > +	ktime_t time;
> > > +
> > > +	bitmap_copy(cp, bitmap, BITMAP_LEN);
> > > +
> > > +	time = ktime_get();
> > > +	for (cnt = i = 0; i < len; cnt++) {
> > > +		i = find_first_andnot_bit(cp, bitmap2, len);
> > > +		__clear_bit(i, cp);
> > > +	}
> > > +	time = ktime_get() - time;
> > > +	pr_err("find_first_andnot_bit: %18llu ns, %6ld iterations\n", time, cnt);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __init test_find_first_nor_bit(void *bitmap, const void *bitmap2, unsigned long len)
> > > +{
> > > +	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
> > > +	unsigned long i, cnt;
> > > +	ktime_t time;
> > > +
> > > +	bitmap_copy(cp, bitmap, BITMAP_LEN);
> > > +
> > > +	time = ktime_get();
> > > +	for (cnt = i = 0; i < len; cnt++) {
> > > +		i = find_first_nor_bit(cp, bitmap2, len);
> > > +		__set_bit(i, cp);
> > > +	}
> > > +	time = ktime_get() - time;
> > > +	pr_err("find_first_nor_bit: %18llu ns, %6ld iterations\n", time, cnt);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static int __init test_find_next_bit(const void *bitmap, unsigned long len)
> > >   {
> > >   	unsigned long i, cnt;
> > > @@ -148,6 +186,51 @@ static int __init test_find_next_and_bit(const void *bitmap,
> > >   	return 0;
> > >   }
> > > +static int __init test_find_next_andnot_bit(const void *bitmap,
> > > +		const void *bitmap2, unsigned long len)
> > > +{
> > > +	unsigned long i, cnt;
> > > +	ktime_t time;
> > > +
> > > +	time = ktime_get();
> > > +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > +		i = find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> > > +	time = ktime_get() - time;
> > > +	pr_err("find_next_andnot_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __init test_find_next_nor_bit(const void *bitmap,
> > > +		const void *bitmap2, unsigned long len)
> > > +{
> > > +	unsigned long i, cnt;
> > > +	ktime_t time;
> > > +
> > > +	time = ktime_get();
> > > +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > +		i = find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> > > +	time = ktime_get() - time;
> > > +	pr_err("find_next_nor_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __init test_find_next_or_bit(const void *bitmap,
> > > +		const void *bitmap2, unsigned long len)
> > > +{
> > > +	unsigned long i, cnt;
> > > +	ktime_t time;
> > > +
> > > +	time = ktime_get();
> > > +	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > +		i = find_next_or_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> > > +	time = ktime_get() - time;
> > > +	pr_err("find_next_or_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static int __init find_bit_test(void)
> > >   {
> > >   	unsigned long nbits = BITMAP_LEN / SPARSE;
> > > @@ -169,6 +252,11 @@ static int __init find_bit_test(void)
> > >   	test_find_first_bit(bitmap, BITMAP_LEN / 10);
> > >   	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 2);
> > >   	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
> > > +	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN / 2);
> > > +	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
> > > +	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN / 2);
> > > +	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
> > > +	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
> > >   	pr_err("\nStart testing find_bit() with sparse bitmap\n");
> > > @@ -187,6 +275,11 @@ static int __init find_bit_test(void)
> > >   	test_find_first_bit(bitmap, BITMAP_LEN);
> > >   	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
> > >   	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
> > > +	test_find_first_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
> > > +	test_find_next_andnot_bit(bitmap, bitmap2, BITMAP_LEN);
> > > +	test_find_first_nor_bit(bitmap, bitmap2, BITMAP_LEN);
> > > +	test_find_next_nor_bit(bitmap, bitmap2, BITMAP_LEN);
> > > +	test_find_next_or_bit(bitmap, bitmap2, BITMAP_LEN);
> > >   	/*
> > >   	 * Everything is OK. Return error just to let user run benchmark
> > > -- 
> > > 2.39.2
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

