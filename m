Return-Path: <linux-kernel+bounces-430349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E727B9E2FCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FF028344C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05E1E1027;
	Tue,  3 Dec 2024 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5GZLFX+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96F202F84
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268397; cv=none; b=to5p76rPncoEG4FghpPqfl9TthdSxSoYlmrXWqYnolKl399jGlTYjSCnpZTi1C7jSjqVQ2xvqHR24O0j635Y6skgph2MmZH6mfCVjqZOHe8LrwPb8nQKjlCbHR+0MSUbo7JER6bx/JNPQIni1qhckLzjDqLly+jZiR6W3QMWmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268397; c=relaxed/simple;
	bh=A+NygRxfATzmDDYl4BW+aoTxyFsALc+e05mYyvBpsWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0ySQeUEsVOzWMcQa926KwzxD9jyWx679hob5r0IrT1hiRdnO2pRSCr//syIL823yN2U7+MSWTlmOSt1zbD/dFHug9e8qUtFniDW/JFZOLNkxepHsCVkRW5+T3Xbm8DqKX68Fe2YDOiECxN6WZZXzuUe4NiafThaDFPP9qufb0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5GZLFX+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0c098c870so555912a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 15:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733268393; x=1733873193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0gsOOV1IK0tbYsC9eBpU6WfUiWf0dqVzzhWYdaHF04=;
        b=g5GZLFX+dNpdx1YYUJf5LjvBATqDc4vNwiLsd5Vg5f/Q0v1vpIo5LbOagutF6tWpuq
         6YPnniNdcTWkE0F9Pvnvrnyoz9rQRpLflynsw2tat7MCaNvjdvbRURLlw6ilPDuWJGjM
         jwltgiwduh6ZCo5qqzKW6ZY9o5YAhNmfK1NZ7+gO96u9qTwIAKxCwQT3n6BFbosUl7NU
         KJy+Azpyyugs2JXMN6hZZfh1JmHZOlJqSATah+9PVo8y6wgRdTm6n6ssGamQGnEs+vHT
         4lOi6RHdVh+hafoWNSS7MvnG4IuACOc9ad8h6t6tXTl5T+0V+0QY0DDdQXw4VU8auBjZ
         kqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268393; x=1733873193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0gsOOV1IK0tbYsC9eBpU6WfUiWf0dqVzzhWYdaHF04=;
        b=b06FKo6HBYT7fdMPaOhs3Cwb1hhO/09urCI/57M9K6920HDEVy/9BY2fzaVOxLOrqQ
         ig4jP5J23eb9ETu11cY07s1NTAE0Q4ZbpnUCanctbXhK96H1UUy6CgmGmK8uzMF0+1t5
         3aQcnKOvX8/BF/boSDvV4g5qXbyTj1H6gDimVuiTnay54PvsyvcGtXm6I7p45KH794t0
         Rp6gBgCmqCdgAYgxdEOsQ8AcljGHzQ0gjJ/6/MVlCBP8XvfTHPtIez/8e8wNR77973DI
         f4e0Qig0Sm5g4spPQiJT6HVSz6XsMkZ9L8XU7x0WmIsQFBeTqiGGrab6NkEWZHv+1MSl
         qm2w==
X-Forwarded-Encrypted: i=1; AJvYcCXihTRodQ8XN30/NpE2/JvRK0FRhJFOmK2c2ZpUblR47XurYu2W57vOj7ytgFHb/NEvjNaX2hRBTDLe3TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymT+LLQMRyLw1tlgNz44Ku8f5Q+DKzphPqGbrI/U7aCBhfkrZo
	abCoLBNjdz2FLP6lBTO8rptelbDD3j1b8eEXiYK840unaad1vZ7mSaoeEc56MdmH9u7V6YxSasJ
	Nws+Ug7tE3W0AarU79Z7DqNKNcvhSlo0Cy9yV
X-Gm-Gg: ASbGncsbFvaJFgJqni513Vymvb/vDRc+zMVqUWv+d6iBX01NIdSiFg080G85ub4djP1
	gbaWubv5SCipxgs63Ih3Bjx3FjuVSAMuORcvDYQafJuGJw3OT+0xnGtY773b57EJB
X-Google-Smtp-Source: AGHT+IG44HltO60JYgYmVvMEo3QlcFo1P0mYiAAGDSp4Skz4zAxbxt9ZfqfNSvUY79c414MNywqlUX98rVVFvuuFn2Y=
X-Received: by 2002:a05:6402:1d49:b0:5d0:e9a8:4c96 with SMTP id
 4fb4d7f45d1cf-5d10c2498d8mr3918350a12.9.1733268392481; Tue, 03 Dec 2024
 15:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112184455.855133-1-ojeda@kernel.org> <CAH5fLghFZTG2X_mYE2yGJwPM31NrJdkA-cpZTCYsdghR8YdY8Q@mail.gmail.com>
In-Reply-To: <CAH5fLghFZTG2X_mYE2yGJwPM31NrJdkA-cpZTCYsdghR8YdY8Q@mail.gmail.com>
From: "Hong, Yifan" <elsk@google.com>
Date: Tue, 3 Dec 2024 15:25:56 -0800
Message-ID: <CAABy=s1sEzJZBR6Mt+ujFY_SSbU_OgKDtOs0+bxXQhTo9QZtGA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: rust: add PROCMACROLDFLAGS
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Nov 12, 2024 at 7:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> w=
rote:
> >
> > From: HONG Yifan <elsk@google.com>
> >
> > These are flags to be passed when linking proc macros for the Rust
> > toolchain. If unset, it defaults to $(KBUILD_HOSTLDFLAGS).
> >
> > This is needed because the list of flags to link hostprogs is not
> > necessarily the same as the list of flags used to link libmacros.so.
> > When we build proc macros, we need the latter, not the former (e.g. whe=
n
> > using a Rust compiler binary linked to a different C library than host
> > programs).
> >
> > To distinguish between the two, introduce this new variable to stand
> > out from KBUILD_HOSTLDFLAGS used to link other host progs.
> >
> > Signed-off-by: HONG Yifan <elsk@google.com>
> > Link: https://lore.kernel.org/r/20241017210430.2401398-2-elsk@google.co=
m
> > [ v3:
> >
> >   - `export`ed the variable. Otherwise it would not be visible in
> >     `rust/Makefile`.
>
> Despite the missing export, the previous version worked for us too.
> I'm not sure why that is.

It happened to pass the build when KBUILD_HOSTLDFLAGS was empty, which
was the case when it was not exported. But that was definitely not the
original intention of this patch. Thanks for catching it! I have
verified that v3 correctly exports the variable to sub-make and still
works for our case.

>
> >   - Removed "additional" from the documentation and commit message,
> >     since this actually replaces the other flags, unlike other cases.
> >
> >   - Added example of use case to documentation and commit message.
> >     Thanks Alice for the details on what Google needs!
> >
> >   - Instead of `HOSTLDFLAGS`, used `KBUILD_HOSTLDFLAGS` as the fallback
> >     to preserve the previous behavior as much as possible, as discussed
> >     with Alice/Yifan. Thus moved the variable down too (currently we
> >     do not modify `KBUILD_HOSTLDFLAGS` elsewhere) and avoided
> >     mentioning `HOSTLDFLAGS` directly in the documentation.
> >
> >   - Fixed documentation header formatting.
> >
> >   - Reworded slightly.
> >
> >          - Miguel ]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: HONG Yifan <elsk@google.com>

