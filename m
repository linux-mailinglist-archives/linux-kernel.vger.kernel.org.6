Return-Path: <linux-kernel+bounces-534445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA6A4671C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4777E17E41A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD4224AF9;
	Wed, 26 Feb 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+6GaM5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB07218823
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588288; cv=none; b=bxNYJModuGotT5LpPMOdcNKSK6G07fve/towvU8jC72mnJiT5G5pRlpUZcQQ5QBYCjTst2FAHYa+dso3qXFtak1mqdsybeqWSJob1QMwpOci2rJTnlVPDQcAuNoYHT/xA3939IPIhEl9xWKaD2fjQkxYdiVsMEtcmDLQTkq3Lt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588288; c=relaxed/simple;
	bh=wmmdXB84NfFshKKaz33rSra6NHIGRZEKRnRRJQgidw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieOCAbdTScU252Z2EILPy5/sGGetNyJWoYsURB/I3bW9OyCLRie5OuqH7aXrbtDmd4t80uEY2LU95kBoCfyScd2JWyN8pDZS0jjsf0DSl4gGlBm08IOHUpzx1Gibs/V8L01f49LzN3UXGWI0e4tCmgoA+v7/T27HHNcZluLmTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+6GaM5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E683C4CED6;
	Wed, 26 Feb 2025 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740588287;
	bh=wmmdXB84NfFshKKaz33rSra6NHIGRZEKRnRRJQgidw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+6GaM5Y5AAanbXXu9piTxj7lAcADLu94y4AgXPS6rNmunnLa6s/zTjwhjJ3lDmYj
	 VQB7UGKvDGgmUZslA7cwr9tHec8Knqqs6hsc8KoQBssUdRZGppVT9AgvOu1MIFAP7G
	 a0ZtBBSDO8lbEUQ0M3+kV14ZhkFCi7a9cSUNHGROKYlZMa+PxmuKhoMYcvy72PVXto
	 mEQd2n4tnJnNv3od25M1JSn/Frk8Vu4LRpaLDetcTBUtyksCQ30EnxFYLBoNl5gh8z
	 6pvtgb2mH8Cg90Em+ZUpjDzlcCnaUZj7+QiPL2dQvs0qAYjF4Hy4QG+dlZton4+kIp
	 X3vVuJ2as09yQ==
Date: Wed, 26 Feb 2025 06:44:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] workqueue: Always use wq_select_unbound_cpu() for
 WORK_CPU_UNBOUND.
Message-ID: <Z79E_gbWm9j9bkfR@slm.duckdns.org>
References: <20250221112003.1dSuoGyc@linutronix.de>
 <Z7iSboU-05uMJ7-e@localhost.localdomain>
 <Z7iuUObJGgZtsaJe@slm.duckdns.org>
 <20250226161847.eYrJFpIg@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226161847.eYrJFpIg@linutronix.de>

Hello, Sebastian.

On Wed, Feb 26, 2025 at 05:18:47PM +0100, Sebastian Andrzej Siewior wrote:
> > That's API guarantee and there are plenty of users who depend on
> > queue_work() and schedule_work() on per-cpu workqueues to be actually
> > per-cpu. 
> 
> You mean queue_work(), not queue_work_on()?
> Even with the latter you need to ensure the CPU does not go away and
> hardly someone does this.

All variants that use per-cpu workqueues.

> >          I don't think we can pull the rug from under them. If we want to do
> > this, which I think is a good idea, we should:
> >
> > 1. Convert per-cpu workqueue users to unbound workqueues. Most users don't
> >    care whether work item is executed locally or not. However, historically,
> >    we've been preferring per-cpu workqueues because unbound workqueues had a
> >    lot worse locality properties. Unbound workqueue's topology awareness is
> >    a lot better now, so this should be less of a problem and we should be
> >    able to move a lot of users over to unbound workqueues.
> 
> you mean convert each schedule_work() to schedule_unbound_work() which
> uses system_unbound_wq instead?

Yes and adding WQ_UNBOUND to custom per-cpu workqueues.

> I would really like to make it default because otherwise most people
> will stick to the old function and the "convert" is never ending.

We can rename APIs too and it's going to be a slog, which, to be fair, this
is going to be no matter what.

> > 2. There still are cases where local execution isn't required for
> >    correctness but local & concurrency controlled executions yield
> >    performance gains. Workqueue API currently doesn't distinguish these two
> >    cases. We should add a new API which prefers local execution but doesn't
> >    require it, which can then do what's suggested in this patch.
> 
> I see. So we get rid of the old naming and have them something like
> 	schedule_bound_work()
> 	schedule_unbound_work()
> 	schedule_hopefully_local_work()

If we're renaming, I'd deprecate the schedule_*() interface and always use
queue_*() and maybe:

- Replace WQ_UNBOUND with its complement WQ_PERCPU.
- Add WQ_PREFER_PERCPU.
- Rename system_wq -> system_percpu_wq.
- Add system_prefer_percpu_wq.
- Rename system_unbound_wq -> system_dfl_wq.

> ? The last one would attempt the local CPU for performance reasons
> unless the CPU is not part the workqueue' cpumask. So the difference is
> that the middle one would be queued on WQ_UNBOUND while the latter might
> be queued on a different CPU but on WQ without WQ_UNBOUND. Both would
> respect workqueue' cpumask.

I'm not sure allowing queueing on per-cpu worker on a different CPU would be
all that useful. Might as well just turn them into when necessary.

> > Unfortunately, I don't see a way forward without auditing and converting the
> > users.
> 
> So tried to pull the "in WORK_CPU_UNBOUND the has unbound" card and
> comment where it says "prefer local CPU" card.
> We have already different behaviour with queue_delayed_work(,,0) vs
> queue_delayed_work(,,!0) but this does not count here?
> I don't insist in doing this always, just if the CPU is "isolated" as in
> not part of the workmask. But then, this path gets probably less testing
> so it might be not a good idea if something relies on but does not know…

It's a correctness issue. We can't change the gurantees without auditing and
transitining the users.

Thanks.

-- 
tejun

