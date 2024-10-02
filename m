Return-Path: <linux-kernel+bounces-348081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1998E254
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE3F1C20D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E3212F13;
	Wed,  2 Oct 2024 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tVSRmtqq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A621D0BA2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893384; cv=none; b=FUabOpO1vvwG/ATP6sIDJPDZcVZDbzHjOCOtddhuUGf9j1za9R74fqWIT7Cmq/FdDoWC/u+Ml1kD8tgICdPVMm2Y7oKN3Rl+9puCJX+0BPZjlR1NKQNk4sxb5feol9P2Y641bt9sheOM7Z5vVqGVxYe1jawUnXbaPiPGSn9tRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893384; c=relaxed/simple;
	bh=P0dnA6pDWDl7zAv7otneX5vQDt60doSrygZMCB8s2ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c15PyqTauVHTP5thU/mAG8Am23paPWsKFE62W424/M2c5unAMx82RYvaGif7ZkNdu93SC1ao8Y/GYexZp8DR4EISSdCBalyjkjQkGCBVo0ylAy2qQXy4K84huwKO4VU091xpoDc7l2V9zpwOlWHFGDA+6EAp6/T3PcSe8rfkiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tVSRmtqq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492IJs7k005940;
	Wed, 2 Oct 2024 18:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=t2TLF2flFJMv3iotvGq0ttJpOh3
	ksgLXpFVClpxrovQ=; b=tVSRmtqq5n1Qa8ngqAEpX0DFt/6E9CLkuaPT13bsJ5U
	AvX7xP3XZ2zYJXwjPLmI0RYImw969Feo4CYCrdvoEPjRQdiFWUmME05udlCkZWHv
	wIlw9MHiUKAgUkbBiIE7I9ly2PIpZ5FYcOz04KVSJ9CR5t19o4+mcLJdW+mO3doT
	UrM1vrHisCRbvKBB/Q3ygYRJ6QQBhCQCNiUK0xtXZVmFMBYwq1xaX22B4molIIpn
	GP2IBNOkrWed9x4m2G0OADV9I2d8917uYSSMaK2PPRBlHdMGBknDHDRTSasuVYRE
	7VK5PKvNYT9Blmj2YxljcmqMRMQ5vycC7qUY9Cwt/bg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421bbsr0gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 18:22:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 492IMlCX013071;
	Wed, 2 Oct 2024 18:22:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421bbsr0gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 18:22:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492GHhdt008026;
	Wed, 2 Oct 2024 18:22:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy4116-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 18:22:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492IMhFE53936562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 18:22:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 973FA2004F;
	Wed,  2 Oct 2024 18:22:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B6042004E;
	Wed,  2 Oct 2024 18:22:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.212.80])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Oct 2024 18:22:41 +0000 (GMT)
Date: Wed, 2 Oct 2024 23:52:38 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        luis.machado@arm.com
Subject: Re: sched/fair: Kernel panics in pick_next_entity
Message-ID: <Zv2PbgNZPgV-MbB2@linux.ibm.com>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
 <Zvr2bLBEYyu1gtNz@linux.ibm.com>
 <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
 <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
 <20241002084932.GN5594@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002084932.GN5594@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JCkhJJuG8i_hUolecMZBna-U3rYnZw38
X-Proofpoint-GUID: 9B6eP0drehTwlHEIkN5QBSfJcdFGl_7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_18,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=462 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020131

On Wed, Oct 02, 2024 at 10:49:32AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 01, 2024 at 10:30:26AM +0200, Mike Galbraith wrote:
> > On Tue, 2024-10-01 at 00:45 +0530, Vishal Chourasia wrote:
> > > >
> > > for sanity, I ran the workload (kernel compilation) on the base commit
> > > where the kernel panic was initially observed, which resulted in a
> > > kernel panic, along with it couple of warnings where also printed on the
> > > console, and a circular locking dependency warning with it.
> > >
> > > Kernel 6.11.0-kp-base-10547-g684a64bf32b6 on an ppc64le
> > >
> > > ------------[ cut here ]------------
> > >
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > 6.11.0-kp-base-10547-g684a64bf32b6 #69 Not tainted
> > > ------------------------------------------------------
> > 
> > ...
> > 
> > > --- interrupt: 900
> > > se->sched_delayed
> > > WARNING: CPU: 1 PID: 27867 at kernel/sched/fair.c:6062 unthrottle_cfs_rq+0x644/0x660
> > 
> > ...that warning also spells eventual doom for the box, here it does
> > anyway, running LTPs cfs_bandwidth01 testcase and hackbench together,
> > box grinds to a halt in pretty short order.
> > 
> 
> Right, I've picked up your patch for sched/urgent. But this does make me
> question Vishal's setup.
> 
> He said all he does is compile a kernel, but afaik no regular setup uses
> CFS bandwidth by default. So something is 'special' at his end that he's
> not been telling us about.
Yes Peter, I'm compiling the kernel from source. While I'm not running the 
compilation within a cgroup that has bandwidth limits set, there are some 
system services running in the background that do have bandwidth 
limitations applied.


# find . -name cpu.max -exec cat {} +
max 100000
max 100000
max 100000
max 100000
max 100000
max 100000
5000 100000
34000 100000
10000 100000
31000 100000
max 100000
max 100000
max 100000
max 100000
max 100000
max 100000

> 
> Vishal, could you expand upon your configuration? How come you're using
> CFS bandwidth, what else is special?
config cfs_bandwidth is enabled by default in both the
pseries_le_defconfig and the distro kernel config I'm using for the
compilation.

Let me know if you need any more info. I hope I have answered your
queries.

Thanks!

