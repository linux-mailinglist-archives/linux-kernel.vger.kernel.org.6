Return-Path: <linux-kernel+bounces-258503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E69388F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887DC1C20D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016517C6B;
	Mon, 22 Jul 2024 06:34:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCE123DE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721630056; cv=none; b=BSR8Kwz/B9Hk3ZI0beN6N2NS55wfJgpRcuVbKEfPApU7lt80/IOEqgKxu7Xi4GgC9DoSE1/kWersKkl4bSB2RwLdy1UghfsfDTduhGyMOc2cNNSjLox9MIbn/L2K/HNSJWO7qCDPOZloSlibasF2wwSD9Xn0pvMWmrSbho8LL9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721630056; c=relaxed/simple;
	bh=XM5iXPI2APS3U9VxpvSZA5GkqsXzpGEFEY0hwXbS+Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsMq93MJgzuniwBGwco5oxHJakoayOZHuU0qx/j7JRXR8HyTu3obsIalqszLUmtLfTrHSVroiMzfdgtIbphsJySbGAlfz8vif8iIFB2GEfysO/SG4kdjpg6+uUYsYn1RpQ8EWiCgM2IKH1cMsKgXpI6z8m9wgr+EqD41PtPBfqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03454FEC;
	Sun, 21 Jul 2024 23:34:38 -0700 (PDT)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC8413F73F;
	Sun, 21 Jul 2024 23:34:10 -0700 (PDT)
Message-ID: <0575c014-6fe7-4118-bae8-cbb5b303a390@arm.com>
Date: Mon, 22 Jul 2024 08:34:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org
References: <20240720051248.59608-1-zhouchuyi@bytedance.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240720051248.59608-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2024 07:12, Chuyi Zhou wrote:
> In reweight_task(), there are two situations:
> 
> 1. The task was on_rq, then the task's load_avg is accurate because we
> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
> 
> 2. The task is sleeping, its load_avg might not have been updated for some
> time, which can result in inaccurate dequeue_load_avg() in
> reweight_entity().
> 
> This patch solves this by using update_load_avg() to synchronize the
> load_avg of se with cfs_rq. For tasks were on_rq, since we already update
> load_avg to accurate values in dequeue_task(), this change will not have
> other effects due to the short time interval between the two updates.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
> Changes in v2:
> - change the description in commit log.
> - use update_load_avg() in reweight_task() rather than in reweight_entity
> suggested by chengming.
> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..b1e07ce90284 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3835,12 +3835,15 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  	}
>  }
>  
> +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
> +
>  void reweight_task(struct task_struct *p, const struct load_weight *lw)
>  {
>  	struct sched_entity *se = &p->se;
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  	struct load_weight *load = &se->load;
>  
> +	update_load_avg(cfs_rq, se, 0);

IIUC, you only want to sync the sleeping task with its cfs_rq. IMHO, 
sync_entity_load_avg() should be used here instead of update_load_avg(). 
The latter is doing much more than this.

>  	reweight_entity(cfs_rq, se, lw->weight);
>  	load->inv_weight = lw->inv_weight;
>  }

Maybe even do this in reweight_entity()?. You would have to do it under 
'if (!se->on_rq) in reweight_task() anyway I assume.

-->8--

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..555392be4e82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3669,11 +3669,31 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
        cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
                                          cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
 }
+
+static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
+{
+       return u64_u32_load_copy(cfs_rq->avg.last_update_time,
+                                cfs_rq->last_update_time_copy);
+}
+
+/*
+ * Synchronize entity load avg of dequeued entity without locking
+ * the previous rq.
+ */
+static void sync_entity_load_avg(struct sched_entity *se)
+{
+       struct cfs_rq *cfs_rq = cfs_rq_of(se);
+       u64 last_update_time;
+
+       last_update_time = cfs_rq_last_update_time(cfs_rq);
+       __update_load_avg_blocked_se(last_update_time, se);
+}
 #else
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
+static void sync_entity_load_avg(struct sched_entity *se) { }
 #endif
 
 static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
@@ -3795,7 +3815,10 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
                if (!curr)
                        __dequeue_entity(cfs_rq, se);
                update_load_sub(&cfs_rq->load, se->load.weight);
+       } else if (entity_is_task(se)) {
+               sync_entity_load_avg(se);
        }
+
        dequeue_load_avg(cfs_rq, se);
 
        if (se->on_rq) {
@@ -4033,12 +4056,6 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
 
        return true;
 }
-
-static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
-{
-       return u64_u32_load_copy(cfs_rq->avg.last_update_time,
-                                cfs_rq->last_update_time_copy);
-}
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /*
  * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
@@ -4773,19 +4790,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
        }
 }
 
-/*
- * Synchronize entity load avg of dequeued entity without locking
- * the previous rq.
- */
-static void sync_entity_load_avg(struct sched_entity *se)
-{
-       struct cfs_rq *cfs_rq = cfs_rq_of(se);
-       u64 last_update_time;
-
-       last_update_time = cfs_rq_last_update_time(cfs_rq);
-       __update_load_avg_blocked_se(last_update_time, se);
-}
-
 /*
  * Task first catches up with cfs_rq, and then subtract
  * itself from the cfs_rq (task must be off the queue now).


