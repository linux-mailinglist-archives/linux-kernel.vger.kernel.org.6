Return-Path: <linux-kernel+bounces-384506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 056339B2B06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E50B21DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4156192D70;
	Mon, 28 Oct 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIAUJ7dP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A363192D61
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106573; cv=none; b=go1qDjCH1fuWShEHBbzm+y5H4mcYy43eAk9+4mse4yBO0c1Wg+2V+Eh7yf/FYiOa/2IHJwOSuKxwvps0B10RzgNroBvRrZbvUg0ix8N3V/hkJMa5A6oFLWBOuJVcot16DxE3pcdlRJapfIjV3ltmedU38m5UGO1WL7YQsm+hado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106573; c=relaxed/simple;
	bh=giou2QyJly4VdDrTgW/Uitk7VCB0kfmvuzcsEJHPasE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UofPJkAss3lsJ3knbQATT31htix5k/gVYTscB/bqBZTwdWDuKVgZGyYZThS2bCIU9Ovik4l9kLri7lYSRNxsH2DqlafeBTyPnWkhxBqj379Cj+BU407hZtijHmwTsE3rnu+4E2IcnHjgFhqXvKSckQRSuCCxSwtTwznCc9Xc2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UIAUJ7dP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=clbOrzMgaeZazFVKU1vbExFsWyp21FOKRhm9/eCwJPU=; b=UIAUJ7dPPOgXi9Pglt8bsLUt4k
	PHls2Z3wlwB0ViUW/rYoKbbajopBy0bf0x82SQXMKg1qn2EiEcN1TTNryLou+hpRCJk/zwCOR19Bw
	78R9KvPE0q32jJ+PaIkXSa2gxlNga9Pcrro288woyi0VrdCFWovWfLq86lxIoXcGWZPtdXsd51acU
	8ULsqG0FV2RLq6Z/NzaryAMUW9gL2npO8VIJ0OhC7ZxD3UsoKcHkAiADG8XwnuL5lbzGvzz3WYZMP
	qvCp69KyL1hbVH5UuuBjsSxlbGfnkPSYtRn5YedIuEQBgHNRwrtchbBFprtkv44qlqhDQ/Z2PI9yQ
	8tTs+0tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Lke-00000008BcV-0nZW;
	Mon, 28 Oct 2024 09:09:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D5F4C30083E; Mon, 28 Oct 2024 10:09:27 +0100 (CET)
Date: Mon, 28 Oct 2024 10:09:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/21] sched/idle: Switch to use hrtimer_setup_on_stack()
Message-ID: <20241028090927.GI9767@noisy.programming.kicks-ass.net>
References: <cover.1729864615.git.namcao@linutronix.de>
 <db5daed82f8ba69eb155171ed96f3a5a83cd483b.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5daed82f8ba69eb155171ed96f3a5a83cd483b.1729864615.git.namcao@linutronix.de>

On Mon, Oct 28, 2024 at 08:29:37AM +0100, Nam Cao wrote:
> There is a newly introduced function hrtimer_setup_on_stack(), which will
> replace hrtimer_init_on_stack(). In addition to what
> hrtimer_init_on_stack() does, this new function also sanity-checks and
> initializes the callback function pointer.
> 
> Switch to use the new function.
> 
> Patch was created by using Coccinelle.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/sched/idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index d2f096bb274c..631e42802925 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -399,8 +399,8 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
>  	cpuidle_use_deepest_state(latency_ns);
>  
>  	it.done = 0;
> -	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> -	it.timer.function = idle_inject_timer_fn;
> +	hrtimer_setup_on_stack(&it.timer, idle_inject_timer_fn, CLOCK_MONOTONIC,
> +			       HRTIMER_MODE_REL_HARD);

WTF is hrtimer_setup_on_stack() ?

Do NOT send partial series. How the hell am I supposed to review things
if I don't even get to see the implementation of things,eh?

