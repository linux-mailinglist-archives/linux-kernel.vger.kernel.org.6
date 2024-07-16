Return-Path: <linux-kernel+bounces-253517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117D932266
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9E31F22F37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5E17D373;
	Tue, 16 Jul 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KoW6UfzN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226661957EA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120698; cv=none; b=mcATbkm78iDsXSfFeMaqMc49hVFkzAUPgskBoJLvCaUYoaq5tatghe9ucR0oaNXIjfE3jEaR3CRsjbIqkX/uxxKDvJxzGnCpwnec9u+/N5t8KWRk6uSXfBWlzYAfyf3ldtiilAz5X5w32kcoH9RtxZgbkrEVn8pliQ/3LG/DrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120698; c=relaxed/simple;
	bh=wlilYn+/xvuOJFor9+eMBVOYUjwEpfyAXzgbIoVNdwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF6D8Ev9s2FnW7GkH+pctHtsIrU0ZbCVBIq6EFxmniLoJBDvm/LOws5oYAQMLIkez8CNBM0FU7SZbgQc2RPX4PkKCFFFTsr0WP5opwufBVOKKjLaSFjtS419d3TnRPNxek6wf6TZyIySul3NUBgYYYGi5DGPDxEZDSYahfEDDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KoW6UfzN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R9ZKfMuXBCb/X/lSyXwcbNJySLEf3Pd8Z2Bs3/zfTIQ=; b=KoW6UfzNj/3HeUjavEwH6oI4ez
	2mSBAxqB8JxszCGjx8VnE0x0oxM/KD2tsdmn8pLVdzMsdkvqjH5te24pdjpBZY3NX1J7Wq5xG2EMI
	Q2C8aP5XNsly4qTc66bAWI7Leg/AtaVoKMJw08hD74VfuPziIOWkKUpc5Ev5rf7fGhWsIkaKrbIpp
	tL2M2dzaJ155bu6JFxumGyVXh825hZn58MZxIo1j0ZU08LwpPXtSMwfz9GXAksx79wQPNuZGwg5+4
	/T8ZpQoKgTYGPaKN2+jwOGbWGFfcZGy5yVimpY72Nb6LRRW88W7GtyJEGl4HayMc+NjFtwmEbCSmB
	+qE5atRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTe72-000000020iF-2ydG;
	Tue, 16 Jul 2024 09:04:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93D8D3003FF; Tue, 16 Jul 2024 11:04:43 +0200 (CEST)
Date: Tue, 16 Jul 2024 11:04:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, neeraj.upadhyay@kernel.org, mingo@kernel.org,
	rostedt@goodmis.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] smp: print only local CPU info when sched_clock goes
 backward
Message-ID: <20240716090443.GQ14400@noisy.programming.kicks-ass.net>
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

So I've seen some chatter about this on IRC and was WTF, seeing this
patch I'm still WTF. What is going on with those machines?!?!



