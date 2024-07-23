Return-Path: <linux-kernel+bounces-260165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46FD93A403
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B669284828
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB0156F5D;
	Tue, 23 Jul 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j5Ndcmvs"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08514C5A1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749909; cv=none; b=bAQHupSqWE95dOluOXcm+3g+gGviGOZByAF/9t2z6UPrgsdL67jot7DlRzDSF4jCWN5TaMHlaNX+5nbFCCaDOkT4Cvn0DS5P8i768AlyJws/HzPvJgp0TzUXr9b4/JN5OmgWxJRW/C6AM5vSPxOO9wGcJDT4raFfyqHWXETIFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749909; c=relaxed/simple;
	bh=ZJauzbbYI0ZgankBv+xXA4TXeDSQbk/fd/05pbkZ4qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DoYDJUU+cP++qdj+a/Tzcn6K+hPOdses1hNXHvXFBZqVHNacz69RH0+Kmo8tM/qgv42MWWMW0TjQqLOsla8dnfE3pXg8lSPcr3z3QCCtpcPuZQ5YrlNLe74MnjVmMGvmLGW6VBcB2VojZraAWb+yhcpXO4thSalCb6K7+a3IzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j5Ndcmvs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NFLkoi020870;
	Tue, 23 Jul 2024 15:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=6hQNYlN1OdKVGrgli1OXr2m5Xg6
	PFlfA+ohJkCnX8vI=; b=j5NdcmvsP4MaswltxrSRyXFgORU1H37rBI/v0YX2UWm
	jp+7cNmu4pnytj2iylqNOIPv12d1VU28xRjtoSV0exhexpcn9/nkjJbWvamSDaB5
	hGH5LqYGbumTUMhDjHg5rtY59kaS3ecNkk9jwzx4+m9qgvhiqs+p9qXWx/gsBlxh
	ndvMDuy8jPwmpo+mSgvZxdOt2Oqvz6AtI9J4IddFCjbIdOqnX7C77+Q6oyaA6cBi
	8n4O/vExCm4LOOujWaSB6XtEeHTGvM4gM3si6tGJT459J7t0CADIxBPI7jijN2/b
	+0TEjRDRuUdXSgkz/69j6rKGABu5OueZxQgC0C8eyHg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hva3jbme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 15:49:05 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46NFn42f002248;
	Tue, 23 Jul 2024 15:49:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hva3jbmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 15:49:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDTNgW009131;
	Tue, 23 Jul 2024 15:49:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93byrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 15:49:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NFn0BZ44892490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 15:49:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DD8C2004F;
	Tue, 23 Jul 2024 15:49:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF8620040;
	Tue, 23 Jul 2024 15:48:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.111.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jul 2024 15:48:57 +0000 (GMT)
Date: Tue, 23 Jul 2024 21:18:54 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, chengming.zhou@linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
Message-ID: <Zp_QzS-DUiE934X2@linux.ibm.com>
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723114247.104848-1-zhouchuyi@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5JA6xjJMSXprg2eRdPuxPHjgpL-zpUEn
X-Proofpoint-ORIG-GUID: k5A0RxgDecCdlVusAF-BpXJMILEPP_US
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_05,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 mlxlogscore=835 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230107

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
The difference between using update_load_avg() and
sync_entity_load_avg() is:
1. update_load_avg() uses the updated PELT clock value from the rq
   structure.  
2. sync_entity_load_avg() uses the last updated time of
   the cfs_rq where the scheduling entity (se) is attached.

Won't this affect the entity load sync?

-- vishal.c

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

