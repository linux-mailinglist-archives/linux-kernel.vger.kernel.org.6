Return-Path: <linux-kernel+bounces-227078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70366914803
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249A91F23D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF3137743;
	Mon, 24 Jun 2024 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zul6obyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AE2136663
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227096; cv=none; b=CKvoc5P7dqmCFJQ2pyMjyerFV1Z74y3HTvhRs4uwj6l0ekP+ldIWoE15XzBAFCGuFLLLGes5jYu8UcXfQzqqBxA7PjV/eAqvqbEF2JyoLoIyrMGw7345dHd33XEhGCckdL9sSPtDVKdJIxyz+d3j1y/Kdk2jrhwtN8DUS1WBkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227096; c=relaxed/simple;
	bh=ScPmTjF2579pHVSsz6jaMLkZu+Xg8dywXQLweA3pHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXz1/SFiEDMYzaiX7tLEYwhQm7J2aHXIa3NYX8aH/PHLsj4yhbEFhmYEzwGzq/Xtd/OlUbUxjSRPp6QRDgIp3QCcwl+mfrHuwcz3w2iPzZGmu04z23Bcm1jV5SIL49SQd3LpONWCgJ3CbAtOmYTiWmB5GNFFNz9yK3BT2kh4tH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zul6obyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE06C2BBFC;
	Mon, 24 Jun 2024 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719227096;
	bh=ScPmTjF2579pHVSsz6jaMLkZu+Xg8dywXQLweA3pHi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zul6obylsMOWoO/B+ZQbVaneKjPg4sr+UKZU+ALHnjqcJRxU4uHe2MfXD6qKN10R6
	 X1E445HzYgkQyU40uLhoZsxyYkuotmEE3MMk5Z7L6ejyJkNWrOwFs3CjLskdoLryei
	 CqBL5NzqTNVXtDZa+R97d+t7n3z3NkVCodt2/GMJl2jesEsMmU3mpZNN6Nu2G27cTh
	 JihShgZ9NPQ1jP5LBnYOgimZjGy0PKwNfdu1gVvpxtNAH5wZdybBAGgSZ45qR3vG49
	 ZhoVYvFZ5d846qaU6uP+Xk/Vi1PZ3veoLpkGjN6MHtTiFoA0cGpIzzmuVQXAGnZrWW
	 6N7XlY5qXuxJw==
Date: Mon, 24 Jun 2024 13:04:53 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, Narasimhan V <Narasimhan.V@amd.com>
Subject: Re: [PATCH 0/3] timer_migration: Fix a possible race and improvements
Message-ID: <ZnlS1QcFgHvJGm7J@lothringen>
References: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
 <ZnWOswTMML6ShzYO@localhost.localdomain>
 <87zfrag1jh.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfrag1jh.fsf@somnus>

On Mon, Jun 24, 2024 at 10:58:26AM +0200, Anna-Maria Behnsen wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> > 0) Hierarchy has only 8 CPUs (single node for now with only CPU 0
> >    as active.
> >
> >    
> >                              [GRP1:0]
> >                         migrator = TMIGR_NONE
> >                         active   = NONE
> >                         nextevt  = KTIME_MAX
> >                                          \
> >                  [GRP0:0]                  [GRP0:1]
> >               migrator = 0              migrator = TMIGR_NONE
> >               active   = 0              active   = NONE
> >               nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> >                 /         \                    |
> >               0          1 .. 7                8
> >           active         idle                !online
> >
> > 1) CPU 8 is booting and creates a new node and a new top. For now it's
> >    only connected to GRP0:1, not yet to GRP0:0. Also CPU 8 hasn't called
> >    __tmigr_cpu_activate() on itself yet.
> 
> NIT: In step 1) CPU8 is not yet connected to GRP0:1 as the second while
> loop is not yet finished, but nevertheless...

Yes, I was in the second loop in my mind, but that didn't transcribe well :-)

> 
> >
> >                              [GRP1:0]
> >                         migrator = TMIGR_NONE
> >                         active   = NONE
> >                         nextevt  = KTIME_MAX
> >                        /                  \
> >                  [GRP0:0]                  [GRP0:1]
> >               migrator = 0              migrator = TMIGR_NONE
> >               active   = 0              active   = NONE
> >               nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> >                 /         \                    |
> >               0          1 .. 7                8
> >           active         idle                active
> >
> > 2) CPU 8 connects GRP0:0 to GRP1:0 and observes while in
> >    tmigr_connect_child_parent() that GRP0:0 is not TMIGR_NONE. So it
> >    prepares to call tmigr_active_up() on it. It hasn't done it yet.
> 
> NIT: CPU8 keeps its state !online until step 5.

Oops, copy paste hazards.

> Holding the lock will not help as the state is not protected by the
> lock.

No but any access happening before an UNLOCK is guaranteed to be visible
after the next LOCK. This makes sure that either:

1) If the remote CPU going inactive has passed tmigr_update_events() with
its unlock of group->lock then the onlining CPU will see the TMIGR_NONE

or:

1) If the onlining CPU locks before the remote CPU calls tmigr_update_events(),
   then the subsequent LOCK on group->lock in tmigr_update_events() will acquire
   the new parent link and propagate the up the inactive state.

And yes there is an optimization case where we don't lock:

		if (evt->ignore && !remote && group->parent)
			return true;

And that would fall through the cracks. So, forget about that lock idea.


> +static void tmigr_setup_active_up(struct tmigr_group *group, struct tmigr_group *child)
> +{
> +	union tmigr_state curstate, childstate;
> +	bool walk_done;
> +
> +	/*
> +	 * FIXME: Memory barrier is required here as the child state
> +	 * could have changed in the meantime
> +	 */
> +	curstate.state = atomic_read_acquire(&group->migr_state);
> +
> +	for (;;) {
> +		childstate.state = atomic_read(&child->migr_state);
> +		if (!childstate.active)
> +			return;

Ok there could have been a risk that we miss the remote CPU going active. But
again thanks to the lock this makes sure that either we observe the childstate
as active or the remote CPU sees the link and propagates its active state. And
the unlocked optimization tmigr_update_events() still works because either it
sees the new parent and proceeds or it sees an intermediate parent and the next
ones will be locked.

Phew!

I'll do a deeper review this evening but it _looks_ ok.

Thanks.

