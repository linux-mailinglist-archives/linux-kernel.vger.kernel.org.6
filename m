Return-Path: <linux-kernel+bounces-255107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8A3933C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB6B1F2263C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64917F392;
	Wed, 17 Jul 2024 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gizWjBO5"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BFBA4B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215137; cv=none; b=tufDGRygyLk4VrfqG5yoehQnGIU6KjYPrNsC1Bn+pCIFXb2tI3w8fZrmOkYUIcWMogPJxFJBxWS4EBVBcanMALndoN7jYOeORTb2RED7oziDiHQjpXBW5w/2qPdJhV3p5nTsfECQ0w38CRFPtMUap27sWUuFvW1jjld2iT0PNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215137; c=relaxed/simple;
	bh=4DuetrTpaXRDxLF3sjvvrmJ3a4/JR58xeSUvfDggezI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edlWEWgYp4nJNVzsbOVTyTa4iQPBowy4SrQJV9lq7fegniD5/uJF7fV3MHr6op5bmO5Y0HxL5YMxaZg17xN28bhQfZMKMQvw3EHQ63fAZiqY2gxLDCAhiAVRy6nOAJvQ+z89RUD5eyYm3jXmQ9sOSvXqqmmSHnHXmSrfjJrWG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gizWjBO5; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: zhouchuyi@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721215132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4L2F7fOWFnMqmnDXX6g9Jq59CDZh1EUOdj642nf1V8=;
	b=gizWjBO5pJG01K1PcNqz2JVAHZ01jULLiOp/0qJuN85HsyOJR2MZaRm1snvY9g+jJrJ7m2
	S81nGIeXBfBOMtmBmTnwOXN2zpD0uruuXrBNc0iEa/1VtB0G32fiH5WNAt9ZLizCUZ9XmQ
	1VGX897ipXpdGUL6wDHxbs3CEC/s0i8=
X-Envelope-To: mingo@redhat.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <3faf976d-52ee-4fc7-ad42-70fc0dc53de4@linux.dev>
Date: Wed, 17 Jul 2024 19:18:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_entity
To: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org
References: <20240716150840.23061-1-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240716150840.23061-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/16 23:08, Chuyi Zhou wrote:
> In reweight_entity(), if !se->on_rq (e.g. when we are reweighting a
> sleeping task), we should sync the load_avg of se to cfs_rq before calling
> dequeue_load_avg(). Otherwise, the load_avg of this se can be inaccurate.

Good catch!

> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   kernel/sched/fair.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..2807f6e72ad1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3782,6 +3782,8 @@ static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
>   	se->deadline = avruntime + vslice;
>   }
>   
> +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
> +
>   static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   			    unsigned long weight)
>   {
> @@ -3795,7 +3797,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   		if (!curr)
>   			__dequeue_entity(cfs_rq, se);
>   		update_load_sub(&cfs_rq->load, se->load.weight);
> +	} else {
> +		/* Sync with the cfs_rq before removing our load_avg */
> +		update_load_avg(cfs_rq, se, 0);

I think it's suboptimal to update_load_avg() here unconditionally.

Because reweight_entity() has two types of usages:

1. group se, which uses reweight_entity() in update_cfs_group(), which
should already update_load_avg(), so should have no problem.

2. task se, which uses reweight_entity() in reweight_task(), which 
should be fixed for sleep task entity as you described above.

So IMHO, we should only update_load_avg() or sync_entity_load_avg() in
reweight_task(), right?

>   	}
> +
>   	dequeue_load_avg(cfs_rq, se);
>   
>   	if (se->on_rq) {

