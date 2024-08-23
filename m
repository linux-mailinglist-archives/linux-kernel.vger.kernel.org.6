Return-Path: <linux-kernel+bounces-299719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D595D923
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D527FB2120E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B31C8716;
	Fri, 23 Aug 2024 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="YQxriK00"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748D1C8706
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451282; cv=none; b=iPaqCLry3xIhjVzoE6+ASRAmt83YvPHmklqSwtyvI6PwPpfFGrTRq6Pj/pjPPfRyx51I4J7yfbEFsgnl/Z45KOjn0nHhxgUAmGz5wYwpvHIfbjEkI+48PE7BqHV2Oz3yuW6+a4/SvVf2HopaP+9dhC8LGsvQFlPgQDXtNo/hifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451282; c=relaxed/simple;
	bh=ef9BdM7Ru4+vKo57Z5rftWEmSePRQLxRRzy/17lBdrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESMp78L/6oDOH+kBv/QoqySucwObTfT7TGPHdeyaIB5S5qMOJOU4SzL/4WIt9B251X2kYHnkPw0dogsEC8Fi6pspggBeGE2kMzI2LLHlseR6VgaND+XgTzgXPmSgSwC6tg/RW1pHWcezL4VxBOXuoR7mG9bFNHZIFbezhy9sCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=YQxriK00; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5334879ba28so3016552e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1724451278; x=1725056078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVn7bhcqAuWH/Gc+rMZ1Xor11/SH0tAXV77Rde16lJc=;
        b=YQxriK00oFhBPi+odLWARkTI3F8J+tsuz4Xq8yfpkBuet2dOyB5zupZfUzSTOtUpbc
         0y+Tgk86diTl0Dj86S1a0Lg+oKexzTz8WKLldwpnO0Ufli7AJgKxaq1FKoEx7AJskc9/
         JsUvXTHpANfu5fXTb37iN7G2KcttoU/MtONuTlmMElx+eiDzAtFWKkxF3CGDTgev6JsS
         r/RkrIA4yuRHgo0U/l7UStFMiyTrDM8REseH89Z5vpoqbOkqa1bxS906VW7rycgXpUkJ
         2gszazmO3JXeuAI7COHQlfIFgRQJM3wXbJ7zio16niIVyoJjIWVzfYPMXaypFYizTYjJ
         nwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451278; x=1725056078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVn7bhcqAuWH/Gc+rMZ1Xor11/SH0tAXV77Rde16lJc=;
        b=jgDH1COo2i71mYHL/qdsu+9mgB/aEdlfOBUMIybptk5008iCboxvgf89OcQMkfC/la
         KlDRG1HI31Kpxk9Vl/9s5vSeYez2Qm8tCmykin9yLVKXOpTGZrhHvCHsh0qiK+pxak9P
         oJt8P+Bv/LQgkoMghCRLzVeiVJgMTnc94iOHNPniOy1/PuifalC1S3tLEPSMkEysacJu
         eUPthd0KoID2xzcIu8eMVk+VH9gZaNzHxJI5RQ9iNu5Jm6WFWYHUdLU6JwjEjsv/LgGR
         dTdGBg3knLnimFXraFxF32efNooqK+6wmHJkiypovZxmpseVBtxeKrZeT49ZkM4EOqoP
         8jsw==
X-Forwarded-Encrypted: i=1; AJvYcCWaCe7/ZeocdTWsVP2JT/ksd8El+HhHk4Q6g1Snu3dt4fvz5vYBuKjWhbOXXPZ6Ultf8d3/M+pEhCTiEr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+EqYLbk3pYlrxMPP9L8ecGfh5fnUXx5Dp/2H2hiePsWTE1rGU
	vQUdqMVjp11gUlZo+ybn8TG28ZERb7sFmXekGqtzOGKHJ2BToXYtFNQRFNpK6KPnfxDEAoSeJQu
	WBuiq8shsIuGjZcQ4TTtwFiso83sFkNNyVC3Plg==
X-Google-Smtp-Source: AGHT+IGDhJMFPFDslCxnxri8S951sJjg3aSvVif7lXNqXGz7kFGS4rZgZs1ZBpw6GOJM88hNjR9zGKziEIDdKGLwVUE=
X-Received: by 2002:a05:6512:2244:b0:533:4327:b4cc with SMTP id
 2adb3069b0e04-534387c175cmr2666989e87.52.1724451277886; Fri, 23 Aug 2024
 15:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-macos-build-support-v1-0-4cd1ded85694@samsung.com>
 <20240807-macos-build-support-v1-1-4cd1ded85694@samsung.com> <CAK7LNARmy=N+6O87BJGZbodssDw21sHgMf36TXdcxD4=5A_OBA@mail.gmail.com>
In-Reply-To: <CAK7LNARmy=N+6O87BJGZbodssDw21sHgMf36TXdcxD4=5A_OBA@mail.gmail.com>
From: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>
Date: Sat, 24 Aug 2024 00:14:11 +0200
Message-ID: <CABj0suC1atc=iPX4uOL5FYkzYBRtZC1J3Lhruo7hejd-fe9Yuw@mail.gmail.com>
Subject: Re: [PATCH 01/12] scripts: subarch.include: fix SUBARCH on MacOS hosts
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: da.gomez@samsung.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, speakup@linux-speakup.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, gost.dev@samsung.com, 
	Nick Desaulniers <nick.desaulniers@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 6:13=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Aug 7, 2024 at 8:10=E2=80=AFAM Daniel Gomez via B4 Relay
> <devnull+da.gomez.samsung.com@kernel.org> wrote:
> >
> > From: Nick Desaulniers <nick.desaulniers@gmail.com>
> >
> > When building the Linux kernel on an aarch64 MacOS based host, if we do=
n't
> > specify a value for ARCH when invoking make, we default to arm and thus
> > multi_v7_defconfig rather than the expected arm64 and arm64's defconfig=
.
> >
> > This is because subarch.include invokes `uname -m` which on MacOS hosts
> > evaluates to `arm64` but on Linux hosts evaluates to `aarch64`,
> >
> > This allows us to build ARCH=3Darm64 natively on MacOS (as in ARCH need
> > not be specified on an aarch64-based system).
> >
> > Utilize a negative lookahead regular expression to avoid matching arm64=
.
>
>
> Does sed support "negative lookahead regular expression"?

I think they removed support for PCRE. I've found this:

commit 261c7f145d015d9acb79dc650d27e4a23b839c23
Author: Assaf Gordon <assafgordon@gmail.com>
Date:   Tue Aug 21 14:25:57 2018 -0600

    maint: remove REG_PERL code

    Perl-regexp syntax (PCRE) in GNU Sed is shelved indefinitely.
    See https://bugs.gnu.org/22801 , https://bugs.gnu.org/22647 .
    Remove all (unused) REG_PERL related code.

    * sed/sed.c, sed/sed.h, sed/regexp.c, sed/compile.c: Remove REG_PERL co=
de.

git tag --contains 261c7f145d015d9acb79dc650d27e4a23b839c23
v4.6
v4.7
v4.8
v4.9

And my sed version is (Debian):

sed --version
sed (GNU sed) 4.9
Packaged by Debian
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.ht=
ml>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Jay Fenlason, Tom Lord, Ken Pizzini,
Paolo Bonzini, Jim Meyering, and Assaf Gordon.

This sed program was built with SELinux support.
SELinux is disabled on this system.

GNU sed home page: <https://www.gnu.org/software/sed/>.
General help using GNU software: <https://www.gnu.org/gethelp/>.
E-mail bug reports to: <bug-sed@gnu.org>.

sed version (Homebrew):
sed --version
sed (GNU sed) 4.9
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.ht=
ml>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Jay Fenlason, Tom Lord, Ken Pizzini,
Paolo Bonzini, Jim Meyering, and Assaf Gordon.

This sed program was built without SELinux support.

GNU sed home page: <https://www.gnu.org/software/sed/>.
General help using GNU software: <https://www.gnu.org/gethelp/>.
E-mail bug reports to: <bug-sed@gnu.org>.

>
> >
> > Add a separate expression to support for armv.* as per error reported b=
y
> > Nicolas Schier [1].
> >
> > [1] https://lore.kernel.org/all/Y3MRvtwdjIwMHvRo@bergen.fjasle.eu/#t
> >
> > Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  scripts/subarch.include | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/subarch.include b/scripts/subarch.include
> > index 4bd327d0ae42..5d84ad8c0dee 100644
> > --- a/scripts/subarch.include
> > +++ b/scripts/subarch.include
> > @@ -6,7 +6,8 @@
> >
> >  SUBARCH :=3D $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
> >                                   -e s/sun4u/sparc64/ \
> > -                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
> > +                                 -e s/armv.*/arm/ \
> > +                                 -e s/arm\(?:\(?!64\).*\)/arm/ -e s/sa=
110/arm/ \
>
>
> s/arm\(?:\(?!64\).*\)/arm/
>
> In sed, this expression does not seem to match anything.

You are correct. I've removed the expression and saw no difference.
See below with my test case:
>
> (or please give me some matching examples if I miss something)

cat Makefile
MACHINE ?=3D "aarch64"
SUBARCH0 :=3D $(shell echo $(MACHINE) | sed \
                                  -e s/arm.*/arm/ \
                                  -e s/aarch64.*/arm64/)

SUBARCH1 :=3D $(shell echo $(MACHINE) | sed \
                                  -e s/armv.*/arm/ \
                                  -e s/aarch64.*/arm64/)

SUBARCH2 :=3D $(shell echo $(MACHINE) | sed \
                                  -e /^arm64$/!s/arm.*/arm/ \
                                  -e s/aarch64.*/arm64/)

test:
        @echo "MACHINE=3D$(MACHINE)"
        @echo "SUBARCH0=3D$(SUBARCH0)"
        @echo "SUBARCH1=3D$(SUBARCH1)"
        @echo "SUBARCH2=3D$(SUBARCH2)"
        @echo "---"

SUBARCH0 represents the current upstream expressions for arm/arm64.
SUBARCH1 is my proposal in case we need to cover only armv* for 32-bit
arm (I think that is incomplete?) and SUBARCH2 is Nicolas' proposal
(which I can't make it work in the test Makefile).

Running the above Makefile, I get:

make test MACHINE=3Darmv4 && make test MACHINE=3Darm7 && make test
MACHINE=3Darmhf && make test MACHINE=3Daarch64 && make test MACHINE=3Darm64
MACHINE=3Darmv4
SUBARCH0=3Darm
SUBARCH1=3Darm
SUBARCH2=3Darmv4
---
MACHINE=3Darm7
SUBARCH0=3Darm
SUBARCH1=3Darm7
SUBARCH2=3Darm7
---
MACHINE=3Darmhf
SUBARCH0=3Darm
SUBARCH1=3Darmhf
SUBARCH2=3Darmhf
---
MACHINE=3Daarch64
SUBARCH0=3Darm64
SUBARCH1=3Darm64
SUBARCH2=3Darm64
---
MACHINE=3Darm64
SUBARCH0=3Darm
SUBARCH1=3Darm64
SUBARCH2=3Darm64
---
>
>
>
>
>
> Nocolas already provided correct code:
>
> > [1] https://lore.kernel.org/all/Y3MRvtwdjIwMHvRo@bergen.fjasle.eu/#t

I think it is even more simple if we just make this change:

-                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
+                                 -e s/armv.*/arm/ \

Does armv.* cover all arm32 machines? I see armhf, arm7, arm8 and
armv*, is it correct?

And thanks for checking!

>
>
>
>
>
>
> >                                   -e s/s390x/s390/ \
> >                                   -e s/ppc.*/powerpc/ -e s/mips.*/mips/=
 \
> >                                   -e s/sh[234].*/sh/ -e s/aarch64.*/arm=
64/ \
> >
> > --
> > Git-146)
> >
> >
>
>
> --
> Best Regards
>
>
> Masahiro Yamada

