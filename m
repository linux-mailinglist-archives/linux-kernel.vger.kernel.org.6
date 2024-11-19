Return-Path: <linux-kernel+bounces-413984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9540C9D2170
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3656DB2031E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D215AAB6;
	Tue, 19 Nov 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIqgsC9H"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F3192B83
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004268; cv=none; b=d2YVm3pJ7r2e2l8AJkiUyVzw0TxAW3dcJybiILcxcX53zj9rfa9/IJ5mzDlv40jrBlbuZqSM/DGcUz+wQTeQeAUSoK8BxeJSFVdnmOK0tbISoNHpWE7S4WhxNmmEOcPkElDx4QrwbK1f4ueOYpJ3c0dnsbKee8kkwS+FIs/jZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004268; c=relaxed/simple;
	bh=JGsKg0Y//a+6/OtNA48t1erkYbvx2zoHi2Qdtx+y70M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7mxt25oW7KSRnreDdyIphaK7dyQOApp7YCc0h1YOYM7pHwVnslBRm+ol8c/jedGVFOzJ9sTilEgA9w1nSj2PH2Yv+/dpGGRar6cGDXbsYc6CHjzUmxCDidgCGgvYCO/vPYZai779AMjNGPRnThRmmTkpfPCAXGBm94HvE9doOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UIqgsC9H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aJ06wAJbxVin/3zIo5W6b25bIbV8WLoYfZ7KkRo1ZfM=; b=UIqgsC9H8mFywrppKs+31MO7oe
	qi+KmMEf4f+r4xn+kSrKlPTq465J4RQGXalZvIJW6CEAYVVtrSJg2J3OoSGBYec3xUNx9gSrvVep8
	9ewLQ3b6U4/Q2MH7qP4UB9tmTAzz36rUWLvqJ5mxWS2Cuwu0Z0Y6cW5HMflC0cP7voFXbBVVIZsLx
	Z4Yh3LW4CgY2LIvcSJBpboeE3JiACHVYDf8N+Q7qLhfRk+WgHcGgjctEazjthuBkHPsgstYc8z7UK
	Zja48SxzxWU3xVGEnJahQEkgxrTEafhCLKsB85iISOKs/o18ZGRLjvmqM7+NIVsDLSn9+2s5G0uQq
	tEs4HbRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDJQa-00000003rwW-1ZMr;
	Tue, 19 Nov 2024 08:17:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D7D7B3006AB; Tue, 19 Nov 2024 09:17:40 +0100 (CET)
Date: Tue, 19 Nov 2024 09:17:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] sched_ext: Manage the validity of scx_rq_clock
Message-ID: <20241119081740.GB11903@noisy.programming.kicks-ass.net>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-3-changwoo@igalia.com>
 <20241116193235.GQ22801@noisy.programming.kicks-ass.net>
 <494b8851-ba5b-4205-bea0-dc504c2ffa33@igalia.com>
 <20241118094100.GG39245@noisy.programming.kicks-ass.net>
 <9a2bfe0d-3a1d-4917-bf10-33259c79a3bb@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2bfe0d-3a1d-4917-bf10-33259c79a3bb@igalia.com>

On Tue, Nov 19, 2024 at 10:19:44AM +0900, Changwoo Min wrote:

> > What's the purpose of that flag? Why can't BPF use sched_clock_local()
> > and call it a day?
> 
> Let's suppose the following timeline:
> 
>   T1. rq_lock(rq)
>   T2. update_rq_clock(rq)
>   T3. a sched_ext BPF operation
>   T4. rq_unlock(rq)
>   T5. a sched_ext BPF operation
>   T6. rq_lock(rq)
>   T7. update_rq_clock(rq)
> 
> For [T2, T4), we consider that rq clock is valid
> (SCX_RQ_CLK_UPDATED is set), so scx_bpf_clock_get_ns calls during
> [T2, T4) (including T3) will return the rq clock updated at T2.
> Let's think about what we should do for the duration [T4, T7)
> when a BPF scheduler can still call scx_bpf_clock_get_ns (T5).
> During that duration, we consider the rq clock is invalid
> (SCX_RQ_CLK_UPDATED is unset). So when calling
> scx_bpf_clock_get_ns at T5, we call sched_clock() to get the
> fresh clock.
> 
> I think the term `UPDATED` was misleading. I will change it to
> `VALID` in the next version.

So the reason rq->clock is tied to rq->lock, is to ensure a scheduling
operation happens at a single point in time.

Suppose re-nice, you dequeue the task, you modify its properties
(weight) and then you requeue it. If time were passing 'normally' the
task would loose the time between dequeue and enqueue -- this is not
right.

The only obvious exception here is a migration.

So the question then becomes, what is T5 doing and is it 'right' for it
to get a fresh clock value.

Please give an example of T5 -- I really don't know this BPF crap much
-- and reason about how the clock should behave.

