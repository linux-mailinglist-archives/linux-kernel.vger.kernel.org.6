Return-Path: <linux-kernel+bounces-317378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F22B96DD42
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8D4B221B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30B81AD2;
	Thu,  5 Sep 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGIp5zQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BEB17C60
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548656; cv=none; b=ZpLKZvgYlbgkzoSwumjo5KqzLsmM+BIWcDIKgbYg44KuF8ygENkVd+vE8qIH/LR60wcJy0HjSQMI7um8qdyqaPRsYXCzg/anfGU1OEcs1/fzrZKUrAaWi3esQoNryDHAwkLb5WXtCB51g9cp+F5KonLgv+2j/OY8ycTW2wVhr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548656; c=relaxed/simple;
	bh=JHYnKL5iuS2r3BfQORlEgO18kTluxBtO//MPh8R1Ffo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9v4foKKF1BBu1sPv9zmCTddGiSAiu4tvclJeCISxsg/qtWLPjzA5ZfEiw+HTBeZmC6KoCq2SkL5lWdKxOO3P3V/wt02no9SAlIEgm7qopXrjjhw8PRl94FcfhFxZtR4PxHcN95Ad//r2rQE65LMUJcxvejSjnpWflHvyDXurMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGIp5zQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF8CC4CEC9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725548656;
	bh=JHYnKL5iuS2r3BfQORlEgO18kTluxBtO//MPh8R1Ffo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tGIp5zQHd26AJBOAKXr1xh5Pg52wImQMfP7DhazVAShRB1zCs1MN1I1ON4i3c398Z
	 WYqFa/FFZl5CGOakf0FHKuGmcJNURt5wTTGTeB3SIA2xEqkCv/u+3+aQkoUVy/4npU
	 NuFbTAWxvvaxsJUsbx6D+Lgm6QtRroO8p5ZgCh3V7xlHYqA6AWu79rFSoKLbLmTxTs
	 /btqo1vJ6lzAO0ikMjXgRJmLxs+oZKoKkJQV+DD9JyjWjRUW+Jk4oUuNM/KtynhM6J
	 fghnWr6NUdwkH7LMytG2mBAn0xNW9GARZPBrgh39ForC5VJJRD65RaM2i7muEsVU0i
	 ypAERUBzszalg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86fa3dea99so50938966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:04:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnj7DblkE0TwxobgdZi49iCvLei5OsHGi+UthwXFxeLeK/rfPa6s6jTpREfK8q9XsT7xfmA91g9rT4HE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKP4c6RblgqbDb9jyKSiURkaaKVG39OjSFTTOnJGHark1cCQbq
	MhmB2aUIB8T3H07+YQ4/8g7It0G7KYyIR17n4oKGSv/usJuJQ+vt5E+NdebatUAxBC5Z9l2Dur+
	sq8HkQAKc5HAS5wlxTthe+vX+eEg=
X-Google-Smtp-Source: AGHT+IHGAEemp4AevN+wESidxKclUs4W7tWKnd+Q31O7opIrk8n+qohi4ijJKVLGMqUQu2tI0ixdbp7czWdB2+4UdOw=
X-Received: by 2002:a05:6402:3552:b0:5c2:7699:6d42 with SMTP id
 4fb4d7f45d1cf-5c3cd77e921mr2051228a12.13.1725548654416; Thu, 05 Sep 2024
 08:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065438.802898-1-ubizjak@gmail.com> <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
 <CAFULd4Z4QzS0J_BztD7jDSNwoXM2vF9PWNX5eJBrQZsUbu-gJQ@mail.gmail.com>
 <361bf35ccf308d2fbce14f69f156cb42eef0f095.camel@xry111.site>
 <CAFULd4ZqD2L=B5YfKjGR4s0mOM-fABb5+83Z5KfmX0YRaxWw-A@mail.gmail.com> <CAFULd4b9pV2Rpb+X8gTsDdePtcAppmh7jDVcXBQsk39sicRbhw@mail.gmail.com>
In-Reply-To: <CAFULd4b9pV2Rpb+X8gTsDdePtcAppmh7jDVcXBQsk39sicRbhw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 5 Sep 2024 23:04:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5eLXcAQ_GpEcO7rPZ2iJ7gqRxhXvGg=__p6+XcRK-gCQ@mail.gmail.com>
Message-ID: <CAAhV-H5eLXcAQ_GpEcO7rPZ2iJ7gqRxhXvGg=__p6+XcRK-gCQ@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 8:46=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Thu, Sep 5, 2024 at 2:16=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > On Thu, Sep 5, 2024 at 2:09=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> w=
rote:
> > >
> > > On Thu, 2024-09-05 at 14:02 +0200, Uros Bizjak wrote:
> > > > > If the input value is less than 0xff, then "& 0xff" is meaningles=
s, if
> > > > > the input value is more than 0xff, this conversion still cannot g=
ive a
> > > > > correct result for the caller. So I think for all sizes it is eno=
ugh
> > > > > to just use "((unsigned long) val)".
> > > >
> > > > This part is used to force unsigned extension, otherwise the compil=
er
> > > > will use sign-extension of the possibly signed variable.
> > >
> > > It's not relevant.  For example when size is 2 __pcpu_op_##size("stx"=
)
> > > is expanded to stx.h, and stx.h only stores the lower 16 bits of a
> > > register into MEM[r21 + ptr], the high bits are ignored anyway.
> > >
> > > Thus we can just have
> > >
> > > +#define _percpu_write(size, _pcp, _val)                             =
           \
> > > +do {                                                                =
   \
> > > +       if (0) {                                                     =
   \
> > > +               typeof(_pcp) pto_tmp__;                              =
   \
> > > +               pto_tmp__ =3D (_val);                                =
     \
> > > +               (void)pto_tmp__;                                     =
   \
> > > +       }                                                            =
   \
> > > +       __asm__ __volatile__(                                        =
   \
> > > +               __pcpu_op_##size("stx") "%[val], $r21, %[ptr]   \n"  =
   \
> > > +               :                                                    =
   \
> > > +               : [val] "r"(_val), [ptr] "r"(&(_pcp))           \
> > > +               : "memory");                                         =
   \
> > > +} while (0)
> >
> > Nice, the less code, the better. If it works for loongson target, then
> > we don't need this paranoia.
> >
> > I just played safe and took the approach that x86 took.
>
> Please note that the original code extended the value to a long type.
> If the simplified macro works, then the usage of macros will result in
> a better assembly code, where zero-extends will be omitted.
OK, please send a simplified V4, remember to remove the if(0)
checking, which is the same as V2, thanks.

Huacai

>
> Uros.

