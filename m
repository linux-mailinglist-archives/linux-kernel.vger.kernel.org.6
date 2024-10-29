Return-Path: <linux-kernel+bounces-387659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E43F9B543A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840BAB22D22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5561D1DDA31;
	Tue, 29 Oct 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdxRA+0S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF149208968
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234399; cv=none; b=FszT7n73AzBBnN9CtrTJ1lJpUF3I///pAwVsuOOkyGV1quH40Y7qS9wQwGOOmIUXsgd4GcpTwv3nMWrXDu600DMSVdypdi83fFsuJ8eSSzrfmChe2Z5vv3EMYOxu0ddhfLZmYBjj9q0gsqhdA3fmnnAGKZP5yEwTSkLN0i8DaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234399; c=relaxed/simple;
	bh=pZg9VCG1qxgWdUMyr7+7NAuse75P5HHmtd4lmWOqCn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK/d7tsSJbREIEFnDe5NGDwsNcVkYcRUzIjhWiMQSXABWuFOiKivGuu7GZDuQipSZBDHfr3YdbsyG9DkcQIukaRTcWE2RlN6y/le+1Qf2mu4ha8H6GBid3WUlXWYbZv6Fv9QOqm2TuMKn6KqNH8hpIkTaGhTLHJCF5qAZvCkKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdxRA+0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AEBC4CECD;
	Tue, 29 Oct 2024 20:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730234399;
	bh=pZg9VCG1qxgWdUMyr7+7NAuse75P5HHmtd4lmWOqCn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdxRA+0SPUvmH4LA+FU1kcDLNNKsMAD8+25uWfRk+x80eIZpsQssNwBJ6FDsurILH
	 lb66h6n4Pj3UVZLqaNAjUavlrRhf492fMVZzJiN8TIGJcdhiqKjMV2RpkPOgs6Iamd
	 CZHZqgSqTYODmxq5rf4uNJgHe1WTkoInFlOmuMHa1pYw9HnyVPjcEXEMjZWn0iVOOl
	 n1L5uBPJO+FPP9pMt4B0+UODOR4vObUtgCfXSJL8bSukHNBWIZB9qTxoxpkM5g1tZE
	 NmAeLcOxQ5ZlaUcnUnjLeoQNpc/lNtNC8Vx9uC/6vO7GQaJZc7YfTf2Prz5OhHQUXC
	 W3zpNDgiV9r7g==
Date: Tue, 29 Oct 2024 10:39:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH 2/2] sched/eevdf: Introduce a cgroup interface for
 slice
Message-ID: <ZyFIHrpq1F8G0Tv1@slm.duckdns.org>
References: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
 <20241028063313.8039-3-dtcccc@linux.alibaba.com>
 <Zx_LwYshJV5LERm9@slm.duckdns.org>
 <ddfca6ac-f7a6-4b51-80e8-2e422de7d597@linux.alibaba.com>
 <ZyB-QdXryezwSswB@slm.duckdns.org>
 <cbc64062-f657-4163-9da2-6ed7414d20a7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc64062-f657-4163-9da2-6ed7414d20a7@linux.alibaba.com>

Hello,

On Tue, Oct 29, 2024 at 02:49:51PM +0800, Tianchen Ding wrote:
...
> At the same time, the user may want to decide his processes inside the
> container. He may want to set customized value (sched_attr::sched_runtime)
> for each process, and administrator should not overwrite the user's own
> config.
> 
> So cpu.fair_slice is for preempt competition across cgroups in the samle
> level, while sched_attr::sched_runtime can be used for processes inside the
> same cgroup. (a bit like cpu.weight vs task NICE)

I see. It's setting the slice for the task_groups. I'm not sure how much we
want to codify the current recursive behavior into fixed interface. Besides,
it's not sustainable to keep adding scheduler tunables to cgroup interface.

Thanks.

-- 
tejun

