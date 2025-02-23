Return-Path: <linux-kernel+bounces-527842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6511A41069
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3103F7A381E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED5315442D;
	Sun, 23 Feb 2025 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky8QMRLA"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0DE1519AF
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740331547; cv=none; b=O1Z0L/Zskh2g+2kFqA/Q6aCmV4/3dllLTjYXxry+7ttEW5NFaE6GQUL6FJ69hwsyGXzyOlktYf6aRAE2AiPE/USSvCFKd1EeWoM3kn/Fu7cXLKJHGKEmDp4Ajvt9VYEX4o/PX7rMcN13NgJ1oFsWs38Rv1E/GQ6ru1ZydTyx5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740331547; c=relaxed/simple;
	bh=oNisY2RRu8Zgalr0MAdoVoZtFX5e1zUzAKqy5iPznnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6C1iIC1EFHJy/xsi3cxBfKBL9sOwZnrlQXFh7RihBIYjX/VnCXNmSfgGO8oImwgU7QbOtUTsRJv6FGMqPjXfttm1OGIVDx8unPMeC1LCAJ3D8b28e5blaSaVHHjtmylkSJ98fWZq4Lj8NZmb9LacGpkib4X17fyhm7gQhZLPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky8QMRLA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so36832261fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740331544; x=1740936344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJF3SbGOeJGFf/tfMYVEGGk5++zaetIdPaxtzZT+rSA=;
        b=Ky8QMRLAl3BAb7vUWbeEtuM5SzpxfbonZXI9PzzHVo5R0NjrPCrzZY39gQsMkpOTTk
         f+9rzpPz9tK8F8CQK11862NNEwkiHTFz1f0Br9N5vKn4CHs76G+wEQPAGzgqxZbB9WCn
         kL+NMoGrf6hy1U+9hAOrMvUXOokYT8g1BZjDWyO44IeugIpt3wAlG4bs6gi9PlUQAo+Z
         ofanwt7ABTPbdFVzw9EcWauYqV+vsVY6WTrNSzbhOX1G0KF2bf0SKutamWW7XfCRfhzA
         zaHyJw+LrXgcUsXHGekx3yuydEGM+8zDkqlUl5bIE5AcD+CATnX9Ub4sXy0lTctU8BRB
         1c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740331544; x=1740936344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJF3SbGOeJGFf/tfMYVEGGk5++zaetIdPaxtzZT+rSA=;
        b=L8WrVejHYVmXnjJOhPt2u7/JrswjlfJF8KnoEhy9RRNCAJXCAxl6N8fto1e7MCj6IX
         juRHzmuZMcDoJtZTcW5012jgvwhNFBOYYGsHFYWALd4lF+2r34AIMJBogAhyspdn4qQH
         +ir2bU+9X/GzNlw3Q0JMF1JyU2E5T6i6/8oevRNA88tqAcFigOm4MGevYqrEy5c7rTO5
         4UrcQJyE1ibicYKnOPz7peYpVs4AYk682v1p9tDGeGfZJPInHhOPFq4OWEzP69ID5PjO
         e10a93hRBHht/j//tx+nPqzUlM/fd8Yo+UihftPyfyVO6tktcB1MUkGtQ0gH+F2R1nZp
         q/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWytmJ+nDneL8iQiy4PVrbh23cR8A44JTPCZzM9B48Awx2ObbeZN/H7Tod5S13lapxbRzColkvKk6f9v3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMehxOpO6+PawiZRoafWAajUvNSjfK9SuMai9a17mhjvp9MCV
	a0BdnMHzS/La7Ns92z01AwdB86oDe7UCCkQySA2EfpUQLFAYFmCULl5E8zK6PGrex/xzpqm72Z5
	t1oamXHIjGRpJATLjVh16C0cOnA==
X-Gm-Gg: ASbGncvNm4u9q7dtJrFgNH0p0BUMeQmFTOgUedZMQpedamLLMQOqqm8E/JyKyA2TsVk
	1y2nmtBLmKJkBJoSj2PiNCWPeBJXWowORXln1XfZqFAYG5LwgVk2nwDLKCaV+OiB+pQdqHfqePV
	dwJ7iYJvayndJ5AKKe0g4V9Q==
X-Google-Smtp-Source: AGHT+IFwEfZEHmpupL4RvpiCPdW8WE4LhgcrKh6ivZG9nmPen+/o1bMnIP0aUbxft0sW2KlFZNaiCDkngKasYhb9CFc=
X-Received: by 2002:a2e:900f:0:b0:308:efa4:d277 with SMTP id
 38308e7fff4ca-30a5b18ae7bmr33536371fa.15.1740331543792; Sun, 23 Feb 2025
 09:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222190623.262689-1-brgerst@gmail.com> <Z7rsOVaxhfCJdn2P@gmail.com>
 <CAMj1kXE51FSYQ6prL7M5vfy1KjJGiBAre3CH3G-L3CQj9YSq9A@mail.gmail.com> <CAFULd4YHj_Y7B4B8Mz5rwm3uB5GS=BhQny_eFhSSkdi=qg+qcA@mail.gmail.com>
In-Reply-To: <CAFULd4YHj_Y7B4B8Mz5rwm3uB5GS=BhQny_eFhSSkdi=qg+qcA@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 23 Feb 2025 12:25:32 -0500
X-Gm-Features: AWEUYZmDzPxWoSVtWBOX67cTQnbO2wnnBpHoX9JaNPUrvXgGACoALUT33_R2UgI
Message-ID: <CAMzpN2hYex-uuAZPZfA_8wz5t0Vn5hPcvi+2=aNbfc1POKyq=A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Add a percpu subsection for hot data
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 5:30=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Sun, Feb 23, 2025 at 11:20=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > On Sun, 23 Feb 2025 at 10:37, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > > Add a new percpu subsection for data that is frequently accessed an=
d
> > > > exclusive to each processor.  This is intended to replace the pcpu_=
hot
> > > > struct on X86, and is available to all architectures.
> > > >
> > > > The one caveat with this approach is that it depends on the linker =
to
> > > > effeciently pack data that is smaller than machine word size.  The
> > > > binutils linker does this properly:
> > > >
> > > > ffffffff842f6000 D __per_cpu_hot_start
> > > > ffffffff842f6000 D softirq_pending
> > > > ffffffff842f6002 D hardirq_stack_inuse
> > > > ffffffff842f6008 D hardirq_stack_ptr
> > > > ffffffff842f6010 D __ref_stack_chk_guard
> > > > ffffffff842f6010 D __stack_chk_guard
> > > > ffffffff842f6018 D const_cpu_current_top_of_stack
> > > > ffffffff842f6018 D cpu_current_top_of_stack
> > > > ffffffff842f6020 D const_current_task
> > > > ffffffff842f6020 D current_task
> > > > ffffffff842f6028 D __preempt_count
> > > > ffffffff842f602c D cpu_number
> > > > ffffffff842f6030 D this_cpu_off
> > > > ffffffff842f6038 D __x86_call_depth
> > > > ffffffff842f6040 D __per_cpu_hot_end
> > > >
> > > > The LLVM linker doesn't do as well with packing smaller data object=
s,
> > > > causing it to spill over into a second cacheline.
> > >
> > > ... now it's linker-ordered. But on the other hand that can be an
> > > advantage too: the linker will try to (or at least has a chance to)
> > > order the fields optimally for cache density, while the hand-packing
> > > always has the potential to bitrot without much of an outside,
> > > actionable indicator for the bitrot.
> > >
> >
> > The linker will need some help here - by default, it just emits these
> > variables in the order they appear in the input.
> >
> > If we emit each such variable 'foo' into .data..hot.foo, and define
> > the contents of the section as
> >
> > *(SORT_BY_ALIGNMENT(.data..hot.*))
> >
> > we should get optimal packing as long as the alignment of these
> > variables does not exceed their size.
>
> Is it possible to warn/error when data is spilled over the cache line?
> Previously, there was:
>
> -static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
>
> that failed the build in this case.

I think it should be a warning and not an error.  If it does spill
into a second cacheline the kernel will still boot and function
properly so it's not a fatal error, it just could hit performance a
bit.  By decentralizing this it does make it harder to account for
size, especially with conditional builds.  Unfortunately, the linker
script language does not have a WARNING() counterpart to ASSERT().


Brian Gerst

