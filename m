Return-Path: <linux-kernel+bounces-262945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3332B93CEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E311F2177B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D78176ACF;
	Fri, 26 Jul 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cBR5Dq8P"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A82B9B8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979668; cv=none; b=sQ7l/rCYwpNPCC5Rkzn1p7sYJokgaxQK43yCuPULh2uXFxozJEGaEramLhHcI3VriJ87bO6BsgFrI7+iv04U04t0TPYxSdF2/qRYrr4zEA8Gvaj3E1d4LeY7xSpco0EukQ1BSDUuM1DPm31VNM194DlbfivhbhzzomEMHfOnAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979668; c=relaxed/simple;
	bh=I70QW6hpY+jLdfy5HkEgw5Gl1NKikX5wbk22K6+C/eQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYnDfpWB2j/tIPPVMPxqPgn0cc7qyx9SDg1sHZZJgqthIpIDWTbHOj2vjIrhzz7mivAcDJyjme+MaWtFB7+8LwPKHUOQrbEQserz/HEVyxecwfMm/meYCKoQa0zpELFW5wGIJlj8fx6Cf9KYtUCF5vCVrfUd0oFH3FduFCEY4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cBR5Dq8P; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721979664; x=1722238864;
	bh=nuNNEuDtKjzAbgP3yLhd9hSlLZ1VjY9HwALtq8R4bIs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cBR5Dq8P7o5mkS9xOC4P/s/vArJK0fYrmVvGA30eEvSd20DfFODGSr+0lglaWhpaI
	 ZhLfR+R0o+LeNhP2k1hkDEk7e5YQeVfdsaSzXbheCZNUlfAXULhRBAASCxyFAyrHGh
	 1sfH9w0FOnX4Iz6GjhtSRyZX2VSXuHr9dR382dSj3tXUqg5xKrLng5KbL7gKmLxBdP
	 VGWLxEsa735t/EtQQLRCuBsG2n7qP2gTe3ah2dCQ47jBZXTOhgSkzzw3ak4ueq7rK4
	 YekLlrWbcYZOT9nrL+awjnEM8zC0Cmzoyom2Cj6QNi2gIryz+d/hZZMivkRtg6ul9/
	 if0j/0K+dnQjQ==
Date: Fri, 26 Jul 2024 07:40:59 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Trevor Gross <tmgross@umich.edu>, Ben Gooding <ben.gooding.dev@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: sync: Introduce LockContainer trait
Message-ID: <59515c1e-d1f4-47c3-a201-d2b0824f948b@proton.me>
In-Reply-To: <20240725222822.1784931-3-lyude@redhat.com>
References: <20240725222822.1784931-1-lyude@redhat.com> <20240725222822.1784931-3-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8520140208c81d9550b798ed5e0975a1d64dec95
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.07.24 00:27, Lyude Paul wrote:
> We want to be able to use spinlocks in no-interrupt contexts, but our
> current `Lock` infrastructure doesn't allow for the ability to pass
> arguments when acquiring a lock - meaning that there would be no way for =
us
> to verify interrupts are disabled before granting a lock since we have
> nowhere to pass an `IrqGuard`.
>=20
> It doesn't particularly made sense for us to add the ability to pass such
> an argument either: this would technically work, but then we would have t=
o
> pass empty units as arguments on all of the many locks that are not grabb=
ed
> under interrupts. As a result, we go with a slightly nicer solution:

I think there is a solution that would allow us to have both[1]:
1. Add a new associated type to `Backend` called `Context`.
2. Add a new parameter to `Backend::lock`: `ctx: Self::Context`.
3. Add a new function to `Lock<T: ?Sized, B: Backend>`:
   `lock_with(&self, ctx: B::Context)` that delegates to `B::lock`.
4. Reimplement `Lock::lock` in terms of `Lock::lock_with`, by
   constraining the function to only be callable if
   `B::Context: Default` holds (and then using `Default::default()` as
   the value).

This way people can still use `lock()` as usual, but we can also have
`lock_with(irq)` for locks that require it.

[1]: I think I saw this kind of a pattern first from Wedson in the
context of passing default allocation flags.

> introducing a trait for types which can contain a lock of a specific type=
:
> LockContainer. This means we can still use locks implemented on top of
> other lock types in types such as `LockedBy` - as we convert `LockedBy` t=
o
> begin using `LockContainer` internally and implement the trait for all
> existing lock types.


>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/sync.rs           |  1 +
>  rust/kernel/sync/lock.rs      | 20 ++++++++++++++++++++
>  rust/kernel/sync/locked_by.rs | 11 +++++++++--
>  3 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5d..14a79ebbb42d5 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -16,6 +16,7 @@
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
>  pub use lock::mutex::{new_mutex, Mutex};
>  pub use lock::spinlock::{new_spinlock, SpinLock};
> +pub use lock::LockContainer;
>  pub use locked_by::LockedBy;
>=20
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_ke=
y`.
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819f..bbd0a7465cae3 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -195,3 +195,23 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state=
: B::GuardState) -> Self {
>          }
>      }
>  }
> +
> +/// A trait implemented by any type which contains a [`Lock`] with a spe=
cific [`Backend`].
> +pub trait LockContainer<T: ?Sized, B: Backend> {
> +    /// Returns an immutable reference to the lock
> +    ///
> +    /// # Safety
> +    ///
> +    /// Since this returns a reference to the contained [`Lock`] without=
 going through the
> +    /// [`LockContainer`] implementor, it cannot be guaranteed that it i=
s safe to acquire
> +    /// this lock. Thus the caller must promise not to attempt to use th=
e returned immutable
> +    /// reference to attempt to grab the underlying lock without ensurin=
g whatever guarantees the
> +    /// [`LockContainer`] implementor's interface enforces.

This safety requirement is rather unclear to me, there isn't really a
good place to put the `LockContainer` requirements when implementing
this trait.
I also don't understand the use-case where a lock can only be acquired
in certain circumstances, do you have an example?

---
Cheers,
Benno

> +    unsafe fn get_lock_ref(&self) -> &Lock<T, B>;
> +}
> +
> +impl<T: ?Sized, B: Backend> LockContainer<T, B> for Lock<T, B> {
> +    unsafe fn get_lock_ref(&self) -> &Lock<T, B> {
> +        &self
> +    }
> +}
> diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.r=
s
> index babc731bd5f62..d16d89fe74e0b 100644
> --- a/rust/kernel/sync/locked_by.rs
> +++ b/rust/kernel/sync/locked_by.rs
> @@ -95,13 +95,20 @@ impl<T, U> LockedBy<T, U> {
>      /// data becomes inaccessible; if another instance of the owner is a=
llocated *on the same
>      /// memory location*, the data becomes accessible again: none of thi=
s affects memory safety
>      /// because in any case at most one thread (or CPU) can access the p=
rotected data at a time.
> -    pub fn new<B: Backend>(owner: &Lock<U, B>, data: T) -> Self {
> +    pub fn new<B, L>(owner: &L, data: T) -> Self
> +    where
> +        B: Backend,
> +        L: super::LockContainer<U, B>,
> +    {
>          build_assert!(
>              size_of::<Lock<U, B>>() > 0,
>              "The lock type cannot be a ZST because it may be impossible =
to distinguish instances"
>          );
>          Self {
> -            owner: owner.data.get(),
> +            // SAFETY: We never directly acquire the lock through this r=
eference, we simply use it
> +            // to ensure that a `Guard` the user provides us to access t=
his container's contents
> +            // belongs to the same lock that owns this data
> +            owner: unsafe { owner.get_lock_ref() }.data.get(),
>              data: UnsafeCell::new(data),
>          }
>      }
> --
> 2.45.2
>=20


