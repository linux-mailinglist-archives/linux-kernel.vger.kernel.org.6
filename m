Return-Path: <linux-kernel+bounces-222594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0292D910448
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C651C228C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF6E1AC453;
	Thu, 20 Jun 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VdEx+bYz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF01AB34A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886831; cv=none; b=hAc4u0Yc5kthDeFBnhb7kht/EUDKZkFMywFy47EY+yrFfyxCs7KWZS7xbj2h8VkkVBxpdAUJswRe5smavG2Fn2zWv/CrnoDribJm7NEmN/IJMt7qjrgUO8JC0MgyIFBRsKhwKqAd/IgvUO2xOvo0xJPSN/ohugE9x13XqH3+iSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886831; c=relaxed/simple;
	bh=EkIBmSmII12BjQwFyVyLSIrxf7sKE/dZhVwJFRfaUV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8Po1YB8IJs7W1qt2Ef1fmrAOnMF8dy0ouvfQd89Nlom7QtBYxu9gW7YpLkkZ07sDbiF/kVSpblMuFab266VCpqBo78Gx/WKg/gSuu5lVfySDq0wl2qqIEMQBu6UhUJjB2WIDN6tq6ndqM/Q3kByZqIgOezDvaZ7qr4OpyeZXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VdEx+bYz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cKyiy07FYL92EG3cVRyZSbgppLEe98eSJ1TVo2XVpxc=; b=VdEx+bYzwCm/fS5kntwsy9xHHF
	CA+FCb2bu/v1Av3wRkT6C8+/9rwqMXREarYz2+xAQkLUQvlS0RcMBzuVpeD3rNokgbkDmL+KML2XS
	R5YQiVTj9BBd18q4kXihl9TLrNWKg2fjb6EEuuwZKZSUW3tN1BleZFRka8xSBagVy+PGVh3QDEZRu
	3uCy59zpvw8BBYH5GgYhDpV6SVwnwaEOJrfA+ZjqOCIDjcgMF8x2dXJar72nytQf4zlzeqZCnxaUJ
	C4Sdrha2sL1/7ABVKjfCCdK8wu4ZaAS4pxuk9uKUIH+LUj7bVl11KJecvitSFPDhIGgXNd0Q7GEZA
	8QeWudmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKGyw-000000063dK-3nGL;
	Thu, 20 Jun 2024 12:33:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 42B06300CB9; Thu, 20 Jun 2024 14:33:38 +0200 (CEST)
Date: Thu, 20 Jun 2024 14:33:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/preempt: Bypass setting same mode for
 sched_dynamic_update()
Message-ID: <20240620123338.GX31592@noisy.programming.kicks-ass.net>
References: <20240620121020.869707-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620121020.869707-1-ruanjinjie@huawei.com>

On Thu, Jun 20, 2024 at 08:10:20PM +0800, Jinjie Ruan wrote:
> If the preempt mode to set is same with current preempt mode, there is no
> need to update all the `cond_resched`, `might_resched`, `preempt_schedule`,
> `preempt_schedule_notrace` and `irqentry_exit_cond_resched` state.

IIRC this actively breaks things, also this is a super slow path, nobody
should care.

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bcf2c4cc0522..eb409901c64c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8777,6 +8777,9 @@ static bool klp_override;
>  
>  static void __sched_dynamic_update(int mode)
>  {
> +	if (mode == preempt_dynamic_mode)
> +		return;
> +
>  	/*
>  	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
>  	 * the ZERO state, which is invalid.
> -- 
> 2.34.1
> 

