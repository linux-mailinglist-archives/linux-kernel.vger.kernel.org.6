Return-Path: <linux-kernel+bounces-523492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D509CA3D78E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE623BB412
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F21F190E;
	Thu, 20 Feb 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqPMuErv"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC01C6FE9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048996; cv=none; b=qky2jqg6sGgyynLjwQ8cc1+IkByFa2JoRes33Kvn53zb5SiR3APE1SWpRsnx0XdWowNWrSy/QZdCZAPWs8W0abVoRASTIcZj3RtL7q/hs9gmjMHpgu7NONgl2WbIRCQAhsHurSDbXo+HTCiqQIAQxQE6SMljK8wTJ/Jd9ZUiXQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048996; c=relaxed/simple;
	bh=fRu8eUbZlr5WjUOyfFTKMd8WKBc7SWVXg5JE+CVhBFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jifdhuP9garhgPhzGULhXRRlvO7Ov6rn3fnnnuxmHnTjKNBEhrwcf5Mv08HMg882NASIKkZWWVAiq0uVqbdc+TlFIpAFF4pjeaw5mkZXT4f8Q1FOe8C5ASUiPKEQ22ai8blkUVSMoMGSti1h/O3N+38nW3AO5IQD9rJcb69tm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqPMuErv; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30a440effcfso19272791fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048993; x=1740653793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRu8eUbZlr5WjUOyfFTKMd8WKBc7SWVXg5JE+CVhBFw=;
        b=KqPMuErv3HRCkVp5lM8rv66hBFAIByefLjYyc8wU39MkenoNx2ER1NcihuHCjK0TRV
         lLhUUTLFlizxpMkcNW+EyBZPQ1EwMiwbd+DuX4qfmox3GHT/Qk6D1brKWZQn7lAapgZB
         J044HYP/2s+pCln0/lEPU7Hm4BD6+U3N3yUDdC+uQf76YAtVhSmPWKjq5TgrGGVtXMDg
         U8VFDb9lWHxBLbn5h3dxYCSb2fqIXU/0DnCCHwXTCx7AyqaDWBiRPbKwwyAcjl1Ig9B0
         iJvmmXDOHGqvoaEW+0xeeopXqfhuSMgme9DtzveB9txWDyLvSmxKRr3N48kan99Ot39x
         RfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048993; x=1740653793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRu8eUbZlr5WjUOyfFTKMd8WKBc7SWVXg5JE+CVhBFw=;
        b=eGsZWEzTAEdR5BMXuI4L+kM//bfQg3mGQSZdZz4yunfFb2IWSpWRqdc6XFX+Ad1W5L
         CyqlOSzBrIKKDWf1jGXwHawZ4OiWTyrlFeyiwg71gLqU6t1WjuHXxCF0mdcCl6vT0iKZ
         Fnymx9hzubXB2mUKUKVcAc9JsICDlVfkE2T+iRRJHwkaJEB2K6b6J4os2hsequptdcVu
         TPOMCRYtGo08UH/O+UqdDmqf2vuWLmGvKeEAVvg6IguMGyRXDEgK6pIQYbaStMc1TncW
         YEA4Q0t8qBP3I9ROkkAY1xkOyUT0vg4wMaSh1ZI8Nc4Fhmpb4Wyi27n6defqDTGa0PSV
         wccA==
X-Forwarded-Encrypted: i=1; AJvYcCXp3WjZCPOSyN1K56x2cSwAqF/Yb4qI5Gp8rB6y/lM/IhEpF0Nrtu6yrT/ZLhm4+/SkwMZroLCh20cT0v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHT/KnD484IEPqiZ7TVHI1YE08/CaJLG1lpW0jRtht00NzixH
	DwL8bHoyvF5wIUBvi+fK1u0fPJ81WeTzzuMh6zZlfimTvdfG6ONhcwavucmzNUhruLsJVN68x6N
	bX9hFew24stTsSVLjSBeQouUdygsIaqEo
X-Gm-Gg: ASbGncvQf2KaqnOUDBvkj31QC4rYrFcishxjkpPAQQ+jLlcO2M3CBt/Z/0pnfBX5d+4
	sASqJ2qY4hMis4skb7ahctSFEIuULOFu/wfjK8xt2XNfstQ7HhKc1QbHKL2nbKXxbAVTmtuum
X-Google-Smtp-Source: AGHT+IFg16Cpi34Nx5OBZZj3UBP9+BvW4NSgYKS5HcY+H9ccmPPfkhdxLu3CL/Ze5+kyj/MWpUu3PhkPOeBDVIPYNDg=
X-Received: by 2002:a05:6512:3d1b:b0:545:2e8b:5959 with SMTP id
 2adb3069b0e04-546e5f768bemr964670e87.24.1740048992642; Thu, 20 Feb 2025
 02:56:32 -0800 (PST)
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
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 20 Feb 2025 11:56:21 +0100
X-Gm-Features: AWEUYZnteaXMK8HgJJ6iL5SHU5Azq-Dcxyy5M3SLgdeblJ4cJF0EGkot4QPPSoI
Message-ID: <CAFULd4b63uHvZs_tUjkiNRykThiztwn59jnZ-5JkTEXR16oVeg@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:52=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
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
>
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

OK, let me prepare a patch then.

Thanks,
Uros.

