Return-Path: <linux-kernel+bounces-199336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2378D85BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07001C21BE0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0AE391;
	Mon,  3 Jun 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kEDfUL9U"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45BB65C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427134; cv=none; b=e7bESdNR6PhbYP04swf7gcAtFIXsFsgAe62BBZRIJ+15PEELlWDns8iZfOlg5Jtbs6AKEwZsfr4S5QVuiSqDKuf4jm3REQesLbY+mps4jgsadua/omI/5WPeQnOIBionLnrtd+swF84wdO5iW/LbcL4UuZR8RG0f35BCA7sy5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427134; c=relaxed/simple;
	bh=A4d0HBbd11TYbTQ8bDDsdE+G+P9vlAN4AaksPVUcVgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zd+Nr4laVYcbZfSf6fsoVnly0SFyQKbShZEvycbuJrin5RJGJvTyuqW5+lTr5DP+L2GiohY2s0yOQFOskj2sLA9ZcSG/h9TQXg6k4BahWRFhKMls3Lmb2KZ3TikXYfxkfRGQfGgjkCp+KRd5rJh8kJA89xnpMMdrY3aikktSbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kEDfUL9U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453F0Xa0028042;
	Mon, 3 Jun 2024 15:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=NARqzYpVpuJJ5qaLM1qiiYSWLbBrBa4BwcSoD89Ox5Q=;
 b=kEDfUL9UlUbu+ZFk6RQZPVkMPjtPqkYvWtATFvaqKrnCvNqiBqXR4GUbFTUWe4SrRu3V
 9k9a4JMwCM4McGZJ7P2eY915tR0cqzcFiISqdqpLioeg4SY5FaEl1izZiO1qdaWFOO+A
 cOLCc3tI0/8uiOCE+9rzqA9poakVbUSL6Hjwaqg2xrPqc9UFI2AGjyRa4lR1r03RTVmq
 RkVWkYiLIi1puDoTCzfmYU5F4BGoyZiAWH96x7acgl0oZz4AA8jBDskPundPSpbbJ4MJ
 JfmOJ2dJEEmMiawIHCBS2p4rR5b/ZVNGwHmpnenY8V3Edi1XCT/dEbd+J+syXZSi/fLt EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhenfr9wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 15:05:01 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 453F515E006254;
	Mon, 3 Jun 2024 15:05:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhenfr9wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 15:05:00 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 453E1lQc022807;
	Mon, 3 Jun 2024 15:04:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygg6m062a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 15:04:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 453F4uwP32572076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 15:04:59 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C90535805A;
	Mon,  3 Jun 2024 15:04:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 244BC58056;
	Mon,  3 Jun 2024 15:04:53 +0000 (GMT)
Received: from [9.195.46.110] (unknown [9.195.46.110])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Jun 2024 15:04:52 +0000 (GMT)
Message-ID: <fa715df1-bc7f-4abc-8554-947484b2c0ae@linux.ibm.com>
Date: Mon, 3 Jun 2024 20:34:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/35] preempt: introduce CONFIG_PREEMPT_AUTO
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-5-ankur.a.arora@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240528003521.979836-5-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kPXMA0Y5nLe__bDXmxxAVr0zkpdZZz3b
X-Proofpoint-GUID: QMreaihNZU9XtUXCg9aKhn0vpnG-x-zT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 mlxlogscore=905
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406030125



On 5/28/24 6:04 AM, Ankur Arora wrote:
> PREEMPT_AUTO adds a new scheduling model which, like PREEMPT_DYNAMIC,
> allows dynamic switching between a none/voluntary/full preemption
> model. However, unlike PREEMPT_DYNAMIC, it doesn't use explicit
> preemption points for the voluntary models.
> 
> It works by depending on CONFIG_PREEMPTION (and thus PREEMPT_COUNT),
> allowing the scheduler to always know when it is safe to preempt
> for all three preemption models.
> 
> In addition, it uses an additional need-resched bit
> (TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED allows the
> scheduler to express two kinds of rescheduling intent: schedule at
> the earliest opportunity (the usual TIF_NEED_RESCHED semantics), or
> express a need for rescheduling while allowing the task on the
> runqueue to run to timeslice completion (TIF_NEED_RESCHED_LAZY).
> 
> The scheduler chooses the specific need-resched flag based on
> the preemption model:
> 
> 		TIF_NEED_RESCHED 	TIF_NEED_RESCHED_LAZY
> 
> none		never   		always [*]
> voluntary       higher sched class	other tasks [*]
> full 		always                  never
> 
> [*] when preempting idle, or for kernel tasks that are 'urgent' in
> some way (ex. resched_cpu() used as an RCU hammer), we use
> TIF_NEED_RESCHED.
> 
> The other part is when preemption happens -- or, when are the
> need-resched flags checked:
> 
>                  exit-to-user    ret-to-kernel    preempt_count()
> NEED_RESCHED_LAZY     Y               N                N
> NEED_RESCHED          Y               Y                Y
> 
> Exposed under CONFIG_EXPERT for now.
> 
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  1 +
>  include/linux/thread_info.h                   | 12 ++++++
>  init/Makefile                                 |  1 +
>  kernel/Kconfig.preempt                        | 37 +++++++++++++++++--
>  4 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2d693300ab57..16a91090d167 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4719,6 +4719,7 @@
>  
>  	preempt=	[KNL]
>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
> +			or CONFIG_PREEMPT_AUTO.
>  			none - Limited to cond_resched() calls
>  			voluntary - Limited to cond_resched() and might_sleep() calls
>  			full - Any section that isn't explicitly preempt disabled
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 9ea0b28068f4..06e13e7acbe2 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -59,6 +59,18 @@ enum syscall_work_bit {
>  
>  #include <asm/thread_info.h>
>  
> +/*
> + * Fall back to the default need-resched flag when an architecture does not
> + * define TIF_NEED_RESCHED_LAZY.
> + *
> + * Note: with !PREEMPT_AUTO, code should not be setting TIF_NEED_RESCHED_LAZY
> + * anywhere. Define this here because we will explicitly test for this bit.
> + */


Is this comment still valid? 
I see that flag has been set without any checks in arch file. 


> +#ifndef TIF_NEED_RESCHED_LAZY
> +#define TIF_NEED_RESCHED_LAZY TIF_NEED_RESCHED
> +#define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
> +#endif
> +
>  #ifdef __KERNEL__
>  
>  #ifndef arch_set_restart_data

