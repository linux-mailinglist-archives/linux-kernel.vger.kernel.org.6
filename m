Return-Path: <linux-kernel+bounces-272491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2F945CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298C3283EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFD1DF662;
	Fri,  2 Aug 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="njhhsfEh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340934AEF6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597037; cv=none; b=JtX76Gf5c8Xe44TP2P+vBhvxmWtJay1aqovmWsFu8SWk6G/3HkRng7WNf3b07dZymyMGr7WyjRQBdXChnL+ft8GmERCzC2ndO/OMH0pXuFvjsk1YSI2gpUAJsYkvBlARVXb9+KHrzANpPucgfXtNL9hSN1dXKDX8cPPnZY9AdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597037; c=relaxed/simple;
	bh=jypJKW4/Wx+Ew+ORwamTuz6dfTzg/MWvqfdNVbA0fMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmO4qKyiadIu1jtftW0We2d9KS/NKqKeEITAOI9zfhQhBQetiXec3UkRu6SbzNXnojaxFRyrP0X6vJZ9H3Hk1IlWN8xrict/XlQyXap5ShrpALT5O7QtcA6tE4B4PagYk6LxtU/SEeFCPpruu+rfUe6w91rndNtmT0ez8AdTo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=njhhsfEh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=68jEVvdzTVmpOayzX9tgovX5xVXyVBYmUCYhJF/EMBU=; b=njhhsfEhbU8/wxlhybNpwuvEtf
	tCWbpjUvo5yw5gX1kFOWhTJoTfh5rDX9Yla2X8GWn4ZP2TMnM7LZD4MV4Sthk0e5wOGsfg//unH+p
	HWsr7yfXbUaLgDqkE4gsfauW+LulzMvMLjVD+3tSG92U2GvFpuzR5FyKbTbJeoKBRQmwYRykspfYe
	izgOPHUnfbF8H5UacSl0LJkkcy2ZhfxqBRiqxOaPty0FUS3QKfd5SVdCJHl7bJHwi4ScrDS1u/RJ0
	isHfsDEzA3/aQLHdrRsSa2y3XUfMh87j3ApoBbzyBEcb7Sas7kpVGtmyvvBP4EzCUJqYmzcXFETsP
	ViIoM38A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZqAt-00000005h98-28DG;
	Fri, 02 Aug 2024 11:10:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 579FB30049D; Fri,  2 Aug 2024 13:10:18 +0200 (CEST)
Date: Fri, 2 Aug 2024 13:10:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240802111018.GI39708@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqmVG9ZiktN6bnm0@slm.duckdns.org>

On Tue, Jul 30, 2024 at 03:36:27PM -1000, Tejun Heo wrote:

> > Or make scx hard depend on SMP? Are there really still people using !SMP
> > -- and I suppose more importantly, do we care?
> > 
> > I mean, they could always run an SMP kernel on their UP potato if they
> > *really* feel they need this.
> 
> Maybe, but at the same time, it's also just some isolated cruft that enables
> UP support, so both sides of the scale seem similarly light-weight? I lean
> towards "why not support it?" but don't feel particularly strongly about it.

So you're basically looking for something like this?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9f655025607..69ec02a28117 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5772,7 +5772,6 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 				  struct rq_flags *rf)
 {
-#ifdef CONFIG_SMP
 	const struct sched_class *class;
 	/*
 	 * We must do the balancing pass before put_prev_task(), such
@@ -5783,10 +5782,9 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * a runnable task of @class priority or higher.
 	 */
 	for_class_range(class, prev->sched_class, &idle_sched_class) {
-		if (class->balance(rq, prev, rf))
+		if (class->balance && class->balance(rq, prev, rf))
 			break;
 	}
-#endif
 
 	put_prev_task(rq, prev);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..40f3dc436f4f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2296,8 +2296,8 @@ struct sched_class {
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
-#ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+#ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 
 	struct task_struct * (*pick_task)(struct rq *rq);

