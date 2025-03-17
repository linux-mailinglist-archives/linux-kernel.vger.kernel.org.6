Return-Path: <linux-kernel+bounces-564832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF39A65B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB66A7A7AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFDB1B0F30;
	Mon, 17 Mar 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcjn2eXd"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4E1AD403;
	Mon, 17 Mar 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233975; cv=none; b=IWh5C+v407743+fURaGEl5tqrwTSe99YWNRv+wAE7jPkEVXvWc68925SrX1ekjQXMVAjB43sblK7hQc3o2RJ0bC85yznqdx6b1eHinzL4UflLZWXMdWQyVPU6g3ikMUEkLcb7t0+41Dh3QuwCaUwncJD+hcIluo6kSiFEDr/5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233975; c=relaxed/simple;
	bh=zl/nX8wj3yLCj3xnxXmmvs7Nrgt8lnuIVxCL59pWZuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XImEbzMqPmnzg56QZoTg0wDhr27mdhLTl9VPXYDmN07NQGMRE9yIN08cKQqJuRtitvfh7HKlB9XUlrqLj2oW8zQD8PpDJ+3k7nGcx0ZrCz2xFWuy79lj2EI8MBXPWZj5CHNeoMpppnF7tlg2qjg59WThYb3pbZzcJ8JvelthiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcjn2eXd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a6bso53133361fa.1;
        Mon, 17 Mar 2025 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233972; x=1742838772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5thfR2ajzXn32xUhJ9gHgw/bHdU8lF5FnexVFpisXE=;
        b=bcjn2eXdR9jIKK7Bcblc9TEiyj0Dr+gwzgtGsITBHqQ+TopdPz1ttvdM+vOkSovwle
         SWySpa7nkKqlIakjscAqDpwy5oJ1q+YWR6ap4LkM5X4l9nNFqFdakC6DT1C+h2Z7VhUz
         eXuJOGtBhNJXZsqVYZ09vxG9L6KZsSow9gH0I0MdBVmS6/DuJGKAZvZpzAzAnuP4WmNk
         8en/VsayZe9V8oNmO2YsnOGtyzNl9hQl+z8gL9BDZt8mFNcu6QWLt+ANTkTpxRTQnNoA
         LjFPLoWsjFXzLm/bS9TuMU0ngmFormNhYkIN3wsiIJ/uHxE/b8gQZ6J0hc6oXRL3EWqH
         Y0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233972; x=1742838772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5thfR2ajzXn32xUhJ9gHgw/bHdU8lF5FnexVFpisXE=;
        b=kcIdI4BpoYRJ50XCQtzbmm9WHW9YDSUnV9XZauXxbq3bRTqG8sDruwzznb/zv7f/LP
         I50SFHWveNgvN8D7IYlOW0l9rs6DWRgzQSNx4ynVz8/lZxkZHMljDjM/gyNww3Um8BQh
         9yDz2cEQVZ0aysmbsK6LGwKYtQw1njg+AMgGKNUNLn/NA7xbuoHwzO4ek4ULTf7FLcLk
         k321FDoFzWycYxtf/vua/WPgGeEownYjC+Qf+Xva4VKEbvasuTj8/MXgGUyHPwjuR5vP
         SyPbFOtB5xoxIyT86ODL717Kla8ai+9pTM/GGXb3o5GjC1QCfb+fljA0+WsspuyCRjxK
         zoZA==
X-Forwarded-Encrypted: i=1; AJvYcCUUDm0UW4tKXMnXia3LnMwrSYdAjjTzDLY6Jg8QKASXloUG+DYfUQoH9CG+G+/7j5CaqlLv+u/4gyjcJbs=@vger.kernel.org, AJvYcCVHJoXUyD92FQ6cl17CUyHt4JXhI5RmW0D1Ri4Ao9i8k5Qfuqic/VDTSLBdCNHhM0uOHSdSf36rGRhqQ4zB6tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dO9pR4NssQEj3d9IX4JRdVR0AL22k3uGBJsm430n6UC6Bg1e
	nw5GIZNDrjxhHOwtM31pCUy23SYiwDS36tqAH0xMseyXqzR2MxV16bsCxsvs+PHMf7GNSwZfNp6
	G9zcK6hHlFqIrsPDss+ttntgk1eg=
X-Gm-Gg: ASbGnctW6jUE1RMdpn1VoaBxQC6GY61yIVdKDbJBqeDkqzZQUppxi+T6RPmjp25Kxxa
	X6LYaxvS9Inm83b4z4LCMkKvn5WtpQzgxm4o4KHns8l1MY5iRb5+Wc+QCgslFOzBFNM4QdggFwR
	EpVkxce2NL73x8AjP1lIruu138HlnwlyO0dDuRmLGLxu0sTW8d6TZtr/XIQ19t
X-Google-Smtp-Source: AGHT+IEVurWRQByJ+jwpbSCBHSHIUFCLmbx852SJppmpGLil+MdtcsJIaRBBFH46mVtuOsJBn41cnzB9uh2ULeFSHQQ=
X-Received: by 2002:a05:651c:b12:b0:30b:ba06:b6f9 with SMTP id
 38308e7fff4ca-30c4a8cb5dbmr91075781fa.26.1742233971998; Mon, 17 Mar 2025
 10:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-vec-push-use-spare-v2-1-5dc6583f732c@gmail.com> <D8IQ6GO56119.2JBP30MJWUK6Z@proton.me>
In-Reply-To: <D8IQ6GO56119.2JBP30MJWUK6Z@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 13:52:15 -0400
X-Gm-Features: AQ5f1JoNgxfJW1Kv1LL2mWZklUT1usJmmUiP35voBmcB8Wywblkhumy-vtjFzlQ
Message-ID: <CAJ-ks9ks+-=rEUBw59LBg2EWieSejC8hvqeux3fwzRNSyMpO1w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: alloc: use `spare_capacity_mut` to reduce unsafe
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:42=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Mon Mar 17, 2025 at 6:23 PM CET, Tamir Duberstein wrote:
> > Use `spare_capacity_mut` in the implementation of `push` to reduce the
> > use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("rust:
> > alloc: implement kernel `Vec` type").
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> One nit below, with or without that fixed:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> > ---
> > Changes in v2:
> > - Use `slice::get_unchecked_mut` to ensure we avoid a bounds check.
> >   (Benno Lossin)
> > - Link to v1: https://lore.kernel.org/r/20250317-vec-push-use-spare-v1-=
1-7e025ef4ae14@gmail.com
> > ---
> >  rust/kernel/alloc/kvec.rs | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index ae9d072741ce..b91b287e0d22 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut [Mayb=
eUninit<T>] {
> >      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocErro=
r> {
> >          self.reserve(1, flags)?;
> >
> > -        // SAFETY:
> > -        // - `self.len` is smaller than `self.capacity` and hence, the=
 resulting pointer is
> > -        //   guaranteed to be part of the same allocated object.
> > -        // - `self.len` can not overflow `isize`.
> > -        let ptr =3D unsafe { self.as_mut_ptr().add(self.len) };
> > -
> > -        // SAFETY:
> > -        // - `ptr` is properly aligned and valid for writes.
> > -        unsafe { core::ptr::write(ptr, v) };
> > +        // SAFETY: The call to `reserve` was successful so the spare c=
apacity is at least 1.
> > +        unsafe { self.spare_capacity_mut().get_unchecked_mut(0) }.writ=
e(v);
>
> IMO it's difficult to tell which operation is the `unsafe` one here, so
> how about you factor the `spare_capacity_mut` call out.

=F0=9F=91=8D

