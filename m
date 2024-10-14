Return-Path: <linux-kernel+bounces-363475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B899C2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E4B24B38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8A31531F9;
	Mon, 14 Oct 2024 08:21:27 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333551531C5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894087; cv=none; b=BL49kclnHy9kSL4sxQg7zEmnJhHLBZS3YYGfs2NlgEUp520u69/wzUDbW5wKmgyTMQcpEW7gSMmbESum/6XhNGDmrwjLBTaoIWjLBrIxpteHgw8ZC82ecZ+gDKR96JX3IB4gRj5W649CdU16a7hPCYqKX1GdO1YnjFixYGDJfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894087; c=relaxed/simple;
	bh=Q7GdbHWVCQ15TEWLQ0a6xS1UciFvn7NyHW1raI8/Kp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DvhQiFIRtsXxU+1ygWiCMa4oMeJXvtQ5Fyk4JIAo5NFRgwTJxC1k48hknC7JR903IPcdupRa18IbItxNwL5/kewtDGBvHT/9HE2KryidjVOZQOM1p0WmcatobVB3N+KQ5JDuwNcR7ZEHqqDmoQiDrysvtXzwovl9kYli1oTkN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-247-4NFu0UZOOFmACXHGH0uvGg-1; Mon, 14 Oct 2024 09:21:07 +0100
X-MC-Unique: 4NFu0UZOOFmACXHGH0uvGg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Oct
 2024 09:21:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Oct 2024 09:21:06 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thomas Gleixner' <tglx@linutronix.de>, Steven Rostedt
	<rostedt@goodmis.org>
CC: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
	"mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "efault@gmx.de" <efault@gmx.de>
Subject: RE: [PATCH 0/5] sched: Lazy preemption muck
Thread-Topic: [PATCH 0/5] sched: Lazy preemption muck
Thread-Index: AQHbGo8XexbPsuHzxEm33+r9fps+rbJ/xYLAgAU5dICAAO1icA==
Date: Mon, 14 Oct 2024 08:21:06 +0000
Message-ID: <2a2007766d7942b6a4bfb7541143f959@AcuMS.aculab.com>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home> <87h69lqbk0.ffs@tglx>
 <20241009164355.1ca1d3d3@gandalf.local.home> <87ed4pq953.ffs@tglx>
 <ea496d1ea02049e88a701f984b0f2a6b@AcuMS.aculab.com> <878qurhlmu.ffs@tglx>
In-Reply-To: <878qurhlmu.ffs@tglx>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Thomas Gleixner
> Sent: 13 October 2024 20:02
>=20
> On Thu, Oct 10 2024 at 10:23, David Laight wrote:
> > ...
> >> And once all the problems with LAZY are sorted then this cond_resched(=
)
> >> line just goes away and the loop looks like this:
> >>
> >>     while ($cond) {
> >>           spin_lock(L);
> >>           do_stuff();
> >>           spin_unlock(L);
> >>     }
> >
> > The problem with that pattern is the cost of the atomics.
> > Thay can easily be significant especially if there are
> > a lot of iterations and do_stuff() is cheap;
> >
> > If $cond needs the lock, the code is really:
> > =09spin_lock(L);
> > =09while ($cond) {
> > =09=09do_stuff();
> > =09=09spin_unlock(L);
> > =09=09spin_lock(L);
> > =09}
> > =09spin_unlock(L);
> >
> > which make it even more obvious that you need a cheap
> > test to optimise away the unlock/lock pair.
>=20
> You cannot optimize the unlock/lock pair away for a large number of
> iterations because then you bring back the problem of extended
> latencies.
>=20
> It does not matter whether $cond is cheap and do_stuff() is cheap. If
> you have enough iterations then even a cheap do_stuff() causes massive
> latencies, unless you keep the horrible cond_resched() mess, which we
> are trying to remove.

While cond_resched() can probably go, you need a cheap need_resched()
so the loop above can contain:
=09=09if (need_resched()) {
=09=09=09spin_unlock(L);
=09=09=09spin_lock(L);
=09=09}
to avoid the atomics when both $cond and do_stuff() are cheap
but there are a lot of iterations.

There will also be cases where it isn't anywhere near as simple
as unlock/lock (eg traversing a linked list) because additional
code is needed to ensure the loop can be continued.

> What you are proposing is a programming antipattern and the lock/unlock
> around do_stuff() in the clean loop I outlined is mostly free when there
> is no contention, unless you use a pointless micro benchmark which has
> an empty (or almost empty) do_stuff() implementation. We are not
> optimizing for completely irrelevant theoretical nonsense.

Aren't you adding a extra pair of atomics on every iteration.
That is going to be noticeable.
Never mind the cases where it isn't that simple.

=09David

>=20
> Thanks,
>=20
>         tglx
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


