Return-Path: <linux-kernel+bounces-298834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CA95CC07
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C32D1C212A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE131850AF;
	Fri, 23 Aug 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGYIV/cf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6C469D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414799; cv=none; b=P6pdAaKLYTb0R88UrAYZ1PbJLU6N+U/RG6PVCOjSDmKLTFNHLEl2vXtz7bep+N2IwPdeAmzYSkuR03KsAl069hSrPuJ2X0SSZdNl/iKFvJ6wqhvMNFEjpeAAHYjA6mXZE/9YgHZIqTXMlXCsZDv6oLf5UKLN4/BTGNDhDJDnEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414799; c=relaxed/simple;
	bh=Sk0EEbwOwk6bGDHJqFCT1S4gBS8svzgeQU2FmDtx+GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz+AMVAbhtPGfUCEUorcZloQhTC0FdFpgbJh/N3vi2zXdgyl6z0xdUlOciybOy9YZZsh574mUcfJdH1Qxwtt66fXiXfmZ7TRevGo2ZOf0ihOC5++rCBjeiszDfcjJsWPSZR5dgZ64KwbQMr6ofIbj9JMEnf6iV6a2jlklvYAeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGYIV/cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4B1C32786;
	Fri, 23 Aug 2024 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724414799;
	bh=Sk0EEbwOwk6bGDHJqFCT1S4gBS8svzgeQU2FmDtx+GA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZGYIV/cffOOJDjqmdiNPtnQToN7a7I2lCikgEC0lfA3rzWf9hgI9kyIjajzMBh9ij
	 MmABOYkLJHentw5YdkTnGcUZHPn38OF3WfKOSQU9XWGGf4Q7Cxe577NnKEHozC9wMT
	 zT7Izl7fqEnUzUHQIFvKDcJrnpeYsTst3WjGhl3xJ/5vCl0EQHs8GeNMbIzO8LoirI
	 iPkzS2jFl0Wb4fTsM11WHOK0s+JFYsy/eb5IL1knq+eYJd1mY5/7v/xEKD0ZlUDCo9
	 IDqfuuykdF3ROv2ckZIxWxo9QqkFycvwoaMRWcOIJML8NqMx+cCNcNhqHL3yG+N0TI
	 HUhUGQVOoq0Ew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CC36CCE0427; Fri, 23 Aug 2024 05:06:38 -0700 (PDT)
Date: Fri, 23 Aug 2024 05:06:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: neeraj.upadhyay@kernel.org, riel@surriel.com, leobras@redhat.com,
	tglx@linutronix.de, thorsten.blum@toblux.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/csd_lock: fix csd_lock_wait_toolong() error
 warning
Message-ID: <ba64c1a2-c334-4e04-8641-7a7d2abaee5c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240823080046.61736-1-qiyuzhu2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823080046.61736-1-qiyuzhu2@amd.com>

On Fri, Aug 23, 2024 at 08:00:46AM +0000, Zhu Qiyu wrote:
> From: "Zhu Qiyu" <qiyuzhu2@amd.com>
> 
> In AC cycle stress tests, it was found that the csd_lock_wait_toolong()
> did not reach the 5s threshold, but printed the warning message, the
> probability of occurrence is about 0.58%-0.87%.
> 
> This is due to the out-of-order execution of the CPU, which causes ts2
> to be used before it is initialized. The original value of ts2 on the
> stack is random, which may cause ts_delta = ts2 - *ts1 to be greater
> than 5s, thus triggering the printing.
> 
> The solution is to add a memory barrier after reading the ts2, which
> can effectively avoid this issue.
> 
> Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>

Good catch!  But does the following commit help?

7ba82f5d831b ("locking/csd-lock: Switch from sched_clock() to ktime_get_mono_fast_ns()")

This is in the "dev" branch of the -rcu tree:

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

This commit switches from sched_clock() to ktime_get_mono_fast_ns()
in csd_lock_wait_toolong() and __csd_lock_wait().  Because this code
runs with preemption disabled, both calls to ktime_get_mono_fast_ns()
will be from the same CPU.  Furthermore, neither call will ever be from
an NMI handler.  Therefore, the times returned from those two call sites
should never go backwards.

Please see the end of this email for the corresponding patch.

							Thanx, Paul

> ---
>  kernel/smp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f25e20617b7e..e58678d424a4 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -247,6 +247,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  	}
>  
>  	ts2 = sched_clock();
> +	/* Avoid ts2 being used before it is initialized */
> +	mb();
>  	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
>  	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *

------------------------------------------------------------------------

commit 7ba82f5d831bcddfa22b6b782c5e254c5580bc07
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Aug 5 11:44:43 2024 -0700

    locking/csd-lock: Switch from sched_clock() to ktime_get_mono_fast_ns()
    
    Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock()
    to check for excessive CSD-lock wait times.  This works, but does not
    guarantee monotonic timestamps.  Therefore, switch from sched_clock()
    to ktime_get_mono_fast_ns(), which does guarantee monotonic timestamps,
    at least in the absence of calls from NMI handlers, which are not involved
    in this code path.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
    Cc: Rik van Riel <riel@surriel.com>
    Cc: Leonardo Bras <leobras@redhat.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>

diff --git a/kernel/smp.c b/kernel/smp.c
index f25e20617b7eb..27dc31a146a35 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -246,7 +246,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 		return true;
 	}
 
-	ts2 = sched_clock();
+	ts2 = ktime_get_mono_fast_ns();
 	/* How long since we last checked for a stuck CSD lock.*/
 	ts_delta = ts2 - *ts1;
 	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
@@ -321,7 +321,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
 	int bug_id = 0;
 	u64 ts0, ts1;
 
-	ts1 = ts0 = sched_clock();
+	ts1 = ts0 = ktime_get_mono_fast_ns();
 	for (;;) {
 		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id, &nmessages))
 			break;

