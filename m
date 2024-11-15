Return-Path: <linux-kernel+bounces-410455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941E29CDBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A51F21945
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421C0192B76;
	Fri, 15 Nov 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HkJBasIZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58C1925A4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664264; cv=none; b=O+lbF04clIXESe2hcXJJyHvtwsJU5BMyNF1O2iwMaLY9y7X+d/lSpHQHZB8UtG05Xb4cSZ0QNUiFW5x76+i6sSfmHXN8aYJ0jqUm4PFJV1qCGnaMJdMZ55cgOUmUWeIwI6xeECabLr9XyKST4o6XuslgEb2SZShvF6Ca+G4FVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664264; c=relaxed/simple;
	bh=ZMYhMf6GB0MYri+yHGRBYeMvGiAqHqVaFNS625tcmYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvtAz6kuTvnQjBWkefF1zotR47MElw2Yk9UVtbwXQNounsbW3gb6JtZJ9ZQ1LeyKDZL0wQ+RsLd9lLpmKOaG1uChv+mzswfEAM46JJvNlQaoG+3HHXfvu9kjoXYhpfGE7ANRTSIl3j4chwTv1ASvi8yIhO/sG2o9QQX6DB6jbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HkJBasIZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=No0itrRwWrq3DwWbF9VH16QTfBK+9VXQ1u42vHkdc14=; b=HkJBasIZqHbxslYQpQuXnuea6v
	N2K2VXCHAne6rzLObW3InXUx1w50ho6SKBzK6iQ72W8xmZI2vQrIoVaKmjTZ0J4vsrNOBxehP0Pp1
	w/uj36uxk7DiLzkODP9TYEHmyqmBLFozBhtVB+wksY8LsyH5BijNE1d1iVqzTidxAIwIszUwZQ56v
	ZgBWn5ezyWAng33LEeCjioNEG3v58k8Us9AzXD7n6XvE23ENPb2qt4tiq30XYsCmML3EPbJ73DhZy
	wdNogQFgscwnHY6V23rgoIgOSPwzZGFMsmO+/JDlkQJ4DrtACZwS0ni2GU4KZrLkkZx28bgqfRW7x
	EONgMbuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBsyc-00000001CXO-3ZLj;
	Fri, 15 Nov 2024 09:50:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C882030066A; Fri, 15 Nov 2024 10:50:52 +0100 (CET)
Date: Fri, 15 Nov 2024 10:50:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Harshit Agarwal <harshit@nutanix.com>,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched: add READ_ONCE to task_on_rq_queued
Message-ID: <20241115095052.GU22801@noisy.programming.kicks-ass.net>
References: <20241114210812.1836587-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114210812.1836587-1-jon@nutanix.com>

On Thu, Nov 14, 2024 at 02:08:11PM -0700, Jon Kohler wrote:
> From: Harshit Agarwal <harshit@nutanix.com>
> 
> task_on_rq_queued read p->on_rq without READ_ONCE, though p->on_rq is
> set with WRITE_ONCE in {activate|deactivate}_task and smp_store_release
> in __block_task, and also read with READ_ONCE in task_on_rq_migrating.
> 
> Make all of these accesses pair together by adding READ_ONCE in the
> task_on_rq_queued.
> 
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Cc: Jon Kohler <jon@nutanix.com>
> ---
>  kernel/sched/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c03b3d7b320e..dbbe5ce0dd96 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2277,7 +2277,7 @@ static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
>  
>  static inline int task_on_rq_queued(struct task_struct *p)
>  {
> -	return p->on_rq == TASK_ON_RQ_QUEUED;
> +	return READ_ONCE(p->on_rq) == TASK_ON_RQ_QUEUED;
>  }

I think that strictly speaking we don't need it here, *IF* we see the
ON_RQ_QUEUED value, it must be stable.

But yeah, this is probably easier to reason about.

If you've got time, it might be worth to try something like:

	if (READ_ONCE(p->on_rq) == TASK_ON_RQ_QUEUED) {
		/*
		 * If we observe ON_RQ_QUEUED, it should be stable. IOW
		 * there should be no concurrent writes at this point.
		 */
		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
		return true;
	}
	return false;

