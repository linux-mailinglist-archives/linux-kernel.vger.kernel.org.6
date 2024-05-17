Return-Path: <linux-kernel+bounces-181783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509858C813B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A861C21117
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD715E8C;
	Fri, 17 May 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn+bhOyg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCB14F64
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930325; cv=none; b=OP4IsmUY4qCKB8ADmimuulzIRE4qDvoxTh8VXY/uj3t/4rvVmL+IZ/jB5/VzC9LuSv7WI6jKcTcACAHNzgv6jrVLj0tVTRhIlRzB4o+OdRW1g01ny4Rr8RsfMvFRkC7yTTCCyoFtC/OWbWwuu3/FDALlC6vaUM7qaJoTrZBwp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930325; c=relaxed/simple;
	bh=D6yLkdkWDGehSsmuPi0OTbIYs2uK1ZPFs2xIBQk11OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdaCk3YOgE9KhNvlgl6SXr1mpzEYLuPznAldEWayZkHPyNVFJPk5R5+hX4t9nkp7PhbHcA37HWjP0/lKpruxQwKI+bCz0svCOqr0FCCDgeFOBm44N1tmpKH7biioaRpL3Tuvz8BFHRq9AvVskHq8nrrcSWb9nHh2fCkGqJi12/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn+bhOyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A85C32786
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715930324;
	bh=D6yLkdkWDGehSsmuPi0OTbIYs2uK1ZPFs2xIBQk11OI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hn+bhOyg1u6Nn6IdET8i6FfDPRsF4cQ5L3G0uP5tRfzX60uIQVggaQA16HNLZMIC0
	 WLJQ4p1TmXaKzBXXMYbLDrHCN5Dnj7ufRqAoQ0coGgcoRUXwW6fHC0+K/UfcIT0hQ9
	 KrwBOWBM54JpGr6wpwN/YL4d+fRfKXT+hxl3CcxeKpxd/UnYYvMuGFa80vQh4C8CDv
	 CEIm1n6hHGRIMX+SvqOusw0nZg85Do0wKX5vEpKmhTPJoTQysWWVvt4TF/JNyhWiTw
	 S9u/ExCDAxIWZT+hm6YdFQpZWSjDvB0MFo5KJjkKrUFr/3QQFXyRUfMAkjInhOadSl
	 hlWKamENlU4qA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5238b5c080cso2052304e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 00:18:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWG4hXmBvbl4H4tLwcxIk0bL96to93mTwHJua8mQZRbFiRbP5n3ck9EjTKOf1tgey4wv0UI/68EDARE8QeVQP081NEi+RyVD6+H49qq
X-Gm-Message-State: AOJu0YwefDlbYXYzbBkLA+ZRauFxChm3M9l46KfJZdX8zoF+vAzlL6LI
	MOWCg3/PzRXV2OM2WdXC1U/KOCMCulzxgYGlBRwb5d5mNWbqbqxG70cW7Dy/qqDiv1FHeizCg4Z
	0AtWX3iEQOrXll5sV7EW8nh3qeFA=
X-Google-Smtp-Source: AGHT+IFoKVrHXL5i82YPHFqG19q8TzoC6MKvE/Z0zHmcm+jFnk24R1cKbLMVOU3erGRbR2hs/9de1ovPH/R23sn0Plo=
X-Received: by 2002:a05:6512:138e:b0:520:5261:9cd0 with SMTP id
 2adb3069b0e04-5221006cc86mr16065884e87.57.1715930323144; Fri, 17 May 2024
 00:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204122003.53795-1-masahiroy@kernel.org> <CAK7LNASH+vfoXhTtPWqwHYgkhUaLfemB+xPfo=SM-rbg2rrhnQ@mail.gmail.com>
In-Reply-To: <CAK7LNASH+vfoXhTtPWqwHYgkhUaLfemB+xPfo=SM-rbg2rrhnQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 17 May 2024 16:18:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQSz30kShL1y+FQQa5DdyS=X=HmrfOz7VZSNmYwTE1iw@mail.gmail.com>
Message-ID: <CAK7LNAQQSz30kShL1y+FQQa5DdyS=X=HmrfOz7VZSNmYwTE1iw@mail.gmail.com>
Subject: Re: [PATCH] x86: select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
To: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, x86 maintainers


Please check this.


And, please also note the current code is incorrect,
and it may get broken with future Kconfig refactoring.





On Thu, Mar 21, 2024 at 12:30=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Ping?
>
>
> On Sun, Feb 4, 2024 at 9:20=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > It took me some time to understand the purpose of the tricky code at
> > the end of arch/x86/Kconfig.debug.
> >
> > Without it, the following would be shown:
> >
> >   WARNING: unmet direct dependencies detected for FRAME_POINTER
> >
> > because commit 81d387190039 ("x86/kconfig: Consolidate unwinders into
> > multiple choice selection") removed 'select ARCH_WANT_FRAME_POINTERS'.
> >
> > The correct and more straightforward approach should have been to move
> > it where 'select FRAME_POINTER' is located.
> >
> > Several architectures properly handle the conditional selection of
> > ARCH_WANT_FRAME_POINTERS. For example, 'config UNWINDER_FRAME_POINTER'
> > in arch/arm/Kconfig.debug.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/x86/Kconfig.debug | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> > index c5d614d28a75..74777a97e394 100644
> > --- a/arch/x86/Kconfig.debug
> > +++ b/arch/x86/Kconfig.debug
> > @@ -248,6 +248,7 @@ config UNWINDER_ORC
> >
> >  config UNWINDER_FRAME_POINTER
> >         bool "Frame pointer unwinder"
> > +       select ARCH_WANT_FRAME_POINTERS
> >         select FRAME_POINTER
> >         help
> >           This option enables the frame pointer unwinder for unwinding =
kernel
> > @@ -271,7 +272,3 @@ config UNWINDER_GUESS
> >           overhead.
> >
> >  endchoice
> > -
> > -config FRAME_POINTER
> > -       depends on !UNWINDER_ORC && !UNWINDER_GUESS
> > -       bool
> > --
> > 2.40.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--
Best Regards
Masahiro Yamada

