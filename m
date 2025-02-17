Return-Path: <linux-kernel+bounces-516934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5FDA379F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C0D3AF23D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F6D5477F;
	Mon, 17 Feb 2025 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ULfYf6xJ"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D56C2C9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760805; cv=none; b=dVNHbB4F4cTL3Ce5a60kAmuTmES8xp5VRDEm0ZvuWtxfgQkenaHriUS0JjpJttp5WSxuY+vC95xGmAU5jl0KVaXxdVcVH7P1e5WUQGsxkgnp6b/IR2W/erAZSCHDIg4IiUgxSiJrg092zjOP2o6Kw79lqSwSy9qL7zClsUO2294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760805; c=relaxed/simple;
	bh=NcMamrHzYRI1SvXXfVJYOez4rGJyDXXm16Y9PqO2bv0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bDl8cO7ufj4IqcQJA/TcW/6INQWkOAecijD3rTQToCxyAz0Y4+sfn89ib1WFxaaLjRLBIxENdJDmWP/V6luG33n7vgm0xXEtwXqYY7/HdaSfTFmYZWY1Sv2ZC93SLUpUKLTkZNZ79frPoyOLvXYE+qT3CGXZNYOZUyD5FRuGupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ULfYf6xJ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739760799; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=E81IRHnHZE5qlcpraf5GKQabggaPUwmbnygvRaF2KMw=;
	b=ULfYf6xJIikAo8X7z71wYDreFPx188xBf6QM5HH7IkuesuXDCqJMSjzamGwQaOaQf8EEZ4gQI1FpSXOuxEdJj8aK/lgFSkXj46cWJAPixQMP9UpuAqTYxHkwq62uuCehULwSa3+LNIW2BsgO/o83Gl7thVPPJLeZwVLvqCE5jAw=
Received: from 30.74.128.124(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WPYBtpA_1739760798 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 10:53:18 +0800
Message-ID: <958a085d-95bf-490f-9987-b269f80635b5@linux.alibaba.com>
Date: Mon, 17 Feb 2025 10:53:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [PATCH v3] sched/eevdf: Force propagating min_slice of cfs_rq
 when {en,de}queue tasks
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250211063659.7180-1-dtcccc@linux.alibaba.com>
 <610e209d-5c12-44d5-898c-f18dffbc2062@amd.com>
Content-Language: en-US
In-Reply-To: <610e209d-5c12-44d5-898c-f18dffbc2062@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi. Sorry for replying late due to weekend.

On 2/14/25 11:42 PM, K Prateek Nayak wrote:

[...]

> 
> Should we check if old slice matches with the new slice before
> propagation to avoid any unnecessary propagate call? Something like:
> 
>          if (se->slice != slice) {
>              se->slice = slice;
>              if (se != cfs_rq->curr)
>                  min_vruntime_cb_propagate(&se->run_node, NULL);
>          }
> 
> Thoughts?
> 

This optimization makes sense to me. But the code would be a bit ugly :-/

Maybe we should wrap it in a helper. Something like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1e78caa21436..ccceb67004a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -844,6 +844,16 @@ static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
  RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
  		     run_node, min_vruntime, min_vruntime_update);
  
+static inline void propagate_slice(struct cfs_rq *cfs_rq, struct sched_entity *se, u64 slice)
+{
+	if (se->slice == slice)
+		return;
+
+	se->slice = slice;
+	if (se != cfs_rq->curr)
+		min_vruntime_cb_propagate(&se->run_node, NULL);
+}
+
  /*
   * Enqueue an entity into the rb-tree:
   */
@@ -6969,7 +6979,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
  		se_update_runnable(se);
  		update_cfs_group(se);
  
-		se->slice = slice;
+		propagate_slice(cfs_rq, se, slice);
  		slice = cfs_rq_min_slice(cfs_rq);
  
  		cfs_rq->h_nr_runnable += h_nr_runnable;
@@ -7098,7 +7108,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  		se_update_runnable(se);
  		update_cfs_group(se);
  
-		se->slice = slice;
+		propagate_slice(cfs_rq, se, slice);
  		slice = cfs_rq_min_slice(cfs_rq);
  
  		cfs_rq->h_nr_runnable -= h_nr_runnable;
-- 

Since the patch has been accepted, I'm not sure whether I should send a
next version. The current version does introduce an extra function call
when se->slice == slice, but the loop will run only once and exit because
RBCOMPUTE() will return true. So maybe the cost is insignificant?

