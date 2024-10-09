Return-Path: <linux-kernel+bounces-357800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C381199763D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AEF1C21C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D41E1A30;
	Wed,  9 Oct 2024 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mheTBNAL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iNvpsPRq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90C1714A4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504836; cv=none; b=HNn/xkEdzsgpru7SdJMsm1wyvPh8nXTLGiApSGLgn+Y6zrNoqCd7FP2YZmKqAObM6OOLQOmuzalce5wquTEDz/sZN/jhA2sMAhNpcIuZTjSoGxfXhgGblHx8sURuOQkQdNH1zBuCGWepMjMiDIoLUC7qOo+48dDcbL8weUMTk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504836; c=relaxed/simple;
	bh=FmYTJs7FUmlmO3yfdAvjWYGI4WitjfjCDO9WZmNUzLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kD3VDrdeJ677D4h4RDML7nx+nMjOL1et8q1EGPXbM5CliHIq/mrmrr7BEJs/XPu7oHNh4oO/FeKxOGIDx33StV1E+nKMuF2igN3dkx4/dDAXTul+krVJCDF/5Nt/IaJcWoM3djhHNL4/seMg+tRGurw69bO2xUnwH26qNx/lGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mheTBNAL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iNvpsPRq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728504832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuOXTpu41mQ0uytKHnV4FGfOF/obO6wI0JWD76mUgP0=;
	b=mheTBNALlV9LXEZ6IZc0UpMvSh9UDQK3L+Fl10ysCvRAeo2UM6+3qthGFKgRiVjn6VFdzt
	YNKoyX2pBOY9Q6iJIWfFRehBjOh9SmyFnyUMisI8dQn8agCjA1tzp4Tv0Qlh5s7CjE8mrm
	vQte46m7x9VHmJuj7RNycPER34b5iblD50iYvEDgdXIgzRBdLgsmFj7TAP8gmhhGFMk66I
	w9KqV+iGOOEW9jtrmcdcBTs82YsnkEY/1EUlIx9u9oziXOcgj0UoudUPZDHuCOT9ZyFzCS
	LKZKZFv35h5Ckr6fbsnkCCFAphIgE/EbpHQihDJK0vppf9reoAyn+kP7T2dOtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728504832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuOXTpu41mQ0uytKHnV4FGfOF/obO6wI0JWD76mUgP0=;
	b=iNvpsPRq0fZRl6FDPeKswIC1QIH2KtXWIGnq+6yyRk0AR0KRayXR5ZyOlXo4wAP0lAjsrf
	oz92/eFkg4CBSQBA==
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ankur Arora
 <ankur.a.arora@oracle.com>, mingo@kernel.org,
 linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
In-Reply-To: <20241009100133.2569e2a7@gandalf.local.home>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home>
Date: Wed, 09 Oct 2024 22:13:51 +0200
Message-ID: <87h69lqbk0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09 2024 at 10:01, Steven Rostedt wrote:
> On Wed, 9 Oct 2024 10:02:02 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Wed, Oct 09, 2024 at 08:20:19AM +0200, Sebastian Andrzej Siewior wrot=
e:
>> > On 2024-10-08 21:40:05 [-0700], Ankur Arora wrote:=20=20
>> > > > While comparing this vs what I have:
>> > > > - need_resched()
>> > > >   It checked both (tif_need_resched_lazy() || tif_need_resched()) =
while
>> > > >   now it only looks at tif_need_resched().
>> > > >   Also ensured that raw_irqentry_exit_cond_resched() does not trig=
ger on
>> > > >   lazy.
>> > > >   I guess you can argue both ways what makes sense, just noting=E2=
=80=A6=20=20
>> > >=20
>> > > I think we want need_resched() to be only tif_need_resched(). That w=
ay
>> > > preemption in lazy mode *only* happens at the user mode boundary.=20=
=20
>> >=20
>> > There are places such as __clear_extent_bit() or select_collect() where
>> > need_resched() is checked and if 0 they loop again. For these kind of
>> > users it would probably make sense to allow them to preempt themself.
>> > We could also add a new function which checks both and audit all users
>> > and check what would make sense base on $criteria.=20=20
>>=20
>> Do we really need this -- wasn't the idea to have thing 'delay' until
>> the actual NEED_RESCHED bit gets set?
>
> If we think about it as what would happen with the current PREEMPT_NONE,
> wouldn't need_resched() return true as soon as NEED_RESCHED is set? That
> means, with PREEMPT_AUTO, it should return true if LAZY_NEED_RESCHED is
> set, right? That would make it act the same in both cases.

I don't think so. Quite some of these need_resched() things have been
sprinkled around to address the issues with PREEMPT_NONE.

We need to look at those places and figure out whether they need it when
LAZY is enabled. There might be a few which want to look at both flags,
but my expectation is that those are less than 5% of the overall usage.

Peter's choice is the right one. That forces us to look at all of them
and figure out whether they need to be extended to include the lazy bit
or not. Those which do not need it can be eliminated when LAZY is in
effect because that will preempt on the next possible preemption point
once the non-lazy bit is set in the tick.

Remember, the goal is to eliminate all except LAZY (RT is a different
scope) and make the kernel behave correctly to the expectation of LAZY
(somewhere between NONE and VOLUNTARY) and non-LAZY (equivalent to
FULL).

The reason why this works is that preempt_enable() actually has a
meaning while it does not with NONE.

Thanks,

        tglx

