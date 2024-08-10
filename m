Return-Path: <linux-kernel+bounces-282025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104D94DE92
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989AF1C20D43
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1213D512;
	Sat, 10 Aug 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLtQbXPA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0871381BA
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723322757; cv=none; b=Gf1S7dg+IyyAz1LGl9bwIjuBcIKfUDol8KwWSR+cHqGWcdBGkXoFBzaKeo9FWagX+FI5T/SZKJ938e7IFbV6eJpdwfTyq4jFdkSG625aoUyaQYtmmZY2G4CFoPEsolGFv6dhl1jbdbZ1rcIMwwDfU36Rp5YmUjqKvcTQxFC/Bh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723322757; c=relaxed/simple;
	bh=d8huKyiUI7JCX9l9KEZC1tHcCmhaf1ajD1lXLOp9Q38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1yH8rvI8tW6H24aLb4YzjSYTM6NxYNEcXDRzqzPRqXQmY0IgI4ZJwS7Ce/dNtIONyio0rB4IdMgKZEjy5xt2s2FPyxS/gxmOKvOmRe+nQeUajGFHVNxQdScWtNOSy3XoIgOLj2KOaT4iusyYq6+7KnDb+wDFj4NVtldeQ1Ahjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fLtQbXPA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IVIXeCl0FYncKg58jPRc2oTSMm1XYf38TAxCRLMXzU8=; b=fLtQbXPAe2C8ScPQWjbL7uVAEq
	1mmn1EuJCFiKM6B9yURVMn1DA4rRf7Z8KgN/C2qs47q9a0Au2YK6Li1NuVZMpccvwb6GpdoJJAQbE
	hZccNWLgzVd3kr+TgyR8MnM+FhMzhzJP0ITMyy00unpO0aWs4R1K31cssftWccQE03+P+yPHZ6308
	ndaqMIr0szRswUulp8/DAV4H2+KsK6TMHLkVj1mZ+mMFa4iZUL7fytcHS2uiSC0sAVgVyTLo2uW+u
	qatUm+f524W04FdYNvaatNbAzPvRKLbJEeA2PcQ6wH6d4P0oRlcSu/qJffbvcW8aZsD03X1RLDp8V
	C/f787fA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scsy7-0000000Ci9G-2Oej;
	Sat, 10 Aug 2024 20:45:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3104B300729; Sat, 10 Aug 2024 22:45:42 +0200 (CEST)
Date: Sat, 10 Aug 2024 22:45:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240810204542.GA11646@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240806211002.GA37996@noisy.programming.kicks-ass.net>
 <ZrKW2wZTT3myBI0d@slm.duckdns.org>
 <20240806215535.GA36996@noisy.programming.kicks-ass.net>
 <ZrKfK1BCOARiWRr0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrKfK1BCOARiWRr0@slm.duckdns.org>

On Tue, Aug 06, 2024 at 12:09:47PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 06, 2024 at 11:55:35PM +0200, Peter Zijlstra wrote:
> ...
> > > > And the above condition seems a little core_sched specific. Is that
> > > > suitable for the primary pick function?
> > > 
> > > Would there be any distinction between pick_task() being called for regular
> > > and core sched paths?
> > 
> > There currently is not -- but if you need that, we can definitely add a
> > boolean argument or something. But I think it would be good if a policy
> 
> Yeah, SCX might need that.

Right, patch is trivial ofcourse.

> > can inherently know if curr is the better pick.
> > ISTR you having two queue types, one FIFO and one vtime ordered, for
> > both I think it should be possible to determine order, right?
> 
> It is tricky because the kernel part can't make assumptions about whether
> two tasks are even on the same timeline. In the usual scheduling path, this
> isn't a problem as the decision is made by the BPF scheduler from balance()
> - if it wants to keep running the current task, it doesn't dispatch a new
> one. Otherwise, it dispatches the next task.

But I have a question.. don't you clear scx.slice when a task needs to
be preempted? That is, why isn't that condition sufficient to determine
if curr has precedence over the first queued? If curr and it is still
queued and its slice is non-zero, take curr.

Am I missing something obvoius?

