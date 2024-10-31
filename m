Return-Path: <linux-kernel+bounces-390446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E79B7A05
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1861F246DA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC119C540;
	Thu, 31 Oct 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTdD0iKn"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF319ABC2;
	Thu, 31 Oct 2024 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375449; cv=none; b=AlpC+rPTRkdtp9fAxfu+0dLLVqWz4FR2Xd/u6fNgKKfrChT4Qi7w8t8naUA3tL3aATsKj9BuP1i6CKcssB+LYmbaEZ52vmzqvusVN8Fi4DQJDvBKie6bX9kAPYsJRyPtAUS493/YXswvZiEJcsQPZM4Nm1KQNnBzFpJVR2eUErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375449; c=relaxed/simple;
	bh=pfysqH01FD7sfcWYcL4ziD5LKo28t3lRvp6E7rfa8O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G89DXclcGaiqF0jdYm8b7vC+xYOWdRGrIJnyR+eWBuDLqFKbkNqpRrCXIMLjBhJ1opEdAUq8Qzyra76ls0oT3SqRWteb2E+apBJXxFkCFRS7d1PUBiVRHU8IQ+0oftUdXxv2i+kammoRfd+0l3dhQlZXvjxqt56KicCY8gbBSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTdD0iKn; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so7134411fa.3;
        Thu, 31 Oct 2024 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730375446; x=1730980246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Stg8oTx/JY2f4JZWsatzVnk/fAucLKtr/wHi1HEc9aQ=;
        b=mTdD0iKnUZQTTHseae4i+dElszd0uHhaiaksWQ/y5vOfNRww0lJnIbsmaa3klfwlV2
         92qlJNBEHDy+pHYhqv+u/4ITjuDeS61PpQcdJp2CamLY/wKwlHdfYtCtED+wzECQand8
         0KyqnwHqq1TFmPeZBBBvSlFBCSoKdSc3rCa30lziFn0CrP3aoCPuhmlgZOqMukCZUJxl
         uJ3M+UdP1+nCQMM2jP4yTF+XjJZVFygnIIKzONbTxRl+p1dQ6jYqCDHUyGv4R8K+toZ+
         iT1dvzCz0LAI2GpnBjd2ia+lttHI56CPR8tJIf/2pzOu+rPR15/sus6Sc8AvO8tHPyd1
         5WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730375446; x=1730980246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Stg8oTx/JY2f4JZWsatzVnk/fAucLKtr/wHi1HEc9aQ=;
        b=OOZhoIbnweSnBaHQhjTDU1W+h/bkjxItAhM9zOPic/Li9I9YBSE7KiXAd2RYiBmzzP
         VTFVs6aGLY/TarCDBPVdsb9DH6fGgM9bPZfxhwfNLDEAtVsIilV9U+dipD6pmHbbxNfN
         dpZ8gBHR06DS0dvLe41/BI1u3sLUBdryea5aMF4Mz/LJXJ9a0M6g0MfoZ0Ylgl+Nsf/z
         8uym84qMgpuEBPbzvxNdnxUQM3sST0SlO76kPDJqHbjNIdXnTKgFnNq+8w+NUhnoUgye
         THFmkCMtxKehRmn2fdB2nOvaAitiBjNj51cwl3SOCVoAdViP/5aXsKciCuDEttGX7UlR
         dJZg==
X-Forwarded-Encrypted: i=1; AJvYcCUGVJ9Yh4XXHFPOZVURppPbKnbIiNnengP58UFe91M83R0xczZNRnLBrDnI7gUC3xKLnA/J7KynbrvkT3U=@vger.kernel.org, AJvYcCUx/O62DCGAEQWioE+C7ODxUjaxsx2WQiE2mzjST0ORpqm8rXNnG7JzXnRCSr1VcsET3UO8s/3Xa53Nreq8ylI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sBSOP+hsrpDFizdORSxrUHCrRPteqs8TnHiMZswlccfI/Ex9
	q50gHKTtLDGKPlIDvqqFfckoQhV87Ir341j8FXHVofjQ3aTXIZkPd4xZ3m+7AyOM5zWbWy7fbOH
	HPD9rUC7dJdM83HyU3Wpj67HTilo=
X-Google-Smtp-Source: AGHT+IEbappliEtAC1kjvX5QtgBDeCijNrbhETiVCl7g41WopCd3cn4eta6l0lVFDsibeC4FlVBoZku3IrGpi9tqxdQ=
X-Received: by 2002:a2e:a99e:0:b0:2fb:5a7e:504c with SMTP id
 38308e7fff4ca-2fcbdfae76bmr99375731fa.13.1730375445556; Thu, 31 Oct 2024
 04:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <4Gt8heJcUIL12zJWx8G_MkgF3vZQPoFAEagztu_-UzAVBIVIx_qJn6E7bWdq3QMKQ4n3GcuXitfXwY5HMxX7KQ==@protonmail.internalid>
 <20241030-borrow-mut-v1-1-8f0ceaf78eaf@gmail.com> <87jzdopthc.fsf@kernel.org>
In-Reply-To: <87jzdopthc.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 31 Oct 2024 07:50:08 -0400
Message-ID: <CAJ-ks9=ph2ejGEyi_nS9vfA662xQS-yFFxT3t2yDkGaV9AqYGw@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: arc: use `NonNull::new_unchecked`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 4:50=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > There is no need to check (and panic on violations of) the safety
> > requirements on `ForeignOwnable` functions. Avoiding the check is
> > consistent with the implementation of `ForeignOwnable` for `Box`.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/sync/arc.rs | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index db9da352d588f65348aa7a5204abbb165b70197f..4857230bd8d410bcca97b20=
81c3ce2f617ee7921 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -337,9 +337,9 @@ fn into_foreign(self) -> *const core::ffi::c_void {
> >      }
> >
> >      unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'=
a, T> {
> > -        // By the safety requirement of this function, we know that `p=
tr` came from
> > -        // a previous call to `Arc::into_foreign`.
> > -        let inner =3D NonNull::new(ptr as *mut ArcInner<T>).unwrap();
> > +        // SAFETY: The safety requirements of this function ensure tha=
t `ptr` comes from a previous
> > +        // call to `Self::into_foreign`.
> > +        let inner =3D unsafe { NonNull::new_unchecked(ptr as _) };
>
> Please use an explicit cast.

This changes to .cast() in a subsequent patch.

>
> >
> >          // SAFETY: The safety requirements of `from_foreign` ensure th=
at the object remains alive
> >          // for the lifetime of the returned value.
> > @@ -347,10 +347,14 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_voi=
d) -> ArcBorrow<'a, T> {
> >      }
> >
> >      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> > +        // SAFETY: The safety requirements of this function ensure tha=
t `ptr` comes from a previous
> > +        // call to `Self::into_foreign`.
> > +        let inner =3D unsafe { NonNull::new_unchecked(ptr as _) };
>
> Please use an explicit cast.

This changes in a subsequent patch, here it is matching the prevailing
convention. I will restore the type ascription in v2.


>
> > +
> >          // SAFETY: By the safety requirement of this function, we know=
 that `ptr` came from
> >          // a previous call to `Arc::into_foreign`, which guarantees th=
at `ptr` is valid and
> >          // holds a reference count increment that is transferrable to =
us.
> > -        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
> > +        unsafe { Self::from_inner(inner) }
> >      }
> >  }
>
> Otherwise lgtm.
>
> Best regards,
> Andreas
>

