Return-Path: <linux-kernel+bounces-271071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF4094491E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B2D1F217F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3417B40A;
	Thu,  1 Aug 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AONgN93H"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1C183CA3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507116; cv=none; b=fY0fzoPx8yqC6G+Ga1WDV8kK+ScUQGnkPFFin15eds7t02jEZjfZxsDqMfQ61YRWm/Ev7UxkqtFwD6AHDOvN6uuKSRvUC3ApzaM5PXu0o8uhDTg3L38RGVbI2VkUDTic9gOqNlJqC33qTn2CAv3eLJpHn/4QNwlhEIiVljYtRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507116; c=relaxed/simple;
	bh=Iq69SaRT8GGzXmsv05bS8grBvLtWQTR3SCFVnK4tfMg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvizIN5lNsoQH2uTRVtiMkuVxm0tjyZNDjPH6j9i2gZS7O+QP2fsXRkwbeGQaILLUU8hbE2GS4ayCJ12BXAHo+NsxXDsVR28S23zboNw6Bsj+9i+EuEidwrSnUGlmMBDVP6wOsMK+/XrQDUSasjxlk8PvmmV022ijj9SF70tAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AONgN93H; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722507111; x=1722766311;
	bh=PgVkGuT/+v1e5Yq/KovVFgrDnMHXMXPtnrHOBzVMHUI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AONgN93Hvq9RU70+P+cKUK2Ovmic29GspcPHnxxS4HPosNs22PSRF1fvFqO7W8Xjx
	 MSze1ef+nqHHN2rFXDgyv0Zalp/rJ0YNyZzwMs3Nf2fTxUeDIkganKdF5QhCZqiSnj
	 BflPPHr6cJ3shwgz4fqmqxZ8ucbLPfhs30cIy7DJdthH/3UfeuEZ3pWaKwHpCKMOkO
	 JTRa4fZKsVOA4sGCnqsXndWtDO3VwuyIUw7JnyvgGq3eYCRIqBImu9dzwqhwKe6jv3
	 vVfg9HUX5xVf89B37tQZqZb9xrbsxISiuMW/zJEH2xfgu1uz7lrqhK2raagRGXV3Cm
	 G6/LkyFjn6OJA==
Date: Thu, 01 Aug 2024 10:11:47 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Trevor Gross <tmgross@umich.edu>, Ben Gooding <ben.gooding.dev@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: sync: Introduce lock::Backend::Context
Message-ID: <6a6bcf8a-8b33-4f46-b891-4a97da2b73fc@proton.me>
In-Reply-To: <20240731224027.232642-3-lyude@redhat.com>
References: <20240731224027.232642-1-lyude@redhat.com> <20240731224027.232642-3-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8935c47c01e0ee511c4d8a1b1728e4b5ffcdc067
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 00:35, Lyude Paul wrote:
> Now that we've introduced an `IrqDisabled` token for marking contexts in
> which IRQs are disabled, we need a way to be able to pass it to locks tha=
t
> require that IRQs are disabled. In order to continue using the
> `lock::Backend` type instead of inventing our own thing, we accomplish th=
is
> by adding the associated Context type, along with a `lock_with()` functio=
n
> that can accept a Context when acquiring a lock. To allow current users o=
f
> context-less locks to keep using the normal `lock()` method, we take an
> example from Wedson Almeida Filho's work and add a `where T<'a>: Default`
> bound to `lock()` so that it can only be called on lock types where the
> context is simply a placeholder value, then re-implement it through the n=
ew
> `lock_with()` function.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/sync/lock.rs          | 17 +++++++++++++++--
>  rust/kernel/sync/lock/mutex.rs    |  3 +++
>  rust/kernel/sync/lock/spinlock.rs |  1 +
>  3 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819f..f3ff50c4272cf 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -38,6 +38,9 @@ pub unsafe trait Backend {
>      /// [`unlock`]: Backend::unlock
>      type GuardState;
>=20
> +    /// The context which much be provided to acquire the lock.
> +    type Context<'a>;
> +
>      /// Initialises the lock.
>      ///
>      /// # Safety
> @@ -120,14 +123,24 @@ pub fn new(t: T, name: &'static CStr, key: &'static=
 LockClassKey) -> impl PinIni
>  }
>=20
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
> -    /// Acquires the lock and gives the caller access to the data protec=
ted by it.
> -    pub fn lock(&self) -> Guard<'_, T, B> {
> +    /// Acquires the lock with the given context and gives the caller ac=
cess to the data protected
> +    /// by it.
> +    pub fn lock_with(&self, _context: B::Context<'_>) -> Guard<'_, T, B>=
 {

Here we need to be careful, without lifetime elision, this signature is:

    pub fn lock_with<'a, 'b>(&'a self, _context: B::Context<'b>) -> Guard<'=
a, T, B>

This is problematic, since with this signature you should be able to
create this piece of code:

    let lock: SpinLockIrq =3D /* ... */

    let mut guard =3D None;
    with_irq_disabled(|irq| guard =3D Some(lock.lock_with(irq)));
    // then use guard when `irq` are again enabled!

So what we want the signature to be is this:
   =20
    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T=
, B>

So we need to ensure that the lifetime of `context` is bound to the
lifetime of the guard.

>          // SAFETY: The constructor of the type calls `init`, so the exis=
tence of the object proves
>          // that `init` was called.
>          let state =3D unsafe { B::lock(self.state.get()) };
>          // SAFETY: The lock was just acquired.
>          unsafe { Guard::new(self, state) }
>      }
> +
> +    /// Acquires the lock and gives the caller access to the data protec=
ted by it.
> +    #[inline]
> +    pub fn lock<'a>(&'a self) -> Guard<'a, T, B>
> +    where
> +        B::Context<'a>: Default,
> +    {
> +        self.lock_with(B::Context::default())
> +    }
>  }
>=20
>  /// A lock guard.
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex=
.rs
> index 30632070ee670..327e53be4c0f4 100644
> --- a/rust/kernel/sync/lock/mutex.rs
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! This module allows Rust code to use the kernel's `struct mutex`.
>=20
> +use core::marker::*;
> +
>  /// Creates a [`Mutex`] initialiser with the given name and a newly-crea=
ted lock class.
>  ///
>  /// It uses the name if one is given, otherwise it generates one based o=
n the file name and line
> @@ -93,6 +95,7 @@ macro_rules! new_mutex {
>  unsafe impl super::Backend for MutexBackend {
>      type State =3D bindings::mutex;
>      type GuardState =3D ();
> +    type Context<'a> =3D PhantomData<&'a ()>;

Is there any reason you chose `PhantomData` here? Why not just `()`?

---
Cheers,
Benno

>=20
>      unsafe fn init(
>          ptr: *mut Self::State,
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/sp=
inlock.rs
> index ea5c5bc1ce12e..8503d6e8e3de3 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -92,6 +92,7 @@ macro_rules! new_spinlock {
>  unsafe impl super::Backend for SpinLockBackend {
>      type State =3D bindings::spinlock_t;
>      type GuardState =3D ();
> +    type Context<'a> =3D PhantomData<&'a ()>;
>=20
>      unsafe fn init(
>          ptr: *mut Self::State,
> --
> 2.45.2
>=20


