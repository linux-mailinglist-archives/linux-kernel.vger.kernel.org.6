Return-Path: <linux-kernel+bounces-406047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE69C5A65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1D32859B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3E1FC7DF;
	Tue, 12 Nov 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xnaJIt2r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzfxjV9P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017771F708F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421847; cv=none; b=QimN/RU41dj0vqJUCeVdmKE4Tr7pHWel4PNjduJHHwWXwI0cac8oiqBXkrcw2iRJBaW1CGqp+Qc7HIFp95CpAc6fqC5sN1HsX4aNgRUvBJ9gPwTVoIzzsmGXtnxpLRTy/E1cDF2s8hZDdm79YLVRujpAlbtyZ+ShUOdZQF9rEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421847; c=relaxed/simple;
	bh=p8ExRg4z1a1LltITq7U6wb/KGJ2S8pV0ajmyjQAexy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BEkielLEQkfqLd3TROTtlIwcCC6bggAav3q+sAKIH+edUMQnqF2JuaM+QjLtf1PZKBGH7S22kV4f8EWR/GwbV3vzbRJx4BWP429GgdAFTlEsV0PcRt/ZdKsOqGR14LRWun0PN/UrNIyjC7QEPAW2fZBLFwRYzhOiNu/yY38HSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xnaJIt2r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QzfxjV9P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731421844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfB7KMTx1REg3uFpEr1DS4wFMbhQ4wNa/fXYGewvLsg=;
	b=xnaJIt2ruBeywTuHAfaY+/IwsNwAUSqY7htsEFt4H2f/1+A5cxvOL2SXaiFg9hTmjch00j
	vlzd3anqzRmoBvkANgimQigW/B9mkt2AQee01nxilNQi1D2VYtoSAzMo/yVWyrwPIJNEOo
	qDNEqUMUnhn3vnlz8XgCYxcvUkwpS3TM/xtO6u+PoDuN8sGH7r7HvGK64thp5YwtqiHa1s
	IEk/x/lNBBvvu3/tdk3sTOdr4RXdIOYVJZsda7j6K1X65IMHGcNFkBCgmX3NsXFHM3weU4
	uBg9IB5LzqktZZWlTHweT5+uNc+qjRZVGGI2OE8esmzsEa4JA5P+13XHyq2HFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731421844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfB7KMTx1REg3uFpEr1DS4wFMbhQ4wNa/fXYGewvLsg=;
	b=QzfxjV9PbXhdIXAysGX5LcRT47hPxb/EbxP/o3fkw4VoKNtI7qDD0tE+PigAbCGnC9wYMj
	qN/qO/07xjgQt1Bg==
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@kernel.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [RFC 3/3] tick-sched: Replace jiffie readout with idle_entrytime
In-Reply-To: <20241108174839.1016424-4-joel@joelfernandes.org>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-4-joel@joelfernandes.org>
Date: Tue, 12 Nov 2024 15:30:24 +0100
Message-ID: <871pzgo77j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 08 2024 at 17:48, Joel Fernandes wrote:
> This solves the issue where jiffies can be stale and inaccurate.

Which issue?

> Putting some prints, I see that basemono can be quite stale:
> tick_nohz_next_event: basemono=18692000000 basemono_from_idle_entrytime=18695000000

What is your definition of stale? 3ms on a system with HZ < 1000 is
completely correct and within the margin of the next tick, no?

> Since we have 'now' in ts->idle_entrytime, we can just use that. It is
> more accurate, cleaner, reduces lines of code and reduces any lock
> contention with the seq locks.

What's more accurate and what is the actual problem you are trying to
solve. This handwaving about cleaner, less lines of code and contention
on a non existing lock is just not helpful.

> I was also concerned about issue where jiffies is not updated for a long
> time, and then we receive a non-tick interrupt in the future. Relying on
> stale jiffies value and using that as base can be inaccurate to determine
> whether next event occurs within next tick. Fix that.

I'm failing to decode this word salad.

> XXX: Need to fix issue in idle accounting which does 'jiffies -
> idle_entrytime'. If idle_entrytime is more current than jiffies, it
> could cause negative values. I could replace jiffies with idle_exittime
> in this computation potentially to fix that.

So you "fix" some yet to be correctly described issue by breaking stuff?

>  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  {
> -	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo;
> +	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo, boot_ticks;
>  	unsigned long basejiff;
>  	int tick_cpu;
>  
> -	basemono = get_jiffies_update(&basejiff);
> +	boot_ticks = DIV_ROUND_DOWN_ULL(ts->idle_entrytime, TICK_NSEC);

Again this div/mult is more expensive than the sequence count on 32bit.

> -/*
> - * Read jiffies and the time when jiffies were updated last
> - */
> -u64 get_jiffies_update(unsigned long *basej)

How does this even compile? This function is global for a reason.

Thanks,

        tglx

