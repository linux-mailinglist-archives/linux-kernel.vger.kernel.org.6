Return-Path: <linux-kernel+bounces-369478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C599A1DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E1428326B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901EB1D88AD;
	Thu, 17 Oct 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPAyQK7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A218C348
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155866; cv=none; b=NWfFr7zN7lyrytvdua5ZC3/Y/DU5QUSXUfTsWZ3+FvzAD6cvnlLBLkWyXG4yqnh9ATDYaQKyQGeH4cd5LE37RKbIdFZBPAOC4+dNTYwx6zn9pcfRtOZPxBhEKgD+voO0JaOqtICtsQAhjydNTfOQzSNA5smvmKN1ae24jborQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155866; c=relaxed/simple;
	bh=ahEgNy00u13prB4Dsk1cbLOT66omxDLwfiqmiCFvNBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAqcyGLl5G6zpsffHVWqr6piBs3ROfm+cTBpWtsVh/WAFa/mR/f3gElpyWU5nzrnA39fdNSIti/Cmo87rDTIuR1oveOQbowZ4ORNSgCHFfGmUeoykrlZy9Eo9AGRfvpIm1UdBZWzvJvK4pSkXeyYjqJg+n4NTSlEPpt7syCzyLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPAyQK7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260F9C4CEC3;
	Thu, 17 Oct 2024 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729155865;
	bh=ahEgNy00u13prB4Dsk1cbLOT66omxDLwfiqmiCFvNBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPAyQK7SK4gQ08M6LKVkjBDuFpGtgDwiTLhnmcCDZ52j/VJD9HhW9iPEMQXs8EeR8
	 p78KK1RdUUL1ZM++wchPuwvmDoVO2qyafE8ZeM4LF5JuGal8U6GrrMdxZRQ+/aUrsI
	 BrMlr41KkYkrDM+N3bz80w0DFo61nuvt+/M6UV2wwDTXciCpcNzHaN3yATl3tpvUMy
	 3MOvDo0vphLzmetsGk0KHC6wnWZ1JqwPg7MPlwQv/BdVBnXGROr2dvmMKgGhgsCj1b
	 +IImRMJJFCJn1CsmxO02IP3mTgW+WCuRI52aFACyIlWboGK2rO8MHWxjX5t69AQuk3
	 y3quyJCk95beg==
Date: Thu, 17 Oct 2024 11:04:22 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Chris Metcalf <cmetcalf@ezchip.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] posix-cpu-timers: clear TICK_DEP_BIT_POSIX_TIMER on clone
Message-ID: <ZxDTFmOi0waQFGEX@lothringen>
References: <xm264j5bd2gj.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm264j5bd2gj.fsf@google.com>

On Wed, Oct 16, 2024 at 04:59:08PM -0700, Benjamin Segall wrote:
> When we clone a new thread, we do not inherit its posix_cputimers, and
> clear them with posix_cputimers_init. However, this does not clear the
> tick dependency it creates in tsk->tick_dep_mask, and the handler does
> not reach the code to clear the dependency if there were no timers to
> begin with.
> 
> Thus if a thread has a cputimer running before cloneing/forking, that
> hierarchy will prevent nohz_full unless they create a cputimer of their
> own.
> 
> Process-wide timers do not have this problem because fork does not copy
> signal_struct as a baseline, it creates one from scratch.
> 
> Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
> Signed-off-by: Ben Segall <bsegall@google.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index df8e4575ff01..b57cd63cfcd1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2290,10 +2290,11 @@ __latent_entropy struct task_struct *copy_process(
>  
>  	task_io_accounting_init(&p->ioac);
>  	acct_clear_integrals(p);
>  
>  	posix_cputimers_init(&p->posix_cputimers);
> +	tick_dep_clear_task(p, TICK_DEP_BIT_POSIX_TIMER);

Yes but we don't need the expensive atomic_fetch_andnot(). Also more
generally the task tick dependency should be 0 upon creation.

So something like this?

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 72744638c5b0..99c9c5a7252a 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -251,12 +251,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_set_task(tsk, bit);
 }
+
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_clear_task(tsk, bit);
 }
+
+static inline void tick_dep_init_task(struct task_struct *tsk)
+{
+	atomic_set(&tsk->tick_dep_mask, 0);
+}
+
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
@@ -290,6 +297,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..6fa9fe62e01e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
+#include <linux/tick.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2292,6 +2293,7 @@ __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);

