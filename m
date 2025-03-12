Return-Path: <linux-kernel+bounces-558108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E265A5E1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C289A3A8F61
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6861D5174;
	Wed, 12 Mar 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoUfWJTF"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A71BB6BA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796819; cv=none; b=QnwJCPZu6wfQK+IWQC7XwLuHoYJa10TyegM42Z3ApRBRrkv6321WVUy6kzpjdm97hEAO2uBUwFypVKexFgBxTAOjpFBYDuSIj3yeHGpcgVChYlDqmk12jywayVE3jwN7/Tl+ia9onOW/ylJPlfmIoOzndU+y3pe83JXy8KwUmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796819; c=relaxed/simple;
	bh=kRRp21av8Hh7pPKct98IzIhEEgOiPz+57LivNHj+CvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmIaXUGQ1Fr1dCXgdnd+3R0H9d5Y/668/LnlnR7fViY7WtWqKLynUkuc2uwrpYWeO9zc2VmaH0nMEgYj1ZEqMLwz7/vvuBfxFQnO2n1jMmOBUIqkGVf59F+irZ/fcmq5d7Hn0Od4kAtP9SzK+rft90chU/uQRh6cxI5SzxjdmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoUfWJTF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f679788fd1so53044147b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741796817; x=1742401617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtbMoxoY+0r+dGRFaJbObtRqRCRzGoMTxZlGjKoABT8=;
        b=IoUfWJTFOG/iaCn8XzfY3FY5xavK8SrtkolV+FCd55H4CRfW2iL1AHSMEGv3el/QG/
         MsvIyKG6I/YOvVx3QZRqq7pkyylVrcWJuqSyXT8vJIaIO7YIj9HSXDfuOWcf6Kad3QIh
         /VDfFZYoJEF+XseVWA9AY05G7VgGeQqVXmo8NOgRj4a+TjdHOjb3x58cjFoYggbtK2Jz
         MnyhrhfLoth/D28DF1ig2PMQQBIMC5SqPtin7UCzx+Pv9vkue6Ov6jmWEuK0nybUhLHB
         z6uAydUMBMe4VwXMEMgcK2il90vJ2GFDQAwBu57nEwt3+eaDJx2XX0MmH1/k37TRayBG
         JjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796817; x=1742401617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtbMoxoY+0r+dGRFaJbObtRqRCRzGoMTxZlGjKoABT8=;
        b=pkJVldHpUQw/Al26jkoF7YwRGoNELjpjOV/+kdKRVxUQVXpQ+pWAPOqgGyaX/l1lFb
         nt/3nnC4pJ5wDVY/4bn3oRBCdcrCNnmz9lQnOBB4xJW84jHon8GwlQobNkJTaceb1cuU
         OZFQeSk5ro5XB5+ryTjqDqDV0brRwuqAx4HT9FLVI5hvUV5MjFLAcqaUWtOv9aixgpqP
         FA21uTvlhtJAjJa5lvys8BV/6aBBswRAynctp4knDe9VlmezonIHPRzN0aSFM7JDq91h
         Df5gYHbPKqbht7tKfRM+/aHoyYH6lqVDJuDRpCJdUjiPaGYuhyRsC4+4NURy9anQB52P
         6WvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkM6QBRJSmrc2Hbu8Qp1JIm0cQACjn1bUu5lAy7DpWCctb0B3ZswKAHhdi4WUHJE1LV+SsA5Ybhm5Pt/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKq3xJ/g51RYkF3mm/fbU3OXWPjWey64y3mxTyYjnQiiAk7gx
	vhq6TIpneKUS8ULGcM4GXkU5tJgAiJh0Zya0cGgxpbK2APhNLyYKute711vMKvLi1rh6B/DSpu9
	Gy6Qou1mw93T6u9zidEE7zAkeWKSRBw==
X-Gm-Gg: ASbGncudDhKof9nolbyLWXFkQtV07HB13k9OAOmXK5Acb0p1IxnBCwxVzRCF3lvRTbK
	DJE6Anw0X4a3LeWA6G8epHyykCT3M13Gh/UHWtfMxQI9KFeE0O3E7QhODoEIQ1ZfSgZwT+gzJu8
	K9h83OrVKzxrTdcIEvNCsJt2Zv
X-Google-Smtp-Source: AGHT+IGwIilqLIs/47ywUA0mPYyex6iczz3P9omqm4iVSKnzzFj5OIFe77lwOuSPi2ImR4Qb3aQ4cT3QgKXQHZMGiKI=
X-Received: by 2002:a05:690c:3708:b0:6f9:b0a6:6a15 with SMTP id
 00721157ae682-6ff09293b84mr115686997b3.38.1741796816745; Wed, 12 Mar 2025
 09:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <2025022012-viscous-cringing-bf88@gregkh>
 <Z7b50rGRA4RuybgC@phenom.ffwll.local> <caba927a-b71b-40bf-96b6-d15418ed705a@bootlin.com>
In-Reply-To: <caba927a-b71b-40bf-96b6-d15418ed705a@bootlin.com>
From: jim.cromie@gmail.com
Date: Wed, 12 Mar 2025 10:26:30 -0600
X-Gm-Features: AQ5f1JqGa1v3EYAxZlTMvkfJud0RHhUAoGaupEFx5s7t6c1Ynr_sb_DXNN9AMWQ
Message-ID: <CAJfuBxwmFETyYZ4_sy92TtZr2a+CbjhGKidGU91uL5XiJy5cOQ@mail.gmail.com>
Subject: Re: [PATCH 00/63] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	jbaron@akamai.com, ukaszb@chromium.org, 
	intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello everyone,

sorry for the late reply.  I have a cleaner version cooking now.
less inter-commit churn, by bringing more cleanups forward.

I'll send a -v2 soon.  (lets forget all the meandering crap versions I sent=
)

Louis, thanks for testing !!!!!

I wrote the test script and submod.ko so the lib/* parts would stand
by themselves.
And this time, I left the old DECLARE_ macro, so DRM doesnt get a
flag-day breakage :-)

But for ease of testing, I'll keep the DRM parts in the series.
Taking 1st N commits is normal workflow ?

On Fri, Feb 28, 2025 at 9:24=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 20/02/2025 =C3=A0 10:45, Simona Vetter a =C3=A9crit :
> > On Thu, Feb 20, 2025 at 09:31:41AM +0100, Greg KH wrote:
> >> On Fri, Jan 24, 2025 at 11:45:14PM -0700, Jim Cromie wrote:
> >>> This series fixes dynamic-debug's support for DRM debug-categories.
> >>> Classmaps-v1 evaded full review, and got committed in 2 chunks:
> >>>
> >>>    b7b4eebdba7b..6ea3bf466ac6       # core dyndbg changes
> >>>    0406faf25fb1..ee7d633f2dfb       # drm adoption
> >>>
> >>> DRM-CI found a regression during init with drm.debug=3D<initval>; the
> >>> static-keys under the drm-dbgs in drm.ko got enabled, but those in
> >>> drivers & helpers did not.
> >>>
> >>> Root Problem:
> >>>
> >>> DECLARE_DYNDBG_CLASSMAP violated a K&R rule "define once, refer
> >>> afterwards".  Replace it with DYNDBG_CLASSMAP_DEFINE (invoked once in
> >>> drm-core) and DYNDBG_CLASSMAP_USE (invoked repeatedly, in drivers &
> >>> helpers).
> >>>
> >>> _DEFINE exports the classmap it creates (in drm.ko), other modules
> >>> _USE the classmap.  The _USE adds a record ref'g the _DEFINEd (&
> >>> exported) classmap, in a 2nd __dyndbg_class_users section.
> >>>
> >>> So now at modprobe, dyndbg scans the new section after the 1st
> >>> __dyndbg_class_maps section, follows the linkage to the _DEFINEr
> >>> module, finds the (optional) kernel-param controlling the classmap,
> >>> examines its drm.debug=3D<initval>, and applies it to the module bein=
g
> >>> initialized.
> >>>
> >>> To recapitulate the multi-module problem wo DRM involvement, Add:
> >>>
> >>> A. tools/testing/selftests/dynamic_debug/*
> >>>
> >>> This alters pr_debugs in the test-modules, counts the results and
> >>> checks them against expectations.  It uses this formula to test most
> >>> of the control grammar, including the new class keyword.
> >>>
> >>> B. test_dynamic_debug_submod.ko
> >>>
> >>> This alters the test-module to build both parent & _submod ko's, with
> >>> _DEFINE and _USE inside #if/#else blocks.  This recap's DRM's 2 modul=
e
> >>> failure scenario, allowing A to exersize several cases.
> >>>
> >>> The #if/#else puts the 2 macro uses together for clarity, and gives
> >>> the 2 modules identical sets of debugs.
> >>>
> >>> Recent DRM-CI tests are here:
> >>>    https://patchwork.freedesktop.org/series/139147/
> >>>
> >>> Previous rev:
> >>>    https://lore.kernel.org/lkml/20240716185806.1572048-1-jim.cromie@g=
mail.com/
> >>>
> >>> Noteworthy Additions:
> >>>
> >>> 1- drop class "protection" special case, per JBaron's preference.
> >>>     only current use is marked BROKEN so nobody to affect.
> >>>     now framed as policy-choice:
> >>>     #define ddebug_client_module_protects_classes() false
> >>>     subsystems wanting protection can change this.
> >>>
> >>> 2- compile-time arg-tests in DYNDBG_CLASSMAP_DEFINE
> >>>     implement several required constraints, and fail obviously.
> >>>
> >>> 3- modprobe time check of conflicting class-id reservations
> >>>     only affects 2+classmaps users.
> >>>     compile-time solution not apparent.
> >>>
> >>> 4- dyndbg can now cause modprobe to fail.
> >>>     needed to catch 3.
> >>>     maybe some loose ends here on failure.
> >>>
> >>> 5- refactor & rename ddebug_attach_*module_classes
> >>>     reduce repetetive boilerplate on 2 types: maps, users.
> >>>     rework mostly brought forward in patchset to reduce churn
> >>>     TBD: maybe squash more.
> >>>
> >>> Several recent trybot submissions (against drm-tip) have been passing
> >>> CI.BAT, and failing one or few CI.IGT tests randomly; re-tests do not
> >>> reliably repeat the failures.
> >>>
> >>> its also at github.com:jimc/linux.git
> >>>    dd-fix-9[st]-ontip  &  dd-fix-9-13
> >>>
> >>> Ive been running it on my desktop w/o issues.
> >>>
> >>> The drivers/gpu/drm patches are RFC, I think there might be a single
> >>> place to call DRM_CLASSMAP_USE(drm_dedbug_classes) to replace the
> >>> sprinkling of _USEs in drivers and helpers.  IIRC, I tried adding a
> >>> _DEFINE into drm_drv.c, that didn't do it, so I punted for now.
> >>>
> >>> I think the dyndbg core additions are ready for review and merging
> >>> into a (next-next) test/integration tree.
> >>
> >> So whose tree should this go through?
> >
> > I'm trying to get some drm folks to review/test this, but thus far not
> > much success :-/ I think it's good stuff, but I'm somewhat hesitant if =
no
>
> I tested the VKMS driver with this, and it works!
>
> Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
>
> > one else agrees that it's useful for CI or in-field crash-recording or
> > whatever ...
> >
> > I guess worst case we can land it and hope it attracts more folks?
> >
> > Wrt tree I don't care, but I guess we should then also land the drm sid=
e
> > too.
> > -Sima
> >
> >> And I think the last patch in this series isn't correct, it looks like=
 a
> >> 000 email somehow.
> >>
> >> thanks,
> >>
> >> greg k-h
> >
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

