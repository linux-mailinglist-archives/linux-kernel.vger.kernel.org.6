Return-Path: <linux-kernel+bounces-186626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C48CC691
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD10282CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C756145B2F;
	Wed, 22 May 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCKokZlL"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D823CB
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403950; cv=none; b=K8V7WL5UR7fdbqQQ6LYs6babPI6Ed6Oqf7k2BnwvR9XDTiywzl69RqrSrzvQfQKUVfeDCp56KYAH6lGnQ54fPGV14NStvRw5/h5wFedSHIFEOw1ixnCExmX+MwrvF2sGxeUUBZWckT/xSUwIQpkLAjpjfR9LULtzmShJCAhDzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403950; c=relaxed/simple;
	bh=shm1dhC8Fyb4N2X20Owe1g2clV/Gh8Tk6up6B/kfE1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtxnUUR0Lh/FwC6PW8VTVvocvZV88n/8odJ5VyINgQAO+flFRTjCceFwp/yQ/FGQhobxASBID0eilwZWRkTBpIc51EUkNYods5XpXSmk1TwFmF0Umgt4o92TlpVFKxxs+1udblebv3pKM2sNixIIBR1Xi/8uj/9x/gQHM/SnerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCKokZlL; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47eff9b3c23so400597137.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716403948; x=1717008748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUWpivSzxaIrixDkj6aA8gHoz3/kBRnCazuu8dkm+LM=;
        b=aCKokZlLllquLXHkW/lyxQD8K0gQjYVhSMzW7LnP3xuU7JoW4SPWHad2Xtb9rbMUei
         /IZ3BFtiP56WFLnH8++trbkv3Vc1djikoEYXitlp5cYZji4omoKad5G4ik58y27cHztz
         DN14sKYTkcQZNNpIbLCXYssZp0GXnJ1isHH0rsJ4HRA7PspllPbAeJfsrj27sj7xeD82
         heB5GCUTIP+g9bOrpJrdKdHBX1H/SG7ptnNN5BXuxwFFdB8kK3YMwJwE7U2jWuKR7emG
         p+G4MYZsTjaHvMIz62wqH0XoBRTs3rMJFb9wYOwH19Gy8cRf5eQ8o8lLVChiiBPX06yf
         s0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716403948; x=1717008748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUWpivSzxaIrixDkj6aA8gHoz3/kBRnCazuu8dkm+LM=;
        b=cNpxfZeCu/6ckncuFJ50392hVfbXOTZhae/oVU5Qa5l4+IUJVE94qEL8kRCzskjj2S
         doedOzxI/u2JSaxUxTJiEjOfJ9vL0FJ1uaYuHl+BGWSQkblNbxk4WCq40aiOHtIAuoYU
         e7uk21NgYbrAJv+KgjJhwXigM3AuWmYG22lUFraQIKqTd77vXdctt7ArVq/AgDdIY23y
         pRI5HAo1/AWbOyzKzoM2B3rHHGpcdWEFNJwhqQbuveNfUz5Y0kmtrBclgYgW7vHWnyun
         yEY/Fq4Yf+yGi9pU2d/Q9h+hd2uX0YpJXp7Fevp6DBNFD7sKNcvhLUV+XyWrPyA9K/jN
         YdXg==
X-Forwarded-Encrypted: i=1; AJvYcCVFi3kW3VTqxL8691b2flNyCrE+fpzhJ0HrtBdBj/mkiAqp6kzMECGs4B96gEXTDLDvgXU6xjrZn67FO98giz9cspCg8EbjBN52cKli
X-Gm-Message-State: AOJu0YwEoXBPWQ57+XqZ3pCXaVs/L7vdxRfqSgP1m+wp3gdjIKVg0skw
	J61wVsZttqMGvSlsQuH3PMoVO8Iv7YT0o7/MtMZh7NDGqjPWG7zNaFOBgncF10mjTArCxq075I1
	oJFqxSYZz8rg9jUbGRp7TJaaatM0=
X-Google-Smtp-Source: AGHT+IE50w7qd8A7GwCCz9lPIK7nECopfHdQo+GKgDHc+pswVSnRKcUDgoj6fnqf6XxdPAnRhhpLcBsdYMLz/WPaZbo=
X-Received: by 2002:a05:6102:6c3:b0:480:6c41:220b with SMTP id
 ada2fe7eead31-4890096d879mr3427415137.1.1716403948262; Wed, 22 May 2024
 11:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-16-jim.cromie@gmail.com>
 <CALwA+NYXBgennLhnFUvaU+U871hoiQbjNK2uRaPEd6fxPr68Jg@mail.gmail.com> <CAJfuBxzNKvFGB3AyJyPRDALkZ9nNYvG33u6yZ4OWEbmNypotQg@mail.gmail.com>
In-Reply-To: <CAJfuBxzNKvFGB3AyJyPRDALkZ9nNYvG33u6yZ4OWEbmNypotQg@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Wed, 22 May 2024 12:52:01 -0600
Message-ID: <CAJfuBxzJqgnwy1m9f-a7+Ke-g13mwQoA9NrPFAZU_Ems_fMPiw@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 15/33] dyndbg-API: fix DECLARE_DYNDBG_CLASSMAP
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:31=E2=80=AFAM <jim.cromie@gmail.com> wrote:
>
> On Tue, May 21, 2024 at 5:46=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chro=
mium.org> wrote:
> >
> > On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.co=
m> wrote:
> > >
> > > DECLARE_DYNDBG_CLASSMAP() has a design error; its usage fails a basic
> > > K&R rule: "define once, refer many times".
> > >
> > > It is used across DRM core & drivers, each use re-defines the classma=
p
> > > understood by that module; and all must match for the modules to
> > > respond together when DRM.debug categories are enabled.  This is
> > > brittle; a maintenance foot-gun.
> > >
> > > Worse, it causes the CONFIG_DRM_USE_DYNAMIC_DEBUG=3DY regression; 1st
> > > drm.ko loads, and dyndbg initializes its DRM.debug callsites, then a
> > > drm-driver loads, but too late - it missed the DRM.debug enablement.
> > >
> > > So replace it with 2 macros:
> > >   DYNDBG_CLASSMAP_DEFINE - invoked once from core - drm.ko
> > >   DYNDBG_CLASSMAP_USE    - from all drm drivers and helpers.
>
> >
> > Why does DYNDBG_CLASSMAP_DEFINE take "stringified" enum name-vals ?
> >
>
> short version:
>
> real enum vals would be better - misspellings would be compiler errors
> but doing the stringification inside the macro doesnt work,
>  __stringify(__VA__ARGS__) produces "DRM_UT_CORE, DRM_UT_DRIVER" etc,
> not 10 separate stringifications
>
> I have a patchset for later that fixes this,
> but I didnt want to complicate this submission any further.
> Its already touching 2 sub-systems, revising and adding API
>
>
> > > -         This module registers a tracer callback to count enabled
> > > -         pr_debugs in a 'do_debugging' function, then alters their
> > > -         enablements, calls the function, and compares counts.
> > > +         This module exersizes/demonstrates dyndbg's classmap API, b=
y
> >
> > Typo exersizes -> exercises
> >
>
> yes
>
> > > +static void ddebug_apply_params(const struct ddebug_class_map *cm, c=
onst char *modnm)
> > > +{
> > > +       const struct kernel_param *kp;
> > > +#if IS_ENABLED(CONFIG_MODULES)
> >
> > Instead of the above maybe use "if (IS_ENABLED(CONFIG_MODULES)) {" ?
> > This will allow to get rid of #if and #endif which make code less reada=
ble.
> >
>
> will do.
>
> > > +       int i;
> > > +

meh, turns out the #ifdef was doing more work - hiding the use of
struct module in the expression.
and since the cm->mod->kp actually refers thru the struct, it must be defin=
ed,
a forward decl looks insufficient


>> lib/dynamic_debug.c:1202:28: error: incomplete definition of type 'struc=
t module'
    1202 |                         for (i =3D 0, kp =3D cm->mod->kp; i <
cm->mod->num_kp; i++, kp++)
         |                                          ~~~~~~~^
   arch/x86/include/asm/alternative.h:108:8: note: forward declaration
of 'struct module'
     108 | struct module;
         |        ^
[jimc:dd-classmap-fix-8d 15/36] lib/dynamic_debug.c:1202:28: error:
incomplete definition of type 'struct module'


I'll probably revert, and stick with the #if block,
anything else feels too subtle by half

