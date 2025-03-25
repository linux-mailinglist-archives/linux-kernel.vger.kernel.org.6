Return-Path: <linux-kernel+bounces-575703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186DA705FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE7A7A6D86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F042571B1;
	Tue, 25 Mar 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmErkoOZ"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3F2561B8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918662; cv=none; b=UVU5rHKu+dsOPTdnZpz+f5LZ1ms1z8rZxULj1+FvuUVRrPfsqFgBDHgOk2sHntLRPdWGFnQ/SEEzSZciBPbyejQ9prsD4KG6E7/sLBJ6431kaQSmHykIBp5Gb0g47r0KM0ieeiZPaYNhun74r1HkAjegQZrkA/pOJvNxMV1vJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918662; c=relaxed/simple;
	bh=rCUZnLQ3PGHUDGtLBw8YYNv0Y3LVMYUzPgKKH0CMTmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlUY78VtmdXTzsdQZatmh8NDNwmT+QxVrQ+B0qeQnjE0LvFdGzBRgx2TlgTgfQsEbCdqZlYYEM4TldjChR6Da4eid9XcKndP0qV/5VDBfjsTJjE06WnFHnZZkDbdX8TcFlSrN7x+2wlBjSyO+pOH+D3Q0KLd2kdjtJDqJOpHwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmErkoOZ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ff1814102aso51741537b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742918659; x=1743523459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsymUyAwd/7+saRMvKt7vls4TQ6B6dvAPD1as5mOOSw=;
        b=MmErkoOZ48fPQDOKDvHzZ0wMc/z+uzU2aVXFeerZK9E0Srm1oeAXLS26/UXk0y7u+y
         9NG6q2A9BHuVpWeZ9rYwq3T+tidoLv4/r8wCtyBaW9ZbvgiLCoAkFNmPfd+cGQxBamUJ
         cGZpMwSPTNjCRbi4txWTQgbpN3CxPLDFpumEE4BXQLPnVIMgCR/zB5jlzEwUZ7WAPbbq
         fqmmJywBSOIodr2JM+BsaSph7/2Y8EyDl2Crq53HANZzBY3M1a2E3hTXsk99S+8j+gyd
         vzXB7E0lAQU5MhqU2hUO3f4OiXIKWaSva76EmaQUj+wlI0MTWJtd28NrzI3bWvHnwpRw
         U/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918659; x=1743523459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsymUyAwd/7+saRMvKt7vls4TQ6B6dvAPD1as5mOOSw=;
        b=C84sy0GgihdyHbM89vMPws7iSQw2h4TIbmAWUSuWgDvcYdFwIcKTZFhp9Q2kFgSYBe
         LDobWUb7VZ9aqkJR4IbsLkl7jkqxbLnQTvKV6tWRUoXQWF/tDeKH2kDBJk5wlF6w6FWp
         suYbvJ3g6qHJdXUv+bPWhAPAr/92tbgMJPbyp1jROS40Joii9Bv71QWZro1lHuTeMLUp
         UWawTtu4jMr4EB+iU37U6aQwNP5cKfXvSH0gCZIcDjz7Yn9w8gWJgxbQLIpxIdHOe+NQ
         tfvFSyFxLGUl7EqYWxfjiw2PNQAjceMWyyK01sDtYeTLdyrladyMOTCzTKiSqsEpkEC7
         tgeA==
X-Gm-Message-State: AOJu0YxeUVF0r30IudQD4fn67qAlqs93ogmE4iX50cLhOvL8nTu9pRl/
	XWbf+ORxLKnTXZhC+fgIqP+ucm10Mjgi52X3vLIj0SQMnlpqkChOUTzl45LrTEfi3R54MPvr7Qg
	2HP4ycHb7Jh5v03p7bbYBhZVKy8YZOTEh
X-Gm-Gg: ASbGncsKcO50SaNCZ7ltTBWXoTiAvUDWGg0K+KNnhMVn0CNbZMgBnm1A7+vjRk1eI4Z
	Tjkk6myjU5x6NJnSL+pKgJwyQlfw6LisNE9UpbviEs/S2aSUboLxN3NgekRTJBGzfKlZVMPhlmG
	3fOfEgY3CEhINLnd8I6RVTgg07
X-Google-Smtp-Source: AGHT+IFuO7/KsoWda68hHwMp3dp3vTaBY41RtEIHi5DSJzf7/I8Ad1hcWmGz5xn7HPqn5/pt2dj+MfILAPOJgzT4I1k=
X-Received: by 2002:a05:690c:8d02:b0:6fd:33a1:f4b with SMTP id
 00721157ae682-7020fd4fc2fmr5275767b3.4.1742918659083; Tue, 25 Mar 2025
 09:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <20250125064619.8305-17-jim.cromie@gmail.com>
 <b2d9acea-c2ad-45c7-9853-8fac0957c56f@bootlin.com> <CAJfuBxwBZ0a630YH2gbwz971ehZWASH6yXfRrdVCWBNGqA=mMw@mail.gmail.com>
 <a6824252-87be-458f-ba4a-b34bf86d67f4@bootlin.com>
In-Reply-To: <a6824252-87be-458f-ba4a-b34bf86d67f4@bootlin.com>
From: jim.cromie@gmail.com
Date: Tue, 25 Mar 2025 10:03:53 -0600
X-Gm-Features: AQ5f1JquBnQ-iGybb_4LD4MxqKJLiDkxofsnIfISZQzupn9eWPMArOPgVB9U_e4
Message-ID: <CAJfuBxw4BuVDh5+xdp5vunQt1=P-5AeSQHtRW16rU4SJLFgK8g@mail.gmail.com>
Subject: Re: [PATCH 16/63] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:07=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
trimming

> >>> +     __section("__dyndbg_class_users") _uname =3D {                 =
   \
> >>> +             .mod_name =3D KBUILD_MODNAME,                          =
   \
> >>> +             .map =3D &(_var),                                      =
   \
> >>> +     }
> >>> +
> >>
> >> I'm not sure I understand properly how __section works, but can we use
> >> multiple DYNDBG_CLASSMAP_USE in one module? Can we also use
> >> DYNDBG_CLASSMAP_DEFINE while also importing an other classmap
> >> DYNDBG_CLASSMAP_USE?
> >>
> >
> > Yes, its supposed to work that way.
> >
> > I havent tested that specific scenario (yet), but
> > a _USEr module, like test-dynamic-debug-submod,
> > could also _DEFINE its own, as long as it honors
> > the class-id mapping it is using and therefore sharing.
> > The on-modprobe conflict check should catch this condition.
> >
> > And __section (ISTM) accumulates entries, typically static struct var
> > initializations.
> > AFAICT, scanning the sections is how these { scoped statics } are
> > often reachable.
> >
> > For example, dd's _METADATA_ builds a { static _ddebug } for every pr_d=
ebug.
> > They all go into the __dyndbg section (renamed with _descriptors suffix=
 soon),
> > in the order their respective definer objects are linked.
> >
> > include/asm-generic/vmlinux.lds.h  then places the __dyndbg_* sections
> > into DATA, along with lots of other freight, for the various
> > mechanisms they serve.
> >
> >
> >
> >
> >> If not, does it make sense to allow it (for example MFD devices can
> >> touch multiple subsystems)?
> >
> > We have another use case !
> > Do you know your way around that case ?
> >
>
> No, I don't have other use cases, I was just thinking about possible
> scenarios of the "include multiple classmap".
>
> So, happy to konw it is not an issue with the section, but do I
> understand properly the code (completly hypotetical example): if drm.ko
> defines classes 0..10 and spi.ko defines classes 0..4, it means
> driver.ko can't use both classmap? (I don't have such use-case, and
> maybe this use-case does not exists!)
>

It sounds realistic on the face of it, so lets break it down:

1st off, drm drivers/helpers are full dependents on (core) drm.ko.
they are the "subsystem" users I considered.

This dependence is "+1" by _USE ref'g the exported DEFINE product.
If that dependence doesn't suit a situation, it doesn't quite fit.
The dependence dictates module-load order, amongst other things.

So it follows that spi.ko would never be a dependent module on drm.ko,
if there is a relationship, DRM would use spi, and whatever classes it defi=
nes.

Suppose spi.ko DEFINEd a classmap:  with ENDPOINT, TRANSPORT, BULK
categories of pr_debugs,  those classes would need to map to different clas=
s-ids
than DRM_UT_<*>, cuz the callsites only have the classids, not the
name-->id mapping.

if both DRM_UT_CORE and ENPOINT had class-id =3D 0,
then both these commands would alter the same set of pr-debugs

  echo class DRM_UT_CORE +p > /proc/dynamic-debug/control
  echo class SPI_ENDPOINT -p > /proc/dynamic-debug/control

Thats not as troublesome as it might seem:

DRM's DRM_UT_<*> vals are only exposed to userspace
by the existence of : /sys/module/drm/parameter/debug,
cuz it exposes the bit values in >debug input.

and this already changed DRM_UT_<*> vals wo anybody caring.
0406faf25fb1 drm_print: condense enum drm_debug_category

DYNAMIC-DEBUG-CLASSMAP-DEFINE() has _base arg,
which offsets the natural/obvious 0..N range to allow sharing of 0..62 rang=
e.

The outer edge of inconvenience in coordinating class-id reservations
would be N providers and M consumers. ATM, N=3DM=3D1.

Say DRM  used 2 modules defining classmaps:  spi (as discussed),
and (pure wag) gpu_engine.
Those 2 modules dont really have any other connection, but would have
to coordinate
(but maybe gpu_engine needs spi to control its cooling, and would want
to anyway)

DRM (or any classmap-definer/user) is also free to define a 2nd "category"
enum to separate the user facing aspects of DRM_UT_*
from its name->ID mapping (very internal)

Also:  "classnames" are a public-namespace; theres nothing
to stop a module from defining their own version of "DRM_UT_CORE",
and getting their pr_debugs enabled/disabled along with all of DRMs callsit=
es.

Such a use-case would be obvious in review, and would want some justificati=
on.

WAG:  a _base arg to the _USE() macro could specify a local user offset.

Theres a saying:  if youre explaining, youre losing.

How'd I do ?

> The only solution I see is to add more stuff in the _ddebug structure
> (for example a "classmap identifier"). But for now, the current user
> will be DRM, so we don't really need to fix this issue right now.
>
> I just found a possible user for dyndbg classes [1], it seems to
> implement something similar.
>
> [1]:https://elixir.bootlin.com/linux/v6.13.7/source/drivers/block/drbd/dr=
bd_polymorph_printk.h
>

thats a pretty impressive stack of macros.
I like the componentry and assembly

One thing that puts it out of scope is its use of KERN_EMERG, CRIT etc.
dyndbg is just KERN_DEBUG

Also those #undef *DYNAMIC_DEBUG*
explicitly unwire  dyndbg apparatus, and plug into __dynamic_pr_debug direc=
tly.
Making it an interesting case.


> > Note that DEFINEr  & USEr calls set up linkage dependencies,
> > As long as these are consistent with other module deps,
> > it should work.
> >
> >
> >>

