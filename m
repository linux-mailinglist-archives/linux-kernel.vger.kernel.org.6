Return-Path: <linux-kernel+bounces-422222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23219D9610
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819BA287B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2521CDA04;
	Tue, 26 Nov 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ASIQ8PWj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE81B413C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619795; cv=none; b=ntVHJubNL4Bu6XmtCTeqPTNdSnhq1SK6+n5RwxPxlYa1bZBDrnVI0bvANsopokxG0Crxe58nF8gRekSfT/17i4oCLbCJnewPFaa5MIknVMPVPdCxU9lWLuL8Guho1T4OssXxUiQh3+SJQYLNshNYZRSAUD6wJdDnBUgF7hB18FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619795; c=relaxed/simple;
	bh=syQDtxYMocMChVIS6iWR10VIG1YnTWooDY3+kXW+ULk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/OfZ2Q+Wm6Hyyz4j1WfFNhBbGdpLjyZbhgQ+BPOAt60aKP1JQjd06hD04dSDZjNu3w0fq42fc42HVZS7NsiyB7vRYuDerPOu9X55Tz2GAJm0gZb2mkdqGrkCbTavch4gKJ/zAqmGw865RHUQI5zdIG2q1JjB+W+azzjdzzla0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ASIQ8PWj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ7QfOj026432;
	Tue, 26 Nov 2024 11:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hAebp0
	etoMoKwMxgXhWWrfMPhcW0ksN7duWdXSQYhxE=; b=ASIQ8PWjdyg+OOiBU5is5l
	8B+kTpiv10m2oYx0z8VKVITdn3knjn8xrQODrrlNDIa9mlJRlKVty+59NGAUYe/m
	pKxz3aGepgotvJOZl57trzNDO1q2gu5MfRueiM1Us4IvljHnwh/dDBjT6+Oyt7uj
	sK/n8s042DxRfd+UAViRFxyie7HrmV/hOdjdBajP80cWWhASiLn2efEs62t5V6Pt
	J97CbY6qwCAl5SE0vvYaoE9P1U08Vtoi2/iZWT5YrP2rBjHJQFN1at0R57lU80KZ
	Ysr3wd+8q6wgvS2GV9PbReNC6R7Gtl+9cxNYYHYBDQ01lP7sFMdnH7ybNNYJgm7Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386ndjy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 11:15:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQAu7Fo021464;
	Tue, 26 Nov 2024 11:15:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386ndjxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 11:15:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQA1pRH000859;
	Tue, 26 Nov 2024 11:15:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433srya0cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 11:15:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQBFpgx38666634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 11:15:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0686B2004B;
	Tue, 26 Nov 2024 11:15:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1CF120043;
	Tue, 26 Nov 2024 11:15:48 +0000 (GMT)
Received: from [9.124.223.8] (unknown [9.124.223.8])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 11:15:48 +0000 (GMT)
Message-ID: <f41701ce-2977-4e49-ad25-1dabb26a2668@linux.ibm.com>
Date: Tue, 26 Nov 2024 16:45:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powerpc: support dynamic preemption
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
        ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-3-sshegde@linux.ibm.com>
 <d169e57d-d0a8-4fe8-a44e-2f7a967b5121@csgroup.eu>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d169e57d-d0a8-4fe8-a44e-2f7a967b5121@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qefz3VclLuq8hRME7QI8XXkhisJhjc1p
X-Proofpoint-ORIG-GUID: wCerN3LS0Low155tfa5KqL2t5uMpQxxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260088



On 11/26/24 16:18, Christophe Leroy wrote:
> 
> 

Hi Christophe, Thanks for taking a look at this.

> Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
>> Once the lazy preemption is supported, it would be desirable to change
>> the preemption models at runtime. So this change adds support for dynamic
>> preemption using DYNAMIC_KEY.
>>
>> In irq-exit to kernel path, use preempt_model_preemptible for decision.
>> Other way would be using static key based decision. Keeping it
>> simpler since key based change didn't show performance improvement.
>>
>> Tested lightly on Power10 LPAR. Performance numbers indicate that,
>> preempt=none(no dynamic) and preempt=none(dynamic) are similar.
>> Only hackbench pipe shows a regression. There is slight overhead of code
>> check if it is preemptible kernel. hackbench pipe is prone to such
>> patterns[1]
>>
>> cat /sys/kernel/debug/sched/preempt
>> (none) voluntary full lazy
>> perf stat -e probe:__cond_resched -a sleep 1
>>   Performance counter stats for 'system wide':
>>               1,253      probe:__cond_resched
>>
>> echo full > /sys/kernel/debug/sched/preempt
>> cat /sys/kernel/debug/sched/preempt
>> none voluntary (full) lazy
>> perf stat -e probe:__cond_resched -a sleep 1
>>   Performance counter stats for 'system wide':
>>                   0      probe:__cond_resched
>>
>> echo lazy > /sys/kernel/debug/sched/preempt
>> cat /sys/kernel/debug/sched/preempt
>> none voluntary full (lazy)
>> perf stat -e probe:__cond_resched -a sleep 1
>>   Performance counter stats for 'system wide':
>>                   0      probe:__cond_resched
>>
>> [1]: https://lore.kernel.org/all/1a973dda-c79e-4d95-935b- 
>> e4b93eb077b8@linux.ibm.com/
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig               | 1 +
>>   arch/powerpc/include/asm/preempt.h | 1 +
>>   arch/powerpc/kernel/interrupt.c    | 6 +++++-
>>   arch/powerpc/lib/vmx-helper.c      | 2 +-
>>   4 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 6d6bbd93abab..01c58f5258c9 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -270,6 +270,7 @@ config PPC
>>       select HAVE_PERF_EVENTS_NMI        if PPC64
>>       select HAVE_PERF_REGS
>>       select HAVE_PERF_USER_STACK_DUMP
>> +    select HAVE_PREEMPT_DYNAMIC_KEY
>>       select HAVE_RETHOOK            if KPROBES
>>       select HAVE_REGS_AND_STACK_ACCESS_API
>>       select HAVE_RELIABLE_STACKTRACE
>> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/ 
>> include/asm/preempt.h
>> index 51f8f3881523..c0a19ff3f78c 100644
>> --- a/arch/powerpc/include/asm/preempt.h
>> +++ b/arch/powerpc/include/asm/preempt.h
>> @@ -84,6 +84,7 @@ extern asmlinkage void preempt_schedule_notrace(void);
>>   #if defined(CONFIG_PREEMPT_DYNAMIC) && 
>> defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>> +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>>   void dynamic_preempt_schedule(void);
>>   void dynamic_preempt_schedule_notrace(void);
>>   #define __preempt_schedule()        dynamic_preempt_schedule()
>> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/ 
>> interrupt.c
>> index 8f4acc55407b..0fb01019d7e0 100644
>> --- a/arch/powerpc/kernel/interrupt.c
>> +++ b/arch/powerpc/kernel/interrupt.c
>> @@ -38,6 +38,10 @@ static inline bool exit_must_hard_disable(void)
>>   }
>>   #endif
>> +#ifdef CONFIG_PREEMPT_DYNAMIC
>> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>> +#endif
> 
> Why is that needed at all ? It isn't used.

This is needed else compilation fails.

It has be defined by arch if it doesn't use kernel infra of entry/exit.
So if an arch does enable, CONFIG_HAVE_PREEMPT_DYNAMIC_KEY it has to be 
define this key has well. The generic sched/core enables this flag.

This was one of the point I was requesting answer for. Either to use 
preempt_model_preemptible or define macros based on this key. Other 
archs are doing the later and hence the generic code enables this key.

It can be done in either way. if we do the later way, then this variable 
will be used as well.

I hope this answers the question on patch 1 as well. Otherwise i have to 
declare that in one of other arch/asm/.h file.

> 
>> +
>>   /*
>>    * local irqs must be disabled. Returns false if the caller must re- 
>> enable
>>    * them, check for new work, and try again.
>> @@ -396,7 +400,7 @@ notrace unsigned long 
>> interrupt_exit_kernel_prepare(struct pt_regs *regs)
>>           /* Returning to a kernel context with local irqs enabled. */
>>           WARN_ON_ONCE(!(regs->msr & MSR_EE));
>>   again:
>> -        if (IS_ENABLED(CONFIG_PREEMPTION)) {
>> +        if (preempt_model_preemptible()) {
>>               /* Return to preemptible kernel context */
>>               if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>>                   if (preempt_count() == 0)
>> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx- 
>> helper.c
>> index 58ed6bd613a6..7b069c832ce2 100644
>> --- a/arch/powerpc/lib/vmx-helper.c
>> +++ b/arch/powerpc/lib/vmx-helper.c
>> @@ -45,7 +45,7 @@ int exit_vmx_usercopy(void)
>>        * set and we are preemptible. The hack here is to schedule a
>>        * decrementer to fire here and reschedule for us if necessary.
>>        */
>> -    if (IS_ENABLED(CONFIG_PREEMPTION) && need_resched())
>> +    if (preempt_model_preemptible() && need_resched())
>>           set_dec(1);
>>       return 0;
>>   }


