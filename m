Return-Path: <linux-kernel+bounces-430533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35909E3236
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2D0163800
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53917156243;
	Wed,  4 Dec 2024 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="LesNnhwJ"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166581547CA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283819; cv=none; b=S1vJxVgj6D9IzHBVn1zle3eSam5Q1dV38Dwyn94hkJR3uVvkQeQXoi/JlJ9taMjfT8EAilo0d7GUW2kE/KMb39z2XCt1B9jAqa29cJvYstaeIzbINlEHZxPEyILe5SIk0Ide7ximHOt3S/52ngPuFd98A5J4t+6rRQa3J5hMFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283819; c=relaxed/simple;
	bh=+kQgx+gnUJbkShBpT4dRk72hfPx4Z/Q1SR5sEmPhons=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7XWsid5ZS1JBWEjyaOZOiPAlTVLOaK3kmJe4W6nIg+GyScXiW5Y80v8tZpBxu+e2VQnp9mVmeQ8bPBleeycBvOH6ac7uZJTCYRoBndnmdFpp4iutptv4Mnc8Sv58u4FQNfmbXm+3UBP0ETxOf8vl93z5z6Y7MJ/jzb9P0t5lq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=LesNnhwJ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8419f5baedcso202081039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 19:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1733283817; x=1733888617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGkT/pl1gB1Evs4ReRwjiJx5mPh/IBj5HFwD48IlujU=;
        b=LesNnhwJpSy1T9sLWdLo5mrghP+Qf0Kn0rRltwLpT/Wd0N1BGJ7StUZtcbTk+i4mDL
         zQ0wy6poNVxX4AL2/FdVZH3IGDI7E9FF8JcbihX3v/hOb7bNdKf/yCtQa0GWXMnAKnDJ
         k78c3nyRAm+noxkY6CGe6iwiz7cIOHPWthlf6kLTNaLs6+GfXgGXUWaaHBJhPYy47C26
         Pd+UIQ3jLy1fqbB7JB1RTaDQ0rlFMsfvDBVyQQDVPSnh5AbNa3E/0nczvAu5tCEg3H+z
         GeHEO3fhLzFaD/i5zOfY1uE+EXlj7gZx1DJ6HQHBwfuI/MFtCXlECWQCDVEBW9mKwD5p
         rsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283817; x=1733888617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGkT/pl1gB1Evs4ReRwjiJx5mPh/IBj5HFwD48IlujU=;
        b=pu6FmFSbrKI+39qu/jR4I4N0PO+/UpleEJ6IMSJOoj30KlyPzI4h6ib2OuJWghjTBx
         pUgDsvPdi1kSqnE279GtzLghSaB+sXljukOQ2I8HKBYSji3VOOOUTC73zvXjXB4rBznS
         /E3UC2jm9XLkfx+LpchhoU5xgSaYz2L3ZrXo9PHnSYhGXcGtyn9lYdJcNBoTpky6A/B8
         zB7Gy4M+9MMFd2z2MBy/hfNL100JxrwrYW2YDgyWWrTredpAb+NaoWo3wUnUi8Uh66HQ
         w4vFX1glCrS9bE2hX4cKy9Ll7l4s5nJqknztV5AkIrPQups+W0e/fH60U9NpXWgpjC9C
         yT2g==
X-Forwarded-Encrypted: i=1; AJvYcCVJY3S4T6xx2JU0V9dq9uOAfBOnvNYpwxwP8Md3aYog9+SApu2tkzvxOhVnnmtwZSry10zxE6Z4t4tLhig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCC2y8DWRBq2aXKVO25PvYMmIB2d+pSMMmVSJvsMKCgJulSbRW
	8ERLvj+S9420s6nM+cXxl//XluxvrMCSbpM1PQ1P8HqEo7+fTYTHz4mVfjfMoixn41gxs/zuAR6
	tWs+2A+WpIWAIAVFtFirAc6cFTiAuA0HWqxNt1A==
X-Gm-Gg: ASbGnctfv/mH7uTfmCbkQMdEols4P66VYwEIjzY/pt1GK5krxyaojmIy1XaqI+OLvID
	a/0unvVk4CfPuyHNubJTjpQXVo4oQMHWCAg==
X-Google-Smtp-Source: AGHT+IGWdFp8FF+1NtOQA0riwNaVCNa+lNq7c5BS40O1U8dW0QvsTp35bk3sIYPxMlaLCPGVX4HHb6tLAmO9iVR0CsU=
X-Received: by 2002:a05:6602:29c8:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-8445b5477f8mr665966539f.1.1733283817005; Tue, 03 Dec 2024
 19:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-18-ajones@ventanamicro.com> <87mshcub2u.ffs@tglx>
 <CAAhSdy08gi998HsTkGpaV+bTWczVSL6D8c7EmuTQqovo63oXDw@mail.gmail.com>
 <874j3ktrjv.ffs@tglx> <87ser4s796.ffs@tglx>
In-Reply-To: <87ser4s796.ffs@tglx>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 4 Dec 2024 09:13:24 +0530
Message-ID: <CAAhSdy27gaVJaXBrx8GB+Xr4ZTvp8hd0Jg8JokzehgC-=5pOmA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/15] irqchip/riscv-imsic: Use hierarchy to reach irq_set_affinity
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Jones <ajones@ventanamicro.com>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tjeznach@rivosinc.com, zong.li@sifive.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, atishp@atishpatra.org, alex.williamson@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:29=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Tue, Dec 03 2024 at 21:55, Thomas Gleixner wrote:
> > On Tue, Dec 03 2024 at 22:07, Anup Patel wrote:
> >> On Tue, Dec 3, 2024 at 7:23=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >>> Sorry, I missed that when reviewing the original IMSIC MSI support.
> >>>
> >>> The whole IMSIC MSI support can be moved over to MSI LIB which makes =
all
> >>> of this indirection go away and your intermediate domain will just fi=
t
> >>> in.
> >>>
> >>> Uncompiled patch below. If that works, it needs to be split up proper=
ly.
> >>>
> >>> Note, this removes the setup of the irq_retrigger callback, but that'=
s
> >>> fine because on hierarchical domains irq_chip_retrigger_hierarchy() i=
s
> >>> invoked anyway. See try_retrigger().
> >>
> >> The IMSIC driver was merged one kernel release before common
> >> MSI LIB was merged.
> >
> > Ah indeed.
> >
> >> We should definitely update the IMSIC driver to use MSI LIB, I will
> >> try your suggested changes (below) and post a separate series.
> >
> > Pick up the delta patch I gave Andrew...
>
> As I was looking at something else MSI related I had a look at
> imsic_irq_set_affinity() again.
>
> It's actually required to have the message write in that function and
> not afterwards as you invoke imsic_vector_move() from that function.
>
> That's obviously not true for the remap case as that will not change the
> message address/data pair because the remap table entry is immutable -
> at least I assume so for my mental sanity sake :)
>
> But that brings me to a related question. How is this supposed to work
> with non-atomic message updates? PCI/MSI does not necessarily provide
> masking, and the write of the address/data pair is done in bits and
> pieces. So you can end up with an intermediate state seen by the device
> which ends up somewhere in interrupt nirvana space.
>
> See the dance in msi_set_affinity() and commit 6f1a4891a592
> ("x86/apic/msi: Plug non-maskable MSI affinity race") for further
> explanation.
>
> The way how the IMSIC driver works seems to be pretty much the same as
> the x86 APIC mess:
>
>         @address is the physical address of the per CPU MSI target
>         address and @data is the vector ID on that CPU.
>
> So the non-atomic update in case of non-maskable MSI suffers from the
> same problem. It works most of the time, but if it doesn't you might
> stare at the occasionally lost interrupt and the stale device in
> disbelief for quite a while :)

Yes, we have the same challenges as x86 APIC when changing
MSI affinity.

>
> I might be missing something which magically prevent that though :)
>

Your understanding is correct. In fact, the IMSIC msi_set_affinity()
handling is inspired from x86 APIC approach due to similarity in
the overall MSI controller.

The high-level idea of imsic_irq_set_affinity() is as follows:

1) Allocate new_vector (new CPU IMSIC address + new ID on that CPU)

2) Update the MSI address and data programmed in the device
based on new_vector (see imsic_msi_update_msg())

3) At this point the device points to the new_vector but old_vector
(old CPU IMSIC address + old ID on that CPU) is still enabled and
we might have received MSI on old_vector while we were busy
setting up a new_vector for the device. To address this, we call
imsic_vector_move().

4) The imsic_vector_move() marks the old_vector as being
moved and schedules a lazy timer on the old CPU.

5) The lazy timer expires on the old CPU and results in
__imsic_local_sync() being called on the old CPU.

6) If there was a pending MSI on the old vector then the
__imsic_local_sync() function injects an MSI to the
new_vector using an MMIO write.

It is very unlikely that an MSI from device will be dropped
(unless I am missing something) but the unsolved issue
is that handling of in-flight MSI received on the old_vector
during the MSI re-programming is delayed which may have
side effects on the device driver side.

I believe in the future RISC-V AIA v2.0 (whenever that
happens) will address the gaps in AIA v1.0 (like this one).

Regards,
Anup

