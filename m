Return-Path: <linux-kernel+bounces-562449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D880A62807
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154BF19C2F38
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209271D8A12;
	Sat, 15 Mar 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hnplweJ7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31D18E75A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742023369; cv=none; b=sQmF+N4zSPjmJ4ScR4vpTO792MPwmxNJViPLbF5CxrRxex2jlRoMNfYF2S1YbOHmAYuB6eJbeGTPCh91n/s3fmyEUjXLnA+nf1SP8i/CHeUIWO4pDP4UAgMyM5qRZuivG5W2kZBAdRL2b3X9rYECoHBY2guFwZkwKE1DGNw0/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742023369; c=relaxed/simple;
	bh=dLbiAJdVJz7bbsQu8yFXRQdfHcFo7iNvcSgGQRyrsTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8q1/wEgUx0tO6ZfFbUQbFB8LHkc4iAGVcF7bDW0p/fqsXOReY/156JisuOCgJ7HBJUU8zkAah0i9IKpovLvtQuUa42NS1E5gLS2k5ermwtd38MYbh6k6W+05muylUQ58AfXyGJgE2t3l5EpscFCYG5BOyeyjOhHZoPJQpeaIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hnplweJ7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dLbiAJdVJz7bbsQu8yFXRQdfHcFo7iNvcSgGQRyrsTE=; b=hnplweJ7b383i4UCAji1NyMuEJ
	q2Yb2RTVJ5+7G21QxvhGVF2QySb9uxp2UkPTerWc0Wd0JsL/42X08rRfQHNS934klb3NHSsYFxoLn
	eo5UbQh/GhempOU8nUW8ec/ZUsqib1qNjgztkp1eOF+/YS+IgcR+wJQrWV3+GL2s7AhVgVeqikCYl
	8Ir+5z4n2eZ1wBOw2IHOjQo46uHCZxC4UU7RS6ouuiJxHA9tcXvYJq7/lxw4ttE6txjiTbYWxFB5z
	ThE99f4x3hAwi2QK73fyoR3+GLuN2pt5jhkOd9qDORqiBxhBORYCvyRAXkxTM78OamqfObxAHAnLv
	/ajjv8Vg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ttLqk-0000000Dire-3Blq;
	Sat, 15 Mar 2025 07:22:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE69E300599; Sat, 15 Mar 2025 08:22:25 +0100 (CET)
Date: Sat, 15 Mar 2025 08:22:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
	boqun.feng@gmail.com
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
Message-ID: <20250315072225.GG36322@noisy.programming.kicks-ass.net>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315022158.2354454-4-joelagnelf@nvidia.com>

On Fri, Mar 14, 2025 at 10:21:50PM -0400, Joel Fernandes wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.

This needs a lot more words on why you need a second server. Because I
don't think you do.

