Return-Path: <linux-kernel+bounces-188612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E88CE454
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF561C216B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB385923;
	Fri, 24 May 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZQHEFkc"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E72CA5
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716547132; cv=none; b=T40BpQYgQi9IHPly6ZV8vCFrrLhd6XOe15bVdYB+x1nor+QxeTLBx1kdBd7K7mZqfey6KzzeBIMPux2jE+7urHTZCLoT9As1uj+RC7FD0fpO7EEnNvpbcRhfDFeAuIzUsU0pcsIwwTirUhsTNwGIp5myt2IhLkggtN5xgXbOfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716547132; c=relaxed/simple;
	bh=gKa6mmvzOF1ZpJO+bPGgziKndrJPW99i0DYrvhPmWHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3r1MXPf5Ur3evM0b3euxQBUITntNKX/bBFQVBXx44zA2UI/Z0Q8GJ8N8Hs1G8QApBSsscTuqb4Nif1DKblRrbZxfcXmVeQufVB+TAG5naBgNZKmLzxNprcPIkUnioAwL6zOvMDOioszLr6eYGWgfnUkrCC6qVDsMdxUcluBwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WZQHEFkc; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso59455561fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716547128; x=1717151928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7QJ4Br1wGtDprLMS8vBRq5ATk0CW/YgMrLCILR8mwU=;
        b=WZQHEFkcclDZ1fkgfSSO4f59VEZbGu7MYUspgtG0PC0ThlD/wSHbkx1k576sAWSgeM
         GaJZBHI2ePdGICLk0shgrn84Okr4/AmvxIWQaeljGEAfGwAQab1CfhT7L2zQGhS1kelU
         qm51HWVACdrNFwzdVbAIHoCbCjy7NQYMTAMvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716547128; x=1717151928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7QJ4Br1wGtDprLMS8vBRq5ATk0CW/YgMrLCILR8mwU=;
        b=KAJTCUu74xCYMTaREd97oWUK13ZiSIUCt/SWPJHVgFlPsv2MdkQV1eSZKF6Gl6dxGw
         vYqZ5ymFVzL7e5YxYugQUFZ2qxR7DS1VSnDxD6I8NJ9WSU8PNlwApDWNZumJlZDiEpIB
         0yERR5c1yaN/m8SXNsnNsPFkLOYPS7Ga4XBAF6WV1mOg55WqwyLgUrLb3Jy9D6UhjlOr
         3CZwcl4s6yzXcM65J7vzL1ifGvra+TCzM/MgyiyEG9jB1i49NrdEIiww+XsN4yrN297R
         tlrYDJCWJoxKr074yysK9Vxk+d1+dE938L2tGNKMuarbjNGDRrRK/igQarWkCeTcyMKu
         Ld3A==
X-Forwarded-Encrypted: i=1; AJvYcCXmZD3t8F3OWoqUT4D2qw/PMuB+t1TOhiKpM8WtWUUObdPi4dAwVUo/RJbjoSSj+JWcwuL0oo6MssZzGIXA6q7xdYJ1bNWTeTcihedy
X-Gm-Message-State: AOJu0YwPn8z+L+od48sByaQZyYxY6ZEyzOJnOsUJoXzYU3R9kt3mvgta
	karLiM7cr0ymdXx+kSZzPBLm3y/IrTW5NDgPOaBMjpQudppcDSIUiAmJa4EkoQ7IuPw/eD/CMH7
	01tNp0SuInTFhZ1sBVbVi+JT47cW472xjals=
X-Google-Smtp-Source: AGHT+IEKCqXlR3VFq4PuZL729CIHR+NXOv7en8ECSeBpEO61zPsCJiDAOi/Nenxh9tUH5OtaGhXb+HKe2JSOzy9OfNw=
X-Received: by 2002:a05:6512:4024:b0:51d:a5fb:bfd8 with SMTP id
 2adb3069b0e04-52965b3a029mr1988848e87.32.1716547128267; Fri, 24 May 2024
 03:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-16-jim.cromie@gmail.com>
 <CALwA+NYXBgennLhnFUvaU+U871hoiQbjNK2uRaPEd6fxPr68Jg@mail.gmail.com>
 <CAJfuBxzNKvFGB3AyJyPRDALkZ9nNYvG33u6yZ4OWEbmNypotQg@mail.gmail.com> <CAJfuBxzJqgnwy1m9f-a7+Ke-g13mwQoA9NrPFAZU_Ems_fMPiw@mail.gmail.com>
In-Reply-To: <CAJfuBxzJqgnwy1m9f-a7+Ke-g13mwQoA9NrPFAZU_Ems_fMPiw@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Fri, 24 May 2024 12:38:36 +0200
Message-ID: <CALwA+Na1rg2S0Nh_AtpLWSC6m6pCAZZG=FUo727_jdj8fO__Mw@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 15/33] dyndbg-API: fix DECLARE_DYNDBG_CLASSMAP
To: jim.cromie@gmail.com
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 8:52=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Tue, May 21, 2024 at 10:31=E2=80=AFAM <jim.cromie@gmail.com> wrote:
> >
> > On Tue, May 21, 2024 at 5:46=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@ch=
romium.org> wrote:
> > >
> > > On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.=
com> wrote:
> > > >
> > > > DECLARE_DYNDBG_CLASSMAP() has a design error; its usage fails a bas=
ic
> > > > K&R rule: "define once, refer many times".
> > > >
> > > > It is used across DRM core & drivers, each use re-defines the class=
map
> > > > understood by that module; and all must match for the modules to
> > > > respond together when DRM.debug categories are enabled.  This is
> > > > brittle; a maintenance foot-gun.
> > > >
> > > > Worse, it causes the CONFIG_DRM_USE_DYNAMIC_DEBUG=3DY regression; 1=
st
> > > > drm.ko loads, and dyndbg initializes its DRM.debug callsites, then =
a
> > > > drm-driver loads, but too late - it missed the DRM.debug enablement=
.
> > > >
> > > > So replace it with 2 macros:
> > > >   DYNDBG_CLASSMAP_DEFINE - invoked once from core - drm.ko
> > > >   DYNDBG_CLASSMAP_USE    - from all drm drivers and helpers.
> >
> > >
> > > Why does DYNDBG_CLASSMAP_DEFINE take "stringified" enum name-vals ?
> > >
> >
> > short version:
> >
> > real enum vals would be better - misspellings would be compiler errors
> > but doing the stringification inside the macro doesnt work,
> >  __stringify(__VA__ARGS__) produces "DRM_UT_CORE, DRM_UT_DRIVER" etc,
> > not 10 separate stringifications
> >
> > I have a patchset for later that fixes this,
> > but I didnt want to complicate this submission any further.
> > Its already touching 2 sub-systems, revising and adding API
> >
> >
> > > > -         This module registers a tracer callback to count enabled
> > > > -         pr_debugs in a 'do_debugging' function, then alters their
> > > > -         enablements, calls the function, and compares counts.
> > > > +         This module exersizes/demonstrates dyndbg's classmap API,=
 by
> > >
> > > Typo exersizes -> exercises
> > >
> >
> > yes
> >
> > > > +static void ddebug_apply_params(const struct ddebug_class_map *cm,=
 const char *modnm)
> > > > +{
> > > > +       const struct kernel_param *kp;
> > > > +#if IS_ENABLED(CONFIG_MODULES)
> > >
> > > Instead of the above maybe use "if (IS_ENABLED(CONFIG_MODULES)) {" ?
> > > This will allow to get rid of #if and #endif which make code less rea=
dable.
> > >
> >
> > will do.
> >
> > > > +       int i;
> > > > +
>
> meh, turns out the #ifdef was doing more work - hiding the use of
> struct module in the expression.
> and since the cm->mod->kp actually refers thru the struct, it must be def=
ined,
> a forward decl looks insufficient
>
>
> >> lib/dynamic_debug.c:1202:28: error: incomplete definition of type 'str=
uct module'
>     1202 |                         for (i =3D 0, kp =3D cm->mod->kp; i <
> cm->mod->num_kp; i++, kp++)
>          |                                          ~~~~~~~^
>    arch/x86/include/asm/alternative.h:108:8: note: forward declaration
> of 'struct module'
>      108 | struct module;
>          |        ^
> [jimc:dd-classmap-fix-8d 15/36] lib/dynamic_debug.c:1202:28: error:
> incomplete definition of type 'struct module'
>
>
> I'll probably revert, and stick with the #if block,
> anything else feels too subtle by half

Ah, you're right, without CONFIG_MODULES the compilation fails.
Reverting to #if statement sounds good to me then.

