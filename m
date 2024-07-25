Return-Path: <linux-kernel+bounces-262632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B493C9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65C11F23CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9D46522;
	Thu, 25 Jul 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbhgWcFq"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9013C827;
	Thu, 25 Jul 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940238; cv=none; b=aMadQuf4+Dslyt7G2mxqVWZEeuN8MMxqTYEEKFnvzle8LAyC5vEYg37rIeJN9mIuoBwfNa2WJLuAmxffUNPd23UGpYip6SUzLqaC5OvNOjoI6A8Pj3GT+b2kaPCrIwPYON7BoB2aLsDdc5RpV9bhV7B2csbzkXP7UxmVoNPMfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940238; c=relaxed/simple;
	bh=P2aKC8gW2J+UHIPZkZpsfR0wGWUdLzK34g9G2lV4Zks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7AcU0sw0lUqemT0JWhd2nOVMiu/BjHPWU7Hh72b91cEzYUSuZP1jKbiu34AuQqHHcOlj3PJJt+h9g/emeFvMbHr5Zs9TP2n2sUp56984n4/DKByIv5FcBQknyKWmzEi7TkUJMu76Pp0Oh2EeLNYUrouBHtbo+oIRQJ0c153Rsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbhgWcFq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b7a0ef0dfcso7219226d6.1;
        Thu, 25 Jul 2024 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721940235; x=1722545035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bzbox2dvPacn9f1zgOQQPuaJOsdrlkyHVAgxJDLrrE=;
        b=fbhgWcFqMIsgrG21khaZyHUoO3EC7V9eaCkFunC1LcrNmANCkBWAoFprhz+y0lsilI
         dED4E4vhEnz3pWL/5TV4UQL8SngI2oQQZrA5FizfdP+pzs1C4LFJwr35178So4pZCjCr
         xUfA4GiCCbU+jQd5rKsasDuSt5R9yBc8uJXY5xXghB6FGTZ6OiQamcwxUW2bLdlg5tG4
         WjlhohRl5V0odLW3oEZyvhzj5MNq444MRHiZBN/eX1E0KeitNM0PtXDFI5SxEO/oUACT
         rju6pb138AK807/YIv9ht3QQzG5IOnWyTSGW1pdDKs52rNqqx7BZSgP0ZNfOoqIihq6a
         4tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940235; x=1722545035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Bzbox2dvPacn9f1zgOQQPuaJOsdrlkyHVAgxJDLrrE=;
        b=neKaaE1mb8qvyLYXf4aBjhROvh/Iet+yF2E1WnL+7UKg0qa7hv9S3VkMIyfHGsFsk9
         fz7R8Qt3wtr43dqI43wqaGMcKrFIGLUrS72NNkjfHytvH2LnpOXvrAorqta8BzEvIFdH
         whcPFoGklvTt/wGNI/Rk0etU8jCbbXe5zeVkacPRLwvk9dEp1+7zP7JnhqxGzituO0jZ
         lGHjAfxsxVu6+m/jCnal0Y9VEYKZArCqOppRYcK8bibozrHwWskp0Opgx1BX3kjM0tlV
         HOU6S7L2id1krhD8fehkac7GSyP0KgETr/f0iW4im5SSK9MnTAGkF41qEL36wCim0l7v
         2vGA==
X-Forwarded-Encrypted: i=1; AJvYcCVGZLRFqRs2qmoqJ6amnMfq4VC1w0i4m9/ijfVsvmONl8EivSxb6GQMRmyyX3jCUhjn9c1JCsp2k7l3lZ8VTexP0uEznwBof8w8pynsy8BImNpoEkWJbEsc9Rp3Qw18gH3xgMF0rivB
X-Gm-Message-State: AOJu0YwKhLY8hdkiNyQfUXiwbBsrA0GR/l+MU3cH8ap2ukKIGWW1GbAV
	/hAA4QX/ODpZo9t0ObArvKDjkTxXlhHI9ClneSkptQ5yOstocE+4
X-Google-Smtp-Source: AGHT+IFcKNPJe/eqs5LThYNaUNDcu1x1b6/IK/2Y319jGWX1iJRwN5yo9jG8bElcDqdXAC4bppeQHw==
X-Received: by 2002:a05:6214:240e:b0:6b7:abe7:566f with SMTP id 6a1803df08f44-6bb3cac4a74mr49946026d6.43.1721940235531;
        Thu, 25 Jul 2024 13:43:55 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94c76sm10461136d6.92.2024.07.25.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:43:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 643661200068;
	Thu, 25 Jul 2024 16:43:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Jul 2024 16:43:54 -0400
X-ME-Sender: <xms:CrmiZlM9lz6UUKMs2jB7wSM-oUqMukbGMOKkRjG_OvdDl_f7pEaHhA>
    <xme:CrmiZn_K91EEeijhijovZOB8ddHxbiYG3ZeEc0ym1OoTkE29cnqkjS35LO9SuilB7
    RL8CfXcDPvldD__uA>
X-ME-Received: <xmr:CrmiZkSq40zprQBsuV6936ECvaQSTkzZdEYVTAcwCsUKTGeXSuekIs7AfNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdduheefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:CrmiZhsDfHtU5bRJ18ImLZ5r5Mf1nI3LhauGx88qDWR9U-XLcLFEew>
    <xmx:CrmiZtdYv4F2HlDGD7yZ6fdN8wGMPQcvgkHYpv_IFX4ovIAAjNQEyQ>
    <xmx:CrmiZt2ZZAHY1yHTTNAr1ICLJdr3MM0Zs41pkjCJ8wzDb1nXIV_RPQ>
    <xmx:CrmiZp-ia-rGJTl6PUWv_Yy5_lwZagh5AbOw4SObyBQNgoSCzrnqEw>
    <xmx:CrmiZo_kM1nz1b8XljnTIhNANCQ7UGRQTMDUG6PSdvsUQMJqISrYOSWE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 16:43:53 -0400 (EDT)
Date: Thu, 25 Jul 2024 13:43:26 -0700
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
Message-ID: <ZqK47uNmutavG9Vh@boqun-archlinux>
References: <20240710032447.2161189-1-boqun.feng@gmail.com>
 <ef9c98ea-b8ce-4017-9db8-177731996513@proton.me>
 <ZqKwQ4krNB1WjSu5@boqun-archlinux>
 <ba35b142-a5ad-454f-8ed8-216bc6cf4d9c@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba35b142-a5ad-454f-8ed8-216bc6cf4d9c@proton.me>

On Thu, Jul 25, 2024 at 08:32:10PM +0000, Benno Lossin wrote:
> On 25.07.24 22:06, Boqun Feng wrote:
> > Hi Benno,
> > 
> > Thanks for taking a look.
> > 
> > On Thu, Jul 25, 2024 at 06:51:56PM +0000, Benno Lossin wrote:
> >> On 10.07.24 05:24, Boqun Feng wrote:
> >>> As the usage of `ARef` and `AlwaysRefCounted` is growing, it makes sense
> >>> to add explanation of the "ARef pattern" to cover the most "DO" and "DO
> >>> NOT" cases when wrapping a self-refcounted C type.
> >>>
> >>> Hence an "ARef pattern" section is added in the documentation of `ARef`.
> >>>
> >>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >>> ---
> >>> This is motivated by:
> >>>
> >>> 	https://lore.kernel.org/rust-for-linux/20240705110228.qqhhynbwwuwpcdeo@vireshk-i7/
> >>>
> >>>  rust/kernel/types.rs | 156 +++++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 156 insertions(+)
> >>>
> >>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> >>> index bd189d646adb..70fdc780882e 100644
> >>> --- a/rust/kernel/types.rs
> >>> +++ b/rust/kernel/types.rs
> >>> @@ -329,6 +329,162 @@ pub unsafe trait AlwaysRefCounted {
> >>>  ///
> >>>  /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
> >>>  /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> >>> +///
> >>> +/// # [`ARef`] pattern
> >>> +///
> >>> +/// "[`ARef`] pattern" is preferred when wrapping a C struct which has its own refcounting
> >>
> >> I would have written "[...] struct which is reference-counted, because
> >> [...]", is there a specific reason you wrote "its own"?
> >>
> > 
> > "its own" indicates the reference counters are inside the object (i.e.
> > self refcounted), it's different than `Arc<T>` where the reference
> > counters are "attached" to `T`. Your version looks good to me as well.
> 
> I thought about that as well, but the paragraph above talks about a C
> struct, so what is meant with "its own" there?
> 

Still the same thing, the `refcount_t` (or other reference counter
types) is inside the structure other than outside, one example of an
outside reference-counting is:

	struct foo_ref {
		struct foo *foo;
		refcount_t ref;
	}

	struct foo {
		struct foo_ref *ref;
		...
	}

TBH, I'm not sure whether that case really exist and we care or we want
to use `ARef<Foo>` for that case. So I just put "its own" to avoid that
for now and for the documentation purpose.

> >>> +/// mechanism, because it decouples the operations on the object itself (usually via a `&Foo`) vs the
> >>> +/// operations on a pointer to the object (usually via an `ARef<Foo>`). For example, given a `struct
> >>
> >> Not exactly sure I understand your point here, what exactly is the
> >> advantage of decoupling the operations?
> >> In my mind the following points are the advantages of using `ARef`:
> >> (1) prevents having to implement multiple abstractions for a single C
> >>     object: say there is a `struct foo` that is both used via reference
> >>     counting and by-value on the stack. Without `ARef`, we would have to
> >>     write two abstractions, one for each use-case. With `ARef`, we can
> >>     have one `Foo` that can be wrapped with `ARef` to represent a
> >>     reference-counted object.
> >> (2) `ARef<T>` always represents a reference counted object, so it helps
> >>     with understanding the code. If you read `Foo`, you cannot be sure
> >>     if it is heap or stack allocated.
> >> (3) generalizes common code of reference-counted objects (ie avoiding
> >>     code duplication) and concentration of `unsafe` code.
> >>
> >> In my opinion (1) is the most important, then (2). And (3) is a nice
> >> bonus. If you agree with the list above (maybe you also have additional
> >> advantages of `ARef`?) then it would be great if you could also add them
> >> somewhere here.
> >>
> > 
> > Basically to me, the advantages are mostly (1) and (2) in your list,
> > thank you for the list. And I did try to use an example (below) to
> > explain these, because I felt an example of the bad cases is
> > straightforward.
> > 
> > I will add your list here, because although an example may be
> > straightforward of reading, a list of advantages are better for
> > references. Again, thanks a lot!
> > 
> >>> +/// foo` defined in C, which has its own refcounting operations `get_foo()` and `put_foo()`. Without
> >>> +/// "[`ARef`] pattern", i.e. **bad case**:
> >>
> >> Instead of "bad case" I would have written "i.e. you want to avoid this:".
> >>
> > 
> > I'm OK with your version, but for my personal interest, why? ;-)
> 
> I felt like "bad case" did not "flow" right when reading and I also
> think that "you want to avoid this" sounds more polite :)
> 

Got it, will use "you want to avoid this" then.

> >>> +///
> >>> +/// ```ignore
> >>> +/// pub struct Foo(NonNull<foo>);
> >>> +///
> >>> +/// impl Foo {
> >>> +///     // An operation on the pointer.
> >>> +///     pub unsafe fn from_ptr(ptr: *mut foo) -> Self {
> >>> +///         // Note that whether `get_foo()` is needed here depends on the exact semantics of
> >>> +///         // `from_ptr()`: is it creating a new reference, or it continues using the caller's
> >>> +///         // reference?
> >>> +///         unsafe { get_foo(ptr); }
> >>> +///
> >>> +///         unsafe { Foo(NonNull::new_unchecked(foo)) }
> >>> +///     }
> >>> +///
> >>> +///     // An operation on the object.
> >>> +///     pub fn get_bar(&self) -> Bar {
> >>> +///         unsafe { (*foo.0.as_ptr()).bar }
> >>> +///     }
> >>> +/// }
> >>> +///
> >>> +/// // Plus `impl Clone` and `impl Drop` are also needed to implement manually.
> >>> +/// impl Clone for Foo {
> >>> +///     fn clone(&self) -> Self {
> >>> +///         unsafe { get_foo(self.0.as_ptr()); }
> >>> +///
> >>> +///         Foo(self.0)
> >>> +///     }
> >>> +/// }
> >>> +///
> >>> +/// impl Drop for Foo {
> >>> +///     fn drop(&mut self) {
> >>> +///         unsafe { put_foo(self.0.as_ptr()); }
> >>> +///     }
> >>> +/// }
> >>> +/// ```
> >>> +///
> >>> +/// In this case, it's hard to tell whether `Foo` represent an object of `foo` or a pointer to
> >>> +/// `foo`.
> >>> +///
> >>> +/// However, if using [`ARef`] pattern, `foo` can be wrapped as follow:
> >>> +///
> >>> +/// ```ignore
> >>> +/// /// Note: `Opaque` is needed in most cases since there usually exist C operations on
> >>
> >> I would disagree for the reason that `Opaque` is needed. You need it if
> >> the `foo` eg contains a bool, since C might just write a nonsense
> >> integer which would then result in immediate UB in Rust.
> >> Other reasons might be that certain bytes of `foo` are written to by
> >> other threads, even though on the Rust side we have `&mut Foo` (eg a
> >> `mutex`).
> >>
> > 
> > hmm.. "since there usually exist C operations on ..." include these two
> > cases you mentioned, no? Plus, the reference counters themselves are not
> > marked as atomic at the moment, so without `Opaque`, we also have UB
> > because of the reference counters. I was trying to summarize all these
> > as "C operations on ...", maybe I should say "concurrent C operations on
> > ..."? I am trying to be concise here since it's a comment inside a
> > comment ;-)
> 
> Ah that is your definition of "C operations", I interpreted it as "there
> are functions that take `struct foo *`". So maybe it would be good to
> spell out exactly why `Opaque` might be needed.
> I think its fine to be verbose here.
> 

Will do.

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> >>> +/// /// `struct foo *`, and `#[repr(transparent)]` is needed for the safety of converting a `*mut
> >>> +/// /// foo` to a `*mut Foo`
> >>> +/// #[repr(transparent)]
> >>> +/// pub struct Foo(Opaque<foo>);
> >>> +///
> >>> +/// impl Foo {
> >>> +///     pub fn get_bar(&self) -> Bar {
> >>> +///         // SAFETY: `self.0.get()` is a valid pointer.
> >>> +///         //
> >>> +///         // Note: Usually extra safety comments are needed here to explain why accessing `.bar`
> >>> +///         // doesn't race with C side. Most cases are either calling a C function, which has its
> >>> +///         // own concurrent access protection, or holding a lock.
> >>> +///         unsafe { (*self.0.get()).bar }
> >>> +///     }
> >>> +/// }
> >>> +/// ```
> >>> +///
> >>> +/// ## Avoid `impl AlwaysRefCounted` if unnecesarry
> 

