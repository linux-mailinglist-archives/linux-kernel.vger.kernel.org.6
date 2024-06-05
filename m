Return-Path: <linux-kernel+bounces-202984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7485C8FD442
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FFFB23A36
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8743F13AA47;
	Wed,  5 Jun 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R1h7ZkKD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090213B58F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609533; cv=none; b=GEKPl3ECL4BiedO8Jl1uKC4M/bb+Z3UcgNBj4Be3o6+zPmjjfeN27DgkwQrL9IYkRYMbQS7ZibxGXOpW3UGxI3BAM9+n6rSvBtrqyv9ZgrTG75I5K3wYpvvxmM7Otgy+rAuZe6AU6SFposN6mbTwDig6Wy1SBm0QhAYNEn/CPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609533; c=relaxed/simple;
	bh=cfDXBiHcAgkf+70g6+M12g81o9le+UulmANraU6DG4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHa1pwEVitfSTKy+nYkMRSFaFTeWPxtWe8j/MIgsGMHMYuZXFe6bjUyKsXXpWNsnUmB3HMpwK0RjTD8Vmm9drO+Gt1ypOWD5KzDZjY9LKHxdv++0Ols1S6/oxZRvzW5AUsabsBFsFP/c+bGPf7p1zs9r2NtCF3sJcVjhQ8gAeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R1h7ZkKD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VlzINK+QpsDFxMx2kaj/f/JTkuH3IRx1hsHjKwSce7k=; b=R1h7ZkKDgug+lc/Kv/yohIWeYI
	nSE4lLUK65HkzWDEqLWhPgis7zcpws4cQgcTrACFrsD8vhh7mtrHvOmI+yflu3OtbiXVQd2aMtewv
	yIbpOmMoW3J8bTRvj5NWuql+Wx5diIm1Ntj47zY6R5/PhsZrdGIKowLRbvRS7XsIYciBaWKKqxCsU
	jyAowxfHEyjyoGtRm3CMZzel00wjv2uh5pNak/2Gh1LI7dGWrQBo88wY4PAkdHox6sCVrt+5q0ja+
	yZTz3rDuwmj8Dt2aco3ik/dNw0M0eT25nxqRi1gMoRV3kQm44UhGIu0a/1TcfUfG/X2eLHTz8lwkA
	ebQiZCpQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEuhM-0000000FosK-0Zcu;
	Wed, 05 Jun 2024 17:45:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F03E30068B; Wed,  5 Jun 2024 19:45:16 +0200 (CEST)
Date: Wed, 5 Jun 2024 19:45:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, torvalds@linux-foundation.org,
	paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
	juri.lelli@redhat.com, joel@joelfernandes.org,
	raghavendra.kt@amd.com, sshegde@linux.ibm.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
Message-ID: <20240605174516.GA8774@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <ZmCH8vH6VRdYHZWs@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmCH8vH6VRdYHZWs@google.com>

On Wed, Jun 05, 2024 at 08:44:50AM -0700, Sean Christopherson wrote:
> On Mon, May 27, 2024, Ankur Arora wrote:
> > Patches 1,2 
> >  "sched/core: Move preempt_model_*() helpers from sched.h to preempt.h"
> >  "sched/core: Drop spinlocks on contention iff kernel is preemptible"
> > condition spin_needbreak() on the dynamic preempt_model_*().
> 
> ...
> 
> > Not really required but a useful bugfix for PREEMPT_DYNAMIC and PREEMPT_AUTO.
> > Sean Christopherson (2):
> >   sched/core: Move preempt_model_*() helpers from sched.h to preempt.h
> >   sched/core: Drop spinlocks on contention iff kernel is preemptible
> 
> Peter and/or Thomas, would it be possible to get these applied to tip-tree sooner
> than later?  They fix a real bug that affects KVM to varying degrees.

It so happens I've queued them for sched/core earlier today (see
queue/sched/core). If the robot comes back happy, I'll push them into
tip.

Thanks!

