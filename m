Return-Path: <linux-kernel+bounces-566218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C5FA67513
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08A73B3191
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4420CCE9;
	Tue, 18 Mar 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p2J7/ekc"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB163206F22
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304297; cv=none; b=ZPKZ2oU4ZmEjQJxgrLLNCF1yVj0aOuoXolki3yVUPpJCtSu7HcxY7VZJneWU2YCtlJP89a85RGLKKfxdC9w/biHIMR0uLGI+Z+RCYHKKShy5Anb47BPuouDPluyxWwei3ZOe1bnbIIfevMVkx8XojcnjVTFpZMiax+Dl133Boww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304297; c=relaxed/simple;
	bh=BuOvW7eyYaT5DbhjI637N0geQsyWJU5agQ+gp1GmwEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGLF5MPJgepPE9Ee2+a/B7xhYcLgnD0amx1mDaQKV6HeuiYHHr6EsbCF4iDDgR2ZB090rMc/9v/ieobyu0/q3HFi0p4kY5tLRgmNXZBb/t/BTSwclWOUv7Ufsoi1Rn0LIX1ITIO5CXFIz1zxcv4bmixkcg4++R1CMFnMDM6Tibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p2J7/ekc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ID2EhB008725;
	Tue, 18 Mar 2025 13:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AHLgZ5
	XycjmAhaOgRjAzdPYu9We1Fze8Zvp5Pfd4LAo=; b=p2J7/ekcJ8xp2d5vImzwSt
	9zurhpLtc9I80ZDnAAlCsVQfvj8ZgO+nsKVqCKWS7BN/PKxIkaQc0UG7H/AQ0Ci+
	b5MOcJcUPvBbHqTLxt/MzHiTUeOYKlO7WZBrnPxgmD+dP91aqRGXB5fridYlcoaC
	lfZUwA9lYVz3X8pUYw9hsrKo/mAqqYi6+NWvf/uZc9+rlJMMX9OIXcATd6ZIOn2A
	QbPJ4UJQSH9+ip/L5gbcnQRkTxYxpeo9A0qrGrGjFtQu9/oboQYIHUggt1Y+BM6+
	uWLh4YETFapRs8s79bsAPmPui9sUrBDToGqWcLGSTEU/AFbEJOsKdYCyum8TjflA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45etwqbxhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 13:24:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ID6q96005664;
	Tue, 18 Mar 2025 13:24:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8yv5sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 13:24:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IDOQPl29426292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 13:24:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 246DB20040;
	Tue, 18 Mar 2025 13:24:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C2020043;
	Tue, 18 Mar 2025 13:24:23 +0000 (GMT)
Received: from [9.124.211.142] (unknown [9.124.211.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 13:24:23 +0000 (GMT)
Message-ID: <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
Date: Tue, 18 Mar 2025 18:54:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6Brk4DRwFZBfFnBuQzn5KRMr8O86BuET
X-Proofpoint-ORIG-GUID: 6Brk4DRwFZBfFnBuQzn5KRMr8O86BuET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=981 suspectscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503180096



On 3/12/25 20:46, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> this is a follow up on
>          https://lore.kernel.org/ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb
> 
> and adds support for task local futex_hash_bucket.
> 
> This is the local hash map series based on v9 extended with PeterZ
> FUTEX2_NUMA and FUTEX2_MPOL plus a few fixes on top.
> 
> The complete tree is at
> 	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/log/?h=futex_local_v10
> 	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git futex_local_v10
> 

Hi Sebastian. Thanks for working on this (along with bringing back FUTEX2 NUMA) which
might help large systems with many futexes.

I tried this in one of our systems(Single NUMA, 80 CPUs), I see significant reduction in futex/hash.
Maybe i am missing some config or doing something stupid w.r.t to benchmarking.
I am trying to understand this stuff.

I ran "perf bench futex all" as is. No change has been made to perf.
=========================================
Without patch: at 6575d1b4a6ef3336608127c704b612bc5e7b0fdc
# Running futex/hash benchmark...
Run summary [PID 45758]: 80 threads, each operating on 1024 [private] futexes for 10 secs.
Averaged 1556023 operations/sec (+- 0.08%), total secs = 10   <<--- 1.5M

=========================================
With the Series: I had to make PR_FUTEX_HASH=78 since 77 is used for TIMERs.

# Running futex/hash benchmark...
Run summary [PID 8644]: 80 threads, each operating on 1024 [private] futexes for 10 secs.
Averaged 150382 operations/sec (+- 0.42%), total secs = 10   <<-- 0.15M, close to 10x down.

=========================================

Did try a git bisect based on the futex/hash numbers. It narrowed it to this one.
first bad commit: [5dc017a816766be47ffabe97b7e5f75919756e5c] futex: Allow automatic allocation of process wide futex hash.

Is this expected given the complexity of hash function change?


Also, is there a benchmark that could be run to evaluate FUTEX2_NUMA, I would like to
try it on multi-NUMA system to see the benefit.

