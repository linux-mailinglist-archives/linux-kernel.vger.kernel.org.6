Return-Path: <linux-kernel+bounces-260590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0793AB40
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DA328486F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736117758;
	Wed, 24 Jul 2024 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qEcsWmUp"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353F2595
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788323; cv=none; b=YtvBtWbbqJJ2ijCeYaseqbWYmPeDr+FQHENPN8g1n3W6Q+ECEURrWzUKKm6F5D7ssz6hcOi6bkOcaMIJzFC+51B256RrLJx+avcSMH8kGLvqPk84eaIZ0pCbfxjHPjAEcZ1tPUfi6eJyA8Bci+LrIzzyAA3JXTDPANDCiSASlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788323; c=relaxed/simple;
	bh=eqzFQzNwtL8VQl5W7g18vWD4vD5+Jyqh7vavMwyPR38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d70jxX9Ag6YPNwNNDB+v/e7aSvJO+7/4d7clZ8tFZ1vCDAA+vOaKNQ765hzRWUYR+IBRixbiC1UEdHBKeqcOsQCabqt2QnCkL5MRgg0RMqkVxYocXp6HcI9vhn52pJfOm/2DnGnga95D7H/JK1e4SY9VKhIFPC780G5zZOEsjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qEcsWmUp; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc61be3b-816a-44d9-aa56-d5338ccd3342@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721788319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LS1EuViH1t5zqh/ApOnEVUHQb/0kTtyVG0skusGupcE=;
	b=qEcsWmUpovt2xYRjUFGY0I6hJIU8PoBZh5tSEpUdQNgUUFXxVHkRTZmn2TikQBHxSN0n2P
	vJLykLBsQiZkGzFlMCWwqz7WmqT/M/pIVdWf4ou4l217YYNHTlBA2V21amhqHbY9uGJPZh
	G2Wfmhusvhq8TXU1vCykOtq8WzExpS4=
Date: Wed, 24 Jul 2024 10:31:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] sched/core: Avoid unnecessary update in
 tg_set_cfs_bandwidth
To: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, joshdon@google.com
References: <20240723122006.47053-1-zhouchuyi@bytedance.com>
 <20240723122006.47053-3-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240723122006.47053-3-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/23 20:20, Chuyi Zhou wrote:
> In the kubernetes production environment, we have observed a high
> frequency of writes to cpu.max, approximately every 2~4 seconds for each
> cgroup, with the same value being written each time. This can result in
> unnecessary overhead, especially on machines with a large number of CPUs
> and cgroups.
> 
> This is because kubelet and runc attempt to persist resource
> configurations through frequent updates with same value in this manner.
> While optimizations can be made to kubelet and runc to avoid such
> overhead(e.g. check the current value of cpu request/limit before writing
> to cpu.max), it is still worth to bail out from tg_set_cfs_bandwidth() if
> we attempt to update with the same value.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   kernel/sched/core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7720d34bd71b..0cc564f45511 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9090,6 +9090,9 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>   	guard(cpus_read_lock)();
>   	guard(mutex)(&cfs_constraints_mutex);
>   
> +	if (cfs_b->period == ns_to_ktime(period) && cfs_b->quota == quota && cfs_b->burst == burst)
> +		return 0;
> +

Should break this to multiple lines? Feel free to add:

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

>   	ret = __cfs_schedulable(tg, period, quota);
>   	if (ret)
>   		return ret;

