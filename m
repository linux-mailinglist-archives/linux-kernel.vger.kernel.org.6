Return-Path: <linux-kernel+bounces-250868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B692FDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD651F22231
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3371741EF;
	Fri, 12 Jul 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OzouaXA5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3087171E53
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799061; cv=none; b=V/mISmc+bBpIUDgTLRl1d33Zsr3J9n4uNIk/tu9cLW9npz5j1OJsPCjR0/Fmu+UGRpp3xEDHt3gH5wDcIDJXctlRBC1tSQDbmC6epheyJf9dUHPPlhlksgLY5k9NEkSDtB5iWCgQ7XX4Gty0nIVuxyy1cTufDV5mqzewJkyL7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799061; c=relaxed/simple;
	bh=Jw7ALA7hpmXnAP/Kypfcn/ibIEv2TWlznMpwoyfzncw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6uOIOcDRHJIuGbrCr1OVsSwptUqkNQ7oJbmlqvtz1MwyQ+ZwhulBzyvDibM0em9aJnAXVSKs6dXso6pHKaRiwoZjKd3z4BdUll91xRzOvS9rTn58c/W0DHO9bi/oUmE2urRmTyO5djk0LJr2Ll3uTZ9SS884Xz+hl4T43fqfUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OzouaXA5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso2413980e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720799058; x=1721403858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm+dL+hq2H7t5EiDDEM1tOdPxkkuckw7URFjri0hY5Y=;
        b=OzouaXA5DuZCpAnHID8zf+s9TcNug9pKyrNVtHLWyUb/H2dJInq9gmgQZ0aE+44dbZ
         eTGq8g1eR7kknIKMEGum/BVvv4vMa7WJcM/iB3LOSxBkWKVaakfcpGQ/mgCiW7xnm4i7
         VCUI2eDUo7lvr6s09UCr0NT0fQloFZ4IcvM/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799058; x=1721403858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gm+dL+hq2H7t5EiDDEM1tOdPxkkuckw7URFjri0hY5Y=;
        b=VLq4kl01Ou0uyViyMJ7eSSIGrfrfAvHQ/Rdpq9uSNE4P/EPy9s4yUPQc3thPfod2A/
         rNMHNO9X6ElkxFLgUkjEIszh+wrxexwlKIPXJrfrJK2esFG+1HrhXSowHfQHvr8Xgaj3
         rhL7t1ScIMP72qw3/PfvPQCwXwMjk5ZGc/Rka7nPOVjaodRrHIYMtpldzftAhjgB5SEy
         y9NgwF5fUnkkLPOdli7i1kYKx27AHipsnOCkpX9Vw3gFYJZbp6YF+0koUX5euhtrEPJN
         9yE+M3k3+FuabVDKXHv/tXv6IYwutCyG6pphL5DAciB3Bcba1hxsqxS/dmJ+4/dH24Pm
         /U+w==
X-Forwarded-Encrypted: i=1; AJvYcCX/1TAkXKq6ilfWf79CXy5reqKj8yHN5mvz/CqKhOpzsZoNJHGnIjQreO1/4+YnjMsCs1tWTdZQxmZ9Tk9CthnERAyJGxao95RwLi4d
X-Gm-Message-State: AOJu0Yy2HB7+x3G1U8Fbj4G5Mswn5/oUcSLux8Su2wbLp5ECFYQcf48G
	+/y4nXa7Vng1hG0RsrLcZvPthIO13Hs23YugDIxBHg4vhS6b6I+iFHmKs86oGBrkYaPZM01dCK7
	FNQE+nHQjrXPCEaxgjACAW3MEq08A9ioNZYc=
X-Google-Smtp-Source: AGHT+IH9pJBNkOUybx5L7VzoPfxzDl6G5bgrKTfUB/1jjytiloEd89f5W+QGClFOQf+tuEha2LiMoViJKAOxrZ9jfME=
X-Received: by 2002:a05:6512:ea1:b0:52c:df6f:a66 with SMTP id
 2adb3069b0e04-52eb99d4f5dmr8246097e87.58.1720799058056; Fri, 12 Jul 2024
 08:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <ZoR40nWmpEV2Ly_6@bombadil.infradead.org> <CAJfuBxyxamRhOyz8WuL+7=eJkEKSw8jnAWjyAuqU2i7gvg-rsQ@mail.gmail.com>
In-Reply-To: <CAJfuBxyxamRhOyz8WuL+7=eJkEKSw8jnAWjyAuqU2i7gvg-rsQ@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Fri, 12 Jul 2024 17:44:06 +0200
Message-ID: <CALwA+NbUCfEj_DzT5eMQ7_pSNpyp-zBe6PEL2XnMZrb303J4_Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/53] fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
To: jim.cromie@gmail.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com, jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 12:14=E2=80=AFAM <jim.cromie@gmail.com> wrote:
>
> On Tue, Jul 2, 2024 at 4:01=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
> >
> > On Tue, Jul 02, 2024 at 03:56:50PM -0600, Jim Cromie wrote:
> > > This fixes dynamic-debug support for DRM.debug, added via classmaps.
> > > commit bb2ff6c27bc9 (drm: Disable dynamic debug as broken)
> > >
> > > CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy was marked broken because drm.debug=
=3Dval
> > > was applied when drm.ko was modprobed; too early for the yet-to-load
> > > drivers, which thus missed the enablement.  My testing with
> > > /etc/modprobe.d/ entries and modprobes with dyndbg=3D$querycmd option=
s
> > > obscured this omission.
> > >
> > > The fix is to replace invocations of DECLARE_DYNDBG_CLASSMAP with
> > > DYNDBG_CLASSMAP_DEFINE for core, and DYNDBG_CLASSMAP_USE for drivers.
> > > The distinction allows dyndbg to also handle the users properly.
> > >
> > > DRM is the only current classmaps user, and is not really using it,
> > > so if you think DRM could benefit from zero-off-cost debugs based on
> > > static-keys, please test.
> > >
> > > HISTORY
> > >
> > > 9/4/22  - ee879be38bc8..ace7c4bbb240 commited - classmaps-v1 dyndbg p=
arts
> > > 9/11/22 - 0406faf25fb1..16deeb8e18ca commited - classmaps-v1 drm part=
s
> > >
> > > https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
> > > greg k-h says:
> > > This should go through the drm tree now.  The rest probably should al=
so
> > > go that way and not through my tree as well.
> >
> > Can't this just be defined as a coccinelle smpl patch? Must easier
> > to read than 53 patches?
> >
>
> perhaps it could - Im not sure that would be easier to review
> than a file-scoped struct declaration or reference per driver
>
> Also, I did it hoping to solicit more Tested-by:s with drm.debug=3D0x1ff
>
> Jim
>

Jim,

When testing different combinations of Y/M for TEST_DYNAMIC_DEBUG and
TEST_DYNAMIC_DEBUG_SUBMOD in virtme-ng I spotted test failures:

When the TEST_DYNAMIC_DEBUG=3DM and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
BASIC_TESTS, COMMA_TERMINATOR_TESTS, TEST_PERCENT_SPLITTING,
TEST_MOD_SUBMOD selftests passed
When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
BASIC_TESTS, COMMA_TERMINATOR_TESTS selftests passed, however
TEST_PERCENT_SPLITTING selftest fails with ": ./dyndbg_selftest.sh:270
check failed expected 1 on =3Dpf, got 0"
When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DY -
BASIC_TESTS, COMMA_TERMINATOR_TESTS selftests passed, however
TEST_PERCENT_SPLITTING selftest fails also with ":
./dyndbg_selftest.sh:270 check failed expected 1 on =3Dpf, got 0"

Have I missed something ?

Thanks,
Lukasz

> >   Luis
> >

