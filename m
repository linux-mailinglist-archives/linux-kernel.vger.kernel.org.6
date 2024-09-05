Return-Path: <linux-kernel+bounces-317561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F249096DFFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D5F1F25C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316FD19DF70;
	Thu,  5 Sep 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8+E1uIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B021487FF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554503; cv=none; b=Jk6KMqPpPoiHwlWXExrsM8zCLr9KqR4pBAxiFZeL/82Pg2zYSQdPVGIMdreix079zj9ICTL4Dwdd+zuUPWhiEuFX1n8dwpTC9xvMLf4Qh9D6mjc3tVaHeNjlJk810LxrFtsZk0ke9jnDXw5gDT8353zN9V78X2dbasKW8ZtPrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554503; c=relaxed/simple;
	bh=/KXlBn2PgyXloXiU1K5ZuRezydyuPnJXDLoq/nHtOv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3zU8wotLEdwAvfqPRcGqwLyvyT6loz8ViVZ5uTU733FlPnUxa6Y6/PF8mefIJv0x+2To00JN9vFVzpZqYTZEb7A8gbXU7UTlfydVuUgGPa3faRTIUVvo0/1RtVJi8t0Wduev50e0I1uO/0s7nie4RY7V0tcLKS15flF3v3ytkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8+E1uIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E48CC4CEC7;
	Thu,  5 Sep 2024 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725554503;
	bh=/KXlBn2PgyXloXiU1K5ZuRezydyuPnJXDLoq/nHtOv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8+E1uIbXZtryYrzhwB7R7SLrwZNxx7RmWAZIb5WwGjFAlVmfAMYv+L8HNObGbuDZ
	 jqXiNgYFzM6P1dlMFKwhVsro/b0wd6aiaN9TJmIY7vjFH5H4RAG8TfIrxGVU6k4GJy
	 piMSO+lrMv4GhJOS4sFyHxXYKRnKF5nqt8Ok4onMEna0vBCHqhOBQXdbjcNHeonwUk
	 fQW0tDIcj7r2Tuxec1OE0pxtjtHUbGr1bOAE87k7GhIOFaV07YP2DxEGWycGHxEzFY
	 8sxms0afhAU3RdDEVdOS2nRuGMw7AEMabsNs0WMPufSmwfUqCafirMXbFtXVjGcShl
	 8XbWJXvCiXuCg==
Date: Thu, 5 Sep 2024 06:41:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <ZtnfRnmo-EpWKcyC@slm.duckdns.org>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
 <20240905092858.GA15400@noisy.programming.kicks-ass.net>
 <20240905150012.GF4928@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905150012.GF4928@noisy.programming.kicks-ass.net>

Hello,

On Thu, Sep 05, 2024 at 05:00:12PM +0200, Peter Zijlstra wrote:
...
> > Oh cute. Which class in particular did you see this do?

The easiest repro was fair.

> > Looking at balance_fair() / sched_balance_newidle() I suppose we could
> > verify we actually have a runnable task once we've re-acquired the
> > rq-lock and have pulled_task > 0.
> > 
> > 
> > Tightening all that up would probably be better than trying to deal with
> > the fallout like this, hmm?

Oh, yeah, that would be better and we probably want to add a sanity check so
that we know if balance() and pick_task() disagree.

> Something like so. Haven't yet looked at the rt/dl classes.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 11e890486c1b..7db42735d504 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12716,6 +12716,12 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>  	if (this_rq->cfs.h_nr_running && !pulled_task)
>  		pulled_task = 1;
>  
> +	/*
> +	 * We pulled a task, but it got stolen before we re-acquired rq->lock.
> +	 */
> +	if (!this_rq->cfs.h_nr_running && pulled_task)
> +		pulled_task = 0;
> +

Lemme test that.

Thanks.

-- 
tejun

