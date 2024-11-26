Return-Path: <linux-kernel+bounces-421997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59D9D930D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80899B2441D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987719CC3C;
	Tue, 26 Nov 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JOIrWjQp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD619E990
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608357; cv=none; b=cr8WWtjoSNFYXYvzGT8xbmYS99kVr9prJ+TdNQKpXtyW1D275SGrQJ0Zw85BBZUkxKHH+QsFzu7y6q1rABaxA9xhHQyzhbfxr/9Xd8H1Iw+4W/+NyX3ZBIXhbWWdVS49QO+PBw6LGv9R4ZfdXOIRldQ93XK1RB3KP05REYyOhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608357; c=relaxed/simple;
	bh=+BuN2fML9/ORBK9/jX9FXRH/GiaGtUvxK+aQjAbcdsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r87SlI7ML6I10FPe9BjMsil1sZAhbGBAfzB2fdTgiSP/mZOmDMXYJPxtMPootRqWG4eNHiK0A+6skZn04yF8HZzPDliMw3MAUjDHq0Tt3hMWjjrXPMJAL2sbL0KsE0qN/3Ku0LjojEpDcT7eu92wxnnnoUq0FnQW5UZSiqqpYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=JOIrWjQp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de880c77eso793546e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1732608353; x=1733213153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mblk/GqEW9iAij/JyHLpkHC+jT95D7axh/UD6TLm/s0=;
        b=JOIrWjQpnh0RMBu9V15jkQob3ocvkLODB1eZ9GKVWAZjOXKfk/kXLOBzIX65T749D/
         4FeURKaEz/WqrGtnackeJl3/27gncbm8USojCIkrQSAF8ZIxKqCgJTq0gOF+ISLp52ZK
         20r8eJU2RgbNS9xfy0c4nF4eLXF2AnxEnJiGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608353; x=1733213153;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mblk/GqEW9iAij/JyHLpkHC+jT95D7axh/UD6TLm/s0=;
        b=taEUFK2G7q77tVVcha+2Wpu6WX0Vr9Un6cNzyZdXm1RlDE/VuJoislMbQxNZPjxtNc
         wfOXm6zdDH6PdQ93eef0dJZ4gM38NkSvYZqD+d/d2/CimX07SAXOEHpL+rJfHsFu3L4Z
         Et19bVHtFSI76bi3sTSgcPBn3lt0YIYZyjrTagNfyQf0EwFdigFSyRr59E8IoyHUcpr7
         Vctnr+AcreqxxXFDd15o+DA0DsdG3P1WM4AW1OeFet81RgKke8Pal5tOqRtPXprFoF4x
         EVi7R2dAfGtIIU9+aSZeH/oQe51sX+F/Y6Dxn7NB4B+YYGzKBlsJ46U+ZKOQFSw0/qT0
         BGgA==
X-Forwarded-Encrypted: i=1; AJvYcCWEH0Dt9cx5Paotr73F2gEyd7e7umZiOUZufQ+ViiT0pQLWMpmnRSSks97eHZFuNz9m8vGf4huxWbjdsS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSp8bqv/ueMSC5nV89HVCVbXtIr4lNPNYtASHCUX23bXh08CY
	CZ4TwAI7MfuL4CX/6SX3Q94VRKFcn8G5gTa53vymruNA2sFoBmQwXNuoiGHcYL8=
X-Gm-Gg: ASbGncuLyupdH8mVSIbNM8xcF/3OTxWg3KexkciKqZNEXG5iyWgrijeSRD1j9U/3+G4
	eSPgZ8Q/kcHZxg0ZEt5leo+f26vSRrXPCzEujgG3hXszGeuXxPjCMto2ARTGhFmGvQthzq/zHyH
	eRdUOW8rvcMuOGwWXYsFERNJZcBUqsmd3g6hi7aLovNiUPXEQV6vZ/BkYAoBUkIw8ar66giMQ+k
	xAe78rc7PkYhSM6QTF215Fu1K9jKZVbBsb4x2mNr2tnGPGPme94yJcRarVUPg==
X-Google-Smtp-Source: AGHT+IHfKuXVgieD6LKSHS0HWASo80sRs8h8JkH0BdlC3e9MCus5LGdQtq0+MN0uzu0A4jgwxoFVZw==
X-Received: by 2002:ac2:4a64:0:b0:53d:d951:bbfc with SMTP id 2adb3069b0e04-53dd951be49mr5488564e87.55.1732608352995;
        Tue, 26 Nov 2024 00:05:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab44sm224359735e9.30.2024.11.26.00.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:05:52 -0800 (PST)
Date: Tue, 26 Nov 2024 09:05:50 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
Message-ID: <Z0WBXhyyE4ilLlCE@phenom.ffwll.local>
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
 <ZvU6JQEN_92nPH4k@phenom.ffwll.local>
 <254496ac-bc5f-4622-99c4-9e2ada27e069@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <254496ac-bc5f-4622-99c4-9e2ada27e069@proton.me>
X-Operating-System: Linux phenom 6.11.6-amd64 

Sorry for the super late reply, was absorbed too much with life stuff :-/

On Mon, Sep 30, 2024 at 02:04:06PM +0000, Benno Lossin wrote:
> On 26.09.24 12:40, Simona Vetter wrote:
> > On Wed, Sep 25, 2024 at 08:53:05PM +0000, Benno Lossin wrote:
> >> +    /// Sets the underlying untrusted value.
> >> +    ///
> >> +    /// # Examples
> >> +    ///
> >> +    /// ```
> >> +    /// use kernel::validate::Untrusted;
> >> +    ///
> >> +    /// let mut untrusted = Untrusted::new(42);
> >> +    /// untrusted.write(24);
> >> +    /// ```
> >> +    pub fn write(&mut self, value: impl Init<T>) {
> >> +        let ptr: *mut T = &mut self.0 .0;
> >> +        // SAFETY: `ptr` came from a mutable reference and the value is overwritten before it is
> >> +        // read.
> >> +        unsafe { ptr::drop_in_place(ptr) };
> >> +        // SAFETY: `ptr` came from a mutable reference and the initializer cannot error.
> >> +        match unsafe { value.__init(ptr) } {
> >> +            Ok(()) => {}
> >> +        }
> >> +    }
> > 
> > So I think this doesn't work for a few reasons:
> > 
> > - there's a lot of unsafe both here and when using this (even without
> >   MaybeUninit), at least if I understand things correctly. And forcing
> >   unsafe for something that inheritedly does not break any of the rust
> >   memory safety rules feels silly.
> > 
> > - it also looks awkward, because you have the special versions
> >   write_uninit and write_uninit_slice, and imo if our write isn't good
> >   enought to just work with abritrary box/container types, it's not good.
> > 
> > - it doesn't actually work for one of the main uaccess.rs use-cases beyond
> >   just enabling the current interface. Example in pseudo-rust:
> > 
> >   struct IoctlParams {
> >       input: u32,
> >       ouptut: u32,
> >   }
> > 
> >   The thing is that ioctl that use the struct approach like drm does, use
> >   the same struct if there's both input and output paramterers, and
> >   furthermore we are not allowed to overwrite the entire struct because
> >   that breaks ioctl restarting. So the flow is roughly
> > 
> >   let userptr : UserSlice;
> >   let params : Untrusted<IoctlParams>;
> > 
> >   userptr.read(params));
> > 
> >   // validate params, do something interesting with it params.input
> > 
> >   // this is _not_ allowed to overwrite params.input but must leave it
> >   // unchanged
> > 
> >   params.write(|x| { x.output = 42; });
> > 
> >   userptr.write(params);
> > 
> >   Your current write doesn't allow this case, and I think that's not good
> >   enough.
> 
> I see. One thing that makes this API work better is field projections
> (it's a rust language feature for which we do have a PoC macro
> implementation and which I am working on getting into the language):
> To only overwrite a part of a struct you would do
> 
>     params->output.write(42);
> 
> The `->` syntax "projects" the `output` field, turning
> `Untrusted<IoctlParams>` into `Untrusted<u32>`.
> 
> I think that this would solve your problem with the API. (we probably
> need a stop gap solution though until field projections are part of the
> language).
> 
> >   The one I propsed in private does:
> > 
> >   Untrusted<T>::write(&mut self, Fn(&mut T)->())
> > 
> >   It's not perfect because it allows you to do other stuff than writing,
> >   but it's still pretty good by limiting any potentially dangerous code to
> >   the provided closure. And with these of protection apis we need to
> >   strike the right balance between as much protection as possible while
> >   still allowing users to get the job done.
> 
> Ideally I would like to avoid exposing the value.
> 
> >   Now I guess you can do this with your write too using a copy constructor
> >   approach, but that will result in less efficient code and it's probably
> >   also too much functional programming design for kernel developers to
> >   cope with.
> 
> Agreed.
> 
> >> +
> >> +    /// Turns a slice of untrusted values into an untrusted slice of values.
> >> +    pub fn transpose_slice(slice: &[Untrusted<T>]) -> &Untrusted<[T]>
> >> +    where
> >> +        T: Sized,
> >> +    {
> >> +        let ptr = slice.as_ptr().cast::<T>();
> >> +        // SAFETY: `ptr` and `len` come from the same slice reference.
> >> +        let slice = unsafe { slice::from_raw_parts(ptr, slice.len()) };
> >> +        Untrusted::new_ref(slice)
> >> +    }
> >> +
> >> +    /// Turns a slice of uninitialized, untrusted values into an untrusted slice of uninitialized
> >> +    /// values.
> >> +    pub fn transpose_slice_uninit(
> >> +        slice: &[MaybeUninit<Untrusted<T>>],
> >> +    ) -> &Untrusted<[MaybeUninit<T>]>
> > 
> > So these and some of the related functions to handle slice of box vs box
> > of slice feel a bit awkward. I think we can do better if we rename
> > Untrusted and Unvalidated to UntrustedBox and UnvalidatedBox, and then
> > make Untrusted and Unvalidated traits, with implementations for
> > UntrustedBox<T>, [Untrusted<T>], and all the others we want.
> 
> Hmm that might work for `Untrusted`, I will see how that looks. For
> `Unvalidated` I am less confident.
> 
> > I expect that in the future we'll get more boxes with special semantics
> > that we want to use together with Untrusted, not just [] and MaybeUninit.
> > One example would be when the Untrusted data is shared with userspace
> > (mmap()ed into both kernel and userspace for example for a ringbuffer), in
> > which case the data is both Untrusted but also SharedUnsafe or whatever
> > we'll call memory that's fundamentally breaking the rust memory model
> > because there's no exclusive access (userspace can always do whatever it
> > feels like), and all access has to go through at least
> > READ_ONCE/WRITE_ONCE from the C side, or often even full blown atomics.
> 
> I don't think that we need to wrap that in `Untrusted`, instead the type
> representing shared data between kernel and userspace should return
> `Untrusted<u8>` instead of `u8`.
> 
> > And that memory is not MaybeUninit, because we have to initialize it
> > before userspace can mmap it, for otherwise it's an information leak and
> > hence security issue.
> > 
> > tldr; I think going with traits for Untrusted and Unvalidated here will be
> > worth it, even if a bit more pain at first. Plus cleaner interfaces.
> > 
> >> +    where
> >> +        T: Sized,
> >> +    {
> >> +        let ptr = slice.as_ptr().cast::<MaybeUninit<T>>();
> >> +        // SAFETY: `ptr` and `len` come from the same mutable slice reference.
> >> +        let slice = unsafe { slice::from_raw_parts(ptr, slice.len()) };
> >> +        Untrusted::new_ref(slice)
> >> +    }
> 
> [...]
> 
> >> +/// Validates untrusted data.
> >> +///
> >> +/// # Examples
> >> +///
> >> +/// The simplest way to validate data is to just implement `Validate<&Unvalidated<[u8]>>` for the
> >> +/// type that you wish to validate:
> >> +///
> >> +/// ```
> >> +/// use kernel::{
> >> +///     error::{code::EINVAL, Error},
> >> +///     str::{CStr, CString},
> >> +///     validate::{Unvalidated, Validate},
> >> +/// };
> >> +///
> >> +/// struct Data {
> >> +///     flags: u8,
> >> +///     name: CString,
> >> +/// }
> >> +///
> >> +/// impl Validate<&Unvalidated<[u8]>> for Data {
> >> +///     type Err = Error;
> >> +///
> >> +///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> >> +///         let raw = unvalidated.raw();
> >> +///         let (&flags, name) = raw.split_first().ok_or(EINVAL)?;
> >> +///         let name = CStr::from_bytes_with_nul(name)?.to_cstring()?;
> >> +///         Ok(Data { flags, name })
> >> +///     }
> >> +/// }
> >> +/// ```
> >> +///
> >> +/// This approach copies the data and requires allocation. If you want to avoid the allocation and
> >> +/// copying the data, you can borrow from the input like this:
> >> +///
> >> +/// ```
> >> +/// use kernel::{
> >> +///     error::{code::EINVAL, Error},
> >> +///     str::CStr,
> >> +///     validate::{Unvalidated, Validate},
> >> +/// };
> >> +///
> >> +/// struct Data<'a> {
> >> +///     flags: u8,
> >> +///     name: &'a CStr,
> >> +/// }
> >> +///
> >> +/// impl<'a> Validate<&'a Unvalidated<[u8]>> for Data<'a> {
> >> +///     type Err = Error;
> >> +///
> >> +///     fn validate(unvalidated: &'a Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> >> +///         let raw = unvalidated.raw();
> >> +///         let (&flags, name) = raw.split_first().ok_or(EINVAL)?;
> >> +///         let name = CStr::from_bytes_with_nul(name)?;
> >> +///         Ok(Data { flags, name })
> >> +///     }
> >> +/// }
> >> +/// ```
> >> +///
> >> +/// If you need to in-place validate your data, you currently need to resort to `unsafe`:
> >> +///
> >> +/// ```
> >> +/// use kernel::{
> >> +///     error::{code::EINVAL, Error},
> >> +///     str::CStr,
> >> +///     validate::{Unvalidated, Validate},
> >> +/// };
> >> +/// use core::mem;
> >> +///
> >> +/// // Important: use `repr(C)`, this ensures a linear layout of this type.
> >> +/// #[repr(C)]
> >> +/// struct Data {
> >> +///     version: u8,
> >> +///     flags: u8,
> >> +///     _reserved: [u8; 2],
> >> +///     count: u64,
> >> +///     // lots of other fields...
> >> +/// }
> >> +///
> >> +/// impl Validate<&Unvalidated<[u8]>> for &Data {
> >> +///     type Err = Error;
> >> +///
> >> +///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> >> +///         let raw = unvalidated.raw();
> >> +///         if raw.len() < mem::size_of::<Data>() {
> >> +///             return Err(EINVAL);
> >> +///         }
> >> +///         // can only handle version 0
> >> +///         if raw[0] != 0 {
> >> +///             return Err(EINVAL);
> >> +///         }
> >> +///         // version 0 only uses the lower 4 bits of flags
> >> +///         if raw[1] & 0xf0 != 0 {
> >> +///             return Err(EINVAL);
> >> +///         }
> >> +///         let ptr = raw.as_ptr();
> >> +///         // CAST: `Data` only contains integers and has `repr(C)`.
> >> +///         let ptr = ptr.cast::<Data>();
> >> +///         // SAFETY: `ptr` came from a reference and the cast above is valid.
> >> +///         Ok(unsafe { &*ptr })
> >> +///     }
> >> +/// }
> >> +/// ```
> >> +///
> >> +/// To be able to modify the parsed data, while still supporting zero-copy, you can implement
> >> +/// `Validate<&mut Unvalidated<[u8]>>`:
> >> +///
> >> +/// ```
> >> +/// use kernel::{
> >> +///     error::{code::EINVAL, Error},
> >> +///     str::CStr,
> >> +///     validate::{Unvalidated, Validate},
> >> +/// };
> >> +/// use core::mem;
> >> +///
> >> +/// // Important: use `repr(C)`, this ensures a linear layout of this type.
> >> +/// #[repr(C)]
> >> +/// struct Data {
> >> +///     version: u8,
> >> +///     flags: u8,
> >> +///     _reserved: [u8; 2],
> >> +///     count: u64,
> >> +///     // lots of other fields...
> >> +/// }
> >> +///
> >> +/// impl Validate<&mut Unvalidated<[u8]>> for &Data {
> >> +///     type Err = Error;
> > 
> > I think we should make that one the default, but not sure that's doable
> > with associated types instead of generics.
> 
> There is the `associated_type_defaults` unstable feature: 
> https://github.com/rust-lang/rust/issues/29661
> 
> But I actually think that we should get away from making the `Error`
> type the return error of Rust functions. It's much better to have
> function-specific errors, since they can be more descriptive. In cases
> where we have to return to userspace or C, sure use the existing
> `Error`.

Do you mean a area-specific Error code that only returns the values that
are actually possible? I fear a bit that that could be a maintenance pain,
when the C side suddenly returns a new errno value. Or do you mean
something else.

> > The input parameter should definitely default to the output paramter,
> > because often they're just exactly the same e.g. when validating ioctl
> > input structures.
> 
> I don't understand what you mean by this? The input parameter has to be
> some sort of `..Untrusted..` and the output shouldn't have that.

Yeah it needs to be wrapped, but I was wondering whether there's a way to
make Untrusted<T> default to T as the output. If I remember all my
thoughts correctly, it's been a month.

> > On this version you've also left out the in-place validation (originally
> > validate_bytes), but we can add that later on when a need arises I guess.
> > Or do you think it's just not a good idea in general?
> 
> This version supports in-place validation, this example and the one
> above showcase how you would implement `Validate` in that case.
> 
> You can then call `.vaildate()` on an `&[mut ]Unvalidated<[u8]>` and you
> get a `&Data` that borrows from the unvalidated data without copying the
> data.

Ah I missed that, thanks for explaining.

Cheers, Sima

> 
> ---
> Cheers,
> Benno
> 
> >> +///
> >> +///     fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> >> +///         let raw = unvalidated.raw_mut();
> >> +///         if raw.len() < mem::size_of::<Data>() {
> >> +///             return Err(EINVAL);
> >> +///         }
> >> +///         match raw[0] {
> >> +///             0 => {},
> >> +///             1 => {
> >> +///                 // version 1 implicitly sets the first bit.
> >> +///                 raw[1] |= 1;
> >> +///             },
> >> +///             // can only handle version 0 and 1
> >> +///             _ => return Err(EINVAL),
> >> +///         }
> >> +///         // version 0 and 1 only use the lower 4 bits of flags
> >> +///         if raw[1] & 0xf0 != 0 {
> >> +///             return Err(EINVAL);
> >> +///         }
> >> +///         if raw[1] == 0 {}
> >> +///         let ptr = raw.as_ptr();
> >> +///         // CAST: `Data` only contains integers and has `repr(C)`.
> >> +///         let ptr = ptr.cast::<Data>();
> >> +///         // SAFETY: `ptr` came from a reference and the cast above is valid.
> >> +///         Ok(unsafe { &*ptr })
> >> +///     }
> >> +/// }
> >> +/// ```
> >> +pub trait Validate<I: ValidateInput>: Sized {
> >> +    /// Validation error.
> >> +    type Err;
> >> +
> >> +    /// Validate the given untrusted data and parse it into the output type.
> >> +    fn validate(unvalidated: I) -> Result<Self, Self::Err>;
> >> +}
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

