Return-Path: <linux-kernel+bounces-285584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C2950FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BA1C22608
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820561AB51F;
	Tue, 13 Aug 2024 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hDmF89uv"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913D1AB512
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589592; cv=none; b=Iqcg0Uitq5sKq6qhBvf3Iz3acNEtatRJA/NFC28wKeFmUrPOf/LRaAfSGuk/sj3T8ECcCPgSMgrYz9SjGtoRrIiZvx+iQ+L8uYpKZ91vPMNCIWdLu4hpt5Li0msSst3cewuW9Ek9lhAG6b/EMQGgUJ/aYbZKbiQkGcBooYuAkfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589592; c=relaxed/simple;
	bh=EqpGSRVeMFK8CiM/UlhWvX7ZYW+u82V9UBcXE9CPwpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG46jiE0jMiNWn3WBx6fDnk//ZtqlG8Jbdv5YpN8PiMfPZl2HPgAlf6rplVOw1Q0QuLBW0mOSpNVgi4BQNzgzosht2H9voEpWk1b6uKZgDoh4+ij3uJ5PzYkmeyVi8ChzUKX/kv0/XZAJjsSYThVfwODgKJDjpSEdf2R48GCrL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hDmF89uv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UpEJmEdQDgPAbGGAVVVZyk7pw6V5fIcc6+BwgVE2MQw=; b=hDmF89uv28pLtHmwLeqtQUua4c
	i9s/VRfbYMYmAoHxWpl0qLVs8xB7xPr8CbdgowfRaQhJIkLRn0QHM4FwubXa0qVJCfcuTs4p7Yttt
	CGJEj6SYRWQFEUM3N6kgPZ7IFq+A7UcT8sdpffRuDbkK31Qrj827FETwCmZvGP7EkdMzr3lZWn+3V
	90Jf9bewEO2j2JsmNt8xqmLZSSM1cNau/52CZ5qPY+lSjNprxSDrKbGJa19EezAIFGNL+zNbkgPkA
	RzSl4pQ4+6+vuWryaMIxrTNuOxngJZBbHxDqFsiDC4f8LcW5VseJxKDHg/+RfJl8buR9MabCTGg64
	ZhT3ay0A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0O3-00000007s3G-35Gi;
	Tue, 13 Aug 2024 22:53:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4928C30074E; Wed, 14 Aug 2024 00:53:07 +0200 (CEST)
Date: Wed, 14 Aug 2024 00:53:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240813225307.GC10328@noisy.programming.kicks-ass.net>
References: <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240806211002.GA37996@noisy.programming.kicks-ass.net>
 <ZrKW2wZTT3myBI0d@slm.duckdns.org>
 <20240806215535.GA36996@noisy.programming.kicks-ass.net>
 <ZrKfK1BCOARiWRr0@slm.duckdns.org>
 <20240810204542.GA11646@noisy.programming.kicks-ass.net>
 <Zruwioj86jQz8Oq6@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zruwioj86jQz8Oq6@slm.duckdns.org>

On Tue, Aug 13, 2024 at 09:14:18AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Sat, Aug 10, 2024 at 10:45:42PM +0200, Peter Zijlstra wrote:
> ...
> > > It is tricky because the kernel part can't make assumptions about whether
> > > two tasks are even on the same timeline. In the usual scheduling path, this
> > > isn't a problem as the decision is made by the BPF scheduler from balance()
> > > - if it wants to keep running the current task, it doesn't dispatch a new
> > > one. Otherwise, it dispatches the next task.
> > 
> > But I have a question.. don't you clear scx.slice when a task needs to
> > be preempted? That is, why isn't that condition sufficient to determine
> > if curr has precedence over the first queued? If curr and it is still
> > queued and its slice is non-zero, take curr.
> 
> scx.slice is used a bit different from other sched classes mostly because
> there are two layers - the SCX core and the BPF scheduler itself. The BPF
> scheduler uses scx.slice to tell the SCX core to "don't bother asking about
> it until the current slice has been exhausted" - ie. it's a way to offload
> things like tick handling and preemption by higher priority sched classes to
> SCX core. When scx.slice expires, the BPF scheduler's dispatch() is called
> which can then decide whether to replenish the slice of the current task or
> something else should run and so on.

Right, but can't we flip that on its head and state that when scx.slice
is non-zero, we should pick current and not bother asking for what's
next?

