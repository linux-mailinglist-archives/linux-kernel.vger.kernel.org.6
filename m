Return-Path: <linux-kernel+bounces-252349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3077B9311F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69CA2855C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3B187327;
	Mon, 15 Jul 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BAx/jI7J"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6723BF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037912; cv=none; b=b/03LqzfcH3igSsWtT5vIsZJFU1SrcocmspdcXzGwAPissa6xl+bC4yJ0AbXREYQ/edQtEs4ToK5QXF/CRITz++W9BbSW8a9xwmKsANqRwA3O343mMdPodGEl+x2H5/ceDRB9a67PgcmHn+VYV5ODLWk+GhD3NN7PO/TGwjYzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037912; c=relaxed/simple;
	bh=3JUHujWjiaHRS+vu9GT1XVAPz43NrXG5mNF+7DfNJL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQw67EusIGFzKhPVYbHIempPoI0AWurh7p8a6TyVfMskr7CumBQ8mwBsWKiNLyLDcsU4oZWB4i49tkJfSU0CHYB8PP2BWdlw/c2oTMTuPTACG1VoP61q4/9MLZSteKeLhpc5GsZkWYuHudGLS3Lodk6MngrK72HR/BDgRbB8iqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BAx/jI7J; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so4252060e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721037908; x=1721642708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXrhdNRq6oludJZnjz76rz84qmMewPWdtA9STQ5A9L0=;
        b=BAx/jI7JcGYNLmK6SQqhHuYMuL512IwAV80u1MMAlVVSIDrw+X3lUWjqgIk75bUDeQ
         6gubdDTe/IQdzVsMHDd5yQd99LT97xtgQjYtMF5A7yC8EXpNr2ign8JCWM/ekp/5uo0C
         iD0IGza3R8SqVzAxnJzmGULYmCPH+v3VIniHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721037908; x=1721642708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXrhdNRq6oludJZnjz76rz84qmMewPWdtA9STQ5A9L0=;
        b=iNYkA2UE20GWPuur2Bf0mgmqlyVyptbWprBkR4N5LmFRJ65mbrwtTfrJd6UMpBAHiA
         UlO6iG47JKbVyiUE58WulG0uPHBtBBFDOzMMQJUAA62rf8PzpqVf1zrKciuT4iHAZ9Tr
         5tfeJv6V3iiL8O1DjMnkZQPTVLpWH0Ra889eHx1KcTEz5ksd2u0m3TJjpAvC4SlKLeiq
         3FWzHB0/da0nZu79JvfCVQ9D28MXz+lMQL9rr9jUhWmnxXbsudtgK30APBcAqH4BCDFr
         WR4wWIr8Wf8opkR+S1jWnLWYFrvZUnyIS03FlZjslNMvvQI1f++EKUXBmKaacGCpVKk7
         ZXpA==
X-Forwarded-Encrypted: i=1; AJvYcCV0DnE5RxnrDpe/4SEkB047UNu6xS23ISgD9bsIRELIxEfHmnXMct4Kl44bO3N/TT0wSWHJ58Mxe/5nMdc3FI1irxBAyecowqTEnkS+
X-Gm-Message-State: AOJu0YyT0zJU4oLJ7fpwhwv7iqVSo1b0UNGxkD3CIsT13yYUTSD7eHr/
	WaemJMT+6ddURQfp1V/b1eFFLLx02knwC9GFjirfG65alJTho3euEaOSjK2X4k5cfw5AD3lhGp2
	pIw4oVWwG6euks9mO9v8e/NY66WWcgu/Y4TY=
X-Google-Smtp-Source: AGHT+IFR/iC1N3Tb8Jho/ZE42f1MzhOjhl0CAO4hiWmUByPiy1Zd0g36Ny/4VrjQlbpoVgWVwwAvv2WZBTBdvA7v3B4=
X-Received: by 2002:a05:6512:3b20:b0:52c:c9ce:be8d with SMTP id
 2adb3069b0e04-52eb99d6de0mr12891922e87.57.1721037907620; Mon, 15 Jul 2024
 03:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <ZoR40nWmpEV2Ly_6@bombadil.infradead.org> <CAJfuBxyxamRhOyz8WuL+7=eJkEKSw8jnAWjyAuqU2i7gvg-rsQ@mail.gmail.com>
 <CALwA+NbUCfEj_DzT5eMQ7_pSNpyp-zBe6PEL2XnMZrb303J4_Q@mail.gmail.com> <CAJfuBxzeYWWV1ikYagFpyFHdAQU4ReYPirksQFHbEzDxhXCfHA@mail.gmail.com>
In-Reply-To: <CAJfuBxzeYWWV1ikYagFpyFHdAQU4ReYPirksQFHbEzDxhXCfHA@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Mon, 15 Jul 2024 12:04:56 +0200
Message-ID: <CALwA+Naec_YHxHoKu8Ba_Bnuq2L3VXw1cT3=Tx3qC3mE5_BG1g@mail.gmail.com>
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

On Sat, Jul 13, 2024 at 11:45=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Fri, Jul 12, 2024 at 9:44=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chro=
mium.org> wrote:
> >
> > On Wed, Jul 3, 2024 at 12:14=E2=80=AFAM <jim.cromie@gmail.com> wrote:
> > >
> > > On Tue, Jul 2, 2024 at 4:01=E2=80=AFPM Luis Chamberlain <mcgrof@kerne=
l.org> wrote:
> > > >
> > > > On Tue, Jul 02, 2024 at 03:56:50PM -0600, Jim Cromie wrote:
> > > > > This fixes dynamic-debug support for DRM.debug, added via classma=
ps.
> > > > > commit bb2ff6c27bc9 (drm: Disable dynamic debug as broken)
> > > > >
> > > > > CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy was marked broken because drm.de=
bug=3Dval
> > > > > was applied when drm.ko was modprobed; too early for the yet-to-l=
oad
> > > > > drivers, which thus missed the enablement.  My testing with
> > > > > /etc/modprobe.d/ entries and modprobes with dyndbg=3D$querycmd op=
tions
> > > > > obscured this omission.
> > > > >
> > > > > The fix is to replace invocations of DECLARE_DYNDBG_CLASSMAP with
> > > > > DYNDBG_CLASSMAP_DEFINE for core, and DYNDBG_CLASSMAP_USE for driv=
ers.
> > > > > The distinction allows dyndbg to also handle the users properly.
> > > > >
> > > > > DRM is the only current classmaps user, and is not really using i=
t,
> > > > > so if you think DRM could benefit from zero-off-cost debugs based=
 on
> > > > > static-keys, please test.
> > > > >
> > > > > HISTORY
> > > > >
> > > > > 9/4/22  - ee879be38bc8..ace7c4bbb240 commited - classmaps-v1 dynd=
bg parts
> > > > > 9/11/22 - 0406faf25fb1..16deeb8e18ca commited - classmaps-v1 drm =
parts
> > > > >
> > > > > https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
> > > > > greg k-h says:
> > > > > This should go through the drm tree now.  The rest probably shoul=
d also
> > > > > go that way and not through my tree as well.
> > > >
> > > > Can't this just be defined as a coccinelle smpl patch? Must easier
> > > > to read than 53 patches?
> > > >
> > >
> > > perhaps it could - Im not sure that would be easier to review
> > > than a file-scoped struct declaration or reference per driver
> > >
> > > Also, I did it hoping to solicit more Tested-by:s with drm.debug=3D0x=
1ff
> > >
> > > Jim
> > >
> >
> > Jim,
> >
> > When testing different combinations of Y/M for TEST_DYNAMIC_DEBUG and
> > TEST_DYNAMIC_DEBUG_SUBMOD in virtme-ng I spotted test failures:
> >
> > When the TEST_DYNAMIC_DEBUG=3DM and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
> > BASIC_TESTS, COMMA_TERMINATOR_TESTS, TEST_PERCENT_SPLITTING,
> > TEST_MOD_SUBMOD selftests passed
> > When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
> > BASIC_TESTS, COMMA_TERMINATOR_TESTS selftests passed, however
> > TEST_PERCENT_SPLITTING selftest fails with ": ./dyndbg_selftest.sh:270
> > check failed expected 1 on =3Dpf, got 0"
> > When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DY -
> > BASIC_TESTS, COMMA_TERMINATOR_TESTS selftests passed, however
> > TEST_PERCENT_SPLITTING selftest fails also with ":
> > ./dyndbg_selftest.sh:270 check failed expected 1 on =3Dpf, got 0"
> >
> > Have I missed something ?
> >
>
> I am not seeing those 2 failures on those 2 configs.
>
> most of my recent testing has been on x86-defconfig + minimals,
> built and run using/inside virtme-ng
>
> the last kernel I installed on this hw was june 16, I will repeat that,
> and report soon if I see the failure outside the vm
>
> I'll also send you my script, to maybe speed isolation of the differences=
.
>

Jim,

I know why I saw these failures.
I ran dyndbg_selftest.sh directly in thw directory
tools/testing/selftests/dynamic_debug/.

All works as expected when I run it from the top kernel directory.
Here are the results:

When the TEST_DYNAMIC_DEBUG=3DM and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
BASIC_TESTS, COMMA_TERMINATOR_TESTS, TEST_PERCENT_SPLITTING,
TEST_MOD_SUBMOD selftests passed

When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
BASIC_TESTS and COMMA_TERMINATOR_TESTS selftests passed,
TEST_PERCENT_SPLITTING and TEST_PERCENT_SPLITTING selftests were
skipped

When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DY -
BASIC_TESTS and COMMA_TERMINATOR_TESTS selftests passed,
TEST_PERCENT_SPLITTING and TEST_PERCENT_SPLITTING selftests were
skipped

Based on that maybe it would be worth it for the script to fail when
it doesn't find a .config with an error message something like this:
"Kernel .config not found. Are you running the script from the
kernel's top directory?"

What do you think ?

Thanks,
Lukasz

> > Thanks,
> > Lukasz
> >
> > > >   Luis
> > > >

