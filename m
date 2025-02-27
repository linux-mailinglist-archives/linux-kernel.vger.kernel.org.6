Return-Path: <linux-kernel+bounces-535394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746E3A471F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E7D3AD775
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084C1494A9;
	Thu, 27 Feb 2025 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0BReojG"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D884D34
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622205; cv=none; b=Kku491CLekKwMYx7IZe7xRZ+qbvB8jTFDEPVJCtskiiGdI3E4xvU0x0W3PBQrEWrrApmNvwnBZZBA28pL09r6HbELd3CJFZgjBacrOYDImdooKa4GwoRSotXIZRmKlqU7PaXZF3njq9agVNkyffXLMd1kHoiP30U0NOYJt3viDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622205; c=relaxed/simple;
	bh=GTBVZlJ6z+c5FM2Dou0EhEVrsHEbtWySsGPwLR73Yp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGR54jUgZhrXWd7AZVZlqao0/dHj0WvEV7/ze+5O73zShjBClF22S0SBwX9vbmRLHy5em8511tmBESn6LJRavTwv69BFXmjBXXy51vdH/fhD1zBz8/WImYoHO5E4Dvb4cZuBmrSyPh0VCsxKmwgMttO5A75lwC6Q6gTJHg8dRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0BReojG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54527a7270eso383192e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740622202; x=1741227002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4l7VnYEHFwyEI/iiluR5ke5vhEE3/FWKUuodBvFewo=;
        b=f0BReojGCJFKTsyP4JFOXPAZi7TruIIf9dztex6m+0IrCkc3zHc5JsO98x4/Tvmisj
         rvvuL/Oa9JZYBVGmbz7s7RxCsMqoIm76pvs3S0w3JM5d/n2DwtcuVjavKO3RUXeqMC41
         Dr/0DJnjXFYU6+7rWKu+msIDTO+PmCIHgIJ6d8dLk/pZvR47DWYoSi5Rlc7uaJ/Xuf5f
         gXvMLcH6RaPh5D9LLqckS2i+Xl6AKir3bCc1zDBeGY3gBExHJhlH6AqEA5HgDSXaNyrv
         wUEGWAdWtrg8ZSZn/B6gRC8WUoHc7yxMuMn5WsiUlVP3xaU3X+1cj6yP3PwpQQYLPbj1
         8OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622202; x=1741227002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4l7VnYEHFwyEI/iiluR5ke5vhEE3/FWKUuodBvFewo=;
        b=FIzoBUJ6tV9Yz8wOJ+E2WBJ64MkVAUJ1tFHG+0a4B4Mw8Ugt3GobojhdQTQQNMRIY9
         ULEU6IHV4tVE6R+ztvRgdpX1l2k5Tw6bBgDO4XSOBvooUtwaNIifIKa06R+yVgo3R7TD
         KXu6Coa90yUfOxtRfCxA6D0/L4pnjEqq9KGJl32XbsBqHE+IqzZK7ipet3kpMK3aWH2J
         oIr/P08VLEu+oAwxhgdKHxHZX8pRCIE+tdyxbYYaUvBK2qWLXabePLH5zqP/df1ZtalG
         ht+FKDPG6CAVQINdNeOopH0eOjse4LzDTQJBsB07K+U9M5dvmwRsCoPqyj8kRYWjhsjM
         j2tg==
X-Gm-Message-State: AOJu0YxeEWa00TAtTf+5gbynsQ7P37OO8up+Zf3qowvdwhRXrm4uahp6
	ByVsncxQ1jDo8tf/k3KC7WrtgRThFwjtRevpODVEkh0P4mHAlcpdrde52knvDEK0uoUFLpuQbrM
	9Vv1L+OhY8LopQEZaI5E529JHpA==
X-Gm-Gg: ASbGncuSpdiwNAA52VDMqiGB8hE/Fxkr8ZsNK6iXT/GBH0t88oxGOnXjKjpIGLD+PIp
	3Jj6oSDKqdkxIkIqg9y2n1B+PAXSQ8Ga8De5VjCaNvsbCe+OntAgTqp9zzLiNpc2LkhOt+tyDyo
	1FJnGW7OS20WcFpblgmn3Wag==
X-Google-Smtp-Source: AGHT+IG9keNBFOWSkf5uTrb/OPd1PQMa/DQ/6WDFH3IgtyIeLBuxyFXaU5nea6uzuwaulr1eVyn92E8kT+QG7qijCC4=
X-Received: by 2002:a05:6512:b1c:b0:545:4b0:3dce with SMTP id
 2adb3069b0e04-5483912fdd8mr10074400e87.1.1740622201377; Wed, 26 Feb 2025
 18:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226180531.1242429-1-brgerst@gmail.com> <20250226180531.1242429-2-brgerst@gmail.com>
 <CAFULd4ZP58hPacGp+n_bBZV0e7nomzLMdX7OOu3DEeGe2OxomA@mail.gmail.com>
In-Reply-To: <CAFULd4ZP58hPacGp+n_bBZV0e7nomzLMdX7OOu3DEeGe2OxomA@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 26 Feb 2025 21:09:49 -0500
X-Gm-Features: AQ5f1JqvSsVUKjFXIi-AL8ZStMI-_Wyn76ZAu7NQvDRbSjUkPLtgJliYKJgYlTc
Message-ID: <CAMzpN2gc-OGabKXyEAQSeRRdahWfEosoFapRx6bERxJQxCD+SQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] percpu: Introduce percpu hot section
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:36=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Feb 26, 2025 at 7:05=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > Add a subsection to the percpu data for frequently accessed variables
> > that should remain cached on each processor.  These varables should not
> > be accessed from other processors to avoid cacheline bouncing.
> >
> > This will replace the pcpu_hot struct on x86, and open up similar
> > functionality to other architectures and the kernel core.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 10 ++++++++++
> >  include/linux/percpu-defs.h       | 12 ++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index 92fc06f7da74..92dd6065fd0a 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -385,6 +385,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PR=
OPELLER_CLANG)
> >         . =3D ALIGN(PAGE_SIZE);                                        =
   \
> >         __nosave_end =3D .;
> >
> > +#define CACHE_HOT_DATA(align)                                         =
 \
> > +       . =3D ALIGN(align);                                            =
   \
> > +       *(SORT_BY_ALIGNMENT(.data..hot.*))                             =
 \
> > +       . =3D ALIGN(align);
> > +
> >  #define PAGE_ALIGNED_DATA(page_align)                                 =
 \
> >         . =3D ALIGN(page_align);                                       =
   \
> >         *(.data..page_aligned)                                         =
 \
> > @@ -1065,6 +1070,10 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_=
PROPELLER_CLANG)
> >         . =3D ALIGN(PAGE_SIZE);                                        =
   \
> >         *(.data..percpu..page_aligned)                                 =
 \
> >         . =3D ALIGN(cacheline);                                        =
   \
> > +       __per_cpu_hot_start =3D .;                                     =
   \
> > +       *(SORT_BY_ALIGNMENT(.data..percpu..hot.*))                     =
 \
> > +       . =3D ALIGN(cacheline);                                        =
   \
> > +       __per_cpu_hot_end =3D .;                                       =
   \
> >         *(.data..percpu..read_mostly)                                  =
 \
> >         . =3D ALIGN(cacheline);                                        =
   \
> >         *(.data..percpu)                                               =
 \
> > @@ -1112,6 +1121,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_P=
ROPELLER_CLANG)
> >                 INIT_TASK_DATA(inittask)                               =
 \
> >                 NOSAVE_DATA                                            =
 \
> >                 PAGE_ALIGNED_DATA(pagealigned)                         =
 \
> > +               CACLE_HOT_DATA(cacheline)                              =
 \
>
> There is a typo in the above macro name.

Fixed in the next version.


Brian Gerst

