Return-Path: <linux-kernel+bounces-243606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD092985A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0852823F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D525569;
	Sun,  7 Jul 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XrMFgfi5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jLwhdt4P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A6EDC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720362869; cv=none; b=rSODWSFL0XScP2vEvXPpjGzz3DyAk/DDm30YJ5XG5zZTcoTeo7RN/vUbrHnSDSN/xMrUvDFcILkCCqe2ASqSPTPFxSuAaJiGA9IgR4IjBHvN6ZWGpuAy9KEkOfSivkP3UJBsuZfFl5pu62CDnmMTQ168slMmNtgcyU13QGkI5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720362869; c=relaxed/simple;
	bh=VpbR1U4/APX17kDvuZzFM6O8thDFY4upsDEyCoY/fMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK7A7ikHv0xKkaUm2iN85/g500FSfFmTI7OrEhF47x6P1WCS9Qpl39fVE3AR6aQgKqcYmes7M6buNLp542TVqQPvXMaVcFuxS3SqZZD9THujSeMh9QnYq6VFBxkPf8DwKpapP6towHycxPSJC1jc9Yw/WbihHaCBLTUiX0Ucawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XrMFgfi5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jLwhdt4P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 7 Jul 2024 16:34:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720362858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT/JZYImBb6WANX1g7RQzC4oQ/TM5mv6H1+ZAVtcEXg=;
	b=XrMFgfi5+bmf2zFPnd/QIDWbDG4J9yVFcVeEfPFcGD2V4UOZ5ewOMdbVTHJblauCULN9Hb
	Z6m0AJLk0GWA4EVRGXXghlSQIzpCn4/o2i4ipiSbghedsxff4yPEI0b/esgvatT+A22uE4
	8w7tTDSwhaOphu6075MGsB/4iPHa4q7rxdQOFqZvM0O5Eqnn4cdptR3tjJWbcofNUHUw6z
	ZdFb//XUubzTHCc0StsOtP/zX7EW6ouxO3ef3jFi9kwwn0uGdZLGO+OJuQgYygrOJ98APw
	UUxzMePNtAty/VrAEMPjsI5oPTqkcEdTQASoupUBlOEg0fgahzXpwnRl94QcdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720362858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT/JZYImBb6WANX1g7RQzC4oQ/TM5mv6H1+ZAVtcEXg=;
	b=jLwhdt4P8vKkACKriOoBEVzOi4lnMiuf/wQLdPJZvmPN6T0VcKicgoqEPBoQvXE+Ew85ut
	9P7j3KfvcOFFCsBQ==
From: Nam Cao <namcao@linutronix.de>
To: Anup Patel <anup@brainfault.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	b.spranger@linutronix.de, Christoph Hellwig <hch@lst.de>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix plic_set_affinity() only
 enables 1 cpu
Message-ID: <20240707143414.0ydME30F@linutronix.de>
References: <20240703072659.1427616-1-namcao@linutronix.de>
 <CAAhSdy0ZGD-p0iBVPqHF0RKTwvAAMWwYZ0ufioRrO75JzSh1qQ@mail.gmail.com>
 <20240703123327.CvOiP2Jb@linutronix.de>
 <CAAhSdy3gZHnSwovxypY5vP438TNPj8h+miqtyBKhEUAdWj=htQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy3gZHnSwovxypY5vP438TNPj8h+miqtyBKhEUAdWj=htQ@mail.gmail.com>

On Wed, Jul 03, 2024 at 08:31:31PM +0530, Anup Patel wrote:
> On Wed, Jul 3, 2024 at 6:03 PM Nam Cao <namcao@linutronix.de> wrote:
> >
> > On Wed, Jul 03, 2024 at 05:28:23PM +0530, Anup Patel wrote:
> > > On Wed, Jul 3, 2024 at 12:57 PM Nam Cao <namcao@linutronix.de> wrote:
> > > >
> > > > plic_set_affinity() only enables interrupt for the first possible CPU in
> > > > the mask. The point is to prevent all CPUs trying to claim an interrupt,
> > > > but only one CPU succeeds and the other CPUs wasted some clock cycles for
> > > > nothing.
> > > >
> > > > However, there are two problems with that:
> > > > 1. Users cannot enable interrupt on multiple CPUs (for example, to minimize
> > > > interrupt latency).
> > >
> > > Well, you are assuming that multiple CPUs are always idle or available
> > > to process interrupts. In other words, if the system is loaded running
> > > some workload on each CPU then performance on multiple CPUs
> > > will degrade since multiple CPUs will wastefully try to claim interrupt.
> > >
> > > In reality, we can't make such assumptions and it is better to target a
> > > particular CPU for processing interrupts (just like various other interrupt
> > > controllers). For balancing interrupt processing load, we have software
> > > irq balancers running in user-space (or kernel space) which do a
> > > reasonably fine job of picking appropriate CPU for interrupt processing.
> >
> > Then we should leave the job of distributing interrupts to those tools,
> > right? Not all use cases want minimally wasted CPU cycles. For example, if
> > a particular interrupt does not arrive very often, but when it does, it
> > needs to be handled fast; in this example, clearly enabling this interrupt
> > for all CPUs is superior.
> 
> This is a very specific case which you are trying to optimize and in the
> process hurting performance in many other cases. There are many high
> speed IOs (network, storage, etc) where rate of interrupt is high so for
> such IO your patch will degrade performance on multiple CPUs.

No, it wouldn't "hurting performance in many other cases". It would give
users the ability to do what they want, including hurting performance as
you said, or improving performance as I pointed out earlier.

I am willing to bet that most users don't ever touch this. But if they do,
they better know what they are doing. If they want to waste their CPU
cycles, so be it.

My point essentially is that kernel shouldn't force any policy on users.
The only case this makes sense is when the policy is _strictly_ better than
anything else, which is not true here. What the driver should do is
providing a "good enough for most" default, but still let users decide
what's best for them.

Side note: if I am not mistaken, the effective affinity mask thing is for
hardware limitation of the chips who cannot enable interrupt for all CPUs
in the mask. RISC-V PLIC, on the other hand, can enable interrupts for any
CPU, and therefore should do so.

Best regards,
Nam

