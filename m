Return-Path: <linux-kernel+bounces-426427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D809DF2DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DD8162E55
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A821B1A9B33;
	Sat, 30 Nov 2024 19:57:04 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAC3D3B3;
	Sat, 30 Nov 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732996624; cv=none; b=g5HvFKDPedaEGBpN7vNG10kFXai40Hv8lAnJfO4QseI6+vGfb0moVJcEhIGdt/Wt2KxKqq9O4O6r0MAuQDmgYGscqthmunvdtzPU+AiXQoUycL6zdifkorlYZfBWbMA1vaP6IGVWv79c/8H/8FkLMHaVN+KZRviGkQ8UBz1VijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732996624; c=relaxed/simple;
	bh=iliAV4e1ag5AmPwuqTfpm94XBTsvFbIoc0GjRaaazmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAezEQQ6dHDvUPXpWWkpnPOLUrMA4y4uZ2qpvIo+xYL1wopGprl3cuUAe3+uMzK6VpAsxYBCcXBLNSeMKTLZSMVNFl1j1h7oUjuzbmNrvN5VHQ77R43w2YdU6ZZayKfqSh57QJMsM8LQVLK0/fDJ1/6uS9uAmQp5wWisDB4E3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tHTa0-000000006XM-3qRr;
	Sat, 30 Nov 2024 14:56:36 -0500
Message-ID: <e1d810d7c2bc77961828ee38ef322f5ec49181d8.camel@surriel.com>
Subject: Re: [linus:master] [x86/mm/tlb] 7e33001b8b:
 will-it-scale.per_thread_ops 20.7% improvement
From: Rik van Riel <riel@surriel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@kernel.org>,  Andy Lutomirski	 <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Date: Sat, 30 Nov 2024 14:56:36 -0500
In-Reply-To: <CAHk-=wj0HyNR+d+=te8x3CEApCDJFwFfb22DH5TAVyPArNK9Tg@mail.gmail.com>
References: <202411301528.342383d8-lkp@intel.com>
	 <069d686ab958d973563cfad52373ec6c8aad72ca.camel@surriel.com>
	 <CAHk-=wj0HyNR+d+=te8x3CEApCDJFwFfb22DH5TAVyPArNK9Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Sat, 2024-11-30 at 09:54 -0800, Linus Torvalds wrote:
> On Sat, 30 Nov 2024 at 09:31, Rik van Riel <riel@surriel.com> wrote:
> >=20
> > 1) Stop using the mm_cpumask altogether on x86
>=20
> I think you would still want it as a "this is the upper bound" thing
> -
> exactly like your lazy code effectively does now.
>=20
> It's not giving some precise "these are the CPU's that have TLB
> contents", but instead just a "these CPU's *might* have TLB
> contents".
>=20
> But that's a *big* win for any single-threaded case, to not have to
> walk over potentially hundreds of CPUs when that thing has only ever
> actually been on one or two cores.
>=20
> Because a lot of short-lived processes only ever live on a single
> CPU.
>=20
Good point. We do want to keep optimizations for single
threaded processes in place.

> The benchmarks you are optimizing for - as well as the ones that
> regress - are
>=20
> =C2=A0(a) made up micobenchmark loads
>=20
> =C2=A0(b) ridiculously many threads
>=20
> and I think you should take some of what they say with a big pinch of
> salt.
>=20
> Those "20% difference" numbers aren't actually *real*, is what I'm
> saying.

Agreed that it won't be a 20% difference on real
workloads, but there are a few real world workloads
where these optimizations do make a fairly significant
difference.

For example, this change below made a 2% performance
difference for a memcache style workload on 2 socket
systems back in 2018, when CPU counts were much smaller
than today:

e9d8c6155768 ("x86/mm/tlb: Skip atomic operations for 'init_mm' in
switch_mm_irqs_off()")

>=20
> > 2) Instead, at context switch time just update
> > =C2=A0=C2=A0 per_cpu variables like cpu_tlbstate.loaded_mm
> > =C2=A0=C2=A0 and friends
>=20
> See aboive. I think you'll still want to limit the actual real
> situation of "look, ma, I'm a single-threaded compiler".
>=20
> > 3) At (much rarer) TLB flush time:
> > =C2=A0=C2=A0 - Iterate over all CPUs
>=20
> Change this to "iterate over mm_cpumask", and I think it will work a
> whole lot better.
>=20
> Because yes, clearly with just the *pure* lazy mm_cpumask, you won
> some at scheduling time, but you lost a *lot* by just forcing
> pointless stale IPIs instead.

I struggle to think of a way to synchronize clearing
bits from the mm_cpumask that does not involve IPIs,
but I suppose we could rate limit that clearing to
something like once a second?

The rest of the time we could compare whether a
CPU's cpustate_loaded_mm matches the target mm, and
skip sending an IPI to that CPU?

We already seem to be passing info through to
tlb_is_not_lazy, so the logic could all be implemented
inside there if we wanted to.

--=20
All Rights Reversed.

