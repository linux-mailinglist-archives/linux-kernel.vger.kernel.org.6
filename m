Return-Path: <linux-kernel+bounces-536271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75AA47D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA8E1896BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB7F22E406;
	Thu, 27 Feb 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFVha0SR"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2522DF9E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658799; cv=none; b=kgeZwx+F/hCYgCGjuxMzz/FtfheHbpa9rxmnBoWAhF1UMCt/Ir9JbDWYKfCBmBNdRoKp9T131eYijrq8uVq+HPDst47SnoYb/4AdZo5o+KcaEfGCF2zGuCRdkPzYW1hU0xx8JSoADotrQshXeEwe3uehXS8rgVWuZwpfKdfARcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658799; c=relaxed/simple;
	bh=u7MGhynBrW4XzL2BBEX+Qn/6dYTwxzMNVdpH0lUcAp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URBBcX1LQSbYxBs7vy/GOlb/U5T8CoqRWh0gRogAHw+SH2iodljG9xhlj/j18EdjDnO1qaYHmHUavuJlr1QhTWnwLxA2gXIR28ReQZv3RQAxMRcUgLsekKI4GMF6eQ8A6WM8uEqcQlAhCcuQnnLHnq6biX5ArttT2p5JHQ77V3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFVha0SR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390df0138beso469675f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740658795; x=1741263595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4K8UiwVopP53xOklWDCrKpSnqZT0eqEWjR2XgfhARY=;
        b=oFVha0SRj1OPMM2EymezsVg/qqoXpdUY9WNMdBVAw9ZMuoLTFlVO+IqK8fUvajsZOR
         b5Ay7Rnc361j2hTPlnN4kPyKC5kZ3XIQZh3I4deWOVuVpdmiff8U5Y6ewUuveK/vmD3j
         ba4aKtrQy9qmt2F1HUIX1b2Kv8TIGOU58MNeDbMJFiNbE4a8VvJZAaaV+H9Sh0rfUTEQ
         jyV0OQnkMWXQEuMrunjL8ZL+aHD1aGE16TYgf9xD0etfoN7nPh8Cd+MLeBW2/37zNmYJ
         HatvnrDEpSf6yqJhs7oMcQjuhOlLDnPvEqovwxiUS5KxtlNor0xbeh5/bpp4dFX8MrT7
         hX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658795; x=1741263595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4K8UiwVopP53xOklWDCrKpSnqZT0eqEWjR2XgfhARY=;
        b=FQ9ZxPV084nn/psSwbO5v3aVHdmS4WXU8Ds0DTKxnI4jwEF9UcyZvD4r48pbIT5bWh
         RfAAogL6NFSmcQ8RTeOH6SODjBHCbQUm5NzOldPy9VXGk2IIFEKHtKi1HrW20/JnwbG3
         6PoTeMMUiZ17USXSq9rhLGFeYvBu+bgJklCQ499dD/6ruBhsvle7L+wvmwb2SSPemu9F
         518EerxQBWEBJ+If2Ju5xqc12K6fiuMYMt+zNVS6J2iQzFtbve671qKT21jpRYfR6VMY
         BjfGTh07YfG1vi4sGsBYsM8P7O4D97BWPutV5fqnBf6oCap8yrthfhfAmOzLZAWvLutp
         5utA==
X-Forwarded-Encrypted: i=1; AJvYcCWE53Dw+lzS+PI6GjOJDpixow35zmfrKKHcu9sm1shsZMRsPjfM/iCOWDEtMQYR8Hwf5xdwlz+BqbsGYvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5Y4/e6/6yUcMsXOc2w3aQGxE/o9N1emrMQQBkFj/zj6bZ3oC
	3QKKJ67XxgRQO8CTshXuA9oNexb6DPJpkP0inEMzI1fyPKGEV1+j3zJN8q3kcAEoTMKu4TXIUc2
	WfieDUzKsn41eEyTdAlPDZuOyyB3WSLPtbrO+
X-Gm-Gg: ASbGncuMDv8G/nMG9/jYF5ReD2a+yJRG8fe0/3FSfKs+IrQdumiQzXvpOPVNfqzKVzk
	/qdbuAKbejQ1HvujOQFu6pBRzTVM3Jd8eosYI9BTzBu+utHwjEcKYGqmmjTGKBJwE+6lHfLtkcj
	HShVxYUlH3stnD2Rs5+HTmZsIPNCQ2Fe5GPscnuw==
X-Google-Smtp-Source: AGHT+IEKZwk8Kq2mq+sCggG9tt199/S5gDLDG+iTeZ1Eo+AMAi7QqJSIE9qQ+X+XF1Rpkj8qlzEAsa7zDuZuHXBR2wQ=
X-Received: by 2002:a5d:5985:0:b0:38f:3ee5:fd36 with SMTP id
 ffacd0b85a97d-38f6f0af903mr23070702f8f.53.1740658795362; Thu, 27 Feb 2025
 04:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLggyEXyyaFNnmBCPOSX051TiFyAp0B8GfahbPg=+LrtUWA@mail.gmail.com>
 <20250225180223.763026-1-aliceryhl@google.com> <20250227104640.sa6vqdz7j5hwjigs@vireshk-i7>
In-Reply-To: <20250227104640.sa6vqdz7j5hwjigs@vireshk-i7>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Feb 2025 13:19:43 +0100
X-Gm-Features: AQ5f1JqWf30os7GawawS5Uk4aefwZr9l8Qmlesu4YIZqX8gdGJlMfcQv-exzF4E
Message-ID: <CAH5fLgg8PvCEEks81Dy_3eRBkVG4P0a7usB2cfP2pbcSw495FA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@redhat.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	vincent.guittot@linaro.org, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:46=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 25-02-25, 18:02, Alice Ryhl wrote:
> > diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> > +/// This corresponds to the C type alias `cpumask_var_t`.
> > +pub struct CpumaskBox {
> > +    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> > +    ptr: NonNull<Cpumask>,
> > +    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> > +    mask: Cpumask,
> > +}
> >
> > +impl CpumaskBox {
> > +    pub fn new(_flags: Flags) -> Result<Self, AllocError> {
> > +        Ok(Self {
> > +            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> > +            ptr: {
> > +                let mut ptr: *mut bindings::cpumask =3D ptr::null_mut(=
);
> > +                unsafe { bindings::zalloc_cpumask_var(&mut ptr, _flags=
.as_raw()) };
> > +                NonNull::new(ptr.cast()).ok_or(AllocError)?
> > +            },
> >              #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> > -            // SAFETY: The pointer was earlier initialized from the re=
sult of `KBox::into_raw()`.
> > -            unsafe {
> > -                drop(KBox::from_raw(self.ptr))
> > -            };
> > -        }
> > +            mask: unsafe { core::mem::zeroed() },
>
> This will work correctly, yes, but I wasn't sure if the Rust code
> should do this or depend on the C API and call zalloc_cpumask_var().
> The implementation of struct cpumask allows this to work right now,
> but any change where some internal state management is done, for
> example, within the structure may break the Rust side.
>
> I am okay with this way of doing it if that looks okay to you.
>
> I have made following changes over your diff.
>
> Thanks for your help in simplifying the code.
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> index f82dafbc4e61..d56f7dc9d762 100644
> --- a/rust/kernel/cpumask.rs
> +++ b/rust/kernel/cpumask.rs
> @@ -13,20 +13,28 @@
>  #[cfg(CONFIG_CPUMASK_OFFSTACK)]
>  use core::ptr::{self, NonNull};
>
> +#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +use core::mem::MaybeUninit;
> +
> +use core::ops::{Deref, DerefMut};
> +
>  /// This corresponds to the C type `struct cpumask`.
>  #[repr(transparent)]
> -pub struct Cpumask {
> -    mask: Opaque<bindings::cpumask>,
> -}
> +pub struct Cpumask(Opaque<bindings::cpumask>);
>
>  impl Cpumask {
> -    /// Creates a reference to an existing `struct cpumask` pointer.
> +    /// Creates a mutable reference to an existing `struct cpumask` poin=
ter.
>      ///
>      /// # Safety
>      ///
>      /// The caller must ensure that `ptr` is valid for writing and remai=
ns valid for the lifetime
>      /// of the returned reference.
> -    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask) -> &'a m=
ut Self {
> +    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask_var_t) ->=
 &'a mut Self {

Why?

Perhaps put this on the CpumaskBox and keep the `struct cpumask` one here?

Alice

