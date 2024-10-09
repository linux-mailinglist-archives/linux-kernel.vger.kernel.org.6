Return-Path: <linux-kernel+bounces-357848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4FE9976F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC65D1C232BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D2D1A3BC3;
	Wed,  9 Oct 2024 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifrnHuck"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7D40849
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507151; cv=none; b=V7K/8AZmc6UHMv7eHr5UAXIfEDaT/rd6x/tG9QifQFsHvObV0AtxkPcMKJPybI5s43W4Lfjp5mFKtpaqBOcDydQSzAWutz7VmNuNLI/1yWxIvZWgA1yE3pZmSMas1h2OOXGzQdewTaqMA3ahJo+RTfhcx5rMfQIa+okFTAEADdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507151; c=relaxed/simple;
	bh=hhg17eZvF+6oL9OgO98UerfxhRhYYUVTQeDaUphtTAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdLaLTUFPfeh/G9GuCj6uB4yovzQxBxtSz2OfNHTl/axBc+PFVaWNyHJIrrrdpmgvsqagYb0qcRRUzbKKrRXyR3COyhxcpWP9+OnUGnfM5r0OnYxQc8+6yOUwu2x6E6VCwropjd6tkbxiSQ5NAXizKXgHovGXOc1o+t9ugWlX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ifrnHuck; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DFZwQRcsg5n+KmIUzAnEBnwerEReRX5a9ITiwmryWrc=; b=ifrnHuckN15J3mTe1AycDaPhHB
	fQ2LejjTYD1LwBmfmzY5aYSm/akWBcFpWgo/Jb4WqapyvmbzAxCElrcwi3fLdno+RokTOVBSPEzka
	TdlGnYhhyLddt7NYk+7cNDYyVppw/yUsn+5PmDH47Sfe6jwiaGV87BQUY6U531UnAQU4AszflnNS8
	M8W5nLs2K3uITzCW7hxUokzzGWQSvBVHY0o2ZXhJEJU4U4n0m1Hv599AatqyQzUY2nVu+Xr9UJeVI
	PYTT2n7SmScPHRCQrxlWSYaMWN5t3mnG7Jr78GS8Ijm9TmyOLbx6eNEKhfEJIoeAxF6Qgabo+wKU+
	ksP3GKdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sydfO-00000005n1f-1bjv;
	Wed, 09 Oct 2024 20:52:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 62AE330057A; Wed,  9 Oct 2024 22:52:18 +0200 (CEST)
Date: Wed, 9 Oct 2024 22:52:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241009205218.GW17263@noisy.programming.kicks-ass.net>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>

On Wed, Oct 09, 2024 at 11:24:09AM -0700, Paul E. McKenney wrote:
> On Wed, Oct 09, 2024 at 08:01:17PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 09, 2024 at 09:54:06AM -0700, Ankur Arora wrote:
> > > PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
> > > which allows for dynamic switching of preemption models.
> > > 
> > > The choice of preemptible RCU or not, however, is fixed at compile
> > > time. Given the trade-offs made to have a preemptible RCU, some
> > > configurations which have limited preemption might prefer the
> > > stronger forward-progress guarantees of PREEMPT_RCU=n.
> > > 
> > > Accordingly, explicitly limit PREEMPT_RCU=y to PREEMPT_DYNAMIC,
> > > PREEMPT, PREEMPT_RT.
> > > 
> > > This means that (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), which selects
> > > PREEMPTION will run with PREEMPT_RCU=n. The combination (PREEMPT_LAZY=y,
> > > PREEMPT_DYNAMIC=y), will run with PREEMPT_RCU=y.
> > 
> > I am completely confused by this. Why do we want this?
> 
> In order to support systems that currently run CONFIG_PREEMPT=n that
> are adequately but not overly endowed with memory.  If we allow all
> RCU readers to be preempted, we increase grace-period latency, and also
> increase OOM incidence.  Which we would like to avoid.
> 
> But we do want lazy preemption otherwise, for but one thing to reduce
> tail latencies and to reduce the need for preemption points.  Thus, we
> want a way to allow lazy preemption in general, but to continue with
> non-preemptible RCU read-side critical sections.
> 
> Or am I once again missing your point?

Even without this patch this is allowed, right? It's just a default
that's changed. If people want to run PREEMPT_RCU=n, they can select it.

I just don't see a point in making this change.

