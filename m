Return-Path: <linux-kernel+bounces-330873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC297A57A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC18C2828F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF79158A1F;
	Mon, 16 Sep 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fOICcOm2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3845514EC47
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501758; cv=none; b=vEk3DQCeRVSANlAoPUZ5n8uP5yEVQxRkx+vDbPdmkVR0wteOr+mdaecCRNSLfmh05wCYtrgDNDISKtMMD/UTkqd0uEzVfEWYucvRf7TfvyjOqzbFuUWEguWsaFl3dz4ki4ezasMzuTBOWMqAhMqal3qSnEwxwtVJw+r5lLea19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501758; c=relaxed/simple;
	bh=ytXX+rFbEfmsNL6H5IQcOxaiBgB+9omIwpytAhEyhs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVvkxH51F4XHXbJLm+DnoKsAybct/MyH3nOOlkRfJ3glUSDhvW6ECKz2HOBXqOENj329RPBLU10OC9oib0KL/sQeITirfuDDhaEADYw0b/o/UlcR3d+ncJ4piBXKKaF3Pv73BhmMvwcy/j/yhpWD2Bic8zmgaArtDIlQZkcE1+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=fOICcOm2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3787e067230so3326753f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1726501754; x=1727106554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSxKvh3D0Xj4dNp7fN0yWZEV5OiTopcqw+9tTtMMdFg=;
        b=fOICcOm2FVsNKZSQlVwfzzX4P1MPS/PEy/cIdPA5u+fsSIEWPCf5yp01TBDEZA3MaA
         /PESqh35NFLDzLbvbWbU6mH6J+5rwP1Cqa8CVKoMaNDswG+NYaM/1yxkYHo11IseSQNU
         PkSDZDGdOYNxCQWBkeg0S+Ei3fyIrroFAzelg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726501754; x=1727106554;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSxKvh3D0Xj4dNp7fN0yWZEV5OiTopcqw+9tTtMMdFg=;
        b=tNP3zGmEdg0VQuT2zYQR5R/cSbVGMmDGNmgo9GIyCvDhnkkh7IGIBV1df7j6GvCO1t
         5STBOrqkV/A/SfUDt+HFtXGdZV2RJ3CHLwMX5XtPiaO/7uoBjrAS044DjeLjE/9W14Do
         itQ0eHTWWWphg1eeYCxPzPjU/3PLj6bFmbxWbK/C4wzJfr/811IFEwbLz7Wr1HVWItQf
         Kp7mCgVU70a42yQpWYlzKuMmB1Q1KWbo55jRi9By1IB+fkG+pOEGfZq/JyB5US1oLEsU
         C3uQWq4cxKG673fNVEbg1V+GBlJPSvzWoUnEsI6G8cbCtApf0nFvmz5FMynBhiucH/eM
         lZPg==
X-Forwarded-Encrypted: i=1; AJvYcCUyW17TdyraS16KuadkmLMQekDAXdY0hPidkkS2EyTsMjBEsRXQO/uaFfYQRWSb0PQ3wIqQjNGnAuBOy2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxln4GbWwFdNoNJV5AFHgTg2oG9UyMAZQL6SCOB3doGhFzg7F8Q
	Rju7dxBQY92mFhe0x1Xg/3RVCwAxYmn1D9C04SbJuThRpv5rxgKmc5LuehieNCo=
X-Google-Smtp-Source: AGHT+IEoBZpbkeJqr1kgucWOqV82v9Tc5WviC8YscX7pG8VyfMNyhqwWJr/veDjjinB0UYpSArogMw==
X-Received: by 2002:a5d:5d84:0:b0:378:c305:8f43 with SMTP id ffacd0b85a97d-378c3059085mr7989179f8f.18.1726501754156;
        Mon, 16 Sep 2024 08:49:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78054cesm7535728f8f.108.2024.09.16.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:49:13 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:49:11 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Message-ID: <ZuhTdwCqz61bQEgq@phenom.ffwll.local>
Mail-Followup-To: Benno Lossin <benno.lossin@proton.me>,
	Simona Vetter <simona.vetter@ffwll.ch>,
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
 <ZuRbSxwlz1xWT1pG@phenom.ffwll.local>
 <cf0d6189-e81c-4b7c-ab50-7a297c69b132@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0d6189-e81c-4b7c-ab50-7a297c69b132@proton.me>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Fri, Sep 13, 2024 at 04:49:29PM +0000, Benno Lossin wrote:
> On 13.09.24 17:33, Simona Vetter wrote:
> > On Fri, Sep 13, 2024 at 11:26:57AM +0000, Benno Lossin wrote:
> >>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
> >> @@ -532,3 +533,248 @@ unsafe impl AsBytes for str {}
> >>  // does not have any uninitialized portions either.
> >>  unsafe impl<T: AsBytes> AsBytes for [T] {}
> >>  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
> >> +
> >> +/// Untrusted data of type `T`.
> >> +///
> >> +/// When reading data from userspace, hardware or other external untrusted sources, the data must
> >> +/// be validated before it is used for logic within the kernel. To do so, the [`validate()`]
> >> +/// function exists and uses the [`Validator`] trait. For raw bytes validation there also is the
> >> +/// [`validate_bytes()`] function.
> >> +///
> >> +///
> >> +/// [`validate()`]: Self::validate
> >> +/// [`validate_bytes()`]: Self::validate_bytes
> >> +#[repr(transparent)]
> >> +pub struct Untrusted<T: ?Sized>(T);
> > 
> > I think we could make this a bit more strict and instead of encouraging
> > people to put all their validation code into a Validator<T>, force
> > them to. Which means assuming apis wrap all untrusted stuff in
> > Untrusted<T> reviewers only need to look at validate implementations and
> > nothing else.
> > 
> > If I'm not too wrong with my rust I think this would work with slitting
> > Untrusted<T> into two types:
> > 
> > - Untrusted<T> is just a box you can't access, and the type returned by
> >   apis for untrusted data. It doesn't have any of the functions except
> >   validate and new_untrusted so that you can't get at the data at all.
> > 
> > - UntrustedUnsafe<T> does have all the accessors needed for validation,
> >   but you can't construct that outside of this module. Maybe simplest to
> >   just nest this within the Untrusted<T> box.
> > 
> > - Untrusted::validate does the unboxing and passes a reference to
> >   UntrustedUnsafe<T> to Validator::validate, to guarantee that all the
> >   validation code is in there and nowhere else. Similar for
> >   validate_bytes.
> > 
> > Of course people can still bypass this easily, but it gets a bit harder to
> > do so, and easier for reviewers to verify everything.
> 
> This is a great idea!
> I think we should also remove `validate_bytes`, then you really must
> implement `Validator`. If we figure out later that people need it, we
> can add it later again. I added it because I thought that implementing
> `Validator` for something very small might be very annoying, but it
> seems like you actually want to force people to implement it :)

See further down, I think there's a real use-case for validate_bytes, or
something really close to it at least.

> I think we should discuss the name `UntrustedUnsafe` though, I don't
> really like the `Unsafe` although I understand why you used it. What do
> you think of renaming the current `Untrusted` (and the one that only
> exposes `validate`) to `Unvalidated` and using `Untrusted` as the
> parameter for `Validator::validate`?

Much better, I didn't like my naming either.

> Alternatively, we could use `Unverified`/`Untrusted`, because
> unvalidated is not a "real English word". But then I think we also
> should rename `Validator` to `Verifier` etc.
> 
> >> +    /// Gives direct access to the underlying untrusted data.
> >> +    ///
> >> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> >> +    /// do so use [`validate()`].
> >> +    ///
> >> +    /// [`validate()`]: Self::validate
> >> +    pub fn untrusted(&self) -> &T {
> >> +        &self.0
> >> +    }
> >> +
> >> +    /// Gives direct access to the underlying untrusted data.
> >> +    ///
> >> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> >> +    /// do so use [`validate()`].
> >> +    ///
> >> +    /// [`validate()`]: Self::validate
> >> +    pub fn untrusted_mut(&mut self) -> &mut T {
> >> +        &mut self.0
> >> +    }
> >> +
> >> +    /// Unwraps the data and removes the untrusted marking.
> >> +    ///
> >> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> >> +    /// do so use [`validate()`].
> >> +    ///
> >> +    /// [`validate()`]: Self::validate
> >> +    pub fn into_inner_untrusted(self) -> T
> > 
> > I don't like the above two since they could be easily and accidentally
> > abused to leak untrusted data. And at least in your example I think
> > they're fallout from being a bit too eager with annotating data as
> > untrusted. The Folio and Mapped itself are just kernel structures, they
> > better be correct. So I don't think it's useful to annotate those as
> > untrusted and rely on Deref to also annotate the actual data as untrusted,
> > because it forces you to peak behind the box a few times.
> 
> As I wrote in patch 2, I have no idea if I added the `Untrusted<T>` in
> the correct places, as I don't know folios. I would disagree, that these
> methods are necessary because of marking the entire folio as untrusted,
> they are needed to access the data from within the `Validator::validate`
> function, but with your above suggestion, we can move them to the
> internal type.
> 
> > Instead I think we only want to annotate the Folio Deref:
> > 
> > impl<S> Deref for Mapped<'_, S> {
> >     type Target = Untrusted<[u8]>;
> > 
> > Now there will be folios that we trust because they're kernel internal
> > data and not file cache, so we need more flexibility here. No idea how to
> > best make that happen, but in either case it's only the Deref data itself
> > we don't trust, not any of the structures around it. One example would be
> > gpu page tables. One way to implement this would be to make the Target
> > type a generic of the folio, or well an associated type of the existing
> > generics folio paramater:
> > 
> > pub struct Folio<S: FolioType>
> > 
> > pub trait FolioType {
> > 	type Data;
> > }
> > 
> > impl<T> FolioType for PageCache<T> {
> > 	type Data = Untrusted<[u8]>;
> > }
> > 
> > And gpu pagetables would use a something like this instead:
> > 
> > impl FolioType for GpuFolios {
> > 	type Data = [struct GpuPTE];
> > }
> > 
> > All extremely untested.
> 
> What I would like to avoid is having to do this for every possible data
> source. Ideally we could just wrap trusted data sources with `Untrusted`
> and be done with it.
> If the wrapped type is not plain data, but rather a smart pointer or
> other abstraction, then only the underlying data is marked untrusted
> (otherwise how would you even know that the pointer can be used?). So
> for example one might have an `Untrusted<ARef<[u8]>>`.

Yeah I think for pure smart pointers this is great, hence why I didn't
object to your Deref implementation. But if there's an entire
datastructure around it (like with pagecache) I think we need to sprinkle
associated types around to make this work.

What imo breaks annotations like this is if you have a lot of false
positive cases that force people to jump through hoops and normalize
having random uncecessary "validate" code all over. That defeats the
point.

> What I think we should do instead is make our APIs that return untrusted
> data just return `Untrusted<Folio>` and implement the following method:
> 
>     impl Folio {
>         pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
>     }
> 
> I think that is the best of both worlds: we don't need to do excessive
> type shenanigans for every type carrying potentially untrusted data and
> we get to have methods specific to untrusted data.
> 
> However, I think implementing this method will be a bit difficult with
> the `Untrusted`/`Unvalidated` split. Maybe we can have some `pub(crate)`
> methods on `Unvalidated` to perform some mappings?

The thing is, folios are just a pile of contig pages, and there's nothing
in the rules that they only contain untrusted data. Currently in rust code
we have that's the case, but not in general. So we need that associated
type.

But I also think Folio here is special, a lot of the other places where I
want this annotation it's the case that the data returned is _always_
untrusted. So we don't need to place associated types all over the
codebase to make this work, it's just that the rfc example you've picked
needs it.

E.g. copy_from_user is _always_ untrusted, not exception. Network packets
we read are also always untrusted. When you have a device driver and want
to be robust against evil implementations (external bus like usb or cloud
virtual hw with confidential compute), then also everything you ever read
from that device is always untrusted until validated.

And the neat thing is if we get this right, there's a lot of cases where
the Untrusted<> wrapper doesn't matter, because we just pass from one
untrusted to another. E.g. for the write() syscall (or an implemenation of
that in an fs) we get a Untrusted<[u8]> from Folio and let copy_from_user
directly write into that. But that only works if the annotations are
exactly right, not too much, not too little.

Oh another one we need:

impl<T: AsBytes> AsBytes for Untrusted<AsBytes>

Otherwise you can't write untrusted stuff to userspace, which is really no
issue at all (e.g. networking, where the kernel only parses the headers
and shovels the data to userspace unchecked).

> > Now I think there are cases you can't cover with just validate, where you
> > have multiple input data which needs to be cross-checked to ensure overall
> > validity. But I think that we can cover that by implementing a Validator
> > for tuples and making Untrusted a trait so that we can either Accept
> > Untrusted<(A, B)> or (Untrusted<A>, Untrusted<B>) interchangably when
> > calling validate().
> 
> I could imagine us adding conversion functions that can combine
> untrusted values. Additionally, we should probably add a `Context` type
> to `Validator` that is an additional parameter.
> 
> > At least with an hour of theorizing and your one example I couldn't come
> > up with anything else.
> 
> Yeah, we need more users of this to know the full way to express this
> correctly. I would like to avoid huge refactorings in the future.

I think adding it to the copy_*_user functions we already have in
upstream, and then asking Alice to rebase binder should be a really solid
real-world testcase. And I think currently for the things in-flight
copy*user is going to be the main source of untrusted data anyway, not so
much page cache folios.

> >> +impl Untrusted<[u8]> {
> >> +    /// Validate the given bytes directly.
> >> +    ///
> >> +    /// This is a convenience method to not have to implement the [`Validator`] trait to be able to
> >> +    /// just parse some bytes. If the bytes that you are validating have some structure and/or you
> >> +    /// will parse it into a `struct` or other rust type, then it is very much recommended to use
> >> +    /// the [`Validator`] trait and the [`validate()`] function instead.
> >> +    ///
> >> +    /// # Examples
> >> +    ///
> >> +    /// ```
> >> +    /// # fn get_untrusted_data() -> &'static Untrusted<[u8]> { &[0; 8] }
> >> +    ///
> >> +    /// let data: &Untrusted<[u8]> = get_untrusted_data();
> >> +    /// let data: Result<&[u8], ()> = data.validate_bytes::<()>(|untrusted| {
> >> +    ///     if untrusted.len() != 2 {
> >> +    ///         return Err(());
> >> +    ///     }
> >> +    ///     if untrusted[0] & 0xf0 != 0 {
> >> +    ///         return Err(());
> >> +    ///     }
> >> +    ///     if untrusted[1] >= 100 {
> >> +    ///         return Err(());
> >> +    ///     }
> >> +    ///     Ok(())
> >> +    /// });
> >> +    /// match data {
> >> +    ///     Ok(data) => pr_info!("successfully validated the data: {data}"),
> >> +    ///     Err(()) => pr_info!("read faulty data from hardware!"),
> >> +    /// }
> >> +    /// ```
> >> +    ///
> >> +    /// [`validate()`]: Self::validate
> >> +    pub fn validate_bytes<E>(
> > 
> > I think this is a special case of a somewhat common in-place validation
> > pattern. For example in in complex syscall or ioctl we need to copy
> > structures from userspace anyway and doing yet another copy to put them
> > into a rust structure isn't great, instead we validate in-place. So I
> > think we need something like
> > 
> > impl Untrusted<T> {
> > 	pub fn validate_inplace<E>(
> > 		&self,
> > 		validator: impl FnOnce(&T) -> Result<(), E>,
> > 		) -> Result <&T, E> {
> > 		...
> > 	}
> > }
> 
> I had thought about in-place validation as well, but I first wanted to
> get a feel for how to do it, since I felt that in-place might make it
> significantly more complicated.
> In your proposal, you give a reference back, but maybe the data started
> out as a `Box<[u8]>` (or how do you usually copy from userspace?), so it
> would be better to be able to also handle owned data.

The code in upstream is just MaybUninit<[u8]>.

> Also, it might be a good idea to just make the copy to kernel and
> validate a single step.

Yeah that'd be a nice helper, but I think conceptually you want it to be
two steps: Often for efficiency complex structures are linearized into one
single memory block, so that you can pull it all in with one
copy_from_user. But validation would need to look at each piece (and it's
often mixed, not just an array), probably together with Alice's Range
datatype to make sure we're don't have index confusions.

> > Eventually we might want a _mut version of this too, because often uapi
> > extensions means we need to correctly fill out default values for
> > extensions when being called by old userspace, and that requires
> > mutability. And it really is often an integral part of input validation.
> 
> I see, will have to think about how to include this as well.
> 
> > Also I think we might need an Iterator for Untrusted<I: IntoIterator> so
> > that we can validate Untrusted<[T]> and things like that with standard map
> > and collect and do it all inplace.
> 
> Hmm, so a general iterator for `Unvalidated` might be a bad idea, but
> for the `Untrusted`, it should be fine.

Yup that was my thinking too, the idea being that you write a validator
for a single element, and then let Iterator magic handle things when you
need to validate an entire array.
 
> >> +pub trait Validator {
> >> +    /// Type of the input data that is untrusted.
> >> +    type Input: ?Sized;
> >> +    /// Type of the validated data.
> >> +    type Output;
> > 
> > So I think the explicit Output makes sense if you have multiple different
> > untrusted input that validate to the same trusted structure, but I'm not
> > sure this makes sense as associated types. Instead I'd go with generics
> > and somethign like this:
> > 
> > pub trait Validator<Input: ?Sized> {
> >     type Err;
> > 
> >     fn validate(untrusted: &Untrusted<Input>) -> Result<Self, Self::Err>;
> > }
> > 
> > That means you can't implement validate for types from other modules
> > directly but need a newtype (I think at least, not sure). But I think
> > that's actually a good thing, since often that means you're validating
> > some generic state plus whatever your own code needs (like the
> > inode::Params<tarfs::INodeData> in your example), and both pieces need to
> > be consisted overall and not just individually (otherwise why does the
> > that other module not do the parsing for you). And so explicitly treating
> > the validated output as an explicit new type just makes sense to me. Plus
> > with derive(Deref) it's trivial to unbox after validation.
> 
> There might be the need to validate the same piece of data with
> different ways and I am not convinced adding a newtype for every single
> case is a good way to achieve it.
> Although it would simplify the `Validator` trait... I will think a bit
> about this.

Hm, but unless I misunderstand you already need a random type to attach
your current trait too? So not worse if we require that for the
less-common type of multiple ways to validate the same, and simpler for
the common one.

> > Cheers, Sima
> 
> Thanks a lot for taking a look!

I _really_ want this :-)
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

