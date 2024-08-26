Return-Path: <linux-kernel+bounces-301753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B629195F513
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E2D1C2144E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29933EC;
	Mon, 26 Aug 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="foeuuRGe"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304117BEA5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686218; cv=none; b=ETsBdaXJz0iZkLx8kWNTfqAOUUKSq/5XGas4WnLHeMTZv7JJi2AvoJOuDTCzmwdYgg92Az8c6HDYOrn+c+xML8SuCF085j5nhQ8uKsRKjm+ospZEza1efv98anuF4g1ZUVjiiGr7airpML9Kt7Eo3RQYLsjl9GCSixTGD9X8VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686218; c=relaxed/simple;
	bh=06p/l1Z2HVeU+KDuAy8+n0dmtDSXIUuwbXx5MRqFTxk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRd+yu5dqoc2AUyxUeRg3iJTk6mMh4VeQSDpbN9ZPf6KnRHJBUh9CW8+C630qFhRzxAguyxO77wyJVkbjz0MaSjddND5VuAx/H2cGM5FXKJl9J7MseDh94tRD6K7XLK/0W58DQcbhTc/6m2iXJDRYUiiosodmuDT9pKnhU75R14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=foeuuRGe; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724686214; x=1724945414;
	bh=KxRHVmcm1qvb26ydvSyHXTipBP2NvBWirzM8fU55iS0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=foeuuRGeTizHJrJLsZBGwbmsD4ZDOGARkh8CFP8r4t7mgCRx9chRThgUk5IvyNBUz
	 MFv+v/WigmwMY0xlF/sG3qv/TX/fILnYhuE6/isApni2YJDzYOlwI6SSWHzeSOly4q
	 ZtK5wBOt+d01mGoJroPegBovUu9okPAITV01XEiMracwtedeN4ooCjn/2Vc+zfltNX
	 4JngLhGkCBSSvNFO4lLUku7XTxt7Q3QQUg8Nu2b77h99qlKFZevf6uGIBP5sM9tTk7
	 aEiM7nUqEgc0XMhOMgByK4FOBcOr0JXGTr8Pa34rawZep2STVRQTs5ormn/yO9KKqw
	 mwsi5gGAH3DpA==
Date: Mon, 26 Aug 2024 15:30:08 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: add global lock support
Message-ID: <9feb41cc-cb1c-4d0d-a3df-09298e69af69@proton.me>
In-Reply-To: <20240826-static-mutex-v1-1-a14ee71561f3@google.com>
References: <20240826-static-mutex-v1-1-a14ee71561f3@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 81454d238bba8d88fbf1f30a0e89dd200375df55
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.08.24 17:27, Alice Ryhl wrote:
> We don't currently have any support for global locks in Rust, however
> they are very useful and I have needed to work around this limitation
> several times. My workarounds generally involve initializing the mutex
> in the module's init function, and this workaround is reflected here.
>=20
> Due to the initialization requirement, constructing a global mutex is
> unsafe with the current approach. In the future, it would be really nice
> to support global mutexes that don't need to be initialized, which would
> make them safe. Unfortunately, this is not possible today because
> bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
> compile-time constant. It just generates an `extern "C"` global
> reference instead.
>=20
> On most architectures, we could initialize the lock to just contain all
> zeros. A possible improvement would be to create a Kconfig constant
> that is set whenever the current architecture uses all zeros for the
> initializer and have `unsafe_const_init` be a no-op on those
> architectures. We could also provide a safe const initializer that is
> only available when that Kconfig option is set.
>=20
> For architectures that don't use all-zeros for the unlocked case, we
> will most likely have to hard-code the correct representation on the
> Rust side.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/lock.rs | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819..19e8ecd8d194 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -117,6 +117,40 @@ pub fn new(t: T, name: &'static CStr, key: &'static =
LockClassKey) -> impl PinIni
>              }),
>          })
>      }
> +
> +    /// Create a global lock that has not yet been initialized.
> +    ///
> +    /// Since global locks is not yet fully supported, this method imple=
ments global locks by
> +    /// requiring you to initialize them before you start using it. Usua=
lly this is best done in
> +    /// the module's init function.
> +    ///
> +    /// # Safety
> +    ///
> +    /// You must call [`unsafe_const_init`] before calling any other met=
hod on this lock.
> +    ///
> +    /// [`unsafe_const_init`]: Self::unsafe_const_init
> +    pub const unsafe fn unsafe_const_new(t: T) -> Self {
> +        Self {
> +            data: UnsafeCell::new(t),
> +            state: Opaque::uninit(),
> +            _pin: PhantomPinned,
> +        }
> +    }
> +
> +    /// Initialize a global lock.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * This lock must have been created with [`unsafe_const_new`].
> +    /// * This lock must be pinned.

You could also ask for `self: Pin<&Self>` and remove this constraint, or
is that not possible in your use-case?

---
Cheers,
Benno

> +    /// * This method must not be called more than once on a given lock.
> +    ///
> +    /// [`unsafe_const_new`]: Self::unsafe_const_new
> +    pub unsafe fn unsafe_const_init(&self, name: &'static CStr, key: &'s=
tatic LockClassKey) {
> +        // SAFETY: The pointer to `state` is valid for the duration of t=
his call, and both `name`
> +        // and `key` are valid indefinitely.
> +        unsafe { B::init(self.state.get(), name.as_char_ptr(), key.as_pt=
r()) }
> +    }
>  }
>=20
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
>=20
> ---
> base-commit: b204bbc53f958fc3119d63bf2cda5a526e7267a4
> change-id: 20240826-static-mutex-a4b228e0e6aa
>=20
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>
>=20


