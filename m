Return-Path: <linux-kernel+bounces-255069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7E933B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2B82838BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1E17F4E3;
	Wed, 17 Jul 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L8y6yTy9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EED17F36E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212749; cv=none; b=NWDmLf2YoQCwdPcX+zT9AiClhy00jW6ACXVEVS4wyt1ad4ju+zRhWb17SW42LG3eWA4vS/ey6WS3sJXN4rcwh8s1lZp+Rni51IbCOFKmUXg62UR9bWr3ViXKsMW6Kjd6LrH91UTRZQ6nGW0H1OLaDgvxBSA9q/yxM5D57I4LBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212749; c=relaxed/simple;
	bh=WhKS4jkTLsefDuEG9p7iucNmjwNPJGe6bKEAFUNz2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfN8TZUewQMKmEHbGjqlDXRWLf67clRIUS43sxVY2J3LCacYYFFOBMAGEi3y8q5irP26idpmXTHlHuNJkzu5iAcDSGKwKg7IzZMnRt5DnWpDVLFKXv9ZaImL+K9MnG/ai/dtK8FBMMWqZ/ZD79ybtm9yWZi5J7ktiyzz3rw3ISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L8y6yTy9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso8427653e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721212745; x=1721817545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUGlQHl8PKwPc+cI7G+9C1/A30MK7pw94dtaMexOJNU=;
        b=L8y6yTy9evMPhe8F5urOyuPvh0EaCKnnEsIIE2lqbkbiE2yEWr+BUpG/9eb/+7ZRXo
         WWQT9lSbCLC6W04XCRkIF2KKzbUZHoRfCpD9CjeQ353++bjII/+Pfz4AuaxpZ7HYjfM/
         NZTDhdIpiqzA2AGQ3+bQJYwIJ5QMEykljB2lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721212745; x=1721817545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUGlQHl8PKwPc+cI7G+9C1/A30MK7pw94dtaMexOJNU=;
        b=ItsJJWAb9Mz858UJCqTNsCygomk+kpCsyWGhaoIeZlN7R9AAMi8NVJjrS/wJNJt2i9
         OeJ9FHY57itWvAh79SbiOiY0mHRN7R3h7jU5TitKQG2zmFM44lAjoMB4mpP6CUhpqBsK
         1I+bKt560J1afIaS/dFfA2cAo/UgxoGFA9ishY6aIhqWrBAtjANWazI5T40kCt+IvTFk
         emLT8aX9D2B4EnlI392SCGDzVMR6/zS0vaConPy2JgoHDk5hl4lJcWn1/RN236MlKnG4
         tlyxpF+jE8aS2u4zPWQVCQMZpFHO7mIexmYYqp5388xeXw/kPyqYsd+0IPRBp8lT5gz0
         sQlg==
X-Forwarded-Encrypted: i=1; AJvYcCUrb8NHoVbjvellqPds8el0ot+Iw+ESv0KfvjPfQyg9zHYfAg46tQuEGkp1ZEkzyHqmGWRW/8X+vi/c8tbw35+z8AS/ZAMMH5r4fsWq
X-Gm-Message-State: AOJu0Yzd+vQOLeSzf/GYFf+LRdviGBPELCOW1w9uKJCC8qCzuTnKHqpF
	jOnN0iCJm6bcEljp4uOvwrH/So+qFos/nZK9FgN7O3TbA4TzhGzcX8DRzXtD7I9er7R0/b+kWGi
	DPk5EBxbuGfwwErzElw6lnJZU/5RA0S51Dak=
X-Google-Smtp-Source: AGHT+IHxg8zNsdD8Eo1Vffp0MSXIaIS5xW3Su0QbPUe5IWbUhBN/2S1B3D0WgRGGz2VkYyi0XXC5WDVvjaMANhw5Xos=
X-Received: by 2002:a05:6512:2387:b0:52d:259d:bd91 with SMTP id
 2adb3069b0e04-52ee53b04c7mr1051655e87.18.1721212744729; Wed, 17 Jul 2024
 03:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <ZoR40nWmpEV2Ly_6@bombadil.infradead.org> <CAJfuBxyxamRhOyz8WuL+7=eJkEKSw8jnAWjyAuqU2i7gvg-rsQ@mail.gmail.com>
 <CALwA+NbUCfEj_DzT5eMQ7_pSNpyp-zBe6PEL2XnMZrb303J4_Q@mail.gmail.com>
 <CAJfuBxzeYWWV1ikYagFpyFHdAQU4ReYPirksQFHbEzDxhXCfHA@mail.gmail.com>
 <CALwA+Naec_YHxHoKu8Ba_Bnuq2L3VXw1cT3=Tx3qC3mE5_BG1g@mail.gmail.com> <CAJfuBxxnTyqeGtS1mPBFqX2MYs7kgK49ZUQeR1oTe4UMC4ct5A@mail.gmail.com>
In-Reply-To: <CAJfuBxxnTyqeGtS1mPBFqX2MYs7kgK49ZUQeR1oTe4UMC4ct5A@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Wed, 17 Jul 2024 12:38:53 +0200
Message-ID: <CALwA+NYQsKAtrME-dgZcBH=+KKU0duHAjxu-X3PhckJmbwz60A@mail.gmail.com>
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

On Mon, Jul 15, 2024 at 8:00=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Mon, Jul 15, 2024 at 4:05=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chro=
mium.org> wrote:
> >
> > On Sat, Jul 13, 2024 at 11:45=E2=80=AFPM <jim.cromie@gmail.com> wrote:
> > >
> > > On Fri, Jul 12, 2024 at 9:44=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@=
chromium.org> wrote:
> > > >
> > > > On Wed, Jul 3, 2024 at 12:14=E2=80=AFAM <jim.cromie@gmail.com> wrot=
e:
> > > > >
> > > > > On Tue, Jul 2, 2024 at 4:01=E2=80=AFPM Luis Chamberlain <mcgrof@k=
ernel.org> wrote:
> > > > > >
> > > > > > On Tue, Jul 02, 2024 at 03:56:50PM -0600, Jim Cromie wrote:
> > > > > > > This fixes dynamic-debug support for DRM.debug, added via cla=
ssmaps.
> > > > > > > commit bb2ff6c27bc9 (drm: Disable dynamic debug as broken)
> > > > > > >
> > > > > > > CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy was marked broken because dr=
m.debug=3Dval
> > > > > > > was applied when drm.ko was modprobed; too early for the yet-=
to-load
> > > > > > > drivers, which thus missed the enablement.  My testing with
> > > > > > > /etc/modprobe.d/ entries and modprobes with dyndbg=3D$querycm=
d options
> > > > > > > obscured this omission.
> > > > > > >
> > > > > > > The fix is to replace invocations of DECLARE_DYNDBG_CLASSMAP =
with
> > > > > > > DYNDBG_CLASSMAP_DEFINE for core, and DYNDBG_CLASSMAP_USE for =
drivers.
> > > > > > > The distinction allows dyndbg to also handle the users proper=
ly.
> > > > > > >
> > > > > > > DRM is the only current classmaps user, and is not really usi=
ng it,
> > > > > > > so if you think DRM could benefit from zero-off-cost debugs b=
ased on
> > > > > > > static-keys, please test.
> > > > > > >
> > > > > > > HISTORY
> > > > > > >
> > > > > > > 9/4/22  - ee879be38bc8..ace7c4bbb240 commited - classmaps-v1 =
dyndbg parts
> > > > > > > 9/11/22 - 0406faf25fb1..16deeb8e18ca commited - classmaps-v1 =
drm parts
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
> > > > > > > greg k-h says:
> > > > > > > This should go through the drm tree now.  The rest probably s=
hould also
> > > > > > > go that way and not through my tree as well.
> > > > > >
> > > > > > Can't this just be defined as a coccinelle smpl patch? Must eas=
ier
> > > > > > to read than 53 patches?
> > > > > >
> > > > >
> > > > > perhaps it could - Im not sure that would be easier to review
> > > > > than a file-scoped struct declaration or reference per driver
> > > > >
> > > > > Also, I did it hoping to solicit more Tested-by:s with drm.debug=
=3D0x1ff
> > > > >
> > > > > Jim
> > > > >
> > > >
> > > > Jim,
> > > >
> > > > When testing different combinations of Y/M for TEST_DYNAMIC_DEBUG a=
nd
> > > > TEST_DYNAMIC_DEBUG_SUBMOD in virtme-ng I spotted test failures:
> > > >
> > > > When the TEST_DYNAMIC_DEBUG=3DM and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
> > > > BASIC_TESTS, COMMA_TERMINATOR_TESTS, TEST_PERCENT_SPLITTING,
> > > > TEST_MOD_SUBMOD selftests passed
> > > > When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
> > > > BASIC_TESTS, COMMA_TERMINATOR_TESTS selftests passed, however
> > > > TEST_PERCENT_SPLITTING selftest fails with ": ./dyndbg_selftest.sh:=
270
> > > > check failed expected 1 on =3Dpf, got 0"
> > > > When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DY -
> > > > BASIC_TESTS, COMMA_TERMINATOR_TESTS selftests passed, however
> > > > TEST_PERCENT_SPLITTING selftest fails also with ":
> > > > ./dyndbg_selftest.sh:270 check failed expected 1 on =3Dpf, got 0"
> > > >
> > > > Have I missed something ?
> > > >
> > >
> > > I am not seeing those 2 failures on those 2 configs.
> > >
> > > most of my recent testing has been on x86-defconfig + minimals,
> > > built and run using/inside virtme-ng
> > >
> > > the last kernel I installed on this hw was june 16, I will repeat tha=
t,
> > > and report soon if I see the failure outside the vm
> > >
> > > I'll also send you my script, to maybe speed isolation of the differe=
nces.
> > >
> >
> > Jim,
> >
> > I know why I saw these failures.
> > I ran dyndbg_selftest.sh directly in thw directory
> > tools/testing/selftests/dynamic_debug/.
>
> thats odd.
> I mostly run it from src-root,
> also whereever make selftest target is/works (I forgot)
>
> I went into that subdir and ran it there
> I got no test differences / failures.
>

Jim,

The dyndbg_selftest.sh checks the location of kernel .config if it is
configured and
if not it sets it to the current dir.

[ -f "$KCONFIG_CONFIG" ] || KCONFIG_CONFIG=3D".config"
if [ -f "$KCONFIG_CONFIG" ]; then

If it does not find the .config it will set the variables to:

    LACK_DD_BUILTIN=3D0
    LACK_TMOD=3D0
    LACK_TMOD_SUBMOD=3D0

and run all selftests no matter what the values (Y/M) of
TEST_DYNAMIC_DEBUG and TEST_DYNAMIC_DEBUG_SUBMOD are.

> IIRC, the failure was on line 270, just after a modprobe.
> can you further isolate it ?
>
> > All works as expected when I run it from the top kernel directory.
> > Here are the results:
> >
> > When the TEST_DYNAMIC_DEBUG=3DM and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
> > BASIC_TESTS, COMMA_TERMINATOR_TESTS, TEST_PERCENT_SPLITTING,
> > TEST_MOD_SUBMOD selftests passed
> >
> > When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DM -
> > BASIC_TESTS and COMMA_TERMINATOR_TESTS selftests passed,
> > TEST_PERCENT_SPLITTING and TEST_PERCENT_SPLITTING selftests were
> > skipped
> >
> > When the TEST_DYNAMIC_DEBUG=3DY and TEST_DYNAMIC_DEBUG_SUBMOD=3DY -
> > BASIC_TESTS and COMMA_TERMINATOR_TESTS selftests passed,
> > TEST_PERCENT_SPLITTING and TEST_PERCENT_SPLITTING selftests were
> > skipped
>
>
> thank you for running these config-combo tests.
>
> are you doing these in a VM ?
> and since Im asking, Ive done these combos on virtme-ng builds,
> also installed & running on 2 x86 boxen.
>

Sorry I forgot to mention that I tested it using virtme-ng.

> could you add DRM=3Dm and a driver too,
> and boot with drm.debug=3D0x1ff, dynamic_debug.verbose=3D3
> the debug output should show all the class-work on modprobe,
> for your easy inspection/grading ;-)
>

I will retest with your patchset v9.

Thanks,
Lukasz

> >
> > Based on that maybe it would be worth it for the script to fail when
> > it doesn't find a .config with an error message something like this:
>
> if no config - they get to see more errors now.
> if the solution isnt obvious to them, we can find out more ?
>
> > "Kernel .config not found. Are you running the script from the
> > kernel's top directory?"
> >
> > What do you think ?
>
> the -rc0 window is open, Id rather not fiddle with this now.
>
> Im gonna rebase onto 6.10, resend,
> copy and rebase onto drm-mumble-next
> then try to get into the DRM-CI river, see where that takes me.
>
> thanks Lukas,
> Jim
>
> >
> > Thanks,
> > Lukasz
> >
> > > > Thanks,
> > > > Lukasz
> > > >
> > > > > >   Luis
> > > > > >

