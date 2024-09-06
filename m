Return-Path: <linux-kernel+bounces-318219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4A96EA22
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841B61C239BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4D014883B;
	Fri,  6 Sep 2024 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFQT8E7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502D145B11
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603961; cv=none; b=ePHr+nR3FGChQOgBX00AsSEk8cJPqAA/MrNbCr30Mc/PUdTlx9THexerTGY/JWgWdLt6B6uDycs8ROzVX4qZ58Z7RJwJdH/O5k3kHE2axn5XS6d3mGmEk4Rrz4loWXQoDdrufJJy0I3UH9KRJ/mAKwwad1E5I59VsnRIp1tz7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603961; c=relaxed/simple;
	bh=DREQymudoG/EclRSLEM6OUkORODDaXonihhOL6WMI7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDtfrPjhJLT8sXkrRmqZJyK/+1lVQusneEY//uMyD5GXYwMtinAEgXFiaKTljtSb72WnrKLc4ygBCWjQntdvuEP7NUB/fgRlBL0SY+afzyc72+XQUJjPJcfKYqnM8aC39L54vwGFKuBiEydeEWw6bnXJ/zDJNC7zsHSzhvuHbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFQT8E7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637B5C4CEC6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725603961;
	bh=DREQymudoG/EclRSLEM6OUkORODDaXonihhOL6WMI7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MFQT8E7z4OtHWIHiRUNkyPbRsfjwy3ZtsHEpb6pjBbT4GIgHNgIAydU3NYWknnFaS
	 vFv3w6B2pJJ9/+uW+m6XV7y+ohs2JzEd8QXwU0rPXjrfE7Iifr6nFrlRcVZP5/LQxj
	 RbFAVPKTnmXTAjOK4UQ6Obvg+af3WjQfzMhz0PNaVsfbwBYFX36ur5iKhCiOj5w0m2
	 wveqymALYzJvlPifXfUohZuNTlfP54lquQcXZpb0Sjjvo0mpCNVqEWvqiBwOGyzIY/
	 FByKgJgk/oDZMtyso0NPbwTedWZtF8tujfMMFwJRpPu1OtvDH9js9QV89L86K3GcSx
	 ib1Jb4X/7fT6Q==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so1760371a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 23:26:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtb++8NXkjdGSirNMh+mC3jLt4MujAgha4mAQvvo2NUOWgyv7SC5sVg1apFMnxr0w/YxFor/pvmV47mik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WUXwBKTRI7sfU6cxmLghYbNlsH9HvNHNtgXR8iIIbGNXyur5
	JIa+av5GEWyAp+npXSxC7btV55L/5koYD0w2JWTemLnCSqViN4MuEM9mbXHrUfj4xBIMU9REsse
	mQk6PfV4/c32B3ELcLeqNH9R7c3E=
X-Google-Smtp-Source: AGHT+IF3JZ7EToPYAGiMK2zl1U8V3c8koOzFtJkPKb+SmZt58sDoO9N3lPQeBHEbROqfiRxe5jlqTsDqjtyTj1q9ZgA=
X-Received: by 2002:a05:6402:13d3:b0:5c2:5141:8488 with SMTP id
 4fb4d7f45d1cf-5c3dc78512bmr848572a12.5.1725603959969; Thu, 05 Sep 2024
 23:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065438.802898-1-ubizjak@gmail.com> <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
 <CAFULd4Z4QzS0J_BztD7jDSNwoXM2vF9PWNX5eJBrQZsUbu-gJQ@mail.gmail.com>
 <361bf35ccf308d2fbce14f69f156cb42eef0f095.camel@xry111.site>
 <CAFULd4ZqD2L=B5YfKjGR4s0mOM-fABb5+83Z5KfmX0YRaxWw-A@mail.gmail.com>
 <CAFULd4b9pV2Rpb+X8gTsDdePtcAppmh7jDVcXBQsk39sicRbhw@mail.gmail.com>
 <CAAhV-H5eLXcAQ_GpEcO7rPZ2iJ7gqRxhXvGg=__p6+XcRK-gCQ@mail.gmail.com> <CAFULd4bSHM9j11N8b3+V8N-pQTconan53THeme4p3UR3COCTLQ@mail.gmail.com>
In-Reply-To: <CAFULd4bSHM9j11N8b3+V8N-pQTconan53THeme4p3UR3COCTLQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 6 Sep 2024 14:25:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5e=fOuAngxkUpuosveCOEUcY03Our2=H-fGPCO6L51Ag@mail.gmail.com>
Message-ID: <CAAhV-H5e=fOuAngxkUpuosveCOEUcY03Our2=H-fGPCO6L51Ag@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:09=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Thu, Sep 5, 2024 at 5:04=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
> >
> > On Thu, Sep 5, 2024 at 8:46=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> =
wrote:
> > >
> > > On Thu, Sep 5, 2024 at 2:16=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com=
> wrote:
> > > >
> > > > On Thu, Sep 5, 2024 at 2:09=E2=80=AFPM Xi Ruoyao <xry111@xry111.sit=
e> wrote:
> > > > >
> > > > > On Thu, 2024-09-05 at 14:02 +0200, Uros Bizjak wrote:
> > > > > > > If the input value is less than 0xff, then "& 0xff" is meanin=
gless, if
> > > > > > > the input value is more than 0xff, this conversion still cann=
ot give a
> > > > > > > correct result for the caller. So I think for all sizes it is=
 enough
> > > > > > > to just use "((unsigned long) val)".
> > > > > >
> > > > > > This part is used to force unsigned extension, otherwise the co=
mpiler
> > > > > > will use sign-extension of the possibly signed variable.
> > > > >
> > > > > It's not relevant.  For example when size is 2 __pcpu_op_##size("=
stx")
> > > > > is expanded to stx.h, and stx.h only stores the lower 16 bits of =
a
> > > > > register into MEM[r21 + ptr], the high bits are ignored anyway.
> > > > >
> > > > > Thus we can just have
> > > > >
> > > > > +#define _percpu_write(size, _pcp, _val)                         =
               \
> > > > > +do {                                                            =
       \
> > > > > +       if (0) {                                                 =
       \
> > > > > +               typeof(_pcp) pto_tmp__;                          =
       \
> > > > > +               pto_tmp__ =3D (_val);                            =
         \
> > > > > +               (void)pto_tmp__;                                 =
       \
> > > > > +       }                                                        =
       \
> > > > > +       __asm__ __volatile__(                                    =
       \
> > > > > +               __pcpu_op_##size("stx") "%[val], $r21, %[ptr]   \=
n"     \
> > > > > +               :                                                =
       \
> > > > > +               : [val] "r"(_val), [ptr] "r"(&(_pcp))           \
> > > > > +               : "memory");                                     =
       \
> > > > > +} while (0)
> > > >
> > > > Nice, the less code, the better. If it works for loongson target, t=
hen
> > > > we don't need this paranoia.
> > > >
> > > > I just played safe and took the approach that x86 took.
> > >
> > > Please note that the original code extended the value to a long type.
> > > If the simplified macro works, then the usage of macros will result i=
n
> > > a better assembly code, where zero-extends will be omitted.
> > OK, please send a simplified V4, remember to remove the if(0)
> > checking, which is the same as V2, thanks.
>
> Are you sure we want to remove type checking on _val ? I'd rather
> leave the if(0) part, but remove forcing zero-extension.
Yes, please, the checking is not very useful.

Huacai

>
> Uros.

