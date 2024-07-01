Return-Path: <linux-kernel+bounces-235787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1391D9A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCC5284EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2547E76F;
	Mon,  1 Jul 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2+E4fv1Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MBKuApQk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607261674
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821140; cv=none; b=HSAtW4+tpepvUTxYUDmSBe1L5uK9WZ2G2zod7SgSWiYu6+ZjZFnTezLZnrGOM3x004Zrnv4FrzaOAHNdFFo23b8GXbdWkYrnDm1SGK3C6FqD4jIM+ReKFvOeIGIcFtXVR+sBjLj0PX2yd27EsvESYEFWGScz9dlZcV0d0XCRCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821140; c=relaxed/simple;
	bh=w936zWrxp6gQ6PPvrdJeCp0eT2dQIZTyjScYat4O1Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P76kU9yFM0jmyneNxMx+vdj8oZ7G+aNGyQss0f8LXK9Ub/+vjVW9ShQAFTAB/mlIITHfKHsG07apKA7K3eSeWgpElG957KMvxa/ziDOwdyOx0jEbJ0Z9mF136KIWEVyLZaP8Ls8Hn61Lspv9kPpyOn3DUdBQWzJUm5juwFGiiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2+E4fv1Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MBKuApQk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 1 Jul 2024 10:05:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719821137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKfzw2ROY3stuRf89Jn2lC5lgD1irCU4YYPi/8S8KrA=;
	b=2+E4fv1Z6SYruIg13wR86OOfrDEl3jGK5RgN7/7FKnp2rRMJjk+OtTV9ezcOT5J+ZkMEL5
	NI+R9ra18yT+jO4bdKVBcpOW1+Ejhvj5/IQsNaUODXrpfLD/cuJZ/gBpnXTasBnjZPNk41
	3QZNdHAWx0TI9zynoEAmx8eApWLhdK3oE8CzT5rnOPZzTJ73Co7OafJZT1H6icjClqVwv7
	BYWke/gn6YI9YFsubr1xLRZxZT2exlrbzzUmhtEl1PU356BXbmJyomZ6SQeYjbkMg9CGx3
	hizsVq4xzzTj0Rlo3xws8jThmwXmGHj4v099pIAzaYmbEE/HW1hVvxKVGrNmCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719821137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKfzw2ROY3stuRf89Jn2lC5lgD1irCU4YYPi/8S8KrA=;
	b=MBKuApQkRCIX5zCUlU0ZFPl29CtPryLrkXjqQaUSKpKmhAXEJvDj86BwvmC7fhb9FGgQhc
	GqeCkhi95DjJc3Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <20240701080536.nLclpYXN@linutronix.de>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <20240628094944.QwcHkf8J@linutronix.de>
 <ynstsvvvjonzkltu4iwedbmntwnnth7dmcvng3ccrtqv45bq3y@5p6amff7cjmw>
 <20240628195553.G48MpeQ6@linutronix.de>
 <w2qopormdwuh54vropw6sgvadnivjnrgvmpurud2cu6nannfj3@xxrs2r6qt7zi>
 <20240630211142.kZAs9f0p@linutronix.de>
 <jvkmjjqfo6w4arluq3ggwilfwucvg5ra273ziq5ov2e2hnrtck@x64ksn72qi3u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <jvkmjjqfo6w4arluq3ggwilfwucvg5ra273ziq5ov2e2hnrtck@x64ksn72qi3u>

On 2024-06-30 17:23:36 [-0400], Kent Overstreet wrote:
> On Sun, Jun 30, 2024 at 11:11:42PM GMT, Sebastian Andrzej Siewior wrote:
> > On 2024-06-28 16:20:27 [-0400], Kent Overstreet wrote:
> > > > Kent, you said you didn't want it where it currently is. Fine. You =
said
> > > > you want it at the front next to `flags'. This isn't going to work =
since
> > > > there is no space left. You didn't make another suggestion or say h=
ow to
> > > > make room.
> > >=20
> > > It doesn't need to be on the exact same cacheline, just as near as you
> > > can get it.
> >=20
> > the first possible thing would be somewhere after the scheduler.
> > However, what difference does it make if it s two cache lines later or
> > more?  I don't understand the requirement "closer".
>=20
> take advantage of CPU prefetching; CPUs will bring in more than just the
> cacheline you touched because 64 bytes is small and it's cheap to fetch
> from the same DRAM bank while it's open.

Looking at the layout:
|        unsigned int               flags;                /*    44     4 */
|        unsigned int               ptrace;               /*    48     4 */
|        int                        on_cpu;               /*    52     4 */
|        struct __call_single_node  wake_entry;           /*    56    16 */
|        /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
=E2=80=A6
Starting with sched
=E2=80=A6
|        struct sched_statistics    stats __attribute__((__aligned__(64)));=
 /*   704   256 */
|
|        /* XXX last struct has 32 bytes of padding */
sched end, earliest spot imho

|        /* --- cacheline 15 boundary (960 bytes) --- */
|        unsigned int               btrace_seq;           /*   960     4 */

If I add this before `btrace_seq' right after `stats' then it will be 14
caches lines later or 912 bytes after. How big is this prefetch going to
be?

Sebastian

