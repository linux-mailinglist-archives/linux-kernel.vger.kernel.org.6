Return-Path: <linux-kernel+bounces-355751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C5995680
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B91283351
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290D8212F04;
	Tue,  8 Oct 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0FdY2cnm"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33BE212D3D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411937; cv=none; b=HfO8QQRfsCTeeiX9KLhiywtz07xsb6KBSU70RcgwQVHpCF396cxhef5EJ4PpJZK5F6UbOqrqIl6mggBWZOgyqUnD39bZL11+RXU8o1nYeV3chFuYcpMPcRtveoNWXHLqolBxVLT6pcsJgPPzuwIRNXereE0zn9qL+WM6E01Gbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411937; c=relaxed/simple;
	bh=hOXbxmxGL9RjWcZWCgTZ0kljKWaTMIJz6LF9nZkfKgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7x3FfWedKLQd25XXJPQwoogQwf9zLia2Q6DrilLA/HeLLSI7ga+Ch7QsPEF0nVp2rL1CiIev1OkxmWgb2BLuuTvw335nuKF85zrUMhopl1IpToQh73U3+e9R8XgxfsNHWwnS+xX+VF1/6NxfQBEQlaSmkec6TwEJUejDt3tRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0FdY2cnm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae4ead5bso34345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728411934; x=1729016734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9+qQfvvXgyE3lbO6k8qawt8v4FfcA1COjzGEqqIH8M=;
        b=0FdY2cnmeqPVl0D3RZk2Fi5NOuT5VbVbt6FFc4E7IIABhaStx0cTGGqCKXYuF+Ovgs
         xdjYgeNQU88HEvcZsakEaFJBFvJzPpzKFaGxlurZv3AnU2uWJxOy9Hat5KAn901PoDLb
         vNW9M0k4tnNlYaM5KWxwkvzPKD5U/QJOrgVa9tH7oGbhduRN6PDRG4BZ1O9DfQRybc8l
         AnupCspSoMt477hLnoa/46Bsj2gtQ3kJXnbsyesp1NF9mg6jV8ZS0UsIIz/B34+LMz0Z
         cGdxXY0gvCNYwGPXkRbgg1DH/+s+qeLK/miO7uFiyw//yKvzhE1M3YGnJi7vhXVZpJl/
         1hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411934; x=1729016734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9+qQfvvXgyE3lbO6k8qawt8v4FfcA1COjzGEqqIH8M=;
        b=VddM5LQpZ7MKgZrRu40vO6FcZHbPOgyE6uWkKFDNDzXZVX2CGnrHWuxWcjwXRfEe3i
         xOOtipemIAteYDqs9BW8MQ8Z09Kix4isSRkb1Iohq6h8v78weKfjbKv60WGGC6pX65fs
         gFUY2/WBGEtARLIalVAXBU0ocVdzJ/SNzrGqiSJ17wgxcwMwRIJxmUZU/eSHpNBd5efl
         Zau0+6COC60mtRnQRWe9VGyFOWhyAZcS0IBv5LjZ29WrGxSBNgkyL6lJxTjg/CBxY2zm
         /vMkmvcMapzvE/sn5rC5paWTO1GeesGVbdirlvEZScY76bwJvbfyshFvcCkd6uGHD1Tf
         OkvA==
X-Forwarded-Encrypted: i=1; AJvYcCWFnCz289Gtvbgsm7y7Yym0sV0++0Y1bixwGl61RjqT4rfz5735+UfmUa56NHTM1bTtTpaS+ab2arOjGXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWI3k44dxqeQJz4lAFZEm6f0rd6iYrnEztsaigCSyJw5uDslvK
	fmznCEtYdimLG7XW0XltgC6Nn+17dHpM6kKW7wdNxXgvkIJweYWODuWNJoacGITzUgtWmlguI5R
	A8gb7uEFZX39XRX5OF+tAXeIDPXynwJKpWuCY
X-Google-Smtp-Source: AGHT+IHAssweWZAY+6Z2ceMdPdwwXkz/meoe1Yl5qmMTx3Ojc57hVUGpsCH+wADKon600alISzrnsmRVOkEfwYW3jWI=
X-Received: by 2002:a05:600c:c07:b0:42c:acd7:b59b with SMTP id
 5b1f17b1804b1-43058d74771mr362955e9.6.1728411933766; Tue, 08 Oct 2024
 11:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rustc-option-bootstrap-v2-1-e6e155b8f9f3@google.com> <CAGSQo02oVWxazut2nyh-9K9gK+937zKCfYMBkT4EQE2CddvZtg@mail.gmail.com>
In-Reply-To: <CAGSQo02oVWxazut2nyh-9K9gK+937zKCfYMBkT4EQE2CddvZtg@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 8 Oct 2024 11:25:21 -0700
Message-ID: <CAGSQo01FErmGbeu-+_kRfpQrO4xkaGuSo_zAXTmGHZuFVYXpNw@mail.gmail.com>
Subject: Re: [PATCH v2] Kbuild: fix issues with rustc-option
To: Alice Ryhl <aliceryhl@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Err, slight amendment - I think you want `-o $$TMP`, and not
`--out-dir $$TMPOUT`

You definitely don't want `--out-dir $$TMP`, but the other two
settings above would be defensible.


On Tue, Oct 8, 2024 at 10:43=E2=80=AFAM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Thanks for catching this - I had a specialized toolchain enabled which
> didn't exercise the `RUSTC_BOOTSTRAP` issue, and without an unexpected
> failure, didn't see the `--out-dir` flag conflict after I got the
> request to add it.
>
> Reviewed-By: Matthew Maurer <mmaurer@google.com>
>
>
> On Tue, Oct 8, 2024 at 10:32=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Fix a few different compiler errors that cause rustc-option to give
> > wrong results.
> >
> > If KBUILD_RUSTFLAGS or the flags being tested contain any -Z flags, the=
n
> > the error below is generated. The RUSTC_BOOTSTRAP environment variable
> > is added to fix this error.
> >
> >         error: the option `Z` is only accepted on the nightly compiler
> >         help: consider switching to a nightly toolchain: `rustup defaul=
t nightly`
> >         note: selecting a toolchain with `+toolchain` arguments require=
 a rustup proxy;
> >               see <https://rust-lang.github.io/rustup/concepts/index.ht=
ml>
> >         note: for more information about Rust's stability policy, see
> >               <https://doc.rust-lang.org/book/appendix-07-nightly-rust.=
html#unstable-features>
> >         error: 1 nightly option were parsed
> >
> > The probe may also fail incorrectly with the below error message. To fi=
x
> > it, the /dev/null argument is replaced with a new rust/probe.rs file
> > that doesn't need even the core part of the standard library.
> >
> > error[E0463]: can't find crate for `std`
> >   |
> >   =3D note: the `aarch64-unknown-none` target may not be installed
> >   =3D help: consider downloading the target with `rustup target add aar=
ch64-unknown-none`
> >   =3D help: consider building the standard library from source with `ca=
rgo build -Zbuild-std`
> >
> > The -o and --out-dir parameters are altered to fix this warning:
> >
> >         warning: ignoring --out-dir flag due to -o flag
> >
> > I verified that the Kconfig version of rustc-option doesn't have the
> > same issues.
> >
> > Fixes: c42297438aee ("kbuild: rust: Define probing macros for rustc")
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Changes in v2:
> > - Add `export` to RUSTC_BOOTSTRAP.
> > - Fix error about core being missing.
> > - Fix warning about -o flag.
> > - Link to v1: https://lore.kernel.org/r/20241008-rustc-option-bootstrap=
-v1-1-9eb06261d4f7@google.com
> > ---
> >  rust/probe.rs             | 7 +++++++
> >  scripts/Makefile.compiler | 5 +++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/probe.rs b/rust/probe.rs
> > new file mode 100644
> > index 000000000000..bf024e394408
> > --- /dev/null
> > +++ b/rust/probe.rs
> > @@ -0,0 +1,7 @@
> > +//! Nearly empty file passed to rustc-option by Make.
> > +//!
> > +//! The no_core attribute is needed because rustc-option otherwise fai=
ls due to
> > +//! not being able to find the core part of the standard library.
> > +
> > +#![feature(no_core)]
> > +#![no_core]
> > diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> > index 057305eae85c..08d5b7177ea8 100644
> > --- a/scripts/Makefile.compiler
> > +++ b/scripts/Makefile.compiler
> > @@ -21,6 +21,7 @@ TMPOUT =3D $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD=
_EXTMOD))/).tmp_$$$$
> >  # automatically cleaned up.
> >  try-run =3D $(shell set -e;              \
> >         TMP=3D$(TMPOUT)/tmp;              \
> > +       export RUSTC_BOOTSTRAP=3D1;       \
> >         trap "rm -rf $(TMPOUT)" EXIT;   \
> >         mkdir -p $(TMPOUT);             \
> >         if ($(1)) >/dev/null 2>&1;      \
> > @@ -76,7 +77,7 @@ ld-option =3D $(call try-run, $(LD) $(KBUILD_LDFLAGS)=
 $(1) -v,$(1),$(2),$(3))
> >  # __rustc-option
> >  # Usage: MY_RUSTFLAGS +=3D $(call __rustc-option,$(RUSTC),$(MY_RUSTFLA=
GS),-Cinstrument-coverage,-Zinstrument-coverage)
> >  __rustc-option =3D $(call try-run,\
> > -       $(1) $(2) $(3) --crate-type=3Drlib /dev/null --out-dir=3D$$TMPO=
UT -o "$$TMP",$(3),$(4))
> > +       $(1) $(2) $(3) --crate-type=3Drlib $(srctree)/rust/probe.rs --o=
ut-dir=3D$$TMP,$(3),$(4))
> >
> >  # rustc-option
> >  # Usage: rustflags-y +=3D $(call rustc-option,-Cinstrument-coverage,-Z=
instrument-coverage)
> > @@ -86,4 +87,4 @@ rustc-option =3D $(call __rustc-option, $(RUSTC),\
> >  # rustc-option-yn
> >  # Usage: flag :=3D $(call rustc-option-yn,-Cinstrument-coverage)
> >  rustc-option-yn =3D $(call try-run,\
> > -       $(RUSTC) $(KBUILD_RUSTFLAGS) $(1) --crate-type=3Drlib /dev/null=
 --out-dir=3D$$TMPOUT -o "$$TMP",y,n)
> > +       $(RUSTC) $(KBUILD_RUSTFLAGS) $(1) --crate-type=3Drlib $(srctree=
)/rust/probe.rs --out-dir=3D$$TMP,y,n)
> >
> > ---
> > base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> > change-id: 20241008-rustc-option-bootstrap-607e5bf3114c
> >
> > Best regards,
> > --
> > Alice Ryhl <aliceryhl@google.com>
> >

