Return-Path: <linux-kernel+bounces-412145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6849D0453
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5F1B21C9D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1551D90BD;
	Sun, 17 Nov 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTbdScdQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4A1D89F5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853788; cv=none; b=Kby27/mwx7PZikMdAx7DRc783qSztLZBpksaG5fyCVE1It0dYBApdWSJCOImSrRnwldWg3xr3G0AyAIuANFK+OT/dgQiihDLahHhlZTHhm/JFANbNdGD05MK28iifAIgg8niLzTOKTVh7hksTZMYeXWw/C921cWdAcke+8PfHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853788; c=relaxed/simple;
	bh=O/JWHyDW0KE2C+ZgfVKqniQ/SdcaXsDHUSroiKdB9SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBbTc83zmKh9ek/h/8JAJ+FX+ndJnrJ7IrPSbhJq5qHeF+gIWe7ogg6qXu4SnN0y+jFlpfaIUtUvxQcU+Y2+vazPEkKQzRddBWUpd4E3+r1XSln9aqBAQew0A940k1wymmXRo+5uZ0dWESV16AxOOOBo4V/2AQ2dFF0tz1D48SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTbdScdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEDBC4CECD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731853787;
	bh=O/JWHyDW0KE2C+ZgfVKqniQ/SdcaXsDHUSroiKdB9SI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hTbdScdQrMWoFGpFqkSKmw9hV1punhOD4DwUzSilOZ5O0HduNKuDtVQNgKVHSJjBb
	 75WVR6NLwGOpA7MlVOgkAf92FrGSqvZERrMGKr9O8nNavoPF8vtRLVAjkxcL8Di+jb
	 RqpK+fSXwL1JUKHn3ymFhZvlXvVSfDDjC0/5ZMWnS1x0o4i/vzwvQP7wEBCXqG4knk
	 pDu0KhglN46v01HI2QcNARwZm1SB3/erWxPcehAYgCOD7ekatHqHiTBmLAHrM3iC/A
	 iNeW3kvGYt+amYwOUN7ccgEuPoS+DSKw1giK8HPOIt6hLkEAUGvlamPHl2AjSHS/i3
	 4nhvdaSTgUlBA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso33370801fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 06:29:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkzy69cdAktDp9WC1Q0HPajs0IbadISpYU/G4iUAL3ozJsa8311aXBOSEcfmoVfrcC0I6a8QOJM/5OunU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrDVUt+hUb0MEibLOpGs2Zef0qV2dhVs4bOLLN4HVGw5EGtrk
	12kVa/fdVbOHUfdNUN4a8K+sJ78k4MRkplfXOvpbnJmWAWkUaWoUSJEVC1aPylCoSK8xGtg6iqe
	ZQek1JPdrzc8JVxluMtrKmbG8gQ4=
X-Google-Smtp-Source: AGHT+IExNZRYsn5mI2cmaZeli5AYRt6e3OOfZgSGxtGp1LSUEibpevmh+1Ccpua/vIAvPdMbcOG/XCG8l0dx5Tn0DEI=
X-Received: by 2002:a2e:8a8e:0:b0:2ff:76ad:f8c3 with SMTP id
 38308e7fff4ca-2ff76adfa05mr2675771fa.1.1731853786408; Sun, 17 Nov 2024
 06:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112210500.2266762-1-linux@rasmusvillemoes.dk>
 <CAK7LNAQdxx6yHGc9-+=aQxeOkBs-qGxf_1namqWp-gUwQ-uo-w@mail.gmail.com> <877c92m4qc.fsf@prevas.dk>
In-Reply-To: <877c92m4qc.fsf@prevas.dk>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 17 Nov 2024 23:29:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqG2bediFSzC3MvL5_qErPrJswi0A4QP7V-pspQpfb=A@mail.gmail.com>
Message-ID: <CAK7LNATqG2bediFSzC3MvL5_qErPrJswi0A4QP7V-pspQpfb=A@mail.gmail.com>
Subject: Re: [PATCH v2] setlocalversion: work around "git describe" performance
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 9:20=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On Sat, Nov 16 2024, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > This patch was not sent to linux-kbuild ML
> > (and it can be one reason when a patch falls into a crack),
> > but I guess I am expected to review and pick it.
>
> Sorry, but get_maintainer.pl doesn't tell one to cc linux-kbuild.


Ah, I just realized that MAINTAINERS file does not cover this file.

KERNEL BUILD + files below scripts/ (unless maintained elsewhere)


So, I randomly pick up patches for the scripts/ directory.



> >>
> >> Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
> >
> >
> > Maybe, the comprehensive tag list looks like this?
> >
> > Reported-by: Sean Christopherson <seanjc@google.com>
> > Closes: https://lore.kernel.org/lkml/ZPtlxmdIJXOe0sEy@google.com/
> > Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Closes: https://lore.kernel.org/lkml/309549cafdcfe50c4fceac3263220cc3d8=
b109b2.1730337435.git.jpoimboe@kernel.org/
>
> Fine by me.
>
> >>
> >> +try_tag() {
> >> +       tag=3D"$1"
> >> +
> >> +       # Is $tag an annotated tag?
> >> +       [ "$(git cat-file -t "$tag" 2> /dev/null)" =3D "tag" ] || retu=
rn 1
> >
> > The double-quotes for tag are unneeded.
> >
> > "tag"  --> tag
> >
>
> OK. The current script isn't consistent here, though (--no-local and +
> are quoted where they need not be), and I find having the quotes on both
> sides of =3D more visually appealing. Not a hill I'm gonna die on.

My personal preference is to not add unnecessary quotes.

In contrast, necessary quotes are missing.

So, shellcheck shows warnings.


In scripts/setlocalversion line 79:
desc=3D$(git describe --match=3D$tag 2>/dev/null)
                                            ^--^ SC2086 (info): Double
quote to prevent globbing and word splitting.


If you contribute for consistency, it is appreciated too.


> > This function returns either 1 or 0, but how is it used?
> >
>
> Well, you're right that it's not used currently, but I might as well let
> the return value reflect whether it succeeded or not. I played around
> with some variation of
>
>   if [ -n "${file_localversion#-}" ] && try_tag "${file_localversion#-}" =
; then
>     :
>   elif [ -n "${file_localversion}" ] && try_tag "${version_tag}${file_loc=
alversion}" ; then
>     :
>   elif try_tag "${version_tag}"
>     :
>   else
>     count=3D""
>   fi
>
> but in the end decided to keep the current logic of testing some shell
> variable (previously $desc, not $count).

Either style is fine with me.



> Still, I see no reason to make
> the early returns do "return 0".






--=20
Best Regards
Masahiro Yamada

