Return-Path: <linux-kernel+bounces-522593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FB6A3CC22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACCA3BAC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0EA2586EE;
	Wed, 19 Feb 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejgEXkhM"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E01253351;
	Wed, 19 Feb 2025 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003180; cv=none; b=UMVo89/ayEWs5SZiGlSE94wLcv+/CwNiNMufruJ1rvkMt2uf5cJxOnSxn76PJ+nUTaG4Mytb+azxbpLnUHX/4mdMNASK10fVAYgYcJHck86heGy6auYrYi8cRMbYgQNNtZl5KlUA+idNA93f+bcAh1XTGh0emg0Qxllf81qj0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003180; c=relaxed/simple;
	bh=Ga8xNgv/VWLU5N1VarEyJZc6r0V+R7+woP0WCUaFIa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sh+SwpWTCvYB0Ya6vjVZ4SB1ZtR/7fw8hU7WHkAtcDXOiwVIbGRjjOT8XxlKNM97tWZUbJZErVs2om97gzeq7CxUKGbJECraZ1YZeM/cmSVdJUKshvjaA7nReTlBYdm3p8cDuor2Y6XeA5MBONuOIrzJ83wsOT2kZkGwN5ZpSWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejgEXkhM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a59so2829491fa.0;
        Wed, 19 Feb 2025 14:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740003176; x=1740607976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/baX92GLTACspGLZqgMgClkf/31ZitmF3XtIadSp+Bo=;
        b=ejgEXkhMZXWPAechJK940lzN141luxkenWtF+BPUalgoXbNpCNYNeo013xCcBOlsUm
         xliM0pRvr6wF0C6kJFX77s8k1f29RpEUib4+MFjij3yk86EZ9Jp6aGHebZXMniIhmI1z
         8K06vimWa+oNpxMn+kbsok34mJgiIUXfvA5cD4jtclL4douVKMt9JKP79Zn0VyDEBhp/
         h1luubf1SUV47+3MzUiqdNqVtYABs9qQCf13gRpjcuJNVUzaM3wfYcQ4q/znV8R0WfL1
         L48P+waS0JO8j7GXZsRZ0nsMXdEg8+5P9WcOG+I8k4qj6Pge3C1Aav0KeVf3ke2uK9Oh
         kiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003176; x=1740607976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/baX92GLTACspGLZqgMgClkf/31ZitmF3XtIadSp+Bo=;
        b=B3T+6sqIZLZ1joX23PCcANi5hQCF16NCmC04+rGlpH6JALBsas/byhaI+fIhda1RXm
         20E8P1i6bBHMvQq6ObTgYXBBZjr+1ond3o4PmB96WMAw9Itpx6F3LDVkmpza8x+2jbUU
         uzDe6R5ill/Blg/luNeggaCx0yFroWIZqQxI+hKgzRKCTcWZE3Dc2Mz8b5VWS3Ezo8C7
         g1EbXCpNpImBfWUuMgQ/IfhmA8CPXuwNQ+KZ/xmA1ck9exRqmhU8Co2vaz/Dq0oxnGVm
         eiiGKhOexybLy8u5MhA067WfvLYnXkYobDb26nFzMJsNoBkjQ/gEFoOCD+rPLtxjTg4V
         hDww==
X-Forwarded-Encrypted: i=1; AJvYcCUvk20FEhRv/ayTRICyJXbzkB3p8wd7ZVTxqouu+hG9lQSiUnMtiYZFLaMc+/m0aJ2ZQXE4WLvdQREaRRg=@vger.kernel.org, AJvYcCW+AXVu3x99vJCfivN65KIteuF50gBhynZicJnXs7MUg0yyejqB631mZISFMANRGmj+k5A9qI3hZDxA3aMNKYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4Jsbs6cEuryxk/PK7etymQK+sXlnG+j01GorKb8e/8PAd81t
	lpExoDbJ8ejaBIZJUvuW1rx93xcFmlHf3yvWzV/BVEpGrfRdglR8AVngpXI95pi0FAJn5ewwp7h
	B23PAq4myD3lJhxfRMO4OKyUmf5Y=
X-Gm-Gg: ASbGncuhE+rekrTsIxPBch7KF9m7aNuX7oLZdd2I74wLdr0bUnYJjyZ3lHE7/mJhd8i
	4aVf3x6nSXuyfOBMou3BoleYuCPQUVpUtPJ8viwP/LInTUwDsryykR4HVmXW7VUczfd+QpdxUMV
	ZAWoX5B0NkHHLU
X-Google-Smtp-Source: AGHT+IEfOqgY16e75OnK51epf5+UR2PZMTQurkYNynfgYh4ocvFnghH7jlMxXUhn+W+kXKKEPjgGOc/7XkeoVDpq1DE=
X-Received: by 2002:a2e:80d2:0:b0:300:2a29:d47c with SMTP id
 38308e7fff4ca-30a45043f8amr16787571fa.24.1740003175748; Wed, 19 Feb 2025
 14:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-2-gary@garyguo.net>
In-Reply-To: <20250219201602.1898383-2-gary@garyguo.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Feb 2025 17:12:19 -0500
X-Gm-Features: AWEUYZmElzxctdD_mVqUEh2n9ldumGYd2qmBTx-9SlS7Pp4l5UK-QA3C5Mdghy8
Message-ID: <CAJ-ks9=b5Mw1kQf3xz_VPtp4CkUhw=6xQ-543uXkFgn6wUaOcQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rust: implement `kernel::sync::Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Lyude Paul <lyude@redhat.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This is a wrapping layer of `include/linux/refcount.h`. Currently the
> kernel refcount has already been used in `Arc`, however it calls into
> FFI directly.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/helpers/refcount.c      | 10 +++++
>  rust/kernel/sync.rs          |  2 +
>  rust/kernel/sync/refcount.rs | 86 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 rust/kernel/sync/refcount.rs
>
> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> index d6adbd2e45a1..d175898ad7b8 100644
> --- a/rust/helpers/refcount.c
> +++ b/rust/helpers/refcount.c
> @@ -7,11 +7,21 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
>         return (refcount_t)REFCOUNT_INIT(n);
>  }
>
> +void rust_helper_refcount_set(refcount_t *r, int n)
> +{
> +       refcount_set(r, n);
> +}
> +
>  void rust_helper_refcount_inc(refcount_t *r)
>  {
>         refcount_inc(r);
>  }
>
> +void rust_helper_refcount_dec(refcount_t *r)
> +{
> +       refcount_dec(r);
> +}
> +
>  bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  {
>         return refcount_dec_and_test(r);
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 3498fb344dc9..b196cd0b358e 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -13,6 +13,7 @@
>  mod locked_by;
>  pub mod poll;
>  pub mod rcu;
> +mod refcount;
>
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> @@ -20,6 +21,7 @@
>  pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
>  pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
>  pub use locked_by::LockedBy;
> +pub use refcount::Refcount;
>
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_ke=
y`.
>  #[repr(transparent)]
> diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> new file mode 100644
> index 000000000000..a6a683f5d7b8
> --- /dev/null
> +++ b/rust/kernel/sync/refcount.rs
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic reference counting.
> +//!
> +//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcoun=
t.h)
> +
> +use crate::types::Opaque;
> +
> +/// Atomic reference counter.
> +///
> +/// This type is conceptually an atomic integer, but provides saturation=
 semantics compared to
> +/// normal atomic integers. Values in the negative range when viewed as =
a signed integer are
> +/// saturation (bad) values. For details about the saturation semantics,=
 please refer to top of
> +/// [`include/linux/refcount.h`](srctree/include/refcount.h).
> +///
> +/// Wraps the kernel's C `refcount_t`.
> +#[repr(transparent)]
> +pub struct Refcount(Opaque<bindings::refcount_t>);
> +
> +impl Refcount {
> +    /// Construct a new [`Refcount`] from an initial value.
> +    #[inline]
> +    pub fn new(value: i32) -> Self {
> +        // SAFETY: There are no safety requirements for this FFI call.
> +        Self(Opaque::new(unsafe { bindings::REFCOUNT_INIT(value) }))
> +    }
> +
> +    #[inline]
> +    fn as_ptr(&self) -> *mut bindings::refcount_t {
> +        self.0.get()
> +    }
> +
> +    /// Set a refcount's value.
> +    #[inline]
> +    pub fn set(&self, value: i32) {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_set(self.as_ptr(), value) }
> +    }
> +
> +    /// Increment a refcount.
> +    ///
> +    /// It will saturate if overflows and `WARN`. It will also `WARN` if=
 the refcount is 0, as this
> +    /// represents a possible use-after-free condition.
> +    ///
> +    /// Provides no memory ordering, it is assumed that caller already h=
as a reference on the
> +    /// object.
> +    #[inline]
> +    pub fn inc(&self) {
> +        // SAFETY: self is valid.
> +        unsafe { bindings::refcount_inc(self.as_ptr()) }
> +    }
> +
> +    /// Decrement a refcount.
> +    ///
> +    /// It will `WARN` on underflow and fail to decrement when saturated=
.
> +    ///
> +    /// Provides release memory ordering, such that prior loads and stor=
es are done
> +    /// before.
> +    #[inline]
> +    pub fn dec(&self) {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_dec(self.as_ptr()) }
> +    }
> +
> +    /// Decrement a refcount and test if it is 0.
> +    ///
> +    /// It will `WARN` on underflow and fail to decrement when saturated=
.
> +    ///
> +    /// Provides release memory ordering, such that prior loads and stor=
es are done
> +    /// before, and provides an acquire ordering on success such that me=
mory deallocation
> +    /// must come after.
> +    ///
> +    /// Returns true if the resulting refcount is 0, false otherwise.
> +    #[inline]
> +    #[must_use =3D "use `dec` instead you do not need to test if it is 0=
"]

The word "if" seems to be missing?

The C function comment includes this bit:

 * Use of this function is not recommended for the normal reference countin=
g
 * use case in which references are taken and released one at a time.  In t=
hese
 * cases, refcount_dec(), or one of its variants, should instead be used to
 * decrement a reference count.

Do we need to include this warning?


> +    pub fn dec_and_test(&self) -> bool {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_dec_and_test(self.as_ptr()) }
> +    }
> +}
> +
> +// SAFETY: `refcount_t` is thread-safe.
> +unsafe impl Send for Refcount {}
> +
> +// SAFETY: `refcount_t` is thread-safe.
> +unsafe impl Sync for Refcount {}
> --
> 2.47.2
>

