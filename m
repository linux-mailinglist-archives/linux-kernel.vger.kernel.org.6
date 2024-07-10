Return-Path: <linux-kernel+bounces-248214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150892D9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A765B223E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B094219644B;
	Wed, 10 Jul 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G6aiDFt4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5+dzHl9g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4C82D69
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642804; cv=none; b=B1zsMeBuU57JEvZV2/mhR0o0w8Qm9HzCkICtjR36WAj6ekvZYgXG3wnuKQQ8lWB+hwzjv5Gqv+T9jhCzi+lLzQcHHVXwGqAgDRPKcsoF3ufsTPy1Xb+o+oKv4m5VsaDfXaBUKB11I2Dus3NpOSEv9V4OsjYWHszt5bLR5hbXS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642804; c=relaxed/simple;
	bh=h/GxLIwyES+pnnON57gG6KMzcUdU/Y2kBp9Ou625mfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W6NiauD+dNzjRNUT9RDrnVgalaH0T5JuT7Bdj+JEnq8l3rkGA0o0g4094C34tv+J1u8JFS6XM1k/6+nwm3+DkyZ3jRjaWGj2gpDpYZnlBNTniweJlD84zm0UwfAek3KFuxZMXwUMb2AkCNgqbe+awjMTTaOIIkK4lsPZ36XBdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6aiDFt4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5+dzHl9g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720642794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnXG/JKnLr0h3GlU+atLgTzdvWjSnxPK3E+F8E/BRZs=;
	b=G6aiDFt4rNn4UQrLnfHUgYntl2CfqT4zHBB204F0OGZ+M1orepDmsL+mdL9rxlgI04L3JT
	Vl9CTFuy86iHF8aYpj8t/Au6D6waRaunydEwtg5C9eJ9SRb4ON65NmP/PTRz8qBVD/hsoJ
	bXYxb+IYo5QQImFP/WT08y5+oZLyHm4QxiFReFcvlEIfk8mNJEmOr0dnWYP9PlVQBIduWS
	iQfIwlt2zLlAG1QInGCPry44EIRWJt1bTBQ807OL2IXnIWEFhBlRBUvgsPQFVAzF//MQCU
	rzR4HTF+B7e27FIp4yllE9SuHJc0LruobIF1lml7HQy6CdHd7vB+wk4ScRqCPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720642794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnXG/JKnLr0h3GlU+atLgTzdvWjSnxPK3E+F8E/BRZs=;
	b=5+dzHl9gS4zPz4CthMByS7+DAK8Ls62Xy0hCLFVPloiS+oMzYph8RAU8IblWvRlf9bi3/f
	VgtIzNFJKFMJBUBg==
To: Nam Cao <namcao@linutronix.de>, Anup Patel <anup@brainfault.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland
 <samuel.holland@sifive.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, b.spranger@linutronix.de, Christoph
 Hellwig <hch@lst.de>, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix plic_set_affinity() only
 enables 1 cpu
In-Reply-To: <20240707143414.0ydME30F@linutronix.de>
References: <20240703072659.1427616-1-namcao@linutronix.de>
 <CAAhSdy0ZGD-p0iBVPqHF0RKTwvAAMWwYZ0ufioRrO75JzSh1qQ@mail.gmail.com>
 <20240703123327.CvOiP2Jb@linutronix.de>
 <CAAhSdy3gZHnSwovxypY5vP438TNPj8h+miqtyBKhEUAdWj=htQ@mail.gmail.com>
 <20240707143414.0ydME30F@linutronix.de>
Date: Wed, 10 Jul 2024 22:19:54 +0200
Message-ID: <87r0c1uhhx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 07 2024 at 16:34, Nam Cao wrote:
> On Wed, Jul 03, 2024 at 08:31:31PM +0530, Anup Patel wrote:
>> On Wed, Jul 3, 2024 at 6:03=E2=80=AFPM Nam Cao <namcao@linutronix.de> wr=
ote:
>> > Then we should leave the job of distributing interrupts to those tools,
>> > right? Not all use cases want minimally wasted CPU cycles. For example=
, if
>> > a particular interrupt does not arrive very often, but when it does, it
>> > needs to be handled fast; in this example, clearly enabling this inter=
rupt
>> > for all CPUs is superior.

It's not really superior at all.

The problem is that a single interrupt is delivered to multiple CPUs at
once and there is no mechanism in the hardware to select one CPU from
the given set which can handle it quickly because it does not have
interrupts disabled. The spec is clear about this:

"The PLIC hardware only supports multicasting of interrupts, such that
 all enabled targets will receive interrupt notifications for a given
 active interrupt. Multicasting provides rapid response since the
 fastest responder claims the interrupt, but can be wasteful in
 high-interrupt-rate scenarios if multiple harts take a trap for an
 interrupt that only one can successfully claim."

It's even worse. $N CPUs will in the worst case congest on the interrupt
descriptor lock and for edge type interrupts it will cause the interrupt
to be masked, marked pending and the handling CPU is forced to unmask
and run another handler invocation. That's just wrong.

Aside of that this can cause the loss of cache and memory locality in
high speed scenarios when the interrupt handler bounces around between
CPUs.

>> This is a very specific case which you are trying to optimize and in the
>> process hurting performance in many other cases. There are many high
>> speed IOs (network, storage, etc) where rate of interrupt is high so for
>> such IO your patch will degrade performance on multiple CPUs.
>
> No, it wouldn't "hurting performance in many other cases". It would give
> users the ability to do what they want, including hurting performance as
> you said, or improving performance as I pointed out earlier.

Kinda, but you make the bad case the default for very dubious benefits.

I grant you that the current implementation which defaults everything to
CPU0 is suboptimal, but that's an orthogonal problem. E.g. X86 selects
the single target CPU from the mask by spreading the interrupts out
halfways evenly.

But if you really care about low latency, then you want to selectively
associate interrupts to particular CPUs and ensure that the associated
processing is bound to the same CPU.

> I am willing to bet that most users don't ever touch this. But if they do,
> they better know what they are doing. If they want to waste their CPU
> cycles, so be it.

That's not what your patch does. It defaults to bad behaviour.

> My point essentially is that kernel shouldn't force any policy on users.
> The only case this makes sense is when the policy is _strictly_ better th=
an
> anything else, which is not true here. What the driver should do is
> providing a "good enough for most" default, but still let users decide
> what's best for them.

See what I explained you above. Changing this to multi-CPU delivery is
not really good enough and there is a valid technical reason not to do
that.

> Side note: if I am not mistaken, the effective affinity mask thing is for
> hardware limitation of the chips who cannot enable interrupt for all CPUs
> in the mask. RISC-V PLIC, on the other hand, can enable interrupts for any
> CPU, and therefore should do so.

It's not only hardware limitations which cause architectures to limit
the CPU mask to a single target. On X86 systems which support logical
destination or cluster mode this was disabled even though the 'multiple
CPUs try to handle it' problem is mitigated in hardware. The benefit is
marginal for the common case and is not sufficient for the low latency
requirements case.

Using a spreading algorithm for the default case will help for the
common case, but won't be sufficient for special latency sensitive
scenarios. Those are the scenarios where the user needs to take care and
set the affinities correctly.

Thanks,

        tglx

