Return-Path: <linux-kernel+bounces-422666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74559D9CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0069C2833E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680711DB372;
	Tue, 26 Nov 2024 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhQfsdXP"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9B1CEE9B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642622; cv=none; b=LIP9ET85xHGHTdqaQWlv93HdLZzhkQwnO9S1YVcKRiUl68ZQVQMVXTUdEL7IDT0sooYUNyxSXTqh8skTJrKorYHaarBsD+T9aUgyfR15nrKW2C9rVABvvnhBt3R7Okufwa8Czvtb47qruIFA8JV/PKVwEa3csAHlebe2iQbULXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642622; c=relaxed/simple;
	bh=gbmYMQbA2rXzpUjzBqFO65i30182vY/giAHtdzQYoPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbG7LSCxf/RyX8tG+9CL/dnF61czHeclcTsRFKVhSGG/9LVApKKy85Q96+IGEMkaquSK9EHdbq4vZWintPGOB1F1MVi6lhWdxyJ9baLM5tkTLzdn01EZpjNgUAQVy8TA1F7HJ1zDtIEjN7j/216nSrWXDbGCKE3MTqS9vpFLh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhQfsdXP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-466ab386254so216621cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732642620; x=1733247420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNErqAZxCf0oiKmzzwSTS7FqswDOdrvvy+jDoDThaf4=;
        b=mhQfsdXPVRIoq/bP4f7TYU+FGmAqrpRuSZCV1vq5wSnNG0mgNt0JOED+1xj3TF7/jK
         oK990SMElFZVG+BXjNkeZsvzr7jffmMaUljFJzc80FER2cg4Wy2LDT100JV9XTZ+KczM
         ZVrswBF5IsBw2gQzLlieBSAOnGLcwaPzLS+RW3EbLDVZ3T2KygDf9RZouMQZVPdKj/X1
         nQ+y4m0TKrGLUUVl7zhwT0tgQNo8CGPMKbc73e3q41odPcCqBv/7TPrw0ouZGB+oHgma
         Wm8DkVzxsRdzGQNiqI1Tj5K0gwXeaViQtjHm2f3ni6uzq+46src4ucUmqPITod7KqJBG
         ejBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732642620; x=1733247420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNErqAZxCf0oiKmzzwSTS7FqswDOdrvvy+jDoDThaf4=;
        b=aMKlGfOFg+oly5wyRH6RiAwRBHWfLuvQiV8+HKoI0pN1Hl8JJuk3POdiitMmp3xLxi
         CdtO99hXmilXjAxJXOaJFSBk4ZxJNIXVvcHM/So+pUeGVLPvBlbimUOmVuJl3snVD5Du
         t9VBFQ7YtCtIGMpap6GsfWPj9IMV6yRYIPcID45/RosWFYVa72c/e6HMWGkz8qBKLCA2
         HubvhXX2t2prKD3NZerdsfmRfrWR2BUvjYwdCWwLNOJZpd9/Vp6IO9a0om2KhDIbTitp
         8KLRTPBAvTUGisBGbN13AhAhwLXU/gldT6aXFKDXaVAsCU6CuGJiCLkr7L1QJVZp1ssa
         d1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVEwvdCeE772A/YFybTDUyz21Xed7yvLBVusUNumGxSDW5Dzd1qp9fnI73itX/Pkz8QRAPvdOkjExTBLok=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfau1w52dt6qjoo429/pGeJdGj6iLvsNCV1kxdtnu+Gl1tCzfX
	nc7jBNmlxT1Q/iLQMAiNxbmffgacO4/7h0h9Ot9PjooxXVNY2pD6MjPuozXfqeU5gHvwqMafwT+
	0VW9hqcnZDJTtz5Qbv4tfewVsDEQbx0SlEcMOazPqwGvFjYB6GpUW
X-Gm-Gg: ASbGncsW1qyeuwLvobins1eGvasdMiAuSf5OueP0jcpRUdDOxgfhG8o+CefxKYHEviM
	JSiJYFAV+tnWCcltWmNb+MFQ02+KAtNhkP/vm4vWq4YBmBI8ifzJMH/e8ScM3Lg==
X-Google-Smtp-Source: AGHT+IEYwvMJn3roNildxf/BcieIfiTVZUivCidbeF0e4ZRl7GnpoSHxHDA9pKW7LcMiHICNIGVOOnfoMv2XwGBPbRc=
X-Received: by 2002:a05:622a:298b:b0:466:a3bf:41ab with SMTP id
 d75a77b69052e-466a755b5c8mr3124471cf.21.1732642619835; Tue, 26 Nov 2024
 09:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125230953.3090508-1-xur@google.com> <66daf1a8-efb7-4fef-92cd-eb680c7832fa@alliedtelesis.co.nz>
 <CAK7LNAQi_R_ppZu3Y7ZBEbGpGviCYoD=vBUvt9rgaPLkaLZ9Xw@mail.gmail.com>
In-Reply-To: <CAK7LNAQi_R_ppZu3Y7ZBEbGpGviCYoD=vBUvt9rgaPLkaLZ9Xw@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Tue, 26 Nov 2024 09:36:48 -0800
Message-ID: <CAF1bQ=TMvb-42YREZ5iHLxAc1M5U54L2D95bbmTrD0kP59UUAw@mail.gmail.com>
Subject: Re: [PATCH] [MIPS] Place __kernel_entry at the beginning of text section
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Klara Modin <klarasmodin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Masahiro and Chris for the review!

I just sent out patch v2. I verified that v2 has pretty much the same
layout (except for
some debug info caused layout changes).

-Rong

On Mon, Nov 25, 2024 at 7:43=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Tue, Nov 26, 2024 at 8:42=E2=80=AFAM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> >
> >
> > On 26/11/24 12:09, Rong Xu wrote:
> > > Mark __kernel_entry as ".head.text" and place HEAD_TEXT before
> > > TEXT_TEXT in the linker script. This ensures that __kernel_entry
> > > will be placed at the beginning of text section.
> > >
> > > Drop mips from scripts/head-object-list.txt.
> > >
> > > Signed-off-by: Rong Xu <xur@google.com>
> > > Reported-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >
> > Works for me on my RTL9302C based board
> >
> > Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >
> > > ---
> > >   arch/mips/kernel/head.S        | 1 +
> > >   arch/mips/kernel/vmlinux.lds.S | 1 +
> > >   scripts/head-object-list.txt   | 1 -
> > >   3 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> > > index e90695b2b60e..6d5fc498c6f9 100644
> > > --- a/arch/mips/kernel/head.S
> > > +++ b/arch/mips/kernel/head.S
> > > @@ -26,6 +26,7 @@
> > >
> > >   #include <kernel-entry-init.h>
> > >
> > > +     __HEAD
> >
> > I'm not and expert on any of this but... should this go below the
> > setup_c0_status_* macros (just before the CONFIG_NO_EXCEPT_FILL) line? =
I
> > don't think it makes any actual difference but as a reader it feels mor=
e
> > logical that the __HEAD annotation is applying to the .fill and
> > __kernel_entry.
>
>
> Agree.
>
> Having __HEAD right before the allocated code would be better.
>
>
> We have one more section marker, __REF, some lines below.
> This is placed right before the affected code.
>
>
> Rong, could please send v2 as Chris suggested?
>
> Then, I will insert this to my tree to avoid regression.
>
> I will drop the previous commit
> (MIPS: move _stext definition to vmlinux.lds.S).
> It changed the location of _stext when
> CONFIG_NO_EXCEPT_FILL is disabled.
>
> Thanks.
>
>
>
>
> >
> > >       /*
> > >        * For the moment disable interrupts, mark the kernel mode and
> > >        * set ST0_KX so that the CPU does not spit fire when using
> > > diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinu=
x.lds.S
> > > index d575f945d422..c9c1ba85ac7b 100644
> > > --- a/arch/mips/kernel/vmlinux.lds.S
> > > +++ b/arch/mips/kernel/vmlinux.lds.S
> > > @@ -62,6 +62,7 @@ SECTIONS
> > >       _text =3D .;      /* Text and read-only data */
> > >       _stext =3D .;
> > >       .text : {
> > > +             HEAD_TEXT
> > >               TEXT_TEXT
> > >               SCHED_TEXT
> > >               LOCK_TEXT
> > > diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.=
txt
> > > index fd5d00bac447..f12b4a7b8406 100644
> > > --- a/scripts/head-object-list.txt
> > > +++ b/scripts/head-object-list.txt
> > > @@ -23,7 +23,6 @@ arch/m68k/coldfire/head.o
> > >   arch/m68k/kernel/head.o
> > >   arch/m68k/kernel/sun3-head.o
> > >   arch/microblaze/kernel/head.o
> > > -arch/mips/kernel/head.o
> > >   arch/nios2/kernel/head.o
> > >   arch/openrisc/kernel/head.o
> > >   arch/parisc/kernel/head.o
> > >
> > > base-commit: 3596c721c4348b2a964e43f9296a0c01509ba927
>
>
>
> --
> Best Regards
> Masahiro Yamada

