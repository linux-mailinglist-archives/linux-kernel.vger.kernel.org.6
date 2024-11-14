Return-Path: <linux-kernel+bounces-409216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A3D9C894E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A633CB24510
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C51F8F12;
	Thu, 14 Nov 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCYyL0+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED701F80C3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584169; cv=none; b=CeTjC4j4QvVFkLM4pZz9htJ6rdiOCOTa1yPfPz9xIKM7gqaNMj26id9QMR+MoNBWFrO26iB2tMTE2sN0aa9uqq5htf/gFBOpMX94Ga0SCftIHgwzLEtYYwZfpXiv5bD2ondJPgyvAHte2YyqcPqSY1G+Ae7P76pMwRY96GehP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584169; c=relaxed/simple;
	bh=7uEL4gDRTBmKwzVxkKVKiofQtmtbVwc68Ad/q5PPhR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmCphrPCFn1OwQ6trD5KX81l6rKzB1ZGQEm9+Z/hBm9+1uutEhuJuYMXgPn7hMsAP83ld9jruTS9V7BTIcXf36h/lFWqcaoZzCWFHxiupVed0d7MmGW8t9hT80yf+1wZ9e0LLBFP60Bd/g5HtdHRvh5pwBltk+ln++00Phz3ilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCYyL0+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6484C4CECD;
	Thu, 14 Nov 2024 11:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584169;
	bh=7uEL4gDRTBmKwzVxkKVKiofQtmtbVwc68Ad/q5PPhR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCYyL0+vtJaoDaaMKq7okeRw17lNeM+388UGfaf+WCHeFUaiL//J4Esg3y6AMmH/G
	 lf2ysHLbiAO8b7EZ1GqifXF9c57ogecVoIhfTAkP15UGh7NGjC8jd2o7SC/XfBhyos
	 9Dw80QSOl+cFiPS1rZwy5iEq5TWWecOgPRClZlAb1R8lJNKmD4KdpmSq8084KQl5CC
	 vcs3cjDABnBe5jxmb1UKADX5TjiKWvs9yJzMv649+BLZ7qsX7IIydtKrBan5QZ2ZRc
	 hyrL4yyjvL8FeVHGl6U2Pw+JYa1O2bZUGZWxLGikutRHyOhx7rbyhptJLVAbh9MUX4
	 b5BvkudlDhBVg==
Date: Thu, 14 Nov 2024 12:36:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
Message-ID: <ZzXgpv2ywa6rIK5u@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
 <87bjyir7dk.fsf@oracle.com>
 <20241114082534.8Go_kdjY@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114082534.8Go_kdjY@linutronix.de>

Le Thu, Nov 14, 2024 at 09:25:34AM +0100, Sebastian Andrzej Siewior a écrit :
> On 2024-11-13 16:23:03 [-0800], Ankur Arora wrote:
> > > But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
> > > some issues now that the code can be preemptible. Well I think
> > > it has always been preemptible but PREEMPTION && !PREEMPT_RCU
> > > has seldom been exerciced (or was it even possible?).
> > >
> > > For example rcu_read_unlock_strict() can be called with preemption
> > > enabled so we need the following otherwise the rdp is unstable, the
> > > norm value becomes racy
> > 
> > I think I see your point about rdp being racy, but given that
> > rcu_read_unlock_strict() would always be called with a non-zero
> > preemption count (with CONFIG_PREEMPTION), wouldn't the preempt_count()
> > check defeat any calls to rcu_read_unlock_strict()?
> > 
> >     void rcu_read_unlock_strict(void)
> >     {
> >             struct rcu_data *rdp;
> > 
> >             if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
> >                     return;
> > 
> > Or am I missing something?

Haha, right!

> 
> This is indeed broken. By moving preempt_disable() as Frederic suggested
> then rcu_read_unlock_strict() becomes a NOP. Keeping this as-is results
> in spats due to this_cpu_ptr() in preemptible regions. Looking further
> we have "rdp->cpu != smp_processor_id()" as the next candidate.
> 
> That preempt_disable() should go to rcu_read_unlock_strict() after the
> check.

Yeah that looks better ;-)

> 
> > Ankur
> 
> Sebastian

