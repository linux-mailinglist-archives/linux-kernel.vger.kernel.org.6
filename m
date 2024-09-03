Return-Path: <linux-kernel+bounces-312991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929BC969EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BFE1C238C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B11A7250;
	Tue,  3 Sep 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjJ59o++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756441A42CB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369172; cv=none; b=jtTcw3aix+jp4e/IOE1fVMtbH2ywE4gePMXaYiDKtF1xAfZjcOXp8TUO+B8httnfO1NpNeZNb01uus85RYPjnhvsYYwuDPKSsMAQatkOHWW4fr6PIXjUHQZ8V7ALlTxoEH03/ZEMtE3wfIuae4v9Z0zT4YPPPqVM1p1vNR4GaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369172; c=relaxed/simple;
	bh=ybzFF6PxoqiWbZh0xD1WsVz/GY9X1ufOVyY4BYpYfzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7xxj/82awz3mFAfTItBrPuqVzdVfThHxp3oGrpPalf6xoCwqQHj13UFBi4HxsrKHqWi//Q0Tlb5Z8+rR+TTqpMoxADWQY+u1rcTlNECz7TrbbiXTxfrd9o7TlBLz8ar8/GiFwTuvy+/IhTwbS8aN6Z36za1muM+P3MisF+6HjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjJ59o++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F0C4CEC4;
	Tue,  3 Sep 2024 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725369172;
	bh=ybzFF6PxoqiWbZh0xD1WsVz/GY9X1ufOVyY4BYpYfzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjJ59o++BdycaIA6UPN3d4GUeysULsw7e73v0Ytsc16OZ64fbpHLSqULyA34qc5cl
	 /8usqFwtzBL7PO1zKnGLb6wAqGElBQATA/A9HLpoWJAwm9BVQQgk9zsbhegJdK5TFt
	 L86LCc8N5LL5438+COfUp4w+lZasJnOIVeMAOKyj1NOXzWSGssej7E2yLoo9iElGLn
	 zn9FDwnuEJY1FutbVIkpoYr9ybR2Ajfd01SOpfv857pORngve7UrbdCMP1XFS/L0lY
	 qEDJJmGrFgJEU38SAK5o7VsYHVd+wBVyiwYEryZIVXaOzcFGGEhTpdfe4TbNHIJQ+U
	 xLFaKUfHb9dhg==
Date: Tue, 3 Sep 2024 15:12:49 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/fair: Use HK_TYPE_SCHED housekeeping CPUs
Message-ID: <ZtcLUcJvqSV3vXd2@localhost.localdomain>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240818234520.90186-3-longman@redhat.com>

Le Sun, Aug 18, 2024 at 07:45:19PM -0400, Waiman Long a écrit :
> As the previous commit has enabled the setting of HK_TYPE_SCHED
> housekeeping CPUs in nohz_full setup, we can now use the more aptly
> named HK_TYPE_SCHED housekeeping CPUs instead of HK_TYPE_MISC.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Can we instead merge HK_FLAG_TICK, HK_FLAG_WQ, HK_FLAG_TIMER, HK_FLAG_RCU,
HK_FLAG_MISC and HK_FLAG_KTHREAD into a single
HK_FLAG_KERNEL_NOISE / HK_TYPE_KERNEL_NOISE ?

Thanks.

> ---
>  kernel/sched/fair.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6be618110885..0350667f5ce8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12128,16 +12128,13 @@ static inline int on_null_domain(struct rq *rq)
>   * - When one of the busy CPUs notices that there may be an idle rebalancing
>   *   needed, they will kick the idle load balancer, which then does idle
>   *   load balancing for all the idle CPUs.
> - *
> - * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
> - *   anywhere yet.
>   */
>  static inline int find_new_ilb(void)
>  {
>  	const struct cpumask *hk_mask;
>  	int ilb_cpu;
>  
> -	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
> +	hk_mask = housekeeping_cpumask(HK_TYPE_SCHED);
>  
>  	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
>  
> @@ -12155,7 +12152,7 @@ static inline int find_new_ilb(void)
>   * Kick a CPU to do the NOHZ balancing, if it is time for it, via a cross-CPU
>   * SMP function call (IPI).
>   *
> - * We pick the first idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
> + * We pick the first idle CPU in the HK_TYPE_SCHED housekeeping set (if there is one).
>   */
>  static void kick_ilb(unsigned int flags)
>  {
> -- 
> 2.43.5
> 

