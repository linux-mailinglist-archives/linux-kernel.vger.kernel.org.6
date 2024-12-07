Return-Path: <linux-kernel+bounces-435894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192FF9E7E53
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A03163476
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A0745C1C;
	Sat,  7 Dec 2024 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sIs67msF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76B28FC
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549102; cv=none; b=PEh/FgFhuZFozLWWhNs/O7nUmilZJZSRd7rlbYqiuCKtR89JgLLz8T7xkpLp9GZBwIq3FxstPdzF+8bp3oZP1ASVJEEb+J2oUbHFtKD417uS7qBPoYmyTaK6h79+ZrL3Wqo0dG1Nq/xj3IQNRGbXAMwTmfkDei2PW/GE4aXv4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549102; c=relaxed/simple;
	bh=cl0XzP8EOE6+HOKD2e9J2O14aBngARKE65eQBSD5XS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/MiVDh4kBvdtrvMGElVHA+WABB9/6ClvI7M62qI3rqfqCQhi9CgMJZgArlviqzoGKgXaY1GVQkVrnNVPZENyHn93E7wbek/M9VRxqqW2b4fOWvo92AE3XUhT/tMxoTpsMzDcDQ85Xwnk4rwYLKdMCHiO8CHycqGhSuhj86WKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sIs67msF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B74UOUA003578;
	Sat, 7 Dec 2024 05:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=N3Q3as1ACfTfuibeOglQhdTA62gqQa
	XHP2IPz/1/1wg=; b=sIs67msFnL1rObqd4feD1CCqKTzjhVlpUqf2uv8G/Vpu5l
	D0tueu/OeIamC9mmZ9p/dWqXv85u+EEY3ZgZP7roV9lyzR+msDJIqU0bsJAB1swP
	xFuyoYuFUcBkm9sk13Wwhkwtg/+BNJkdt93pwVvaQiPzgRsK2lk3dxBKqh5N5reo
	k7AT0G0LRtqdU1lnhdLOXyuQGyFXa+c5n7Snj3+Cw3p9+YKsY2yQPhD+aF+54yQ0
	CAMPBPqF+v/SjPqBwMzUOQU2hyf9J/55FPzemBtg/xmeqTbduwJmlhrgDpejf6QC
	Egqtph3nd7jvG8oSInMTZ5SjqowjtCvITXyySd6w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv88cuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Dec 2024 05:24:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B75Oi2J013976;
	Sat, 7 Dec 2024 05:24:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv88cu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Dec 2024 05:24:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B740Cqi005286;
	Sat, 7 Dec 2024 05:24:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr225r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Dec 2024 05:24:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B75Od9018415924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 7 Dec 2024 05:24:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9847120043;
	Sat,  7 Dec 2024 05:24:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7993520040;
	Sat,  7 Dec 2024 05:24:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.29.4])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  7 Dec 2024 05:24:34 +0000 (GMT)
Date: Sat, 7 Dec 2024 10:54:27 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, sshegde@linux.ibm.com
Subject: Re: [PATCH] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
Message-ID: <Z1PcC2h-VWOIAkaG@linux.ibm.com>
References: <20241126064812.809903-2-vishalc@linux.ibm.com>
 <v7lpjkr7stdkm6qnmv5dnbxlekovrsa26wxofcsnblisscbgdw@ph2rmplamzkt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v7lpjkr7stdkm6qnmv5dnbxlekovrsa26wxofcsnblisscbgdw@ph2rmplamzkt>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 30aav4PWm6nhizhZQD8ZocSbYknA5Xuf
X-Proofpoint-ORIG-GUID: jdyYriSw1xEuQgJl5UfQsIfx8CpeFyuS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=987
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412070034

On Fri, Dec 06, 2024 at 02:37:54PM +0530, Srikar Dronamraju wrote:
> * Vishal Chourasia <vishalc@linux.ibm.com> [2024-11-26 12:18:13]:
> 
> > CPU controller limits are not properly enforced during CPU hotplug operations,
> > particularly during CPU offline. When a CPU goes offline, throttled
> > processes are unintentionally being unthrottled across all CPUs in the system,
> > allowing them to exceed their assigned quota limits.
> > 
> <snip>
> 
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> > ---
> >  kernel/sched/fair.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fbdca89c677f..c436e2307e6f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6684,7 +6684,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
> >  	list_for_each_entry_rcu(tg, &task_groups, list) {
> >  		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> >  
> > -		if (!cfs_rq->runtime_enabled)
> > +		/* Don't unthrottle an active cfs_rq unnecessarily */
> 
> Per the patch description, its not just unnecessary but unthrottling is
> buggy. Unnecessary would mean its just an overhead. Here we dont want to
> unthrottle. Other than that this seems to be fine to me.
sure.


Also, I missed running the patch against checkpatch.pl 

Will be sending out v2 with the updates.

vishalc
> 
> > +		if (!cfs_rq->runtime_enabled || cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
> >  			continue;
> 
> -- 
> Thanks and Regards
> Srikar Dronamraju

