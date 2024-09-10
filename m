Return-Path: <linux-kernel+bounces-323057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E4973714
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866331F26206
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45618E77F;
	Tue, 10 Sep 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhm/f4kQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650518C347
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970896; cv=none; b=CBNVuTnJlUXy3ljbTnnyqHYi/1YnswJ6dwvUJXWHy7XPDrB4liQo7IpFeBcaufy1FQMsaiZl/xfmmxQSsMycIl86auJ5jrocM114NETvymWUL3AISMEh2Jeea6JnZpIzzkb7CoRx6E1TmgZph2XtIrsn3dRZIicH0/EOLC4se24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970896; c=relaxed/simple;
	bh=Yy/uCsgfxv2hexTxawH3Q4aYphAXTQfogySLSH71qMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=ViTci5aOmsOJNmed9/j7i9QyGHcMgdNjtbMb+Ws+YSVN3kmUOwqUD23UrdtJzK8cQ6sl2mfVfgxNcehiHdxNZ4VupLUBwX/Q//FcV+bTz0kT/e819zARKj3ascQYFRZ0Fnodsixug9VBCs5AFwaS/XJHoifubiOQfDPJNhcHMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhm/f4kQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8Qeti015231;
	Tue, 10 Sep 2024 12:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=XUaUVVkb0XT/u8nvJR30AODfRM
	PZC9UijDR/tN6vjhI=; b=bhm/f4kQRPy2EBcrezzK8DWSgcPvy6bbKJF5Q8iZoV
	rA0M/FQUJqXsAzSuDwakXOD1kkEGOdWfUTkMttgYipDGZL2a56EJDUrH7fbowv7E
	FdhmChLi/9NuReDB6z/hO2rfASZCFd1ts53RMDxlTal4n45EbmMmkKpvahHgSP4C
	Ohay5M5vsYgnRX4prwF0GJ0qBUo+M4CQLzRtae372WO0Jn0+A4cJiAAKzQz5AX3Y
	YmWcldmyXfLnSxVqitcFMbPJk+T3sjRK7qJ0rHxfYrSjYhPxez4GNi41gh6Z23xf
	9u2mW86RvDcMQi3ujOWlsrBKL6uFiuqmnU2n0Ua9X+4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwqdst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 12:21:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48ACL9iZ015473;
	Tue, 10 Sep 2024 12:21:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwqdse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 12:21:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8xsbb032073;
	Tue, 10 Sep 2024 12:21:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmkajw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 12:21:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48ACL69657016666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 12:21:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 059DC20049;
	Tue, 10 Sep 2024 12:21:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9FCD20040;
	Tue, 10 Sep 2024 12:21:05 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Sep 2024 12:21:05 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
        youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 00/24] Complete EEVDF
In-Reply-To: <yt9d4j6nenps.fsf@linux.ibm.com> (Sven Schnelle's message of
	"Tue, 10 Sep 2024 13:45:51 +0200")
References: <20240727102732.960974693@infradead.org>
	<yt9d4j6nenps.fsf@linux.ibm.com>
Date: Tue, 10 Sep 2024 14:21:05 +0200
Message-ID: <yt9dzfofd7im.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1QRsJDksr0op8YJGE9wgQeDfHOUoVhSK
X-Proofpoint-ORIG-GUID: kuivBLcV3g54KqYQiJ-UlCysj0JqXnKY
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100089

Sven Schnelle <svens@linux.ibm.com> writes:

> Peter Zijlstra <peterz@infradead.org> writes:
>
>> Hi all,
>>
>> So after much delay this is hopefully the final version of the EEVDF patches.
>> They've been sitting in my git tree for ever it seems, and people have been
>> testing it and sending fixes.
>>
>> I've spend the last two days testing and fixing cfs-bandwidth, and as far
>> as I know that was the very last issue holding it back.
>>
>> These patches apply on top of queue.git sched/dl-server, which I plan on merging
>> in tip/sched/core once -rc1 drops.
>>
>> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.
>>
>>
>> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>>
>>  - split up the huge delay-dequeue patch
>>  - tested/fixed cfs-bandwidth
>>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>>  - SCHED_BATCH is equivalent to RESPECT_SLICE
>>  - propagate min_slice up cgroups
>>  - CLOCK_THREAD_DVFS_ID
>
> I'm seeing crashes/warnings like the following on s390 with linux-next 20240909:
>
> Sometimes the system doesn't manage to print a oops, this one is the best i got:
>
> [..]
> This happens when running the strace test suite. The system normaly has
> 128 CPUs. With this configuration the crash doesn't happen, but when
> disabling all but four CPUs and running 'make check -j16' in the strace
> test suite the crash is almost always reproducable.

I failed to add the log from git bisect. Unfortunately i had to skip
some commit because the kernel didn't compile:

git bisect start
# status: waiting for both good and bad commits
# bad: [100cc857359b5d731407d1038f7e76cd0e871d94] Add linux-next specific files for 20240909
git bisect bad 100cc857359b5d731407d1038f7e76cd0e871d94
# status: waiting for good commit(s), bad commit known
# good: [da3ea35007d0af457a0afc87e84fddaebc4e0b63] Linux 6.11-rc7
git bisect good da3ea35007d0af457a0afc87e84fddaebc4e0b63
# good: [df20078b9706977cc3308740b56993cf27665f90] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good df20078b9706977cc3308740b56993cf27665f90
# good: [609f9e1b6242e7158ce96f9124372601997ce56c] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
git bisect good 609f9e1b6242e7158ce96f9124372601997ce56c
# skip: [664c3413e9a6c345a6c926841358314be9da8309] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect skip 664c3413e9a6c345a6c926841358314be9da8309
# good: [16531118ba63dd9bcd65203d04a9c9d6f6800547] iio: bmi323: peripheral in lowest power state on suspend
git bisect good 16531118ba63dd9bcd65203d04a9c9d6f6800547
# bad: [d9c7ac7f8bfb16f431daa7c77bdfe2b163361ead] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
git bisect bad d9c7ac7f8bfb16f431daa7c77bdfe2b163361ead
# bad: [05536babd768b38d84ad168450f48634a013603d] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 05536babd768b38d84ad168450f48634a013603d
# good: [dabef94a179957db117db344b924e5d5c4074e5f] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good dabef94a179957db117db344b924e5d5c4074e5f
# bad: [d4886a325947ecae6867fc858657062211aae3b9] Merge branch into tip/master: 'locking/core'
git bisect bad d4886a325947ecae6867fc858657062211aae3b9
# bad: [51c095bee5c77590d43519f03179342e910d333c] Merge branch into tip/master: 'core/core'
git bisect bad 51c095bee5c77590d43519f03179342e910d333c
# bad: [fc1892becd5672f52329a75c73117b60ac7841b7] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
git bisect bad fc1892becd5672f52329a75c73117b60ac7841b7
# good: [ae04f69de0bef93c7086cf2983dbc8e8fd624ebe] sched/rt: Rename realtime_{prio, task}() to rt_or_dl_{prio, task}()
git bisect good ae04f69de0bef93c7086cf2983dbc8e8fd624ebe
# good: [abc158c82ae555078aa5dd2d8407c3df0f868904] sched: Prepare generic code for delayed dequeue
git bisect good abc158c82ae555078aa5dd2d8407c3df0f868904
# skip: [781773e3b68031bd001c0c18aa72e8470c225ebd] sched/fair: Implement ENQUEUE_DELAYED
git bisect skip 781773e3b68031bd001c0c18aa72e8470c225ebd
# skip: [e1459a50ba31831efdfc35278023d959e4ba775b] sched: Teach dequeue_task() about special task states
git bisect skip e1459a50ba31831efdfc35278023d959e4ba775b
# skip: [a1c446611e31ca5363d4db51e398271da1dce0af] sched,freezer: Mark TASK_FROZEN special
git bisect skip a1c446611e31ca5363d4db51e398271da1dce0af
# good: [e28b5f8bda01720b5ce8456b48cf4b963f9a80a1] sched/fair: Assert {set_next,put_prev}_entity() are properly balanced
git bisect good e28b5f8bda01720b5ce8456b48cf4b963f9a80a1
# skip: [f12e148892ede8d9ee82bcd3e469e6d01fc077ac] sched/fair: Prepare pick_next_task() for delayed dequeue
git bisect skip f12e148892ede8d9ee82bcd3e469e6d01fc077ac
# skip: [152e11f6df293e816a6a37c69757033cdc72667d] sched/fair: Implement delayed dequeue
git bisect skip 152e11f6df293e816a6a37c69757033cdc72667d
# skip: [2e0199df252a536a03f4cb0810324dff523d1e79] sched/fair: Prepare exit/cleanup paths for delayed_dequeue
git bisect skip 2e0199df252a536a03f4cb0810324dff523d1e79
# bad: [54a58a78779169f9c92a51facf6de7ce94962328] sched/fair: Implement DELAY_ZERO
git bisect bad 54a58a78779169f9c92a51facf6de7ce94962328
# only skipped commits left to test
# possible first bad commit: [54a58a78779169f9c92a51facf6de7ce94962328] sched/fair: Implement DELAY_ZERO
# possible first bad commit: [152e11f6df293e816a6a37c69757033cdc72667d] sched/fair: Implement delayed dequeue
# possible first bad commit: [e1459a50ba31831efdfc35278023d959e4ba775b] sched: Teach dequeue_task() about special task states
# possible first bad commit: [a1c446611e31ca5363d4db51e398271da1dce0af] sched,freezer: Mark TASK_FROZEN special
# possible first bad commit: [781773e3b68031bd001c0c18aa72e8470c225ebd] sched/fair: Implement ENQUEUE_DELAYED
# possible first bad commit: [f12e148892ede8d9ee82bcd3e469e6d01fc077ac] sched/fair: Prepare pick_next_task() for delayed dequeue
# possible first bad commit: [2e0199df252a536a03f4cb0810324dff523d1e79] sched/fair: Prepare exit/cleanup paths for delayed_dequeue

