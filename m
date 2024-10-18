Return-Path: <linux-kernel+bounces-371638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9FC9A3DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39ECAB23CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC3F1C242D;
	Fri, 18 Oct 2024 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaaJHnpP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122D26AD9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252723; cv=none; b=Eq4aSZLWlVe8gFNdLaR+warCGAG9deU1RB9xDEd32Sttpzf1GgnBMoZVkI0UffyPJJgu53ZBrLZOcW/3dKeUWIvsCTSShnMNNUnR0+kS5xslAvvzcKqGS275BgWjBlM/cvxn2wBlCAjjzPXowQBMT/VmtQ0S4YCsaLMFyptVatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252723; c=relaxed/simple;
	bh=uju9A75VydgesuV5VJ3zReQUSRiqlBTRNgvmQbRq87Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXV1e/Q8l0pCONY3M7OCydsbNyAj1ZPF8NaLOixpE9ox9EWhGMUCUDDtzEztEiR92AM97ytxBIlLvV7XindSgjRsR6aY91K1N3EdROxo2r8qtR5OoWmxa8XRlFVirUF5uNsaLLP9pk8XZiX2/paKOBDg7K1+ci6z1TrlLEZ4O8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaaJHnpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328EFC4CEC3;
	Fri, 18 Oct 2024 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729252722;
	bh=uju9A75VydgesuV5VJ3zReQUSRiqlBTRNgvmQbRq87Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaaJHnpPDoAyz4yqPckjDJbyHGnUQaOxDPah2u6t6xtQwqZV4Yh+fGDMpsRjyoW4B
	 +kxp47jNpaGncjFqF1y2MGjjt6EVOZgqYQgJKUvjRpKBsz00Jl6dYb2Qk/gZYBruyl
	 1nZhSs0E1NUGdg6ZL/6XLIxMIrRYBhti8YNqfT79dqun+9dIqb8hNQLv6i1W2/2ILn
	 noGG3czYJBURW+AVk+sInB0ApmEsrNDIM46E5yOBvJfuqUhzs03Ch56BL6lj731vVq
	 R3fcY+fW+ba2SbLIurrbbhT532DZo0BPtJLbh/tZbaqGdLm1+OE1EfCiWHxUppBMDO
	 zGbhKF6fWF8iQ==
Date: Fri, 18 Oct 2024 13:58:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Chris Metcalf <cmetcalf@ezchip.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] posix-cpu-timers: clear TICK_DEP_BIT_POSIX_TIMER on clone
Message-ID: <ZxJNb0UNE6yxMNNe@localhost.localdomain>
References: <xm264j5bd2gj.fsf@google.com>
 <ZxDTFmOi0waQFGEX@lothringen>
 <xm26zfn2bifv.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xm26zfn2bifv.fsf@google.com>

Le Thu, Oct 17, 2024 at 01:09:08PM -0700, Benjamin Segall a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > On Wed, Oct 16, 2024 at 04:59:08PM -0700, Benjamin Segall wrote:
> >> When we clone a new thread, we do not inherit its posix_cputimers, and
> >> clear them with posix_cputimers_init. However, this does not clear the
> >> tick dependency it creates in tsk->tick_dep_mask, and the handler does
> >> not reach the code to clear the dependency if there were no timers to
> >> begin with.
> >> 
> >> Thus if a thread has a cputimer running before cloneing/forking, that
> >> hierarchy will prevent nohz_full unless they create a cputimer of their
> >> own.
> >> 
> >> Process-wide timers do not have this problem because fork does not copy
> >> signal_struct as a baseline, it creates one from scratch.
> >> 
> >> Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
> >> Signed-off-by: Ben Segall <bsegall@google.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>  kernel/fork.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/kernel/fork.c b/kernel/fork.c
> >> index df8e4575ff01..b57cd63cfcd1 100644
> >> --- a/kernel/fork.c
> >> +++ b/kernel/fork.c
> >> @@ -2290,10 +2290,11 @@ __latent_entropy struct task_struct *copy_process(
> >>  
> >>  	task_io_accounting_init(&p->ioac);
> >>  	acct_clear_integrals(p);
> >>  
> >>  	posix_cputimers_init(&p->posix_cputimers);
> >> +	tick_dep_clear_task(p, TICK_DEP_BIT_POSIX_TIMER);
> >
> > Yes but we don't need the expensive atomic_fetch_andnot(). Also more
> > generally the task tick dependency should be 0 upon creation.
> >
> > So something like this?
> 
> Yeah, the only other uses are contained in rcu_do_batch and rcutorture
> tests, which won't end up here anyways.
> 
> Up to you if you want to send this or I can send out a v2.

Sounds good, please send a v2.

Thanks!

