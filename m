Return-Path: <linux-kernel+bounces-191886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96BE8D1594
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DD1F21BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA68D73509;
	Tue, 28 May 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z0wMS8jK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AtJe0IO7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5556D1C1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882989; cv=none; b=PcyNS8guGfW1I8dEnTte/9CiLEKUIjXYdbg5o8a7qFavh5BHwZMdvHwvnQEzO7ZpL++lfmraWilqfg/JhoE6ip8JAlH7EZHD472QF3inqYBigbqDe7kh+P7a38rin4gtIljcK0L4yYTN0X6UDInnM7Xsky3crfLkFBD3TRzYSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882989; c=relaxed/simple;
	bh=PLRA6eg3GpEb0s6BIYfSrc9jNEo6E5f65DZU6Y7C/Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3nepB56FhvruB28Qtb7kcmsXtgJsMzYHg+/V92zNVuGbafFGIzcC/KWB2j/C0Mjz9CKFDobpmb6tUjJjK/BuOwxkGDUFtV5AE+OLXOQZwovtKbE2UPCfjW+QbLNNdezaBl0ynj/g7ycprvV2e0WQysGBA4nMxp2B9P/bDk8F8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z0wMS8jK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AtJe0IO7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 09:56:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716882985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLRA6eg3GpEb0s6BIYfSrc9jNEo6E5f65DZU6Y7C/Ts=;
	b=z0wMS8jK/NcODY+06JDwvEgSi1Hqt8CrfjGJyG8OooTiHIVo3qJlcSf1Y8+Uxed/njRocq
	WPMEvR6uBjSqqYfRHnE7GCs7Pcz18gSp8w+cjBDFzXfhPIQyK3WMLLr0eCriNiPyfmOgPY
	ux2kGbtTwEoQ3DEtktHLw/06q9Zkedtt/5U703PV4QHRaeke4vw/UYOYBLFrQEVliTeBPQ
	719gbf6vatjt+nBdXY6YScOZIELZEsFvyeSxE+MSs+e0LhFlh1a64v9cQttZsVrSUcrvgj
	me6P58xE84P+7OMg7afqGWHR/FL4et2vlqCR2ZmdsG1tZghLz10ZObtagqVX/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716882985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLRA6eg3GpEb0s6BIYfSrc9jNEo6E5f65DZU6Y7C/Ts=;
	b=AtJe0IO7jvWMw4vtY/DQoswZG5uHlwssofyV+QijtJgBWlZ90aGFXWG5YvedH2jTJ/sZpV
	LKi42QeDFlFownAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: simple cleanup of stats update functions
Message-ID: <20240528075623.oFcU1JLj@linutronix.de>
References: <20240420232505.2768428-1-shakeel.butt@linux.dev>
 <20240527152200.P1rU7FaG@linutronix.de>
 <86006806-4ffc-4330-ab4b-29215ab2c98c@kernel.org>
 <n6zstrcbqp7fqpennqf3qgt2nuc2tdrnsc5dmoawyke3zn3xcm@6uirkotvrhe6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <n6zstrcbqp7fqpennqf3qgt2nuc2tdrnsc5dmoawyke3zn3xcm@6uirkotvrhe6>

On 2024-05-27 22:16:41 [-0700], Shakeel Butt wrote:
> On Mon, May 27, 2024 at 06:34:24PM GMT, Vlastimil Babka (SUSE) wrote:
> > On 5/27/24 5:22 PM, Sebastian Andrzej Siewior wrote:
> > > On 2024-04-20 16:25:05 [-0700], Shakeel Butt wrote:
> > >> mod_memcg_lruvec_state() is never called from outside of memcontrol.c
> > >> and with always irq disabled. So, replace it with the irq disabled
> > >> version and add an assert that irq is disabled in the caller.
> > >=20
> > > unless PREEMPT_RT is enabled. In that case IRQs are not disabled as p=
art
> > > of local_lock_irqsave(&memcg_stock.stock_lock, =E2=80=A6) leading to:
>=20
> Sorry about that and thanks for the report.

no worries.

> >=20
> > But then the "interrupts are handled by a kernel thread that can sleep"=
 part
> > of RT also means it's ok to just have the stock_lock taken with no
> > interrupts disabled as no actual raw interrupt handler will interrupt t=
he
> > holder and deadlock, right?

I *don't* know why the interrupts-disabled check is here. The
memcg_stock.stock_lock is acquired on RT with interrupts enabled and
never disables interrupts. The lock is never acquired in an hard
interrupt (not threaded interrupt) context so there is never a deadlock.

Originally the interrupts were disabled in mod_memcg_lruvec_state()
because the counter, it operates on, is per-CPU and relies on disabled
interrupts because the operation is not atomic and the code can be run
in interrupts context (on !RT). The __mod_memcg_lruvec_state() variant
of it relied on interrupts being disabled by the caller. This "rely on"
was part of a spinlock_t lock (or invoked from an interrupt handler, the
memory is fading slowly away) which does not disable interrupts on
PREEMPT_RT.
So for that reason we ended up with __memcg_stats_lock() which disables
preemption only on PREEMPT_RT to achieve the same level of "atomic"
update.

> Thanks Vlastimil for jolting my memory on RT reasoning.
>=20
> > > suggestions?
> >=20
> > So in that case the appropriate thing would be to replace the assert wi=
th
> > lockdep_assert_held(&memcg_stock.stock_lock);
> > ?
> >=20
> > It seems all the code paths leading here have that one.
> >=20
>=20
> Yeah this seems right and reasonable. Should I send a fix or you want to
> send it?

I don't mind sending a patch. I'm just not sure if the lock is the right
thing to do. However it should ensure that interrupts are disabled on
!RT for the sake of the counter update (if observed in IRQ context).

Yeah, let me prepare something.

Sebastian

