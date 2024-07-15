Return-Path: <linux-kernel+bounces-252928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C97A9319FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80BC282152
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE355589A;
	Mon, 15 Jul 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUcJAgep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928284C62A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066851; cv=none; b=F4NQU6n/G1u6D8aEkqk20D4E9EnVlEMPBqDJ5ehMJ2tVv6+nYEwCuHZQcQGqJNMdEXs30LI5YLSfw1LOURr0nNm4D72lDEBbQVWXB/OMbA9vAi7bGxk/C0GuIGzIrbVOWPGYxqbzlg+gLKKV/1ctyJ/Z5TdTCuhMlpaLWNB4k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066851; c=relaxed/simple;
	bh=E5wYUGyt7Ir/qYAhUbW44IRGQ5AMiuS2oe6KXU0RIk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRsjcxparXImnroqpu2A8B1a7uU/slGlboG3FycP1H+O64UA93LIu9QOO40BluPHY5oUhUs0gT9GZcYcGLU7heOMe3qT0si9dSzHA17ce02I9iGrsvRp1i1o/slcm0AzYYb/FU1lx9bZA7W74gpJv6bGvc41jaWqcPtTVlV6NgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUcJAgep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681EFC32782;
	Mon, 15 Jul 2024 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721066851;
	bh=E5wYUGyt7Ir/qYAhUbW44IRGQ5AMiuS2oe6KXU0RIk8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZUcJAgep2XNM5Cc/ddLvJphVsuftYoBdfE2HAv1SEQ6IqqyEMg5FEvil/bTZKXuh4
	 e+8ReTdSIwHvp8HSzvlWVC+pRx3P9oGr/ZDw5Mq6LsHgstR+I8otkV6j8w96eIycS7
	 c/YQaHhtHyCdgH8R20tqF6S2iHvbLAQEyeNC+mX+598UdiuBWeM1Eq3AdIWc+uPCtk
	 mw6HeYo/2Ba9z2H+Wowmzxi5G9+ZkhvHvJweNStGOsEgEhOIc7Un4IjAQnkRMx30q9
	 a+bJu+tFq/lewVP+3rCRDrLGXF9qhw98j3Gm6Fq3dh03Rxqv9kWPDubnkuO3mdCMOK
	 T85JL6AeMQ0fA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F0AF4CE0AD3; Mon, 15 Jul 2024 11:07:30 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:07:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	neeraj.upadhyay@kernel.org, mingo@kernel.org, rostedt@goodmis.org,
	Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] smp: print only local CPU info when sched_clock goes
 backward
Message-ID: <88d281fe-d101-47d9-b70e-bb6a8959f5ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240715134941.7ac59eb9@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715134941.7ac59eb9@imladris.surriel.com>

On Mon, Jul 15, 2024 at 01:49:41PM -0400, Rik van Riel wrote:
> About 40% of all csd_lock warnings observed in our fleet appear to
> be due to sched_clock() going backward in time (usually only a little
> bit), resulting in ts0 being larger than ts2.
> 
> When the local CPU is at fault, we should print out a message reflecting
> that, rather than trying to get the remote CPU's stack trace.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f085ebcdf9e7..5656ef63ea82 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -237,6 +237,14 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
>  		return false;
>  
> +	if (ts0 > ts2) {
> +		/* Our own sched_clock went backward; don't blame another CPU. */
> +		ts_delta = ts0 - ts2;
> +		pr_alert("sched_clock on CPU %d went backward by %llu ns\n", raw_smp_processor_id(), ts_delta);
> +		*ts1 = ts2;
> +		return false;
> +	}
> +
>  	firsttime = !*bug_id;
>  	if (firsttime)
>  		*bug_id = atomic_inc_return(&csd_bug_count);
> -- 
> 2.45.2
> 

