Return-Path: <linux-kernel+bounces-273719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA094946CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE8F1C214BE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D914F98;
	Sun,  4 Aug 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsW4d7Z5"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE0FC19;
	Sun,  4 Aug 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722754521; cv=none; b=Vl6mXMOjKiFwUXfPLcESNdRdebRHvk/9pYkekHf3UGOZS/cMfnIp8uCmDuRu0Fkx7siprXkUIAOt1K3Qk4QLPJU/1QWklt4CoTrVR8VK7SMB2qim/9cwjD4Bt5GWpLHMy9Vou0Z+CwswRSXX1/RWo5qyvfEwh23vFfGlYRr8wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722754521; c=relaxed/simple;
	bh=6D/+j4eNn56ySxxT28Z42uljRo92JoDAZoLs78OI/2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+0KA5nnNxF1i3E045PGw/82l6Gbe0FBgz2IAf9TQLE+KNS6UuGHvRWGjS5+taFUem5k0DZJAiiDnEi/7e87WU4TvypGGHlcCefotooDu7JRvmlqC9QmnEL7wCh5mY80aiL0Fw6qBzKm4RI94Vf/Qw+2q9wPTnCVP08ehUimV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsW4d7Z5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7a4668f07so52265936d6.1;
        Sat, 03 Aug 2024 23:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722754518; x=1723359318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy8FGn/BTbcPJC5MMyxJCn4sZraMIh/6JsCawGK/LUY=;
        b=PsW4d7Z5H+7AWyc09N4hpnD+L27nIgTNyi4xjxkPsgzhi8L1ams7wBq2JpIP9XJiey
         nuvPpoLDdT8AGRrJZ7BAG7LOmu6Kf+eKHzAC0pEgdRT6jQWiZLooQvqDI+JWbY4Nu61A
         Lhc223i87rPaIDMCh/7s9Ym8B9/sXVpRR0pf5FqPX1DpR6utB4ZgELRXL65HMdHUl3Bd
         5p/SJViEjcYYEyX/iPaZ6EHYgZnFHqLuzhk6GvyzhMmudbs2e2eNXbiXuQqhe8xZ6kSi
         Fl9ZYSsV/KS8Dvv3jyg2kWsathU121aUl1fi5LVt6duCJSE2rYNg5p4uUhhKt9Sl8YRy
         2PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722754518; x=1723359318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy8FGn/BTbcPJC5MMyxJCn4sZraMIh/6JsCawGK/LUY=;
        b=KCZVG0Do3p97INLKfSElQ9S9yIiRnX3SGQLbhQD3GzkW8X7iMO+V/NkLHQHT6/ZUxc
         WV32kpfHoWDIB6uIQFqS3RiPEAyv++tKNrdlLsdji/5Vq2Yvu0ZGPmO/PNUpUmLyIbXl
         OHIDjWlwl6uTQ5oEZDUJHRbsQLkZqblTboB3ZfLtsiMX3Oy/aCppKdaIx27Cb/PpEd1w
         hp+HuYkmErv6dr5QXjgoS4D3Mm7mluap3F43iQy20lA3xs2jKy4vFO/6n9rIEOOAbzKC
         8fx1TktNQBxGUderIzT5GOetAOMefOwUR/fyVTyJtpiLwZbJvuWML4JmGo5ubasi43YT
         o09A==
X-Forwarded-Encrypted: i=1; AJvYcCUPHS2xlibDzDf+fuMOs2nSriLMv/pvHL/bkpi6yMU+KUnFueD5dea+yHDRlwM766d/gIRjEdxOMa75/2iik8Yz2UXsk+nG+72CZw99crtWjlf0LLuSC3FXJG3T0HCoKB15FvfBl15aa7OhTN4=
X-Gm-Message-State: AOJu0Yz91e62LE0zzJ080bVwujvojS7eZk4hlRWlu9VUP9FoCoY1XmzO
	h2NWSODv6aKsdhCU4QU6va/tD7dVwyGq8JPW1jnHK7NhAE7wiDPA
X-Google-Smtp-Source: AGHT+IEZzvju0oH2WTEc5x1rknfx0xEx4H+x73atNK4I8YNXMMBWEeXs6uVEgXnER87ogp6NHIi6rA==
X-Received: by 2002:a05:6214:5984:b0:6b0:6400:3b6f with SMTP id 6a1803df08f44-6bb9833d816mr132610476d6.8.1722754518089;
        Sat, 03 Aug 2024 23:55:18 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c760453sm23062286d6.26.2024.08.03.23.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 23:55:17 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id ECA84120006E;
	Sun,  4 Aug 2024 02:55:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 04 Aug 2024 02:55:16 -0400
X-ME-Sender: <xms:1CWvZpIRKWvW3XbCRf5rDSvmHyCc86PEnrwfa1vZRnduv-dmCGl6sQ>
    <xme:1CWvZlLD05xXPzVenzUVYZoI1SCIzKlvITMjCvhoBX9urLrOScD9NEzh2istzwPyd
    I4OE2OZY1KIqT-3-Q>
X-ME-Received: <xmr:1CWvZhsunipDn-SNX_oe5UgdTRYtYsBs7dZEQBTFNbfppr__9xKi3FL_lcdasw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeefiefhueeghfdtfedvudejgeeltdetjeduhfeltdefteduhfehveelfefg
    feeileenucffohhmrghinhepghhithhhuhgsrdgtohhmpddtjeeiledqshhouhhnugdqgh
    gvnhgvrhhitgdqughrohhprdhmugdpphhoihhnthgvrhdrrghspdgrshgpphhtrhdrshgr
    fhgvthihnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:1CWvZqZPjXID0EkXMPwMkppFrs9T3d00JlyEJMZlw9zG8OowyOCINA>
    <xmx:1CWvZgbSBVkPl1qOD_X4rheCCQmcswfl5JAXwOHuRbfUuvSaLLC_xw>
    <xmx:1CWvZuBsmnQxE5dvDBvEZHECr1u6TclVpT3epAVxHVQJrhGDn4sNfg>
    <xmx:1CWvZuYsr3T48hzVvm5FWyBZKFgbrewsFIDE_PVE5wusLS1cV0ZjfA>
    <xmx:1CWvZsqOpfF06P8zLqZtNZ0c8TdInOFVZ5XID9AU0VUVT4TzXKgksING>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 02:55:16 -0400 (EDT)
Date: Sat, 3 Aug 2024 23:54:20 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 08/25] rust: types: implement `Unique<T>`
Message-ID: <Zq8lnBvgqXAk1B5e@boqun-archlinux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-9-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801000641.1882-9-dakr@kernel.org>

On Thu, Aug 01, 2024 at 02:02:07AM +0200, Danilo Krummrich wrote:
> Implement the `Unique` type as a prerequisite for `Box` and `Vec`
> introduced in subsequent patches.
> 
> `Unique` serves as wrapper around a `NonNull`, but indicates that the
> possessor of this wrapper owns the referent.
> 
> This type already exists in Rust's core library, but, unfortunately, is
> exposed as unstable API and hence shouldn't be used in the kernel.
> 
> This implementation of `Unique` is almost identical, but mostly stripped
> down to the functionality we need for `Box` and `Vec`. Additionally, all
> unstable features are removed and / or replaced by stable ones.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

If I understand correctly, `Unique` does nothing unless the compiler
supports putting noalias at the corresponding IRs. If so, should this
depend on whether Rust compiler supports using `Unique` outside std
libraries?

Regards,
Boqun

> ---
>  rust/kernel/types.rs | 183 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index bd189d646adb..7cf89067b5fc 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -473,3 +473,186 @@ unsafe impl AsBytes for str {}
>  // does not have any uninitialized portions either.
>  unsafe impl<T: AsBytes> AsBytes for [T] {}
>  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
> +
> +/// A wrapper around a raw non-null `*mut T` that indicates that the possessor
> +/// of this wrapper owns the referent. Useful for building abstractions like
> +/// `Box<T>`, `Vec<T>`, `String`, and `HashMap<K, V>`.
> +///
> +/// Unlike `*mut T`, `Unique<T>` behaves "as if" it were an instance of `T`.
> +/// It implements `Send`/`Sync` if `T` is `Send`/`Sync`. It also implies
> +/// the kind of strong aliasing guarantees an instance of `T` can expect:
> +/// the referent of the pointer should not be modified without a unique path to
> +/// its owning Unique.
> +///
> +/// If you're uncertain of whether it's correct to use `Unique` for your purposes,
> +/// consider using `NonNull`, which has weaker semantics.
> +///
> +/// Unlike `*mut T`, the pointer must always be non-null, even if the pointer
> +/// is never dereferenced. This is so that enums may use this forbidden value
> +/// as a discriminant -- `Option<Unique<T>>` has the same size as `Unique<T>`.
> +/// However the pointer may still dangle if it isn't dereferenced.
> +///
> +/// Unlike `*mut T`, `Unique<T>` is covariant over `T`. This should always be correct
> +/// for any type which upholds Unique's aliasing requirements.
> +#[repr(transparent)]
> +pub struct Unique<T: ?Sized> {
> +    pointer: NonNull<T>,
> +    // NOTE: this marker has no consequences for variance, but is necessary
> +    // for dropck to understand that we logically own a `T`.
> +    //
> +    // For details, see:
> +    // https://github.com/rust-lang/rfcs/blob/master/text/0769-sound-generic-drop.md#phantom-data
> +    _marker: PhantomData<T>,
> +}
> +
> +/// `Unique` pointers are `Send` if `T` is `Send` because the data they
> +/// reference is unaliased. Note that this aliasing invariant is
> +/// unenforced by the type system; the abstraction using the
> +/// `Unique` must enforce it.
> +unsafe impl<T: Send + ?Sized> Send for Unique<T> {}
> +
> +/// `Unique` pointers are `Sync` if `T` is `Sync` because the data they
> +/// reference is unaliased. Note that this aliasing invariant is
> +/// unenforced by the type system; the abstraction using the
> +/// `Unique` must enforce it.
> +unsafe impl<T: Sync + ?Sized> Sync for Unique<T> {}
> +
> +impl<T: Sized> Unique<T> {
> +    /// Creates a new `Unique` that is dangling, but well-aligned.
> +    ///
> +    /// This is useful for initializing types which lazily allocate, like
> +    /// `Vec::new` does.
> +    ///
> +    /// Note that the pointer value may potentially represent a valid pointer to
> +    /// a `T`, which means this must not be used as a "not yet initialized"
> +    /// sentinel value. Types that lazily allocate must track initialization by
> +    /// some other means.
> +    #[must_use]
> +    #[inline]
> +    pub const fn dangling() -> Self {
> +        Unique {
> +            pointer: NonNull::dangling(),
> +            _marker: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> Unique<T> {
> +    /// Creates a new `Unique`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be non-null.
> +    #[inline]
> +    pub const unsafe fn new_unchecked(ptr: *mut T) -> Self {
> +        // SAFETY: the caller must guarantee that `ptr` is non-null.
> +        unsafe {
> +            Unique {
> +                pointer: NonNull::new_unchecked(ptr),
> +                _marker: PhantomData,
> +            }
> +        }
> +    }
> +
> +    /// Creates a new `Unique` if `ptr` is non-null.
> +    #[allow(clippy::manual_map)]
> +    #[inline]
> +    pub fn new(ptr: *mut T) -> Option<Self> {
> +        if let Some(pointer) = NonNull::new(ptr) {
> +            Some(Unique {
> +                pointer,
> +                _marker: PhantomData,
> +            })
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Acquires the underlying `*mut` pointer.
> +    #[must_use = "`self` will be dropped if the result is not used"]
> +    #[inline]
> +    pub const fn as_ptr(self) -> *mut T {
> +        self.pointer.as_ptr()
> +    }
> +
> +    /// Dereferences the content.
> +    ///
> +    /// The resulting lifetime is bound to self so this behaves "as if"
> +    /// it were actually an instance of T that is getting borrowed. If a longer
> +    /// (unbound) lifetime is needed, use `&*my_ptr.as_ptr()`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Safety requirements for this function are inherited from [NonNull::as_ref].
> +    ///
> +    #[must_use]
> +    #[inline]
> +    pub const unsafe fn as_ref(&self) -> &T {
> +        // SAFETY: the caller must guarantee that `self` meets all the
> +        // requirements for a reference.
> +        unsafe { self.pointer.as_ref() }
> +    }
> +
> +    /// Mutably dereferences the content.
> +    ///
> +    /// The resulting lifetime is bound to self so this behaves "as if"
> +    /// it were actually an instance of T that is getting borrowed. If a longer
> +    /// (unbound) lifetime is needed, use `&mut *my_ptr.as_ptr()`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Safety requirements for this function are inherited from [NonNull::as_mut].
> +    #[must_use]
> +    #[inline]
> +    pub unsafe fn as_mut(&mut self) -> &mut T {
> +        // SAFETY: the caller must guarantee that `self` meets all the
> +        // requirements for a mutable reference.
> +        unsafe { self.pointer.as_mut() }
> +    }
> +
> +    /// Casts to a pointer of another type.
> +    #[must_use = "`self` will be dropped if the result is not used"]
> +    #[inline]
> +    pub fn cast<U>(self) -> Unique<U> {
> +        Unique::from(self.pointer.cast())
> +    }
> +
> +    /// Acquires the underlying `*mut` pointer.
> +    #[must_use = "`self` will be dropped if the result is not used"]
> +    #[inline]
> +    pub const fn as_non_null(self) -> NonNull<T> {
> +        self.pointer
> +    }
> +}
> +
> +impl<T: ?Sized> Clone for Unique<T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: ?Sized> Copy for Unique<T> {}
> +
> +impl<T: ?Sized> From<&mut T> for Unique<T> {
> +    /// Converts a `&mut T` to a `Unique<T>`.
> +    ///
> +    /// This conversion is infallible since references cannot be null.
> +    #[inline]
> +    fn from(reference: &mut T) -> Self {
> +        Self::from(NonNull::from(reference))
> +    }
> +}
> +
> +impl<T: ?Sized> From<NonNull<T>> for Unique<T> {
> +    /// Converts a `NonNull<T>` to a `Unique<T>`.
> +    ///
> +    /// This conversion is infallible since `NonNull` cannot be null.
> +    #[inline]
> +    fn from(pointer: NonNull<T>) -> Self {
> +        Unique {
> +            pointer,
> +            _marker: PhantomData,
> +        }
> +    }
> +}
> -- 
> 2.45.2
> 

