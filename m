Return-Path: <linux-kernel+bounces-262605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2693C952
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8F228264C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7477F11;
	Thu, 25 Jul 2024 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TImlI60G"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B954C7B;
	Thu, 25 Jul 2024 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938020; cv=none; b=sZXsmdvcMoISbHEu1k7AtOs52YaTJFwsqUbi3LcMlivFRaFFyj9nvC6hBTZKriBPFFeh3tyOtjSyf17Tx+OH7lHWF56enAP0YIIBImilEjuN8o2hhyhor0TADkx7qy0RqvhslWuLI7ZVcC9CRQKbfRkHqKuzeCLlqMOWTp3ciTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938020; c=relaxed/simple;
	bh=5ymonCN+xqRYhhm6L1ISL2iOQloQav1MvZhTGKjuCMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqrIrwfMpu0tqEPxaw0dpAye7kgF39veD6B2Z9fMTHoNPGKafjRjuSYZg3FDJQl9SWT6IpyNi13mAVA7kRSvdya5LDpH2PaXIppb1JgZwbWnc53fg39o5o1ZKQrQkV2k6vjxJsWxrgJlswNNhu+OXf2Y++hroGLpk+9SRtZzV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TImlI60G; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7037a208ff5so184933a34.0;
        Thu, 25 Jul 2024 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721938018; x=1722542818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcsaS3xlIHvq0RPP0War+uG33YjpMeGah3OHxpiowAI=;
        b=TImlI60GehVjCmI41XPUY56+eMnQ+2h9LEwpNE5raOHcIG55mPBuKrfThLWxGbKXJ1
         TThuxIDwci54dVvWe6jWacENxcAtEGG2nBYVUcVUtQJxV9EmrSYleHuJmiv36SDV9dFH
         T52GcgP430ymoOnecBRrMjbJniJQ7CUc1+JE12I/TttENxE7WS34dmhNtsmw/jtyuHEZ
         5l6YZB5yHFkzogipChjGbrvFeF2Ge9J0WzYRldvwI3nxOd8q5BHeP0NhLsXshxl6zrCq
         bBXt8/gNHsn18+uQz0gbvcE9GbDschGDF7elof5r5lGcGNL82v2rWROMZwAdxCqe9RWo
         rkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938018; x=1722542818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcsaS3xlIHvq0RPP0War+uG33YjpMeGah3OHxpiowAI=;
        b=bziVR4oRSfkAP1so75rA1qBOviikfolt8/NwDFdFggPmQ2/jwculbHXkqQEozt5+1D
         5+I68Ldnkm/eloGpwuT6AhjL651Dvfl7fHjpgasyDsh53Iptb9fp6SAWuaz1jSGrNp0V
         iDyPV6pTGao93xyHq6QLjdCaQ21vRYV6ThnhJwMK8H+Ivcex49OqayFdepX97riB+V1x
         2ezydnhEXmbCjMagPgglv42Z/7rw/3h9+ZgVhCES+UjMmb7P+1Yh/HUMCc2tT4hvqWzU
         peDWdO6D21m1aI2QAGJEHxtR5vNNX36UPRnuz9D0VpPputbeZtAsaiR8o3/wnX/TEwB1
         JxHw==
X-Forwarded-Encrypted: i=1; AJvYcCWCynlMkIOl1RP0Q8TyarKH4JlOsC1Xijk/9+v5Z4k/K6aVLFmvcRILvHbG6zR8lCxJ7mEBpnAk/cAJhPbY7sI799uYQjCH2aqrwr17R7KwwQyPSYDMUv/AKHvhu7DJWfvIuvwwmw4a
X-Gm-Message-State: AOJu0Yy+J+vARAhS6pGCVc1G3mhobpf3xFr1xm01BnHRsJHJclhoX7m1
	H2KEpbwrxEfjUEzzdy24VERiHDRtNBHYwRrHp60ek1Wi6fRTWH3w
X-Google-Smtp-Source: AGHT+IGI0gbXMG6eC/sBfYpiX/QRbzKwYIyyjIGnCI+BLlXOtZxdYnE8+B/UMewjGfzKqsGqRnft6w==
X-Received: by 2002:a05:6830:6018:b0:703:6988:dbed with SMTP id 46e09a7af769-7093251bcffmr3758086a34.34.1721938018002;
        Thu, 25 Jul 2024 13:06:58 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b46b4sm113027985a.53.2024.07.25.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:06:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E10521200066;
	Thu, 25 Jul 2024 16:06:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 25 Jul 2024 16:06:55 -0400
X-ME-Sender: <xms:X7CiZgtAs9y_DqtpqCEdOIGQaP4bhbV07JDGMgq-fpG2l1Y_5ZDS3Q>
    <xme:X7CiZtdC9t9XAnyqqJJHCL1ruciCVMe9cNuzoU3RbLzCFwza5eUEIMgbzLlNmT3RN
    DgymxX_o0jokgosMQ>
X-ME-Received: <xmr:X7CiZrz3e6NRFKYOOIRSSVw9cxPaSIeohlxrPVuIkI7bEsMTdAI0hYORYxdAbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekleejvdeggfetueegjeetteeffedvjeevheejffetteehfeeufeehteeu
    udevteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhsthgrnhgtvgdrihhnpd
    grshgpphhtrhdrsggrrhdpghgvthdrsggrrhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:X7CiZjPPjqoA7PkYXHv5-P-4TcU-MO9QpgugJ-I1ZR_Xq_tf-UuhPw>
    <xmx:X7CiZg_PPWaPY3aPbU2TfSFoOYqzTJGJ4IZIbLPUAdrs7BGEZjeCxw>
    <xmx:X7CiZrU_E3VnZd7mzKtVzl1Th-n34Loydd030x57tSnhJiPqtSmUug>
    <xmx:X7CiZpdP6EdSw_H0zwHw-wqCWN1i3J8H14QMG-Eqa64SZ5zkn6moLg>
    <xmx:X7CiZidaUK_-ihwBtp-5U2oe_xTelofdnlJSxYbt6w-TQcAqZvT74klD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 16:06:54 -0400 (EDT)
Date: Thu, 25 Jul 2024 13:06:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <ZqKwQ4krNB1WjSu5@boqun-archlinux>
References: <20240710032447.2161189-1-boqun.feng@gmail.com>
 <ef9c98ea-b8ce-4017-9db8-177731996513@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9c98ea-b8ce-4017-9db8-177731996513@proton.me>

Hi Benno,

Thanks for taking a look.

On Thu, Jul 25, 2024 at 06:51:56PM +0000, Benno Lossin wrote:
> On 10.07.24 05:24, Boqun Feng wrote:
> > As the usage of `ARef` and `AlwaysRefCounted` is growing, it makes sense
> > to add explanation of the "ARef pattern" to cover the most "DO" and "DO
> > NOT" cases when wrapping a self-refcounted C type.
> > 
> > Hence an "ARef pattern" section is added in the documentation of `ARef`.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > This is motivated by:
> > 
> > 	https://lore.kernel.org/rust-for-linux/20240705110228.qqhhynbwwuwpcdeo@vireshk-i7/
> > 
> >  rust/kernel/types.rs | 156 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 156 insertions(+)
> > 
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index bd189d646adb..70fdc780882e 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -329,6 +329,162 @@ pub unsafe trait AlwaysRefCounted {
> >  ///
> >  /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
> >  /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> > +///
> > +/// # [`ARef`] pattern
> > +///
> > +/// "[`ARef`] pattern" is preferred when wrapping a C struct which has its own refcounting
> 
> I would have written "[...] struct which is reference-counted, because
> [...]", is there a specific reason you wrote "its own"?
> 

"its own" indicates the reference counters are inside the object (i.e.
self refcounted), it's different than `Arc<T>` where the reference
counters are "attached" to `T`. Your version looks good to me as well.

> > +/// mechanism, because it decouples the operations on the object itself (usually via a `&Foo`) vs the
> > +/// operations on a pointer to the object (usually via an `ARef<Foo>`). For example, given a `struct
> 
> Not exactly sure I understand your point here, what exactly is the
> advantage of decoupling the operations?
> In my mind the following points are the advantages of using `ARef`:
> (1) prevents having to implement multiple abstractions for a single C
>     object: say there is a `struct foo` that is both used via reference
>     counting and by-value on the stack. Without `ARef`, we would have to
>     write two abstractions, one for each use-case. With `ARef`, we can
>     have one `Foo` that can be wrapped with `ARef` to represent a
>     reference-counted object.
> (2) `ARef<T>` always represents a reference counted object, so it helps
>     with understanding the code. If you read `Foo`, you cannot be sure
>     if it is heap or stack allocated.
> (3) generalizes common code of reference-counted objects (ie avoiding
>     code duplication) and concentration of `unsafe` code.
> 
> In my opinion (1) is the most important, then (2). And (3) is a nice
> bonus. If you agree with the list above (maybe you also have additional
> advantages of `ARef`?) then it would be great if you could also add them
> somewhere here.
> 

Basically to me, the advantages are mostly (1) and (2) in your list,
thank you for the list. And I did try to use an example (below) to
explain these, because I felt an example of the bad cases is
straightforward.

I will add your list here, because although an example may be
straightforward of reading, a list of advantages are better for
references. Again, thanks a lot!

> > +/// foo` defined in C, which has its own refcounting operations `get_foo()` and `put_foo()`. Without
> > +/// "[`ARef`] pattern", i.e. **bad case**:
> 
> Instead of "bad case" I would have written "i.e. you want to avoid this:".
> 

I'm OK with your version, but for my personal interest, why? ;-)

> > +///
> > +/// ```ignore
> > +/// pub struct Foo(NonNull<foo>);
> > +///
> > +/// impl Foo {
> > +///     // An operation on the pointer.
> > +///     pub unsafe fn from_ptr(ptr: *mut foo) -> Self {
> > +///         // Note that whether `get_foo()` is needed here depends on the exact semantics of
> > +///         // `from_ptr()`: is it creating a new reference, or it continues using the caller's
> > +///         // reference?
> > +///         unsafe { get_foo(ptr); }
> > +///
> > +///         unsafe { Foo(NonNull::new_unchecked(foo)) }
> > +///     }
> > +///
> > +///     // An operation on the object.
> > +///     pub fn get_bar(&self) -> Bar {
> > +///         unsafe { (*foo.0.as_ptr()).bar }
> > +///     }
> > +/// }
> > +///
> > +/// // Plus `impl Clone` and `impl Drop` are also needed to implement manually.
> > +/// impl Clone for Foo {
> > +///     fn clone(&self) -> Self {
> > +///         unsafe { get_foo(self.0.as_ptr()); }
> > +///
> > +///         Foo(self.0)
> > +///     }
> > +/// }
> > +///
> > +/// impl Drop for Foo {
> > +///     fn drop(&mut self) {
> > +///         unsafe { put_foo(self.0.as_ptr()); }
> > +///     }
> > +/// }
> > +/// ```
> > +///
> > +/// In this case, it's hard to tell whether `Foo` represent an object of `foo` or a pointer to
> > +/// `foo`.
> > +///
> > +/// However, if using [`ARef`] pattern, `foo` can be wrapped as follow:
> > +///
> > +/// ```ignore
> > +/// /// Note: `Opaque` is needed in most cases since there usually exist C operations on
> 
> I would disagree for the reason that `Opaque` is needed. You need it if
> the `foo` eg contains a bool, since C might just write a nonsense
> integer which would then result in immediate UB in Rust.
> Other reasons might be that certain bytes of `foo` are written to by
> other threads, even though on the Rust side we have `&mut Foo` (eg a
> `mutex`).
> 

hmm.. "since there usually exist C operations on ..." include these two
cases you mentioned, no? Plus, the reference counters themselves are not
marked as atomic at the moment, so without `Opaque`, we also have UB
because of the reference counters. I was trying to summarize all these
as "C operations on ...", maybe I should say "concurrent C operations on
..."? I am trying to be concise here since it's a comment inside a
comment ;-)

> > +/// /// `struct foo *`, and `#[repr(transparent)]` is needed for the safety of converting a `*mut
> > +/// /// foo` to a `*mut Foo`
> > +/// #[repr(transparent)]
> > +/// pub struct Foo(Opaque<foo>);
> > +///
> > +/// impl Foo {
> > +///     pub fn get_bar(&self) -> Bar {
> > +///         // SAFETY: `self.0.get()` is a valid pointer.
> > +///         //
> > +///         // Note: Usually extra safety comments are needed here to explain why accessing `.bar`
> > +///         // doesn't race with C side. Most cases are either calling a C function, which has its
> > +///         // own concurrent access protection, or holding a lock.
> > +///         unsafe { (*self.0.get()).bar }
> > +///     }
> > +/// }
> > +/// ```
> > +///
> > +/// ## Avoid `impl AlwaysRefCounted` if unnecesarry
> 
> I would move this section below the next one.
> 
> > +///
> > +/// If Rust code doesn't touch the part where the object lifetimes of `foo` are maintained, `impl
> > +/// AlwaysRefCounted` can be temporarily avoided: it can always be added later as an extension of
> > +/// the functionality of the Rust code. This is usually the case for callbacks where the object
> > +/// lifetimes are already maintained by a framework. In such a case, an `unsafe` `fn(*mut foo) ->
> > +/// &Foo` function usually suffices:
> > +///
> > +/// ```ignore
> > +/// impl Foo {
> > +///     /// # Safety
> > +///     ///
> > +///     /// `ptr` has to be a valid pointer to `foo` for the entire lifetime `'a'.
> > +///     pub unsafe fn as_ref<'a>(ptr: *mut foo) -> &'a Self {
> > +///         // SAFETY: Per function safety requirement, reborrow is valid.
> > +///         unsafe { &*ptr.cast() }
> > +///     }
> > +/// }
> > +/// ```
> > +///
> > +/// ## Type invariants of `impl AlwaysRefCounted`
> 
> I think you should first show how the example looks like with `ARef` and
> then talk about type invariants.
> 

These two sound good to me.

Regards,
Boqun

> > +///
> > +/// Types that `impl AlwaysRefCounted` usually needs an invariant to describe why the type can meet
> > +/// the safety requirement of `AlwaysRefCounted`, e.g.
> > +///
> > +/// ```ignore
> > +/// /// # Invariants:
> > +/// ///
> > +/// /// Instances of this type are always refcounted, that is, a call to `get_foo` ensures that the
> > +/// /// allocation remains valid at least until the matching call to `put_foo`.
> > +/// #[repr(transparent)]
> > +/// pub struct Foo(Opaque<foo>);
> > +///
> > +/// // SAFETY: `Foo` is always ref-counted per type invariants.
> > +/// unsafe impl AlwaysRefCounted for Foo {
> > +///     fn inc_ref(&self) {
> > +///         // SAFETY: `self.0.get()` is a valid pointer and per type invariants, the existence of
> > +///         // `&self` means it has a non-zero reference count.
> > +///         unsafe { get_foo(self.0.get()); }
> > +///     }
> > +///
> > +///     unsafe dec_ref(obj: NonNull<Self>) {
> > +///         // SAFETY: The refcount of `obj` is non-zero per function safety requirement, and the
> > +///         // cast is OK since `foo` is transparent to `Foo`.
> > +///         unsafe { put_foo(obj.cast()); }
> > +///     }
> > +/// }
> > +/// ```
> > +///
> > +/// After `impl AlwaysRefCounted for foo`, `clone()` (`get_foo()`) and `drop()` (`put_foo()`)  are
> 
> Typo: it should be `impl AlwaysRefCounted for Foo`.
> 
> ---
> Cheers,
> Benno
> 
> > +/// available to `ARef<Foo>` thanks to the generic implementation.
> > +///
> > +/// ## `ARef<Self>` vs `&Self`
> > +///
> > +/// For an `impl AlwaysRefCounted` type, `ARef<Self>` represents an owner of one reference count,
> > +/// e.g.
> > +///
> > +/// ```ignore
> > +/// impl Foo {
> > +///     /// Gets a ref-counted reference of [`Self`].
> > +///     ///
> > +///     /// # Safety
> > +///     ///
> > +///     /// - `ptr` must be a valid pointer to `foo` with at least one reference count.
> > +///     pub unsafe fn from_ptr(ptr: *mut foo) -> ARef<Self> {
> > +///         // SAFETY: `ptr` is a valid pointer per function safety requirement. The cast is OK
> > +///         // since `foo` is transparent to `Foo`.
> > +///         //
> > +///         // Note: `.into()` here increases the reference count, so the returned value has its own
> > +///         // reference count.
> > +///         unsafe { &*(ptr.cast::<Foo>()) }.into()
> > +///     }
> > +/// }
> > +/// ```
> > +///
> > +/// Another function that returns an `ARef<Self>` but with a different semantics is
> > +/// [`ARef::from_raw`]: it takes away the refcount of the input pointer, i.e. no refcount
> > +/// incrementation inside the function.
> > +///
> > +/// However `&Self` represents a reference to the object, and the lifetime of the **reference** is
> > +/// known at compile-time. E.g. the `Foo::as_ref()` above.
> > +///
> > +/// ## `impl Drop` of an `impl AlwaysRefCounted` should not touch the refcount
> > +///
> > +/// [`ARef`] descreases the refcount automatically (in [`ARef::drop`]) when it goes out of the
> > +/// scope, therefore there's no need to `impl Drop` for the type of objects (e.g. `Foo`) to decrease
> > +/// the refcount.
> >  pub struct ARef<T: AlwaysRefCounted> {
> >      ptr: NonNull<T>,
> >      _p: PhantomData<T>,
> > --
> > 2.45.2
> > 
> 

