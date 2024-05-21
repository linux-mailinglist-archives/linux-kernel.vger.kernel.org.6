Return-Path: <linux-kernel+bounces-185128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49398CB0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4902821D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409C0142E6C;
	Tue, 21 May 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4TCcxKG"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AD130A54;
	Tue, 21 May 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303508; cv=none; b=dtDL5id5Gs/yl85HFfzXQzi3r/FsUJYrUCt88Qb0gBex02UfPAFCkqXct/qQIu4+VmXM2X04mfoKHf1bPnHCcwO/0sBL/AXFNCgenfCMnvErQ0eneoapjBMAZtQZAeAZArDvUIoAKW4Qel2D4XDBG5zyHYfEQCXJBKB6e7lClqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303508; c=relaxed/simple;
	bh=Uiscs0U341tdEUrH05/ILKU4Gt6KpnkNj6+JQX2v6Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og8n/RoDpRvqSssvLlC4+E0hKDML/29w9jgsaztouFSKmtNZpymvLkwsnIUHGm0VeX8wjTzzPhG7B98IPlhniRzpNRDmbrJmusBCqQMVcUrtFeqGhz5Sw8ey5j7OGFJqQRF7nZ1VhnHRtcy93q2AWak4o2qqVgC/nz5kPTKqfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4TCcxKG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354cd8da8b9so1090785f8f.0;
        Tue, 21 May 2024 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716303505; x=1716908305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCP0JX7AzC1ediVXRIfcPiizg+qYKlRX3WKBJgSjoaY=;
        b=I4TCcxKGN4kx7h2tQNsaBNI9/W5l403RWVw4ZFfQOKzolLxhFWQZ9qpniyor7lR/TD
         o4sLo7zYwuVeStKoY971v6WAavxXK2vM0xjdGReVCBHTtl89gR5iJgOeDW/e75q0sgYq
         pg2zvplK766s0cb+m3AcYBxPqhwdjnKtwbu7uZdtY8LY6hUiAwULT1KyctiVcdXzYnpA
         pe6EnpOnaD5G+eVkHR6XdikrSYWZiKZu5j4xk/KAJCYisAJ8lVFsmqcta9aAGB/FsDb0
         /ab7Oj/R2jesKl8G5GM2yxjp477Sz0Dx4B2M0xdBGKjp5+axo9ndb1rJSPeRsZlZVfV4
         KbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303505; x=1716908305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCP0JX7AzC1ediVXRIfcPiizg+qYKlRX3WKBJgSjoaY=;
        b=CAumdYeG+kUX8OVsM9NKpxlO6hd71BCz18Ma/gf4MrnbXeI+cYUxQj6BIJdJYX1iy8
         JMyuYFQIcsD46oXoUwvf233H8NPzOqycAJISOat1C8vEzOes2AeIsXnAIojXDwTs0MIT
         RUCioW4K5y/mCg3GdsxS4BPpPc6D9XjSKuNEbcaPYgyj9pu2+FEmXtNP+3iC13n4m0qJ
         V3xlek2/hClqhOQiqeqAAFAvmRAyzieiYXr7Te9giKlvQOSWXJzEyAV3kGHLRgOgzlMY
         lAnW3saL/HhUwjV76fPvZlMQAxlbq6SWheDWqGailo+xoSPsN+FNC2imSMjblWfR8tsB
         Ia0g==
X-Forwarded-Encrypted: i=1; AJvYcCVdljxvLqnEazuk28DnKyCpuQ1YfI36WsIuSE/s9yZdAS+qOvW7aUMahcaTQ/BLMCzbxqnUJygWOynALCYoLBlo3Pg1GK7r2Kb6Q1sGzsZgyAtz4hk8q/XLhpyO86kG05ScCw+xZ0lj
X-Gm-Message-State: AOJu0YzaA5mMuyiGcSVD2dDTXht0KM57m64j0mSaUI/BP+ETeiSKTA/o
	slvc/HulFxpX5JvmzQPK+oYVK6LNMhn/Zv/mcX9cK9+HIBWaPpPaQfX0OGbUr+KbdyNcH/8NYo1
	K2x1Yxn4hYxuRR4w0A12pfz89UOM=
X-Google-Smtp-Source: AGHT+IEhTPHhWH44XdUrjqpD9flq+8cQ79/myMXTedt2Biaf1H6BFKDKRWN+fCSUNcRVJ9zwxcBWyP2bsbyLtcnWSoQ=
X-Received: by 2002:adf:f60d:0:b0:34d:aaca:2f6f with SMTP id
 ffacd0b85a97d-3504aa667e9mr19890043f8f.69.1716303504810; Tue, 21 May 2024
 07:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-20-jim.cromie@gmail.com>
 <CALwA+NYNPfpyM8ZH3L-fbrqSpzKw61gZU+u_uxP6tjnFe7UJ-w@mail.gmail.com>
In-Reply-To: <CALwA+NYNPfpyM8ZH3L-fbrqSpzKw61gZU+u_uxP6tjnFe7UJ-w@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 21 May 2024 08:57:57 -0600
Message-ID: <CAJfuBxyMBh-1BQMqgXj1GBZ=pwbFK3PuBhRDzM7DNd4ML2hSzw@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 19/33] dyndbg-doc: add classmap info to howto
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:57=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chromi=
um.org> wrote:
>
> On Thu, May 16, 2024 at 7:45=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com>=
 wrote:
> >
> > Describe the 3 API macros providing dynamic_debug's classmaps
> >
> > DYNDBG_CLASSMAP_DEFINE - create, exports a module's classmap
>
> create, exports a module's classmap - > creates and exports a module's cl=
assmap

I was going for an imperative "thou shalt" voice,
rather than a descriptive/passive voice
since its an API, and thou shalt use it "this way"
( s/creates/create/ if so)

Do we / linux-doc  have a preference in this regard ?




>
> > DYNDBG_CLASSMAP_USE    - refer to exported map
>
> DYNDBG_CLASSMAP_USE - refers to exported map
>
> > DYNDBG_CLASSMAP_PARAM  - bind control param to the classmap
>
> bind -> binds
>
> > DYNDBG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug
> >
>
> + use module's storage - __drm_debug -> - uses module's storage (for
> example __drm_debug)
>
> > cc: linux-doc@vger.kernel.org
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> > v5 adjustments per Randy Dunlap
> > v7 checkpatch fixes
> > v8 more
> > ---
> >  .../admin-guide/dynamic-debug-howto.rst       | 63 ++++++++++++++++++-
> >  1 file changed, 62 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index 6a8ce5a34382..742eb4230c6e 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > @@ -225,7 +225,6 @@ the ``p`` flag has meaning, other flags are ignored=
.
> >  Note the regexp ``^[-+=3D][fslmpt_]+$`` matches a flags specification.
> >  To clear all flags at once, use ``=3D_`` or ``-fslmpt``.
> >
> > -
> >  Debug messages during Boot Process
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -375,3 +374,65 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``=
.
> >  For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format stri=
ng is
> >  its ``prefix_str`` argument, if it is constant string; or ``hexdump``
> >  in case ``prefix_str`` is built dynamically.
> > +
> > +Dynamic Debug classmaps
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Dyndbg allows selection/grouping of *prdbg* callsites using structural
> > +info: module, file, function, line.  Classmaps allow authors to add
> > +their own domain-oriented groupings using class-names.  Classmaps are
> > +exported, so they referencable from other modules.
>
> Typo referencable -> are referenceable
>
>
>
> > +
> > +  # enable classes individually
> > +  :#> ddcmd class DRM_UT_CORE +p
> > +  :#> ddcmd class DRM_UT_KMS +p
> > +  # or more selectively
> > +  :#> ddcmd class DRM_UT_CORE module drm +p
> > +
> > +The "class FOO" syntax protects class'd prdbgs from generic overwrite:=
:
> > +
> > +  # IOW this doesn't wipe any DRM.debug settings
> > +  :#> ddcmd -p
> > +
> > +To support the DRM.debug parameter, DYNDBG_CLASSMAP_PARAM* updates all
> > +classes in a classmap, mapping param-bits 0..N onto the classes:
> > +DRM_UT_<*> for the DRM use-case.
> > +
> > +Dynamic Debug Classmap API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +DYNDBG_CLASSMAP_DEFINE - modules use this to create classmaps, naming
> > +each of the classes (stringified enum-symbols: "DRM_UT_<*>"), and
> > +type, and mapping the class-names to consecutive _class_ids.
> > +
> > +By doing so, modules tell dyndbg that they have prdbgs with those
> > +class_ids, and they authorize dyndbg to accept "class FOO" for the
> > +module defining the classmap, and its contained classnames.
> > +
> > +DYNDBG_CLASSMAP_USE - drm drivers invoke this to ref the CLASSMAP that
> > +drm DEFINEs.  This shares the classmap definition, and authorizes
> > +dyndbg to apply changes to the user module's class'd pr_debugs.  It
> > +also tells dyndbg how to initialize the user's prdbgs at modprobe,
> > +based upon the current setting of the parent's controlling param.
> > +
> > +There are 2 types of classmaps:
> > +
> > + DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
> > + DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
> > +
> > +DYNDBG_CLASSMAP_PARAM - modelled after module_param_cb, it refers to a
> > +DEFINEd classmap, and associates it to the param's data-store.  This
> > +state is then applied to DEFINEr and USEr modules when they're modprob=
ed.
> > +
> > +This interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
> > +amongst the contained classnames; all classes are independent in the
> > +control parser itself.
> > +
> > +Modules or module-groups (drm & drivers) can define multiple
> > +classmaps, as long as they share the limited 0..62 per-module-group
> > +_class_id range, without overlap.
> > +
> > +``#define DEBUG`` will enable all pr_debugs in scope, including any
> > +class'd ones.  This won't be reflected in the PARAM readback value,
> > +but the class'd pr_debug callsites can be forced off by toggling the
> > +classmap-kparam all-on then all-off.
> > --
> > 2.45.0
> >

