Return-Path: <linux-kernel+bounces-405971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DBA9C5A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A66BB32B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD451F81B3;
	Tue, 12 Nov 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TNS9lz2e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KUnatkAx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D21F8191
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419183; cv=none; b=ubfESBYOy3EizyqY/s3ImKB9+NDLcpiPaSNlFOTsUdKJPcv+6py6bGuPAe8wq+o3SEtYmSf9RpjItl/lZMoBLEX6Ngk9ZNQj5m+zckUokZzkD7R1prAhRCuGgh70tFoiNdGLuxSL+sPA3BO3/kulzro6UwspH5lEXy+D64vsbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419183; c=relaxed/simple;
	bh=gKShv7+G+/jj6/jXNcXUElgPO+Tlumb8gNlcoxF1x88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9y356bFC2fUWRRgw1zYlw21/2/A2UKGS9zSKtvOj+OwnTpPICTfmnSYufRMtFBzCKgIb/JN9o5D8QzR7y56w9/YyN5fbx3VeDGOQPXMkwSHOMozfxebcoRPJwh+Mydxjcl9E2ludsYjhsYC7hdXKLnHHeP4aAUArQuk7Irbw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TNS9lz2e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KUnatkAx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731419179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fmxrs8QHJz5PAmm33VLO/J5Su+9eR3M9rqggTcHIdxI=;
	b=TNS9lz2ef0A5oPo9qOoS/rFOmhq7vuSyV1aFTCrXmazMLMFnXHoutveF7ENGjJfGqOSpqe
	9HZ7GD5+GwAtUKOB2L0ZLsadpdB64L0QKbFkQUv3Vn9zCyUETRwU2gy5AvwNg1ANgkkmeq
	okOy52FFllZKais+deWoJB++n19MObSrAZpdKbvCkaBukvDlw1ddXqKUFtJmx+DVrdmEWZ
	N8EsQOWi3vtokzMzuGkr3epg1/2QyDzOq6c63p/GhjKzQHn0thVHC/SfZxnoHwwfoXmFCW
	d1XmGowxmNqZ2ubIf5n4ak2vvFM18M5jLXHkSqVSah7ffxCVJoqFCHGHEi6VdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731419179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fmxrs8QHJz5PAmm33VLO/J5Su+9eR3M9rqggTcHIdxI=;
	b=KUnatkAxt18uhOvqM4NmiOkuw3OsUs6j9FKI+/ctAB96hFRsSoU9rQKrxnWPHCpToViuMY
	1pcup05ajDWqEwCQ==
To: Frederic Weisbecker <frederic@kernel.org>, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 1/3] tick-sched: Remove last_tick and calculate next tick
 from now
In-Reply-To: <ZzKWvislBnjV9kpf@pavilion.home>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-2-joel@joelfernandes.org>
 <ZzKWvislBnjV9kpf@pavilion.home>
Date: Tue, 12 Nov 2024 14:46:23 +0100
Message-ID: <874j4co98w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12 2024 at 00:43, Frederic Weisbecker wrote:
> Le Fri, Nov 08, 2024 at 05:48:34PM +0000, Joel Fernandes (Google) a =C3=
=A9crit :

>> During tick restart, we use last_tick and forward it past now.
>>
>> Since we are forwarding past now, we can simply use now as a reference
>> instead of last_tick. This patch removes last_tick and does so.
>>
>> This patch potentially does more mul/imul than the existing code,
>> as sometimes forwarding past now need not be done if last_tick > now.
>> However, the patch is a cleanup which reduces LOC and reduces the size
>> of struct tick_sched.

May I politely ask you to read and follow the Documentation
vs. changelogs?

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#change=
log

Also

git grep 'This patch' Documentation/process

might give you a hint.

>> -	/* Forward the time to expire in the future */
>> -	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
>> +	hrtimer_set_expires(&ts->sched_timer, DIV_ROUND_UP_ULL(now, TICK_NSEC)=
 * TICK_NSEC);

How is a division and multiplication in this hotpath helpful? That's
awfully slow on 32-bit machines and pointless on 64-bit too.

Using now is also wrong as it breaks the sched_skew_tick distribution by
aligning the tick on all CPUs again.

IOW, this "cleanup" is making things worse.

> We don't want to rewrite hrtimer_forward() but, after all, the current ex=
piry is
> enough a relevant information.
>
> How about just this? It's worth it as it now forwards after the real last=
 programmed
> tick, which should be close enough from @now with a delta below TICK_NSEC=
, or even
> better @now is below the expiry. Therefore it should resume as just a no-=
op
> or at worst an addition within hrtimer_forward():
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 753a184c7090..ffd0c026a248 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -838,7 +838,6 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
>  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
>  {
>  	hrtimer_cancel(&ts->sched_timer);
> -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
>=20=20
>  	/* Forward the time to expire in the future */
>  	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);

That's just wrong. ts->sched_timer.expires contains a tick in the
future. If tick_nohz_stop_tick() set it to 10 ticks in the future and
the CPU goes out of idle due to a device interrupt before the timer
expires, then hrtimer_forward() will do nothing because expires is ahead
of now.

Which means the CPU is not idle and has no tick until the delayed tick
which was set by tick_nohz_stop_tick() expires. Not really correct.

Thanks,

        tglx

