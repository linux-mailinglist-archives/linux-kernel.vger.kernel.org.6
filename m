Return-Path: <linux-kernel+bounces-371834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CA59A4107
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB271F24682
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5CF1D47CD;
	Fri, 18 Oct 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AXHR2PT9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A613C8E2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261377; cv=none; b=XrTmvm1ZUFY5WIXIovZp6al5ZPi6jDYupqjpIxSvfwyP7ui4JTXfyM8W/mh2IoB/4QZv27xet5fRLoHhzFLzveT8JLNaPrIjiaWDu8vmgBE+I6xYcLEaKxwmZX5sRslLYuxZBPuCfkacAYyA7EeI6MlISNYfmsMrDpHim2F2uj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261377; c=relaxed/simple;
	bh=DS31xoKzFNzDzcC2LoriMFmbRPpq+/4QXQt54ZyTCPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsdL+juygt6+NfsnQXNQ7UVWBCcbEB/JmQpIXBdE0hFOIaaFQhhLk4eeyR6nxSnz675XZcmGs3VmLSPqDSRt5jNYHj+o4OIa4xrV4Zh0gDbIDtXS2EWcMtHNQCV3pJThe1sgzMRzOFtrMyGnAAjIHv3kKgAKAYkpKq/BpNVLeyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AXHR2PT9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8XfDX017569;
	Fri, 18 Oct 2024 14:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ive6im
	Yrwk8d/lqN5FxzZtged4R92siMsXKM6jVE4Xg=; b=AXHR2PT9Puh8bbEZoMBczp
	O29o05gkyaZn19NeimKO2TBjFGSVetBQumDAcHssWLErH/CeSWwK4ifxy5IYHUu7
	fIf+L4WagxuzOlwwpjb+wHug7qUSNKREXNnZkk2TFiAkb6c/QpvY4h44pVEgK7uz
	jnRuEyALGQ7UCNQDNJsoU4M11PMjLmNWAk2GEu6sawPDoKcvJ5SVGEXWEk5ZDZPK
	girU8aNiNAaXk1jtk/Q+HvlqgVewIsyVOqibhEVI/XbDPF/6LyFTteyokxtdxaO3
	IRXnThXHeMlxTO+KFjaRsNUQHT3Is3wV5ppz1yxm/B4ukQuNN/q+c1OVNELFSnyw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u99np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 14:22:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IC5qr0002452;
	Fri, 18 Oct 2024 14:22:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284en527k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 14:22:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IEMHUf25690782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:22:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5914F20043;
	Fri, 18 Oct 2024 14:22:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 406CC20040;
	Fri, 18 Oct 2024 14:22:15 +0000 (GMT)
Received: from [9.39.22.247] (unknown [9.39.22.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 14:22:15 +0000 (GMT)
Message-ID: <e7d7a3d8-4b4a-47ff-8d69-a4c2e75d6818@linux.ibm.com>
Date: Fri, 18 Oct 2024 19:52:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Make ASYM_PACKING compile-time arch config
To: Christian Loehle <christian.loehle@arm.com>
Cc: x86@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <32c0aed9-bae1-4273-938d-36acb420eb56@arm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <32c0aed9-bae1-4273-938d-36acb420eb56@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W8veBnDey0G-qdz-HY7541WQ7Qd2fBDY
X-Proofpoint-ORIG-GUID: W8veBnDey0G-qdz-HY7541WQ7Qd2fBDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=643 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180088



On 10/18/24 03:16, Christian Loehle wrote:
> Only x86 and Power7 set SD_ASYM_PACKING at boot-time depending on the

Power10 on Shared Processor LPAR also enables that.

> system. All other platforms don't make use of asym-packing anyway,
> so introduce auxiliary ARCH_HAS_SCHED_ASYM_PACKING and guard all the
> related logic behind that so it isn't compiled when not needed.
> 
> On arm64 this reduces
> size kernel/sched/fair.o
>     text	   data	    bss	    dec	    hex	filename
>    74120	   4097	     88	  78305	  131e1	kernel/sched/fair.o
> to
> size kernel/sched/fair.o
>     text	   data	    bss	    dec	    hex	filename
>    72896	   4065	     88	  77049	  12cf9	kernel/sched/fair.o
> 
> Most of that is on the load-balance hot-path, in particular
> need_active_balance() reduces from 141 to 84 instructions.

This patch sprinkes #ifdef across the code. IMHO it makes the code 
difficult to read. Its possible to do slight such reductions for other 
group types as well, such as group_misfit_task(which allows right load 
balancing when SD_ASYM_CPUCAPACITY is on, except for a case when 
capacity is reduced due to side activity).

sd->flags should be cache hot and its a percpu variable. Hence the 
access to it shouldn't be costly. the branch predictors should do a good
job since it doesn't change often. Correct me if i am wrong.

> 
> hackbench -pTl 20000 on a rk3399 goes from
> 58.4664 to 57.6056 (-1.5%), mean over 20 iterations.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   arch/Kconfig         |  3 ++
>   arch/powerpc/Kconfig |  1 +
>   arch/x86/Kconfig     |  1 +
>   kernel/sched/fair.c  | 86 ++++++++++++++++++++++++++++++--------------
>   kernel/sched/sched.h |  8 ++++-
>   5 files changed, 71 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8af374ea1adc..9f6ec10723a3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1684,4 +1684,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>   config ARCH_NEED_CMPXCHG_1_EMU
>   	bool
...

