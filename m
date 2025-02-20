Return-Path: <linux-kernel+bounces-524381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6DBA3E282
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5B93A7BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77657211A0E;
	Thu, 20 Feb 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9XwV5Oa"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF91C0DED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072291; cv=none; b=tI1bAeu/ZhOIzrb7Iks6G6cuJAOaTs0v5YytBmH7sFAlGX0fqxAriBtt7qe47G+fWG9RZonVDRzv9Ps3Hz7tgVyxmFqMMHjiGBsoWKRmq6pDY5i29jzC6Eg1L/+NBpaTqSgeYn0A0xs0AItaqe2CkCAkQFpXOxD9l0eFAcIzoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072291; c=relaxed/simple;
	bh=uYSHKsrKSduGu7avLSE4e6T1A5acNPfUzU821FxZCx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQZi4SKgrraXWn7ynP3qjm12G6ArILDv24+DyU7ewX1zyqwwV0GoYlcq36WOJNfmRJEKNf6KWhtwEAcO/6IGz5JHLYiBOpoNC6ZHCgCY3ZYHr5s/QHgOUH5hrKR0l9r0LuzcGdnm6u0PmHWtBTf+8M4a+UZfYWcWb6Nd8OBj4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9XwV5Oa; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30930b0b420so10627551fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740072288; x=1740677088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNpHCgrAsfe1/rNKxXBxQmjwPCLk6Ox/gTQr0wh0duw=;
        b=G9XwV5OaMyDh2AUM7NocMVHEldDLdus8BtyP3zuyIe1GHu+tZSBMf9S2FY6H8vWQL1
         9ECkUA6MPc+OvZCA4GIxZj/4lBnJE4xRXRp+GS0EdDk3lByCZtHdZir2FZBftsDhrC2d
         glzj3aiGff0mf6lj6ZBDK1KGH6tivjGG2fFDeCXrnx4RtDfdf3N12L8sVaRmcoMZY/KC
         iDupe6dQF3k4Q0WvL2pO+R6WcR67CPbm9kJQemgWgBCQ8htHNE3JTKhl8eQUO5ZvTWtx
         eg6PwoyZEAcgb/81H4kP5ve+ekpwZYhbFlDssrCg187OEPnRfqO8du+EUd7Cv6uvRq9i
         FTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072288; x=1740677088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNpHCgrAsfe1/rNKxXBxQmjwPCLk6Ox/gTQr0wh0duw=;
        b=oCRcM21IKZiJz5WE8C8hi8HqOfXABxcGjNZBXThrITANfhsuS/tIFSM6F+suYvArtW
         XGVeMdLTCQOAfnsr+vy8K0RwYz+CTUPglTwz7N7VJMvprbbs16KzOqoms9wDvfJ1gzEt
         sIB6JTxUHBVeJVBh5r+vdwcK2CR4migEUzqkgNgDS3CLqCCR/+1qmWHzCm0p4uXzR9Py
         lJVRlqOWm9qkBJfi+qo8VzDfk23pckd9/eID8J0KMuQtKzaIri1V2ulQNb0Sv6gtQEfU
         dNEovKSwS/WkL1Jmd7t7mpkXYyDri9C5TN/qqimKs+LiTPtNV6STzq6TqF/1E82KoxGW
         zqog==
X-Forwarded-Encrypted: i=1; AJvYcCUNnWH3lscosaHO7JnoKVHLXJ9LvyN9t2KlA71vRlPsJHEnvcLvXKQY+teudMjzUW+p+qDSrx00EGhxzg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzk+do8O0MTttgSmNqph5882rgewpBmqxybmEjthGtynNQ6pcr
	ZiLefaswW1oltSwh9eqTflGBQyGd3YG3OT+EjWJcViKmDoIblL32Y7MOB9LjhY8bydbuZ+gPGKg
	ktPQKGi7LhFfipFeBpVW29OPBYw==
X-Gm-Gg: ASbGncsCD2wxRlJRBM9VmVteCBMui+QQWkr12LZRZHduytbcfg4fCpg19j8IyxKrRnZ
	36TxP7NbU6Ff3rVEGDSbgBZy2QNhw81ek+63uqjQvX8nvfms7BgfSwa3znjbIzXpWOM0EXVYHGJ
	7X6BVF61NC/UM=
X-Google-Smtp-Source: AGHT+IHtyPkaLWiwHP7cVO8/NHrjUkfBzrUOUinht4KKl/1eDjJDFb5a4Fqb3n8hIe396bSVazzrBh34TzxEvyDmtcc=
X-Received: by 2002:a05:6512:224e:b0:545:b28:2fa9 with SMTP id
 2adb3069b0e04-5462eee7034mr3961922e87.16.1740072287801; Thu, 20 Feb 2025
 09:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com>
 <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com>
 <CAFULd4aYjnWzWaN8WA0LetN1Li7F8MY3qnxbhY8=tNFxqHCP1w@mail.gmail.com> <CAMj1kXGG4J76o17d=e4jv-5jjzcSGyZdKRcNNB17SkCqD6+8qQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGG4J76o17d=e4jv-5jjzcSGyZdKRcNNB17SkCqD6+8qQ@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 20 Feb 2025 12:24:34 -0500
X-Gm-Features: AWEUYZmb9Cv2tk-6mhKPGrwEmsqOxI-dklBrg2aZrNdpWFvtgV0zyPFnizlBS5M
Message-ID: <CAMzpN2h=Mc_7MNg5RiqxEvchV_BGAiThG4a5_Xt_HHB=0+vmEg@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 5:52=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Thu, 20 Feb 2025 at 11:46, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 11:05=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > >
> > > Hi Uros,
> > >
> > > On Thu, 20 Feb 2025 at 10:51, Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 19, 2025 at 2:18=E2=80=AFPM Brian Gerst <brgerst@gmail.=
com> wrote:
> > > > >
> > > > > On Wed, Feb 19, 2025 at 6:47=E2=80=AFAM Ingo Molnar <mingo@kernel=
.org> wrote:
> > > > > >
> > > > > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > > > > >
> > > > > > > I wonder if there would be any benefit if stack canary is put=
 into
> > > > > > > struct pcpu_hot?
> > > > > >
> > > > > > It should definitely be one of the hottest data structures on x=
86, so
> > > > > > moving it there makes sense even if it cannot be measured expli=
citly.
> > > > > >
> > > > >
> > > > > It would have to be done with linker tricks, since you can't make=
 the
> > > > > compiler use a struct member directly.
> > > >
> > >
> > > Interesting take. I'd have tried to put the canary at offset 0x0, and
> > > simply use pcpu_hot as the guard symbol.
> > >
> > >
> > > > It boots and runs without problems.
> > > >
> > > > However, when building the kernel, I get "Absolute relocations
> > > > present" warning with thousands of locations:
> > > >
> ...
> > >
> > > The warning is about the type of __ref_stack_chk_guard, not about the
> > > type of the relocation.
> >
> > Thanks, I got distracted by the text of the warning that mentions reloc=
ation.
> >
> > > $ nm vmlinux |grep \\s__ref_sta
> > > ffffffff8350c620 A __ref_stack_chk_guard
> > >
> > > Without your patch:
> > >
> > > $ nm vmlinux |grep \\s__ref_sta
> > > ffffffff834fba10 D __ref_stack_chk_guard
> >
> > Is this a problem in our specific case?
>
> I don't think so - the whole notion of absolute ELF symbols is rather
> flaky IME, so I don't think we should be pedantic here.

From what I understand it stayed relative because there wasn't a
constant added.  As soon as you add a constant (which the linker
treats as absolute), it becomes absolute.

> > We can list the symbol in arch/x86/tools/relocs.c to quiet the
> > warning, but I would need some help with auditing the symbol itself.
> >
> > OTOH, we could simply do it your way and put stack canary at the
> > beginning of pcpu_hot structure, with
> >
> > static_assert(offsetof(struct pcpu_hot, stack_canary) =3D=3D 0));
> >
> > for good measure.
>
> I think this would be the most straight-forward if there are no other
> locality concerns this might interfere with.

I'd prefer it at the end of pcpu_hot, that way the disassembler
doesn't latch on to the __stack_chk_guard symbol when referencing the
other fields of pcpu_hot.


Brian Gerst

