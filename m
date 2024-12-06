Return-Path: <linux-kernel+bounces-434684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE569E69BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6406286B57
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3D1B87FA;
	Fri,  6 Dec 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AdQ/J2PW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887D1E0E0A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476097; cv=none; b=kc2WGk1th6B5rjlZYen4TPECIcnL52ARoAs82FphQo5fw2ZjrkDzUpuCfI9at33q1CgqNMx0CDUHTqbaXqruhVvlGuwc/W9I0hNfyNjXWDiOyMsGhh8/jJ0uk2MLLWQXbCwdFWbAbYLF3aksB+wqUO+8BtdlE3dyHJL8h9Olyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476097; c=relaxed/simple;
	bh=VWOBUQSuhy0l3CyultYzD2iB1KsDEi9qNdAygZKy1es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDraKDRxN5fibEI90jqZqJicNg4zU00gHjslJujeeM8zNg2z+xBlx53r0GyrQ9QtW8QuhYbT2zT7cuTxZLBMRJ7KLszC7VwMaNUMykMKi+bBS+knKXB+rC2GfLyQKWlEdIYeQUsmdtVxOSO4W0V+gPzT3e1/SYDYIwPT7HpoMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AdQ/J2PW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67UR9p000594;
	Fri, 6 Dec 2024 09:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=R2h0BM8qei3r9rv01mWNO
	bWH19MEj70+OZE+dZ0PZ+Y=; b=AdQ/J2PWLm06fm4mqzpAJP60ZW1UClFRLJR6G
	YMaMiI/0lat+DHGjEj8btJ5s0byPiek9fNN0cKOsCnaAevi/0ptkItYZHZennLgz
	OX6bWRaPaAZcNge2XCJNyg4BLn/otl2HopeYaX5GLWMCc9UIGRI760I9I4D/im9/
	itSC5hIi1uhpI6PJeLSBaspcJ6AzjHH6+2RIfYs7YJH2KodAsUHnJPW6aSA34JG4
	I+ygwgrNf+YWehSnY5eBHWLs3evAZ+So7sX1tB1y+qWmocQm76PXCXxPf2gw5pcw
	O13p7C1mAjXnKoogRpt54T2Bpe9a/GWi1MKO5yAWje8BluVfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxkrcvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:08:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B692Pdx031764;
	Fri, 6 Dec 2024 09:08:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxkrcve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:08:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B68mCjB017943;
	Fri, 6 Dec 2024 09:08:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1sp1kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:08:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B697vRS34668876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 09:07:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A35A120040;
	Fri,  6 Dec 2024 09:07:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D45D20043;
	Fri,  6 Dec 2024 09:07:55 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  6 Dec 2024 09:07:55 +0000 (GMT)
Date: Fri, 6 Dec 2024 14:37:54 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, sshegde@linux.ibm.com
Subject: Re: [PATCH] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
Message-ID: <v7lpjkr7stdkm6qnmv5dnbxlekovrsa26wxofcsnblisscbgdw@ph2rmplamzkt>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20241126064812.809903-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241126064812.809903-2-vishalc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D4RDzkrReB-1dHL5NuLgveUNtWQPgd-t
X-Proofpoint-ORIG-GUID: 2khBb4AQpKAI_9gUkp2YoPP7w89wq373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=968 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060065

* Vishal Chourasia <vishalc@linux.ibm.com> [2024-11-26 12:18:13]:

> CPU controller limits are not properly enforced during CPU hotplug operations,
> particularly during CPU offline. When a CPU goes offline, throttled
> processes are unintentionally being unthrottled across all CPUs in the system,
> allowing them to exceed their assigned quota limits.
> 
<snip>

> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fbdca89c677f..c436e2307e6f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6684,7 +6684,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  	list_for_each_entry_rcu(tg, &task_groups, list) {
>  		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>  
> -		if (!cfs_rq->runtime_enabled)
> +		/* Don't unthrottle an active cfs_rq unnecessarily */

Per the patch description, its not just unnecessary but unthrottling is
buggy. Unnecessary would mean its just an overhead. Here we dont want to
unthrottle. Other than that this seems to be fine to me.

> +		if (!cfs_rq->runtime_enabled || cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
>  			continue;

-- 
Thanks and Regards
Srikar Dronamraju

