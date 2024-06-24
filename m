Return-Path: <linux-kernel+bounces-227991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA5915977
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DD41F23857
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B961A0B04;
	Mon, 24 Jun 2024 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awKWNwI4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C1482C1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266491; cv=none; b=M+i0YvQPADaxooB0XksrGswIPq4/q/98IBJAbNqKCMwCGl6M4ldEbTbqju8/o0mG8IlMwJjAZA7+COoRIQXQLzvI84B9pcURWjLDsfmTKgvyndUoAxrRJS+2qG3gKyjoQa2W6APA21ik7jkHK8Fd5ORVBndF/R4TBGTHoGuvTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266491; c=relaxed/simple;
	bh=rM6BY/wduZEkcBxm4aJ4XDuJ4I/Yj6gkCD81guYzGug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoQWaJTs2ty01WUyTA6WHNpU9XAliwoj/l1rYfFvABp1JCjYw6vWk7EwCF3Ue2yfeDha/t0TZIeSvBAwXj442W9Iz2a/YaziJzQSfQLp/I8c+HI4Lzrv3dLepNz0Bk6oyYaztOodIVD/7RO4o7n4Xm6ZbVEGwXhwDMoOp2sD4U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awKWNwI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6162C2BBFC;
	Mon, 24 Jun 2024 22:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719266490;
	bh=rM6BY/wduZEkcBxm4aJ4XDuJ4I/Yj6gkCD81guYzGug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awKWNwI4Vjtsyek6PQ7Ll3P++B+6zlPkm7I0fGCrePTZLGtiaG9TTBgIHiGjcxhRl
	 aTtBd/KnjsOnGivxsAICLHRygIsWpLmlq1bb3ZrkVlao5thXBwVI4fCjPxf9puL+KC
	 nb9Y8zhCk53uBGflhBu9xJPzJr19KoM3re7dQ7Wc6sb56ooc/YoQK49gycrMxZAtDk
	 wa1+yqPgkvUGKpoZDl7o61hE18+QYr2zp4svCgee+dSChmqJTZGe2Gb3yb3NB493EQ
	 KufJ0tR+rupEhgMqQIVNJq9/QiJYa/ozq0MvHMpBFSqrp8mmk2wZCDtnB68GV8FhPF
	 9Z5JqUAibVfLw==
Date: Tue, 25 Jun 2024 00:01:27 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] timer_migration: Fix possible race in
 tmigr_active_up() in setup path
Message-ID: <Znnst52fdxIeBats@pavilion.home>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
 <20240624-tmigr-fixes-v2-4-3eb4c0604790@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624-tmigr-fixes-v2-4-3eb4c0604790@linutronix.de>

Le Mon, Jun 24, 2024 at 04:53:56PM +0200, Anna-Maria Behnsen a écrit :
> Frederic reported the following possible race:
> 
> 
> 		  [GRP0:0]
> 	       migrator = 0
> 	       active   = 0
> 	       nextevt  = KTIME_MAX
> 	       /         \
> 	      0         1 .. 7
> 	  active         idle
> 
> 0) Hierarchy has for now only 8 CPUs and CPU 0 is the only active CPU.
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = NONE
> 			nextevt  = KTIME_MAX
> 					 \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = 0              migrator = TMIGR_NONE
> 	      active   = 0              active   = NONE
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	  active         idle                !online
> 
> 1) CPU 8 is booting and creates a new group in first level GRP0:1 and
>    therefore also a new top group GRP1:0. For now the setup code proceeded
>    only until the connected between GRP0:1 to the new top group. The

*connection

>    connection between CPU8 and GRP0:1 is not yet established and CPU 8 is
>    still !online.
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = NONE
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = 0              migrator = TMIGR_NONE
> 	      active   = 0              active   = NONE
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	  active         idle                !online
> 
> 2) Setup code now connects GRP0:0 to GRP1:0 and observes while in
>    tmigr_connect_child_parent() that GRP0:0 is not TMIGR_NONE. So it
>    prepares to call tmigr_active_up() on it. It hasn't done it yet.
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = NONE
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE        migrator = TMIGR_NONE
> 	      active   = NONE              active   = NONE
> 	      nextevt  = KTIME_MAX         nextevt  = KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	    idle         idle                !online
> 
> 3) CPU 0 goes idle. Since GRP0:0->parent has been updated by CPU 8 with
>    GRP0:0->lock held, CPU 0 observes GRP1:0 after calling
>    tmigr_update_events() and it propagates the change to the top (no change
>    there and no wakeup programmed since there is no timer).
> 
> 			     [GRP1:0]
> 			migrator = GRP0:0
> 			active   = GRP0:0
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE       migrator = TMIGR_NONE
> 	      active   = NONE             active   = NONE
> 	      nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	    idle         idle                !online
> 
> 4) Now the setup code finally calls tmigr_active_up() to and sets GRP0:0
>    active in GRP1:0
> 
> 			     [GRP1:0]
> 			migrator = GRP0:0
> 			active   = GRP0:0, GRP0:1
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE       migrator = 8
> 	      active   = NONE             active   = 8
> 	      nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
> 		/         \                    |
> 	      0          1 .. 7                8
> 	    idle         idle                active
> 
> 5) Now CPU 8 is connected with GRP0:1 and CPU 8 calls tmigr_active_up() out
>    of tmigr_cpu_online().
> 
> 			     [GRP1:0]
> 			migrator = GRP0:0
> 			active   = GRP0:0
> 			nextevt  = T8
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE         migrator = TMIGR_NONE
> 	      active   = NONE               active   = NONE
> 	      nextevt  = KTIME_MAX          nextevt  = T8
> 		/         \                    |
> 	      0          1 .. 7                8
> 	    idle         idle                  idle
> 
> 5) CPU 8 goes idle with a timer T8 and relies on GRP0:0 as the migrator.
>    But it's not really active, so T8 gets ignored.
> 
> The update which is done in third step is not noticed by setup code. So a
> wrong migrator is set to top level group and a timer could get ignored.
> 
> Rework the activation of an already existing group in setup code after
> adding a new top level group and use memory barriers (as already used in
> tmigr_inactive_up()) to be sure that child state updates and group state
> updates are ordered properly.
> 
> The update of the group event ignore bit is now ignored. But this is fine,
> as this bit is only required when queueing the event into the timer queue
> of the parent group. As this is always the update of the top level group,
> it doesn't matter.
> 
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Very nice fix, thanks!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just some comment suggestions below:

> ---
>  kernel/time/timer_migration.c | 49 ++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 0e1c53dac390..7971512a60b0 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1448,6 +1448,37 @@ u64 tmigr_quick_check(u64 nextevt)
>  	return KTIME_MAX;
>  }
>  
> +static void tmigr_setup_active_up(struct tmigr_group *group, struct tmigr_group *child)
> +{
> +	union tmigr_state curstate, childstate;
> +	bool walk_done;
> +
> +	/*
> +	 * Memory barrier is paired with the cmpxchg in tmigr_inactive_up() to
> +	 * make sure updates of child and group states are ordered. The ordering
> +	 * is mandatory, as the update of the group state is only valid for when
> +	 * child state is active.
> +	 */
> +	curstate.state = atomic_read_acquire(&group->migr_state);
> +
> +	for (;;) {

/*
 * If the child hasn't yet propagated anything to the top level, the above
 * acquire has no effect. However thanks to child locking (see comment in
 * tmigr_connect_child_parent()), either the latest child->migr_state is
 * observed or the remote CPU now observes the new parent and is about to
 * propagate to the new parent. In the latter case it will either beat the
 * current trial update or overwrite it.
 */

And another comment later:

> +		childstate.state = atomic_read(&child->migr_state);
> +		if (!childstate.active)
> +			return;
> +
> +		if (__tmigr_active_up(group, &walk_done, &curstate, child->childmask))
> +			break;
> +
> +		/*
> +		 * The memory barrier is paired with the cmpxchg() in
> +		 * tmigr_inactive_up() to make sure the updates of child and
> +		 * group states are ordered. It is required only when the
> +		 * try_cmpxchg() in __tmigr_active_up() fails.
> +		 */
> +		smp_mb__after_atomic();
> +	}
> +}
> +
>  static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
>  			     int node)
>  {
> @@ -1522,8 +1553,6 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
>  static void tmigr_connect_child_parent(struct tmigr_group *child,
>  				       struct tmigr_group *parent)
>  {
> -	union tmigr_state childstate;
> -

/*
 *  CPU 0                                CPU 1
 *  -----                                ------
 *  // tmigr_connect_child_parent        // tmigr_inactive_up()
 *  LOCK child                           WRITE group->migr_state
 *  WRITE child->parent                  // tmigr_update_events()
 *  UNLOCK child                         LOCK group
 *  // tmigr_setup_active_up             UNLOCK group
 *  READ child->migr_state               // walk_groups()
 *                                       READ group->parent
 *
 * Due to RELEASE/ACQUIRE semantics, it is ensured that either the
 * current CPU sees the latest migr_state update on the remote group
 * or the remote group will observe the new parent.
 *
 * Early lockless return on tmigr_update_events() involve either
 * observing the new parent or dealing with an intermediate parent that
 * will trigger relevant locking while walking up.
 */

Thanks!

