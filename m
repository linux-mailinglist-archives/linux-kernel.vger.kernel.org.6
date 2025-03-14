Return-Path: <linux-kernel+bounces-561602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6013A613DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEAD3A2652
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466E20125B;
	Fri, 14 Mar 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO9s4bKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD120110F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963251; cv=none; b=GwA0h90MTS1mYdIM0TH8DKp1vEAooyRXAYrkphGxe5hkZEI/QlvjeS4z4gb0lhHDb+lZAyrG8Z4uEYz7Vehx8aGnlcvbZtnhyS+mJXIxBPPMD8VLyoQdhqGtJNx6vuEXnIRrbcIffpIYOoc6o7AED3S4w0I9x3+MtQh6s5Xo18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963251; c=relaxed/simple;
	bh=fKLOJG+wCqdo3QLPNwIgVZGH8BSKkaP5FrLXW/34+5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS13fDid+Mb32l87+IfRQTmOwlz5RUzwffqva32v5z3yj3fXOftROEWYcAse9hRi+ZDBQImpVlps1W1K4T8SYkf4kWHoTcJNavUTO0NK0lU95IWymZhhBTMtq4NyhMSTSz0zr3HYEGhy/woL5oO48CFY/VBHfsthc7VSCFAx0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO9s4bKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7316C4CEE3;
	Fri, 14 Mar 2025 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963250;
	bh=fKLOJG+wCqdo3QLPNwIgVZGH8BSKkaP5FrLXW/34+5Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LO9s4bKMpwFKntf4taNdbOIjQ6I+ZOQOugICl+JxiqKrdgjUGQSfmRT/vdsOntZcl
	 APULuN0M86QcGYYbRw0JzP9eoPrlknrTLk1ddW0aaddjPMY+Q0XdZneYDkfSd6MTgH
	 ZXzKHQVDppTHU/2L4mmWC+V/D97hRjoPBhfWCDRM1qnv+FqsGTwF+FmmCX/DS71XW8
	 W0GKSnTcK8KrUjex+bs6nF3YFSiHCuLRlNdvupmXnH53CpuGtvOZprbtPnBn/v0/0C
	 aXYKZMkA7GP/ctzPSaNyZj6ZChwsN0nHRcH4TKOtImpSJuzesg9nKJaZIKPRLv67Z3
	 RCyqm0IBpalhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8077ACE056F; Fri, 14 Mar 2025 07:40:50 -0700 (PDT)
Date: Fri, 14 Mar 2025 07:40:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <8a285fc9-9505-44bf-8286-a83ea78357cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
 <20250314105856.GB36322@noisy.programming.kicks-ass.net>
 <20250314112808.-XVssA31@linutronix.de>
 <20250314114102.GY5880@noisy.programming.kicks-ass.net>
 <20250314120057.NcjcFp3K@linutronix.de>
 <20250314123058.GZ5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314123058.GZ5880@noisy.programming.kicks-ass.net>

On Fri, Mar 14, 2025 at 01:30:58PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 14, 2025 at 01:00:57PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-03-14 12:41:02 [+0100], Peter Zijlstra wrote:
> > > On Fri, Mar 14, 2025 at 12:28:08PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2025-03-14 11:58:56 [+0100], Peter Zijlstra wrote:
> > > > > On Wed, Mar 12, 2025 at 04:18:48PM +0100, Sebastian Andrzej Siewior wrote:

[ . . . ]

> > > > This makes it obvious that you can access it, it won't change as long
> > > > as you have the lock.
> > > 
> > > It's just plain confusing. rcu_dereference() says you care about the
> > > load being single copy atomic and the data dependency, we don't.
> > > 
> > > If we just want to shut up sparse; can't we write it like:
> > > 
> > > 	cur = unrcu_pointer(mm->futex_phash);
> > > 
> > > ?
> > 
> > But isn't rcu_dereference_protected() doing exactly this? It only
> > verifies that lockdep_is_held() thingy and it performs a plain read, no
> > READ_ONCE() or anything. And the reader understands why it is safe to
> > access the pointer as-is.
> 
> Urgh, so we have a rcu_dereference_*() function that does not in fact
> imply rcu_dereference() ? WTF kind of insane naming it that?

My kind of insane naming!  ;-)

The rationale is that "_protected" means "protected from updates".

							Thanx, Paul

------------------------------------------------------------------------

/**
 * rcu_dereference_protected() - fetch RCU pointer when updates prevented
 * @p: The pointer to read, prior to dereferencing
 * @c: The conditions under which the dereference will take place
 *
 * Return the value of the specified RCU-protected pointer, but omit
 * the READ_ONCE().  This is useful in cases where update-side locks
 * prevent the value of the pointer from changing.  Please note that this
 * primitive does *not* prevent the compiler from repeating this reference
 * or combining it with other references, so it should not be used without
 * protection of appropriate locks.
 *
 * This function is only for update-side use.  Using this function
 * when protected only by rcu_read_lock() will result in infrequent
 * but very ugly failures.
 */

