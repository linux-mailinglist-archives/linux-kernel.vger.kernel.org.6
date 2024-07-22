Return-Path: <linux-kernel+bounces-258574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ABF9389F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AA21C20F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34661B969;
	Mon, 22 Jul 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eYy4Owo4"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128C317BD5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632911; cv=none; b=CQS0OQHF3OC6ElW12ztQ+7so6bOLC4TjcT7vh3WoChg2mmDrV8zsFZlgt2MaCMnt0jVj2CiN8BgE9+ugmF9TGT1aF4YGBKz7B9R9uINUsW/gt9+kp2l2uuiTJvYSsuDFfyM3OxJoIwY4EVvpqwuH/VC2nk/lxZCb5hvhzfGi/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632911; c=relaxed/simple;
	bh=NeoYLjbISoVB5rvhGmXiAVODaKDSfSSTsqsOblb+2EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3WeTOPNCEjoNOZvZck2g7ATM8ENNqkiDL0LKBWaaLQ0P8CA+oYpRQkuNOVi5rLiMH0KMgHIqlbdk3yGkLBUl4s+NJoJRu2vZ2vhuJwMWZRHXZAVMbCfB0qfd/jqHMAGi94vy1d2s3C0VqzoqKFjdKGmoDxVDmiSjkjoTgHuj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eYy4Owo4; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: zhouchuyi@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721632907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjhkBh80GqT5Qb/LiGqlf+8/MbWYImdrAQ4flsDlkDw=;
	b=eYy4Owo4gW7yxtUVRTQ0CKPZ2qy1eS3py4Ma1dngNTgVOzCLfqoRki3hJ+dM1pq2jgxeV2
	wlDGzL37K4eBGE2Eby40k87Z51ZES7U+On2p5A8zP9HU2/Sm9IYw0MYbYQs+O7QpWfK+8q
	pGYv4VRRUlUHrWXZiN+v1mluM6O7JLA=
X-Envelope-To: mingo@redhat.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: joshdon@google.com
Message-ID: <c60c07b3-7c97-4c9d-8496-72f3fc65307c@linux.dev>
Date: Mon, 22 Jul 2024 15:21:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] sched/core: Avoid unnecessary update in
 tg_set_cfs_bandwidth
To: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, joshdon@google.com
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
 <20240721125208.5348-3-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240721125208.5348-3-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/21 20:52, Chuyi Zhou wrote:
> In the kubernetes production environment, we have observed a high
> frequency of writes to cpu.max, approximately every 2~4 seconds for each
> cgroup, with the same value being written each time. This can result in
> unnecessary overhead, especially on machines with a large number of CPUs
> and cgroups.
> 
> This is because kubelet and runc attempt to persist resource
> configurations through frequent updates with same value in this manner.

Ok.

> While optimizations can be made to kubelet and runc to avoid such
> overhead(e.g. check the current value of cpu request/limit before writing
> to cpu.max), it is still worth to bail out from tg_set_cfs_bandwidth() if
> we attempt to update with the same value.

Yeah, we can optimize this situation with a little of checking code,
seems worthwhile to do IMHO.

> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   kernel/sched/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6d35c48239be..4db3ef2a703b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9081,6 +9081,8 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>   				     burst + quota > max_cfs_runtime))
>   		return -EINVAL;
>   
> +	if (cfs_b->period == ns_to_ktime(period) && cfs_b->quota == quota && cfs_b->burst == burst)
> +		return 0;

Maybe we'd better do these checkings under the lock protection, right?

Thanks.

>   	/*
>   	 * Prevent race between setting of cfs_rq->runtime_enabled and
>   	 * unthrottle_offline_cfs_rqs().

