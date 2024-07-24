Return-Path: <linux-kernel+bounces-261345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D67E93B61B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18381F22313
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F21662E5;
	Wed, 24 Jul 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at2+RSxA"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4591BF38;
	Wed, 24 Jul 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843092; cv=none; b=MlDF6Bp/r/ckUaSv5mGTK0OAkgJ6rQusjNmoSVnWqBD4uMg3wEYkOEOyHc0MWTkCBcIAFp3HGsn2gdeBsR1SI5xKIDMs5EUAQskvIF1cCJf39qtTakfdlSmEWMD/yvEPjcWfaM5NpDKEn80kVnWfkQIxT6d7+gC/kFjj1YlPc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843092; c=relaxed/simple;
	bh=aifeDb/Yogov3ZSX/f6KbSjmSKuyb27jNzsI0ncmPs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMycDx0t2R3BMbAF3f96SMFVvWyH7Y8ZWRmKNJ3r+ReGPAWvUgDF0SPHa0szkN0cb8KitwNSgyouflzbz65K5s0yw69VbhNguYXbEcWe77vbjYhRDflSaiI+FcueMhpzLzXubtNyXrcvUJkowqfz+X9AYLV/QsUvE7q0PXB/GDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at2+RSxA; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-492aae5fde6so10931137.1;
        Wed, 24 Jul 2024 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721843090; x=1722447890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbrjmf6eGFou/2U8th1K6YoDJkNPkKQdQpS9YXkclb4=;
        b=at2+RSxA2pJUYZ2loyhu27RCckJM7owvsHLnw16YnzG0UsnE4cdA6gCOA4ikXHXEGP
         zBzEfjIuZbsQZZ416Q+4ms6MVlA+D1DDiBP3B+sOfUlURlmb6jTucd61PBY03DtKCzU6
         Euz4s50nq9gg/zfV3pGv9xNRu+0yAtfPY66c0a124sTYOSsIXFVB2YXBNfIKjzuVIp/n
         HaTy7wXlUTePOna+LaPRB6v5OrByE0MMNqLnasX+WCMSYR3gyo7eNxskZNAdj7rVaj+f
         YDvo5vkK2QXOSCdW2QPrGadSyGnb9Tl9BdDd56Nq6dHfxPMbt7QbRRvT5fo7r/fgYBXw
         HGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721843090; x=1722447890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbrjmf6eGFou/2U8th1K6YoDJkNPkKQdQpS9YXkclb4=;
        b=sbMzxN2iPTKSBzrq6u9uSDezgnLMY3cbBv0jxPx/RwWCabwLcyk/V1Mhm5DhRF96r4
         yefvvZ6P8IosLm2BkQEp8gUECxkPb+QCFJtK9aUITbekoHtLVrkNyfbLY000VSWRgG7X
         u5u5wBgxFfaG2eyQKJS3T/sDz+piZOZl7ohc6T4beBzQbWEmDNgnMTi1SQPBFG9spU2E
         Q8wX5H9Tes6kA7ync7N/+4Vq+nqSr0+9Tla4iW5McNqdQJUVbhvtS6/Etx93AqgmpgFG
         QVFGNElmCrwPmggQr7rFZV97vIwy8sJ0NBZr1cY9UYMuP+riXJcmpDZvN67vGW7A7G2i
         RlDA==
X-Forwarded-Encrypted: i=1; AJvYcCWRE3O1QbA4GM8BBIdSMvl3kHS/hTV28WiRdoc/klQKbTevkkRY72oDkW1Yh9LVjKZGs0fDVz3wN8izxa8V5bfXPwTUEWB/t9uF+ppMujfz9cuMLjG+JeCgAqcXpS8S77A/sNKxDe9n
X-Gm-Message-State: AOJu0YyF/75mZqnt116a5sRfMTUZzYt2revQqDff0eVsvtJ+zW77ibYE
	nbIqkXpaA9s9rZUuNfvot/DD4Aqi355jVTuYiMe6BTZ9ik4HJgCH
X-Google-Smtp-Source: AGHT+IGuDRAbnvZl9A9YCnE8gbnPETn8+UwCvPY/YvlzRxM14j+R+Co3qVJw26odstXnN2DYPghpnQ==
X-Received: by 2002:a05:6102:4b86:b0:492:980c:f53 with SMTP id ada2fe7eead31-493d652e520mr506495137.20.1721843090046;
        Wed, 24 Jul 2024 10:44:50 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fbfa73sm597681585a.30.2024.07.24.10.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:44:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1FB7F1200066;
	Wed, 24 Jul 2024 13:44:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jul 2024 13:44:48 -0400
X-ME-Sender: <xms:kD2hZmHj2kPZ80qycDR9Z4HQKqegxA4-vPP2Jmn5-HFER6A_OJ_gyQ>
    <xme:kD2hZnUS3o9KelVEEhHIs83x7LdTiJnJI774jeS1yyFcjAGthc6Yyav5DRCgSakRd
    YNl9AI8E0aSZQDg-A>
X-ME-Received: <xmr:kD2hZgJSXzdjBXemV_ch5LFF1OwbOOV9QWnZCfLgJSChyZaIkxE8wmm05RW77Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:kD2hZgEj_9FGKEmwgPtPDGdYlMXJdwnM1GUfwEZbEAUWtcI7g2oBsg>
    <xmx:kD2hZsWRRAI_Js-PaHP2qjAIKqPK8ISMSYh2DcBfZM4kZNfAoeelIw>
    <xmx:kD2hZjOrq0pwPucAtidTH3I_YoWq62hQMRd1yR-xANESoXttUZJN6g>
    <xmx:kD2hZj1IiYbIFhrV2Fk8heqzKT_4Uyw8ESThCES9JgNwHJrLpqg3sw>
    <xmx:kD2hZtVcRyb19j7BLinz6hq4uiK8J8QvgqA56A89RLtG17ZKpSFSjGGK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 13:44:47 -0400 (EDT)
Date: Wed, 24 Jul 2024 10:44:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <ZqE9dzfNrE3Xg3tV@boqun-archlinux>
References: <20240710032447.2161189-1-boqun.feng@gmail.com>
 <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com>

On Tue, Jul 23, 2024 at 11:14:29AM +0200, Alice Ryhl wrote:
[...]
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

So I did use the `&Self` -> `ARef<Self>` conversion here,

> > +///     }
> > +/// }
> > +/// ```
> > +///
> > +/// Another function that returns an `ARef<Self>` but with a different semantics is
> > +/// [`ARef::from_raw`]: it takes away the refcount of the input pointer, i.e. no refcount
> > +/// incrementation inside the function.
> > +///

and mentioned the difference between .into() and `ARef::from_raw()`.

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
> I think this is missing some basic information related to `&Self` ->
> `ARef<Self>` conversions. We should explain that these conversions are
> possible, and that you usually don't want `raw_ptr` -> `ARef<Self>` to
> increment the refcount - instead provide a `raw_ptr` -> `&Self` and
> convert the `&Self` to `ARef<Self>`.
> 

I could be more explicit on this, but could there be a case where a `T`
only wants to return `ARef<T>` as a public API? In other words, the
author of `T` doesn't want to expose an `-> &T` function, therefore a
`-> ARef<T>` function makes more sense? If all the users of `T` want to
operate on an `ARef<T>` other than `&T`, I think it makes sense, right?

Overall, I feel like we don't necessarily make a preference between
`->&Self` and `->ARef<Self>` functions here, since it's up to the users'
design?

Regards,
Boqun

> Alice

