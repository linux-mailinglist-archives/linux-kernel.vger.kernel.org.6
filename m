Return-Path: <linux-kernel+bounces-554832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8EA5A068
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAA3189112F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62444233710;
	Mon, 10 Mar 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO3phxCL"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281B22D7A6;
	Mon, 10 Mar 2025 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628961; cv=none; b=th/zrI3Pb3m2AJEKqHvB5ZZ3Ch+12wUhRGDHgALA6bV1HR5jcHvhiKzPr8uLKEkQFBtL7V9BTQwzAte24YH0W5Nz8d4b6pLDPEp27Ez7DoE6jUXD4ulKof5KoI3h1sGyHtsIav8I/Honmv/1cavjcXdr25sN6kZaASwrx8yfaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628961; c=relaxed/simple;
	bh=iUXRSebu1l2XyVgUiQIxp52HQt51wAF5tvSbZDLj7t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdZdRG6vqEZgv4zOd2nciaox+1n06PnssCaY8XE2DaIGfHf7PF62uuYHd5cjuOrlfCGlva7hOwcEqMz9ycVo17T+Bils0lOJ/RFv6mi3DAC4eBs2TQIToR+l3BXZMcNQLHaA6pzbX/riejt/awJFQRRIk1Wfmt5oyfSTkUx7jSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO3phxCL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c55500d08cso42848985a.0;
        Mon, 10 Mar 2025 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741628958; x=1742233758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tazBI7yaWl8JPiamfWO0OPuatZUqs1akrfq29KxusD0=;
        b=dO3phxCLahkRMyKjerPf5hFklAGM8t5ZVZ7ZdlaRQ2gQ+limnQh/ai/ldzqB0nt8nE
         Ssg+QJ9O29x63yGGmknP8Bg8akV4MLIIybwzqav49CZojoZekxmwXQsU+9VHA1XScZ8Y
         K7YqSf1iXfrhlr3X0iTymUmQrWz6X1SAhX7rWPLllBGPh35Q7//02r38O/TstknbtNra
         V4l5ltfaVIPgUBNP+aFkwvZuAwNs3idVVfIvsfx7VnwuvKnKBTTWXME1IFkV6C72k4Fz
         tPqVj6dmzEM53UV6Id2pOW9WA8/5kYRO5SCNsKDkteuN5aGfJwACN5gVvsijrt1EqMJL
         PveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741628958; x=1742233758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tazBI7yaWl8JPiamfWO0OPuatZUqs1akrfq29KxusD0=;
        b=wkby5UpC5X83edegRUQj/NhJgMulrGrKmWBL35ZMBYQmy0GBXuJFro7MU2eBSO6v9Q
         ivjoXVfqdV79hlM5W804p3bsvaEEkXxBC+J59Y3LtNwFTClYKfs2fmaXYquc4UyBsyh4
         TmwJxBzUM2+6badPfjAN4v5xxfCwJ3YlVftjCyj6UsklO8FDZxSs/e5gZO3IOE8VJ8/U
         jwXuRE/WFGZrizdegfoD5H7nf9cMbqB8cDQGLcD3Ixv/WKvDZYKUEfPZ1lanvcZMAH6w
         bEYQWFZ5HbDwXu9GX/0BhqKEtEZx96+T1pohv75XMCqQzntI0sWvSO3FdRymX+qBWflv
         wSAg==
X-Forwarded-Encrypted: i=1; AJvYcCUJE+CxcM57g1OhuVleq0sVmYEKF9INDcPLvPvo+vQ7p0MwvMrVdoR3QzgnUNe9sVcyo5/MknGVJc2HVJWkWqU=@vger.kernel.org, AJvYcCXixvodNfk0Lnte7Yf7hUv+3U68df681t0AZUNBOpFDfr16RtV1OJN8pANYM+MKyuw2M46DZfIif9q1HHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8IbDD2Gz7zNN30qgTSXsyPAzVSTuRh/81/XpRyQwKFr1JL+b
	gghigEsBtm7CycjTzZ0K0K7drPpxkelfgues/0oMX70qK0Shgy3u
X-Gm-Gg: ASbGncv38lct99CfhFAF+GMLl0hhxLOAQNA92ijrPzEnyLnIk+htMEmRgkrT96sl9ia
	KLz9zhed6EiLCDUM/hpoQVDA90ZVgu9qBb4f2STjx7A1VpAT0/HZ9erIYUdruE4aTSsB3KlXhtw
	RoE0mZPMkWQB9yii3N0bEj122+stO27+UExGwgaMEsH6d2NN2ym3JgfVK6it7voj0/zi8Q5aH81
	sLK+9TTE0Ts5uaq8Rc9Mf4H69a1YOZqSf1Kk44BoiqXX6ObT8octKF+7ACZzfF/DCCerWiuOLQ9
	vZILrTrovDESJF+FHHPuqZduANRdfYD8S09QkM1m+nY5HZrlILrT1h30GP93LIf6/EdoDWfPpCV
	b80kcSdQYGj37DJQpnErCCv5Pc7Udn4KrsWc=
X-Google-Smtp-Source: AGHT+IGFJ9IYV4W3yPTf1APSohG567VCEjsH2icVmnJuPRHwxtxq5AdHFfNPmKc3vsFGDw5wSqVMvg==
X-Received: by 2002:a05:620a:2620:b0:7c3:c9f9:3936 with SMTP id af79cd13be357-7c55e873b46mr105699785a.20.1741628957839;
        Mon, 10 Mar 2025 10:49:17 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5389c14sm706642985a.49.2025.03.10.10.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:49:17 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 965201200069;
	Mon, 10 Mar 2025 13:49:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 10 Mar 2025 13:49:16 -0400
X-ME-Sender: <xms:HCbPZz3dRmgXOpmVg2z7kwnE8gaDbEyMzTdqn0UMlAQghP9lfmfYfQ>
    <xme:HCbPZyEdIzO_luDu4-fpvmq0RnmYIc5rpHg3ZaMUgUKZXDDvFpg10qv0p0bVHRmmM
    Hsq9TGH_M7cC6lq9w>
X-ME-Received: <xmr:HCbPZz5l68FhS819O85bPjSZ3mnPvRhQiXfwbZdsIJNxh9GnchYWzGJ1SFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopeholhhivhgvrhdrmhgrnhhgohhlugesph
    hmrdhmvgdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonh
    drmhgvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmh
    hgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:HCbPZ407O2z_QC9Vae6ZWkyk0PGyg72E0kj3JBblfSIR_Nfx5gWPDg>
    <xmx:HCbPZ2HN-LS5i4EFqVxK2oU0jJWrRidXjAP4UCgs1h77gpTQSBt_MQ>
    <xmx:HCbPZ580x4r3NijeDjqo8yGzmpsG_KFF9xAG-eUPH6aKLNQ9ZVE-3g>
    <xmx:HCbPZznTSefzb_lg3e5PCNJMI0xoCF26RadE4pg3ut6s9J8QDcf4hg>
    <xmx:HCbPZyHycP2Z2tqol5YWsGkslfqHyT_zfqR_I1fkk-Si6tx46gSZXZ-l>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 13:49:16 -0400 (EDT)
Date: Mon, 10 Mar 2025 10:47:56 -0700
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
Subject: Re: [PATCH v7 4/4] rust: adding OwnableRefCounted and
 SimpleOwnableRefCounted
Message-ID: <Z88lzDPsO7UStQ85@boqun-archlinux>
References: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me>
 <20250310-unique-ref-v7-4-4caddb78aa05@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-unique-ref-v7-4-4caddb78aa05@pm.me>

On Mon, Mar 10, 2025 at 10:57:47AM +0000, Oliver Mangold wrote:
> Types implementing one of these traits can safely convert between an
> ARef<T> and an Owned<T>.
> 
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> ---
>  rust/kernel/types.rs | 275 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 275 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index e6f3308f931d90718d405443c3034a216388e0af..3e703701b2bccf1a440f4064b6dd90afb204d937 100644
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
> @@ -669,6 +675,275 @@ fn drop(&mut self) {
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
> +    fn into_shared(this: Owned<Self>) -> ARef<Self> {
> +        // SAFETY: Safe by the requirements on implementing the trait.
> +        unsafe { ARef::from_raw(Owned::into_raw(this)) }
> +    }
> +}
> +
> +/// This trait allows to implement all of [`Ownable`], [`RefCounted`] and
> +/// [`OwnableRefCounted`] together in a simplified way,
> +/// only requiring to provide the methods [`inc_ref()`](SimpleOwnableRefCounted::inc_ref),
> +/// [`dec_ref()`](SimpleOwnableRefCounted::dec_ref),
> +/// and [`is_unique()`](SimpleOwnableRefCounted::is_unique).
> +///
> +/// For non-standard cases where conversion between [`Ownable`] and [`RefCounted`] needs
> +/// or [`Ownable::release()`] and [`RefCounted::dec_ref()`] cannot be the same method,
> +/// [`Ownable`], [`RefCounted`] and [`OwnableRefCounted`] should be implemented manually.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that:
> +///
> +/// - Both the safety requirements as for [`Ownable`] and [`RefCounted`] are fulfilled.
> +/// - [`is_unique`](SimpleOwnableRefCounted::is_unique) must only return `true` in case only one
> +///   [`ARef`] exists and it is impossible for one to be obtained other than by cloning an existing
> +///   [`ARef`] or converting an [`Owned`] to an [`ARef`].
> +/// - It is safe to convert an unique [`ARef`] into an [`Owned`] simply by re-wrapping the
> +///   underlying object without modifying the refcount.
> +///
> +/// # Examples
> +///
> +/// A minimal example implementation of [`SimpleOwnableRefCounted`]
> +/// and its usage with [`ARef`] and [`Owned`] looks like this:
> +///
> +/// ```
> +/// # #![expect(clippy::disallowed_names)]
> +/// use core::cell::Cell;
> +/// use core::ptr::NonNull;
> +/// use kernel::alloc::{flags, kbox::KBox, AllocError};
> +/// use kernel::types::{
> +///     ARef, SimpleOwnableRefCounted, Owned,
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
> +/// unsafe impl SimpleOwnableRefCounted for Foo {
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
> +///
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
> +pub unsafe trait SimpleOwnableRefCounted {

Can you make this trait as a sub-trait of RefCounted:

	pub unsafe trait SimpleOwnableRefCounted: RefCounted {
	    fn is_unique(&self) -> bool;
	}

?

> +    /// Checks if exactly one [`ARef`] to the object exists. In case the object is [`Sync`], the
> +    /// check needs to be race-free.
> +    fn is_unique(&self) -> bool;
> +
> +    /// Increments the reference count on the object.
> +    fn inc_ref(&self);
> +
> +    /// Decrements the reference count on the object when the [`SimpleOwnableRefCounted`] is

Should be:

"... when ARef<SimpleOwnableRefCounted> or
Owned<SimpleOwnableRefCounted> is dropped"

?

> +    /// dropped.
> +    ///
> +    /// Frees the object when the count reaches zero.

It may not end up freeing the object, because ARef<..> only tracks the
Rust side of refcounting, we should avoid mentioning "refcount reaching
to zero" here.

Regards,
Boqun

> +    ///
> +    /// # Safety
> +    ///
> +    /// The safety constraints for [`RefCounted::dec_ref`] and [`Ownable::release`] both apply to
> +    /// this method, as it will be used to implement both of these traits.
> +    unsafe fn dec_ref(obj: NonNull<Self>);
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
> +        unsafe { SimpleOwnableRefCounted::dec_ref(this) };
> +    }
> +}
> +
> +#[cfg_attr(RUSTC_HAS_DO_NOT_RECOMMEND, diagnostic::do_not_recommend)]
> +// SAFETY: Safe by the requirements on implementation of [`SimpleOwnableRefCounted`].
> +unsafe impl<T: SimpleOwnableRefCounted> RefCounted for T {
> +    fn inc_ref(&self) {
> +        SimpleOwnableRefCounted::inc_ref(self);
> +    }
> +
> +    unsafe fn dec_ref(this: NonNull<Self>) {
> +        // SAFETY: Safe by the requirements on implementation of
> +        // [`SimpleOwnableRefCounted::dec_ref()`].
> +        unsafe { SimpleOwnableRefCounted::dec_ref(this) };
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

