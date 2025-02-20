Return-Path: <linux-kernel+bounces-523469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CAEA3D740
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5B119C1A31
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F11EFF9B;
	Thu, 20 Feb 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBc9qKOJ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6761D8A0B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048386; cv=none; b=K8agvGO9/u1frenwKDJ9W9cqP9IgCwHAOb/dYsdCMlgzfz1jj0tawN3HahMIACfzh6USk5SXRm+nOLYzrfGXs1KFvEZw1vxaGUDybIQvEBVKTYif/7Vfmsjxx9SU541zi11wQqFpXobh1ZE6Hu/Jt4tyf/R4IRi9b2SfuYwCEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048386; c=relaxed/simple;
	bh=xAZFrxLSN8RPCXsgDk+kHgqDcBaVsWZhjTDrUs/3FZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNvo/45z/PckLViHCntIOnizGT95ijvmdooaxiZtJz2sSdGPZdmni1s46VElG5Stlg4nkE6ClepqwOtfVcdqmprZCE7IKckX2prwlSr09rgxFl1jvbMvLScVAe9pNLjhFZxC5krDu57Py6grXnKJYOdiBvfvyd1yUok5YFHAFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBc9qKOJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-546237cd3cbso836659e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048382; x=1740653182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8idILOZ/fPctXYOBMjSZgICyNRwc2mDS3hxr4nZM8ws=;
        b=mBc9qKOJEkBMiMDkDvCV+mzx4aYeN7D69Wciz2AsF24NXn5l68mRHSUsboE6SWzIHh
         WVUqiF4+VVijbVnESp42hOXrziRedbcOOFmA9aIV8ttE/VTkSc1qQ0X/vlXBtIflfapb
         4TzoyN5bv68yES00570cg4Gkq0PjbFp+yWT5LuBcOrqRYBDiCwYFi5P77lvcK8Wm3pAo
         UtTFaTQE/HBpQE1x7GTfO5UvuJeu8+ADyS9S93x7gyLuEI1BP6/5rE4GMoR4S3+3yMtn
         XZx2WlPbWLQjlxfoRfpQkosFNV/yXxpBXLgDX091i+Zw7WaA1Sqx2uyp4CuFInLUw7bn
         DbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048382; x=1740653182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8idILOZ/fPctXYOBMjSZgICyNRwc2mDS3hxr4nZM8ws=;
        b=WGTo7fcnuB9x0wpSoChk9bBYjiXJdRzYQvHQnu+FaHVXiHWsmTDklfz+bGcZ/jiZVq
         MJYdP5h2Fb3eN1vgIeGnYlm1ZgdsV7XSP4FrqczKbUlHwhokTTKl4mlcbpaJ7EzBJ6qu
         lMLm7iNLjGY3ZB43iz+gwjTe/7n27bh8ee78QD2TKhvooYZle4tQofdUWEs6WZGXk9XT
         poNA+PWsSsnZ9A2aWR1IcKZT1AbJWzFkqHSfJQI6e3fBkuX5g7CPQsxWTwxh5G0xf2uH
         yCRpHHjyXQHL2QTaOZi5r7FlJTY5u/u4ZoC13waf4ZuJsiAMVDY0z67YS3gbD8YdeOWo
         nswQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP3QqSd9MkZFR4/H7Uz+XHxwIAloQ4DTFkzSew/WhRsSg3O7u1C3b143OuNIB3RJtL/a8RLFzkPC4hUOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfAdIfmpE3o/5frf+A4gHRHDxsAU91OzxG7CdAHpFiLHlNmu1
	Iq6r0GmVy+XK6RHB2+xEXRdw4//dsDadYkIL723Cclsj+Ji/rtq0mIZm6dk1jADk9upl3dIOd4h
	Psf513BMXGouHT/u4p6Ni26rRxDg=
X-Gm-Gg: ASbGncv5y5IgF9bjQGKg2wJcA2PLcX4z6fq8eK+HISfHy3CFUHGeRotYS0fbs8vTTtN
	FQ1aVFNDG/VfBY+ICAS2OwA42/Hg0sI8Pef8Bg+qS6wA00aDwuvn8RDvd+affg23khQEUcI2W
X-Google-Smtp-Source: AGHT+IHvHBUkVejI2IwAOirviWKcfLa9CMxZvmL9LX4MIbXDD4K6zbZEWsOZoKz0BBNjG/spSISAyWIDQ41Ltt+mx88=
X-Received: by 2002:a05:6512:3992:b0:545:2d27:5ae1 with SMTP id
 2adb3069b0e04-5452feae86fmr6413557e87.53.1740048382191; Thu, 20 Feb 2025
 02:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com> <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com>
In-Reply-To: <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 20 Feb 2025 11:46:10 +0100
X-Gm-Features: AWEUYZnzrXD8CAi9-uaBj-4MbNgn_eYCw_NwC7BR4ti_YteTes54MT89lYLVmRs
Message-ID: <CAFULd4aYjnWzWaN8WA0LetN1Li7F8MY3qnxbhY8=tNFxqHCP1w@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:05=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> Hi Uros,
>
> On Thu, 20 Feb 2025 at 10:51, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Wed, Feb 19, 2025 at 2:18=E2=80=AFPM Brian Gerst <brgerst@gmail.com>=
 wrote:
> > >
> > > On Wed, Feb 19, 2025 at 6:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org=
> wrote:
> > > >
> > > >
> > > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > > > Thank you for doing this series - it all looks pretty good from=
 my
> > > > > > side and I've applied it experimentally to tip:x86/asm. I fixed=
 up
> > > > > > the trivial details other reviewers and me noticed.
> > > > > >
> > > > > > Note that the merge is tentative, it might still need a rebase =
if
> > > > > > some fundamental problem comes up - but let's see how testing g=
oes
> > > > > > in -next.
> > > > >
> > > > > I wonder if there would be any benefit if stack canary is put int=
o
> > > > > struct pcpu_hot?
> > > >
> > > > It should definitely be one of the hottest data structures on x86, =
so
> > > > moving it there makes sense even if it cannot be measured explicitl=
y.
> > > >
> > >
> > > It would have to be done with linker tricks, since you can't make the
> > > compiler use a struct member directly.
> >
> > Something like the attached patch?
> >
>
> Interesting take. I'd have tried to put the canary at offset 0x0, and
> simply use pcpu_hot as the guard symbol.
>
>
> > It boots and runs without problems.
> >
> > However, when building the kernel, I get "Absolute relocations
> > present" warning with thousands of locations:
> >
> >   RELOCS  arch/x86/boot/compressed/vmlinux.relocs
> > WARNING: Absolute relocations present
> > Offset     Info     Type     Sym.Value Sym.Name
> > ffffffff81200826 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> > __ref_stack_chk_guard
> > ffffffff81201493 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> > __ref_stack_chk_guard
> > ffffffff81201714 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> > __ref_stack_chk_guard
> > ffffffff81201d66 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> > __ref_stack_chk_guard
> > ...
> > ffffffff834e2a13 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> > __ref_stack_chk_guard
> > ffffffff834e2a6a 0003259e00000002 R_X86_64_PC32 ffffffff8350f620
> > __ref_stack_chk_guard
> >
> >   RSTRIP  vmlinux
> >
> > which I don't understand. Looking at the first one:
> >
> > ffffffff8120081d <force_ibs_eilvt_setup.cold>:
> > ffffffff8120081d:    48 8b 44 24 08           mov    0x8(%rsp),%rax
> > ffffffff81200822:    65 48 2b 05 f6 ed 30     sub
> > %gs:0x230edf6(%rip),%rax        # ffffffff8350f620
> > <__ref_stack_chk_guard>
> > ffffffff81200829:    02
> >
> > I don't think this is absolute relocation, see (%rip).
> >
>
> The warning is about the type of __ref_stack_chk_guard, not about the
> type of the relocation.

Thanks, I got distracted by the text of the warning that mentions relocatio=
n.

> $ nm vmlinux |grep \\s__ref_sta
> ffffffff8350c620 A __ref_stack_chk_guard
>
> Without your patch:
>
> $ nm vmlinux |grep \\s__ref_sta
> ffffffff834fba10 D __ref_stack_chk_guard

Is this a problem in our specific case? While the symbol is absolute,
the relocation is still relative, so IMO it should be OK even with
your ongoing rip-relative efforts in mind.

We can list the symbol in arch/x86/tools/relocs.c to quiet the
warning, but I would need some help with auditing the symbol itself.

OTOH, we could simply do it your way and put stack canary at the
beginning of pcpu_hot structure, with

static_assert(offsetof(struct pcpu_hot, stack_canary) =3D=3D 0));

for good measure.

Uros.

