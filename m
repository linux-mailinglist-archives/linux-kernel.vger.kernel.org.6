Return-Path: <linux-kernel+bounces-272504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB3945D43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDABB21675
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFFC1DF695;
	Fri,  2 Aug 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VyW0sRxP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D71DF66F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598210; cv=none; b=WFvfKR/PjbWPbQEtKeNVCDFL4TWXTebCs3Nzw2ScyGcpzhbQ+YuvCNd0ntl3Zoph5KMMBszBA3/uMA/ucQ9nCGcscNQpMqMmsyMTQR4vJ0GYbE69t3Ftj3z+B/XBSz+1NVa77RF8ghwKE7FcyQJ0Arxofs73t3B/I4W7Klum42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598210; c=relaxed/simple;
	bh=QsooQlMyoqgdxE/Wr4zS68WyUzTUBfhULabxOdNdLS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjLsEGHt91qfQGUyp/BaFlg3rePla+ReWQOnt01U/AjH18gjBn9U7FpNWnuXjfrIqhrLXMOE2uVqo1ApbQfdMZWqmaIJzPol0Alue1wOtqKZJdzUfTmY6HtAPfryd5O+paswP3MEODkj+0U1cukSF9GgB6Z8lkWNSayL1wlgVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VyW0sRxP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yCEzN1RSmv0If3JnoPB9uROyFaA8GRSimv/i1r/C9fw=; b=VyW0sRxPosmuiT5mJvN7ApHSWW
	L8nDCSuWAhFUpsPqmhmyarLBA7oY381Bi7Q9azfFy6a6NJk5OiAZnTzi6a6+ntDDqyN+EHVtEXZTN
	ZzLNluDHWc6ypqeh7my/FTShNQ71T/GTDwOvvmMZz+HbA7NDqEkxREXU6AtDjDGfXvDeQ0QPUkinn
	3uLHw1QYTueyCSZjgpRgfjiTqrsNgtyP7IypV73eMoylGQusL+h0vFBTDOQ/5eO3FYiGpxXREQdxk
	x/9n40p38JGVoE4I4KtGMSrdUWnc1ov8Fh7eaiKb1bMUX7CzMqh5yXUgdYZIHRc3wTwC4HZQ0dlyO
	6/BCi9hw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZqTq-00000000xgZ-2d55;
	Fri, 02 Aug 2024 11:29:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6460630049D; Fri,  2 Aug 2024 13:29:53 +0200 (CEST)
Date: Fri, 2 Aug 2024 13:29:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [RFC PATCH 24/24] sched/time: Introduce CLOCK_THREAD_DVFS_ID
Message-ID: <20240802112953.GJ39708@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105031.053611186@infradead.org>
 <ZqdKbcu-iyzmr85r@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqdKbcu-iyzmr85r@jlelli-thinkpadt14gen4.remote.csb>

On Mon, Jul 29, 2024 at 09:53:17AM +0200, Juri Lelli wrote:
> Hi Peter,
> 
> On 27/07/24 12:27, Peter Zijlstra wrote:
> > In order to measure thread time in a DVFS world, introduce
> > CLOCK_THREAD_DVFS_ID -- a copy of CLOCK_THREAD_CPUTIME_ID that slows
> > down with both DVFS scaling and CPU capacity.
> > 
> > The clock does *NOT* support setting timers.
> > 
> > Useful for both SCHED_DEADLINE and the newly introduced
> > sched_attr::sched_runtime usage for SCHED_NORMAL.
> 
> Just so I'm sure I understand, this would be useful for estimating the
> runtime needs of a (also DEADLINE) task when DVFS is enabled, right?

Correct, DVFS or biggie-smalls CPUs with mixed capacities.

