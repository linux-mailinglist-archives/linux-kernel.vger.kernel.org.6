Return-Path: <linux-kernel+bounces-571645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10559A6C025
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF57C3A6CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB722C339;
	Fri, 21 Mar 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcX+3JVz"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE514601C;
	Fri, 21 Mar 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575042; cv=none; b=KHWnHs2TpXuA2BfmcMT2GpCLCHqQVRrakleQ1tFQpAlyzvR9hnzQ0lSiICSjGsTrvICBCp5v0s1He+oiVISgQsq+t8GcHkXzfFUlXSrM/SO3Ljo5p0M7fnmYrmcKOw6z8T1AbD9fM9XQI1KxjRx3h1z2flRGqdK6PVocS2o9Wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575042; c=relaxed/simple;
	bh=/40ipDs5+b2r2oh/+PSV7XySMvIH9YQjxFwDkFcRFI0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg419JZX0TwNRQfOGKO1iMEsdtQ4NN8K9sZ2vJm2pia7M17KMninxOIX01xJ2ZJb8jXRH0PB9fViddOWQrMeD3XydtG7JWJuVSSpSGGh7vdt9/3tq7oHlYUd1HbU3iqNC26WoMGIgeQ+adb0IWqp1FaOOkYvfLvNO+G2JDzm8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcX+3JVz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47677b77725so19639871cf.3;
        Fri, 21 Mar 2025 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742575039; x=1743179839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DemLgMalErRWc5BdgcfMC9pXJ4M8yDeytNYsE9B+E40=;
        b=kcX+3JVzDNBSyORk77xe2vG/YrxFxLo8HSwVNIymRvxamZ5dpxDJirevGylbCsHJXr
         +zbB+O7eKM4E3YYYgUX7U6dIrFBxUkHZJWMnnxgK/yjss3AF7ATVLoYIOVcyQQqfbUZc
         ++lgRDCytTjEfvoTt4sAO3KztwpHFythXe1ik2DfiiYu1BIK0+WJkEzqV9y9W3vJRTDn
         IQKRY5Srdg1ZxiVngN89G7nSHRIKTttlwbmNrG9JgbPIXgCcoa+uv5bbMB8n0yLPeDUF
         Me98/9TqQShClQoWrUjHURue1IgB0K36XlJ93T8fxt2aEi7cUwQ8nzzqOtqdoJREca1o
         qxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575039; x=1743179839;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DemLgMalErRWc5BdgcfMC9pXJ4M8yDeytNYsE9B+E40=;
        b=t0bzu/Y0g0VzZTwiBjLzySYp8w6hjCbPb3xsgBZjSYOMOlhenqgzEuPXn9lTJTZY0X
         dCwFOTR/sSLMoQHtPJok6ldM7gL/39zOuwoLcSYz5gz5fK1k29YTKNOWTHUmBqeWIsjj
         diEJdTtJr7wJVeOnfxBI4i6jsOorLq+bvVOGhYsJhntA15aNIxEaSpUSvG5ROz22o3/c
         bmjZ1qTs8XfXOe15UMasdzm680fbzMakB8IwRLrUc35yac/kBTlhmXbk3qTSCaq7n0y5
         XKCHaYFJvundWTu2VOLismlp4eL7HlnEJMQZrls7I9R8whPBXP8+IJWxIwzDS9f90zm5
         bLgg==
X-Forwarded-Encrypted: i=1; AJvYcCVymumEhRu0e0RRCVDE0jcBM3+z2X/qVx7/s/6hS71eRQAmPEYvuPr6490/eN4mOhdjpLmfQhf3adMTChO7EqY=@vger.kernel.org, AJvYcCWgzYOJu+ZzDusJlvi+rVbYqRbv8bkYo+REQgoxkVyGL20BOWtD7w75nzzGEG9E0pm2SOI0i5iwgaNepXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcTrnjxu6bNkz660KgeapJdfwEXCdVMyjfMCa2U078DnZiRv+
	RTeuXV3qT/7TXH7r+7/9ahFYd6QM6ArfJsQMkJroYXsMJx3TkMo6
X-Gm-Gg: ASbGncvozYNxC7XQvt23CWABXcu1UzBPB/pi599wnVwqz/Te45y7UxwroA+eFEah/rf
	XmL0SbqrYMCUY+LoWY5corRGCsMPjN1bu8hTIWLJDEiMfGkFQDh6ingv2HeosT5PgCxDl1initK
	Af4/cPHoPbOEhBowdVyTx12rVtKexcDeQun6kfshRxMBh9+GMC0Bi5S4R1592bbdAmsWoAlwOSZ
	g09NyKQnILanMCWqCohJ05JksvchoRJobNrXTiPI+EnjKlaeyvOVPF8sFdJdjCansGPZZj51rBo
	yOjnU1Zk1as/5UkoDf9UKJVKocrhr8FYd0cakAprtiTmO2u+idBCtwQorSKEyxrL7oWJc6gMqs5
	qQz3SAhkaFhdZy+vLzLAv97M1KhRwNrkr4wU=
X-Google-Smtp-Source: AGHT+IHNkb/h9lOwy+hWVrQXbsFQuUcgqE24UfnciNxc0u9bkFc5tTD+1Quiq4iA+GQ2AGbSIW4auA==
X-Received: by 2002:a05:622a:3d0:b0:477:1ee1:d1c8 with SMTP id d75a77b69052e-4771ee1d97dmr51248141cf.4.1742575038712;
        Fri, 21 Mar 2025 09:37:18 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d635b94sm13596581cf.76.2025.03.21.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:37:18 -0700 (PDT)
Message-ID: <67dd95be.050a0220.ff22e.716f@mx.google.com>
X-Google-Original-Message-ID: <Z92VvHQPgIYsnDrC@winterfell.>
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id EB9B81200069;
	Fri, 21 Mar 2025 12:37:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Fri, 21 Mar 2025 12:37:17 -0400
X-ME-Sender: <xms:vZXdZ0CiLHnLexnrtpu1GsFqNMJvChDf4k9gRf86yhbvImzMq1VYZw>
    <xme:vZXdZ2ixvAyeJzpny_fBff-D-N-Hs8Qulbv8Z1uf3x5iC76tXFrFFOB5Tzz9WmQkK
    nTsZ6tFczAVhqzlbQ>
X-ME-Received: <xmr:vZXdZ3lR-6bKVyPtp0kDRD0jr_G_59Pilq4-sD5c11Em32Si-HMPlJfunWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepohhlihhvvghrrdhmrghnghholhgusehpmhdrmhgvpdhrtghpthhtohepohhjvggu
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:vZXdZ6zSozJdh_58q4WzL8uCVRN3woG8M_hezVFrLI-IRE2G8CAkcA>
    <xmx:vZXdZ5T_2lnzss6WnvjDS4i5cH8gpYLXtmoM29wPwvoIZjXkA2xMGg>
    <xmx:vZXdZ1ZmNHldW9Jh-MftEDEtiW3o7sWz0T33MceJCUDeKwHIO_Zqwg>
    <xmx:vZXdZyRoJg1h7JYlNCpagczY5IRN1G53THf8uo_VlwwDPuHECZJxhg>
    <xmx:vZXdZzB8y1xcztJDHMM5I79jX33AyxCfAwBsPupFgslgu_Tx_uIUfYtU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 12:37:17 -0400 (EDT)
Date: Fri, 21 Mar 2025 09:37:16 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] rust: adding OwnableRefCounted and
 SimpleOwnableRefCounted
References: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
 <20250313-unique-ref-v8-4-3082ffc67a31@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-unique-ref-v8-4-3082ffc67a31@pm.me>

On Thu, Mar 13, 2025 at 07:00:26AM +0000, Oliver Mangold wrote:
> Types implementing one of these traits can safely convert between an
> ARef<T> and an Owned<T>.
> 

Again, you need to mention why we need this.

> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> ---
>  rust/kernel/types.rs | 250 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 250 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 5a96da714348cc2369969200e6070972226c00fe..cca3d65782eecc7e2ada91f116eb885391c454bf 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -552,6 +552,12 @@ fn from(b: &T) -> Self {
>      }
>  }
>  
> +impl<T: OwnableRefCounted> From<Owned<T>> for ARef<T> {
> +    fn from(b: Owned<T>) -> Self {
> +        T::into_shared(b)
> +    }
> +}
> +
>  impl<T: RefCounted> Drop for ARef<T> {
>      fn drop(&mut self) {
>          // SAFETY: The type invariants guarantee that the `ARef` owns the reference
> @@ -669,6 +675,250 @@ fn drop(&mut self) {
>      }
>  }
>  
> +/// A trait for objects that can be wrapped in either one of the reference types [`Owned`] and
> +/// [`ARef`].
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that:
> +///
> +/// - Both the safety requirements for [`Ownable`] and [`RefCounted`] are fulfilled.
> +/// - The uniqueness invariant of [`Owned`] is upheld until dropped.

Could you explain what this safety requirement means? Isn't this part of
the safe requirement of `impl Ownable`?

> +/// - [`try_from_shared()`](OwnableRefCounted::into_shared) only returns an [`Owned`] if exactly
> +///   one [`ARef`] exists.
> +/// - [`into_shared()`](OwnableRefCounted::into_shared) set the reference count to the value which
> +///   the returned [`ARef`] expects for an object with a single reference
> +///   in existence. This implies that if [`into_shared()`](OwnableRefCounted::into_shared) is left
> +///   on the default implementation, which just rewraps the underlying object, the reference count
> +///   needs not to be modified when converting a [`Owned`] to an [`ARef`].
> +///
> +/// # Examples
> +///
> +/// A minimal example implementation of [`OwnableRefCounted`], [`Ownable`] and its usage with
> +/// [`ARef`] and [`Owned`] looks like this:
> +///
> +/// ```
> +/// # #![expect(clippy::disallowed_names)]
> +/// use core::cell::Cell;
> +/// use core::ptr::NonNull;
> +/// use kernel::alloc::{flags, kbox::KBox, AllocError};
> +/// use kernel::types::{
> +///     ARef, RefCounted, Owned, Ownable, OwnableRefCounted,
> +/// };
> +///
> +/// struct Foo {
> +///     refcount: Cell<usize>,

It's fine to use a Cell for now, but eventually we want to replace this
with either Gary's Refcount [1] or LKMM atomics.

[1]: https://lore.kernel.org/rust-for-linux/20250219201602.1898383-1-gary@garyguo.net/

(just keeping a note here)

> +/// }
> +///
> +/// impl Foo {
> +///     fn new() -> Result<Owned<Self>, AllocError> {
> +///         // Use a `KBox` to handle the actual allocation.
> +///         let result = KBox::new(
> +///             Foo {
> +///                 refcount: Cell::new(1),
> +///             },
> +///             flags::GFP_KERNEL,
> +///         )?;
> +///         let result = NonNull::new(KBox::into_raw(result))
> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
> +///         // SAFETY: We just allocated the `Foo`, thus it is valid.
> +///         Ok(unsafe { Owned::from_raw(result) })
> +///     }
> +/// }
> +///
> +/// // SAFETY: We increment and decrement each time the respective function is called and only free
> +/// // the `Foo` when the refcount reaches zero.
> +/// unsafe impl RefCounted for Foo {
> +///     fn inc_ref(&self) {
> +///         self.refcount.replace(self.refcount.get() + 1);
> +///     }
> +///
> +///     unsafe fn dec_ref(this: NonNull<Self>) {
> +///         // SAFETY: The underlying object is always valid when the function is called.
> +///         let refcount = unsafe { &this.as_ref().refcount };
> +///         let new_refcount = refcount.get() - 1;
> +///         if new_refcount == 0 {
> +///             // The `Foo` will be dropped when `KBox` goes out of scope.
> +///             // SAFETY: The `Box<Foo>` is still alive as the old refcount is 1.
> +///             unsafe { KBox::from_raw(this.as_ptr()) };
> +///         } else {
> +///             refcount.replace(new_refcount);
> +///         }
> +///     }
> +/// }
> +///
> +/// // SAFETY: We only convert into an `Owned` when the refcount is 1.
> +/// unsafe impl OwnableRefCounted for Foo {
> +///     fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>> {
> +///         if this.refcount.get() == 1 {
> +///             // SAFETY: The `Foo` is still alive as the refcount is 1.
> +///             Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
> +///         } else {
> +///             Err(this)
> +///         }
> +///     }
> +/// }
> +///
> +/// // SAFETY: We are not `AlwaysRefCounted`.
> +/// unsafe impl Ownable for Foo {
> +///     unsafe fn release(this: NonNull<Self>) {
> +///         // SAFETY: Using `dec_ref()` from `RefCounted` to release is okay, as the refcount is
> +///         // always 1 for an `Owned<Foo>`.
> +///         unsafe{ Foo::dec_ref(this) };
> +///     }
> +/// }
> +///
> +/// let foo = Foo::new().unwrap();
> +/// let mut foo = ARef::from(foo);
> +/// {
> +///     let bar = foo.clone();
> +///     assert!(Owned::try_from(bar).is_err());
> +/// }
> +/// assert!(Owned::try_from(foo).is_ok());
> +/// ```
> +pub unsafe trait OwnableRefCounted: RefCounted + Ownable + Sized {
> +    /// Checks if the [`ARef`] is unique and convert it to an [`Owned`] it that is that case.
> +    /// Otherwise it returns again an [`ARef`] to the same underlying object.
> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>>;
> +    /// Converts the [`Owned`] into an [`ARef`].
> +

^ this blanket line seems to be at the wrong place.

Regards,
Boqun

> +    fn into_shared(this: Owned<Self>) -> ARef<Self> {
> +        // SAFETY: Safe by the requirements on implementing the trait.
> +        unsafe { ARef::from_raw(Owned::into_raw(this)) }
> +    }
> +}
> +
> +/// This trait allows to implement [`Ownable`] and [`OwnableRefCounted`] together in a simplified
> +/// way, only requiring to implement [`RefCounted`] and providing the method
> +/// [`is_unique()`](SimpleOwnableRefCounted::is_unique).
> +///
> +/// For non-standard cases where conversion between [`Ownable`] and [`RefCounted`] does not allow
> +/// [`Ownable::release()`] and [`RefCounted::dec_ref()`] to be the same method, [`Ownable`]
> +/// and [`OwnableRefCounted`] should be implemented separately.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that:
> +///
> +/// - The safety requirements for [`Ownable`] are fulfilled and [`RefCounted::dec_ref()`] can
> +///   be used for [`Ownable::release()`].
> +/// - [`is_unique`](SimpleOwnableRefCounted::is_unique) must only return `true` in case only one
> +///   [`ARef`] exists and it is impossible for one to be obtained other than by cloning an existing
> +///   [`ARef`] or converting an [`Owned`] to an [`ARef`].
> +/// - It is safe to convert an unique [`ARef`] into an [`Owned`] simply by re-wrapping the
> +///   underlying object without modifying the refcount.
> +///
> +/// # Examples
> +///
> +/// A minimal example implementation of [`RefCounted`] and [`SimpleOwnableRefCounted`]
> +/// and its usage with [`ARef`] and [`Owned`] looks like this:
> +///
> +/// ```
> +/// # #![expect(clippy::disallowed_names)]
> +/// use core::cell::Cell;
> +/// use core::ptr::NonNull;
> +/// use kernel::alloc::{flags, kbox::KBox, AllocError};
> +/// use kernel::types::{
> +///     ARef, Owned, RefCounted, SimpleOwnableRefCounted,
> +/// };
> +///
> +/// struct Foo {
> +///     refcount: Cell<usize>,
> +/// }
> +///
> +/// impl Foo {
> +///     fn new() -> Result<Owned<Self>, AllocError> {
> +///         // Use a KBox to handle the actual allocation.
> +///         let result = KBox::new(
> +///             Foo {
> +///                 refcount: Cell::new(1),
> +///             },
> +///             flags::GFP_KERNEL,
> +///         )?;
> +///         let result = NonNull::new(KBox::into_raw(result))
> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
> +///         // SAFETY: We just allocated the `Foo`, thus it is valid.
> +///         Ok(unsafe { Owned::from_raw(result) })
> +///     }
> +/// }
> +///
> +/// // SAFETY: we ensure that:
> +/// // - The `Foo` is only dropped when the refcount is zero.
> +/// // - `is_unique()` only returns `true` when the refcount is 1.
> +/// unsafe impl RefCounted for Foo {
> +///     fn inc_ref(&self) {
> +///         self.refcount.replace(self.refcount.get() + 1);
> +///     }
> +///
> +///     unsafe fn dec_ref(this: NonNull<Self>) {
> +///         // SAFETY: The underlying object is always valid when the function is called.
> +///         let refcount = unsafe { &this.as_ref().refcount };
> +///         let new_refcount = refcount.get() - 1;
> +///         if new_refcount == 0 {
> +///             // The `Foo` will be dropped when KBox goes out of scope.
> +///             // SAFETY: The `Box<Foo>` is still alive as the old refcount is 1.
> +///             unsafe { KBox::from_raw(this.as_ptr()) };
> +///         } else {
> +///             refcount.replace(new_refcount);
> +///         }
> +///     }
> +/// }
> +///
> +/// // SAFETY: we ensure that:
> +/// // - `is_unique()` only returns `true` when the refcount is 1.
> +/// unsafe impl SimpleOwnableRefCounted for Foo {
> +///     fn is_unique(&self) -> bool {
> +///         self.refcount.get() == 1
> +///     }
> +/// }
> +///
> +/// let foo = Foo::new().unwrap();
> +/// let mut foo = ARef::from(foo);
> +/// {
> +///     let bar = foo.clone();
> +///     assert!(Owned::try_from(bar).is_err());
> +/// }
> +/// assert!(Owned::try_from(foo).is_ok());
> +/// ```
> +pub unsafe trait SimpleOwnableRefCounted: RefCounted {
> +    /// Checks if exactly one [`ARef`] to the object exists. In case the object is [`Sync`], the
> +    /// check needs to be race-free.
> +    fn is_unique(&self) -> bool;
> +}
> +
> +#[cfg_attr(RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recommend)]
> +// SAFETY: Safe by the requirements on implementation of [`SimpleOwnableRefCounted`].
> +unsafe impl<T: SimpleOwnableRefCounted> OwnableRefCounted for T {
> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>> {
> +        if T::is_unique(&*this) {
> +            // SAFETY: Safe by the requirements on implementation of [`SimpleOwnable`].
> +            Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
> +        } else {
> +            Err(this)
> +        }
> +    }
> +}
> +
> +#[cfg_attr(RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recommend)]
> +// SAFETY: Safe by the requirements on implementation of [`SimpleOwnableRefCounted`].
> +unsafe impl<T: SimpleOwnableRefCounted> Ownable for T {
> +    unsafe fn release(this: NonNull<Self>) {
> +        // SAFETY: Safe by the requirements on implementation of
> +        // [`SimpleOwnableRefCounted::dec_ref()`].
> +        unsafe { RefCounted::dec_ref(this) };
> +    }
> +}
> +
> +impl<T: OwnableRefCounted> TryFrom<ARef<T>> for Owned<T> {
> +    type Error = ARef<T>;
> +    /// Tries to convert the [`ARef`] to an [`Owned`] by calling
> +    /// [`try_from_shared()`](OwnableRefCounted::try_from_shared). In case the [`ARef`] is not
> +    /// unique, it returns again an [`ARef`] to the same underlying object.
> +    fn try_from(b: ARef<T>) -> Result<Owned<T>, Self::Error> {
> +        T::try_from_shared(b)
> +    }
> +}
> +
>  /// A sum type that always holds either a value of type `L` or `R`.
>  ///
>  /// # Examples
> 
> -- 
> 2.48.1
> 
> 

