Return-Path: <linux-kernel+bounces-442826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27299EE27D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3797284179
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B38120E01B;
	Thu, 12 Dec 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPY+M4Ev"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136CA204C36
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995151; cv=none; b=O3YnlYsRjHktdIWdaOiHYQr84DD3HwMUqRQ50GJOhKcmCNw6jX9OnxiCE8R8mO5EkZ+pPdYe32W52uBvAZWREYbwFSmaHntZoTsTDOuzg0L33zbfqnP74oY/9uVZS/KNAD2rgkoLPREqBjqy8YAP8uPNCbOsN1c9sMbY1r7G83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995151; c=relaxed/simple;
	bh=c/rmTbU+GJWgA3he8Ah/ZUdi0VIhRgyvy/SJqXEbMK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqVr1mdU0Pp7xjzuYKG1WpPSrgrZXr1DXEGqQZSf0V5n9GeZcd+gHanH2pV3IK0P2rGHV7PDIEoUTn1VGuGyoGUlwtQY1k4lfmQOlF5D9YLHJr/DM5WJ9Vmfr3gYl8ev4dKd4TbBaSq2H7DgzSVgVcAHNGSMrRE9/F17NlUOT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPY+M4Ev; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3863494591bso165179f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733995148; x=1734599948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0a9uVHj0MFII1RtSBeG+K+r0Fep1zBrIePBFN8AAic=;
        b=JPY+M4EvgvRusl36tzanpqjHQzDEBgPSGXrod/cSgR6gwXeuJCqb7wi2zIRef4f/Rx
         Kh5lCXny7yT5hOQp13evH3qzbD81L1QceJt5xnkVtn6cnyEN6wjGWIAIZoPUT59MKTex
         nEU8/W5grrk2Xz4+wiX0az8djCezffm6n7S/ccVJATlyQ+6eSWDrLwEyc51bUnS1Op+Y
         p0I5SLtcpGH+4qEzSWt+puuqK0yOO1JkPKRc609NevApfkQB1hPdqk9VsfzGeL9B8oEN
         nwxV0EscnaXC41oh608QvMdgfkm0Y9dlbOhnokX/htCKvj2XxW2kuGl1BCINk1yuf8g5
         tRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995148; x=1734599948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0a9uVHj0MFII1RtSBeG+K+r0Fep1zBrIePBFN8AAic=;
        b=QUxcf+lhgz45zxcMIbKUeRB1c+a+sgXJGxuYU6+rkrCbXQnRkEiVUOUrVgxCq8lakX
         DLybwVQLPKc7pOMkhOzdWXfTY3deBsxwHtbelSfWqTig3SOuqSiW5QbkFUfUplfrZzjV
         b3PCle/Jqa7kLGkPmmpjHXo9lcd0NA23GlBWkxvU6/lVlb6xZMz6rH3LjlhIFzflWJ1d
         su4qRspgZKHU0CFeTVbDiC2aADeh4p5x/Lttw3esKBTbA1Yuxx8st2dEtyl/iEFzaB9Z
         rBWogxLs0TCl6+UTIUqU+Ooei7fUuE8tX8PJ+tGymxyC0+TG8gBUVYrfLKy1hVSAyNmD
         HJCA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Lx8v30PB+xWa60yC7arhOp0Ny5ZoTwfdk3prpqignfEDzlvjucJ/RgNRDzYRK3Og/4awfl/Oxa0XX8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwglyxRSLI1mIeHPXMXLNP4QAtShf8HVsqnMYKDCDPtxmje/6Dd
	laqotD7eauWysS3O0MG2fX1scFcLM2226U4xmmCRmqDFdB1NUDW5SRyjXOphc5QidTeFahic5mT
	RSdXGPGZZuCjYAk+Vai7bGg3gtPTPJ7CNLkw=
X-Gm-Gg: ASbGncs4euSL/vFo0/kJUmNeCp6YGFiyjgRdFsw9ef6cYB78eu/e97d0p2EPfVtDaWm
	lbguPYiLppB3+mdhy9gN6yBlOKVLwjR/DwySYBss=
X-Google-Smtp-Source: AGHT+IHgSIGyFnE08dyyP5NFrnFmPIIBGih2q0tSX3ULomU1UQVEgWDpmRj4F49p7i9YNu4ESNPLZDHhphuv4WV+WZs=
X-Received: by 2002:a5d:47c6:0:b0:385:f062:c2df with SMTP id
 ffacd0b85a97d-3864ce4968emr5512699f8f.11.1733995148067; Thu, 12 Dec 2024
 01:19:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rMfhZOCT+7Ki14vUs+dZbv9cxCZ0s+jgn6=_om4NTgo_A@mail.gmail.com>
 <86cyi5tanz.wl-maz@kernel.org>
In-Reply-To: <86cyi5tanz.wl-maz@kernel.org>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Thu, 12 Dec 2024 17:18:56 +0800
Message-ID: <CAJNi4rPDVXS3Ft3nHLXvMzHmn9d10Nz4Pxeduoe+v5HaK=CEAg@mail.gmail.com>
Subject: Re: Question about interrupt prioriyt of ARM GICv3/4
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Mark Rutland <mark.rutland@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	richard clark <richard.xnu.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi M,

On Fri, Dec 6, 2024 at 5:37=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 06 Dec 2024 08:33:11 +0000,
> richard clark <richard.xnu.clark@gmail.com> wrote:
> >
> > Hi,
> > Currently seems the GICv3/4 irqchip configures all the interrupts as
> > the same priority, I am thinking about to minimize the latency of the
> > interrupt for a particular device, e.g, the arm arch_timer in the RTL
> > system. The question is,
> > 1. Why don't we provide a /proc or /sys interface for the enduser to
> > set the priority of a specific interrupt(SPI/PPI)?
>
> I'm afraid this really has nothing to do with any particular interrupt
> architecture.
>
> Before thinking of exposing the interrupt priority to userspace, you
> should look at what this translates into for the kernel once you allow
> interrupts to be preempted by another one with a higher priority.
>
Interrupt priority doesn't necessarily mean the preemption, seems
you're talking about the interrupt preemption harm according to your
statement followed.Frankly I am just thinking higher priority will win
the lower ones in case massive external interrupts received in the GIC
level (you see I am still talking about GIC, not kernel)
>
> This means that at every point where you would normally see a
> local_irq_save(), spinlock_irqsave() or equivalent, you would need to
> explicitly specify the priority that you allow for preemption. You
> should then make sure that any code that can be run during an
> interrupt is reentrant. You need to define which data structures can
> be manipulated at which priority level... The list goes on.
>
irqsave just masks the interrupt from the point of cpu, I don't think
it will mess things up if preemption really happens (no? then what the
side-effect is for the nested interrupt handling in the softirq part.
damage the semantic of the lock primitives?)
>
> If you want a small taste of the complexity, just look at what
> handling NMIs (or even pseudo-NMIs in the case of GICv3) means, and
> generalise it to not just two, but an arbitrary range of priorities.
>
> If you want the full blown experience, look at the BSDs and their use
> of spl*(). I don't think anyone has any plan to get there, and the RT
> patches have shown that there is little need for it.
>
As supplement=EF=BC=8Cthe fiq is suggested to be used as an alternative to =
the
higher priority in the RT area...
>
> > 2. Is there any way to verify the higher priority interrupt will have
> > more dominant to be selected to the CPU (IOW, the priority is really
> > working) in case of multiple different interrupts asserted to the GIC
> > at the same time(some debug registers of GIC like GICD_REEMPT_CNT :-)
> > to record higher priority wins)?
>
> The GIC architecture makes no promise that the interrupt you
> acknowledge is the highest priority pending interrupt, because this is
> by definition a very racy process.
>
> Also, even on busy systems, you will very rarely see two interrupts
> targeting the same CPU being made pending at the same time, so that
> the interrupt delivery system would have to arbitrate between the two.
> That's because interrupts are vanishingly rare in the grand scheme of
> things.
>
1. I am trying to stress the external interrupts to the core#0 via the
stress-ng tool with one of interrupt being configured as higher
priority to see the benchmark data, it's time consuming as you can
image, still is in progress(BTW, I can't see any lockup similar hang
in the system with a higher priority configured)
2. This raises a very interesting question and I am also very curious
about is, what is the purpose for the GIC to introduce the interrupt
priority features, a placeholder feature reserved for the future? Ah,
hardware prefer to provide more functionalities than its being
actually used by software, any other justification except that?
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

