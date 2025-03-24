Return-Path: <linux-kernel+bounces-574577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A6A6E6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6655A7A3271
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C291EF0AE;
	Mon, 24 Mar 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYHIuZ+j"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375DB1DA628
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742857141; cv=none; b=ZNrLzU5dDj80l3lYWFutodLYoYa/p82Qw4UgoLtRSnRkpuBnnmc4F4TVbnOcpKRF/HAEXD2hGhaklcVU0OKc9cFsr+9lQ89QJA4GouYq0HV1u0Sc7gjt70OMwwP/buIWfQ2rGaRsMlv6RCyzgEyuN71xkTUv/wwcTYfn3axosNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742857141; c=relaxed/simple;
	bh=x3g84SFyqbXWab5/rtbXK9bdYKVQSXAZev6zLXFbDbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JeJm5MJj/xekzkCk/jzjZx6i/Ni2I3A95ervOMCqKSeqfB9i/2llwcjk6cabykx1VGRmr2DcNJCePS0B+WtYn/l0IP6C1t4empxvmBX/HXIAFyGPCZZCRuvnZvvUUcIQgp1r8VPXCDisBN0z9ANHKXiYVavlKxlsmc8nZ6kc5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYHIuZ+j; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6ca9a3425so49534147b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742857138; x=1743461938; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOweNL3SXc2nhIPv7ifUcHo8yRDM2GGo5EVKCdQ2n5I=;
        b=KYHIuZ+j789G3X+24hwXi5SclylJuwuKU8aJr/s410sFalwSCv2SfZno9Y+RTiE6u1
         eW1almjoPF/Idr9mzPEP04HY6kcrW2J6QreFblVLiZLUAudJNGhaGz2Q0S4C4kprSRy/
         vS+6qzgDP+X58+so+O+6NXifXZ/9celP6oSSmZwtPibYd4FcKw+7DStVTKo2VnvKHjOe
         oox167919gi3UwzOHu2/0qD5Krrbh0otX3FzQ96nPqwvOqVIioyV0c3E6L2JS0G9eccx
         6Ep67iA2kNIsN7iUX7gPR1i6T/nbPPUFMhr7ZzWCrwPyDJK+iG1kYJsochB5lnfSMGeD
         F82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742857138; x=1743461938;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOweNL3SXc2nhIPv7ifUcHo8yRDM2GGo5EVKCdQ2n5I=;
        b=e9H0y1/8/qP4S3JOqZ5IJvLWkKLB8g0Qqg//CZ/8iajitZNml0m/F3UCMyjGAPwlhW
         NBEFtOiQnw79BGY2fSn5wHDgQcDGGpxOYDmvaKcetcWDOnNrz/NAzg9YeUMLFUEyvsXR
         0MCnqsK0QP54/exJR7/DJ7gAjOacgNzg1b63LpSVRVos7K+rO/MB+dzpYrvS7ze7KqhD
         /u9sRPoUb1/mbDqHEWRrB1KQPt9TN1LEfPCu3jbMSs9FCNFVJxQUNfST1gPcc9it7Xhk
         5UNL9yraydtpY32dCmUf8GvIkQA2YYJRY5z4q/xPEA6Yc4a/8kmB6kJyiRzmC3jFJJwG
         /Lbg==
X-Forwarded-Encrypted: i=1; AJvYcCVvUCOtkIsncI04PSEQqN9ybLfSlXaSxT22+5gwtiu3HvMzjXiLOVnxl63qWhBQjXASoTTteIf4CRUbnmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlTLAIsVQQDhPJWUaO2hs+GkNAOafIWJtAl8BCY0gRaiYV963
	DZKpUXBcNthijQredoTOcnsOvVQGlfTpNtuje+3isIyXPzRXMifRBh9tg3rae+cal03KHRMIYqJ
	PlywNeNps96K94IUSc1+Kz2+ewi4=
X-Gm-Gg: ASbGncuF6Ova53f0/NEXgbq9hwiqSYklqAY+8Ny/bvWQjR6Fxs1LcTqTmSFeGhdBRWw
	2WPZWgfGy8SDBZFOvnfxZEYeINOpT4+jhnEIZKrY9pe+BFBEoq81MK0B9+SuUcKF1PUXjE2qAEN
	XEXBj1lXc8fRoPmxS+KebW9PHb
X-Google-Smtp-Source: AGHT+IGJQhE8J9Fev2YDAjew937hy/BDBKy0IxGWP41fseJBpVPTdqCggsrZGeRZCl04ynbwuEzhtC0igtYRZyc/8n8=
X-Received: by 2002:a05:690c:4444:b0:6ef:652b:91cf with SMTP id
 00721157ae682-700bacd28e9mr200033997b3.27.1742857137825; Mon, 24 Mar 2025
 15:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <20250125064619.8305-29-jim.cromie@gmail.com>
 <160ec360-918d-414f-aef9-606cfa1749df@bootlin.com> <CAJfuBxxzXoKummiBDGODidpRj7Fm2UDip-T0qkB7L9tscK0zCQ@mail.gmail.com>
In-Reply-To: <CAJfuBxxzXoKummiBDGODidpRj7Fm2UDip-T0qkB7L9tscK0zCQ@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Mon, 24 Mar 2025 16:58:31 -0600
X-Gm-Features: AQ5f1Jq_ealCWnlM2C-q0MIDv15aWKUMJ6YjQ3JJZCvoTPWllKRV36DEBSe2p6k
Message-ID: <CAJfuBxwCPfPHqWFx0Jh+sucT2smf7o_5TmDJELkV7J--ftotuA@mail.gmail.com>
Subject: Re: [PATCH 28/63] dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 3:14=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Tue, Feb 25, 2025 at 7:29=E2=80=AFAM Louis Chauvet <louis.chauvet@boot=
lin.com> wrote:
> >
> >
> >
> > Le 25/01/2025 =C3=A0 07:45, Jim Cromie a =C3=A9crit :
> > > move the DYNDBG_CLASSMAP_PARAM macro from test-dynamic-debug.c into
> > > the header, and refine it, by distinguishing the 2 use cases:
> > >
> > > 1.DYNDBG_CLASSMAP_PARAM_REF
> > >      for DRM, to pass in extern __drm_debug by name.
> > >      dyndbg keeps bits in it, so drm can still use it as before
> > >
> > > 2.DYNDBG_CLASSMAP_PARAM
> > >      new user (test_dynamic_debug) doesn't need to share state,
> > >      decls a static long unsigned int to store the bitvec.
> > >
> > > __DYNDBG_CLASSMAP_PARAM
> > >     bottom layer - allocate,init a ddebug-class-param, module-param-c=
b.
> > >
> > > Modify ddebug_sync_classbits() argtype deref inside the fn, to give
> > > access to all kp members.
> > >
> > > Also clean up and improve comments in test-code, and add
> > > MODULE_DESCRIPTIONs.
> > >
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > > ---
> > >
> > > -v9
> > >   - fixup drm-print.h  add PARAM_REF forwarding macros
> > >     with DYNDBG_CLASSMAP_PARAM_REF in the API, add DRM_ variant
> > > ---
> > >   include/linux/dynamic_debug.h   | 38 +++++++++++++++++++++
> > >   lib/dynamic_debug.c             | 60 ++++++++++++++++++++++--------=
---
> > >   lib/test_dynamic_debug.c        | 59 +++++++++++++-----------------=
--
> > >   lib/test_dynamic_debug_submod.c |  9 ++++-
> > >   4 files changed, 111 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_de=
bug.h
> > > index 48d76a273f68..b47d1088b7ad 100644
> > > --- a/include/linux/dynamic_debug.h
> > > +++ b/include/linux/dynamic_debug.h
> > > @@ -205,6 +205,44 @@ struct ddebug_class_param {
> > >       const struct ddebug_class_map *map;
> > >   };
> > >
> > > +/**
> > > + * DYNDBG_CLASSMAP_PARAM - control a ddebug-classmap from a sys-para=
m
> > > + * @_name:  sysfs node name
> > > + * @_var:   name of the classmap var defining the controlled classes=
/bits
> > > + * @_flags: flags to be toggled, typically just 'p'
> > > + *
> > > + * Creates a sysfs-param to control the classes defined by the
> > > + * exported classmap, with bits 0..N-1 mapped to the classes named.
> > > + * This version keeps class-state in a private long int.
> > > + */
> > > +#define DYNDBG_CLASSMAP_PARAM(_name, _var, _flags)                  =
 \
> > > +     static unsigned long _name##_bvec;                             =
 \
> > > +     __DYNDBG_CLASSMAP_PARAM(_name, _name##_bvec, _var, _flags)
> > > +
> > > +/**
> > > + * DYNDBG_CLASSMAP_PARAM_REF - wrap a classmap with a controlling sy=
s-param
> > > + * @_name:  sysfs node name
> > > + * @_bits:  name of the module's unsigned long bit-vector, ex: __drm=
_debug
> > > + * @_var:   name of the (exported) classmap var defining the classes=
/bits
> > > + * @_flags: flags to be toggled, typically just 'p'
> > > + *
> > > + * Creates a sysfs-param to control the classes defined by the
> > > + * exported clasmap, with bits 0..N-1 mapped to the classes named.
> > > + * This version keeps class-state in user @_bits.  This lets drm che=
ck
> > > + * __drm_debug elsewhere too.
> > > + */
> > > +#define DYNDBG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)       =
         \
> > > +     __DYNDBG_CLASSMAP_PARAM(_name, _bits, _var, _flags)
> > > +
> > > +#define __DYNDBG_CLASSMAP_PARAM(_name, _bits, _var, _flags)         =
 \
> > > +     static struct ddebug_class_param _name##_##_flags =3D {        =
   \
> > > +             .bits =3D &(_bits),                                    =
   \
> > > +             .flags =3D #_flags,                                    =
   \
> > > +             .map =3D &(_var),                                      =
   \
> > > +     };                                                             =
 \
> > > +     module_param_cb(_name, &param_ops_dyndbg_classes,              =
 \
> > > +                     &_name##_##_flags, 0600)
> > > +
> > >   /*
> > >    * pr_debug() and friends are globally enabled or modules have sele=
ctively
> > >    * enabled them.
> > > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > > index 781781835094..9283f2866415 100644
> > > --- a/lib/dynamic_debug.c
> > > +++ b/lib/dynamic_debug.c
> > > @@ -660,6 +660,30 @@ static int ddebug_apply_class_bitmap(const struc=
t ddebug_class_param *dcp,
> > >
> > >   #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
> > >
> > > +static void ddebug_class_param_clamp_input(unsigned long *inrep, con=
st struct kernel_param *kp)
> > > +{
> > > +     const struct ddebug_class_param *dcp =3D kp->arg;
> > > +     const struct ddebug_class_map *map =3D dcp->map;
> > > +
> > > +     switch (map->map_type) {
> > > +     case DD_CLASS_TYPE_DISJOINT_BITS:
> > > +             /* expect bits. mask and warn if too many */
> > > +             if (*inrep & ~CLASSMAP_BITMASK(map->length)) {
> > > +                     pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, =
masking\n",
> > > +                             KP_NAME(kp), *inrep, CLASSMAP_BITMASK(m=
ap->length));
> > > +                     *inrep &=3D CLASSMAP_BITMASK(map->length);
> > > +             }
> > > +             break;
> > > +     case DD_CLASS_TYPE_LEVEL_NUM:
> > > +             /* input is bitpos, of highest verbosity to be enabled =
*/
> > > +             if (*inrep > map->length) {
> > > +                     pr_warn("%s: level:%ld exceeds max:%d, clamping=
\n",
> > > +                             KP_NAME(kp), *inrep, map->length);
> > > +                     *inrep =3D map->length;
> > > +             }
> > > +             break;
> > > +     }
> > > +}
> > >   static int param_set_dyndbg_module_classes(const char *instr,
> > >                                          const struct kernel_param *k=
p,
> > >                                          const char *modnm)
> > > @@ -678,26 +702,15 @@ static int param_set_dyndbg_module_classes(cons=
t char *instr,
> > >               pr_err("expecting numeric input, not: %s > %s\n", instr=
, KP_NAME(kp));
> > >               return -EINVAL;
> > >       }
> > > +     ddebug_class_param_clamp_input(&inrep, kp);
> > >
> > >       switch (map->map_type) {
> > >       case DD_CLASS_TYPE_DISJOINT_BITS:
> > > -             /* expect bits. mask and warn if too many */
> > > -             if (inrep & ~CLASSMAP_BITMASK(map->length)) {
> > > -                     pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, =
masking\n",
> > > -                             KP_NAME(kp), inrep, CLASSMAP_BITMASK(ma=
p->length));
> > > -                     inrep &=3D CLASSMAP_BITMASK(map->length);
> > > -             }
> > >               v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", =
KP_NAME(kp));
> > >               totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, *dcp-=
>bits, modnm);
> > >               *dcp->bits =3D inrep;
> > >               break;
> > >       case DD_CLASS_TYPE_LEVEL_NUM:
> > > -             /* input is bitpos, of highest verbosity to be enabled =
*/
> > > -             if (inrep > map->length) {
> > > -                     pr_warn("%s: level:%ld exceeds max:%d, clamping=
\n",
> > > -                             KP_NAME(kp), inrep, map->length);
> > > -                     inrep =3D map->length;
> > > -             }
> > >               old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
> > >               new_bits =3D CLASSMAP_BITMASK(inrep);
> > >               v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits,=
 KP_NAME(kp));
> > > @@ -1163,15 +1176,24 @@ static const struct proc_ops proc_fops =3D {
> > >   static void ddebug_sync_classbits(const struct kernel_param *kp, co=
nst char *modname)
> > >   {
> > >       const struct ddebug_class_param *dcp =3D kp->arg;
> > > +     unsigned long new_bits;
> > >
> > > -     /* clamp initial bitvec, mask off hi-bits */
> > > -     if (*dcp->bits & ~CLASSMAP_BITMASK(dcp->map->length)) {
> > > -             *dcp->bits &=3D CLASSMAP_BITMASK(dcp->map->length);
> > > -             v2pr_info("preset classbits: %lx\n", *dcp->bits);
> > > +     ddebug_class_param_clamp_input(dcp->bits, kp);
> > > +
> > > +     switch (dcp->map->map_type) {
> > > +     case DD_CLASS_TYPE_DISJOINT_BITS:
> > > +             v2pr_info("  %s: classbits: 0x%lx\n", KP_NAME(kp), *dcp=
->bits);
> > > +             ddebug_apply_class_bitmap(dcp, dcp->bits, 0UL, modname)=
;
> > > +             break;
> > > +     case DD_CLASS_TYPE_LEVEL_NUM:
> > > +             new_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
> > > +             v2pr_info("  %s: lvl:%ld bits:0x%lx\n", KP_NAME(kp), *d=
cp->lvl, new_bits);
> > > +             ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname)=
;
> > > +             break;
> > > +     default:
> > > +             pr_err("bad map type %d\n", dcp->map->map_type);
> > > +             return;
> > >       }
> > > -     /* force class'd prdbgs (in USEr module) to match (DEFINEr modu=
le) class-param */
> > > -     ddebug_apply_class_bitmap(dcp, dcp->bits, ~0, modname);
> > > -     ddebug_apply_class_bitmap(dcp, dcp->bits, 0, modname);
> >
> > Hi Jim,
> >
> > We lost the double call with ~0/0, is it normal?
>
> Good catch,
>
> I thought so, since it guarantees the pr_debugs' state to
> comport with sysfs settings on modprobe.
>
> I will review.
>

Ok, Im pretty sure I put those in to override DEBUG settings,
ie reset the default print state to whatever the controlling sysfs node,
if it was declared with CLASSMAP_PARAM*, has the var set at.

It now seems like extra work to clean up a corner case
which they asked for, by defining DEBUG

