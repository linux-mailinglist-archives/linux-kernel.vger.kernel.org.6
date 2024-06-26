Return-Path: <linux-kernel+bounces-231356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066FF9191EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F001C22584
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6288E190491;
	Wed, 26 Jun 2024 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFt2QxUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4E14EC59
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428261; cv=none; b=n7bWTpGqQ3lAsGv89vMFdOgZFmb6kifl2rGzl5muMOD+N0wZ/vzAYuFhVAM0CxaNDu8wyvISbXGV1EU3YHiLjh7QRNhTJrc5/8VTPU8PVYpuokweku1vFSAvkGzyEP+boD7i/iDSHEfFSAQM71+9w+x26rXmzCZrGvEgG31ZjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428261; c=relaxed/simple;
	bh=sCMSsGcEMJ++y+g1ZTNTn7ELv4Coua89ZcKT2ADc3fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvY33wIQ7QM/wdytPZI+mYh15bLqAEP8ow2yIM1YBdGtMP2Yuik3xXlWDk7O5Tf0lyb46aKqdNohDNOR5CkpAvWwRVrYwzBpeyhqfuo4ppgkP8HSzgcmaZtv6fQa35X72KyeAWlELGLj6UvWN97+aaWSSyh0GkLQvFguImA3Z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFt2QxUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8F1C116B1;
	Wed, 26 Jun 2024 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719428261;
	bh=sCMSsGcEMJ++y+g1ZTNTn7ELv4Coua89ZcKT2ADc3fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFt2QxUe65wiB2PFGrGbjo/N8Aup7eA0gELflBKPiUUioqsivVeYLEWQIMVgj0Uy4
	 mr0DqCXRMQcAhmz0cR6pLNW14csHt3kvrcTVZ1oRY2gQii7VHXos0CJwEAwHWuPwJu
	 y2wq4lIKesT/wuCAI7Ih7tdtpicxCjvv8auJfh+UIhwxnyt4XWpx0jaYbYWNbJnJlS
	 OCvDMUCc8nHLqaiHK6kemddaUrhcLXRbutA5RsNkrLDh0S1x1Xh80rHmxGiHOkVVYl
	 ad4+Mf40Q1f2WFIYTbva0+nG15uCU/0vu4410xtW450UTOPLTYEwhRwR1oT1aQromw
	 pWYcvp/UpCfbg==
Date: Wed, 26 Jun 2024 11:57:40 -0700
From: Kees Cook <kees@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] seccomp: release task filters when the task exits
Message-ID: <202406261154.50DCF7B7@keescook>
References: <20240523014540.372255-1-avagin@google.com>
 <20240523014540.372255-3-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523014540.372255-3-avagin@google.com>

On Thu, May 23, 2024 at 01:45:39AM +0000, Andrei Vagin wrote:
> Previously, seccomp filters were released in release_task(), which
> required the process to exit and its zombie to be collected. However,
> exited threads/processes can't trigger any seccomp events, making it
> more logical to release filters upon task exits.
> 
> This adjustment simplifies scenarios where a parent is tracing its child
> process. The parent process can now handle all events from a seccomp
> listening descriptor and then call wait to collect a child zombie.
> 
> seccomp_filter_release takes the siglock to avoid races with
> seccomp_sync_threads. There was an idea to bypass taking the lock by
> checking PF_EXITING, but it can be set without holding siglock if
> threads have SIGNAL_GROUP_EXIT. This means it can happen concurently
> with seccomp_filter_release.
> 
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  kernel/exit.c    |  3 ++-
>  kernel/seccomp.c | 22 ++++++++++++++++------
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 41a12630cbbc..23439c021d8d 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -278,7 +278,6 @@ void release_task(struct task_struct *p)
>  	}
>  
>  	write_unlock_irq(&tasklist_lock);
> -	seccomp_filter_release(p);
>  	proc_flush_pid(thread_pid);
>  	put_pid(thread_pid);
>  	release_thread(p);
> @@ -836,6 +835,8 @@ void __noreturn do_exit(long code)
>  	io_uring_files_cancel();
>  	exit_signals(tsk);  /* sets PF_EXITING */
>  
> +	seccomp_filter_release(tsk);
> +
>  	acct_update_integrals(tsk);
>  	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	if (group_dead) {
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 35435e8f1035..67305e776dd3 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -502,6 +502,9 @@ static inline pid_t seccomp_can_sync_threads(void)
>  		/* Skip current, since it is initiating the sync. */
>  		if (thread == caller)
>  			continue;
> +		/* Skip exited threads. */
> +		if (thread->flags & PF_EXITING)
> +			continue;
>  
>  		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
>  		    (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
> @@ -563,18 +566,18 @@ static void __seccomp_filter_release(struct seccomp_filter *orig)
>   * @tsk: task the filter should be released from.
>   *
>   * This function should only be called when the task is exiting as
> - * it detaches it from its filter tree. As such, READ_ONCE() and
> - * barriers are not needed here, as would normally be needed.
> + * it detaches it from its filter tree. PF_EXITING has to be set
> + * for the task.

Let's capture this requirement with a WARN_ON() (like was done for the
sighand case before). So before the spinlock, check for PF_EXITING and
fail safe (don't release):

	if (WARN_ON((tsk->flags & PF_EXITING) == 0))
		return;

>   */
>  void seccomp_filter_release(struct task_struct *tsk)
>  {
> -	struct seccomp_filter *orig = tsk->seccomp.filter;
> -
> -	/* We are effectively holding the siglock by not having any sighand. */
> -	WARN_ON(tsk->sighand != NULL);
> +	struct seccomp_filter *orig;
>  
> +	spin_lock_irq(&current->sighand->siglock);

Shouldn't this be "tsk" not "current"?

> +	orig = tsk->seccomp.filter;
>  	/* Detach task from its filter tree. */
>  	tsk->seccomp.filter = NULL;
> +	spin_unlock_irq(&current->sighand->siglock);

Same.

>  	__seccomp_filter_release(orig);
>  }
>  
> @@ -602,6 +605,13 @@ static inline void seccomp_sync_threads(unsigned long flags)
>  		if (thread == caller)
>  			continue;
>  
> +		/*
> +		 * Skip exited threads. seccomp_filter_release could have
> +		 * been already called for this task.
> +		 */
> +		if (thread->flags & PF_EXITING)
> +			continue;
> +
>  		/* Get a task reference for the new leaf node. */
>  		get_seccomp_filter(caller);
>  
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

Otherwise, looks good!

-- 
Kees Cook

