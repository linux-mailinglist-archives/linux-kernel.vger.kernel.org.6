Return-Path: <linux-kernel+bounces-328495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC70C9784F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D56B21C73
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AC32AD17;
	Fri, 13 Sep 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XDvDVKZQ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14729CF4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241619; cv=none; b=nScwYKKZn8WNTqOSYBfrmQQuzf7lZZ1zMYuFc8xr7QaEUsQ1a8yUeCNXjtPQJNXFB5uPOsx6hjPKZ4tQ87PcvvpjG8nC26CZAtALZRxRtTeUJV0MpBZRFj+SuJ5lH7KNMEEM39jA3aJupq/DLIJDTbciIeihalufUN9L1iDFQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241619; c=relaxed/simple;
	bh=pkYLqcKa7oJgwcHnZDJU7Fx65WSpIzX1ksv/hWWVq3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMZEG1U9CQSdzFtyP7rc9yLb3iTR4bPTGyRU4mxzxbixg9heJfJzRRe9OqvfE1MBhzLDiGJxkPmYlnT9javZ6OjABXnrk4FzScq9vYAJEX24GP6motit/oLwPwHmNSNmuILFSnM1qcd0FnInqUkWhX0VFlgcqTkPRf+iR9YXPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=XDvDVKZQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cafda818aso21978075e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1726241615; x=1726846415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U55bD0XK9xAtOGCzaUk9mCMvdaSI+QcUnvCZwtiUzlI=;
        b=XDvDVKZQL4LMcMiXAFv8pXjJJM25uHwSM0VHKdRmShEraDVOYnc8Z1kTKvm3WPCmmd
         RZKPgAwtb3vPhnyZRRn8p6+mtbBwOyOnDlxcjBoPWLfi5ldzBWzJwKfeP5Bk7xngkSiz
         kn7EATJiZBlsBjivWss9CAANmT9DQ76Wico0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241615; x=1726846415;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U55bD0XK9xAtOGCzaUk9mCMvdaSI+QcUnvCZwtiUzlI=;
        b=FooY/MEWXmWghkIhP2scLEgLILp9GLH82KG7eKg9cwlYBPnTH/ajba2HSM6LnbkTJa
         LhK7BkeyuBDsBG9NYwrxH8YE6jgI6iZCfZLfTUzH4U4uLwAa4i7TbuJATO7rw9H8Ie/0
         plWRF5ibr/l5F2PD1Oe7UlCizMo5NdUBhhLUS20ob6/V8FrFCPKVZCsZ/f8GHrnrQ170
         NO4cEiLSnMWrVeLPKJC2NrRIp5BL4etK6SpoCCBmyWEgjPMvDB/Fq9tsMQ6OLO6UuYOV
         iFqz9JOZm/UcAHPn7IOv96aXq8WYPOLWgga/jIXWKm7hGV9O299PfBHaYrcmkEbSU9hi
         ndew==
X-Forwarded-Encrypted: i=1; AJvYcCVmScgkiYCrWlkhG51nqOUGn6snoyNbjkIMi/MnJ6UCxVorlJxovLF+w2RI9RqwP03puyT5VtW4gYH2T7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATLeiCLlkhXAvVs5zi6F3DjhFgdWTBCYfpy4WOe3U/VUjkRh1
	jehXhzSz0KV2Jf4gU3DWqoCqJELHh4VyWdg4DJosxrDVv8Y4YPYf1jYRqYZDch8=
X-Google-Smtp-Source: AGHT+IEHgKLYbwsqieMcCXj7RUXAJQdLBl6Ly1JDbk+pZzhMyTyV9c863qtQob8Kh/DchVJr97jIYQ==
X-Received: by 2002:a05:600c:3581:b0:42c:c8be:4217 with SMTP id 5b1f17b1804b1-42cdb53192dmr51731915e9.11.1726241614454;
        Fri, 13 Sep 2024 08:33:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc1374f61sm92153125e9.1.2024.09.13.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:33:34 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:33:31 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Message-ID: <ZuRbSxwlz1xWT1pG@phenom.ffwll.local>
Mail-Followup-To: Benno Lossin <benno.lossin@proton.me>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913112643.542914-1-benno.lossin@proton.me>
 <20240913112643.542914-2-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913112643.542914-2-benno.lossin@proton.me>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Fri, Sep 13, 2024 at 11:26:57AM +0000, Benno Lossin wrote:
> When reading data from userspace, hardware or other external untrusted
> sources, the data must be validated before it is used for logic within
> the kernel. This abstraction provides a generic newtype wrapper that
> prevents direct access to the inner type. It does allow access through
> the `untrusted()` method, but that should be a telltale sign to
> reviewers that untrusted data is being used at that point.
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
> To validate data, the `Validator` trait is introduced, readers of
> untrusted data should implement it for their type and move all of their
> validation and parsing logic into its `validate` function. That way
> reviewers and later contributors have a central location to consult for
> data validation.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Yes please. Some thoughts below. Fair warning, my rust is basic at best,
I'll mix things up probably.

> ---
>  rust/kernel/types.rs | 248 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 247 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9e7ca066355c..20ef04b1b417 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -8,9 +8,10 @@
>      cell::UnsafeCell,
>      marker::{PhantomData, PhantomPinned},
>      mem::{ManuallyDrop, MaybeUninit},
> -    ops::{Deref, DerefMut},
> +    ops::{Deref, DerefMut, Index},
>      pin::Pin,
>      ptr::NonNull,
> +    slice::SliceIndex,
>  };
>  
>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
> @@ -532,3 +533,248 @@ unsafe impl AsBytes for str {}
>  // does not have any uninitialized portions either.
>  unsafe impl<T: AsBytes> AsBytes for [T] {}
>  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
> +
> +/// Untrusted data of type `T`.
> +///
> +/// When reading data from userspace, hardware or other external untrusted sources, the data must
> +/// be validated before it is used for logic within the kernel. To do so, the [`validate()`]
> +/// function exists and uses the [`Validator`] trait. For raw bytes validation there also is the
> +/// [`validate_bytes()`] function.
> +///
> +///
> +/// [`validate()`]: Self::validate
> +/// [`validate_bytes()`]: Self::validate_bytes
> +#[repr(transparent)]
> +pub struct Untrusted<T: ?Sized>(T);

I think we could make this a bit more strict and instead of encouraging
people to put all their validation code into a Validator<T>, force
them to. Which means assuming apis wrap all untrusted stuff in
Untrusted<T> reviewers only need to look at validate implementations and
nothing else.

If I'm not too wrong with my rust I think this would work with slitting
Untrusted<T> into two types:

- Untrusted<T> is just a box you can't access, and the type returned by
  apis for untrusted data. It doesn't have any of the functions except
  validate and new_untrusted so that you can't get at the data at all.

- UntrustedUnsafe<T> does have all the accessors needed for validation,
  but you can't construct that outside of this module. Maybe simplest to
  just nest this within the Untrusted<T> box.

- Untrusted::validate does the unboxing and passes a reference to
  UntrustedUnsafe<T> to Validator::validate, to guarantee that all the
  validation code is in there and nowhere else. Similar for
  validate_bytes.

Of course people can still bypass this easily, but it gets a bit harder to
do so, and easier for reviewers to verify everything.

> +
> +impl<T: ?Sized> Untrusted<T> {
> +    /// Marks the given value as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # mod bindings { unsafe fn read_foo_info() -> [u8; 4] { todo!() } };
> +    /// fn read_foo_info() -> Untrusted<[u8; 4]> {
> +    ///     // SAFETY: just an FFI call without preconditions.
> +    ///     Untrusted::new_untrusted(unsafe { bindings::read_foo_info() })
> +    /// }
> +    /// ```
> +    pub fn new_untrusted(value: T) -> Self
> +    where
> +        T: Sized,
> +    {
> +        Self(value)
> +    }
> +
> +    /// Marks the value behind the reference as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// In this imaginary example there exists the `foo_hardware` struct on the C side, as well as
> +    /// a `foo_hardware_read` function that reads some data directly from the hardware.
> +    /// ```
> +    /// # mod bindings { struct foo_hardware; unsafe fn foo_hardware_read(_foo: *mut Foo, _len: &mut usize) -> *mut u8 { todo!() } };
> +    /// struct Foo(Opaque<bindings::foo_hardware>);
> +    ///
> +    /// impl Foo {
> +    ///     pub fn read(&mut self, mut len: usize) -> Result<&Untrusted<[u8]>> {
> +    ///         // SAFETY: just an FFI call without preconditions.
> +    ///         let data: *mut u8 = unsafe { bindings::foo_hardware_read(self.0.get(), &mut len) };
> +    ///         let data = error::from_err_ptr(data)?;
> +    ///         let data = ptr::slice_from_raw_parts(data, len);
> +    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid for reads as long as the
> +    ///         // `foo_hardware` object exists. That function updated the
> +    ///         let data = unsafe { &*data };
> +    ///         Ok(Untrusted::new_untrusted_ref(data))
> +    ///     }
> +    /// }
> +    /// ```
> +    pub fn new_untrusted_ref<'a>(value: &'a T) -> &'a Self {
> +        let ptr: *const T = value;
> +        // CAST: `Self` is `repr(transparent)` and contains a `T`.
> +        let ptr = ptr as *const Self;
> +        // SAFETY: `ptr` came from a shared reference valid for `'a`.
> +        unsafe { &*ptr }
> +    }
> +
> +    /// Gives direct access to the underlying untrusted data.
> +    ///
> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> +    /// do so use [`validate()`].
> +    ///
> +    /// [`validate()`]: Self::validate
> +    pub fn untrusted(&self) -> &T {
> +        &self.0
> +    }
> +
> +    /// Gives direct access to the underlying untrusted data.
> +    ///
> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> +    /// do so use [`validate()`].
> +    ///
> +    /// [`validate()`]: Self::validate
> +    pub fn untrusted_mut(&mut self) -> &mut T {
> +        &mut self.0
> +    }
> +
> +    /// Unwraps the data and removes the untrusted marking.
> +    ///
> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> +    /// do so use [`validate()`].
> +    ///
> +    /// [`validate()`]: Self::validate
> +    pub fn into_inner_untrusted(self) -> T

I don't like the above two since they could be easily and accidentally
abused to leak untrusted data. And at least in your example I think
they're fallout from being a bit too eager with annotating data as
untrusted. The Folio and Mapped itself are just kernel structures, they
better be correct. So I don't think it's useful to annotate those as
untrusted and rely on Deref to also annotate the actual data as untrusted,
because it forces you to peak behind the box a few times.

Instead I think we only want to annotate the Folio Deref:

impl<S> Deref for Mapped<'_, S> {
    type Target = Untrusted<[u8]>;

Now there will be folios that we trust because they're kernel internal
data and not file cache, so we need more flexibility here. No idea how to
best make that happen, but in either case it's only the Deref data itself
we don't trust, not any of the structures around it. One example would be
gpu page tables. One way to implement this would be to make the Target
type a generic of the folio, or well an associated type of the existing
generics folio paramater:

pub struct Folio<S: FolioType>

pub trait FolioType {
	type Data;
}

impl<T> FolioType for PageCache<T> {
	type Data = Untrusted<[u8]>;
}

And gpu pagetables would use a something like this instead:

impl FolioType for GpuFolios {
	type Data = [struct GpuPTE];
}

All extremely untested.

Now I think there are cases you can't cover with just validate, where you
have multiple input data which needs to be cross-checked to ensure overall
validity. But I think that we can cover that by implementing a Validator
for tuples and making Untrusted a trait so that we can either Accept
Untrusted<(A, B)> or (Untrusted<A>, Untrusted<B>) interchangably when
calling validate().

At least with an hour of theorizing and your one example I couldn't come
up with anything else.

> +    where
> +        T: Sized,
> +    {
> +        self.0
> +    }
> +
> +    /// Dereferences the underlying untrusted data.
> +    ///
> +    /// Often, untrusted data is not directly exposed as bytes, but rather as a reader that can
> +    /// give you access to raw bytes. When such a type implements [`Deref`], then this function
> +    /// allows you to get access to the underlying data.
> +    pub fn deref(&self) -> &Untrusted<<T as Deref>::Target>
> +    where
> +        T: Deref,
> +    {
> +        Untrusted::new_untrusted_ref(self.0.deref())
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validator`] trait on how to implement it.
> +    pub fn validate<V: Validator<Input = T>>(&self) -> Result<V::Output, V::Err> {
> +        V::validate(self)
> +    }
> +}
> +
> +impl Untrusted<[u8]> {
> +    /// Validate the given bytes directly.
> +    ///
> +    /// This is a convenience method to not have to implement the [`Validator`] trait to be able to
> +    /// just parse some bytes. If the bytes that you are validating have some structure and/or you
> +    /// will parse it into a `struct` or other rust type, then it is very much recommended to use
> +    /// the [`Validator`] trait and the [`validate()`] function instead.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # fn get_untrusted_data() -> &'static Untrusted<[u8]> { &[0; 8] }
> +    ///
> +    /// let data: &Untrusted<[u8]> = get_untrusted_data();
> +    /// let data: Result<&[u8], ()> = data.validate_bytes::<()>(|untrusted| {
> +    ///     if untrusted.len() != 2 {
> +    ///         return Err(());
> +    ///     }
> +    ///     if untrusted[0] & 0xf0 != 0 {
> +    ///         return Err(());
> +    ///     }
> +    ///     if untrusted[1] >= 100 {
> +    ///         return Err(());
> +    ///     }
> +    ///     Ok(())
> +    /// });
> +    /// match data {
> +    ///     Ok(data) => pr_info!("successfully validated the data: {data}"),
> +    ///     Err(()) => pr_info!("read faulty data from hardware!"),
> +    /// }
> +    /// ```
> +    ///
> +    /// [`validate()`]: Self::validate
> +    pub fn validate_bytes<E>(

I think this is a special case of a somewhat common in-place validation
pattern. For example in in complex syscall or ioctl we need to copy
structures from userspace anyway and doing yet another copy to put them
into a rust structure isn't great, instead we validate in-place. So I
think we need something like

impl Untrusted<T> {
	pub fn validate_inplace<E>(
		&self,
		validator: impl FnOnce(&T) -> Result<(), E>,
		) -> Result <&T, E> {
		...
	}
}

Eventually we might want a _mut version of this too, because often uapi
extensions means we need to correctly fill out default values for
extensions when being called by old userspace, and that requires
mutability. And it really is often an integral part of input validation.

Also I think we might need an Iterator for Untrusted<I: IntoIterator> so
that we can validate Untrusted<[T]> and things like that with standard map
and collect and do it all inplace.

> +        &self,
> +        validator: impl FnOnce(&[u8]) -> Result<(), E>,
> +    ) -> Result<&[u8], E> {
> +        let raw_data = self.untrusted();
> +        validator(raw_data).map(|()| raw_data)
> +    }
> +}
> +
> +impl<T, I> Index<I> for Untrusted<[T]>
> +where
> +    I: SliceIndex<[T]>,
> +{
> +    type Output = Untrusted<I::Output>;
> +
> +    fn index(&self, index: I) -> &Self::Output {
> +        Untrusted::new_untrusted_ref(self.0.index(index))
> +    }
> +}
> +
> +impl<T> Untrusted<[T]> {
> +    /// Gets the length of the underlying untrusted slice.
> +    pub fn len(&self) -> usize {
> +        self.0.len()
> +    }
> +}
> +
> +/// Validates untrusted data.
> +///
> +/// # Examples
> +///
> +/// ## Using an API returning untrusted data
> +///
> +/// Create the type of the data that you want to parse:
> +///
> +/// ```
> +/// pub struct FooData {
> +///     data: [u8; 4],
> +/// }
> +/// ```
> +///
> +/// Then implement this trait:
> +///
> +/// ```
> +/// use kernel::types::{Untrusted, Validator};
> +/// # pub struct FooData {
> +/// #     data: [u8; 4],
> +/// # }
> +/// impl Validator for FooData {
> +///     type Input = [u8];
> +///     type Output = FooData;
> +///     type Err = Error;
> +///
> +///     fn validate(untrusted: &Untrusted<Self::Input>) -> Result<Self::Output, Self::Err> {
> +///         let untrusted = untrusted.untrusted();
> +///         let untrusted = <[u8; 4]>::try_from(untrusted);
> +///         for byte in &untrusted {
> +///             if byte & 0xf0 != 0 {
> +///                 return Err(());
> +///             }
> +///         }
> +///         Ok(FooData { data: untrusted })
> +///     }
> +/// }
> +/// ```
> +///
> +/// And then use the API that returns untrusted data:
> +///
> +/// ```ignore
> +/// let result = get_untrusted_data().validate::<FooData>();
> +/// ```
> +///
> +/// ## Creating an API returning untrusted data
> +///
> +/// In your API instead of just returning the untrusted data, wrap it in [`Untrusted<T>`]:
> +///
> +/// ```
> +/// pub fn get_untrusted_data(&self) -> &Untrusted<[u8]> {
> +///     todo!()
> +/// }
> +/// ```
> +pub trait Validator {
> +    /// Type of the input data that is untrusted.
> +    type Input: ?Sized;
> +    /// Type of the validated data.
> +    type Output;

So I think the explicit Output makes sense if you have multiple different
untrusted input that validate to the same trusted structure, but I'm not
sure this makes sense as associated types. Instead I'd go with generics
and somethign like this:

pub trait Validator<Input: ?Sized> {
    type Err;

    fn validate(untrusted: &Untrusted<Input>) -> Result<Self, Self::Err>;
}

That means you can't implement validate for types from other modules
directly but need a newtype (I think at least, not sure). But I think
that's actually a good thing, since often that means you're validating
some generic state plus whatever your own code needs (like the
inode::Params<tarfs::INodeData> in your example), and both pieces need to
be consisted overall and not just individually (otherwise why does the
that other module not do the parsing for you). And so explicitly treating
the validated output as an explicit new type just makes sense to me. Plus
with derive(Deref) it's trivial to unbox after validation.

Cheers, Sima

> +    /// Validation error.
> +    type Err;
> +
> +    /// Validate the given untrusted data and parse it into the output type.
> +    ///
> +    /// When implementing this function, you can use [`Untrusted::untrusted()`] to get access to
> +    /// the raw untrusted data.
> +    fn validate(untrusted: &Untrusted<Self::Input>) -> Result<Self::Output, Self::Err>;
> +}
> -- 
> 2.46.0
> 
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

