Return-Path: <linux-kernel+bounces-563135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12A8A63767
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF34016C191
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567641922DD;
	Sun, 16 Mar 2025 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv/fWxER"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FF381C4
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742158023; cv=none; b=soTM0KOlyqOI831l2vULbtuhaDjqoHZwbyCWtw/OmAVS4NsepCdD9UtLBHgowy7hH51uNQexy/cCNafWideXwr4wccFr2H13J7zQeSXLp76Byj9FoFWOtHYEjlWdtjqw5UPkfPy86+HRieTE6zxnKiLi9I8L6SbkGnelsegxh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742158023; c=relaxed/simple;
	bh=WjOX0W7CUyWm57wp1Ivr70eZeHI8gR9Cum5p2xNGmHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BUo929BsVMI/TmxHiOfRTOdIY14mClv1jR5dR5zIEUCN7I/KjQh8TMhcM3eZJKBLFCtRkKR6J92Gx7fDgejMg+RaBPKI1Lmc2C6tWpF+1mFk/Q5imm/MNqvJwqbRZbDI5rJgBkPc6x2xms3/kH/VhjpOsK6ejAEi8DF8j+yzTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv/fWxER; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so3540677276.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742158021; x=1742762821; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpQUNmwVK5jHLQezc5R4Z6K7OjXDtGHykFpm0bMm/ps=;
        b=fv/fWxERmiPul5L3pnIvavj2oIJ+XuGuydow2lrxvUu1M8lHcrTSZIIiPqVoqqK6/8
         6zT7VD19FkEOnIRcK3SFmBMeHHNXfgohuoSpaB9MjaSvpgpohdGflf6BIC1Ij9mCu1nh
         QY9Cx1zoEUxN2WqZRzmiHqXO3BooaLLwv2KQp9stken4A7T7bpfRgnxIjob0aqMUonmZ
         WhJ3uC1YfLdJUPHYeYXdAhBrEbB9pal9+Q4ZpBFPbANlN895w+LdFtdWtyONev/9tDOo
         FHc50dhKhDzPz5+aDtcrTeo7+8OzDYv6pPKEerq837Z2sd0KFlQEMG7WRlr3M8mZLyk+
         Ji5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742158021; x=1742762821;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpQUNmwVK5jHLQezc5R4Z6K7OjXDtGHykFpm0bMm/ps=;
        b=X4/Ap3DJtyW+u55+z7x3v61L6f8ZcBbXkMNOdZU7u7jrwn/Ix4pPPc8igEJvBQoube
         +aIGhubfAsE3enoKzTm1O/vuFSNV2EZcfeUBp5KaAPgEInuIjMlPyVLcTnwa2x823xFp
         +CL452Vpk+vDFW7TMPVzHKDWRM1j3wLwTaTWfAZRpQqpuxIVSfLVCxy5MZFSFEGn1CyR
         /1g41b2IpoY64onXAYnokN+7kwqE3wE79Uvq8S+h170MZPHaOZ51qt0QdAUgozmSKsjU
         T5syOtrp8B4T3LFhJxy0GZOoR7ctXAYdHP6dV+2RroKMOBlO9GAZ8VkZwlRtFpoOndOt
         fOwg==
X-Forwarded-Encrypted: i=1; AJvYcCWDDkblOZWrfRpE7qvCkHeEv84D/wzy6wGR8M2wXjLXF7sq0dO3qA9Bf8mwnkgo5Xu3rRg2Xj+TdsHdUSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8q3QMv1Xvqo9+QpUB/bdndNoE3vQIl50IR9y2Mzb+Ov3pDogD
	x7zgusIxYUjlzWjEfaa+0iU+//g6xYGD3GS2DYZQfNyezfS8qVWEj8tJXvcYlI7BLteRq5/ethb
	2FwISkFwgXWG3GZd0hCPR3Qs8HNQ=
X-Gm-Gg: ASbGncvGEXe5lJahCJ1St9Fdf1EbqS6sg+IMiuCOJaG2qWP6dIMG5J8U6IrcwaDtKec
	Sv1I3Nsvmb1QiBR91m6cEsA8X5NfYAhqujzpGe1CDuz7egYQRIwvDHDR0ZuEvfBzign9+fuALTp
	j4iOOPgWJ1OyMbaCCzRnia1Vz7
X-Google-Smtp-Source: AGHT+IGhYVBn7vR4Knu9i9p1S4VK8hyNoaUSgXFGJfzH1GI7bLCBQBjmUDNC8ud8qNAZI0CQlE/V8lGFiNOUrbF8nOs=
X-Received: by 2002:a05:6902:490d:b0:e5d:c30f:22ec with SMTP id
 3f1490d57ef6-e63f64dcbf3mr14511779276.9.1742158020821; Sun, 16 Mar 2025
 13:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <20250125064619.8305-18-jim.cromie@gmail.com>
 <29ca1dc2-3a21-405f-a9b6-06bea7bd75ae@bootlin.com>
In-Reply-To: <29ca1dc2-3a21-405f-a9b6-06bea7bd75ae@bootlin.com>
From: jim.cromie@gmail.com
Date: Sun, 16 Mar 2025 14:46:35 -0600
X-Gm-Features: AQ5f1JprR-UJ_0VXd2VsB4dKW3nxrkYe1QDrUeDVJ6N3x3HhjWh_YqIyfWvWlNY
Message-ID: <CAJfuBxwJ5SgEP15nPpYJbwXi4iDJqVRS9FL8hdkHCkDct=Abrw@mail.gmail.com>
Subject: Re: [PATCH 17/63] dyndbg: check DYNDBG_CLASSMAP_DEFINE args at compile-time
To: Louis Chauvet <louis.chauvet@bootlin.com>, Jim Cromie <jim.cromie@gmail.com>, 
	linux-kernel@vger.kernel.org, jbaron@akamai.com, gregkh@linuxfoundation.org, 
	ukaszb@chromium.org, intel-gfx-trybot@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:17=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 25/01/2025 =C3=A0 07:45, Jim Cromie a =C3=A9crit :
> > Add __DYNDBG_CLASSMAP_CHECK to implement these arg-checks at compile:
> >       0 <=3D _base < 63
> >       class_names is not empty
> >       class_names[0] is a string
> >       (class_names.length + _base) < 63
> >
> > These compile-time checks will prevent several misuses; 4 such
> > examples are added to test_dynamic_debug_submod.ko, and will fail
> > compilation if -DDD_MACRO_ARGCHECK is added to cflags.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> > - split static-asserts to __DYNDBG_CLASSMAP_CHECK
> > - move __DYNDBG_CLASSMAP_CHECK above kdoc for DYNDBG_CLASSMAP_DEFINE
> >    silences kernel-doc warnings
> > ---
> >   include/linux/dynamic_debug.h |  9 +++++++++
> >   lib/test_dynamic_debug.c      | 11 +++++++++++
> >   2 files changed, 20 insertions(+)
> >
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index dc610a12b91c..2b0c943af330 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -99,6 +99,14 @@ struct ddebug_class_map {
> >       enum ddebug_class_map_type map_type;
> >   };
> >
> > +#define __DYNDBG_CLASSMAP_CHECK(_clnames, _base)                     \
> > +     static_assert(((_base) >=3D 0 && (_base) < _DPRINTK_CLASS_DFLT), =
 \
> > +                   "_base must be in 0..62");                        \
> > +     static_assert(ARRAY_SIZE(_clnames) > 0,                         \
> > +                   "classnames array size must be > 0");             \
> > +     static_assert((ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLASS_D=
FLT, \
> > +                   "_base + classnames.length exceeds range")
> > +
> >   /**
> >    * DYNDBG_CLASSMAP_DEFINE - define debug classes used by a module.
> >    * @_var:   name of the classmap, exported for other modules coordina=
ted use.
> > @@ -112,6 +120,7 @@ struct ddebug_class_map {
> >    */
> >   #define DYNDBG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)            \
> >       static const char *_var##_classnames[] =3D { __VA_ARGS__ };      =
 \
> > +     __DYNDBG_CLASSMAP_CHECK(_var##_classnames, (_base));            \
> >       extern struct ddebug_class_map _var;                            \
> >       struct ddebug_class_map __aligned(8) __used                     \
> >               __section("__dyndbg_classes") _var =3D {                 =
 \
> > diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> > index 1838f62738c4..b1555b0a2bb1 100644
> > --- a/lib/test_dynamic_debug.c
> > +++ b/lib/test_dynamic_debug.c
> > @@ -123,8 +123,19 @@ DYNDBG_CLASSMAP_PARAM(level_num, p);
> >   DYNDBG_CLASSMAP_USE(map_disjoint_bits);
> >   DYNDBG_CLASSMAP_USE(map_level_num);
> >
> > +#if defined(DD_MACRO_ARGCHECK)
> > +/*
> > + * Exersize compile-time arg-checks in DYNDBG_CLASSMAP_DEFINE.
> > + * These will break compilation.
> > + */
> > +DYNDBG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG");
> > +DYNDBG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
> > +DYNDBG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
> > +DYNDBG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
>
> Hi Jim,
>
> This test is nice, but can we move it in the *_submod.c directly? They
> don't need anything from this file.
>

Hi Louis,

Given my strong preference for continued / justified ifdeffery earlier,
I will interpret this as move these corner-case tests into the
submod-only branch.

Im happy to do it, and I see the commit-msg says that specifically,
but Im not sure what it will improve by moving it.
I could fix the commit msg instead.

these compile-time tests will break the build,
so I dont think theyre much good as a CONFIG_ option for example.

So making the breakage submodule specific isnt
much of a reduction in blast radius, and it only opens the why-submod-only =
?

Any views or options ?  (both welcomed)


> Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>

ack!

> Thanks,
> Louis Chauvet
>
> >   #endif
> >
> > +#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
> > +
> >   /* stand-in for all pr_debug etc */
> >   #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
> >
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

