Return-Path: <linux-kernel+bounces-340333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E16D9871BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EF71C24C47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258241AD9C8;
	Thu, 26 Sep 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UNIXSCAL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DBD347B4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347245; cv=none; b=tOSOIDhMSltFAaPLgSBuzXFhY/OwhkaJE97u5HmlaKjRUZoCyCkB14ZkMFzn83YrG09J9kpCRmCUzcwW23MDZO3dfAAmvF48FqFJ8q7VU8d9o4wZKfQlJXSNbtpghHd+NRS9nfizoc1f6bPOf3v9OF/OKqVAXD09+uJ2eeqeebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347245; c=relaxed/simple;
	bh=hnyrzhr8pU2Wi2cjl24Vt94hls0410SSLH0DPly9Bmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxPV86UvgDqvcOSPz3WyI+v92lcN4CBCX6Vl/QqVvG3SmKNtxvOFbNgGyMY0yqphemK9ZszrXv/17TWaWVy3yNw+VeBb0N4BKHanPX+3abWV8QLaCgCEJjjcodeEtXC1NPmSoyl+fDKDBDn8D/M9aXUqtvvGchwCUFKA5cr3oAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=UNIXSCAL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso12433065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1727347241; x=1727952041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xDdqrIxPMU7q58Y48sL69W3lZfMrhtN9sxEp6xuX9c=;
        b=UNIXSCAL5IFgTeXXhjkHZcSMJTatNdhoU8V/rZdFvinPXPR2cw4LGfLUTcYRPss3ta
         f50Tqch1og7F3+PWYTchLfnrrUvITLag9BtVGJHJ3YryGC6uiBUZFMbaKE4t3Y5qE6x7
         qUrmCp+J/nj6suUpiyQ6gQ1xGdoPZx/Jg0a/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347241; x=1727952041;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xDdqrIxPMU7q58Y48sL69W3lZfMrhtN9sxEp6xuX9c=;
        b=XZmYR0g/KJNwNPavNd1u3Q0OXs4RMbfR26PdTat1/er16/yaAqM74wGAJieuDOBy+h
         s/C9hZeRjLXun3oZC1GkjXNOJkcK6AL9V2/YR33K6QAPmz619nXwBPKOZSdu3/+MwLIm
         UCzAFKSrQv//hJy3EOdlcAe79gc+AWSLPlNGXoE+xxW/DLnoQsiWQ/jxnBEoWWfu65RF
         ji6fARElfr3rySYWmY/dvq5NdjsKWllMUmfaOjx9fekvT1x2GvBQUca4FFxvXVgo3kCK
         GQtMYNgKy+/qKB7ZB4hDN+BRp5C1LAX9x9v0tTBqykzfP8GMAkpr3sqck+0RRDYEDANr
         9v4A==
X-Forwarded-Encrypted: i=1; AJvYcCUNRd94wIYbejVHDIXXa1Wu7dtRLCdn+gk1nS/LAjINVvrgm5FwKSUS5mYgGrLRpmUCik/ihD83+xcnyyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzalb4Pjouj/LMFYarwe6aOYkkq77fOST7TrdcRk5ckN79MQbcK
	+selFXdiPFkh2m6IARgE8NUXIlNg/hTi2PZkwViY8Z/VswZcYlJPUWfBv2dlvew=
X-Google-Smtp-Source: AGHT+IGoJi4J3lWcH5AB4gPr501DyDR07vvHpQObcB51fggIjz9GCgYHS+f4rmXntsamWI/WX4Qzww==
X-Received: by 2002:adf:f0c5:0:b0:371:6fc7:d45d with SMTP id ffacd0b85a97d-37ccdb39c26mr1495872f8f.2.1727347240710;
        Thu, 26 Sep 2024 03:40:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ccdb8e471sm1775128f8f.13.2024.09.26.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:40:39 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:40:37 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg KH <gregkh@linuxfoundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
Message-ID: <ZvU6JQEN_92nPH4k@phenom.ffwll.local>
Mail-Followup-To: Benno Lossin <benno.lossin@proton.me>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
References: <20240925205244.873020-1-benno.lossin@proton.me>
 <20240925205244.873020-2-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925205244.873020-2-benno.lossin@proton.me>
X-Operating-System: Linux phenom 6.10.6-amd64 

On Wed, Sep 25, 2024 at 08:53:05PM +0000, Benno Lossin wrote:
> When reading data from userspace, hardware or other external untrusted
> sources, the data must be validated before it is used for logic within
> the kernel. This abstraction provides a generic newtype wrapper
> `Untrusted`; it prevents direct access to the inner type. The only way
> to use the underlying data is to call `.validate()` on such a value.
> 
> Doing so utilizes the new `Validate` trait that is responsible for all
> of the validation logic. This trait gives access to the inner value of
> `Untrusted` by means of another newtype wrapper `Unvalidated`. In
> contrast to `Untrusted`, `Unvalidated` allows direct access and
> additionally provides several helper functions for slices.
> 
> Having these two different newtype wrappers is an idea from Simona
> Vetter. It has several benefits: it fully prevents safe access to the
> underlying value of `Untrusted` without going through the `Validate`
> API. Additionally, it allows one to grep for validation logic by simply
> looking for `Unvalidated<`.
> 
> Any API that reads data from an untrusted source should return
> `Untrusted<T>` where `T` is the type of the underlying untrusted data.
> This generic allows other abstractions to return their custom type
> wrapped by `Untrusted`, signaling to the caller that the data must be
> validated before use. This allows those abstractions to be used both in
> a trusted and untrusted manner, increasing their generality.
> Additionally, using the arbitrary self types feature, APIs can be
> designed to explicitly read untrusted data:
> 
>     impl MyCustomDataSource {
>         pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
>     }
> 
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

I think this looks overall nifty, bunch of thoughts below.

Cheers, Sima

> ---
>  rust/kernel/lib.rs      |   1 +
>  rust/kernel/validate.rs | 602 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 603 insertions(+)
>  create mode 100644 rust/kernel/validate.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f10b06a78b9d..3125936eae45 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -54,6 +54,7 @@
>  pub mod time;
>  pub mod types;
>  pub mod uaccess;
> +pub mod validate;
>  pub mod workqueue;
>  
>  #[doc(hidden)]
> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> new file mode 100644
> index 000000000000..b325349e7dc3
> --- /dev/null
> +++ b/rust/kernel/validate.rs
> @@ -0,0 +1,604 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types for handling and validating untrusted data.
> +//!
> +//! # Overview
> +//!
> +//! Untrusted data is marked using the [`Untrusted<T>`] type. See [Rationale](#rationale) for the
> +//! reasons to mark untrusted data throught the kernel. It is a totally opaque wrapper, it is not
> +//! possible to read the data inside; but it is possible to [`Untrusted::write`] into it.
> +//!
> +//! The only way to "access" the data inside an [`Untrusted<T>`] is to [`Untrusted::validate`] it;
> +//! turning it into a different form using the [`Validate`] trait. That trait receives the data in
> +//! the form of [`Unvalidated<T>`], which in contrast to [`Untrusted<T>`], allows access to the
> +//! underlying data. It additionally provides several utility functions to simplify validation.
> +//!
> +//! # Rationale
> +//!
> +//! When reading data from an untrusted source, it must be validated before it can be used for
> +//! logic. For example, this is a very bad idea:
> +//!
> +//! ```
> +//! # fn read_bytes_from_network() -> Box<[u8]> {
> +//! #     Box::new([1, 0], kernel::alloc::flags::GFP_KERNEL).unwrap()
> +//! # }
> +//! let bytes: Box<[u8]> = read_bytes_from_network();
> +//! let data_index = bytes[0];
> +//! let data = bytes[usize::from(data_index)];
> +//! ```
> +//!
> +//! While this will not lead to a memory violation (because the array index checks the bounds), it
> +//! might result in a kernel panic. For this reason, all untrusted data must be wrapped in
> +//! [`Untrusted<T>`]. This type only allows validating the data or passing it along, since copying
> +//! data from one userspace buffer into another is allowed for untrusted data.
> +
> +use crate::init::Init;
> +use core::{
> +    mem::MaybeUninit,
> +    ops::{Index, IndexMut},
> +    ptr, slice,
> +};
> +
> +/// Untrusted data of type `T`.
> +///
> +/// When reading data from userspace, hardware or other external untrusted sources, the data must
> +/// be validated before it is used for logic within the kernel. To do so, the [`validate()`]
> +/// function exists and uses the [`Validate`] trait.
> +///
> +/// Also see the [module] description.
> +///
> +/// [`validate()`]: Self::validate
> +/// [module]: self
> +#[repr(transparent)]
> +pub struct Untrusted<T: ?Sized>(Unvalidated<T>);
> +
> +impl<T: ?Sized> Untrusted<T> {
> +    /// Marks the given value as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// # mod bindings { pub(crate) unsafe fn read_foo_info() -> [u8; 4] { todo!() } };
> +    /// fn read_foo_info() -> Untrusted<[u8; 4]> {
> +    ///     // SAFETY: just an FFI call without preconditions.
> +    ///     Untrusted::new(unsafe { bindings::read_foo_info() })
> +    /// }
> +    /// ```
> +    pub fn new(value: T) -> Self
> +    where
> +        T: Sized,
> +    {
> +        Self(Unvalidated::new(value))
> +    }
> +
> +    /// Marks the value behind the reference as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// In this imaginary example there exists the `foo_hardware` struct on the C side, as well as
> +    /// a `foo_hardware_read` function that reads some data directly from the hardware.
> +    /// ```
> +    /// use kernel::{error, types::Opaque, validate::Untrusted};
> +    /// use core::ptr;
> +    ///
> +    /// # #[allow(non_camel_case_types)]
> +    /// # mod bindings {
> +    /// #     pub(crate) struct foo_hardware;
> +    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardware, _len: &mut usize) -> *mut u8 {
> +    /// #         todo!()
> +    /// #     }
> +    /// # }
> +    /// struct Foo(Opaque<bindings::foo_hardware>);
> +    ///
> +    /// impl Foo {
> +    ///     fn read(&mut self, mut len: usize) -> Result<&Untrusted<[u8]>> {
> +    ///         // SAFETY: just an FFI call without preconditions.
> +    ///         let data: *mut u8 = unsafe { bindings::foo_hardware_read(self.0.get(), &mut len) };
> +    ///         let data = error::from_err_ptr(data)?;
> +    ///         let data = ptr::slice_from_raw_parts(data, len);
> +    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid for reads as long as the
> +    ///         // `foo_hardware` object exists. That function updated the
> +    ///         let data = unsafe { &*data };
> +    ///         Ok(Untrusted::new_ref(data))
> +    ///     }
> +    /// }
> +    /// ```
> +    pub fn new_ref(value: &T) -> &Self {
> +        let ptr: *const T = value;
> +        // CAST: `Self` and `Unvalidated` are `repr(transparent)` and contain a `T`.
> +        let ptr = ptr as *const Self;
> +        // SAFETY: `ptr` came from a shared reference valid for `'a`.
> +        unsafe { &*ptr }
> +    }
> +
> +    /// Marks the value behind the reference as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// In this imaginary example there exists the `foo_hardware` struct on the C side, as well as
> +    /// a `foo_hardware_read` function that reads some data directly from the hardware.
> +    /// ```
> +    /// use kernel::{error, types::Opaque, validate::Untrusted};
> +    /// use core::ptr;
> +    ///
> +    /// # #[allow(non_camel_case_types)]
> +    /// # mod bindings {
> +    /// #     pub(crate) struct foo_hardware;
> +    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardware, _len: &mut usize) -> *mut u8 {
> +    /// #         todo!()
> +    /// #     }
> +    /// # }
> +    /// struct Foo(Opaque<bindings::foo_hardware>);
> +    ///
> +    /// impl Foo {
> +    ///     fn read(&mut self, mut len: usize) -> Result<&mut Untrusted<[u8]>> {
> +    ///         // SAFETY: just an FFI call without preconditions.
> +    ///         let data: *mut u8 = unsafe { bindings::foo_hardware_read(self.0.get(), &mut len) };
> +    ///         let data = error::from_err_ptr(data)?;
> +    ///         let data = ptr::slice_from_raw_parts_mut(data, len);
> +    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid for reads as long as the
> +    ///         // `foo_hardware` object exists. That function updated the
> +    ///         let data = unsafe { &mut *data };
> +    ///         Ok(Untrusted::new_mut(data))
> +    ///     }
> +    /// }
> +    /// ```
> +    pub fn new_mut(value: &mut T) -> &mut Self {
> +        let ptr: *mut T = value;
> +        // CAST: `Self` and `Unvalidated` are `repr(transparent)` and contain a `T`.
> +        let ptr = ptr as *mut Self;
> +        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
> +        unsafe { &mut *ptr }
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validate`] trait on how to implement it.
> +    pub fn validate<'a, V: Validate<&'a Unvalidated<T>>>(&'a self) -> Result<V, V::Err> {
> +        V::validate(&self.0)
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validate`] trait on how to implement it.
> +    pub fn validate_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
> +        &'a mut self,
> +    ) -> Result<V, V::Err> {
> +        V::validate(&mut self.0)
> +    }
> +
> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted = Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write(&mut self, value: impl Init<T>) {
> +        let ptr: *mut T = &mut self.0 .0;
> +        // SAFETY: `ptr` came from a mutable reference and the value is overwritten before it is
> +        // read.
> +        unsafe { ptr::drop_in_place(ptr) };
> +        // SAFETY: `ptr` came from a mutable reference and the initializer cannot error.
> +        match unsafe { value.__init(ptr) } {
> +            Ok(()) => {}
> +        }
> +    }

So I think this doesn't work for a few reasons:

- there's a lot of unsafe both here and when using this (even without
  MaybeUninit), at least if I understand things correctly. And forcing
  unsafe for something that inheritedly does not break any of the rust
  memory safety rules feels silly.

- it also looks awkward, because you have the special versions
  write_uninit and write_uninit_slice, and imo if our write isn't good
  enought to just work with abritrary box/container types, it's not good.

- it doesn't actually work for one of the main uaccess.rs use-cases beyond
  just enabling the current interface. Example in pseudo-rust:

  struct IoctlParams {
  	input: u32,
	ouptut: u32,
  }

  The thing is that ioctl that use the struct approach like drm does, use
  the same struct if there's both input and output paramterers, and
  furthermore we are not allowed to overwrite the entire struct because
  that breaks ioctl restarting. So the flow is roughly

  let userptr : UserSlice;
  let params : Untrusted<IoctlParams>;

  userptr.read(params));

  // validate params, do something interesting with it params.input

  // this is _not_ allowed to overwrite params.input but must leave it
  // unchanged

  params.write(|x| { x.output = 42; });

  userptr.write(params);

  Your current write doesn't allow this case, and I think that's not good
  enough. The one I propsed in private does:

  Untrusted<T>::write(&mut self, Fn(&mut T)->())

  It's not perfect because it allows you to do other stuff than writing,
  but it's still pretty good by limiting any potentially dangerous code to
  the provided closure. And with these of protection apis we need to
  strike the right balance between as much protection as possible while
  still allowing users to get the job done.

  Now I guess you can do this with your write too using a copy constructor
  approach, but that will result in less efficient code and it's probably
  also too much functional programming design for kernel developers to
  cope with.

> +
> +    /// Turns a slice of untrusted values into an untrusted slice of values.
> +    pub fn transpose_slice(slice: &[Untrusted<T>]) -> &Untrusted<[T]>
> +    where
> +        T: Sized,
> +    {
> +        let ptr = slice.as_ptr().cast::<T>();
> +        // SAFETY: `ptr` and `len` come from the same slice reference.
> +        let slice = unsafe { slice::from_raw_parts(ptr, slice.len()) };
> +        Untrusted::new_ref(slice)
> +    }
> +
> +    /// Turns a slice of uninitialized, untrusted values into an untrusted slice of uninitialized
> +    /// values.
> +    pub fn transpose_slice_uninit(
> +        slice: &[MaybeUninit<Untrusted<T>>],
> +    ) -> &Untrusted<[MaybeUninit<T>]>

So these and some of the related functions to handle slice of box vs box
of slice feel a bit awkward. I think we can do better if we rename
Untrusted and Unvalidated to UntrustedBox and UnvalidatedBox, and then
make Untrusted and Unvalidated traits, with implementations for
UntrustedBox<T>, [Untrusted<T>], and all the others we want.

I expect that in the future we'll get more boxes with special semantics
that we want to use together with Untrusted, not just [] and MaybeUninit.
One example would be when the Untrusted data is shared with userspace
(mmap()ed into both kernel and userspace for example for a ringbuffer), in
which case the data is both Untrusted but also SharedUnsafe or whatever
we'll call memory that's fundamentally breaking the rust memory model
because there's no exclusive access (userspace can always do whatever it
feels like), and all access has to go through at least
READ_ONCE/WRITE_ONCE from the C side, or often even full blown atomics.

And that memory is not MaybeUninit, because we have to initialize it
before userspace can mmap it, for otherwise it's an information leak and
hence security issue.

tldr; I think going with traits for Untrusted and Unvalidated here will be
worth it, even if a bit more pain at first. Plus cleaner interfaces.

> +    where
> +        T: Sized,
> +    {
> +        let ptr = slice.as_ptr().cast::<MaybeUninit<T>>();
> +        // SAFETY: `ptr` and `len` come from the same mutable slice reference.
> +        let slice = unsafe { slice::from_raw_parts(ptr, slice.len()) };
> +        Untrusted::new_ref(slice)
> +    }
> +
> +    /// Turns a slice of uninitialized, untrusted values into an untrusted slice of uninitialized
> +    /// values.
> +    pub fn transpose_slice_uninit_mut(
> +        slice: &mut [MaybeUninit<Untrusted<T>>],
> +    ) -> &mut Untrusted<[MaybeUninit<T>]>
> +    where
> +        T: Sized,
> +    {
> +        // CAST: `MaybeUninit<T>` and `MaybeUninit<Untrusted<T>>` have the same layout.
> +        let ptr = slice.as_mut_ptr().cast::<MaybeUninit<T>>();
> +        // SAFETY: `ptr` and `len` come from the same mutable slice reference.
> +        let slice = unsafe { slice::from_raw_parts_mut(ptr, slice.len()) };
> +        Untrusted::new_mut(slice)
> +    }
> +}
> +
> +impl<T> Untrusted<MaybeUninit<T>> {
> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted = Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write_uninit<E>(&mut self, value: impl Init<T, E>) -> Result<&mut Untrusted<T>, E> {
> +        let ptr: *mut MaybeUninit<T> = &mut self.0 .0;
> +        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
> +        let ptr = ptr.cast::<T>();
> +        // SAFETY: `ptr` came from a reference and if `Err` is returned, the underlying memory is
> +        // considered uninitialized.
> +        unsafe { value.__init(ptr) }.map(|()| {
> +            let this = self.0.raw_mut();
> +            // SAFETY: we initialized the memory above.
> +            Untrusted::new_mut(unsafe { this.assume_init_mut() })
> +        })
> +    }
> +}
> +
> +impl<T> Untrusted<[MaybeUninit<T>]> {
> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted = Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write_uninit_slice<E>(
> +        &mut self,
> +        value: impl Init<[T], E>,
> +    ) -> Result<&mut Untrusted<[T]>, E> {
> +        let ptr: *mut [MaybeUninit<T>] = &mut self.0 .0;
> +        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
> +        let ptr = ptr as *mut [T];
> +        // SAFETY: `ptr` came from a reference and if `Err` is returned, the underlying memory is
> +        // considered uninitialized.
> +        unsafe { value.__init(ptr) }.map(|()| {
> +            let this = self.0.raw_mut().as_mut_ptr();
> +            // CAST: `MaybeUninit<T>` is `repr(transparent)`.
> +            let this = this.cast::<T>();
> +            // SAFETY: `this` and `len` came from the same slice reference.
> +            let this = unsafe { slice::from_raw_parts_mut(this, self.0.len()) };
> +            Untrusted::new_mut(this)
> +        })
> +    }
> +}
> +
> +/// Marks types that can be used as input to [`Validate::validate`].
> +pub trait ValidateInput: private::Sealed + Sized {}

I guess even if we go with making Unvalidated a trait we might still need
this one to seal it?

> +
> +mod private {
> +    pub trait Sealed {}
> +}
> +
> +impl<'a, T: ?Sized> private::Sealed for &'a Unvalidated<T> {}
> +impl<'a, T: ?Sized> ValidateInput for &'a Unvalidated<T> {}
> +
> +impl<'a, T: ?Sized> private::Sealed for &'a mut Unvalidated<T> {}
> +impl<'a, T: ?Sized> ValidateInput for &'a mut Unvalidated<T> {}
> +
> +/// Validates untrusted data.
> +///
> +/// # Examples
> +///
> +/// The simplest way to validate data is to just implement `Validate<&Unvalidated<[u8]>>` for the
> +/// type that you wish to validate:
> +///
> +/// ```
> +/// use kernel::{
> +///     error::{code::EINVAL, Error},
> +///     str::{CStr, CString},
> +///     validate::{Unvalidated, Validate},
> +/// };
> +///
> +/// struct Data {
> +///     flags: u8,
> +///     name: CString,
> +/// }
> +///
> +/// impl Validate<&Unvalidated<[u8]>> for Data {
> +///     type Err = Error;
> +///
> +///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +///         let raw = unvalidated.raw();
> +///         let (&flags, name) = raw.split_first().ok_or(EINVAL)?;
> +///         let name = CStr::from_bytes_with_nul(name)?.to_cstring()?;
> +///         Ok(Data { flags, name })
> +///     }
> +/// }
> +/// ```
> +///
> +/// This approach copies the data and requires allocation. If you want to avoid the allocation and
> +/// copying the data, you can borrow from the input like this:
> +///
> +/// ```
> +/// use kernel::{
> +///     error::{code::EINVAL, Error},
> +///     str::CStr,
> +///     validate::{Unvalidated, Validate},
> +/// };
> +///
> +/// struct Data<'a> {
> +///     flags: u8,
> +///     name: &'a CStr,
> +/// }
> +///
> +/// impl<'a> Validate<&'a Unvalidated<[u8]>> for Data<'a> {
> +///     type Err = Error;
> +///
> +///     fn validate(unvalidated: &'a Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +///         let raw = unvalidated.raw();
> +///         let (&flags, name) = raw.split_first().ok_or(EINVAL)?;
> +///         let name = CStr::from_bytes_with_nul(name)?;
> +///         Ok(Data { flags, name })
> +///     }
> +/// }
> +/// ```
> +///
> +/// If you need to in-place validate your data, you currently need to resort to `unsafe`:
> +///
> +/// ```
> +/// use kernel::{
> +///     error::{code::EINVAL, Error},
> +///     str::CStr,
> +///     validate::{Unvalidated, Validate},
> +/// };
> +/// use core::mem;
> +///
> +/// // Important: use `repr(C)`, this ensures a linear layout of this type.
> +/// #[repr(C)]
> +/// struct Data {
> +///     version: u8,
> +///     flags: u8,
> +///     _reserved: [u8; 2],
> +///     count: u64,
> +///     // lots of other fields...
> +/// }
> +///
> +/// impl Validate<&Unvalidated<[u8]>> for &Data {
> +///     type Err = Error;
> +///
> +///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +///         let raw = unvalidated.raw();
> +///         if raw.len() < mem::size_of::<Data>() {
> +///             return Err(EINVAL);
> +///         }
> +///         // can only handle version 0
> +///         if raw[0] != 0 {
> +///             return Err(EINVAL);
> +///         }
> +///         // version 0 only uses the lower 4 bits of flags
> +///         if raw[1] & 0xf0 != 0 {
> +///             return Err(EINVAL);
> +///         }
> +///         let ptr = raw.as_ptr();
> +///         // CAST: `Data` only contains integers and has `repr(C)`.
> +///         let ptr = ptr.cast::<Data>();
> +///         // SAFETY: `ptr` came from a reference and the cast above is valid.
> +///         Ok(unsafe { &*ptr })
> +///     }
> +/// }
> +/// ```
> +///
> +/// To be able to modify the parsed data, while still supporting zero-copy, you can implement
> +/// `Validate<&mut Unvalidated<[u8]>>`:
> +///
> +/// ```
> +/// use kernel::{
> +///     error::{code::EINVAL, Error},
> +///     str::CStr,
> +///     validate::{Unvalidated, Validate},
> +/// };
> +/// use core::mem;
> +///
> +/// // Important: use `repr(C)`, this ensures a linear layout of this type.
> +/// #[repr(C)]
> +/// struct Data {
> +///     version: u8,
> +///     flags: u8,
> +///     _reserved: [u8; 2],
> +///     count: u64,
> +///     // lots of other fields...
> +/// }
> +///
> +/// impl Validate<&mut Unvalidated<[u8]>> for &Data {
> +///     type Err = Error;

I think we should make that one the default, but not sure that's doable
with associated types instead of generics.

The input parameter should definitely default to the output paramter,
because often they're just exactly the same e.g. when validating ioctl
input structures.

On this version you've also left out the in-place validation (originally
validate_bytes), but we can add that later on when a need arises I guess.
Or do you think it's just not a good idea in general?

> +///
> +///     fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +///         let raw = unvalidated.raw_mut();
> +///         if raw.len() < mem::size_of::<Data>() {
> +///             return Err(EINVAL);
> +///         }
> +///         match raw[0] {
> +///             0 => {},
> +///             1 => {
> +///                 // version 1 implicitly sets the first bit.
> +///                 raw[1] |= 1;
> +///             },
> +///             // can only handle version 0 and 1
> +///             _ => return Err(EINVAL),
> +///         }
> +///         // version 0 and 1 only use the lower 4 bits of flags
> +///         if raw[1] & 0xf0 != 0 {
> +///             return Err(EINVAL);
> +///         }
> +///         if raw[1] == 0 {}
> +///         let ptr = raw.as_ptr();
> +///         // CAST: `Data` only contains integers and has `repr(C)`.
> +///         let ptr = ptr.cast::<Data>();
> +///         // SAFETY: `ptr` came from a reference and the cast above is valid.
> +///         Ok(unsafe { &*ptr })
> +///     }
> +/// }
> +/// ```
> +pub trait Validate<I: ValidateInput>: Sized {
> +    /// Validation error.
> +    type Err;
> +
> +    /// Validate the given untrusted data and parse it into the output type.
> +    fn validate(unvalidated: I) -> Result<Self, Self::Err>;
> +}
> +
> +/// Unvalidated data of type `T`.
> +#[repr(transparent)]
> +pub struct Unvalidated<T: ?Sized>(T);
> +
> +impl<T: ?Sized> Unvalidated<T> {
> +    fn new(value: T) -> Self
> +    where
> +        T: Sized,
> +    {
> +        Self(value)
> +    }
> +
> +    fn new_ref(value: &T) -> &Self {
> +        let ptr: *const T = value;
> +        // CAST: `Self` is `repr(transparent)` and contains a `T`.
> +        let ptr = ptr as *const Self;
> +        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
> +        unsafe { &*ptr }
> +    }
> +
> +    fn new_mut(value: &mut T) -> &mut Self {
> +        let ptr: *mut T = value;
> +        // CAST: `Self` is `repr(transparent)` and contains a `T`.
> +        let ptr = ptr as *mut Self;
> +        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
> +        unsafe { &mut *ptr }
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validate`] trait on how to implement it.
> +    pub fn validate_ref<'a, V: Validate<&'a Unvalidated<T>>>(&'a self) -> Result<V, V::Err> {
> +        V::validate(self)
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validate`] trait on how to implement it.
> +    pub fn validate_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
> +        &'a mut self,
> +    ) -> Result<V, V::Err> {
> +        V::validate(self)
> +    }
> +
> +    /// Gives immutable access to the underlying value.
> +    pub fn raw(&self) -> &T {
> +        &self.0
> +    }
> +
> +    /// Gives mutable access to the underlying value.
> +    pub fn raw_mut(&mut self) -> &mut T {
> +        &mut self.0
> +    }
> +}
> +
> +impl<T, I> Index<I> for Unvalidated<[T]>
> +where
> +    I: slice::SliceIndex<[T]>,
> +{
> +    type Output = Unvalidated<I::Output>;
> +
> +    fn index(&self, index: I) -> &Self::Output {
> +        Unvalidated::new_ref(self.0.index(index))
> +    }
> +}
> +
> +impl<T, I> IndexMut<I> for Unvalidated<[T]>
> +where
> +    I: slice::SliceIndex<[T]>,
> +{
> +    fn index_mut(&mut self, index: I) -> &mut Self::Output {
> +        Unvalidated::new_mut(self.0.index_mut(index))
> +    }
> +}
> +
> +/// Immutable unvalidated slice iterator.
> +pub struct Iter<'a, T>(slice::Iter<'a, T>);
> +
> +/// Mutable unvalidated slice iterator.
> +pub struct IterMut<'a, T>(slice::IterMut<'a, T>);
> +
> +impl<'a, T> Iterator for Iter<'a, T> {
> +    type Item = &'a Unvalidated<T>;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.0.next().map(Unvalidated::new_ref)
> +    }
> +}
> +
> +impl<'a, T> IntoIterator for &'a Unvalidated<[T]> {
> +    type Item = &'a Unvalidated<T>;
> +    type IntoIter = Iter<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        Iter(self.0.iter())
> +    }
> +}
> +
> +impl<'a, T> Iterator for IterMut<'a, T> {
> +    type Item = &'a mut Unvalidated<T>;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.0.next().map(Unvalidated::new_mut)
> +    }
> +}
> +
> +impl<'a, T> IntoIterator for &'a mut Unvalidated<[T]> {
> +    type Item = &'a mut Unvalidated<T>;
> +    type IntoIter = IterMut<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        IterMut(self.0.iter_mut())
> +    }
> +}
> +
> +impl<T> Unvalidated<[T]> {

Hm there's no Container trait that has all these in rust? Kinda surprising
tbh ...

> +    /// Returns the number of elements in the underlying slice.
> +    pub fn len(&self) -> usize {
> +        self.0.len()
> +    }
> +
> +    /// Returns true if the underlying slice has a length of 0.
> +    pub fn is_empty(&self) -> bool {
> +        self.0.is_empty()
> +    }
> +
> +    /// Iterates over all items and validates each of them individually.
> +    pub fn validate_iter<'a, V: Validate<&'a Unvalidated<T>>>(
> +        &'a self,
> +    ) -> impl Iterator<Item = Result<V, V::Err>> + 'a {
> +        self.into_iter().map(|item| V::validate(item))
> +    }
> +
> +    /// Iterates over all items and validates each of them individually.
> +    pub fn validate_iter_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
> +        &'a mut self,
> +    ) -> impl Iterator<Item = Result<V, V::Err>> + 'a {
> +        self.into_iter().map(|item| V::validate(item))
> +    }
> +}
> -- 
> 2.46.0
> 
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

