Return-Path: <linux-kernel+bounces-575975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B7A7098E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A631735A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1911C6FEC;
	Tue, 25 Mar 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwLdOj3L"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9D13633F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928290; cv=none; b=grSpsrIgRsZTyhfNV/gp1u6bUCNi+GJBx/BRR7YFpS8xEHSEdMuxsbWz0dzPWvISdGO6kdKvqvj87lLsyIMiTbb1yxc9e4jLb5RYA0DKbMjs9apVW/HopnOGgyhlozRxEAyHG/A/Q7UNCHtDClHM+LPlh8Kb0nO6qPlhj0ur4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928290; c=relaxed/simple;
	bh=olIxRGmiA18On6j0TKZgV9L20BnBdZDSVxW9Xv6z5pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp2kHs3m1a9C78cpYU3ReuoMhFzoak0451mdBIUW133HPTuwQF29HqRPzg80DeRmk2YuC5RfIdMPsSvjwbwMBOrxjNIb2sH7vIlHH7Ya/k1mV8pyVL2le1PA3b+CkUh2YQqP0bH/v+0iq4iFR3s0cdm/Osvj0czmq9XvcKQuY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YwLdOj3L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4xxiTEwAsuvrp40FFgSetmTuIJM8iMUCWyB++M5be/g=; b=YwLdOj3Lk7WhZnJPYKnPlZ7BYR
	OGVFSiCJK9Tc3vNQB9xOI4/Hg39gaY45Hpj28+we/6FEL5E2UJkMlU+0GNXZM0DUhf8UXFr2PxraB
	tBFZs80yj2Qr1TwPD3SUa+hz8WJGeT/Dq7+D16yg98SYe+TcFXV2RXXSmU0/K9/MXgOCbjyfGPiWV
	xvPZ3Ga+39RXYdXqLLlrvBE0s08lStkZOZhXcW5dGCZZLJpDfE6DqN9rAiqgUu6Kt5gG6tYrLiUhk
	UcpqisJtr1niMSThvng8RkovjmVZg41FK7N1uMhLUxUJKkbj8nPdoQBiDNxP2JhJFa1lv2GUolRI3
	/UO+oDyg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx9GI-00000008kOU-2a91;
	Tue, 25 Mar 2025 18:44:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7333A300583; Tue, 25 Mar 2025 19:44:29 +0100 (CET)
Date: Tue, 25 Mar 2025 19:44:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
	gautham.shenoy@amd.com, mingo@kernel.org, kprateek.nayak@amd.com,
	yu.chen.surf@foxmail.com
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
Message-ID: <20250325184429.GA31413@noisy.programming.kicks-ass.net>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
 <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>

On Tue, Mar 25, 2025 at 11:19:52PM +0800, Chen, Yu C wrote:
> 
> Hi Peter,
> 
> Thanks for sending this out,
> 
> On 3/25/2025 8:09 PM, Peter Zijlstra wrote:
> > Hi all,
> > 
> > One of the many things on the eternal todo list has been finishing the
> > below hackery.
> > 
> > It is an attempt at modelling cache affinity -- and while the patch
> > really only targets LLC, it could very well be extended to also apply to
> > clusters (L2). Specifically any case of multiple cache domains inside a
> > node.
> > 
> > Anyway, I wrote this about a year ago, and I mentioned this at the
> > recent OSPM conf where Gautham and Prateek expressed interest in playing
> > with this code.
> > 
> > So here goes, very rough and largely unproven code ahead :-)
> > 
> > It applies to current tip/master, but I know it will fail the __percpu
> > validation that sits in -next, although that shouldn't be terribly hard
> > to fix up.
> > 
> > As is, it only computes a CPU inside the LLC that has the highest recent
> > runtime, this CPU is then used in the wake-up path to steer towards this
> > LLC and in task_hot() to limit migrations away from it.
> > 
> > More elaborate things could be done, notably there is an XXX in there
> > somewhere about finding the best LLC inside a NODE (interaction with
> > NUMA_BALANCING).
> > 
> 
> Besides the control provided by CONFIG_SCHED_CACHE, could we also introduce
> sched_feat(SCHED_CACHE) to manage this feature, facilitating dynamic
> adjustments? Similarly we can also introduce other sched_feats for load
> balancing and NUMA balancing for fine-grain control.

We can do all sorts, but the very first thing is determining if this is
worth it at all. Because if we can't make this work at all, all those
things are a waste of time.

This patch is not meant to be merged, it is meant for testing and
development. We need to first make it actually improve workloads. If it
then turns out it regresses workloads (likely, things always do), then
we can look at how to best do that.


