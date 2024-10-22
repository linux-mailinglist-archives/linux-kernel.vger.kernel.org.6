Return-Path: <linux-kernel+bounces-375836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FEE9A9B83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DDE1F23272
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B61547EB;
	Tue, 22 Oct 2024 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+Bb7PCM"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC85149E0E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583604; cv=none; b=K5dL9nklc43aZrq3ZuR67a6Vfk86a5hqX/UKkMlXFCOFHgcjKi4CWIopYnTtH2rDSoDrVUBCbBAIK6j3xEIQ7Mx8WMyNg52xPg+Z+InLYejndNYkAxoXYaQvaKStm6q7wJTa/PtZhfqNFHWlQ60zDv3PK4daJ9h0PIFhq02klRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583604; c=relaxed/simple;
	bh=b3+Ta7DD0eDNlwJu60EkVR7bTzyKdDHBtwJYPzi9MUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIZBtM9FO742dcboGXI5a4g7o2198XatxM0LBMgzIGVjuwGXYnvao9vSDTqkwhJX5hOBJn2zjsBs3Qdos63woKc9sw1+xEDPJHZV3wztjSJPyZwgRR7A/jZ+DnagNG3qwf8ap3nMUZaqDePYwE1l6BbN1qEo/tPqRd76iFfL+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+Bb7PCM; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c297cba9-5136-46b6-b2a4-5169a1a3f7cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729583599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oru9pAsWlxpg7ADEAtVT9HuvoSEsxSMCem7x1TYoqg=;
	b=Z+Bb7PCM/WOcrmoBK1iLWF35pjuVTWEmJgdbN2JgswD7IOO7BwFr1ODyUMEHtS2UWC3Uhw
	afSinZQEN6oHRtO5T8a/i/qM7ePEQ6EvK4GFa0KVyo7mfiFeXSZ8JbD+ArtPDZ2hzABqsF
	pw77F4SVXGeJAF7+lY/3UGrsMS2FZBw=
Date: Tue, 22 Oct 2024 15:53:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
To: Muchun Song <songmuchun@bytedance.com>, axboe@kernel.dk
Cc: josef@toxicpanda.com, oleg@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, muchun.song@linux.dev
References: <20241021085251.73353-1-songmuchun@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20241021085251.73353-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/10/21 16:52, Muchun Song wrote:
> The memory barriers in list_del_init_careful() and list_empty_careful()
> in pairs already handle the proper ordering between data.got_token
> and data.wq.entry. So remove the redundant explicit barriers. And also
> change a "break" statement to "return" to avoid redundant calling of
> finish_wait().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Good catch! Just a small nit below, feel free to add:

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   block/blk-rq-qos.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index dc510f493ba57..9b0aa7dd6779f 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -218,7 +218,6 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
>   		return -1;
>   
>   	data->got_token = true;
> -	smp_wmb();
>   	wake_up_process(data->task);
>   	list_del_init_careful(&curr->entry);
>   	return 1;
> @@ -274,10 +273,9 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>   			 * which means we now have two. Put our local token
>   			 * and wake anyone else potentially waiting for one.
>   			 */
> -			smp_rmb();
>   			if (data.got_token)
>   				cleanup_cb(rqw, private_data);
> -			break;
> +			return;
>   		}

Would it be better to move this acquire_inflight_cb() above out of
the do-while(1) since we rely on the waker to get inflight counter
for us?

Thanks.

>   		io_schedule();
>   		has_sleeper = true;

