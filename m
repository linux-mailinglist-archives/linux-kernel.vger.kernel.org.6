Return-Path: <linux-kernel+bounces-336082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D0D97EEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707D6B20FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACEA19D067;
	Mon, 23 Sep 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dWkUPmX3"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF946B5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107704; cv=none; b=WJBh8fnKB5kLUwaEGUGc2RH4//Bphn5hG70H6+UzZoE9W+mUY/WsM7jqC0XDTnxhXR6QK7QH3QPlkQw+/oLkdJ5L9/D7YCbSqvZnoDL1Zf5i4hrnX9HtmzSCJHRBWVzlcjL+Dy3XayJ9bGGFb1543uk1HqDSY+FABJWzQWNwdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107704; c=relaxed/simple;
	bh=l9pvLhxlrXQ+NKrcdEQ4hRQP/XaruUdd0ow0M4pMJcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaaJ1Epdg7K0nQNa+EB4uDjf4n56pBbk6qpsnQiupzYMw6yEilq1/eGErV9gE1yj2+diJiIChoy4sKv6q9PIEDnPHvMwd7gJ6NjARZqtZkaIM7By3DKQ2MAbFgPU8/AtKsYzHoRNMHW6eAJBH+oBQp3nTkx6iKqUlte+YiEWo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=dWkUPmX3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so4815578e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1727107700; x=1727712500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWlQU6U3AnAFOBtdgELPFdTepBdlK8f9ijbeIIju6KM=;
        b=dWkUPmX3i48WmFSDP1CmLVagjDIEOT8HUmqHgY4G5p8X432wyNxC3E3LUot7AvrnRc
         LuzGVNVxRYr1i5GY75WZbDCsnqRLFVK6/FugbILMFeQSCDVFoBXFAvR6snd/2+nCmfhP
         XVvrvuF5O5fSqzNnI7xGEjnqLbI6vnRcEBaII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107700; x=1727712500;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWlQU6U3AnAFOBtdgELPFdTepBdlK8f9ijbeIIju6KM=;
        b=fEOdhsZQ9FG3b8XNIvKeoR/0iQ2cCaN5DzarjV952segHnsoPVHOOTssS8LclXfSKA
         s7ussh2kOdAKtpvn1aHACZ17SAw0gvffLUC3Y6PDjJ4WLnwetEtjxGrQzTzdWlh+NgYH
         xmVdDsUvahbkoSK/Xh+RruQxquDLpKHLrjAJ3oGVjPG4ubetFsiCB67vpMgOTFvvoFnW
         l/PlhoDrtAC2aRYL5+PowmFJlVknlbGbamrEdWcRF1n0vaG3q9xvYhA8YwFhzO3zSDx1
         9BeXKQznIo7pnSjHhm6VZ27rD5eA7t01QqivNf0A99j24EJC01jKXRQc5t25t5FKvvqD
         /qNw==
X-Forwarded-Encrypted: i=1; AJvYcCXWmXP8zIFN8Yih2nXYdfzxOg1KGM//oTzvXgASrAXgqIrEwmlMiy7FNi+7DTFZ7x6LsRQSEifNoFXGS/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3G7d0ZZ/qTrCuo0knCjTPPwsFVn8sUNQ3JPAGYmbJE+3utEbZ
	no3XywrTKiCsBWK37z97DEcMP1r/VmwMKWrJ2QRdZs60rbzQMpW5CZORCgP9Fz4=
X-Google-Smtp-Source: AGHT+IGwbItIOn+BG64SMnr+HPq3R1pgjvJPzwButd8voqysRhsknYuubQdlraLdNaZMIZX8NAlYbw==
X-Received: by 2002:a05:6512:3b8e:b0:52c:e012:efad with SMTP id 2adb3069b0e04-536ac2d69c2mr6877210e87.12.1727107699611;
        Mon, 23 Sep 2024 09:08:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb55a13sm10599038a12.30.2024.09.23.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:08:19 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:08:16 +0200
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
Message-ID: <ZvGScCHfprZcymFQ@phenom.ffwll.local>
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
 <ZuRbSxwlz1xWT1pG@phenom.ffwll.local>
 <cf0d6189-e81c-4b7c-ab50-7a297c69b132@proton.me>
 <ZuhTdwCqz61bQEgq@phenom.ffwll.local>
 <3c7b27e3-eedc-44c7-a31b-d927214cc9f8@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7b27e3-eedc-44c7-a31b-d927214cc9f8@proton.me>
X-Operating-System: Linux phenom 6.10.6-amd64 

On Sat, Sep 21, 2024 at 07:45:44AM +0000, Benno Lossin wrote:
> On 16.09.24 17:49, Simona Vetter wrote:
> > On Fri, Sep 13, 2024 at 04:49:29PM +0000, Benno Lossin wrote:
> >> On 13.09.24 17:33, Simona Vetter wrote:
> >>> On Fri, Sep 13, 2024 at 11:26:57AM +0000, Benno Lossin wrote:
> >>>>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
> >>>> @@ -532,3 +533,248 @@ unsafe impl AsBytes for str {}
> >>>>  // does not have any uninitialized portions either.
> >>>>  unsafe impl<T: AsBytes> AsBytes for [T] {}
> >>>>  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
> >>>> +
> >>>> +/// Untrusted data of type `T`.
> >>>> +///
> >>>> +/// When reading data from userspace, hardware or other external untrusted sources, the data must
> >>>> +/// be validated before it is used for logic within the kernel. To do so, the [`validate()`]
> >>>> +/// function exists and uses the [`Validator`] trait. For raw bytes validation there also is the
> >>>> +/// [`validate_bytes()`] function.
> >>>> +///
> >>>> +///
> >>>> +/// [`validate()`]: Self::validate
> >>>> +/// [`validate_bytes()`]: Self::validate_bytes
> >>>> +#[repr(transparent)]
> >>>> +pub struct Untrusted<T: ?Sized>(T);
> >>>
> >>> I think we could make this a bit more strict and instead of encouraging
> >>> people to put all their validation code into a Validator<T>, force
> >>> them to. Which means assuming apis wrap all untrusted stuff in
> >>> Untrusted<T> reviewers only need to look at validate implementations and
> >>> nothing else.
> >>>
> >>> If I'm not too wrong with my rust I think this would work with slitting
> >>> Untrusted<T> into two types:
> >>>
> >>> - Untrusted<T> is just a box you can't access, and the type returned by
> >>>   apis for untrusted data. It doesn't have any of the functions except
> >>>   validate and new_untrusted so that you can't get at the data at all.
> >>>
> >>> - UntrustedUnsafe<T> does have all the accessors needed for validation,
> >>>   but you can't construct that outside of this module. Maybe simplest to
> >>>   just nest this within the Untrusted<T> box.
> >>>
> >>> - Untrusted::validate does the unboxing and passes a reference to
> >>>   UntrustedUnsafe<T> to Validator::validate, to guarantee that all the
> >>>   validation code is in there and nowhere else. Similar for
> >>>   validate_bytes.
> >>>
> >>> Of course people can still bypass this easily, but it gets a bit harder to
> >>> do so, and easier for reviewers to verify everything.
> >>
> >> This is a great idea!
> >> I think we should also remove `validate_bytes`, then you really must
> >> implement `Validator`. If we figure out later that people need it, we
> >> can add it later again. I added it because I thought that implementing
> >> `Validator` for something very small might be very annoying, but it
> >> seems like you actually want to force people to implement it :)
> > 
> > See further down, I think there's a real use-case for validate_bytes, or
> > something really close to it at least.
> 
> Could you point me to it? I wasn't able to find the use-case you are
> referring to here.
> 
> If I remove the `untrusted()` function, then I would think that I also
> should remove the `validate_bytes` function, since you could just do:
> 
>     untrusted.validate_bytes(|_| true)
> 
> Which would give you access to the untrusted data without validation.
> (of course one could also do this in the `Validate` trait, but I feel
> like if we have exactly one place where this can happen, it will be a
> lot easier to catch. We could even have some tool that looks for
> `Validate` implementations that just return `Ok(untrusted)`)

So the use-case I've meant is the in-place validation, without copying
stuff around. So it wouldn't be the specific validate_bytes, but a
validate_inplace. In my original email I did directly call it that, but it
took me a w/e to realize that validate_bytes is really just a special-case
of validate_inplace when T = [u8], and so really we only need
validate_inplace for every case where we do some in-place validation.

And yes validate_inplace would be a very easy minimal escape hatch to just
unbox the unvalidated data. But fundamentally we can't prevent that, all
we can do is make sure that the validation code is concentrated in very
specific places reviewers can easily catch, and |_| true probably not
being correct validation code is rather easy to spot.

I do think we need inplace validation for the fairly common case where the
copy_from_user is split from the validation, e.g. when you copy a big
chunk of memory which is composed itself of variable-length objects that
reside within: You'd do one big copy_from_user and then a pile of inplace
validations for each thing that's in there, maybe with the assistance of
alice's Range module to make sure you don't split up the overall memory
area badly into individual pieces.
-Sima


> 
> ---
> Cheers,
> Benno
> 
> >> I think we should discuss the name `UntrustedUnsafe` though, I don't
> >> really like the `Unsafe` although I understand why you used it. What do
> >> you think of renaming the current `Untrusted` (and the one that only
> >> exposes `validate`) to `Unvalidated` and using `Untrusted` as the
> >> parameter for `Validator::validate`?
> > 
> > Much better, I didn't like my naming either.
> > 
> >> Alternatively, we could use `Unverified`/`Untrusted`, because
> >> unvalidated is not a "real English word". But then I think we also
> >> should rename `Validator` to `Verifier` etc.
> >>
> >>>> +    /// Gives direct access to the underlying untrusted data.
> >>>> +    ///
> >>>> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> >>>> +    /// do so use [`validate()`].
> >>>> +    ///
> >>>> +    /// [`validate()`]: Self::validate
> >>>> +    pub fn untrusted(&self) -> &T {
> >>>> +        &self.0
> >>>> +    }
> >>>> +
> >>>> +    /// Gives direct access to the underlying untrusted data.
> >>>> +    ///
> >>>> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> >>>> +    /// do so use [`validate()`].
> >>>> +    ///
> >>>> +    /// [`validate()`]: Self::validate
> >>>> +    pub fn untrusted_mut(&mut self) -> &mut T {
> >>>> +        &mut self.0
> >>>> +    }
> >>>> +
> >>>> +    /// Unwraps the data and removes the untrusted marking.
> >>>> +    ///
> >>>> +    /// Be careful when accessing the data, as it is untrusted and still needs to be verified! To
> >>>> +    /// do so use [`validate()`].
> >>>> +    ///
> >>>> +    /// [`validate()`]: Self::validate
> >>>> +    pub fn into_inner_untrusted(self) -> T
> >>>
> >>> I don't like the above two since they could be easily and accidentally
> >>> abused to leak untrusted data. And at least in your example I think
> >>> they're fallout from being a bit too eager with annotating data as
> >>> untrusted. The Folio and Mapped itself are just kernel structures, they
> >>> better be correct. So I don't think it's useful to annotate those as
> >>> untrusted and rely on Deref to also annotate the actual data as untrusted,
> >>> because it forces you to peak behind the box a few times.
> >>
> >> As I wrote in patch 2, I have no idea if I added the `Untrusted<T>` in
> >> the correct places, as I don't know folios. I would disagree, that these
> >> methods are necessary because of marking the entire folio as untrusted,
> >> they are needed to access the data from within the `Validator::validate`
> >> function, but with your above suggestion, we can move them to the
> >> internal type.
> >>
> >>> Instead I think we only want to annotate the Folio Deref:
> >>>
> >>> impl<S> Deref for Mapped<'_, S> {
> >>>     type Target = Untrusted<[u8]>;
> >>>
> >>> Now there will be folios that we trust because they're kernel internal
> >>> data and not file cache, so we need more flexibility here. No idea how to
> >>> best make that happen, but in either case it's only the Deref data itself
> >>> we don't trust, not any of the structures around it. One example would be
> >>> gpu page tables. One way to implement this would be to make the Target
> >>> type a generic of the folio, or well an associated type of the existing
> >>> generics folio paramater:
> >>>
> >>> pub struct Folio<S: FolioType>
> >>>
> >>> pub trait FolioType {
> >>> 	type Data;
> >>> }
> >>>
> >>> impl<T> FolioType for PageCache<T> {
> >>> 	type Data = Untrusted<[u8]>;
> >>> }
> >>>
> >>> And gpu pagetables would use a something like this instead:
> >>>
> >>> impl FolioType for GpuFolios {
> >>> 	type Data = [struct GpuPTE];
> >>> }
> >>>
> >>> All extremely untested.
> >>
> >> What I would like to avoid is having to do this for every possible data
> >> source. Ideally we could just wrap trusted data sources with `Untrusted`
> >> and be done with it.
> >> If the wrapped type is not plain data, but rather a smart pointer or
> >> other abstraction, then only the underlying data is marked untrusted
> >> (otherwise how would you even know that the pointer can be used?). So
> >> for example one might have an `Untrusted<ARef<[u8]>>`.
> > 
> > Yeah I think for pure smart pointers this is great, hence why I didn't
> > object to your Deref implementation. But if there's an entire
> > datastructure around it (like with pagecache) I think we need to sprinkle
> > associated types around to make this work.
> > 
> > What imo breaks annotations like this is if you have a lot of false
> > positive cases that force people to jump through hoops and normalize
> > having random uncecessary "validate" code all over. That defeats the
> > point.
> > 
> >> What I think we should do instead is make our APIs that return untrusted
> >> data just return `Untrusted<Folio>` and implement the following method:
> >>
> >>     impl Folio {
> >>         pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
> >>     }
> >>
> >> I think that is the best of both worlds: we don't need to do excessive
> >> type shenanigans for every type carrying potentially untrusted data and
> >> we get to have methods specific to untrusted data.
> >>
> >> However, I think implementing this method will be a bit difficult with
> >> the `Untrusted`/`Unvalidated` split. Maybe we can have some `pub(crate)`
> >> methods on `Unvalidated` to perform some mappings?
> > 
> > The thing is, folios are just a pile of contig pages, and there's nothing
> > in the rules that they only contain untrusted data. Currently in rust code
> > we have that's the case, but not in general. So we need that associated
> > type.
> > 
> > But I also think Folio here is special, a lot of the other places where I
> > want this annotation it's the case that the data returned is _always_
> > untrusted. So we don't need to place associated types all over the
> > codebase to make this work, it's just that the rfc example you've picked
> > needs it.
> > 
> > E.g. copy_from_user is _always_ untrusted, not exception. Network packets
> > we read are also always untrusted. When you have a device driver and want
> > to be robust against evil implementations (external bus like usb or cloud
> > virtual hw with confidential compute), then also everything you ever read
> > from that device is always untrusted until validated.
> > 
> > And the neat thing is if we get this right, there's a lot of cases where
> > the Untrusted<> wrapper doesn't matter, because we just pass from one
> > untrusted to another. E.g. for the write() syscall (or an implemenation of
> > that in an fs) we get a Untrusted<[u8]> from Folio and let copy_from_user
> > directly write into that. But that only works if the annotations are
> > exactly right, not too much, not too little.
> > 
> > Oh another one we need:
> > 
> > impl<T: AsBytes> AsBytes for Untrusted<AsBytes>
> > 
> > Otherwise you can't write untrusted stuff to userspace, which is really no
> > issue at all (e.g. networking, where the kernel only parses the headers
> > and shovels the data to userspace unchecked).
> > 
> >>> Now I think there are cases you can't cover with just validate, where you
> >>> have multiple input data which needs to be cross-checked to ensure overall
> >>> validity. But I think that we can cover that by implementing a Validator
> >>> for tuples and making Untrusted a trait so that we can either Accept
> >>> Untrusted<(A, B)> or (Untrusted<A>, Untrusted<B>) interchangably when
> >>> calling validate().
> >>
> >> I could imagine us adding conversion functions that can combine
> >> untrusted values. Additionally, we should probably add a `Context` type
> >> to `Validator` that is an additional parameter.
> >>
> >>> At least with an hour of theorizing and your one example I couldn't come
> >>> up with anything else.
> >>
> >> Yeah, we need more users of this to know the full way to express this
> >> correctly. I would like to avoid huge refactorings in the future.
> > 
> > I think adding it to the copy_*_user functions we already have in
> > upstream, and then asking Alice to rebase binder should be a really solid
> > real-world testcase. And I think currently for the things in-flight
> > copy*user is going to be the main source of untrusted data anyway, not so
> > much page cache folios.
> > 
> >>>> +impl Untrusted<[u8]> {
> >>>> +    /// Validate the given bytes directly.
> >>>> +    ///
> >>>> +    /// This is a convenience method to not have to implement the [`Validator`] trait to be able to
> >>>> +    /// just parse some bytes. If the bytes that you are validating have some structure and/or you
> >>>> +    /// will parse it into a `struct` or other rust type, then it is very much recommended to use
> >>>> +    /// the [`Validator`] trait and the [`validate()`] function instead.
> >>>> +    ///
> >>>> +    /// # Examples
> >>>> +    ///
> >>>> +    /// ```
> >>>> +    /// # fn get_untrusted_data() -> &'static Untrusted<[u8]> { &[0; 8] }
> >>>> +    ///
> >>>> +    /// let data: &Untrusted<[u8]> = get_untrusted_data();
> >>>> +    /// let data: Result<&[u8], ()> = data.validate_bytes::<()>(|untrusted| {
> >>>> +    ///     if untrusted.len() != 2 {
> >>>> +    ///         return Err(());
> >>>> +    ///     }
> >>>> +    ///     if untrusted[0] & 0xf0 != 0 {
> >>>> +    ///         return Err(());
> >>>> +    ///     }
> >>>> +    ///     if untrusted[1] >= 100 {
> >>>> +    ///         return Err(());
> >>>> +    ///     }
> >>>> +    ///     Ok(())
> >>>> +    /// });
> >>>> +    /// match data {
> >>>> +    ///     Ok(data) => pr_info!("successfully validated the data: {data}"),
> >>>> +    ///     Err(()) => pr_info!("read faulty data from hardware!"),
> >>>> +    /// }
> >>>> +    /// ```
> >>>> +    ///
> >>>> +    /// [`validate()`]: Self::validate
> >>>> +    pub fn validate_bytes<E>(
> >>>
> >>> I think this is a special case of a somewhat common in-place validation
> >>> pattern. For example in in complex syscall or ioctl we need to copy
> >>> structures from userspace anyway and doing yet another copy to put them
> >>> into a rust structure isn't great, instead we validate in-place. So I
> >>> think we need something like
> >>>
> >>> impl Untrusted<T> {
> >>> 	pub fn validate_inplace<E>(
> >>> 		&self,
> >>> 		validator: impl FnOnce(&T) -> Result<(), E>,
> >>> 		) -> Result <&T, E> {
> >>> 		...
> >>> 	}
> >>> }
> >>
> >> I had thought about in-place validation as well, but I first wanted to
> >> get a feel for how to do it, since I felt that in-place might make it
> >> significantly more complicated.
> >> In your proposal, you give a reference back, but maybe the data started
> >> out as a `Box<[u8]>` (or how do you usually copy from userspace?), so it
> >> would be better to be able to also handle owned data.
> > 
> > The code in upstream is just MaybUninit<[u8]>.
> > 
> >> Also, it might be a good idea to just make the copy to kernel and
> >> validate a single step.
> > 
> > Yeah that'd be a nice helper, but I think conceptually you want it to be
> > two steps: Often for efficiency complex structures are linearized into one
> > single memory block, so that you can pull it all in with one
> > copy_from_user. But validation would need to look at each piece (and it's
> > often mixed, not just an array), probably together with Alice's Range
> > datatype to make sure we're don't have index confusions.
> > 
> >>> Eventually we might want a _mut version of this too, because often uapi
> >>> extensions means we need to correctly fill out default values for
> >>> extensions when being called by old userspace, and that requires
> >>> mutability. And it really is often an integral part of input validation.
> >>
> >> I see, will have to think about how to include this as well.
> >>
> >>> Also I think we might need an Iterator for Untrusted<I: IntoIterator> so
> >>> that we can validate Untrusted<[T]> and things like that with standard map
> >>> and collect and do it all inplace.
> >>
> >> Hmm, so a general iterator for `Unvalidated` might be a bad idea, but
> >> for the `Untrusted`, it should be fine.
> > 
> > Yup that was my thinking too, the idea being that you write a validator
> > for a single element, and then let Iterator magic handle things when you
> > need to validate an entire array.
> > 
> >>>> +pub trait Validator {
> >>>> +    /// Type of the input data that is untrusted.
> >>>> +    type Input: ?Sized;
> >>>> +    /// Type of the validated data.
> >>>> +    type Output;
> >>>
> >>> So I think the explicit Output makes sense if you have multiple different
> >>> untrusted input that validate to the same trusted structure, but I'm not
> >>> sure this makes sense as associated types. Instead I'd go with generics
> >>> and somethign like this:
> >>>
> >>> pub trait Validator<Input: ?Sized> {
> >>>     type Err;
> >>>
> >>>     fn validate(untrusted: &Untrusted<Input>) -> Result<Self, Self::Err>;
> >>> }
> >>>
> >>> That means you can't implement validate for types from other modules
> >>> directly but need a newtype (I think at least, not sure). But I think
> >>> that's actually a good thing, since often that means you're validating
> >>> some generic state plus whatever your own code needs (like the
> >>> inode::Params<tarfs::INodeData> in your example), and both pieces need to
> >>> be consisted overall and not just individually (otherwise why does the
> >>> that other module not do the parsing for you). And so explicitly treating
> >>> the validated output as an explicit new type just makes sense to me. Plus
> >>> with derive(Deref) it's trivial to unbox after validation.
> >>
> >> There might be the need to validate the same piece of data with
> >> different ways and I am not convinced adding a newtype for every single
> >> case is a good way to achieve it.
> >> Although it would simplify the `Validator` trait... I will think a bit
> >> about this.
> > 
> > Hm, but unless I misunderstand you already need a random type to attach
> > your current trait too? So not worse if we require that for the
> > less-common type of multiple ways to validate the same, and simpler for
> > the common one.
> > 
> >>> Cheers, Sima
> >>
> >> Thanks a lot for taking a look!
> > 
> > I _really_ want this :-)
> > -Sima
> > --
> > Simona Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

