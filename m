Return-Path: <linux-kernel+bounces-423068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD939DA24E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35FB16913C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C2C146A87;
	Wed, 27 Nov 2024 06:28:30 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717613A888
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732688910; cv=none; b=OxmT8uDMO6JSM4Rfgig3KnNEQ9fMdJXAkQR/BPfhFNTajeBXscd9LN7FdoGgowy9UMxK7gTAAmnRseKVihqQS1zgHo99MIGuyb1KfdllqC/xsVlH7hJ1fffhbxG2cPe6bE6a+PUAK98+Y73rVXooswYnfONi+J9Nv/dtH2nyBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732688910; c=relaxed/simple;
	bh=0M5dM9L0rqWJOkWaHgOo/UNtVt8PUGhHAZAZYnlu58E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaYPXHdzcekIM4BTB4sSTWx0ix/Vu9m20LcfztYiNYxs9ZrkHTXjYeHzj3ib2r4u6J5zF0vcIB/5/1ga/Oi7xddxUrEZjIl/bSYC/XvohbniqkbG/McmbFol2MxicygjYfttXnlhqqMWdLi4yk6dN05ExnlcqHvWvV3dDspSgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XyqJT50krz9sPd;
	Wed, 27 Nov 2024 07:28:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CLqilz5sjvGQ; Wed, 27 Nov 2024 07:28:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XyqJT3tyfz9rvV;
	Wed, 27 Nov 2024 07:28:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7030B8B780;
	Wed, 27 Nov 2024 07:28:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ULA6o10COpzh; Wed, 27 Nov 2024 07:28:25 +0100 (CET)
Received: from [192.168.233.25] (PO18304.IDSI0.si.c-s.fr [192.168.233.25])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D1F5A8B77C;
	Wed, 27 Nov 2024 07:28:24 +0100 (CET)
Message-ID: <cd3f01d0-fd34-4a5c-ac45-5d2dd2349f8a@csgroup.eu>
Date: Wed, 27 Nov 2024 07:28:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powerpc: support dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-3-sshegde@linux.ibm.com>
 <d169e57d-d0a8-4fe8-a44e-2f7a967b5121@csgroup.eu>
 <f41701ce-2977-4e49-ad25-1dabb26a2668@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <f41701ce-2977-4e49-ad25-1dabb26a2668@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/11/2024 à 12:15, Shrikanth Hegde a écrit :
> 
> 
> On 11/26/24 16:18, Christophe Leroy wrote:
>>
>>
> 
> Hi Christophe, Thanks for taking a look at this.
> 
>> Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
>>> Once the lazy preemption is supported, it would be desirable to change
>>> the preemption models at runtime. So this change adds support for 
>>> dynamic
>>> preemption using DYNAMIC_KEY.
>>>
>>> In irq-exit to kernel path, use preempt_model_preemptible for decision.
>>> Other way would be using static key based decision. Keeping it
>>> simpler since key based change didn't show performance improvement.
>>>
>>> Tested lightly on Power10 LPAR. Performance numbers indicate that,
>>> preempt=none(no dynamic) and preempt=none(dynamic) are similar.
>>> Only hackbench pipe shows a regression. There is slight overhead of code
>>> check if it is preemptible kernel. hackbench pipe is prone to such
>>> patterns[1]
>>>
>>> cat /sys/kernel/debug/sched/preempt
>>> (none) voluntary full lazy
>>> perf stat -e probe:__cond_resched -a sleep 1
>>>   Performance counter stats for 'system wide':
>>>               1,253      probe:__cond_resched
>>>
>>> echo full > /sys/kernel/debug/sched/preempt
>>> cat /sys/kernel/debug/sched/preempt
>>> none voluntary (full) lazy
>>> perf stat -e probe:__cond_resched -a sleep 1
>>>   Performance counter stats for 'system wide':
>>>                   0      probe:__cond_resched
>>>
>>> echo lazy > /sys/kernel/debug/sched/preempt
>>> cat /sys/kernel/debug/sched/preempt
>>> none voluntary full (lazy)
>>> perf stat -e probe:__cond_resched -a sleep 1
>>>   Performance counter stats for 'system wide':
>>>                   0      probe:__cond_resched
>>>
>>> [1]: 
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F1a973dda-c79e-4d95-935b-&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf0474c2567834b69dfd908dd0e0bb554%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638682165690258507%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Gcw6nRSPkp78lGEkG8NX04KWW%2FjCZm0oA%2BTGTjpUZUc%3D&reserved=0 e4b93eb077b8@linux.ibm.com/
>>>
>>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>> ---
>>>   arch/powerpc/Kconfig               | 1 +
>>>   arch/powerpc/include/asm/preempt.h | 1 +
>>>   arch/powerpc/kernel/interrupt.c    | 6 +++++-
>>>   arch/powerpc/lib/vmx-helper.c      | 2 +-
>>>   4 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 6d6bbd93abab..01c58f5258c9 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -270,6 +270,7 @@ config PPC
>>>       select HAVE_PERF_EVENTS_NMI        if PPC64
>>>       select HAVE_PERF_REGS
>>>       select HAVE_PERF_USER_STACK_DUMP
>>> +    select HAVE_PREEMPT_DYNAMIC_KEY
>>>       select HAVE_RETHOOK            if KPROBES
>>>       select HAVE_REGS_AND_STACK_ACCESS_API
>>>       select HAVE_RELIABLE_STACKTRACE
>>> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/ 
>>> include/asm/preempt.h
>>> index 51f8f3881523..c0a19ff3f78c 100644
>>> --- a/arch/powerpc/include/asm/preempt.h
>>> +++ b/arch/powerpc/include/asm/preempt.h
>>> @@ -84,6 +84,7 @@ extern asmlinkage void preempt_schedule_notrace(void);
>>>   #if defined(CONFIG_PREEMPT_DYNAMIC) && 
>>> defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>>> +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>>>   void dynamic_preempt_schedule(void);
>>>   void dynamic_preempt_schedule_notrace(void);
>>>   #define __preempt_schedule()        dynamic_preempt_schedule()
>>> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/ 
>>> interrupt.c
>>> index 8f4acc55407b..0fb01019d7e0 100644
>>> --- a/arch/powerpc/kernel/interrupt.c
>>> +++ b/arch/powerpc/kernel/interrupt.c
>>> @@ -38,6 +38,10 @@ static inline bool exit_must_hard_disable(void)
>>>   }
>>>   #endif
>>> +#ifdef CONFIG_PREEMPT_DYNAMIC
>>> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>>> +#endif
>>
>> Why is that needed at all ? It isn't used.
> 
> This is needed else compilation fails.
> 
> It has be defined by arch if it doesn't use kernel infra of entry/exit.
> So if an arch does enable, CONFIG_HAVE_PREEMPT_DYNAMIC_KEY it has to be 
> define this key has well. The generic sched/core enables this flag.
> 
> This was one of the point I was requesting answer for. Either to use 
> preempt_model_preemptible or define macros based on this key. Other 
> archs are doing the later and hence the generic code enables this key.
> 
> It can be done in either way. if we do the later way, then this variable 
> will be used as well.
> 

Ah right, I did a grep on sk_dynamic_irqentry_exit_cond_resched but 
indeed it is triggered by static_key_enable(&sk_dynamic_##f.key)

Christophe

