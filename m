Return-Path: <linux-kernel+bounces-546750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FBA4FE4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E769171052
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D8243374;
	Wed,  5 Mar 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ey7rsrGX"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BD21420F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176685; cv=none; b=qNiwRZTUNBZAkbqn9upyZzNBMNBygLjWLNNeab8KGIA0Fb6yY8Oea3SGDrwCG/NFCyU/XL129e+7oNMinPaNTzt7ZzHylDFgBXnF2SUMnIuDdhcDg+vy+xDGhInEz4mKSmfpsNMRNhxriKzoqzRZXo9QJjfJj+FpX9upLnWQPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176685; c=relaxed/simple;
	bh=AyWpiEAhCq85XVmlstpO1XyYWaX65PrZTBl50tGmiNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DItctHaby4/3g9jP/87KeWQ8h/fqpwfpubCWnPCmgrURxJEqjuMVv9VDHDhSG5/44zXyA0NJXz50LTw/BcWx9CIPLg3PZnsjvh4UT0MQaeVICyLWCFugdAJJ8Cjf3WFgGGqc3W0Mr8j425yJfs/Vq7B963mZOqBs/hI4RMAMSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ey7rsrGX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bbb440520so36811825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741176682; x=1741781482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5d5aiTtAQFVBX8jUGKIprjnYgORPGR3SfLvnW6sYlI=;
        b=Ey7rsrGX/CGgdfbACTfYSKibwmCBPsjueYJE1L4hJVVMD81xLBoQTKYG8Oup9pEiTQ
         a8btT9rwKeWJ2DsBTzobHtxcoczQa7YeOE97iI9h4HFVL9FFP+sCGiN5dR+u6ItnwQ8m
         U5RBUAZs7KVZeXrttzKq60/5ex7KMmpYII0arxiSqYSbYhxh0S6kPXsnJj11pXdHOnXk
         IBJCWs5Lfi0Eb4ifZP7hWLirT8X/pCvKLnn3o6O3G2u1RMpCs0j1YFzNXmA8gjWW91DC
         LIYfT358HC7U8FHP/qvPIJHeHNJ/IzjF4teBsM5q+qbCZvc6QUx4jemeK6jtea+9nsCQ
         o1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741176682; x=1741781482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5d5aiTtAQFVBX8jUGKIprjnYgORPGR3SfLvnW6sYlI=;
        b=DPxWZnClD6yZZhqT6WbfwS3I9FjJ1n0h3ZC1u8zXxZy+54DVKJBVMQ5ETKoZBwRU73
         3bFfD7uteWtDEj20Or9KrcqOcMdfGtOaSK6DPp9YgWrKJFlVapdy5CB7dX7hAzYTTd1U
         PNXg5uK7VL1eoLcL23tyA3F60Hrr/xRj2GD44P+wXJ3x/mlQwDah+2i+syGIhhRER5Qw
         oVfZk+lQiNaI+p0f8R0k5IwGjMWs+ZVjVDfcYsd79NT9Locotba8zqvlsqz16En1w2nl
         l5DQayplRkhMDRfaaCd89UnRUfHLN2/w7p0AIBe3z+vggVpBvng6xMaQIip96XQjsVoj
         qpUg==
X-Forwarded-Encrypted: i=1; AJvYcCUklYbriSy6ZRCOqMGEH2HXSWn2W9wSAWDG68AibVCMyYLFMm9bCxw1tWvF5W6pehUuIlY+XGLV0chxlxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMJT0kyYzWNl26ycDUB3o7Ag+puecaGEwetAxy3cCpBi+cWie
	7/YfaGIBQDtxH1BM26ZUbdsq4O3fGZ6QDVVyrq7lvSwSdFdvgcFm+mJpor9X0BOBFybzFWoo6P2
	DZj4yQnHhU2qz0CIA4Z2L+iKu7AP2btLNjA99
X-Gm-Gg: ASbGnctXgg93AFLFOo6n6X7nnnv4iWmbIpBF7vuC9seDqA71DyOVRMLW33LFVU0WNq8
	VfaxeMSTC3yzHws+Ce0NvIXLGku6mQQoUEIKYiocLIhp0VV2C4TfGCW4GnmMFgJTDx4mt35kknM
	UfvE7VyHRc/YMf43pbQ1ezidlhzDMQUtaoDQZGKc6AD5MS6X41BthFyWjC
X-Google-Smtp-Source: AGHT+IHkPJgkaLq8JWkyQ0nsfJTX4iqcZOecWU7Z5/4NOWvXjt3/oC5rhJv4MQKbDHD6eeFNbniQUl8JaSe3pqLwjaY=
X-Received: by 2002:a05:600c:3b17:b0:43b:d065:ffdc with SMTP id
 5b1f17b1804b1-43bd298f7c1mr23356095e9.18.1741176682292; Wed, 05 Mar 2025
 04:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304225245.2033120-1-benno.lossin@proton.me>
 <msi970CObD4bpxAIjK__fZnRG2q-BXd4FHuA1U1NR80D_dTqSXuQ-0-4R1TS7-7CglN6StcS3Os-IumgWcVLqw==@protonmail.internalid>
 <20250304225245.2033120-10-benno.lossin@proton.me> <87a59zen0l.fsf@kernel.org>
 <D88BHSCKZ8MO.10J627BIF6I97@proton.me>
In-Reply-To: <D88BHSCKZ8MO.10J627BIF6I97@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 5 Mar 2025 13:11:10 +0100
X-Gm-Features: AQ5f1JoVJGDFJ0HD0HBWW2rsIJoN0Rt-ftnePcLpLen_IFUFvKgTECbKrk40bwI
Message-ID: <CAH5fLghL+qzrD8KiCF1V3vf2YcC6aWySzkmaE2Zzrnh1gKj-hw@mail.gmail.com>
Subject: Re: [PATCH 09/22] rust: pin-init: move impl `Zeroable` for `Opaque`
 and `Option<KBox<T>>` into the kernel crate
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 1:05=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On Wed Mar 5, 2025 at 12:26 PM CET, Andreas Hindborg wrote:
> > "Benno Lossin" <benno.lossin@proton.me> writes:
> >
> >> In order to make pin-init a standalone crate, move kernel-specific cod=
e
> >> directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` are pa=
rt
> >> of the kernel, move their `Zeroable` implementation into the kernel
> >> crate.
> >>
> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> >> ---
> >>  rust/kernel/alloc/kbox.rs | 8 +++++++-
> >>  rust/kernel/types.rs      | 5 ++++-
> >>  rust/pin-init/src/lib.rs  | 8 +-------
> >>  3 files changed, 12 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> >> index 39a3ea7542da..9861433559dc 100644
> >> --- a/rust/kernel/alloc/kbox.rs
> >> +++ b/rust/kernel/alloc/kbox.rs
> >> @@ -15,7 +15,7 @@
> >>  use core::ptr::NonNull;
> >>  use core::result::Result;
> >>
> >> -use crate::init::{InPlaceWrite, Init, PinInit};
> >> +use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
> >>  use crate::init_ext::InPlaceInit;
> >>  use crate::types::ForeignOwnable;
> >>
> >> @@ -100,6 +100,12 @@
> >>  /// ```
> >>  pub type KVBox<T> =3D Box<T, super::allocator::KVmalloc>;
> >>
> >> +// SAFETY: All zeros is equivalent to `None` (option layout optimizat=
ion guarantee).
> >> +//
> >> +// In this case we are allowed to use `T: ?Sized`, since all zeros is=
 the `None` variant and there
> >> +// is no problem with a VTABLE pointer being null.
> >> +unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>> {=
}
> >
> > Could you elaborate the statement related to vtable pointers? How does
> > that come into play for `Option<Box<_>>`? Is it for fat pointers to
> > trait objects?
>
> Yes it is for fat pointers, if you have a `x: *mut dyn Trait`, then you
> aren't allowed to write all zeroes to `x`, because the VTABLE pointer
> (that is part of the fat pointer) is not allowed to be null.
>
> Now for `Option<Box<_>>`, this doesn't matter, as there if the normal
> pointer part of the fat pointer is all zeroes, then the VTABLE pointer
> part is considered padding bytes, as it's the `None` variant.

The standard library only guarantees that all zeros is valid for
Option<Box<T,A>> when T:Sized and A=3DGlobal.
https://doc.rust-lang.org/stable/std/option/index.html#representation

Alice

