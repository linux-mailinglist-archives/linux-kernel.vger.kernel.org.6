Return-Path: <linux-kernel+bounces-192739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738EE8D2179
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161181F253DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43269172BAD;
	Tue, 28 May 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SckjFfmH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC5172786
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913106; cv=none; b=VAlwDq108F1LWWEeXjpPSUeOaq3jrG+/aYziqsou1OWXcWv8sxKmi9xl1i40mzhEgbtz05iHm4JgzhZBwfOpl1TkbDassVzd6V0Y5jKQtrPe+asZYxQzDD15/WI3iyXYT14pzml4/7PNYAHcSl9P8qpv05kWzpyw4SfzHYD7nWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913106; c=relaxed/simple;
	bh=1VbUIqUs+Iu0R4n6LFXs/qsLl6tg7ekCtkKrs/8XAqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=st+OLUh0ZaHmDzgf6pbQLwoV2ffTIg1a4eLR0pQ3ypgPRWvOtfJEQTJOcIknPPt+u0d9yvSc/wqMcI/AaCWRep61uojUazqsJxLSaVdaCDu5nZirrhvTnHdueSGyO9GzcAQLOC6RzemEyl5C1P/BpLtnCkgK4KB3SxHebB+KpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SckjFfmH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YrD3h7xnAMYmgs99LNq6GxSV6xHBbPUpPYn32qlIOyw=; b=SckjFfmHkqc2jUeU+XoturfIaG
	L1+MXwlN0MBNdOb+P47BxiF4/kT4KMvgar5k86uLX8mJftlQqA/kBRUbj4IHsX92E2tNLTw1WmGYJ
	EwZ2McN57VF6ApdWl8Isn+xm3l+zSX3FhTYrTt2jFSwIUAvhHji89dE2xvngjiWn+BrMCtva76iD6
	YXXB8+ikkV/tRQGvxlvQpvJ7klDw9z22O8d4GiyGLPmXurSekYwSVkzQjsDFbhBuVbUznnQU0j64y
	ayVaveq+lQptNjBhelIbyxpdFLUEDG2xjib+f6ktW4ZhuFvtoyu/nIcVkq2TtkQwsdEtLs+b9O1Kl
	omEVfmjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzWj-00000008oWl-0NyW;
	Tue, 28 May 2024 16:18:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B69E030058E; Tue, 28 May 2024 18:18:16 +0200 (CEST)
Date: Tue, 28 May 2024 18:18:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 10/35] entry: irqentry_exit only preempts for
 TIF_NEED_RESCHED
Message-ID: <20240528161816.GF26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-11-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-11-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:56PM -0700, Ankur Arora wrote:
> Use __tif_need_resched(RESCHED_NOW) instead of need_resched() to be
> explicit that this path only reschedules if it is needed imminently.
> 
> Also, add a comment about why we need a need-resched check here at
> all, given that the top level conditional has already checked the
> preempt_count().
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/entry/common.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index bcb23c866425..c684385921de 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -307,7 +307,16 @@ void raw_irqentry_exit_cond_resched(void)
>  		rcu_irq_exit_check_preempt();
>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>  			WARN_ON_ONCE(!on_thread_stack());
> -		if (need_resched())
> +
> +		/*
> +		 * Check if we need to preempt eagerly.
> +		 *
> +		 * Note: we need an explicit check here because some
> +		 * architectures don't fold TIF_NEED_RESCHED in the
> +		 * preempt_count. For archs that do, this is already covered
> +		 * in the conditional above.
> +		 */
> +		if (__tif_need_resched(RESCHED_NOW))
>  			preempt_schedule_irq();

Seeing how you introduced need_resched_lazy() and kept need_resched() to
be the NOW thing, I really don't see the point of using the long form
here?


