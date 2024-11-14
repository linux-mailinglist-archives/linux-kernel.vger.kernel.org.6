Return-Path: <linux-kernel+bounces-409808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7319C91FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689461F23A08
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0FD199EA2;
	Thu, 14 Nov 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbsNoa9A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3117588
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610694; cv=none; b=jgvipZh6i89D3nmyqSYDPcwbQ6Yz3SLPhMbOMgLNn1d0UDj5C+4tKk5PNhLAY3XXKhJNBIE4NxZbIKKXC1eDRKgRY4yAnexnv1ekZxngd9CFJIWGBI4ZpOnKBeku3Hqlu1pg3BT6EtCI30vNEC6nGgXlXXkSAId3i5kVGpxCuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610694; c=relaxed/simple;
	bh=WJMLwNkWyRRVbtIP80SdSYSpcbqhAbAEjSqW9Na9zIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbViKD0S40SHv52DstvN2dmUavdKE+GVXnaToMCGw4H+CuK9TYS1+P7FwBpOufiUerTIr4V+6FJMiEjQmvB/CIllXiRnpi2UjhcBJWbiXFpPdgKsJdFKDS6Vm/vOwoTC9++rmhQggl3993QhgAQBPb3+1EfLzmIIabtL+prS5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbsNoa9A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731610691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+kj8xBLWBw0UbQvri4iIdPFvMnVZnKp7peN+Llfm5c=;
	b=YbsNoa9Aja9uw94eeJVyGraTHrTCW9J1ouimPDim+Ap4pIws1noWJ9MDj0ZbetupPtOc/t
	79qcVkYoHsSPwyv+vldlHcILFRegTYNteHzddAfDD2QKjFq5BZU0o7LJ12vjKTiIW6d4R2
	hekylArlbf6BYDgFMc88G2zCfjKuAU0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-yRCtM6ANOz6aPkN5AEOm6Q-1; Thu,
 14 Nov 2024 13:58:02 -0500
X-MC-Unique: yRCtM6ANOz6aPkN5AEOm6Q-1
X-Mimecast-MFC-AGG-ID: yRCtM6ANOz6aPkN5AEOm6Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C61A1956096;
	Thu, 14 Nov 2024 18:58:01 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.110])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CDD81956089;
	Thu, 14 Nov 2024 18:57:58 +0000 (UTC)
Date: Thu, 14 Nov 2024 13:57:55 -0500
From: Phil Auld <pauld@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: hoist ASSERT_EXCLUSIVE_WRITER(p->on_rq) above
 WRITE_ONCE
Message-ID: <20241114185755.GG471026@pauld.westford.csb>
References: <20241114165352.1824956-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114165352.1824956-1-jon@nutanix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Nov 14, 2024 at 09:53:52AM -0700 Jon Kohler wrote:
> In {activate|deactivate}_task(), hoist ASSERT_EXCLUSIVE_WRITER() to be
> above WRITE_ONCE(p->on_rq), which matches the ordering listed in the
> KCSAN documentation, kcsan-checks.h code comments, and the usage
> pattern we already have in __block_task().
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a1c353a62c56..80a04c36b495 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2066,16 +2066,16 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  	enqueue_task(rq, p, flags);
>  
> -	WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
>  	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> +	WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
>  }
>  
>  void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
>  
> -	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
>  	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> +	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
>  
>  	/*
>  	 * Code explicitly relies on TASK_ON_RQ_MIGRATING begin set *before*
> -- 
> 2.43.0
> 
> 

This looks fine to me and it makes sense to have the assert before the
write.  A quick grep showed that this is by no means a universal pattern
at the moment.


Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil

-- 


