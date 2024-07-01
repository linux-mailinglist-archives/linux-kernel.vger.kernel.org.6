Return-Path: <linux-kernel+bounces-236606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03F91E4BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59FF2826FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F19143737;
	Mon,  1 Jul 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UCYFSzJm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B574142624
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849737; cv=none; b=s5gs4UWW/7MWB/9Uid8fEeWMpXAhx+3zqVpy5dm0HDarULV/9IMz4uslTWYreeIFlVB5JoVWmoiS4BfsK/YP5s2yoXi2e/M3UlRnMSVDNwcRBU0yZgdS2w/TZykW1q0JRZEg5LWgm+fcYe+P8fvbL2uWbeqEJgUMD0t1IgJ1ILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849737; c=relaxed/simple;
	bh=506xFAdFP04zrSciQKu/sbYoow44KnDvc6v05EDexBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWsFtDMfxPpIEUGQv3RgI+tN07EcEJ2T9iBPc/jkZjHxpmke3x6btU9DPw/7JwZjMOqFv9M8wKYpyHE9k32Vsk5fS0llTgXL5ooeeY/Ncuo+f2aE69IZk+S/izvEBmqNidQXekRA3zXUYZ2X/K3JQXKxb/nqYzWpWyliWChPUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UCYFSzJm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461FRhE3030072;
	Mon, 1 Jul 2024 15:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	l2DVgo2iYW4gQPmRDiAuMeNH+B42wKmUccRJqFCRY9I=; b=UCYFSzJmB5ZThk+D
	Vwo83shLoFqB5Y3i/tmhqnrP24hIUnaGQuZaAVCedGYQ2ARal+Kymb31Q8ueU1m5
	IKCwWySBYFT3L+K0Chn3wm8UgPFYIy+f4yaoRvfGI2IXh7z+o+qvrZFbm71HT//M
	JcPqZ840fEXoUwlupgtAM8MJzVH/2NniPvkF4Rc4hilL9/+MrDs0T5GdAyJMMPPh
	+AA/jAl95cV71gLRGzYXSmDmDI0u++kRGbswhBW5BcMacQLFQ7M+wWo7X5SOC8cQ
	nLT8ADvMgPfPLVtqr1LW43ymVP0iLhIlUxnZo5LyqdmF/qOBcTPi1H5Zbty6Mdwj
	eCxCmg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403xpe04qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 15:56:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 461Fu8gQ018649;
	Mon, 1 Jul 2024 15:56:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403xpe04qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 15:56:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461DSGB2024077;
	Mon, 1 Jul 2024 15:56:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya37ntr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 15:56:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461Fu38b33948380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 15:56:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EDCC20043;
	Mon,  1 Jul 2024 15:56:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 082DD20040;
	Mon,  1 Jul 2024 15:56:00 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com.com (unknown [9.124.209.85])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 15:55:59 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: zhangqiao22@huawei.com, mchauras@hotmail.com
Cc: Markus.Elfring@web.de, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Subject: Re: [PATCH v2] sched: Initialize the vruntime of a new task when it is first enqueued
Date: Mon,  1 Jul 2024 21:25:08 +0530
Message-ID: <171984853311.154200.2041889183083175576.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627133359.1370598-1-zhangqiao22@huawei.com>
References: <20240627133359.1370598-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iBcIgJOqryL6UaZISiDFCfl9yDEXFHbv
X-Proofpoint-ORIG-GUID: hCH6oLPUHvtGnVDQ9ay4hTlj6hXOEWoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_15,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=793 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010118


On Thu, 27 Jun 2024 21:33:59 +0800, Zhang Qiao wrote:
> When creating a new task, we initialize vruntime of the newly task at
> sched_cgroup_fork(). However, the timing of executing this action is too
> early and may not be accurate.
> 
> Because it uses current CPU to init the vruntime, but the new task
> actually runs on the cpu which be assigned at wake_up_new_task().
> 
> [...]

I tried this on a 104 cpu ppc64le Power9 system

The experiment was to stress the cpus with 416 threads(4 * nproc)
and then run small commands like date, time, ls etc

With bpf i collected the time it took for the tasks from waking up
to switching on to the cpu.

I collected 3600 samples for each

The results are as follows:

With patch

@: count 3601, average 4609830, total 16599997845

@c: 3709
@latency: 
[4K, 8K)               1 |                                                    |
[8K, 16K)              4 |                                                    |
[16K, 32K)          2270 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)            45 |@                                                   |
[64K, 128K)            3 |                                                    |
[128K, 256K)         141 |@@@                                                 |
[256K, 512K)          24 |                                                    |
[512K, 1M)             7 |                                                    |
[1M, 2M)               8 |                                                    |
[2M, 4M)              38 |                                                    |
[4M, 8M)             226 |@@@@@                                               |
[8M, 16M)            321 |@@@@@@@                                             |
[16M, 32M)           501 |@@@@@@@@@@@                                         |
[32M, 64M)            12 |                                                    |

# Without Patch

@: count 3600, average 12786599, total 46031757085

@c: 3608
@latency: 
[4K, 8K)               1 |                                                    |
[8K, 16K)              6 |                                                    |
[16K, 32K)           297 |@@@@@@@@@@@                                         |
[32K, 64K)            25 |                                                    |
[64K, 128K)            4 |                                                    |
[128K, 256K)         149 |@@@@@                                               |
[256K, 512K)          21 |                                                    |
[512K, 1M)             5 |                                                    |
[1M, 2M)              14 |                                                    |
[2M, 4M)              45 |@                                                   |
[4M, 8M)             857 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                   |
[8M, 16M)            812 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     |
[16M, 32M)          1325 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32M, 64M)            31 |@                                                   |

The patch leads to a significant decrease in latency of a newly woken task.

Tested-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Reviewed-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

