Return-Path: <linux-kernel+bounces-323283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D65973A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7DFB25A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF61991B5;
	Tue, 10 Sep 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MVVETQWD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2E194C79
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979989; cv=none; b=l9z/bbzw05ukknj3iakJqHZwAfpjX7JBDjzR9ZOtOzOxW30tfSQDAGmUJoSyPGTJJ9JNgXHK9g4yfMJn3zF9xdHxKKmcVtuNzVf1DonP3JAtwrafH5vL2WnjhE8Z+81qucaL/GDnhGGS/6c4hkk11tguJ7dpHs5aQvI9tPv6njE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979989; c=relaxed/simple;
	bh=tvjswnYQRETrDstdxlEHNA2dDefUhi8F1TgOcFUjMug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sMFSZF8f+QXuIqi18/Ub2sMpP1G3BcCBPpJPRv7QN286mr2V1FEjq6zvE6a5b4Hn1JYOTI37XHBru9V+YKDrRYX8PxM3TsssjSkP7iRc3bPzsZGN+e6RsjNH63acYHj+Xh4Jv2wyUv8MYSbmQAi4Ej86qN3zmXdqJEfaz1cxgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MVVETQWD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A7Kx5J030619;
	Tue, 10 Sep 2024 14:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type; s=pp1; bh=qonQDgonH1ULePGnhyMk5XETZg
	UQ0UnVcq97JaC45JY=; b=MVVETQWDxcpnwvBBwl0fKJLA45nSCKBoIM9t2nvtu6
	wycGSNas3q78QgJ3iiILQMQHSuBzgxKkwRKYHY9rGP6aSzdYg8nXZqr5ZuJKaKGz
	lvuISDd/yq5Onb4qJH2EphKWuUQl/4aS3mm71fa9guU/ODcoWOVuPmdZPGRcWtHc
	jw1qldHYfApQk4oYe7xcWaVbZzZZK4+WbP/qyERbq3SINOSfzc9VAfdQeuFcy7Eh
	uGQUV1GKeir3ZGzxIxal2C+72J7eT7v1b9OTgaUN8cloNdhR9xv4zfgI7wy1vvJX
	PjYFdk9MCy0q75oje0Er1ymaPYX39aRmqGjabmXPnBjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwr7k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 14:52:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48AEkIxg009677;
	Tue, 10 Sep 2024 14:52:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwr7k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 14:52:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48ADqJVQ013476;
	Tue, 10 Sep 2024 14:52:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cm3rcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 14:52:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48AEqXFI26542840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 14:52:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A397C2004D;
	Tue, 10 Sep 2024 14:52:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 715AC20043;
	Tue, 10 Sep 2024 14:52:33 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Sep 2024 14:52:33 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
        youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 00/24] Complete EEVDF
In-Reply-To: <20240910140739.GI4723@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Tue, 10 Sep 2024 16:07:39 +0200")
References: <20240727102732.960974693@infradead.org>
	<yt9d4j6nenps.fsf@linux.ibm.com> <yt9dzfofd7im.fsf@linux.ibm.com>
	<20240910140739.GI4723@noisy.programming.kicks-ass.net>
Date: Tue, 10 Sep 2024 16:52:33 +0200
Message-ID: <yt9dttend0i6.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fWuxmchL7DU2wHoTA5het7EBu-3dsKmw
X-Proofpoint-ORIG-GUID: e5LvltAbiSEmLv3iLuL-2dCL5UAC_NtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100108

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Sep 10, 2024 at 02:21:05PM +0200, Sven Schnelle wrote:
>> Sven Schnelle <svens@linux.ibm.com> writes:
>> 
>> > Peter Zijlstra <peterz@infradead.org> writes:
>> >
>> >> Hi all,
>> >>
>> >> So after much delay this is hopefully the final version of the EEVDF patches.
>> >> They've been sitting in my git tree for ever it seems, and people have been
>> >> testing it and sending fixes.
>> >>
>> >> I've spend the last two days testing and fixing cfs-bandwidth, and as far
>> >> as I know that was the very last issue holding it back.
>> >>
>> >> These patches apply on top of queue.git sched/dl-server, which I plan on merging
>> >> in tip/sched/core once -rc1 drops.
>> >>
>> >> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.
>> >>
>> >>
>> >> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>> >>
>> >>  - split up the huge delay-dequeue patch
>> >>  - tested/fixed cfs-bandwidth
>> >>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>> >>  - SCHED_BATCH is equivalent to RESPECT_SLICE
>> >>  - propagate min_slice up cgroups
>> >>  - CLOCK_THREAD_DVFS_ID
>> >
>> > I'm seeing crashes/warnings like the following on s390 with linux-next 20240909:
>> >
>> > Sometimes the system doesn't manage to print a oops, this one is the best i got:
>> >
>> > [..]
>> > This happens when running the strace test suite. The system normaly has
>> > 128 CPUs. With this configuration the crash doesn't happen, but when
>> > disabling all but four CPUs and running 'make check -j16' in the strace
>> > test suite the crash is almost always reproducable.
>
> I noted: Comm: prctl-sched-cor, which is testing core scheduling, right?
>
> Only today I;ve merged a fix for that:
>
>   c662e2b1e8cf ("sched: Fix sched_delayed vs sched_core")
>
> Could you double check if merging tip/sched/core into your next tree
> helps anything at all?

Yes, that fixes the issue. Thanks!

