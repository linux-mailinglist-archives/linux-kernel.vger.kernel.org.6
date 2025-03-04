Return-Path: <linux-kernel+bounces-545010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F454A4EA36
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19128A5DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9878B2BEC22;
	Tue,  4 Mar 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fju9Rkd8"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F928629B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106536; cv=none; b=YzGMLF2QLgThDEbP4td+bKiJFcJ3Or2wt3t3DZHhquN07EyjvHnOmG1ItknZ4YQURvkU5OPb2cjxiNbAuQbMa2HTr35Ft7JOAh+kWJceSF3PYvYsqWTwxAyhPphmrtMp6o1A7rxiEAqieINt3k1j2PxgMMupj2XfWjMRoYVrlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106536; c=relaxed/simple;
	bh=zVmSRTOrtDmcYsSNsPpxSPi66P1oZ24gaJieWcrsLnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xhq9ic97CJR8zM35s5Ym3bbDEJSfxAanygjzp4AL1W9z97YwcQPXmdy1l6eCZYefKemvPt/L5PWXKdJHwpEtUpYqiVQeao6mYBpxDJxRPWPhcdtqKoZ2UsJy34Cj2zztq1MziiFOJfK/Q9wiJ4It9wTo7Nj9/GTIi7/jD9fQM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fju9Rkd8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5497590ffbbso1419729e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106532; x=1741711332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbivFwbBNRFxWKYci5XIV4ioGLd2re6+2Hrq1RDr5zM=;
        b=fju9Rkd8iVRFSdwReWE8jBAsd6AHCK/2BDCiSliBck65p8Eu1Dn+jwJ3ZaHPgWzoSB
         n5cH0a8q7JK/c0FKqlWVR5e4UX2fUeOqATG23KkYTUZmeXAkZftieP1kO69lABGl3M7K
         0LB0orYqwXiDt9Zccwb0+Saz8VycUmZrzaK6Prq4oksZJFevPyUuVnv/T/tiOjJyHhg8
         bei4+NTL4EsNAwawYZByWcV+6IK5cHVIVEou9fsp5yEYnPaMK1JdLZHua/B06lBAR6N6
         OBB/hGJ3NG4XxM2GMyXNR4HbNptqOeVZRkYEfL4pr1kYdYQboGqRE9UwBrrG5A4Q0TKW
         3gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106532; x=1741711332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbivFwbBNRFxWKYci5XIV4ioGLd2re6+2Hrq1RDr5zM=;
        b=YSGLBYPGdQBrLWhahEPXuhtePdKlJTa7UcZJn/4DsmNMj9Gyi8dtuAhPg3JcXmZYWy
         +RK03wp2Wfejp0DtttyHM52o6jJUcP3Do8DaanORCMeTAMxN+cxNbLaHUasvrPqR40YT
         tdjbXGkiPrKSfAbAC5gb1AELHQId8LlBnn14atCu3CepUWTyy8I6yj7chv5wpMKj8lCK
         5vEAi/pfXUKzVb1NXrkuhrXvhrmCG7H5+JAFwZVje1f8sbJBm9G2VglQyyL1U3BF7qH1
         eX0ICEBtA8eZpVrYnUmbQc4kS+c5kzUpk0mBd/sODIymMHp64GHc3uPcTI62zGWrEAuM
         0Fbw==
X-Forwarded-Encrypted: i=1; AJvYcCXhBjF+0upWAJCKGw/AC2pTr6dUCbHFuRK/X1X25X8p9l6iKM/zvdgGifMjR5KKzs9HdTWraQy7j0fbDKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1PkSiWiiQFd/fO3g+jtv1gQGuJqwNSR4isxRM6he0pdIXt3z
	8ZxC7mLM4LiBhFUx310kvn8FBXZTlLkxlIMEHd/ttijRv7+8E+iAMtD5oGWyvUJsfB8AcD6uk4n
	u/imOM2fxbhAtRlPg0HW4q+flzQ==
X-Gm-Gg: ASbGncsNw4Fka7M2+EB0iJ3mskM/qOtoSPWB8B6BXjv0Xc3OzgU7ikXofmMjjoZdmrj
	1qOlLO6U8QiOQ92T73woUn36AePKpQXhz32NqQjwMbFuxNTHVkM2oWfnM6pqLdcJxnQSZOw95uK
	0iZB0HL1R5n9AmmoaUQxP+HMjXLyx89l+I7+vN0kZw
X-Google-Smtp-Source: AGHT+IFKld2MuR0yS3SVwgIkpXFI8stYJVrTNykV8qkYIVLkcwqpLvDGk6UjyrFpQ+mU6fheyEcHJQ7nv6C4TfGWPE4=
X-Received: by 2002:a05:6512:3c92:b0:545:c1e:6603 with SMTP id
 2adb3069b0e04-5494c3580a5mr7583687e87.50.1741106531819; Tue, 04 Mar 2025
 08:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303165246.2175811-1-brgerst@gmail.com> <Z8YTYWs-DeDHal1Q@gmail.com>
 <CAMzpN2iB4Gv0Fq1pNtk7bpa2z6eYwQGYXT0=p=_wWDBE9Uxa7w@mail.gmail.com>
 <Z8a-NVJs-pm5W-mG@gmail.com> <CAMzpN2gpHRtOtRuCJF_TKOFbEJ2xkksndCH+MfntfDuZHC0O1w@mail.gmail.com>
 <Z8bMSr8JrDZtqwK8@gmail.com> <CAFULd4YFm-2Sc6NOzyWt4-TPDkwY-=5h-Gb99M+tFf-Mczk0Ng@mail.gmail.com>
 <Z8bOIXeWYycUEmp4@gmail.com> <CAMzpN2jUKp93z=jeXqa0uA-kQtaZ931aehZLm_axZoqGCeQZJQ@mail.gmail.com>
 <CAFULd4aR3+J3z18OCKbFcghOrJ7xLdYM1kPbD4HnUka4+AiLcw@mail.gmail.com>
In-Reply-To: <CAFULd4aR3+J3z18OCKbFcghOrJ7xLdYM1kPbD4HnUka4+AiLcw@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 4 Mar 2025 11:42:00 -0500
X-Gm-Features: AQ5f1JqSVwXipGv7ckccv31RuJRPtmTywDwuSyFcy7sfZ85L5jLXyKh-0Y82FPk
Message-ID: <CAMzpN2gLR51ko+hWAS7XRDM4VLL+YJYcP91AsH+phG1K7UoVDQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 11:02=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Tue, Mar 4, 2025 at 4:00=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wr=
ote:
> >
> > On Tue, Mar 4, 2025 at 4:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org> w=
rote:
> > >
> > >
> > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > On Tue, Mar 4, 2025 at 10:48=E2=80=AFAM Ingo Molnar <mingo@kernel.o=
rg> wrote:
> > > > >
> > > > >
> > > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > > >
> > > > > > On Tue, Mar 4, 2025 at 3:47=E2=80=AFAM Ingo Molnar <mingo@kerne=
l.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > > * Brian Gerst <brgerst@gmail.com> wrote:
> > > > > > >
> > > > > > > > >
> > > > > > > > > -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> > > > > > > > > +       PERCPU_SECTION(L1_CACHE_BYTES)
> > > > > > > > >         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=
=3D 64, "percpu cache hot section too large")
> > > > > > > > >
> > > > > > > > >         RUNTIME_CONST_VARIABLES
> > > > > > > > >
> > > > > > > >
> > > > > > > > That is probably the right call.  The initial percpu sectio=
n is just
> > > > > > > > used by the boot cpu early and as a template for the dynami=
cally
> > > > > > > > allocated percpu memory, which should account for the prope=
r
> > > > > > > > alignment for NUMA.
> > > > > > >
> > > > > > > Okay.
> > > > > > >
> > > > > > > Randconfig testing found another corner case with the attache=
d config:
> > > > > > >
> > > > > > >     KSYMS   .tmp_vmlinux0.kallsyms.S
> > > > > > >     AS      .tmp_vmlinux0.kallsyms.o
> > > > > > >     LD      .tmp_vmlinux1
> > > > > > >   ld: percpu cache hot section too large
> > > > > > >   make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> > > > > > >
> > > > > > > (I haven't figured out the root cause yet.)
> > > > > >
> > > > > > CONFIG_MPENTIUM4 sets X86_L1_CACHE_SHIFT to 7 (128 bytes).
> > > > >
> > > > > Hm, to resolve this I'd go for the easy out of explicitly using '=
64' as
> > > > > the size limit - like we did it in the C space.
> > > >
> > > > Why not simply:
> > > >
> > > > ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D L1_CACHE_BYTES,=
 "...")
> > > >
> > > > ?
> > >
> > > I don't think it's a great idea to randomly allow a larger section
> > > depending on the .config ... The *actual* intended limit is 64, not 1=
28
> > > and not 4096, so I'd suggest we write it out as before.
> >
> > Change the assert to:
> >        ASSERT(__per_cpu_hot_pad - __per_cpu_hot_start <=3D 64, "percpu
> > cache hot section too large")
> >
> > We only care about the used portion, not the padded end.
>
> If this is the case, perhaps it is better to use __per_cpu_hot_end
> to mark the end of the real data, as in the attached patch.

That's a better approach.  There's not much value in the current _end
symbol if it's not always _start+64.


Brian Gerst

