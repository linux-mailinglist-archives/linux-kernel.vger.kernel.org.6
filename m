Return-Path: <linux-kernel+bounces-528575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FACA41943
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BD13A34E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C0242912;
	Mon, 24 Feb 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W0t+e4Of";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yR8svMJ4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83B1C861E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389618; cv=none; b=IWPw3nd1vsQk2a9/MkfhJ3RsxMmaDXlbQZgmMHU+dcM3wqeeiLbUxuF6n2dwlqdwLunM5A4BSuFz4/OaQNgpPNZSpX9ft0yrj7hU8w0yTPXCdftzvhd51iDEQmuA/OEvCY5iFhiFYIt1yJnqeLOEubTw1waO5xqgUn+HyhPg5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389618; c=relaxed/simple;
	bh=Zcmbwv5uGMx/Ii7EGISedD6hsAoxcOXn58zM4coDStg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NXkmpp0KG22hbXTyFie+pVLGTMaGa6coLCZg8zD3LxkUJWzIoVuKcXyhuv4SR/7RETjiH6WcZEQMheakjWyZ7mh+YgXJhErcraDg61vuwmmwGoKcz+F0OGWnpjoTj1jEvWztX20eU4mh75Tq9qnU6Agi3XBulgFzzceL3l0yJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W0t+e4Of; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yR8svMJ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740389614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thD0VAK0LcD2Jy2Le/qOKSZ2u3p8iSZ34jCsDjgTLzc=;
	b=W0t+e4OfH2lLgfJmjbhfcs7OJS+0zJdvPg8bTjE5j0SJN0LxqMDxnfhHLrFao3J3IvELez
	2kwg1JqzV43d7bry8hAeGgYlveY+taL5OwiRo5rlmbyNVZxvnnX25evYOissBzlU0uEEsY
	GjcNcW8fYynFDBQbvZHZL7ozn/wuwE40UUI1Be13wp5d3EQCDqepjyTFp0+gMTOmiEVEEE
	Ce05X4QuBi8CXO6vkaI/ubdjvLb1mi3Xbx2ciJMBZM1100QDFh04aV82vF54eKgkX1pz3D
	zlzU/cNyPeTOrKWcA6mfqQtGlKRtzYV1MmloGYC+F/By4DdYl9pxuoGnC7DxMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740389614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thD0VAK0LcD2Jy2Le/qOKSZ2u3p8iSZ34jCsDjgTLzc=;
	b=yR8svMJ4gaoSuMreVMmCbdKd7GIx/i+9o08tTdf1fdmB6xzY2RIbtZbBrniBqtSvZ2kDqz
	dTpYND1hWkL4CCDw==
To: Eric Dumazet <edumazet@google.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall
 <bsegall@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 4/4] posix-timers: Use RCU in posix_timer_add()
In-Reply-To: <20250219125522.2535263-5-edumazet@google.com>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-5-edumazet@google.com>
Date: Mon, 24 Feb 2025 10:33:33 +0100
Message-ID: <871pvnheky.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -125,7 +125,19 @@ static int posix_timer_add(struct k_itimer *timer)
>  
>  		head = &posix_timers_hashtable[hash(sig, id)];
>  
> +		rcu_read_lock();
> +		if (posix_timers_find(head, sig, id)) {
> +			rcu_read_unlock();
> +			cond_resched();
> +			continue;
> +		}
> +		rcu_read_unlock();
>  		spin_lock(&hash_lock);
> +		/*
> +		 * We must perform the lookup under hash_lock protection
> +		 * because another thread could have used the same id.
> +		 * This is very unlikely, but possible.
> +		 */
>  		if (!posix_timers_find(head, sig, id)) {
>  			timer->it_id = (timer_t)id;
>  			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);

So I played with that because I wanted understand what's going on.

Actually this change is just voodoo programming. Why?

  The only case where this lockless lookup would help is when the timer
  ID wrapped around and the lookup has to validate a large range of
  already occupied IDs, but even then the lookup is dropping hash_lock
  after each ID search. I seriously doubt that this is the case at hand
  because according to Ben this happens when a process is started or
  restored, which means there is no timer ID wrap around and therefore
  no timer ID collision in the process itself.

In fact the extra lookup is counter productive in most cases:

 With a single process, which creates 50000 timers in a loop, this
 results in:

 [1]        mainline     +lookup
 create        98 ms      219 ms

 and it gets worse with 100000 timers:

 [2]        mainline     +lookup
 create       313 ms      650 ms

Why? Because with 100k timers the hash buckets contain ~200 timers each,
which means in the worst case 200 timers have to be walked and
checked. Doing this twice obviously at least doubles the time.

Now there is a case where the change improves the situation, but for the
very wrong reasons:

 A process forks 63 times and all forks wait on a barrier before each
 instance creates 20000 timers. The processes are pinned on seperate CPUs
 to achive maximum concurrency. The numbers are the average times per
 process:

 [3]        mainline     +lookup
 create    157253 ms    40008 ms

But that improvement has absolutely nothing to do with the timer ID
collision. The extra lookup (and I verified with tracing) creates just
enough interleaving so that all CPUs can make progress on the hash lock
instead of being stuck in a cache line bouncing shitshow. The very same
can be achieved by:

        ndelay(total_number_of_timers / $CONSTANT);

So, no. This is not a solution. The proper solution is to replace the
hash by a scaled hash with per hash bucket locks, like we have in the
futex code already. I've implemented this and the result proves the
point with the three test cases:

 [1]        mainline     +lookup   scaled hash
 create        98 ms      219 ms         20 ms

 [2]        mainline     +lookup   scaled hash
 create       313 ms      650 ms         48 ms

 [3]        mainline     +lookup   scaled hash
 create    157253 ms    40008 ms         83 ms

This is really only a problem of the hash collisions and the resulting
list walk length, which is easy to prove by extending the tests above.

After creating the timer and synchronizing again (for the fork case),
the test invokes timer_getoverrun(2) for all created timers in a loop.

 [1]        mainline     +lookup   scaled hash
 create        98 ms      219 ms         20 ms
 getoverrun    62 ms       62 ms         10 ms

 [2]        mainline     +lookup   scaled hash
 create       313 ms      650 ms         48 ms
 getoverrun   261 ms      260 ms         20 ms

 [3]        mainline     +lookup   scaled hash
 create    157253 ms    40008 ms         83 ms
 getoverrun  2611 ms     2614 ms         40 ms

I picked timer_getoverrun(2) because that's just doing the lookup and
reading from the k_itimer struct after locking it. So the syscall has no
contention on the timer lock nor on anything else. According to perf the
vast majority of time is spent in the list walk to find the timer and of
course the cache foot print becomes worse the larger the bucket lists
become.

Let me write proper changelogs and a cover letter and post that stuff.

Thanks,

        tglx

