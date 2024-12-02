Return-Path: <linux-kernel+bounces-427658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C3C9E0477
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71575165FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4008E202F9E;
	Mon,  2 Dec 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B/T6nbrP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF98200120
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148375; cv=none; b=dwII1Pbz/BVoT0cJ0qPFD/zSPdpxiJ7JhZ4eLJnJ73DqgyFw1ThLCL2cBZPvi6Z3dH8dyH5tznCK8avClhwG5eAy0Y4aySZ4bovA0mexsDyyhJPQUyH66/nGdOZG7p6V+L35Av9RXk2si6ntGIbtXl913cJHQGETgFTabRMGjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148375; c=relaxed/simple;
	bh=GuYxFQyWC/Z2cYgXMuB7SHzrxI4gmLYEfzSbtKyc9PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ga312V1q8jC6XIfmooocJFwwEQGSEePmD5p5glp+YKQGTPH+3BE03qktCsQr/MJ8WNgYLP2Wvg4IofemKTbs0n4SXUwaLEV9yjT06cU1Zbwnhcvmk9UjytNMPCTQ0mQvICmBpbjrg+LKcYg48pWO2CmBQz61+H3uVNYF5NHMj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B/T6nbrP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2BRMTf008503;
	Mon, 2 Dec 2024 14:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=STOv/z
	ZNVc5lN2iOrksyKCSZc9jg0+HvTYnbwsToZxg=; b=B/T6nbrPzV/+mPRoFIo2Aw
	sJQJ1QDOYmO/WNkIHzitzUYZdlaBx65c9bYQOt9pr6OBAl8bxS4+SwDi83dxDJPl
	6vXJOF+orUSENkZcirCf5k/7/HMw0hfllKZZJFsxQKVdLt/ND54qgn221mCY2C35
	wNVaKV3zFCan9KVNjHcH15P5MeSwURLYxDNc3UXbdJBwp9yeigfDUupja7J1xE5F
	s5x6xC7QXJy31ldpiym7TVQbZ0AHgvOHfn4rAa3dxaltKt+0lxasFwtAW9ALqdUO
	k8aG/S29CNUNWfre6go8zHPPA/RXM2tEB0PZ7GY1Sm/FCiA9W68X6a6ko5Bbd4sA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgdk79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 14:05:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B2DwnUb013298;
	Mon, 2 Dec 2024 14:05:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgdk6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 14:05:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DdVgb029512;
	Mon, 2 Dec 2024 14:05:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ddy69qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 14:05:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2E5cdw33882626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 14:05:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B46FC20071;
	Mon,  2 Dec 2024 14:05:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6293D2006E;
	Mon,  2 Dec 2024 14:05:36 +0000 (GMT)
Received: from [9.124.223.110] (unknown [9.124.223.110])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 14:05:36 +0000 (GMT)
Message-ID: <026ad776-a889-4213-8e0e-1da9065dc5ef@linux.ibm.com>
Date: Mon, 2 Dec 2024 19:35:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] powerpc: copy preempt.h into arch/include/asm
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
        ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-2-sshegde@linux.ibm.com>
 <b5c152a3-d459-4744-84ec-846153de1652@csgroup.eu>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <b5c152a3-d459-4744-84ec-846153de1652@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x2HNJZwtANCojRXB-TRdEdwvabPOdSpU
X-Proofpoint-GUID: qgBBeHP1TUnNBtJaQz1_yXfIg6df90lw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=975 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020121



On 11/27/24 12:07, Christophe Leroy wrote:
> 
> 
> Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
>> PowerPC uses asm-generic preempt definitions as of now.
>> Copy that into arch/asm so that arch specific changes can be done.
>> This would help the next patch for enabling dynamic preemption.
> 

The reason I want the content instead was to allow future patches where 
I thought of making preempt count per paca for ppc64 atleast. generic 
code assumes it is per thread. If this change is to be done at that 
point, that is fair too. I am okay with it.


> Instead of copying all the content of asm-generic version, can you just 
> create a receptacle for your new macros, that will include asm-generic/ 
> preempt.h ?
> 
> Look at arch/powerpc/include/asm/percpu.h for exemple.
>

You mean something like below right?


#ifndef __ASM_POWERPC_PREEMPT_H
#define __ASM_POWERPC_PREEMPT_H

#include <asm-generic/preempt.h>

#if defined(CONFIG_PREEMPT_DYNAMIC) && 
defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
#endif

#endif /* __ASM_POWERPC_PREEMPT_H */



>>
>> No functional changes intended.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/preempt.h | 100 +++++++++++++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>   create mode 100644 arch/powerpc/include/asm/preempt.h
>>
>> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/ 
>> include/asm/preempt.h
>> new file mode 100644
>> index 000000000000..51f8f3881523
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/preempt.h
>> @@ -0,0 +1,100 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_PREEMPT_H
>> +#define __ASM_PREEMPT_H
> 
> Should be __ASM_POWERPC_PREEMPT_H

thanks for catching this.

> 
>> +
>> +#include <linux/thread_info.h>
>> +
>> +#define PREEMPT_ENABLED    (0)
>> +
>> +static __always_inline int preempt_count(void)
>> +{
>> +    return READ_ONCE(current_thread_info()->preempt_count);
>> +}
>> +
>> +static __always_inline volatile int *preempt_count_ptr(void)
>> +{
>> +    return &current_thread_info()->preempt_count;
>> +}
>> +
>> +static __always_inline void preempt_count_set(int pc)
>> +{
>> +    *preempt_count_ptr() = pc;
>> +}
>> +
>> +/*
>> + * must be macros to avoid header recursion hell
>> + */
>> +#define init_task_preempt_count(p) do { \
>> +    task_thread_info(p)->preempt_count = FORK_PREEMPT_COUNT; \
>> +} while (0)
>> +
>> +#define init_idle_preempt_count(p, cpu) do { \
>> +    task_thread_info(p)->preempt_count = PREEMPT_DISABLED; \
>> +} while (0)
>> +
>> +static __always_inline void set_preempt_need_resched(void)
>> +{
>> +}
>> +
>> +static __always_inline void clear_preempt_need_resched(void)
>> +{
>> +}
>> +
>> +static __always_inline bool test_preempt_need_resched(void)
>> +{
>> +    return false;
>> +}
>> +
>> +/*
>> + * The various preempt_count add/sub methods
>> + */
>> +
>> +static __always_inline void __preempt_count_add(int val)
>> +{
>> +    *preempt_count_ptr() += val;
>> +}
>> +
>> +static __always_inline void __preempt_count_sub(int val)
>> +{
>> +    *preempt_count_ptr() -= val;
>> +}
>> +
>> +static __always_inline bool __preempt_count_dec_and_test(void)
>> +{
>> +    /*
>> +     * Because of load-store architectures cannot do per-cpu atomic
>> +     * operations; we cannot use PREEMPT_NEED_RESCHED because it 
>> might get
>> +     * lost.
>> +     */
>> +    return !--*preempt_count_ptr() && tif_need_resched();
>> +}
>> +
>> +/*
>> + * Returns true when we need to resched and can (barring IRQ state).
>> + */
>> +static __always_inline bool should_resched(int preempt_offset)
>> +{
>> +    return unlikely(preempt_count() == preempt_offset &&
>> +            tif_need_resched());
>> +}
>> +
>> +#ifdef CONFIG_PREEMPTION
>> +extern asmlinkage void preempt_schedule(void);
>> +extern asmlinkage void preempt_schedule_notrace(void);
>> +
>> +#if defined(CONFIG_PREEMPT_DYNAMIC) && 
>> defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>> +
>> +void dynamic_preempt_schedule(void);
>> +void dynamic_preempt_schedule_notrace(void);
>> +#define __preempt_schedule()        dynamic_preempt_schedule()
>> +#define __preempt_schedule_notrace()    
>> dynamic_preempt_schedule_notrace()
>> +
>> +#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
>> +
>> +#define __preempt_schedule() preempt_schedule()
>> +#define __preempt_schedule_notrace() preempt_schedule_notrace()
>> +
>> +#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
>> +#endif /* CONFIG_PREEMPTION */
>> +
>> +#endif /* __ASM_PREEMPT_H */


