Return-Path: <linux-kernel+bounces-186322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62108CC2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B53D2822B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D97824A3;
	Wed, 22 May 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XVeUk8Eq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4256AB9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386519; cv=none; b=dHKyId0z/KG5oyv7UJySklkBHThcYfc2+ybrUQI7X4+FhxrbrQx1NS+gauyTA2AB36OAk2Ugk8Vnn2anTSwR0JWf7ctA8ULVu9+zd7CiTPAm9P628XSXw4F5rQ8RT65RI7nkx90WulK7+vs0s94CDaOHB/KUDVqZE057BLMKTe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386519; c=relaxed/simple;
	bh=myYHA+ZviKp/pX06xhXrEgiAUMeEmoKowIRkjh6lviY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGsPXiGfhBtaqNJbgNYJ9Ie76RSHDbJpp3FIhkRQMMqPCua1iAFakR6c/XUeQ4PMEjJ2o3TYgoG2a79kNquZ8JoaOQasxpLHPSs3gZUVs4fuMANF9RT0Wju6FtVrp0OBcmCgg4dn9G1QzouPkKqJ7vVE/TwHroGL7u4+l2KtrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XVeUk8Eq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5238b7d0494so6685474e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716386516; x=1716991316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpcH2M2rE7fdWSwrlKhRsJ3VqP+ueP08PmnanHg+yOo=;
        b=XVeUk8Eqhxg3B8sV5qGvp25BhNKN7Df5h9yzHWQIahb2SXJuBDydsfFczYzG/O54eX
         58aj9/yNWeByAa5YyEuIulM649JRlZr42mK+2ieu9RJv3qA3pN86CgbJpEFinA65ykcT
         gze1Uzn8VGJRMszKY3hstnQlMVM4v7EdslKyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386516; x=1716991316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpcH2M2rE7fdWSwrlKhRsJ3VqP+ueP08PmnanHg+yOo=;
        b=mfiHxXDb33z4TqH6Iq3YccJolJHXswCP37OsGMEHMa308J9SDsVdhB+H0DuK5RrID6
         Fb0svBOHkDKV0Q/T6rzgLCqgC++9wxOIBvgp5N72dw7QHkbvPVGM4am1h/Y54pK5B5Sg
         XjptDzZfORLOu67k/ugXgW3n9rjompT3G8+NVIlO616UX0ad5GS3O+uRoooCfviR768l
         +FPsQIK0Z1NHHi4BleCcBZxtSaaIlsGzzyDX2r0yfC+9lFlfjWNQJdBlIkYPXrfBFyWM
         n/uMAScNdJ8ChKA7yCDzve5Bhkisiy1DpBwOOVb+Lm9eedRKD79O4zEIyXDopaeAbOLX
         o+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBW7JseIuwhu2/ZKl0NyExARqEzyDtcBNNfnxtBuSclgU526DsG5UhlY//Ayrs3O/yVeKpyXDb9YuOnnxXEVixsSHnHevUDsWyk2uQ
X-Gm-Message-State: AOJu0YwtP4VZ1BWVrA0ujJeWjOhp5SgXctqCic2TAIerH+XlRD3LldUC
	KH4K+SJm280qOgKW0iykM4kjTKQGh7PmKsQFdEuwgI2Af3krSXBqZLUJzh0a781OFB5ra5zpP9N
	fhHt38VsJLgMswsogIGVkMJ2ob51/6pq8MyY=
X-Google-Smtp-Source: AGHT+IE6TZAaLzabvqwAwFl1mEfPwAsDXOc379Dn3LSqMCtZDjWDWgjg8bKqPdMMj1IWp9/+7WQsG4Na0ieXFGEbGjs=
X-Received: by 2002:ac2:484c:0:b0:51b:1e76:4ea9 with SMTP id
 2adb3069b0e04-526beca954bmr1726704e87.4.1716386515921; Wed, 22 May 2024
 07:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-20-jim.cromie@gmail.com>
 <CALwA+NYNPfpyM8ZH3L-fbrqSpzKw61gZU+u_uxP6tjnFe7UJ-w@mail.gmail.com> <CAJfuBxyMBh-1BQMqgXj1GBZ=pwbFK3PuBhRDzM7DNd4ML2hSzw@mail.gmail.com>
In-Reply-To: <CAJfuBxyMBh-1BQMqgXj1GBZ=pwbFK3PuBhRDzM7DNd4ML2hSzw@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Wed, 22 May 2024 16:01:44 +0200
Message-ID: <CALwA+NaFsTx-ay=29e=6OZWCiawYPYOfFmPXkDv6xDB_odfC+A@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 19/33] dyndbg-doc: add classmap info to howto
To: jim.cromie@gmail.com
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:58=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Tue, May 21, 2024 at 5:57=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chro=
mium.org> wrote:
> >
> > On Thu, May 16, 2024 at 7:45=E2=80=AFPM Jim Cromie <jim.cromie@gmail.co=
m> wrote:
> > >
> > > Describe the 3 API macros providing dynamic_debug's classmaps
> > >
> > > DYNDBG_CLASSMAP_DEFINE - create, exports a module's classmap
> >
> > create, exports a module's classmap - > creates and exports a module's =
classmap
>
> I was going for an imperative "thou shalt" voice,
> rather than a descriptive/passive voice
> since its an API, and thou shalt use it "this way"
> ( s/creates/create/ if so)
>

Makes sense, thanks for the explanation

> Do we / linux-doc  have a preference in this regard ?
>
>
>
>
> >
> > > DYNDBG_CLASSMAP_USE    - refer to exported map
> >
> > DYNDBG_CLASSMAP_USE - refers to exported map
> >
> > > DYNDBG_CLASSMAP_PARAM  - bind control param to the classmap
> >
> > bind -> binds
> >
> > > DYNDBG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug
> > >
> >
> > + use module's storage - __drm_debug -> - uses module's storage (for
> > example __drm_debug)
> >
> > > cc: linux-doc@vger.kernel.org
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > > ---
> > > v5 adjustments per Randy Dunlap
> > > v7 checkpatch fixes
> > > v8 more
> > > ---
> > >  .../admin-guide/dynamic-debug-howto.rst       | 63 +++++++++++++++++=
+-
> > >  1 file changed, 62 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docu=
mentation/admin-guide/dynamic-debug-howto.rst
> > > index 6a8ce5a34382..742eb4230c6e 100644
> > > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > > @@ -225,7 +225,6 @@ the ``p`` flag has meaning, other flags are ignor=
ed.
> > >  Note the regexp ``^[-+=3D][fslmpt_]+$`` matches a flags specificatio=
n.
> > >  To clear all flags at once, use ``=3D_`` or ``-fslmpt``.
> > >
> > > -
> > >  Debug messages during Boot Process
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > @@ -375,3 +374,65 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)=
``.
> > >  For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format st=
ring is
> > >  its ``prefix_str`` argument, if it is constant string; or ``hexdump`=
`
> > >  in case ``prefix_str`` is built dynamically.
> > > +
> > > +Dynamic Debug classmaps
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +
> > > +Dyndbg allows selection/grouping of *prdbg* callsites using structur=
al
> > > +info: module, file, function, line.  Classmaps allow authors to add
> > > +their own domain-oriented groupings using class-names.  Classmaps ar=
e
> > > +exported, so they referencable from other modules.
> >
> > Typo referencable -> are referenceable
> >
> >
> >
> > > +
> > > +  # enable classes individually
> > > +  :#> ddcmd class DRM_UT_CORE +p
> > > +  :#> ddcmd class DRM_UT_KMS +p
> > > +  # or more selectively
> > > +  :#> ddcmd class DRM_UT_CORE module drm +p
> > > +
> > > +The "class FOO" syntax protects class'd prdbgs from generic overwrit=
e::
> > > +
> > > +  # IOW this doesn't wipe any DRM.debug settings
> > > +  :#> ddcmd -p
> > > +
> > > +To support the DRM.debug parameter, DYNDBG_CLASSMAP_PARAM* updates a=
ll
> > > +classes in a classmap, mapping param-bits 0..N onto the classes:
> > > +DRM_UT_<*> for the DRM use-case.
> > > +
> > > +Dynamic Debug Classmap API
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > +
> > > +DYNDBG_CLASSMAP_DEFINE - modules use this to create classmaps, namin=
g
> > > +each of the classes (stringified enum-symbols: "DRM_UT_<*>"), and
> > > +type, and mapping the class-names to consecutive _class_ids.
> > > +
> > > +By doing so, modules tell dyndbg that they have prdbgs with those
> > > +class_ids, and they authorize dyndbg to accept "class FOO" for the
> > > +module defining the classmap, and its contained classnames.
> > > +
> > > +DYNDBG_CLASSMAP_USE - drm drivers invoke this to ref the CLASSMAP th=
at
> > > +drm DEFINEs.  This shares the classmap definition, and authorizes
> > > +dyndbg to apply changes to the user module's class'd pr_debugs.  It
> > > +also tells dyndbg how to initialize the user's prdbgs at modprobe,
> > > +based upon the current setting of the parent's controlling param.
> > > +
> > > +There are 2 types of classmaps:
> > > +
> > > + DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debu=
g
> > > + DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
> > > +
> > > +DYNDBG_CLASSMAP_PARAM - modelled after module_param_cb, it refers to=
 a
> > > +DEFINEd classmap, and associates it to the param's data-store.  This
> > > +state is then applied to DEFINEr and USEr modules when they're modpr=
obed.
> > > +
> > > +This interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
> > > +amongst the contained classnames; all classes are independent in the
> > > +control parser itself.
> > > +
> > > +Modules or module-groups (drm & drivers) can define multiple
> > > +classmaps, as long as they share the limited 0..62 per-module-group
> > > +_class_id range, without overlap.
> > > +
> > > +``#define DEBUG`` will enable all pr_debugs in scope, including any
> > > +class'd ones.  This won't be reflected in the PARAM readback value,
> > > +but the class'd pr_debug callsites can be forced off by toggling the
> > > +classmap-kparam all-on then all-off.
> > > --
> > > 2.45.0
> > >

