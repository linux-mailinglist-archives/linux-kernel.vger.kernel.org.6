Return-Path: <linux-kernel+bounces-343351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2309899F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC90B21434
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED9613B288;
	Mon, 30 Sep 2024 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fi2eDQII"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AC2AF16
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727672989; cv=none; b=YGjWhtX5SEgbl/beU7YQp+za7LxcEJQUugXeBY7Hre3HwxtD/ki6uP8zstse1oIFYZgLBmRDbzuKp0UVko3TMNJe/8VZaG2Ii/tlRQR8vuF5PQ3aekRhjeFlpfVnVDeuW7fPs2xtCbo/DrLDxURgt8EFA7sFBBCBuqfe/O6ljUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727672989; c=relaxed/simple;
	bh=w7h13H2EaVuKDgBAhVvZ5PwdQTP//la1NEfJ2qazJr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUH5JTYlvIfn8FXozwoxgNhvXFsOU7TgH2lu99eovH0oXZdCm4faYbVpQ1K88k5JZr0KX643gSLcS7JGGi87kQ1Q3csRZ61Mes2NgjtjRO3GtJw7kfn+82T+c9UqY30NGcTE5B6H5L9M/NVtREk0BfrV5cvHXRqBMhBSWg/4Pho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fi2eDQII; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48TNWDtF016727;
	Mon, 30 Sep 2024 05:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=z
	V+FxYUzlEezcIRY7qZm0ACkXnka3IkyEpelTyUEsFU=; b=Fi2eDQIImkLao4nwS
	FEjg/aA7m6MNUaZaEdXNycnT9pjcgApYkVIHZAJ+5OW7teA350HZ1MGcav9BfNBK
	hLtyjEnZilFB2YNffl33QE/I8P5n9DkMPKx2G6ZUIhGh1fhJkjObH36mcUxcpNrP
	JQVudHPjo1PsflkrYLJzBALJFrMsoFXCwTHmKyaR6mtYdh56aMV6wI4+yY5tK2vw
	Zh72W6HK/tp+EQt+vBTv0TpGDjfkMGYUv2BOup+GoUFprRakagJpPN9FEWcJt7qW
	/FCpViCBZX9+JCNswqzUogscPoR8DaEQkJeUhip3ESaDKAQKB+e+aYvTejq5VIgj
	WUllg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwqrbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 05:09:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48U54hF2020858;
	Mon, 30 Sep 2024 05:09:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwqrbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 05:09:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48U40Oij014616;
	Mon, 30 Sep 2024 05:09:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmjvm0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 05:09:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48U59KWY42139972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 05:09:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73EA52004B;
	Mon, 30 Sep 2024 05:09:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04A8420040;
	Mon, 30 Sep 2024 05:09:19 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 05:09:18 +0000 (GMT)
Message-ID: <e058fcbd-dc30-4e7e-b54b-969d9dd67d4a@linux.ibm.com>
Date: Mon, 30 Sep 2024 10:39:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Allow to enable PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20240906111841.562402-1-bigeasy@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240906111841.562402-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fr5VJiQSQNGVJzZ4PVeu_RSds3XLp8jz
X-Proofpoint-GUID: 2iv3nIvE6VifJqzpzqweL0lm0jpsGkF_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=712 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300031



On 9/6/24 16:29, Sebastian Andrzej Siewior wrote:
> The printk bits required for PREEMPT_RT are sitting in linux-next. This
> was the last known roadblock for PREEMPT_RT. The RT queue has
> additionally the "atomic console" for the 8250 UART which is not yet in
> linux-next. This means "legacy console" behaviour as in no printing from
> atomic context in emergency cases. The 8250 UART driver is the only one
> providing "atomic console" support as of today.
> 
> With the printk bits merged, PREEMPT_RT could be enabled on X86, ARM64
> and Risc-V. These three architectures merged required changes over the
> years leaving me in a position where I have no essential changes in the
> queue that would affect them.
> ARM and POWERPC have a few essential patches left and I lost track of
> MIPS.

Hi Sebastian.

Congratulations to all PREEMPT_RT developers
and Thank you for sharing detailed info on what went through/in preempt rt over the years.

Used the latest tip/master tree for preempt_rt experiment.
tip/master was at this commit.
commit f441318ec664d99d7cb03b08557ed3b04d9af67f (origin/master, origin/HEAD)
Merge: d73d270676d8 408eb7417a92
Author: Ingo Molnar <mingo@kernel.org>
Date:   Wed Sep 25 12:33:39 2024 +0200
     Merge branch into tip/master: 'x86/splitlock'


Added the ARCH_SUPPORTS_RT in arch/powerpc/Kconfig. Selected the preempt_rt in menuconfig.
It *compiled and booted successfully* on POWERPC/ppc64le.


Occasionally below sched_warning is seen. It is seen with preempt=full too. So it is likely generic scheduler one,
Not related to RT. I will work on it and try to figure it out.
se->on_rq
WARNING: CPU: 147 PID: 3946 at kernel/sched/fair.c:5629 pick_next_entity+0x140/0x17c
NIP [c0000000001c1fa8] pick_next_entity+0x140/0x17c
LR [c0000000001c1fa4] pick_next_entity+0x13c/0x17c
Call Trace:
[c0000019f7097940] [c0000000001c1fa4] pick_next_entity+0x13c/0x17c (unreliable)
[c0000019f70979c0] [c0000000001c2044] pick_task_fair+0x60/0x128
[c0000019f7097a00] [c0000000001c76ac] pick_next_task_fair+0x68/0x434
[c0000019f7097a90] [c0000000001a7388] __pick_next_task+0x64/0x26c
[c0000019f7097ae0] [c000000000ff62f0] __schedule+0x138/0x73c
[c0000019f7097bb0] [c000000000ff699c] schedule+0x4c/0x114
[c0000019f7097c20] [c0000000005f3624] pipe_read+0x44c/0x5fc
[c0000019f7097d10] [c0000000005e385c] vfs_read+0x2dc/0x3b0
[c0000019f7097dc0] [c0000000005e4884] ksys_read+0xf4/0x144
[c0000019f7097e10] [c0000000000316f8] system_call_exception+0x128/0x360
[c0000019f7097e50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
--- interrupt: 3000 at 0x7fffabcb3cf4


No panic/crash was observed when running some of the microbenchmarks and few real life workloads.
Performance numbers are slightly less than preempt=none. That's likely expected.
However cyclictest numbers are a bit higher with preempt_rt compared to preempt=none.
That probably indicates there are some patches that are yet to be done.


So, Curious to know what are those patches that are left for POWERPC?
would like to work on those and get it enabled on POWERPC.
  

> 
> Sebastian
> 
> 


