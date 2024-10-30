Return-Path: <linux-kernel+bounces-389073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815659B6836
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410282846EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB9921314E;
	Wed, 30 Oct 2024 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qlI4vpXx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBC81F4FA0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303161; cv=none; b=qaq5wKh9Tx6YQEL/TVx24CbstJColNV9Y4FMVlPnQ3naJUDgOGFrpSn/rqgVyLoY6+FgsfTBy2yZjB75YqAhY+rfIrBg3vmJqNIJ8b166dKdAnhI1WeZCMyGiqwYKICnoI316hkTU8+dlbrE5Ee92VSgustaDB/4fmNzqJefIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303161; c=relaxed/simple;
	bh=hg49ccyczYj1R4XAL8YY6i+yBovitm8Ka/88H1GhreQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMsLVGbDL+y8fluf97No8VDx8uwBmPgWNnudplD6BISR6KFT3TqjRaQcEKvf0kUUAYNmvmU9jHOxse+fLRUetumqkAumr77he4OLeXiLSHM8+yS1qPwLIDo1RNNFP4QKZjo4vPGU5GvWOxnapPmI7PebDkeCWea5+xLx2EJ6EoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qlI4vpXx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i9mcnUBLK65TH9YMFBo3oAWo+1k269z5JgWkXsBa2Fc=; b=qlI4vpXxVZfXHSkM93WJsVdIuW
	jDWOX/CGkVsEa+g63knbLDHF0PXaF6gbHtz5NCP4LOdJKSNdlx3c9ug6nQUzey0JMSnvepLFiSsHo
	nxAeHyl5N/fVs6sJQB7/r2CYEPCkzXn1HWCzTKfpAitQULC2U9iXIa23ROzdCPze3S2/7HvJIJ9Ao
	oE76TNPf/Eh1/fX6ZnSncOSbqqQTgvMMo2UzZXmq0+A0DGK+YR+OzSmH6kX/2MM9Op9vVFwmVntQt
	CAf2VoUGY4htLUve01MGrq/sA820mZ2eblpEuHdjhJLahuBn6eHWi/brtxJYfSICUlf/0dXokQBPH
	6gxSI0zg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AtM-0000000AIFE-0eyO;
	Wed, 30 Oct 2024 15:45:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C6391300ABE; Wed, 30 Oct 2024 16:45:51 +0100 (CET)
Date: Wed, 30 Oct 2024 16:45:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] sched: Cleanup sched_delayed handling for class
 switches
Message-ID: <20241030154551.GN14555@noisy.programming.kicks-ass.net>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.928034708@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030152142.928034708@infradead.org>

On Wed, Oct 30, 2024 at 04:13:01PM +0100, Peter Zijlstra wrote:

> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

> @@ -5202,7 +5200,7 @@ static int scx_ops_enable(struct sched_e
>  	percpu_down_write(&scx_fork_rwsem);
>  	scx_task_iter_start(&sti);
>  	while ((p = scx_task_iter_next_locked(&sti))) {
> -		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
> +		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
>  		const struct sched_class *old_class = p->sched_class;
>  		const struct sched_class *new_class =
>  			__setscheduler_class(p->policy, p->prio);
> @@ -5210,9 +5208,7 @@ static int scx_ops_enable(struct sched_e
>  		if (old_class != new_class)
>  			queue_flags |= DEQUEUE_CLASS;
>  
> -		if (old_class != new_class && p->se.sched_delayed)
> -			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> -
> +		update_rq_clock(task_rq(p));
>  		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
>  			p->scx.slice = SCX_SLICE_DFL;
>  			p->sched_class = new_class;

TJ, strictly speaking you should probably do a __balance_callbacks() in
__scx_task_irq_rq_unlock(). The various switched_from() methods like to
queue_balance_callback().

I think you're currently good by the fact that only RT/DL do this, and
you're not touching those in these loops.



