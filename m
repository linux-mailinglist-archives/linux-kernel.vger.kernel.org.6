Return-Path: <linux-kernel+bounces-260654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B9393AC81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3842837DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC7482FF;
	Wed, 24 Jul 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qIvSVVxg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7865A955
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802092; cv=none; b=jZHUF4H6O+9uSQbndEva45pmb2ebZVknUvSTO2WLVJvksITaUDo3OAKlOjJj2NBIP2a9v6f+EYCs/NTuorQYbyTDc5GgjXGFG1uy2Qwmvmz2/5gN9vTgGXpjwBy6PB6QPNu8DQSfHk3EyVdlhosT5h4YSFSNa3qyTO9oaHCByRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802092; c=relaxed/simple;
	bh=lZ2zZjTw6BJlh4wNSGW/LHkY/Av1Norj9ABdse6Yivo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ghsG5H2CklTXsLvYNX1YS3/r70C+lvJVTYspdG9XP7BnwKdAbPNl+vPQL/xO0qraE0555E9E//yO/fCEvIkUta0SZe+5okG1+SosAY7mfU5EB8JFVir6T8m7e+K6tqe+xrUXpObdAA+gRqFLtXE+fyiQYpkhWASNE0U45LfsXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qIvSVVxg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O60IJu024905;
	Wed, 24 Jul 2024 06:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=irV7MYCXgJKS4Eb3M5n0b9VtK1K
	m9aVzEh+uklXz4q0=; b=qIvSVVxg9bPl2EXsrDB4Ryjjp2JRXNTPbuD8YKCDTDf
	nowNs5nP0usRG87NQbMMPsZ3Fsh285sHKyY9HCcjbnZTyaz99YxAB3I1DpFWYf3t
	KbkRhB1JyvSCm1Zm97RrNjO5uHkcFKVquizNJDOSEhOExY6hysI2IKZYCLfaBVff
	txkPaXRgmZbwQwgG+BK/iexutsNBNg93nlHlifHThr10bhQHcox5UFi/liamH97s
	Bh4+asZeyNjXZn618CJdxr7SkOrldyKM13AyahenAOrrQs4bsmDrzZg6tWtomoNV
	/xIXQP8LagatVgYqaw3jiGEkyz8FsyCtI+jT8fg8gWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40juxcg1e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 06:21:00 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46O6KxO9028691;
	Wed, 24 Jul 2024 06:20:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40juxcg1e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 06:20:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46O5ISTZ009111;
	Wed, 24 Jul 2024 06:20:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93f4nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 06:20:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46O6KtVA57147818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 06:20:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDB6220040;
	Wed, 24 Jul 2024 06:20:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA9720043;
	Wed, 24 Jul 2024 06:20:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.94.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jul 2024 06:20:51 +0000 (GMT)
Date: Wed, 24 Jul 2024 11:50:49 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, chengming.zhou@linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
Message-ID: <ZqCdQX3e6mPsA0ys@linux.ibm.com>
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723114247.104848-1-zhouchuyi@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qbfq35jHfd2rQejbvhtdp5-q7S8_2ADx
X-Proofpoint-ORIG-GUID: 4TQYu9fQU15cESzyCv7H95vDEar5iD8R
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_03,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=923 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240042

On Tue, Jul 23, 2024 at 07:42:47PM +0800, Chuyi Zhou wrote:
> In reweight_task(), there are two situations:
> 
> 1. The task was on_rq, then the task's load_avg is accurate because we
> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
> 
> 2. The task is sleeping, its load_avg might not have been updated for some
> time, which can result in inaccurate dequeue_load_avg() in
> reweight_entity().
> 
> This patch solves this by using sync_entity_load_avg() to synchronize the
> load_avg of se with cfs_rq before dequeue_load_avg() in reweight_entity().
> For tasks were on_rq, since we already update load_avg to accurate values
> in dequeue_task(), this change will not have other effects due to the short
> time interval between the two updates.
> 
> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
> Changes in v3:
> - use sync_entity_load_avg() rather than update_load_avg() to sync the
> sleeping task with its cfs_rq suggested by Dietmar.
> - Link t0 v2: https://lore.kernel.org/lkml/20240720051248.59608-1-zhouchuyi@bytedance.com/
> Changes in v2:
> - change the description in commit log.
> - use update_load_avg() in reweight_task() rather than in reweight_entity
> suggested by chengming.
> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
> ---
>  kernel/sched/fair.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..da3cdd86ab2e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3669,11 +3669,32 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
>  					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
>  }
> +
> +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> +{
> +	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> +				 cfs_rq->last_update_time_copy);
> +}
> +
> +/*
> + * Synchronize entity load avg of dequeued entity without locking
> + * the previous rq.
> + */
> +static void sync_entity_load_avg(struct sched_entity *se)
> +{
> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +	u64 last_update_time;
> +
> +	last_update_time = cfs_rq_last_update_time(cfs_rq);
> +	__update_load_avg_blocked_se(last_update_time, se);
> +}
> +
>  #else
>  static inline void
>  enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
>  static inline void
>  dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
> +static void sync_entity_load_avg(struct sched_entity *se) { }
>  #endif
>  
>  static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
> @@ -3795,7 +3816,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  		if (!curr)
>  			__dequeue_entity(cfs_rq, se);
>  		update_load_sub(&cfs_rq->load, se->load.weight);
> -	}
> +	} else if (entity_is_task(se))
> +		sync_entity_load_avg(se);
> +
>  	dequeue_load_avg(cfs_rq, se);
>  
>  	if (se->on_rq) {
> @@ -4034,11 +4057,6 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
>  	return true;
>  }
>  
> -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> -{
> -	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> -				 cfs_rq->last_update_time_copy);
> -}
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  /*
>   * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> @@ -4773,19 +4791,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	}
>  }
>  
> -/*
> - * Synchronize entity load avg of dequeued entity without locking
> - * the previous rq.
> - */
> -static void sync_entity_load_avg(struct sched_entity *se)
> -{
> -	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -	u64 last_update_time;
> -
> -	last_update_time = cfs_rq_last_update_time(cfs_rq);
> -	__update_load_avg_blocked_se(last_update_time, se);
> -}
> -
>  /*
>   * Task first catches up with cfs_rq, and then subtract
>   * itself from the cfs_rq (task must be off the queue now).
> -- 
> 2.20.1
> 

Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com> 

Thank you for the patch!

-- vishal.c

