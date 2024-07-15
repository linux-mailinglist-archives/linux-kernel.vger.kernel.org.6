Return-Path: <linux-kernel+bounces-252334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFB9311C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EC61F232FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5718735B;
	Mon, 15 Jul 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnmPp3nZ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF989187352
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037268; cv=none; b=MVxt66QqEWAjDcgTfN6nBfHjRhqWj7YybKSyZYjnag9/owJ+I6RHJapednUxqgWIcQuffGFuFHMTg+Yt6+NhJ6lO3dr9hK3hTqkfs0Q6JyBdyZ6rO4nJYIaKdbWDfMtfoqafg1PTaS4IrsTZSHUwxSlwwcuG9UayttnTEX3k2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037268; c=relaxed/simple;
	bh=LXusf5hVfGrHQkf8cz+WHg9oLDJZIivkQaeP+8z+zos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRJ0sp7bH+zOBOJVq0G1EqR6IgmDU0C0UXGBDg161Rd3Qr0DxUk3AcSLIVaU7vqkksGHzXdDg53h+J7Ol4BXybIaVe2Yq/tQi4J150uQmrOoEH3F28mAJD4PHg7eKVbAzOedwGSwdBrTqHGq66tV/ymfZzgFXxQWdQaKm79DrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QnmPp3nZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=H0PL1bDi9IOHhHm/Gk0fg2VKpGdiUeAwvnn8fDtyElM=; b=QnmPp3nZcJns0xBQrwucuY76Cb
	/zO0jOd4DNaPMzvHQ/zw4u+k9Q9wBXGRnHCY99Wyh210Pu6FrMGv3ezTWfZDW5OJLUYzalCEAkhYX
	flbR2T9TP/uX7rK8tRBss0I3Hdbqqq6rPVwunv5rwcrgi9ummUvfxB7ObBMOBo+iimkBfNs10ipTc
	PgZt3xbXmQogf/XoLXp5uj2Aq9AT7bPBWPNB2SpGSHl8R1lB53KfjT9h3VX/nT6JmPOHIVxDmVzky
	YYqaocBfuqVCHqRcpazIsZ3cWXqN6saLMQeskCQRSI/ez0Pf/ixYL6WO6wu1kKXHGJPKiig0SMB2z
	rbAUZe4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTIPL-00000001ltU-3ylN;
	Mon, 15 Jul 2024 09:54:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4779E3003FF; Mon, 15 Jul 2024 11:54:11 +0200 (CEST)
Date: Mon, 15 Jul 2024 11:54:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: =?utf-8?B?U2hpLVd1LCBMb++8iEdtYWls77yJ?= <shiwulo@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: A new spinlock for multicore (>16) platform
Message-ID: <20240715095411.GY27299@noisy.programming.kicks-ass.net>
References: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>
 <ZpRjDDKGq1F4cSBr@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZpRjDDKGq1F4cSBr@archie.me>

On Mon, Jul 15, 2024 at 06:45:16AM +0700, Bagas Sanjaya wrote:
> On Mon, Jul 15, 2024 at 01:07:40AM +0800, Shi-Wu, Lo=EF=BC=88Gmail=EF=BC=
=89 wrote:
> > Dear Linux Contributors,

> >    A detailed introduction to this method can be found in the following=
 paper:
> > https://www.usenix.org/conference/osdi23/presentation/lo

So if I understand this right, the algorithm basically boils down to a
circular path and unlock will iterate this path looking for the next CPU
waiting.

The worst case wait-time is one full circle of the rotor, which is
bounded, so that's good.

The immediate problem however is that O(n) iteration on unlock, given
Linux runs on many big machines with 1e3 order of CPUs, which would be
quite terrible on low to medium contention.

You mention in Future work, to alleviate this unlock issue by switching
to a linked-list, whereby unlock would then become O(1). The problem
then becomes lock() needs to an insertion-sort, which needs to know the
rotor position (eg. current lock owner).

I don't think that is a much easier proposition -- notably uncontended
fast path doesn't (want) to track the rotor position, and in the worst
case you're still iterating 1e3 order CPUs.

Hierachical rotors come to mind, but complexity -- is it warranted?

> > Our laboratory is currently developing a system that can apply the
> > same optimization strategy to all multi-core processors. Below is our
> > plan.
> >=20
> > The New Method and Its Compatibility with qspinlock:
> > 1. The default algorithm in the Linux kernel remains qspinlock.
> > 2. A new file is created in /proc/routing_path, where a shortest path
> > can be input, for example:
> > sudo echo 1,2,3,4,16,17,18,19,5,6,7,8,11,12,13,14 > /proc/routing_path
> > 3. After inputting the shortest path, the kernel switches to using the
> > RON algorithm.

This is quite horrendous. If you cannot compute the OWCR from the
provided topology (CPUID on x86) 'nobody' is going to be using this.

Additionally, what locks are so contended that this gives a significant
performance gain, and can't we better rework the locking rather than the
lock implementation to alleviate this problem.

Eg. the futex hash lock is an oft cited example, but something like:

  https://lkml.kernel.org/r/20230721105744.434742902@infradead.org

can significantly reduce this.

That is, in general is helps more to reduce lock contention rather than
to optimize the contention behaviour.

So which locks do you see sufficient contention on to make this
worthwhile and how much do you gain by doing this?

Additionally, per the paper there are Linux patches (albeit for rather
old kernel versions), why aren't those included?



