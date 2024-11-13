Return-Path: <linux-kernel+bounces-407950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372D9C7819
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D4BB22BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6A1632F8;
	Wed, 13 Nov 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p3MHq2dx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOAEwgcW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B413CA93
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513036; cv=none; b=A5X+SGUqw4zMejRgDIVGRjbH2v/eC1CzkGlgFUKquFJ2K88Sziv41Z6iaKbCFLtFwNnz1Ost1iXJ8rCtZv/A7kmwoouz/Yrz4HVBgMY69ka98HzXAuROEyAXoq7ednEJueHuviwLdkl67/g8EfMLMuVaMzMWB8WmV45w80zxotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513036; c=relaxed/simple;
	bh=AGdsQOT0QDEPfL4dXt+G4OI7pKpsFZyI0ecE7ntH9zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2M3n5YuKalzjpRxBuk4EWavthrVE6qIqkzhEokilfEyku/7h+tifOMFD5PmgyFqKbzAkGvLo0yw54zMzCVS0NuXJj/1bLvS7pWJ1lxuqYJZ7XE5Lv7wg3JInvV6FojERRcfN2OZiveopKUF48xiIpDlIhu/csovxVM/UvVHCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p3MHq2dx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOAEwgcW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731513032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9SrnhXk1Z16aVoDKXjON0t13FP8u8SERSsVFZ1+pjA=;
	b=p3MHq2dxSUiHRUkeBvY34fOcd2EmLqv9Fk7DtZTCVDSAMF1/sFjKiCFPxqnh00W0304kP8
	7ZSw7oUBi8YtLM4I3VAa3o1/87ITSLdrxlzrtpfnAikSXhszGzJzG6rT4V4t4XRMTpWARP
	5blh1ki9ZQCz6EQ/x6VOsI+EXT2l9CWiMiP2o1CTw8cLFI9jN8VxvYi4FLRiAYmaF6FNYT
	6+Bc9oAnmQyeM7jP78uHbfwDCA8PpFBYaG0zPO/wNfOBhmGMhjQqWLGUnHx1haa8gzv62o
	zEpF8wLwqDdYniKFrNw0kkgpiOxG2cfchW5BhGQUkzZbzSk/1Kf+lybwyQULug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731513032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9SrnhXk1Z16aVoDKXjON0t13FP8u8SERSsVFZ1+pjA=;
	b=IOAEwgcWq9mtzFUlCO6BWbRu3U1rqTvMqzmIX/9X+8U4k99YW6IF0cajAx+v3AtINRlIcb
	z06p1uA2sNDU69Ag==
To: Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: can/should a disabled irq become pending?
In-Reply-To: <c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
References: <io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz2a2@orquwgflrtyc>
 <87r07gmej2.ffs@tglx>
 <nlzd7endwgf46czretmoqlck3fjp5vnvnkv2tsyql632ym5bfo@phr3ggjyx633>
 <87ldxnn6mp.ffs@tglx>
 <c12201672bf99729caada3e8c8f61ad7f4612a23.camel@gmail.com>
Date: Wed, 13 Nov 2024 16:50:34 +0100
Message-ID: <87servku9h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13 2024 at 11:34, Nuno S=C3=A1 wrote:
> On Wed, 2024-11-13 at 04:40 +0100, Thomas Gleixner wrote:
>> The interrupt does not get to the device handler even in the lazy
>> disable case. Once the driver invoked disable_irq*() the low level flow
>> handlers (edge, level ...) mask the interrupt line and marks the
>> interrupt pending. enable_irq() retriggers the interrupt when the
>> pending bit is set, except when the interrupt line is level triggered.
>
> There's something that I'm still trying to figure... For IRQ controllers =
that=C2=A0not
> disable edge detection, can't we get the device handler called twice if w=
e don't set
> unlazy?
>
> irq_enable() - > check_irq_resend()
>
> and then
>
> handle_edge_irq() raised by the controller

You're right. We should have a flag which controls the replay
requirements of an interrupt controller. So far it only skips for level
triggered interrupts, but for those controllers it should skip for edge
too. Something like IRQCHIP_NO_RESEND ...

> Or is the core handling this somehow? I thought IRQS_REPLAY could be
> doing the trick but I'm not seeing how...

IRQS_REPLAY is just internal state to avoid double replay.

>> On controllers which suffer from the #2 problem UNLAZY should indeed be
>> ignored for edge type interrupts. That's something which the controller
>> should signal via a irqchip flag and the core code can act upon it and
>> ignore UNLAZY for edge type interrupts.
>>=20
>> But that won't fix the problem at hand. Let's take a step back and look
>> at the larger picture whether this can be reliably "fixed" at all.
>>=20
>
> Yeah, I'm still trying to figure when it's correct for a device to do UNL=
AZY? If I'm
> understanding things, devices that rely on disable_irq*() should set
> it?

Not necessarily. In most cases devices are not re-raising interrupts
before the previous one has been handled and acknowledged in the device.

> Because problem #2 is something that needs to be handled at the
> controller and core level if I got you right.

Yes. We need a irqchip flag for that.

>> > Ack. If there is no way to read back the line state and it's unknown if
>> > the irq controller suffers from problem #2, the only way to still
>> > benefit from the irq is to not use IRQ_DISABLE_UNLAZY and only act on
>> > each 2nd irq; or ignore irqs based on timing. That doesn't sound very
>> > robust though, so maybe the driver has to fall back on polling the
>> > status register and not use irqs at all in that case.
>>=20
>> Actually ignoring the first interrupt after a SPI transfer and waiting
>> for the next conversion to raise the interrupt again should be robust
>> enough. The ADC has to be in continous conversion mode for that
>> obviously.
>>=20
> Might be the only sane option we have, Uwe? If we do this, we could be
> dropping valid samples but only with controllers that suffer from
> #2.

No. You have the same problem with the controllers which do not disable
the edge detection logic.

The interrupt controller raises the interrupt on unmask (enable_irq()).
Depending on timing the device handler might be invoked _before_ the
sample is ready, no?

Thanks,

        tglx



