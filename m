Return-Path: <linux-kernel+bounces-251647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F081F930781
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 23:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BCC1C20CC9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD245144D27;
	Sat, 13 Jul 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHHScNDY"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4913B5A6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720907127; cv=none; b=OxCWtXQmbtYyB3OojELO7jgU0cllDgfTKwneu5f5DCr42XbV0IhQxt0bup2ApS5QBsI1r0oH4fOVh9hMUrkIOZ9mqmnE5amXjo1xxTUxOqK+3Tk4at5DKHf4li/W42evWpC8Loofb2F5gJSlBZ3rrLeqJ4FAjhW34cCYKUQKGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720907127; c=relaxed/simple;
	bh=a+dp9grJ0Uex49OGtxpYaJ2AFt2dcdYxhNCSDjUDtv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsZEEIMNgxtNnhDfRKWZSKnlUZCVzraSH3UoYpwE+Q++vtpkdBtl/f2Gd3NJ3LT6tvIlNNxARgZNOwwXttUjq33of2xJ4mCMOehUVRvzCWqBYUKRvlGvN1YVprzH2f4tBISJaET4+jcOtjQVJjtG7iNXffoWedA0FzGdFfL5nPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHHScNDY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5eb69e04cso20860476d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720907123; x=1721511923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4779INmo7oX2Brk3wPdsCqYd8M38qMXjWNHByl5qIpw=;
        b=aHHScNDYUbrORMNQUwqubn6uBuBuG54tpeHiFxYOtiiHSCQLL8vILh2ssIvcD+mbLi
         9hB7xGnYmEFkzT6VQyhiso8S4WH/oaKwH4PE2+LZCfqlwIt7ore8yG1gePuR84Yuyjs2
         MGn5YJWdUD3pOOuT+ApJLHfzxxdhcAKEXRKe9bwOQve8+Qy6BlKWHpkoUhYMxEkbjoqh
         bJJ2jz0af1z/2x8tiiRlln5G1q9BgXK5nKGGCoLl4dHhxagW1umjBO7omNEKp1TgmfTj
         bUSeLYyjudZEp8nGZuB6pGtdRgukdqNzeapexxtlrHCHGuDSAHMhA0PsWKTnKptq3Eci
         hZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720907123; x=1721511923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4779INmo7oX2Brk3wPdsCqYd8M38qMXjWNHByl5qIpw=;
        b=ialGSwE0Rph7ZAKXOuH5anBSjANcNYw0Ya543ID50bKLnYARV7Sk8ri9CoEBTZLSMe
         2h10qWbgvbh7yd5rabTDtO+Lbj0J2nmlT9OdLRBOSGr7WsPm4GVAEg/PEvjeIozdmUHx
         grP8bFg75jiokivsvp/fKckzQUfD04Wz5FY3gIePw5g/aYnW48jbet3yzEnDqRUuC5mZ
         cM4jtsE/E9MtvYxzX68IEPyb432PAGa6qSLafFWKYxfW87rBhjZA0xvH7Gun1C0Rs2m8
         ZfwS0JSnTFJJiRme1zQm3hhObcWUVmMfRWjbsPaoAr4IsMbSdEs2Rwkm7/FP8V0cSLrb
         BaDA==
X-Forwarded-Encrypted: i=1; AJvYcCUPHsdASYdmVFVv1ic8qD8vT4qRXPYg732uL+0HC0ARcm1+OI3A/OubcI36ObDhlIDoMh2Y8Nufjq3izW7Y+A9dUXWupXw78m8RNzEl
X-Gm-Message-State: AOJu0YwEVqHr0dUU2Ycc4klVRqG7ol//NhibqsbyLuKPwN51Zd8y1dXE
	O4//+eCsCznlIoCBF0NtCNziAqdgVW5E9iqlUgAtrMVY9gmLmvg/Wikd/JTV2jQh4eVvI6VIQya
	eMIgiqCYdMbzWbqptZ41Vnqfb5anFUg==
X-Google-Smtp-Source: AGHT+IECwGe1XPnVjL8bL7fgHx3vmwrkrBhM9n+vGphssGZ6Q8QmFWuPB6qYS/3zcotMT35Kj9aVE9yPMKl7T4oT6/4=
X-Received: by 2002:a05:6214:2a83:b0:6b7:4319:ad6f with SMTP id
 6a1803df08f44-6b74319b2admr142352906d6.36.1720907123486; Sat, 13 Jul 2024
 14:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <ZoR40nWmpEV2Ly_6@bombadil.infradead.org> <CAJfuBxyxamRhOyz8WuL+7=eJkEKSw8jnAWjyAuqU2i7gvg-rsQ@mail.gmail.com>
 <CALwA+NbUCfEj_DzT5eMQ7_pSNpyp-zBe6PEL2XnMZrb303J4_Q@mail.gmail.com>
In-Reply-To: <CALwA+NbUCfEj_DzT5eMQ7_pSNpyp-zBe6PEL2XnMZrb303J4_Q@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Sat, 13 Jul 2024 15:44:57 -0600
Message-ID: <CAJfuBxzeYWWV1ikYagFpyFHdAQU4ReYPirksQFHbEzDxhXCfHA@mail.gmail.com>
Subject: Re: [PATCH v9 00/53] fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com, jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 9:44=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chromi=
um.org> wrote:
>
> On Wed, Jul 3, 2024 at 12:14=E2=80=AFAM <jim.cromie@gmail.com> wrote:
> >
> > On Tue, Jul 2, 2024 at 4:01=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.=
org> wrote:
> > >
> > > On Tue, Jul 02, 2024 at 03:56:50PM -0600, Jim Cromie wrote:
> > > > This fixes dynamic-debug support for DRM.debug, added via classmaps=
.
> > > > commit bb2ff6c27bc9 (drm: Disable dynamic debug as broken)
> > > >
> > > > CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy was marked broken because drm.debu=
g=3Dval
> > > > was applied when drm.ko was modprobed; too early for the yet-to-loa=
d
> > > > drivers, which thus missed the enablement.  My testing with
> > > > /etc/modprobe.d/ entries and modprobes with dyndbg=3D$querycmd opti=
ons
> > > > obscured this omission.
> > > >
> > > > The fix is to replace invocations of DECLARE_DYNDBG_CLASSMAP with
> > > > DYNDBG_CLASSMAP_DEFINE for core, and DYNDBG_CLASSMAP_USE for driver=
s.
> > > > The distinction allows dyndbg to also handle the users properly.
> > > >
> > > > DRM is the only current classmaps user, and is not really using it,
> > > > so if you think DRM could benefit from zero-off-cost debugs based o=
n
> > > > static-keys, please test.
> > > >
> > > > HISTORY
> > > >
> > > > 9/4/22  - ee879be38bc8..ace7c4bbb240 commited - classmaps-v1 dyndbg=
 parts
> > > > 9/11/22 - 0406faf25fb1..16deeb8e18ca commited - classmaps-v1 drm pa=
rts
> > > >
> > > > https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
> > > > greg k-h says:
> > > > This should go through the drm tree now.  The rest probably should =
also
> > > > go that way and not through my tree as well.
> > >
> > > Can't this just be defined as a coccinelle smpl patch? Must easier
> > > to read than 53 patches?
> > >
> >
> > perhaps it could - Im not sure that would be easier to review
> > than a file-scoped struct declaration or reference per driver
> >
> > Also, I did it hoping to solicit more Tested-by:s with drm.debug=3D0x1f=
f
> >
> > Jim
> >
>
> Jim,
>
> When testing different combinations of Y/M for TEST_DYNAMIC_DEBUG and
> TEST_DYNAMIC_DEBUG_SUBMOD in virtme-ng I spotted test failures:
>
> When the TEST_DYNAMIC_DEBUG=3DM and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
> BASIC_TESTS, COMMA_TERMINATOR_TESTS, TEST_PERCENT_SPLITTING,
> TEST_MOD_SUBMOD selftests passed
> When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
> BASIC_TESTS, COMMA_TERMINATOR_TESTS selftests passed, however
> TEST_PERCENT_SPLITTING selftest fails with ": ./dyndbg_selftest.sh:270
> check failed expected 1 on =3Dpf, got 0"
> When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DY -
> BASIC_TESTS, COMMA_TERMINATOR_TESTS selftests passed, however
> TEST_PERCENT_SPLITTING selftest fails also with ":
> ./dyndbg_selftest.sh:270 check failed expected 1 on =3Dpf, got 0"
>
> Have I missed something ?
>

I am not seeing those 2 failures on those 2 configs.

most of my recent testing has been on x86-defconfig + minimals,
built and run using/inside virtme-ng

the last kernel I installed on this hw was june 16, I will repeat that,
and report soon if I see the failure outside the vm

I'll also send you my script, to maybe speed isolation of the differences.

> Thanks,
> Lukasz
>
> > >   Luis
> > >

