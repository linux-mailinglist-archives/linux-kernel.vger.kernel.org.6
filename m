Return-Path: <linux-kernel+bounces-378322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98199ACE70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6541F282BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C171BE23F;
	Wed, 23 Oct 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z9IZWNHO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E171A08C2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696641; cv=none; b=UBCSWPIKpcXGjMl+Dg5QCOxdR8QYsQ8mZuQ9nM5UVCGQakYuJuCO0cYidinbGDx+WW3DtRIuqcV7Sj3imkHYz/tnxteGXurGBeIbX2YE9EU0UWPLRJXaL4tws8FsssKeWyCNS94KHAOB8NOhhl56cN3Zvsx4Ipyue0Y5rWE5+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696641; c=relaxed/simple;
	bh=7QXtgMik+x9PyMt0aIrb9yDcVGFj/6gmQhdTCVIJNmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uofb4+zPuCx/AuO1z5YVC6YD8uP6mqWSqAox4VjiC/P8nN5PPlTOHk1y+o0TjYgZGtIUNTmncHA00HOSZkm2UssiHNDaBe8TIr4XWPtPHDFiQH9AbNfbo1Gcd2wliAeFG69kwFsAgb3UhH6+3Qb36bP73n6Pvb44v23SSulZceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z9IZWNHO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDAbpx027450;
	Wed, 23 Oct 2024 15:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9c5VXu
	XWYBCUIxxlDDct7TgskUlWq5rnL3yH2zaR94k=; b=Z9IZWNHOeVtYBQeJresU4i
	UQdsjzX3EGsYy3l9IhYyh8dgLOZD3w/Qd1N8DRPxRuy/XQPIOLrhkDdG9PgzlRpN
	esRZHDK67eC1gMy7DPQUZP75P3n2v9M0l7GcMNQsB8Tf/jy0RXXcjjAz+Gf734YT
	GM3hTocX9FHCWeJzV+omz3P0Osdyi6B79PhN72Ql3MioFTby7+OBXW4OuhAjaT1j
	w+EH0s5/1qSmOTmLCft7p6YS0U/iRHCyIfPtK1E1iAs7qZXDH+S6Py+DW/HTF3T6
	zS1ks83wCMl1rbXjQM6W8uDE2LY9ZH23wcPZIR8ZxNu6kX7YPwspSgo9DKS1D3BQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafkr4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:17:00 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NFH0Yj000818;
	Wed, 23 Oct 2024 15:17:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafkr4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:17:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBefop001542;
	Wed, 23 Oct 2024 15:16:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9beff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:16:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NFGvcN29229756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:16:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AACC920043;
	Wed, 23 Oct 2024 15:16:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEE620040;
	Wed, 23 Oct 2024 15:16:54 +0000 (GMT)
Received: from [9.39.29.91] (unknown [9.39.29.91])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 15:16:54 +0000 (GMT)
Message-ID: <32e0b995-eb81-42bf-904b-225a3b7c0e87@linux.ibm.com>
Date: Wed, 23 Oct 2024 20:46:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
To: Steve Wahl <steve.wahl@hpe.com>, Valentin Schneider <vschneid@redhat.com>
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
References: <20241010155111.230674-1-steve.wahl@hpe.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241010155111.230674-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m6t6agrCRGBMrlzv9TUxoUfkeHVzGCi0
X-Proofpoint-GUID: 04CJ3LKgx1Aakwg1INhWC4fajtf1uP8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxscore=0 mlxlogscore=910 adultscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230091



On 10/10/24 21:21, Steve Wahl wrote:
> Use a different approach to topology_span_sane(), that checks for the
> same constraint of no partial overlaps for any two CPU sets for
> non-NUMA topology levels, but does so in a way that is O(N) rather
> than O(N^2).
> 
> Instead of comparing with all other masks to detect collisions, keep
> one mask that includes all CPUs seen so far and detect collisions with
> a single cpumask_intersects test.
> 
> If the current mask has no collisions with previously seen masks, it
> should be a new mask, which can be uniquely identified by the lowest
> bit set in this mask.  Keep a pointer to this mask for future
> reference (in an array indexed by the lowest bit set), and add the
> CPUs in this mask to the list of those seen.
> 
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, looked up in the same array
> indexed by the lowest bit set in the mask, a single comparison.
> 
> Move the topology_span_sane() check out of the existing topology level
> loop, let it use its own loop so that the array allocation can be done
> only once, shared across levels.
> 
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

I was trying to go through this issue and observed below.
Looks like the computations are repeated in below manner.

Assume SMT4 system.

[[0 2 4 6]   [1 3 5 7] ]   [ [8 10 12 14]  [9 11 13 15] ]
  <--SMT-->   <--SMT-->       <---SMT---->  <----SMT--->
<---------PKG---------->   <------------PKG------------->


Lets say it happening for CPU0, at SMT level, then it will do, masking 
in below manner.

2: [0 2 4 6] & [0 2 4 6]
4: [0 2 4 6] & [0 2 4 6]
6: [0 2 4 6] & [0 2 4 6]

1: [0 2 4 6] & [1 3 5 7]
3: [0 2 4 6] & [1 3 5 7]
5: [0 2 4 6] & [1 3 5 7]
7: [0 2 4 6] & [1 3 5 7]

8: [0 2 4 6] & [8 10 12 14]
10:[0 2 4 6] & [8 10 12 14]
12:[0 2 4 6] & [8 10 12 14]
14:[0 2 4 6] & [8 10 12 14]

9: [0 2 4 6] & [9 11 13 15]
11:[0 2 4 6] & [9 11 13 15]
13:[0 2 4 6] & [9 11 13 15]
15:[0 2 4 6] & [9 11 13 15]


And when it happens for CPU2, it will do the exact same computation. 
Maybe that can be avoided with something like below. Do the computation
if it is the first cpu in that topology level mask.

Not sure if it works in all scenarios. Tested very very lightly on 
power10 system with SMT=4.

Please correct me if i got it all wrong.

------------------------------------------------------------------------

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..541631ca32bd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2367,6 +2367,13 @@ static bool topology_span_sane(struct 
sched_domain_topology_level *tl,
         if (tl->flags & SDTL_OVERLAP)
                 return true;

+       /* Do the computation only if this cpu is first CPU
+        * in the topology level mask. Same computation is kind of
+        * Repetitions on other CPUS */
+       if (!(cpu == cpumask_first(tl->mask(cpu)))) {
+               return true;
+       }
+
         /*
          * Non-NUMA levels cannot partially overlap - they must be either
          * completely equal or completely disjoint. Otherwise we can end up


