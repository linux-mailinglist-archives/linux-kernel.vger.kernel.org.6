Return-Path: <linux-kernel+bounces-526069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE10A3F982
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6B70476C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD71E7C2F;
	Fri, 21 Feb 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki7ope2l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976E1D6DBB;
	Fri, 21 Feb 2025 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152887; cv=none; b=UkINqjd4pPQ17S9uV8IIgzjiqLLQ9PxvmhWiEF5XRZ8f2qmVdSl1oFP/xCdaDwbJRIf+sXfPgwcey9hzw2tarHFnwIwSJPIYNkk4/cAknUfBPnyzLrrPT1MuwaVTp7amryEzAUlsoAZjxAX/KsLI0ADHbMUvK4g9kjgtwH3uFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152887; c=relaxed/simple;
	bh=S6G9H35A+wjHnH4iOlH/plIvtqDC5fvfy9TIuQJtanw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr2ZB5C757VsENWBgnV+eoGT/8QWIx9bg6tGf60fWUD+0cZwN0cf/TB7hJqeAvmH/Fh+j3f04Z7M5H1aKUcDwagWL7nwjVYDGd0MR6fMTOcvcpqak3wu0uZ8qIwsazVuZKvH2I299Ymv/kqnpv7x0fQAuWdHNBG2kzwFJANOcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki7ope2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27C7C4CED6;
	Fri, 21 Feb 2025 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152886;
	bh=S6G9H35A+wjHnH4iOlH/plIvtqDC5fvfy9TIuQJtanw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ki7ope2lYFW4lqAWeC6J8p9kco6uzKsU8tAMyPypie5XFX50fKEc39nNCGrjmtxON
	 VWSK8FDuH7UYXP4VoIywBsXEtOzdCPoewZvCgIznoqwQ3q0jD7LQ3Uly6lN97Uamiq
	 /xpQRoG3fpCkHPOi2j8U/kTy9y9mrjFw+UCO3HQE+dILBSNxvFi1+IzuuFEUbONfJt
	 F6VmRIwj6AI4bdmQ111xZCXQsTjFeYGmNKAQhnv4p0NFSHD4DYosZoYV0shaioYdr3
	 uPiyZDVetOTpj7bx5sHPtTq9w1r4cOalj5e/TzdthFr9FSK5IIj23HcNUCXs2PxiSH
	 RlB6SF3EHhqRA==
Date: Fri, 21 Feb 2025 16:47:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, Anjali K <anjalik@linux.ibm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] sched: Consolidate cpufreq updates
Message-ID: <Z7igK4w4PW1T_PCw@gmail.com>
References: <20250209235204.110989-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209235204.110989-1-qyousef@layalina.io>


* Qais Yousef <qyousef@layalina.io> wrote:

> ---
>  include/linux/sched/cpufreq.h    |   4 +-
>  kernel/sched/core.c              | 116 +++++++++++++++++++++++++++--
>  kernel/sched/cpufreq_schedutil.c | 122 +++++++++++++++++++------------
>  kernel/sched/deadline.c          |  10 ++-
>  kernel/sched/fair.c              |  84 +++++++++------------
>  kernel/sched/rt.c                |   8 +-
>  kernel/sched/sched.h             |   9 ++-
>  kernel/sched/syscalls.c          |  30 ++++++--
>  8 files changed, 266 insertions(+), 117 deletions(-)

The changelog is rather long, and the diffstat is non-trivial.

Could you please split this up into multiple patches?

Thanks,

	Ingo

