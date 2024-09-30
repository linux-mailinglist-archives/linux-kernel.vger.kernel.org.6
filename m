Return-Path: <linux-kernel+bounces-344667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36998AC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881692822FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F8B1991CA;
	Mon, 30 Sep 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AsrJ/M3k"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82069153BD9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723143; cv=none; b=gXVwaKp85FAQIb3OBXm89H4JZogxl49IM5iFxsOJL/lZvcIaxBvncsa2t7YWrvunDUnSljc9pqOln/h2KMVO6CJOLiC3OVCveYGpvwpjIn2NlYuTAU1NZCBmoIMQwGsr35VvSJwsnbG1q/QtYC2u8+668ARYe6j+GvtJ5njQsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723143; c=relaxed/simple;
	bh=2vaRGo/ric+0NSRi8zYr94dftaqYHIBUEZQjOOdIZGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUx9YlcvPLK/+OoGNwl8gf2uaiOye1NbUB5iLmJ8iPjRluTyX3dJXeQ0g/Asfib8FUwW3YZPRyFA6dP/PehJxxLPXumJML5rDjnBoAwOPGhmW7batAGiOOZqSgIJApzZGR39eK1F4ikb33aeCuSXTmPv0okH8d6/ejK+R9XFeh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AsrJ/M3k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UDXLBP008227;
	Mon, 30 Sep 2024 19:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=hsU4KirBdlcZ2pRO0v2TUnItQ5Z
	V/pbQVaUwmMOd5LU=; b=AsrJ/M3kLxMySOpO7dacaCVD5fqWCq/UPMHGBHNwN4t
	Mzpy5ivVn4RJNxy0tB5aCEHSXE1XoCow52ioq0jfrbHlIKKZTkZDaukRkikZGyk1
	9h4gHQ+uyFdXCmu6CVoJ61EZi90nyHcz/O8txMZX5zWzq6EdQn2ARK55HzfEwYRT
	X15DpUxa+AkOpc3i1pOZm4M3hnHAElmqCWt57m0wVdbw9SBOgK52EYb/YFgZFgR/
	ab0u8tfmvdNdCSiuAtyeqdF1j1G0AtDZx2jlRkIPqKy6f20dlganZgwYsfKmUmpN
	D8eX7MFzAcym10colfre6AqOw14ojcYw0uifcNXap8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apbrn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 19:05:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UJ5R8F029578;
	Mon, 30 Sep 2024 19:05:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apbrn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 19:05:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UHn5bh017899;
	Mon, 30 Sep 2024 19:05:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mr8f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 19:05:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UJ5Ojc35127832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 19:05:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92F5A20040;
	Mon, 30 Sep 2024 19:05:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4AC920043;
	Mon, 30 Sep 2024 19:05:21 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.31.120])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Sep 2024 19:05:21 +0000 (GMT)
Date: Tue, 1 Oct 2024 00:35:16 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        luis.machado@arm.com
Subject: Re: sched/fair: Kernel panics in pick_next_entity
Message-ID: <Zvr2bLBEYyu1gtNz@linux.ibm.com>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930144157.GH5594@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DI_N6GpZ7M-1aFcBVj9N2zIiPnOLSdrX
X-Proofpoint-GUID: NqlEsJOxRe_tJKlN_T7V4U47bx7SeiR0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_18,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=686 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300138

On Mon, Sep 30, 2024 at 04:41:57PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 26, 2024 at 06:12:19PM +0530, Vishal Chourasia wrote:
> > I've noticed a kernel panic consistently occurring on the mainline v6.11
> > kernel (see attached dmesg log below). 
> > 
> > The panic occurs almost every time I build the Linux kernel from source.
> > 
> > Steps to Reproduce:
> > 
> > make clean
> > ./scripts/config -e LOCALVERSION_AUTO
> > ./scripts/config --set-str LOCALVERSION -master-with-print
> > make localmodconfig
> > make -j8 -s vmlinux modules
> > 
> > >From my investigation, it seems that the function pick_eevdf() can return NULL.
> > Commit f12e1488 ("sched/fair: Prepare pick_next_task() for delayed dequeue") 
> > introduces an access on the return value of pick_eevdf(). If 'se' was NULL, 
> > it can lead to a null pointer dereference. 
> 
> Even before that commit we relied on that thing not being NULL, notably
> f12e1488^1 has:
> 
>                 se = pick_next_entity(cfs_rq);
>                 cfs_rq = group_cfs_rq(se);
> 
> Which will similarly explode when pick_eevdf() goes wobbly.
> 
> > To determine why pick_eevdf() would return NULL, I added a few printk statements
> > Based on one of the printk logs in the shared dmesg log, it appears that if
> > pick_eevdf() is called for a 'cfs_rq' whose 'cfs_rq->curr' is NULL and there
> > are no eligible entities on that 'cfs_rq', it will return NULL. 
> 
> Right, that is not a valid state. Which seems to suggest something went
> sideways with the eligibility thing -- as Luis suggested.
> 
> > I have not been able to think of a quick reproducer to trigger a panic
> > for this case. Hoping if someone can guide me on this.
> > 
> > Note: The following dmesg log also contains a warning reported too. Panic
> > happens later.
> > 
> > ------------[ cut here ]------------
> > !se->on_rq
> > WARNING: CPU: 1 PID: 92333 at kernel/sched/fair.c:705 update_entity_lag+0xcc/0xf0
> > Modules linked in: binfmt_misc bonding tls rfkill ibmveth pseries_rng vmx_crypto nd_pmem nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
> > CPU: 1 UID: 0 PID: 92333 Comm: genksyms Tainted: G        W          6.11.0-master-with-print-10547-g684a64bf32b6-dirty #64
> > Tainted: [W]=WARN
> > Hardware name: IBM,9080-HEX POWER10 (architected) hv:phyp pSeries
> > NIP:  c0000000001cdfcc LR: c0000000001cdfc8 CTR: 0000000000000000
> > REGS: c00000005c62ee50 TRAP: 0700   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
> > MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER: 00000005
> > CFAR: c000000000156a10 IRQMASK: 1
> > GPR00: c0000000001cdfc8 c00000005c62f0f0 c000000001b57400 000000000000000a
> > GPR04: 00000000ffff7fff c00000005c62eee0 c00000005c62eed8 00000007fb050000
> > GPR08: 0000000000000027 0000000000000000 0000000000000000 c000000002758de0
> > GPR12: c000000002a18d88 c0000007fffef480 0000000000000000 0000000000000000
> > GPR16: c000000002c56d40 0000000000000000 c00000005c62f5b4 0000000000000000
> > GPR20: fffffffffffffdef 0000000000000000 0000000000000002 c000000003cd7300
> > GPR24: 0000000000000000 0000000000000008 c0000007fd1d3f80 0000000000000000
> > GPR28: 0000000000000001 0000000000000009 c0000007fd1d4080 c0000000656a0000
> > NIP [c0000000001cdfcc] update_entity_lag+0xcc/0xf0
> > LR [c0000000001cdfc8] update_entity_lag+0xc8/0xf0
> > Call Trace:
> > [c00000005c62f0f0] [c0000000001cdfc8] update_entity_lag+0xc8/0xf0 (unreliable)
> > [c00000005c62f160] [c0000000001cea80] dequeue_entity+0xb0/0x6d0
> > [c00000005c62f1f0] [c0000000001cf8b0] dequeue_entities+0x150/0x600
> > [c00000005c62f2c0] [c0000000001d02a8] dequeue_task_fair+0x158/0x2e0
> > [c00000005c62f300] [c0000000001b5ea4] dequeue_task+0x64/0x200
> > [c00000005c62f380] [c0000000001cc950] detach_tasks+0x140/0x420
> > [c00000005c62f3f0] [c0000000001d6044] sched_balance_rq+0x214/0x7c0
> > [c00000005c62f550] [c0000000001d6830] sched_balance_newidle+0x240/0x630
> > [c00000005c62f640] [c0000000001d6d0c] pick_next_task_fair+0x7c/0x4a0
> > [c00000005c62f6d0] [c0000000001afc50] __pick_next_task+0x60/0x2d0
> > [c00000005c62f730] [c0000000010e8ce8] __schedule+0x198/0x840
> > [c00000005c62f810] [c0000000010e93d0] schedule+0x40/0x110
> > [c00000005c62f880] [c00000000064c574] pipe_read+0x424/0x6a0
> > [c00000005c62f960] [c00000000063a0fc] vfs_read+0x30c/0x3d0
> > [c00000005c62fa10] [c00000000063adf4] ksys_read+0x104/0x160
> > [c00000005c62fa60] [c000000000031678] system_call_exception+0x138/0x2d0
> > [c00000005c62fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
> 
> So that is a 'fun' one, I don't remember seeing that before. It says
> we're trying to dequeue a task that is not on the runqueue.
> 
> The big new thing this merge window -- I'm assuming v6.11 is good -- is
> DEQUEUE_DELAYED. Does this error go away if you flip that in
> kernel/sched/features.h ?
Yes, with the below diff. I didn't see any warnings or kernel panic
while running the workload

# git diff
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 290874079f60..38bf8df813d1 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -46,7 +46,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  *
  * DELAY_ZERO clips the lag on dequeue (or wakeup) to 0.
  */
-SCHED_FEAT(DELAY_DEQUEUE, true)
+SCHED_FEAT(DELAY_DEQUEUE, false)
 SCHED_FEAT(DELAY_ZERO, true)

 /*



