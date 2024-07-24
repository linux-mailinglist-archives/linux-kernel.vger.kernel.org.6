Return-Path: <linux-kernel+bounces-260749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C089993ADB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3632FB22BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F488535A3;
	Wed, 24 Jul 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUYRSnM4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA710535B7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808092; cv=none; b=hnIZvxRdebCgbNFaxObazIxSttIvhSPszuIxWyVbntXPcA4vXLaidB0nYR1y+oavcK8QAyAFiMlYWT4Q0HiEJk7J2ZTH2lGkHzVIkB4LPL6izZvfJxuVBrmbF1eS3YjetSZrfNE+QHLP6CkP0zanUxkdpjb1EhKOpdHMvLS6ytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808092; c=relaxed/simple;
	bh=Z+889juYrfNeXphvp1+q37Z8MRBKQMhCMKbVBgjRiGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwBhkkeZQZFZVo1hHNt222E7u2GYIB4MeGmXFTK0LqDmOZYCrLt+Q+VTEsu0c5s5JDaPIg40fI1YlBwfYDIbltAZgPQo+82k5CqlgErz4PD2lHTAOMi2b6xDlJ62wwxRik0LmxXo4GJAghYL98VOUbt1T1XVGMa64EzRKsjYOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VUYRSnM4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3MjOTFPvQekKBowTg5GNxQGbi9GPv00Qw2b5IGsqKRA=; b=VUYRSnM4a5INhMqhtZ/LAsVx/R
	6qGr+9icLQNjD+Zzb9W7AigAMNYa0taiS6hWPz8svhPx2AkGnur+LII/joNEYfqNnLiR2s/eDqmF1
	ii4zHy/LWr962H0V4xTMoqtYPalsAeJFfSzVYyQ/vpSd3Zt3EqLgACQdiGsf3E20YuEtPN5yorSZl
	W3PDH0qLVYU96ynqdaJ0D+dktuMG7VeRSbicCCev69n+sgzY/irEy9RFBZ1zKXq71ojACXSGM0m0G
	tpEKRYWWmvqgBeLl1p/KNWYe0nOr7DQG9eh8S3hB+Ejk+FpxBnVwm/z9UHIwWkeshs9BTGbxFowcC
	p2umuMsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWWvu-00000007dq4-1fUI;
	Wed, 24 Jul 2024 08:01:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 50EBD3003EA; Wed, 24 Jul 2024 10:01:09 +0200 (CEST)
Date: Wed, 24 Jul 2024 10:01:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v3] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
Message-ID: <20240724080109.GN26750@noisy.programming.kicks-ass.net>
References: <20240720031928.406540-1-zhouchuyi@bytedance.com>
 <d4ac0022-5ba4-44b9-ac09-4530a18b0974@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ac0022-5ba4-44b9-ac09-4530a18b0974@arm.com>

On Tue, Jul 23, 2024 at 10:47:22PM +0200, Dietmar Eggemann wrote:
> On 20/07/2024 05:19, Chuyi Zhou wrote:
> > nr_spread_over tracks the number of instances where the difference
> > between a scheduling entity's virtual runtime and the minimum virtual
> > runtime in the runqueue exceeds three times the scheduler latency,
> > indicating significant disparity in task scheduling.
> > Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed its usage.
> > 
> > cfs_rq->exec_clock was used to account for time spent executing tasks.
> > Commit 5d69eca542ee ("sched: Unify runtime accounting across classes")
> > removed its usage.
> 
> I was under the impression this commit removed
> 'schedstat_add(cfs_rq->exec_clock, delta_exec)' from update_curr() by
> mistake?
> 
> That's why I sent out this patch back in May:
> 
> https://lkml.kernel.org/r/20240503104605.1871571-1-dietmar.eggemann@arm.com
> 
> to add it back.

Probably an accident yes. Is that exec_clock thing useful though? I
mean, I don't much care either way around.

I had a previous version of this patched lined up, but its easy enough
to press 'dd' on it.

