Return-Path: <linux-kernel+bounces-358775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3699837C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BBB1F21C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B521BFDE7;
	Thu, 10 Oct 2024 10:24:00 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D51BF7E5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555840; cv=none; b=I8GbJCoPC6B//Sy68x7U0IJUFkIXg+aSykfPdiaSex9yIj23CbGK19C1QBqwtji3IGwH1p/G2ibp6rWGy87Xsr66MP8PWOb6lg1NkylL44vdnB+8/BLBQEvtUD3CF+bX7zplhdTSqOTdZB3f9sBJEA0k+qC6RXy0x2ebqapZIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555840; c=relaxed/simple;
	bh=h1R63jixfSue3R7Ieez3jUjailTzjr2SNM0L2a+aAIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=F1CTY21Io5Kcy0uixCyx6PayERoe8vpulmRXolP+urN9M/cC86OrfpfNe9cQWSsN6v/DCHw2zz5VY/VEm/XSmM9JWFYRYeROLD3H0JUqeN/3/I70O+bXrXc9XabloOgn+0M6DmbDpoKL+q/PWjXHsepaDlRsxCOBIr/ob6t7eRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-31-zFKabjwrN-S-U-Z5gNyBvg-1; Thu, 10 Oct 2024 11:23:55 +0100
X-MC-Unique: zFKabjwrN-S-U-Z5gNyBvg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 10 Oct
 2024 11:23:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 10 Oct 2024 11:23:54 +0100
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
Thread-Index: AQHbGo8XexbPsuHzxEm33+r9fps+rbJ/xYLA
Date: Thu, 10 Oct 2024 10:23:54 +0000
Message-ID: <ea496d1ea02049e88a701f984b0f2a6b@AcuMS.aculab.com>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home> <87h69lqbk0.ffs@tglx>
 <20241009164355.1ca1d3d3@gandalf.local.home> <87ed4pq953.ffs@tglx>
In-Reply-To: <87ed4pq953.ffs@tglx>
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

...
> And once all the problems with LAZY are sorted then this cond_resched()
> line just goes away and the loop looks like this:
>=20
>     while ($cond) {
>           spin_lock(L);
>           do_stuff();
>           spin_unlock(L);
>     }

The problem with that pattern is the cost of the atomics.
Thay can easily be significant especially if there are
a lot of iterations and do_stuff() is cheap;

If $cond needs the lock, the code is really:
=09spin_lock(L);
=09while ($cond) {
=09=09do_stuff();
=09=09spin_unlock(L);
=09=09spin_lock(L);
=09}
=09spin_unlock(L);
which make it even more obvious that you need a cheap
test to optimise away the unlock/lock pair.

Perhaps it could be wrapped inside a spin_relax(L)?

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


