Return-Path: <linux-kernel+bounces-254533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EFA933468
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B471C22489
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFC713CFA3;
	Tue, 16 Jul 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmZeM8OS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D8143726
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721170881; cv=none; b=jxOO9HgBmxIKxHS5RhGuR0tiq+porzU4XiGDzzTDNtfmCMlK+vdv2nIalbq6zwsX31CItLSaRuGW61KTBtfHcmkuGNyFynXdKxmYGtojEZpQI1v6QE0/iU28LHFFNZvhLT/SWBPlII54lxgGLwB3HvV3UKlMwA3PBwJEpWErqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721170881; c=relaxed/simple;
	bh=FxuQCZK6IKzWe5TebWWLlXJgqhbrRmbYDrRuUZVNejQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHJDydvijBcScbZjJOWAs+qxorl+4GGyqBeV4xSTnRQNDZe7OXYbq0jgAwQOle6AJsIaqn0eb8Z6PsqdMjD4PfvooClyqQDF45h7pM/PKkrF2mF2f8tn1/p1TY/qqXk60btCQvBkZt6HAxL3bUw+zgXWxJBxEGZQnUVZYU4kxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmZeM8OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775CFC4AF09;
	Tue, 16 Jul 2024 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721170880;
	bh=FxuQCZK6IKzWe5TebWWLlXJgqhbrRmbYDrRuUZVNejQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmZeM8OSxo2ATMdaiXmxX85BNIYdigGi+smpykyaa8RjDyy69H2bmKDHcnPp6urbL
	 qUzhUwbLE10Y7bFCrJ8jFiCEuBvZszql4uzTlmeyGnXb7gjazywGr8lCkVvvdJk8Lo
	 OlFLcGV66X65GBS4MuUGpjwHx7M/JrW2JoWkOJ9YDM+PFsy4jSv9YwPuUm5hEfBEp5
	 7du7btDTIBHznWL6EzMPZi1pBZ0DgR25+BL08stgDNSw5BKdFuEQxbxI8npD7xlrsg
	 boRq4A2hqJYvSbpJzmHisIvzMSoHQyzs/PfVor+A92ioJWUopd3Rn6TD6a5Jl++B9b
	 yciCnUgxB8TJQ==
Date: Wed, 17 Jul 2024 01:01:17 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] timers/migration: Move hierarchy setup into
 cpuhotplug prepare callback
Message-ID: <Zpb7vQqarZZqvtCo@pavilion.home>
References: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
 <20240716-tmigr-fixes-v4-2-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716-tmigr-fixes-v4-2-757baa7803fe@linutronix.de>

Le Tue, Jul 16, 2024 at 04:19:20PM +0200, Anna-Maria Behnsen a écrit :
> However if the active CPU prevents from tmigr_cpu_(in)active() to walk up
> with the update not-or-half visible, nothing prevents walking up to the new
> top with a 0 childmask in tmigr_handle_remote_up() or
> tmigr_requires_handle_remote_up() if the active CPU doing the prepare is
> not the migrator. But then it looks fine because:
> 
>   * tmigr_check_migrator() should just return false
>   * The migrator is active and should eventually observe the new childmask
>     at some point in a future tick.
> 
> Split setup functionality of online callback into the cpuhotplug prepare
> callback and setup hotplug state. Change init call into early_initcall() to
> make sure boot CPU prepares everything for upcoming CPUs.

Not sure this will always be the boot CPU doing the prepare. But I think
the important part is that the target CPU must never do the prepare work.
Otherwise it may activate the old root to the new root even if the old root
is idle.

> Reorder the code,
> that all prepare related functions are close to each other and online and
> offline callbacks are also close together.
> 
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  include/linux/cpuhotplug.h    |   1 +
>  kernel/time/timer_migration.c | 196 +++++++++++++++++++++++-------------------
>  2 files changed, 110 insertions(+), 87 deletions(-)
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 7a5785f405b6..df59666a2a66 100644
> @@ -1623,7 +1689,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
>  			continue;
>  		} else {
>  			child = stack[i - 1];
> -			tmigr_connect_child_parent(child, group);
> +			tmigr_connect_child_parent(child, group, false);

This may need a small comment: /* Will be activated at online time */

>  		}
>  
>  		/* check if uppermost level was newly created */
[...]
> -/*
> - * tmigr_trigger_active() - trigger a CPU to become active again
> - *
> - * This function is executed on a CPU which is part of cpu_online_mask, when the
> - * last active CPU in the hierarchy is offlining. With this, it is ensured that
> - * the other CPU is active and takes over the migrator duty.
> - */
> -static long tmigr_trigger_active(void *unused)
> +static int tmigr_cpu_prepare(unsigned int cpu)
>  {
> -	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +	struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
> +	int ret = 0;
>

It would be nice to have this warning here (or in tmigr_setup_group()):

/*
 * The target CPU must never do the prepare work. Otherwise
 * it may spuriously activate the old root to the new one
 * and/or release an uninitialized childmask.
 */
WARN_ON_ONCE(cpu == raw_smp_processor_id());

And in any case:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

