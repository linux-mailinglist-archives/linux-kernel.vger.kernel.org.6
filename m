Return-Path: <linux-kernel+bounces-359255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB5C998964
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3234E1F273F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310AD1CBEA1;
	Thu, 10 Oct 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHydz6et"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CCB1CB515
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569963; cv=none; b=T2IhxCgsbx+7bomwPLAylBkbbJWVBYGBeG2CboIon7ETFoXc5Dcc5GRPL2cJcpRgJUsFMuDGBBYrwWemSfI9JmYQ3H+pWzvvjTSuqNg26uR8YF7KSxBCujmXAgmXoK3lu+rJ6TrmxeiT9J3z6mOqdiEZe7k0Un08DakE2evEJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569963; c=relaxed/simple;
	bh=0kHIL1wzwx9Fn03jp/C4vfrlz0J5JRHRkfQEvSeDefc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nhx2j9/+5ekGc/eRBIkDsdHN+YjB3bETewiLziKvBVqAmT3idxWDcDkv4OyVeacvfnEZKi7liXWXQlAicvW5qDto/EtK+nZhEQ2Cu9VqPHUnYV4vRXaRIWHVfIlVGNBUdsnUcrHTDJXGHMtkR1WDVP/uHnqN9eNdxyUuu53pRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHydz6et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDC4C4CEC5;
	Thu, 10 Oct 2024 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728569963;
	bh=0kHIL1wzwx9Fn03jp/C4vfrlz0J5JRHRkfQEvSeDefc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JHydz6etz1iYhtLBIYAsd4GgupSzyjfJYLuiU5aGrtpLyWc/wT8EHHOYgDz/rNSTO
	 Da/J3LtYkPwwxeiPeSLMOsxO0669QiyWF5Y8WvSKMZIM3mBVSO7NybjxI8NvI7iEvN
	 +0CFvmMUkkuPpD/aQaVFc7gw94c7GVoipNs6zBUQP+xXr1Bprq0YDmeEqMNeL7o/+e
	 fxGVNAqUKFl0wCaatU/839m+wa5sXj3wXlJpQFRyxSwnhJUjwM+R2hcvx+FOZKqcdf
	 pS2F0Z44b+Thv/GbAJAjXLU7IDAZD/TH+orNPq19JnDm0o05tFZW6knlIwytTyRzXl
	 x6g/JFat7Y/GA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B264CCE08E5; Thu, 10 Oct 2024 07:19:22 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:19:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <79ac2978-fe01-4af0-a17b-21f01dec05de@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241009205218.GW17263@noisy.programming.kicks-ass.net>
 <28bcac6a-6aee-456a-8022-5eef9ec08eaa@paulmck-laptop>
 <20241010075850.GZ17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010075850.GZ17263@noisy.programming.kicks-ass.net>

On Thu, Oct 10, 2024 at 09:58:50AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 09, 2024 at 02:16:43PM -0700, Paul E. McKenney wrote:
> 
> > Because we don't need a bunch of people surprised by this change in
> > behavior.
> 
> I'm not sure what change in behaviour; Lazy is brand spanking new, it
> will have new behaviour not in line with previous modes. Just put in the
> help text that if you're looking for a reality closer to the old
> Voluntary to use PREEMPT_RCU=n.
> 
> In reality very few people will care, because distros will be running
> PREEMPT_DYNAMIC and the 3 people doing their own thing ought to be savvy
> enough to deal with things, no?

No.

Sure, a number of them have proven themselves capable of debugging back
from an otherwise inexplicable series of OOMs not obviously caused by
RCU Kconfig settings, but why put them through that?  And especially,
why put others through such a "learning experience"?

Why not instead tag the Kconfig help text noting that lazy preemption
does not automatically apply to RCU read-side critical sections, and
that if you want it to, there is a Kconfig option that is there for you?

							Thanx, Paul

