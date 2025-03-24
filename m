Return-Path: <linux-kernel+bounces-573971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38557A6DF1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C837188CA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E4261569;
	Mon, 24 Mar 2025 15:55:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4525EFA3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831757; cv=none; b=hWA0W7XnK6FjZOYGEpC5UxnIyQ2ORA2a/er/FdMBV7u+mZBhRlNl4FmsqFHp1XCHjCdYJ+r5jFPAZdRmUX9kLZ06qRx9jgyVnJPQkJELUtuCcksa4FoTCAYcKQMvqLcQChlo6nkdz3zght8xIv2Tvcqv+0pq/8jorH1I+KLM204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831757; c=relaxed/simple;
	bh=E7MXANfcSJrvYujKHPC17ZdDs45EXn/081PhwnmONyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9xamodCZjMMvnD9lN017CionDxROeQ3D/5qYfV7wlLK2TtUyt8IIBmWrHqQkNVtetnwwbR0Lw9msooTm4+j97FPP613IP1J5gdLCeCAmtUpG2pWxo9ER7IB63+NKg8Fvh+JTg6/Vj2KavAbto/7Tt56js3EPI7SzPsq1uAZp/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC70AC4CEDD;
	Mon, 24 Mar 2025 15:55:55 +0000 (UTC)
Date: Mon, 24 Mar 2025 11:56:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pat Cody <patcody@meta.com>
Cc: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
 <linux-kernel@vger.kernel.org>, <riel@surriel.com>, <kernel-team@meta.com>,
 <stable@kernel.org>
Subject: Re: [PATCH] sched/fair: Add null pointer check to
 pick_next_entity()
Message-ID: <20250324115637.26379f8c@gandalf.local.home>
In-Reply-To: <20250320173438.3562449-2-patcody@meta.com>
References: <20250320173438.3562449-2-patcody@meta.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 10:34:39 -0700
Pat Cody <patcody@meta.com> wrote:

> pick_eevdf() can return null, resulting in a null pointer dereference
> crash in pick_next_entity()
> 
> The other call site of pick_eevdf() can already handle a null pointer,
> and pick_next_entity() can already return null as well. Add an extra
> check to handle the null return here.

Have you actually triggered this?

> 
> Cc: stable@kernel.org
> Fixes: f12e148892ed ("sched/fair: Prepare pick_next_task() for delayed dequeue")


No signed-off-by.

> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a553181dc764..f2157298cbce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5560,6 +5560,8 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>  	}
>  
>  	struct sched_entity *se = pick_eevdf(cfs_rq);
> +	if (!se)
> +		return NULL;

So the place that this is called is in pick_task_fair() which has:

	cfs_rq = &rq->cfs;
	if (!cfs_rq->nr_queued)
		return NULL;

Where I believe it's a bug if cfs_rq->nr_queued > 0 and pick_eevdf() returns NULL.

Which means in should never happen. Now, to be more robust, we could add a
check for NULL, but this is not a fix, nor should it go to stable.

-- Steve



>  	if (se->sched_delayed) {
>  		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>  		/*


