Return-Path: <linux-kernel+bounces-404892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B61D9C49ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A47A281E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F2E1BD032;
	Mon, 11 Nov 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6IusLK2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4515884A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368641; cv=none; b=iM2H1Cl7iHR3ALnwqzHpJMHX/3MwyjNoVI3cXTnKa5qNzr+4B8xpSBb6rhbTISdKrXIzepvOHyCcC0Rn1b9SE32jNcbbNMUBifI0J220TcHQzSNKtOxOQUKBNIChGKOJZnEIW601ETdomqJEdHnfWAQCVjsAJubYq+Uyt70TYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368641; c=relaxed/simple;
	bh=fKkuplvt6skLtqPdWckn41dtT4ds87GqhM7iVDWP1bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGSjbDHo8QD98JmpRqGF6pwfRuFoRTreHn3yjTZsO5Jw7ij7bUhnjM+uVkyAPV2pr2poFSDFNQ61BwxvbQoEMs0943Z16PcvU9XkIKYqKboGdeIBc5tmifQsB6EyTj2UlZ/vLW/wJQcSk4oD1VB0HHdzTiMCA9EvuK2/5tK1WRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6IusLK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C528CC4CECF;
	Mon, 11 Nov 2024 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731368641;
	bh=fKkuplvt6skLtqPdWckn41dtT4ds87GqhM7iVDWP1bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6IusLK2nh5l/Lvcw+v4mVo9ZvuHaMWlVI6qTQke3zJK1MwHMNuv2NMFWDeHcB5XK
	 Hj+6jzSVUPn6N5nAAVF6Ks6VllbkijLjO9hpaDoZ2r+QLbMbda6LpBoIxY54R5rsD1
	 OnDZ+CF7XZP4L/TLsogc8MdcfTaLT3aWoIMVGRH00rNqbupzZQljFPwLugDCfsjF7F
	 BeQnAXjkXVLpbuqKbB/sYcDi0ABySfdRvR/QWxVHSJ0MV5O36pvnw6A5HOrG0GemFH
	 d8hbnPIihmovLahM2j/4Mv58/51F/z14Aqya8oIu2kEAQKdzIWr0hQeybUZZCGUG8I
	 bh89qyYfhgpIw==
Date: Tue, 12 Nov 2024 00:43:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 1/3] tick-sched: Remove last_tick and calculate next tick
 from now
Message-ID: <ZzKWvislBnjV9kpf@pavilion.home>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-2-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108174839.1016424-2-joel@joelfernandes.org>

Le Fri, Nov 08, 2024 at 05:48:34PM +0000, Joel Fernandes (Google) a écrit :
> During tick restart, we use last_tick and forward it past now.
> 
> Since we are forwarding past now, we can simply use now as a reference
> instead of last_tick. This patch removes last_tick and does so.
> 
> This patch potentially does more mul/imul than the existing code,
> as sometimes forwarding past now need not be done if last_tick > now.

Which is not uncommon if idle exited because of a non-timer interrupt
(remote wake up IPI or hardware interrupt).

It's also cheaper with hrtimer_forward() if now - last_tick < TICK_NSEC
which is not uncommon either if idle exited because of a wake-up from the tick
(schedule_timeout for example).

> However, the patch is a cleanup which reduces LOC and reduces the size
> of struct tick_sched.

Reducing the overhead of idle exit and consolidating its code within existing
forward API is more important than a per-cpu field.

> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/time/tick-sched.c | 7 ++-----
>  kernel/time/tick-sched.h | 1 -
>  kernel/time/timer_list.c | 1 -
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 71a792cd8936..52a4eda664cf 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -837,11 +837,9 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
>  
>  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
>  {
> +	/* Set the time to expire on the next tick and not some far away future. */
>  	hrtimer_cancel(&ts->sched_timer);
> -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
> -
> -	/* Forward the time to expire in the future */
> -	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> +	hrtimer_set_expires(&ts->sched_timer, DIV_ROUND_UP_ULL(now, TICK_NSEC) * TICK_NSEC);

We don't want to rewrite hrtimer_forward() but, after all, the current expiry is
enough a relevant information.

How about just this? It's worth it as it now forwards after the real last programmed
tick, which should be close enough from @now with a delta below TICK_NSEC, or even
better @now is below the expiry. Therefore it should resume as just a no-op
or at worst an addition within hrtimer_forward():

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c7090..ffd0c026a248 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -838,7 +838,6 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
 	hrtimer_cancel(&ts->sched_timer);
-	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
 
 	/* Forward the time to expire in the future */
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);


As for removing last_tick, I think it's a precious debugging information. But
it's lagging behind the record of the first time only the tick got stopped within
the last trip to idle. So it could become this instead:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c7090..af013f7733b2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1042,12 +1041,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		calc_load_nohz_start();
 		quiet_vmstat();
-
-		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		tick_sched_flag_set(ts, TS_FLAG_STOPPED);
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
+	ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 	ts->next_tick = expires;
 
 	/*

Thanks!

