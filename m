Return-Path: <linux-kernel+bounces-527399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F720A40AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B819B189EC81
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C16201034;
	Sat, 22 Feb 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YaPdj2tR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E41DDE9
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740246543; cv=none; b=ZjgZH3/HdfMiObd1dwaXlfU3qKhrg2lnjigpW6EeZOK0eosrkyUgo2SJyx+S3DB2t3S6iIuJO9wCwZKoKA+Po7ug85cK5UTdVLw+0C+3IYRz0ZdjG1cSAPqAsbXrRU4+F/qwdGC++oKgqoyCojdsXuAfG9LGKIJjbIpp11RxgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740246543; c=relaxed/simple;
	bh=fyXhL1vYPnEm4LpXY3rZDMxwMLSL5AfnDUK3xPw/EB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiXmXtEa9sZIh1iztOJgDA2Zglg4ULiV8HFqsQDX7fWd5I2HdmuUZykothlz+pS5cKrbSKVmoBq1N5X82teszsCQNfpSgazvsXr2dva2Ja5TpBC0B36smou+RMloi4tF1hdGZgC/WfIpdcNSAoeL5QvUgWyLolVAq2ctIrPeiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YaPdj2tR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M9VZCx026800;
	Sat, 22 Feb 2025 17:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=s7ee8y+j+2S+3pcbZZ/rYDpOqbtAtAVzH9Tt57Um7xI=; b=YaPdj2tRJjS3
	mXdHLp74O8M5Z5GloK/DYHa14J5CAMoantI8/of90FNN74CVQY3fyNDCNuGYAPUZ
	O6RfmBYISKI/HLW8UB55lvn5uH3GmZQT/8yb8882AtbKz3DHin/bB7iXuG5LfS58
	oWQ5nFbOtmNTTVtE9N386V+EtmxulN3oENvPeerABq5SfeFE/zDoznMEXZh2mvBy
	NZpAyfiFuvifWSnPOGojbH93W0gcPzsImz9N+AcG1bi7JqGXQMGA3jQPGAnQQh3R
	9Alf+aijCOb1bYyul+5PqmP9bgxl+oDk96BylkEQ3W3WxQIgot9qF2w9jjgMZQ7H
	C29SyA66Qg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y83aa0x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 17:48:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51MHmc3b025080;
	Sat, 22 Feb 2025 17:48:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y83aa0x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 17:48:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51MGFbnb009702;
	Sat, 22 Feb 2025 17:48:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03yp9xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 17:48:37 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51MHmaoa21234396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 17:48:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673EE58056;
	Sat, 22 Feb 2025 17:48:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8AB358052;
	Sat, 22 Feb 2025 17:48:31 +0000 (GMT)
Received: from [9.43.65.232] (unknown [9.43.65.232])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Feb 2025 17:48:31 +0000 (GMT)
Message-ID: <e7c4d27f-6b98-4cd6-85b8-9c4672acdef4@linux.ibm.com>
Date: Sat, 22 Feb 2025 23:18:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Do not let idle entities preempt others
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Josh Don <joshdon@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-2-wuyun.abel@bytedance.com>
Content-Language: en-US
Reply-To: 20250221111226.64455-2-wuyun.abel@bytedance.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250221111226.64455-2-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3-0YB5svzY0bLJ53mV3TnkFY30jWs_VC
X-Proofpoint-GUID: F5J9kO4PfrF_EriJuq3Uj-6K_HPYzkAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=826
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220140

On 21/02/25 16:42, Abel Wu wrote:
> A task with SCHED_IDLE policy doesn't preempt others by definition, and
> the semantics are intended to be preserved when extending to cgroups
> introduced in commit 304000390f88 ("sched: Cgroup SCHED_IDLE support").

[snip]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c0ef435a7aa..4340178f29b7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8778,12 +8778,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	pse_is_idle = se_is_idle(pse);
>  
>  	/*
> -	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
> -	 * in the inverse case).
> +	 * Preempt an idle entity in favor of a non-idle entity.
>  	 */
>  	if (cse_is_idle && !pse_is_idle)
>  		goto preempt;

This patch doesn't apply cleanly on top of tip/sched/core because of the
commit f553741ac8c0 ("sched: Cancel the slice protection of the idle entity").
Please rebase it.

Thanks,
Madadi Vineeth Reddy

> -	if (cse_is_idle != pse_is_idle)
> +
> +	/*
> +	 * IDLE entities do not preempt others.
> +	 */
> +	if (unlikely(pse_is_idle))
>  		return;
>  
>  	/*


