Return-Path: <linux-kernel+bounces-357693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A6997414
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324DBB23DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE71A76D5;
	Wed,  9 Oct 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E0jL3L90"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94433C2E0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497236; cv=none; b=f8qZASGH3hPamZfmluayn+t5yMplql0gINus9kNSG8S6AK7wiN/sj+OAeK/vhrRpzql3Ab0dqcYbv0Umy8OrFAjRBieyv8e2awf3A2Zly13SDdVex9hhX3gVARepQi+I5DQxffYGWoZNcqEj//jirNeXT0s3k9h224sYvA1d0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497236; c=relaxed/simple;
	bh=JGOi4LF+hJ5EqFWXdtiYvW9ooWABcBaUPeGZNfSiqx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFSMT39zdmppyvML2vSsbHY4xUZM0+AdeWl5aQK6whvlFAKd92WQzl41e5ObkflMZdz0n1SsWX9o4ddMNITIShpL9pDQWAmzkDyVJ1gWpz4eQ9XhXy6N9Eswmtomy3NcIL8z/0waALEeIlWyQ9dsTndyhTyBkonBkgYsvvr54VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E0jL3L90; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Y8yOgrz/Krrblq0KCa+ZHLyD2D2jR9ISCF7ATNqlkE=; b=E0jL3L90LU7lKh0PB96gFL40wV
	86OP2L1qbkyn6pdOr26tg/KyVbWC9QZQO4zaistJuumQnMjqohRGg9PussDEJPD7U+Vkp2L75Vdfp
	Dywi7QQ4MtLmYxR2dqomMaXwR6fRtY4cGu7Co6EBm/cAt/xG7beYFxEPi8FqpBgk26NGLQ9uUAUJX
	aRjPS3q4RPnkbaP0NlHLbuA1w/xvrwpWggiBcB7fI6Cr7/s5rfuHN9mcntfkO3COFq6L8qehKWdbd
	2mROU28N7fJuX1kndME1qs2vTcmlrVUBIheJCF8Anwt0b9AF5qMzlUSc0z+qrM7w2yox5Q9bU193m
	KmnhA22w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syb5Y-00000005TMm-1TsG;
	Wed, 09 Oct 2024 18:07:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 841513004AF; Wed,  9 Oct 2024 20:07:08 +0200 (CEST)
Date: Wed, 9 Oct 2024 20:07:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	riel@surriel.com, leobras@redhat.com, tglx@linutronix.de,
	qiyuzhu2@amd.com
Subject: Re: locking/csd-lock: Switch from sched_clock() to
 ktime_get_mono_fast_ns()
Message-ID: <20241009180708.GU17263@noisy.programming.kicks-ass.net>
References: <da9e8bee-71c2-4a59-a865-3dd6c5c9f092@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9e8bee-71c2-4a59-a865-3dd6c5c9f092@paulmck-laptop>

On Wed, Oct 09, 2024 at 10:57:24AM -0700, Paul E. McKenney wrote:
> Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock()
> to check for excessive CSD-lock wait times.  This works, but does not
> guarantee monotonic timestamps. 

It does if you provide a sane TSC

> Therefore, switch from sched_clock()
> to ktime_get_mono_fast_ns(), which does guarantee monotonic timestamps,
> at least in the absence of calls from NMI handlers, which are not involved
> in this code path.

That can end up using HPET in the case of non-sane TSC.

In the good case they're equal, in the bad case you're switching from
slightly dodgy time to super expensive time. Is that what you want?

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Leonardo Bras <leobras@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f25e20617b7eb..27dc31a146a35 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -246,7 +246,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  		return true;
>  	}
>  
> -	ts2 = sched_clock();
> +	ts2 = ktime_get_mono_fast_ns();
>  	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
>  	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
> @@ -321,7 +321,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
>  	int bug_id = 0;
>  	u64 ts0, ts1;
>  
> -	ts1 = ts0 = sched_clock();
> +	ts1 = ts0 = ktime_get_mono_fast_ns();
>  	for (;;) {
>  		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id, &nmessages))
>  			break;

