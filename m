Return-Path: <linux-kernel+bounces-180009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A768C68CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B381F22D16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189F1553B7;
	Wed, 15 May 2024 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ov7/LuyW"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4A2F870
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783615; cv=none; b=rjB8wxAL3go4/aW6GtStYikftplMTV7qJNtprii3bmVhYIixY7zKH4fn5rVP5GHvml2ffIl9+OnYVJlaETBQtlROwIeiM7T1fzMl0+S+nFGNgabcIxMK2Mufq9swmKfWwz0lBkFILSEDcurmp3c/LggtJ7jLJMVtJUgS2KOvuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783615; c=relaxed/simple;
	bh=k1bCyCumxizzGFTm9qJLNZYgVVBjf4rZrpCFh2bKF5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQl983U8XRXA/D8nKUsvQcX6SpQYcWVX5/JiO94HBdbXGT2Nn98xNDBcs2hVSstrhzhHrYDbiRtrUT2kvzvVicizdQQDTzemI8XvdYUzieb/xxhX7raPiNWP/kDpMwUcL2QqdgJTMieTAmc8pgYqR5qGzq6FYmJeoZ9PS9Q9daU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ov7/LuyW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FDqgRx001582;
	Wed, 15 May 2024 14:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tvpkGNdW4WlTe3dzln5VUH8grDyyV2MkAYAqN2apO+8=;
 b=ov7/LuyWi//PMRW223w1ZZbH5XReB1vH2WZUBix+Ys0sZUuedtk9o7+8Ui+q0C6VvWBN
 L8mSqUzI34gmhlnE5q7P7s7YRVO053/K2YkFGzKNS3LZCl0hon5UMhJXB8pbtw8Yyvg+
 xu+T+CFf2T23FsYovXk0AutHX62b4C08Bs17xFAdwmM5VNNUfXuLmea4G1bnc1cBFlWf
 8UXhHkTfV92eP4NLvmZa+zoNOZlsYtL8MBVj2Xtm4YMPApV6UuHjPBIegHQq+QkCx1yP
 uIeFGm2yZ/MkrcZHuXkL+Qcv4AfzIBaeV26hBtGUDxQDYiDjUHtUcnqNie9TvD4Ef/xu tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4xab02kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 14:31:59 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FEVxx4000817;
	Wed, 15 May 2024 14:31:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4xab02kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 14:31:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FDcxo1005721;
	Wed, 15 May 2024 14:31:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2nq2umty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 14:31:58 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FEVtgB44892612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 14:31:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B7D05806A;
	Wed, 15 May 2024 14:31:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E88AC5803F;
	Wed, 15 May 2024 14:31:45 +0000 (GMT)
Received: from [9.79.176.152] (unknown [9.79.176.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 14:31:45 +0000 (GMT)
Message-ID: <17cc54c4-2e75-4964-9155-84db081ce209@linux.ibm.com>
Date: Wed, 15 May 2024 20:01:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <74ffd154-5d92-4303-9977-6ddc9accdf01@linux.ibm.com>
 <CAHk-=whrTE30xzuq4mcXidT4M0z_HRYJW9i8M9gD9VG7d29Qpg@mail.gmail.com>
 <63314d92-9226-4005-a166-37c8648c5351@linux.ibm.com>
 <87r0esc5lb.fsf@oracle.com>
 <34f216da-da8f-44cc-a9fc-47c8634e84c6@linux.ibm.com>
 <87le4kyj8t.fsf@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <87le4kyj8t.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oPOrtn0vTMoK2pBp9GZRiFB0nosEE0m8
X-Proofpoint-GUID: xZ2NgBJIiHBXvlmSHBYdc-j-cYdoZRCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=857
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405150101



On 5/8/24 10:48 AM, Ankur Arora wrote:
> 
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> 
>> On 4/27/24 12:30 AM, Ankur Arora wrote:
>>>
>>
>> Hi Ankur,
>>
>> Sorry for the delay, I was on leave last week.
>> There might be a delay in response as I am recovering from fever.
> 
> Please take your your time.
> 
>>> Great. I'm guessing these tests are when running in voluntary preemption
>>> mode (under PREEMPT_AUTO).
>>>
>>
>> It was run under preempt=none.
>>
>>> If you haven't, could you also try full preemption? There you should see
>>> identical results unless something is horribly wrong.
>>
>> I tried preempt=full with patch you provided below. ran the hackbench for much longer
>> with 100000 loops. I don't see any regression on the larger system.
>> I see slight improvement in some cases.  I dont see any major regression with 10k ops
>> which was tried earlier as well.
> 
> Great, so no surprises with preempt=full.

Right. 

> 
>> ==========================================================
>> 1L ops.
>> ==========================================================
>> Process 10 groups          :       9.85,       9.87(-0.20)
>> Process 20 groups          :      17.69,      17.32(2.09)
>> Process 30 groups          :      25.89,      25.96(-0.27)
>> Process 40 groups          :      34.70,      34.61(0.26)
>> Process 50 groups          :      44.02,      43.79(0.52)
>> Process 60 groups          :      52.72,      52.10(1.18)
>> Thread  10 groups          :      10.50,      10.52(-0.19)
>> Thread  20 groups          :      18.79,      18.60(1.01)
>> Process(Pipe) 10 groups    :      10.39,      10.37(0.19)
>> Process(Pipe) 20 groups    :      18.45,      18.54(-0.49)
>> Process(Pipe) 30 groups    :      25.63,      25.92(-1.13)
>> Process(Pipe) 40 groups    :      33.79,      33.49(0.89)
>> Process(Pipe) 50 groups    :      43.15,      41.83(3.06)
>> Process(Pipe) 60 groups    :      51.94,      50.32(3.12)
>> Thread(Pipe)  10 groups    :      10.73,      10.85(-1.12)
>> Thread(Pipe)  20 groups    :      19.24,      19.35(-0.57)
> 
> I presume the ones on the left are the baseline numbers with
> PREEMPT_AUTO on the right?
> 
> Also, these are with preempt=none/voluntary/full?
> 
One on the left is 6.9 baseline (preempt=full) and one on the right is preempt auto. (preempt=full)
These numbers are with preempt=full. 


>>>> However, I still see 20-50%
>>>> regression on the larger system(320 CPUS). I will continue to debug why.
>>>
>>> Could you try this patch? This is needed because PREEMPT_AUTO turns on
>>> CONFIG_PREEMPTION, but not CONFIG_PREEMPT:
> 
> Just wanted to check if the regression you were seeing with preempt=none
> is fixed?

I ran the tests again today with this patch for preempt=none. 
Unfortunately, the numbers indicate that there is regression with preempt=none on the 
large system. I will continue to debug why.

				6.9 		preempt_auto
				preempt=none	preempt=none

Process 10 groups          :       9.66,       9.75(-0.93)
Process 20 groups          :      16.82,      17.21(-2.32)
Process 30 groups          :      24.56,      25.51(-3.87)
Process 40 groups          :      31.79,      33.99(-6.92)
Process 50 groups          :      39.55,      42.85(-8.34)
Process 60 groups          :      47.39,      51.34(-8.34)
thread 10 groups           :      10.21,      10.36(-1.47)
thread 20 groups           :      18.00,      18.39(-2.17)
Process(Pipe) 10 groups    :       8.78,       8.71(0.80)
Process(Pipe) 20 groups    :      12.19,      13.42(-10.09)
Process(Pipe) 30 groups    :      15.82,      18.32(-15.80)
Process(Pipe) 40 groups    :      19.15,      22.04(-15.09)
Process(Pipe) 50 groups    :      22.23,      27.40(-23.26)
Process(Pipe) 60 groups    :      25.35,      31.37(-23.75)
thread(Pipe) 10 groups     :       8.84,       8.72(1.36)
thread(Pipe) 20 groups     :      12.90,      13.45(-4.26)



> 
>> This patch can be considered as the enablement patch for Powerpc for preempt_auto.
>> Michael, Nick, Do you see any concerns?
>>
>> Ankur, Could you please add this patch, if there are no objections.
> 
> Of course. Thanks for the patch.
> 
> The patch overall looks good. A minor comment below.
> 
>  Will add it to v2.

FWIW, we can add this support for PowerPC and fix the issues along the way. 

> 
>> ---
>> From 878a5a7c990e3459758a5d19d7697b07d8d27d0f Mon Sep 17 00:00:00 2001
>> From: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Date: Tue, 7 May 2024 04:42:04 -0500
>> Subject: [PATCH] powerpc: add support for preempt_auto
>>
>> Add PowerPC arch support for PREEMPT_AUTO by defining LAZY bits.
>>
>> Since PowerPC doesn't use generic exit to functions, Add
>> NR_LAZY check in exit to user and exit to kernel from interrupt
>> routines.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>  arch/powerpc/Kconfig                   |  1 +
>>  arch/powerpc/include/asm/thread_info.h | 11 ++++++++++-
>>  arch/powerpc/kernel/interrupt.c        |  6 ++++--
>>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> ...
> 
>> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
>> index eca293794a1e..0c0b7010995a 100644
>> --- a/arch/powerpc/kernel/interrupt.c
>> +++ b/arch/powerpc/kernel/interrupt.c
>> @@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
>>  	ti_flags = read_thread_flags();
>>  	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
>>  		local_irq_enable();
>> -		if (ti_flags & _TIF_NEED_RESCHED) {
>> +		if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
>>  			schedule();
>>  		} else {
>>  			/*
>> @@ -396,7 +396,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>>  		/* Returning to a kernel context with local irqs enabled. */
>>  		WARN_ON_ONCE(!(regs->msr & MSR_EE));
>>  again:
>> -		if (IS_ENABLED(CONFIG_PREEMPT)) {
>> +
>> +		if ((IS_ENABLED(CONFIG_PREEMPT_AUTO) && IS_ENABLED(CONFIG_PREEMPTION)) ||
>> +		    (!IS_ENABLED(CONFIG_PREEMPT_AUTO) && IS_ENABLED(CONFIG_PREEMPT))) {
> 
> Seems to me, this could just be:
> 
>         if (IS_EANBLED(CONFIG_PREEMPTION))

You are right, that should be fine. Since CONFIG_PREEMPTION is enabled 
iff preempt=full or preempt_auto. So its the same thing. 

Maybe putting a comment around it to just describe is good enough. 

> 
> But, maybe the intent is to exclude support for, say
> (PREEMPT_DYNAMIC && PREEMPT_NONE), then maybe it is best to explicitly
> encode that?
> 
> Alternately, a comment on the disparate treatment for PREEMPT_AUTO and
> !PREEMPT_AUTO might be helpful.
> 
> 
> Thanks
> Ankur
> 
>>  			/* Return to preemptible kernel context */
>>  			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>>  				if (preempt_count() == 0)

