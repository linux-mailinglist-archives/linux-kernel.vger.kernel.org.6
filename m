Return-Path: <linux-kernel+bounces-526251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D867A3FC27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BBF16AAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0E204F80;
	Fri, 21 Feb 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZV0CeZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A421F3FD0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156498; cv=none; b=VtrsQMIiNe9PwbCViruXP0A1tWXL8WU+WxXcjrcccFf/axh2QYHhAHeLG66zc9I7vRFYXG+IaK6HB/15S17HYqOhTx/EyHwWJZGExRJ8nelzFa9JicYISEhMkzWjl7NT+Yf2hHVnJeT4te/1baQGtTLCq2lZ2hQ7M+vj2IQ5fVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156498; c=relaxed/simple;
	bh=qzaTSmwh1YLeBgzSDRua/qgQ/EfnH79NA0l78aVxYUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvammq8fi9nRpKAQMKKgnbpx7/KrdvJc+dEGGHNOgSVJcV4oZCD/fz/d/ZtuKGBjuqe0WM4TE3EvP5pi5bJXpdJcw4ULQVLMYlEHs23IajkpqrTy5akIRqsGzlk9JiHwEcoUtN2m/mlbhGuYWyHWcL0m+CYdorOF5lzBnd0fe7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZV0CeZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823CC4CED6;
	Fri, 21 Feb 2025 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740156497;
	bh=qzaTSmwh1YLeBgzSDRua/qgQ/EfnH79NA0l78aVxYUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZV0CeZo7+S957i8mzPPjBZMBp7oXwkjLFgUdZ9Q+W6VczA6j4AHKHUsXySRvBSo2
	 +u3hRMua7SNevkGqt/hUGeQcEd1EBWamCzPdW8fmOMEby1Sl1yWqVooSVkdLHReSXG
	 sWx1TgyrrhP17uNhv6RPnBx7BpHa4m8/WiypDeC6MzjNzT56Oo6MG0MlBCJQuqVe/c
	 iXQVRIDoFkUdB2Ief9u1fNfSHRIN/bKPnUjHp35A9Qfp2S3hfAnFGcWeh+uL1zGLHh
	 KC7ZaZplXWA1JXo9bSIWXkPu0iSWZ/rtXiN1lYrruX5UXAvkQO9gNC8IIPohMCFkr8
	 Y42K8FtO77zng==
Date: Fri, 21 Feb 2025 06:48:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	open list <linux-kernel@vger.kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] workqueue: Always use wq_select_unbound_cpu() for
 WORK_CPU_UNBOUND.
Message-ID: <Z7iuUObJGgZtsaJe@slm.duckdns.org>
References: <20250221112003.1dSuoGyc@linutronix.de>
 <Z7iSboU-05uMJ7-e@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7iSboU-05uMJ7-e@localhost.localdomain>

Hello,

On Fri, Feb 21, 2025 at 03:49:18PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 21, 2025 at 12:20:03PM +0100, Sebastian Andrzej Siewior a écrit :
> > If the user did not specify a CPU while enqueuing a work item then
> > WORK_CPU_UNBOUND is passed. In this case, for WQ_UNBOUND a CPU is
> > selected based on wq_unbound_cpumask while the local CPU is preferred.
> > For !WQ_UNBOUND the local CPU is selected.
> > For NOHZ_FULL system with isolated CPU wq_unbound_cpumask is set to the
> > not isolated (housekeeping) CPUs. This leads to different behaviour if a
> > work item is scheduled on an isolated CPU where
> > 	schedule_delayed_work(, 1);
> > 
> > will move the timer to the housekeeping CPU and then schedule the work
> > there (on the housekeeping CPU) while
> > 	schedule_delayed_work(, 0);
> > 
> > will schedule the work item on the isolated CPU.
> > 
> > The documentation says WQ_UNBOUND prefers the local CPU. It can
> > preferer the local CPU if it is part of wq_unbound_cpumask.
> > 
> > Restrict WORK_CPU_UNBOUND to wq_unbound_cpumask via
> > wq_select_unbound_cpu().
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> I really would like to have this patch in. I have considered
> doing that a few month ago but got sort-of discouraged by the
> lack of properly defined semantics for schedule_work(). And that
> function has too many users to check their locality assumptions.
> 
> Its headers advertize to queue in global workqueue but the target
> is system_wq and not system_unbound_wq. But then it's using
> WORK_CPU_UNBOUND through queue_work().
> 
> I'm tempted to just assume that none of its users depend on the
> work locality?

That's API guarantee and there are plenty of users who depend on
queue_work() and schedule_work() on per-cpu workqueues to be actually
per-cpu. I don't think we can pull the rug from under them. If we want to do
this, which I think is a good idea, we should:

1. Convert per-cpu workqueue users to unbound workqueues. Most users don't
   care whether work item is executed locally or not. However, historically,
   we've been preferring per-cpu workqueues because unbound workqueues had a
   lot worse locality properties. Unbound workqueue's topology awareness is
   a lot better now, so this should be less of a problem and we should be
   able to move a lot of users over to unbound workqueues.

2. There still are cases where local execution isn't required for
   correctness but local & concurrency controlled executions yield
   performance gains. Workqueue API currently doesn't distinguish these two
   cases. We should add a new API which prefers local execution but doesn't
   require it, which can then do what's suggested in this patch.

Unfortunately, I don't see a way forward without auditing and converting the
users.

Thanks.

-- 
tejun

