Return-Path: <linux-kernel+bounces-186559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4078CC5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A541F23DED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC23142E6E;
	Wed, 22 May 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Th+jRflB"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906D76048
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399392; cv=none; b=dJlAFN2uvZtCRf07icOTotY0F+42WOuHmOb5+fB4656Gl0qkPEIyfa2BeGdys12yOko0XQgicNR78RCZOfSYF9jsPWy63wkgSYzITh0yGPQx+S7PpmUfmvmWWUakyaLk9Qu2Epk4e+5OymFlmgPwi/It2LAibhLSkjvcuBW07Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399392; c=relaxed/simple;
	bh=fuUqSxmunHH1O6NZ9IKpyd6lGt57Efd5eP0D1Dwu0bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8tEkCBZr0NU6FFfPbiJAlp2cLPK0X5nL5BSb8SeZaOcsyYp6mMNIf5yY6v/kuPnzb41iKOBfFh6evSfQ0satSgDcfRVB5TKTZ2kqMw39yQ7mDvwVGo13BOtdwAI72cv49i8RjhlSGT2Cq0VilAGan6H5RjO/xRghqZ6AbJTz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Th+jRflB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e52181c228so67050421fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716399389; x=1717004189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9AXmTCQB3YD9jnJ9PL31F6x/Rz3QbOUnFEu7HedaMM=;
        b=Th+jRflBJF92aPy04+uYiS5UOBXMcGCE98/NWDn391WjRDzvnh26KOZTvUDH5PCbb3
         pEZlamJv0FS2uQls97YCYp7v3lINE1CRYRza8srrRK3jDpv+E2f8NDm/bhp/sDt2khwi
         zc9fxq3LOoaVXyegtDydoOPSjsoyu9pOLS0ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399389; x=1717004189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9AXmTCQB3YD9jnJ9PL31F6x/Rz3QbOUnFEu7HedaMM=;
        b=vDq14QOG9LEolJ3jhE/wHsI5nng390wLDats5ganQbuWIRv7iApg9txVSlQIic8uJA
         6onZHPjnrQmjeAWfA4bYq636gKudfBIe+6rfeAAVfPlO1tWBpb/wlqCcRU7b4lLTz5Hc
         Pb8dE2NaE6FOaW/WPlYDX/5FtLD8nr2NujOSV7rA80J+zcbKu1C0Varj19Izg5iMH7C/
         9dwRwoym8iO1EHAsABPGjOxUqmd+kvxx+H4FNTigkn3NNUGMt6CLuRh2iTwLib+jq/pw
         7dw/4RqzX/hebsKq90RCRBoAw4HtOYSUmYz8wHdvvfIh12UK+OEfzIghdyj/FGNlTllU
         FZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCW1I9T3Or5DCKGyWq3WLnK71sfZaZUrJMdc/4uWRWDs86F15ihzeTzqqfI+cJ0KLnGahkwV9NoKJu/ckZu1A53UbAXh4BcRVkGjlP9k
X-Gm-Message-State: AOJu0YySLwpRe7uYzsCkfh1QNeypCaopUfE8M+Zx9TCJC982P8oha+Mu
	PbbTEnNZ9gKCr9/DIVfxR3BVIkDmfznGt0kvOJlaEoLHaKzKBpG0tCc5rxV1soicH0vcEScoKVq
	j3OakkFkoflaPjjvFB8j/wLAkdr38WEky+U4=
X-Google-Smtp-Source: AGHT+IGybgsxNtIQ75t5hnME5BDWpfXscvL9SCeB8NHC7FKiB7YmMXnJH4nVtChLEyeUYJXPFzoyGimHRJgN9cCJQRo=
X-Received: by 2002:a05:651c:216:b0:2e8:10ca:2437 with SMTP id
 38308e7fff4ca-2e94959368cmr17323691fa.50.1716399388780; Wed, 22 May 2024
 10:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <CALwA+NZxiapXe-BBY6CvpqT-Z1h_YyMQr=JBwybY55TWtDNiBA@mail.gmail.com>
 <CAJfuBxw3oDbdAwporJw0DXGRbpLqVXxGaBQmOra4vMGDzH94jA@mail.gmail.com>
In-Reply-To: <CAJfuBxw3oDbdAwporJw0DXGRbpLqVXxGaBQmOra4vMGDzH94jA@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Wed, 22 May 2024 19:36:15 +0200
Message-ID: <CALwA+Nbr15Wd_kkMr3bJCON5zhM+JAuhxwgFG654yd+nemzzTw@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 00/33] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y regression
To: jim.cromie@gmail.com
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:11=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Tue, May 21, 2024 at 5:41=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chro=
mium.org> wrote:
> >
> > On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.co=
m> wrote:
> > >
> > > hi Greg, Jason,
> > >
> > > This patchset fixes the CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy regression,
> > > Fixes: bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
> > >
> > > Im calling it v8, to keep consistent with previous labels.
> > > v6 was what got committed, back in 9/2022.
> > > v7 had at least 2 problems that blocked its submission:
> > >
> > >  https://lore.kernel.org/lkml/20231101002609.3533731-1-jim.cromie@gma=
il.com/
> > >  https://patchwork.freedesktop.org/series/125066/
> > >
> > > 1. missing __align(8) in METATDATA macro, giving too much placement
> > > freedom to linker, caused weird segvs following non-ptr vals, but for
> > > builtin modules only. found by lkp-test.
> > >
> > > 2. the main patch touched 2 subsystems at once, which would require
> > > special handling.
> > >
> > > What was broken about DYNAMIC_DEBUG ?
> > >
> > > Booting a modular kernel with drm.debug=3D0x1ff enabled pr_debugs onl=
y
> > > in drm itself, not in the yet-to-be loaded driver + helpers.  Once
> > > loaded, the driver's pr_debugs are properly enabled by:
> > >
> > >    echo 0x1ff > /sys/module/drm/parameters/debug  # still worked
> > >
> > > I had tested with scripts doing lots of modprobes with various
> > > permutations of dyndbg=3D<> option, and I missed that I didn't test
> > > without them.
> > >
> > > The deeper cause was my design error, a violation of the K&R rule:
> > > "define once, refer many times".
> > >
> > > DECLARE_DYNDBG_CLASSMAP defined the classmap, and was used everywhere=
,
> > > re-declaring the same static classmap repeatedly. Jani Nikula actuall=
y
> > > picked up on this (iirc shortly after committed), but the problem
> > > hadn't been seen yet in CI.  One patchset across 2 subsystems didn't
> > > help either.
> > >
> >
> > Could  you summarize classmaps from the beginning ?
> >
>
> IMO, the best thing about dynamic-debug is that it uses
> JUMP_LABELs / static-keys , so it is NOPs except when you want them.
>
> Classmaps 1st purpose is to bring that to DRM,
> which has 10 mutually exclusive categories of debug output,
> all controlled from bits in /sys/modules/drm/parameters/debug.
> w/o dyndbg, __drm_debug is constantly checked during normal ops.
>
> verbose/relative is added for the other kind of debug levels
>
> classes =3D=3D=3D categories, with name change to avoid muddling
> the 2 sides of the drm <=3D> dyndbg relation
>
> classmaps to contain the classes, and to not just take the "class" name,
> which is way too generic a term.
>
> Since dyndbg's sole input is the >control file, the "class" keyword was a=
dded.
> the PARAM support constructs queries using class foo to effect its change=
s.
>
>    # change classes by name
>    echo class DRM_UT_CORE +p > /proc/dynamic_debug/control
>    # this cant touch them
>    echo  +p > /proc/dynamic_debug/control
>
> this syntax extension allows dyndbg to honor DRM's privacy expectations
> DRM owns its categories via sysfs knob (only)
> and should not tolerate things changing out from under it.
> (your bank account isnt useful if everyone can withdraw from it)
>
> Also, the class'd pr-dbgs are only manipulable by their classname,
> not by their corresponding class_id : a 64 value space, which is
> shared across all classmaps in a module.
> IOW a module could have 8 separate classmaps, each with 8 classes.
>
> >
> > > So the revised classmap API "splits" it to def & ref:
> > >
> > > DYNDBG_CLASSMAP_DEFINE fixes & updates the busted macro, EXPORTing th=
e
> > > classmap instead.  It gets invoked once per subsystem, by the
> > > parent/builtin, drm.ko for DRM.
> > >
> > > DYNDBG_CLASSMAP_USE in drivers and helpers refer to the classmap by
> > > name, which links the 2 modules, (like a driver's dependency on exter=
n
> > > __drm_debug).
>
> Summarizing,
> author(s) _DEFINE their categories / classes,
> other author(s) _USE that definition.
>
> Both these tell dyndbg that it is allowed to manipulate those classnames
> in the invoking module.
>
> Does that fill the gaps in the explanation / motivation ?
>

Yes it does. Thank you for elaborating on the topic.

> thanks
> ~jimc

