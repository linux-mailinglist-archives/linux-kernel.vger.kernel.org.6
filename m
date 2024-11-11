Return-Path: <linux-kernel+bounces-404847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0EB9C490A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9001C282F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50017278D;
	Mon, 11 Nov 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaIGTkLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09574150990
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363919; cv=none; b=BJtQKUnV68Gy0Xy50GKqOYBjhvrv02xMDyxAv6TKs8qNYHQ+0s6WDwlC0WIXexV5dwGVfM7Kmp/Vl382IXruEvoy/RRjz1gOSntrYHwM+37oxbfx+EKivF7yORiB3liTl9iXZF+ow+A/VfQvB9PbZrEqHGJwkJKukLzoMBJqVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363919; c=relaxed/simple;
	bh=Z5es0xNMMkiJqKJFxE1Zm/pkkpyW0EAh6Chhd6N6brc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWAh25uwEuLNROB4ENqZm7e8Yhkbh291Mu6v6uUPR3Y5ISVF0KFQ1f5FlI/YDLrJo4p0PAaZxYueuicL6dGlYvVpRpu6ULDGDU3pR3g+5JTn7UtL8IMeP6Os99IG/Zdoqor5GhBWVOCs991mzh9cOOdgnBmvvY4b+SNJ8fKjybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaIGTkLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A1FC4CECF;
	Mon, 11 Nov 2024 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731363918;
	bh=Z5es0xNMMkiJqKJFxE1Zm/pkkpyW0EAh6Chhd6N6brc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaIGTkLI1ni1tUHKqVnXdz7bxHacJjPpzlpylClUFzH2T97RYv6j1Op7lHCSe3cos
	 BEHjuBxzY9T6j39SFsCspVuGdH3J0yqflI0BcGVRUns324eCO3eiwW0Pa25IuaWo2B
	 yA5t4T4U4YUBCGWDu3vPFYbBGeZ4Gi+T7GZwARjnZ+OAVwcXAdgpS3oxHXm1iONqpO
	 gwZQQwcHGIbeA9DLdv1X/xKifGC27z45T5I61x8j9MWdIiPotvqYcgUOLQUqV2ijD4
	 TWbUSLBHXtyCHtx24JvipTVKqfRADuP8iEadfZTaNgG6Q3H2mfn0720gMnyA811J1F
	 WZD2/41EpmDwA==
Date: Mon, 11 Nov 2024 23:25:15 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 3/3] tick-sched: Replace jiffie readout with idle_entrytime
Message-ID: <ZzKES39RkUfyN5x4@pavilion.home>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-4-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108174839.1016424-4-joel@joelfernandes.org>

Le Fri, Nov 08, 2024 at 05:48:36PM +0000, Joel Fernandes (Google) a écrit :
> This solves the issue where jiffies can be stale and inaccurate.
> 
> Putting some prints, I see that basemono can be quite stale:
> tick_nohz_next_event: basemono=18692000000 basemono_from_idle_entrytime=18695000000

That's 3 ms. If HZ < 1000 that's to be expected. But even with HZ = 1000 it can
happen.

> 
> Since we have 'now' in ts->idle_entrytime, we can just use that. It is
> more accurate, cleaner, reduces lines of code and reduces any lock
> contention with the seq locks.

Do we need such accuracy? The timers rely on jiffies anyway.
Also it's a seqcount read. Basically just a pair of smp_rmb().
Not sure a division would be cheaper.

> 
> I was also concerned about issue where jiffies is not updated for a long
> time, and then we receive a non-tick interrupt in the future. Relying on
> stale jiffies value and using that as base can be inaccurate to determine
> whether next event occurs within next tick. Fix that.
> 
> XXX: Need to fix issue in idle accounting which does 'jiffies -
> idle_entrytime'. If idle_entrytime is more current than jiffies, it
> could cause negative values. I could replace jiffies with idle_exittime
> in this computation potentially to fix that.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/time/tick-sched.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 4aa64266f2b0..22a4f96d9585 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -860,24 +860,6 @@ static inline bool local_timer_softirq_pending(void)
>  	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
>  }
>  
> -/*
> - * Read jiffies and the time when jiffies were updated last
> - */
> -u64 get_jiffies_update(unsigned long *basej)
> -{
> -	unsigned long basejiff;
> -	unsigned int seq;
> -	u64 basemono;
> -
> -	do {
> -		seq = read_seqcount_begin(&jiffies_seq);
> -		basemono = last_jiffies_update;
> -		basejiff = jiffies;
> -	} while (read_seqcount_retry(&jiffies_seq, seq));
> -	*basej = basejiff;
> -	return basemono;
> -}

This is used in tmigr as well.

Thanks.

