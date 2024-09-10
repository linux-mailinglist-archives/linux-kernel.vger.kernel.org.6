Return-Path: <linux-kernel+bounces-322997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567AA973669
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9B9287503
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB48918C003;
	Tue, 10 Sep 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o2Xp9no5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A1188CDF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968793; cv=none; b=Fg9IPh0ixliS3eJAn5uMc/n0wt7ygxwvY/HshpIRA3b/KmuQNKjQvCpSAAvBFslKpBVivt3wb8ovgtc+ggxPGMCMBlhA2e1lSx9Pp/+ZSKr250ztX1yNzie35/3PLkFiGz+wP6IRqcmiiMf+Dae1/hdyAP5N6HInoEmcsGUiqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968793; c=relaxed/simple;
	bh=jKQrRwUJXvL2TXd07fChTc4rDKbe/39gfG26qL6VJiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERwNxqmBhBLXim/DXuw5I4/itYSeQSjp+9hpgkkXB9H7VgCo85Q1KodziSdeQZK6UWv8I1RUiHCghQA9XkKIeAoiM+sE+pS5x9XAMidIQ5u3Pa/bkZn+lPVepb7zlJfpsk4S1XHarBN5HvA9xDslmntFerCHLYUPBQ4CkegyHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o2Xp9no5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A7Bfh8006300;
	Tue, 10 Sep 2024 11:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type; s=pp1; bh=B3iYgtEZ/V1YOM0UYZtS07sYxt
	EeCMiv99aARL4Nl/o=; b=o2Xp9no50b6NtV0/7SVxaWU4+3NwA6xScAxP2CdY6k
	twG2UeYDsztY2JdLvj5lQWLaL3pLmD7irJM8lSu3dEHRBHHebWpiLjck7QZ0ZC7M
	aM95a2/0SgcZ+UcO63hTW8D7zDQhr5Z09JIthFO+I3vtmFOK1aJWTK4u7c5ZOMwD
	CieNMVC7HAaE6vuYT54HyL5UPRiWvjKCdeiaxS+6pznKeyQ9jQiwjBkBGMukmnqF
	ZRYBojgb7FTBQL+2TFTZH6U0Ky6flLUh0Yn4vRKNz2Is3pE41N89N8DMPjrcsKOD
	dcH3u+B+YW+XOLqObM8Ye3vsmBvDIwSNSW8wUJv0vE5g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejaf8u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 11:45:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48ABjtFL018334;
	Tue, 10 Sep 2024 11:45:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejaf8u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 11:45:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48ABYNFr003155;
	Tue, 10 Sep 2024 11:45:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15tuf6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 11:45:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48ABjqb755902576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 11:45:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4860A20043;
	Tue, 10 Sep 2024 11:45:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB68920040;
	Tue, 10 Sep 2024 11:45:51 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Sep 2024 11:45:51 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
        youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 00/24] Complete EEVDF
In-Reply-To: <20240727102732.960974693@infradead.org> (Peter Zijlstra's
	message of "Sat, 27 Jul 2024 12:27:32 +0200")
References: <20240727102732.960974693@infradead.org>
Date: Tue, 10 Sep 2024 13:45:51 +0200
Message-ID: <yt9d4j6nenps.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rC8LU-g9AFx_aZKuWpaBkEHbAX0-TTM8
X-Proofpoint-GUID: IdZUMOph1JKdKEY_KeNjeIsa0LFZOpYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409100086

Peter Zijlstra <peterz@infradead.org> writes:

> Hi all,
>
> So after much delay this is hopefully the final version of the EEVDF patches.
> They've been sitting in my git tree for ever it seems, and people have been
> testing it and sending fixes.
>
> I've spend the last two days testing and fixing cfs-bandwidth, and as far
> as I know that was the very last issue holding it back.
>
> These patches apply on top of queue.git sched/dl-server, which I plan on merging
> in tip/sched/core once -rc1 drops.
>
> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.
>
>
> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>
>  - split up the huge delay-dequeue patch
>  - tested/fixed cfs-bandwidth
>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>  - SCHED_BATCH is equivalent to RESPECT_SLICE
>  - propagate min_slice up cgroups
>  - CLOCK_THREAD_DVFS_ID

I'm seeing crashes/warnings like the following on s390 with linux-next 20240909:

Sometimes the system doesn't manage to print a oops, this one is the best i got:

[  596.146142] ------------[ cut here ]------------
[  596.146161] se->sched_delayed
[  596.146166] WARNING: CPU: 1 PID: 0 at kernel/sched/fair.c:13131 __set_next_task_fair.part.0+0x350/0x400
[  596.146179] Modules linked in: [..]
[  596.146288] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0-rc7-next-20240909 #18
[  596.146294] Hardware name: IBM 3931 A01 704 (LPAR)
[  596.146298] Krnl PSW : 0404e00180000000 001a9c2b5eea4ea4 (__set_next_task_fair.part.0+0x354/0x400)
[  596.146307]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[  596.146314] Krnl GPRS: 001c000300000027 001c000300000023 0000000000000011 0000000000000004
[  596.146319]            0000000000000001 001a9c2b5f1fb118 000000036ef94dd5 0000001b77ca6ea8
[  596.146323]            001c000000000000 001a9c2b5eec6fc0 0000001b77ca6000 00000000b7334800
[  596.146328]            0000000000000000 001a9c2b5eefad70 001a9c2b5eea4ea0 001a9bab5ee8f9f8
[  596.146340] Krnl Code: 001a9c2b5eea4e94: c0200121bbe6        larl    %r2,001a9c2b612dc660
[  596.146340]            001a9c2b5eea4e9a: c0e5fff9e9d3        brasl   %r14,001a9c2b5ede2240
[  596.146340]           #001a9c2b5eea4ea0: af000000            mc      0,0
[  596.146340]           >001a9c2b5eea4ea4: a7f4fe83            brc     15,001a9c2b5eea4baa
[  596.146340]            001a9c2b5eea4ea8: c0e50038ba2c        brasl   %r14,001a9c2b5f5bc300

[  596.146558] CPU: 1 UID: 0 PID: 18582 Comm: prctl-sched-cor Tainted: G        W          6.11.0-rc7-next-20240909 #18
[  596.146564] Tainted: [W]=WARN
[  596.146567] Hardware name: IBM 3931 A01 704 (LPAR)
[  596.146570] Krnl PSW : 0404e00180000000 001a9c2b5eec2de4 (dequeue_entity+0xe64/0x11f0)
[  596.146578]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[  596.146584] Krnl GPRS: 001c000300000027 001c000300000023 000000000000001a 0000000000000004
[  596.146589]            0000000000000001 001a9c2b5f1fb118 001a9c2b61be7144 0000000016e6692a
[  596.146593]            0000000000000001 00000000b7334951 0000000158494800 00000000b7334900
[  596.146597]            000000000000489e 0000000000000009 001a9c2b5eec2de0 001a9bab75dff760
[  596.146607] Krnl Code: 001a9c2b5eec2dd4: c0200120cdf6        larl    %r2,001a9c2b612dc9c0
[  596.146607]            001a9c2b5eec2dda: c0e5fff8fa33        brasl   %r14,001a9c2b5ede2240
[  596.146607]           #001a9c2b5eec2de0: af000000            mc      0,0
[  596.146607]           >001a9c2b5eec2de4: c004fffff90a        brcl    0,001a9c2b5eec1ff8
[  596.146607]            001a9c2b5eec2dea: a7f4fbbe            brc     15,001a9c2b5eec2566
[  596.146607]            001a9c2b5eec2dee: a7d10001            tmll    %r13,1
[  596.146607]            001a9c2b5eec2df2: a774fb1c            brc     7,001a9c2b5eec242a
[  596.146607]            001a9c2b5eec2df6: a7f4f95f            brc     15,001a9c2b5eec20b4
[  596.146637] Call Trace:
[  596.146640]  [<001a9c2b5eec2de4>] dequeue_entity+0xe64/0x11f0 
[  596.146645] ([<001a9c2b5eec2de0>] dequeue_entity+0xe60/0x11f0)
[  596.146650]  [<001a9c2b5eec34b0>] dequeue_entities+0x340/0xe10 
[  596.146655]  [<001a9c2b5eec4208>] dequeue_task_fair+0xb8/0x5a0 
[  596.146660]  [<001a9c2b6115ab68>] __schedule+0xb58/0x14f0 
[  596.146666]  [<001a9c2b6115b59c>] schedule+0x9c/0x240 
[  596.146670]  [<001a9c2b5edf5190>] do_wait+0x160/0x440 
[  596.146676]  [<001a9c2b5edf5936>] kernel_waitid+0xd6/0x110 
[  596.146680]  [<001a9c2b5edf5b4e>] __do_sys_waitid+0x1de/0x1f0 
[  596.146685]  [<001a9c2b5edf5c36>] __s390x_sys_waitid+0xd6/0x120 
[  596.146690]  [<001a9c2b5ed0cbd6>] do_syscall+0x2f6/0x430 
[  596.146695]  [<001a9c2b611543a4>] __do_syscall+0xa4/0x170 
[  596.146700]  [<001a9c2b6117046c>] system_call+0x74/0x98 
[  596.146705] Last Breaking-Event-Address:
[  596.146707]  [<001a9c2b5ede2418>] __warn_printk+0x1d8/0x1e0

This happens when running the strace test suite. The system normaly has
128 CPUs. With this configuration the crash doesn't happen, but when
disabling all but four CPUs and running 'make check -j16' in the strace
test suite the crash is almost always reproducable.

Regards
Sven

