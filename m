Return-Path: <linux-kernel+bounces-185369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C48CB412
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608E4B24DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B538F14901F;
	Tue, 21 May 2024 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeQOiUNq"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F477105
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318667; cv=none; b=XubkOwYk4djvpr3s75wbjCQUzB6rCjar3NE3zDks5gRKFOYR9nafQ7TynAQ7ZxEmxnDJJN+Yzy0WOmyQ55G8utfr2Sr204KeqRcIpoo3ccgNj3U15cWXfbnKBL7/yX8yWQ+qYdu/QgOG8QEEFTPoe0hAIC+gdy8Cz4Vb2Ik4Zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318667; c=relaxed/simple;
	bh=xWfgrcgmOZhioBs/IUfsh1fFepvx2tn46PZFWTtxGLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrgLA5vUtb2mU6LqScnpfjjsVyXuIyAuaDV56KmMMWXa7r4j8yXXJGZ7CFAsj7wqoYGvR1Do93LjL57IcCOKL0CT6yn901gmWB9noHwGHlKyZzOMBtVAr0lHeTdLE8ujacm2t9NRiNlAjI2XQEtS5Ac52TG7W5+Xvdr/ESz3P4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeQOiUNq; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-47efc7f2625so2311137.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716318665; x=1716923465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjC3cgCgjMQ8RVd2VGQzPmHkojsxJXj44Zp6bGH8ggU=;
        b=TeQOiUNqx5UQ9EdTb2ETbJoBGENWlRzLcW8tR6k3cGVix9xkZOUdqWqA8S2s39C7T/
         +RBWjIDyfTPqrQv8jgmbcgWHnnqm1a8iQzecIXROhYT03uimoNXWObYyDf6SDaLYD8fc
         inLo9O4P/ISJsmJErNqbaBVS74swgpN92XqFq4MNQ3VQmJ7/+GDFb0T4yBUiKk2SONKe
         cobYl6G/OGkJ7GlJ5xagSSDpuu4DcaAoG08+ORczbMwi0ZguXV8Q9FRJN0TilU4Su1is
         URPF9PHQcs1cdGLf49Zix8scX1Ya4u3fVnOpHZmAzUaUdRk1C5aFr0qZsmOJ7dFFyejD
         oDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318665; x=1716923465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjC3cgCgjMQ8RVd2VGQzPmHkojsxJXj44Zp6bGH8ggU=;
        b=eNUdHEIZiQBZ5eHX3uoXV3hlDkTCV0vUUpjjo7aM8h8SfN5JuREOkwSbteOeeQ9eap
         HTYhqSxkOaSTzNswYxe19Nl9iOOIordXGhdfSEOfkLvFI7qtI40ZK5WEmpOPaGD1l8lc
         1puWqPVTT3o24Grre4lwPrAzGOz+y2hST7ZtJwC6J4W8OKJzNfcgoMW+54TtRtL7qfri
         t0T/D5UNHr2UuxFKY6ive/hKcO3tVe4R/7Lm+PtibancQdypuA+Rm+I0p5VnvOTmXl1p
         C6cpzvK14cJWvec7jiAXoheZaG/rSWndiyXDWpnOQ/AJEzMsAgRDJP6fD1F/5z8rS21l
         UlSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjsYFjdIRiSfMsu0SNMDW+WY++ldVQt/FcG4W5BaT9T5lMT69kvKUFsSAncWE15zj/3AUdss+Aa5Vi586rJDbH0uVs1IPI8/vhEfeA
X-Gm-Message-State: AOJu0YwOZDERY53HDWYa1Llgj8TCU0cYFfv5QzP6yruUzwCbyo1KY9w+
	M21uPDAdko956m3nwL70V39YLUqP7RZnFavgQd36V8bl2aErH3aLNPDFsc+G2NbvzB9WYiL2bhZ
	TP0hGqxEjkV2+Zzd0z2DKsvJ4qBE=
X-Google-Smtp-Source: AGHT+IE97Ol4ddgWVV/tgnRy3ShYUEiP/WPZDeALi3tSZIloQJ+PIeQeeWEEgIXUjRh7kKrUaUEMSawMaHzS79UYEyE=
X-Received: by 2002:a05:6102:38c8:b0:47e:effb:f740 with SMTP id
 ada2fe7eead31-48077dccadamr36338590137.7.1716318665053; Tue, 21 May 2024
 12:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <CALwA+NZxiapXe-BBY6CvpqT-Z1h_YyMQr=JBwybY55TWtDNiBA@mail.gmail.com>
In-Reply-To: <CALwA+NZxiapXe-BBY6CvpqT-Z1h_YyMQr=JBwybY55TWtDNiBA@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 21 May 2024 13:10:38 -0600
Message-ID: <CAJfuBxw3oDbdAwporJw0DXGRbpLqVXxGaBQmOra4vMGDzH94jA@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 00/33] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y regression
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:41=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chromi=
um.org> wrote:
>
> On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com>=
 wrote:
> >
> > hi Greg, Jason,
> >
> > This patchset fixes the CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy regression,
> > Fixes: bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
> >
> > Im calling it v8, to keep consistent with previous labels.
> > v6 was what got committed, back in 9/2022.
> > v7 had at least 2 problems that blocked its submission:
> >
> >  https://lore.kernel.org/lkml/20231101002609.3533731-1-jim.cromie@gmail=
com/
> >  https://patchwork.freedesktop.org/series/125066/
> >
> > 1. missing __align(8) in METATDATA macro, giving too much placement
> > freedom to linker, caused weird segvs following non-ptr vals, but for
> > builtin modules only. found by lkp-test.
> >
> > 2. the main patch touched 2 subsystems at once, which would require
> > special handling.
> >
> > What was broken about DYNAMIC_DEBUG ?
> >
> > Booting a modular kernel with drm.debug=3D0x1ff enabled pr_debugs only
> > in drm itself, not in the yet-to-be loaded driver + helpers.  Once
> > loaded, the driver's pr_debugs are properly enabled by:
> >
> >    echo 0x1ff > /sys/module/drm/parameters/debug  # still worked
> >
> > I had tested with scripts doing lots of modprobes with various
> > permutations of dyndbg=3D<> option, and I missed that I didn't test
> > without them.
> >
> > The deeper cause was my design error, a violation of the K&R rule:
> > "define once, refer many times".
> >
> > DECLARE_DYNDBG_CLASSMAP defined the classmap, and was used everywhere,
> > re-declaring the same static classmap repeatedly. Jani Nikula actually
> > picked up on this (iirc shortly after committed), but the problem
> > hadn't been seen yet in CI.  One patchset across 2 subsystems didn't
> > help either.
> >
>
> Could  you summarize classmaps from the beginning ?
>

IMO, the best thing about dynamic-debug is that it uses
JUMP_LABELs / static-keys , so it is NOPs except when you want them.

Classmaps 1st purpose is to bring that to DRM,
which has 10 mutually exclusive categories of debug output,
all controlled from bits in /sys/modules/drm/parameters/debug.
w/o dyndbg, __drm_debug is constantly checked during normal ops.

verbose/relative is added for the other kind of debug levels

classes =3D=3D=3D categories, with name change to avoid muddling
the 2 sides of the drm <=3D> dyndbg relation

classmaps to contain the classes, and to not just take the "class" name,
which is way too generic a term.

Since dyndbg's sole input is the >control file, the "class" keyword was add=
ed.
the PARAM support constructs queries using class foo to effect its changes.

   # change classes by name
   echo class DRM_UT_CORE +p > /proc/dynamic_debug/control
   # this cant touch them
   echo  +p > /proc/dynamic_debug/control

this syntax extension allows dyndbg to honor DRM's privacy expectations
DRM owns its categories via sysfs knob (only)
and should not tolerate things changing out from under it.
(your bank account isnt useful if everyone can withdraw from it)

Also, the class'd pr-dbgs are only manipulable by their classname,
not by their corresponding class_id : a 64 value space, which is
shared across all classmaps in a module.
IOW a module could have 8 separate classmaps, each with 8 classes.

>
> > So the revised classmap API "splits" it to def & ref:
> >
> > DYNDBG_CLASSMAP_DEFINE fixes & updates the busted macro, EXPORTing the
> > classmap instead.  It gets invoked once per subsystem, by the
> > parent/builtin, drm.ko for DRM.
> >
> > DYNDBG_CLASSMAP_USE in drivers and helpers refer to the classmap by
> > name, which links the 2 modules, (like a driver's dependency on extern
> > __drm_debug).

Summarizing,
author(s) _DEFINE their categories / classes,
other author(s) _USE that definition.

Both these tell dyndbg that it is allowed to manipulate those classnames
in the invoking module.

Does that fill the gaps in the explanation / motivation ?

thanks
~jimc

