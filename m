Return-Path: <linux-kernel+bounces-398370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD749BF06B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4733283A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A10201278;
	Wed,  6 Nov 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CI/Yi4Hb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77261DFE38
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903621; cv=none; b=YIHZ6se3x+rqNMFPUoMpv2oA9C2u3/qlBgc+VoEft3CBw0uxGbeHAdnhmOPtgVA7ETCTdqmzOu5QX3OJ4DgIg7FiPBhgZY1XJbKiOAq37j9SJgjSH0rZdxgPWRwRGvztqwIQel0qUklMl9+j++iBc2M3Md1tYCDCnAP0u36yi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903621; c=relaxed/simple;
	bh=iYhkkz4ZZSsqN3PVoAA0hITR5OCwwxu9vemuepTxeeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrUm1K9K2dsnKuHjYGCOA9SHAyKeZAeq7+xYAGAcQvarnqAxEV2LnngSGc+hCQkhMgXLu372QcpuZSVFgAO9YWdTKpQAr9yzEt1vVRlEpy3aONcZaEDEoVEu/mxinrtAaudJX4S3Ltfyh9ffeYZEtdxXEmEoFs+B9wLGklsrw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CI/Yi4Hb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=peLLNhP2JQATBaaZ9fjicMDqNuRIg6fbneMMxCXO7CI=; b=CI/Yi4HbrDWJ9h3uvmuQxhx0Qd
	oVSAjKhLBpM0XoEqUn2fjITys2yT9PFLYN3wLlmQNW1T+PKQEuKlhSneUH965MLE65DaAy496XIrM
	swvVXYK5Tu8d5iWF9JC+pejy2THnUvbOJXzUSfeFibG7ZqSnf2SJcgt85MQwUVPQ0/gU07itiQ2Br
	GmveaEECXlChQsIFzlowDDXyBfc39dougSKGhH+dXyoabewvE/BK0+6p7obdLSCZ4FGFnGjwbrMIw
	jvuSNoiom+vkskZHLvIPL4un8St8YIgcZn1ZCABpTqs80OQSfn4tLUlmOZk2cgI4YfMNTwGZCggj4
	nGNwJ11w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8h69-0000000ByVy-1USq;
	Wed, 06 Nov 2024 14:33:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 97F74300478; Wed,  6 Nov 2024 15:33:28 +0100 (CET)
Date: Wed, 6 Nov 2024 15:33:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241106143328.GM10375@noisy.programming.kicks-ass.net>
References: <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
 <843833bfb0fe7ac12e7b2314aa9debfe066c6bba.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843833bfb0fe7ac12e7b2314aa9debfe066c6bba.camel@gmx.de>

On Wed, Nov 06, 2024 at 03:14:58PM +0100, Mike Galbraith wrote:
> On Wed, 2024-11-06 at 14:53 +0100, Peter Zijlstra wrote:
> > 
> > So... I was trying to make that prettier and ended up with something
> > like this:
> 
> Passing ENQUEUE_DELAYED to dequeue_task() looks funky until you check
> the value, but otherwise yeah, when applied that looks better to me.

Yeah, it does look funneh, but we've been doing that for a long long
while.

Still, perhaps I should rename the shared ones to QUEUE_foo and only
have the specific ones be {EN,DE}QUEUE_foo.

