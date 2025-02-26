Return-Path: <linux-kernel+bounces-534192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5D5A463FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245E71710C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB932222C8;
	Wed, 26 Feb 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMxOtcWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3D190665
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582143; cv=none; b=MqWXFe9VK6dsHBZMa5arcCmpd/G0X9s7RuGuj2ZTjLKFhRK7FkbiG9cGzKRdaqq1i1HdSFUBcQokOkBFQmXiy4lvEIy77qFAe69cCbBQVGJ6T+WjZ154/aJyGyL1B6cKSn+KsAzo6E0wqqESC3qteXVLQiIn+OIBgK5XdA2MPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582143; c=relaxed/simple;
	bh=lW1uVxiz1zwkZfsdu2FvG52Ph55luPTOoJCgdMZItXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCyxqVAkwVDyXAPFpME3tXWaE0Nvlrdjm+OQfWE9gMvt8guPYhDvOH7p4cpcDocdusKpIhnzkeKQzmf3mNdFQGE5qbB4YZ2Rh2krJWqS0P+OAgEkAca3w0rAIGumLaSmUQDLMzUKXh7WUUOHAXjsYUsq36c+NhRRf/qDMrxS0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMxOtcWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D43DC4CEE4;
	Wed, 26 Feb 2025 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740582142;
	bh=lW1uVxiz1zwkZfsdu2FvG52Ph55luPTOoJCgdMZItXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMxOtcWrU/RFP969LF589aMic0wVLrITjYRqReOSEFaCXsrCjdlAwnfsTEUb6nbxf
	 zmsJi4CcfQ6qh712C0UTUxvw8ZpupFh3FtYLstDKdHYSYRzCjDevpq8FzrvoRv+FIC
	 BUC7ESgv1vvXmcG2K3Dd6SuY0JTgjaguHs1qlBYZO93xv7J2bIOw+DP9oI4OouOzhA
	 +bA0IFiUriEV9RKoktxUZDuT2p//BScIIpMkDdpX8096DIpIpZDBHCD5lM3QXzew0d
	 t1pLWSv4x1qmH1dTdg15EpF8HfoECNRyCO1n+s0Wfr7ilbPk5R5t3JYQ6zGtMmcQOW
	 oENIobmmUAq0g==
Date: Wed, 26 Feb 2025 16:02:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	open list <linux-kernel@vger.kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] workqueue: Always use wq_select_unbound_cpu() for
 WORK_CPU_UNBOUND.
Message-ID: <Z78s-1jHXehA33px@localhost.localdomain>
References: <20250221112003.1dSuoGyc@linutronix.de>
 <Z7iSboU-05uMJ7-e@localhost.localdomain>
 <Z7iuUObJGgZtsaJe@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7iuUObJGgZtsaJe@slm.duckdns.org>

Le Fri, Feb 21, 2025 at 06:48:16AM -1000, Tejun Heo a écrit :
> Hello,
> 
> On Fri, Feb 21, 2025 at 03:49:18PM +0100, Frederic Weisbecker wrote:
> > Le Fri, Feb 21, 2025 at 12:20:03PM +0100, Sebastian Andrzej Siewior a écrit :
> > > If the user did not specify a CPU while enqueuing a work item then
> > > WORK_CPU_UNBOUND is passed. In this case, for WQ_UNBOUND a CPU is
> > > selected based on wq_unbound_cpumask while the local CPU is preferred.
> > > For !WQ_UNBOUND the local CPU is selected.
> > > For NOHZ_FULL system with isolated CPU wq_unbound_cpumask is set to the
> > > not isolated (housekeeping) CPUs. This leads to different behaviour if a
> > > work item is scheduled on an isolated CPU where
> > > 	schedule_delayed_work(, 1);
> > > 
> > > will move the timer to the housekeeping CPU and then schedule the work
> > > there (on the housekeeping CPU) while
> > > 	schedule_delayed_work(, 0);
> > > 
> > > will schedule the work item on the isolated CPU.
> > > 
> > > The documentation says WQ_UNBOUND prefers the local CPU. It can
> > > preferer the local CPU if it is part of wq_unbound_cpumask.
> > > 
> > > Restrict WORK_CPU_UNBOUND to wq_unbound_cpumask via
> > > wq_select_unbound_cpu().
> > > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > I really would like to have this patch in. I have considered
> > doing that a few month ago but got sort-of discouraged by the
> > lack of properly defined semantics for schedule_work(). And that
> > function has too many users to check their locality assumptions.
> > 
> > Its headers advertize to queue in global workqueue but the target
> > is system_wq and not system_unbound_wq. But then it's using
> > WORK_CPU_UNBOUND through queue_work().
> > 
> > I'm tempted to just assume that none of its users depend on the
> > work locality?
> 
> That's API guarantee and there are plenty of users who depend on
> queue_work() and schedule_work() on per-cpu workqueues to be actually
> per-cpu. I don't think we can pull the rug from under them. If we want to do
> this, which I think is a good idea, we should:
> 
> 1. Convert per-cpu workqueue users to unbound workqueues. Most users don't
>    care whether work item is executed locally or not. However, historically,
>    we've been preferring per-cpu workqueues because unbound workqueues had a
>    lot worse locality properties. Unbound workqueue's topology awareness is
>    a lot better now, so this should be less of a problem and we should be
>    able to move a lot of users over to unbound workqueues.

But we must check those ~1951 schedule_work() users one by one to make sure they
don't rely on locality for correctness, right? :-)

> 
> 2. There still are cases where local execution isn't required for
>    correctness but local & concurrency controlled executions yield
>    performance gains. Workqueue API currently doesn't distinguish these two
>    cases. We should add a new API which prefers local execution but doesn't
>    require it, which can then do what's suggested in this patch.

That is much trickier to find out and requires to know about the subsystem
details and history.

For those that don't rely on locality for correctness, we would really like
to be able to offload them to unbound pool at least when nohz_full= is filled.
Because in that case we don't care much on workqueues performance.

> 
> Unfortunately, I don't see a way forward without auditing and converting the
> users.

I see...

Thanks.

> 
> Thanks.
> 
> -- 
> tejun

