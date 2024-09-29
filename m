Return-Path: <linux-kernel+bounces-342749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913A989291
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83C51F23107
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC61EDF71;
	Sun, 29 Sep 2024 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MO9iFAaf"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A47B644
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727575394; cv=none; b=XrteLcwVXllyGOe/1WgC7aoqpRG2M7B9PC6Pimk2vJrqKpS8dvP4buCG4WEP54zNqACOR1fyaMLXrUREuIHqIddNIEejXSezHlzfi3IB13hMt0WzADDTIBeASN5cGpaJobafYpB7lPbnwDdFBnQ9UJP/bZIckmp8MxLp2tmezk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727575394; c=relaxed/simple;
	bh=43dVdEqKcLi7d+hFVf/n2zNWG/+EKs2HzhXo+7+olNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM/qxaMhnyTx3WW3CjAZI5Qs4RnKh383hXlnfi29vFsU0ECEq0LE1h5R8fWZu7dzLkSTgdSfBZ0DHzQewD1FcOroFdHOt1l5er1GTIgvdxA+NREdrWvFW3H4tOLgIzcTiw9GXRhVE1UEQ1Pq6ziT3nkHbwbvOfEink5pUZPN2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MO9iFAaf; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727575382; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hQkIuXrmKGw5rMzWRLka9JOfCoWx1jJW1G17ZbsasqA=;
	b=MO9iFAaf9LDCMCd04GhgxwTch3xY9yU+1JYW/q8e5clP0Ys6PjQC/jbHLGkOAaD4sbCnM6yTJbT4+5Nz2wE7KesWgR/G47r1/l6cmSAD8cz4JA60TlmQGB9HTS++MJe943F4rWxDAlyT2ai2qGPuF1y6awp32NmZX2hIi005E5A=
Received: from 30.74.129.150(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WFuY9r4_1727575379)
          by smtp.aliyun-inc.com;
          Sun, 29 Sep 2024 10:03:00 +0800
Message-ID: <86818555-c61e-476c-8317-e8f523bb2054@linux.alibaba.com>
Date: Sun, 29 Sep 2024 10:02:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] sched/eevdf: Propagate min_slice up the cgroup
 hierarchy
To: Peter Zijlstra <peterz@infradead.org>
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20240727102732.960974693@infradead.org>
 <20240727105030.948188417@infradead.org>
Content-Language: en-US
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20240727105030.948188417@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

On 2024/7/27 18:27, Peter Zijlstra wrote:
> In the absence of an explicit cgroup slice configureation, make mixed
> slice length work with cgroups by propagating the min_slice up the
> hierarchy.

Will it be acceptable to introduce a cgroup interface (e.g., sth. like 
cpu.fair_runtime or cpu.fair_slice) to overwrite the caculated min_slice?
This could be useful in container scenarios.

> 
> This ensures the cgroup entity gets timely service to service its
> entities that have this timing constraint set on them.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/sched.h |    1
>   kernel/sched/fair.c   |   57 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 57 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -542,6 +542,7 @@ struct sched_entity {
>   	struct rb_node			run_node;
>   	u64				deadline;
>   	u64				min_vruntime;
> +	u64				min_slice;
>   
>   	struct list_head		group_node;
>   	unsigned char			on_rq;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -782,6 +782,21 @@ static void update_min_vruntime(struct c
>   	cfs_rq->min_vruntime = __update_min_vruntime(cfs_rq, vruntime);
>   }
>   
> +static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
> +{
> +	struct sched_entity *root = __pick_root_entity(cfs_rq);
> +	struct sched_entity *curr = cfs_rq->curr;
> +	u64 min_slice = ~0ULL;
> +
> +	if (curr && curr->on_rq)
> +		min_slice = curr->slice;
> +
> +	if (root)
> +		min_slice = min(min_slice, root->min_slice);

If a sched_delayed se keeps the min_slice, then the parent se will receive a 
shorter slice (from the sched_delayed se) than it should be. Is it a problem?

Thanks.

