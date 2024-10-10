Return-Path: <linux-kernel+bounces-359292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55E9989D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA2F1C2456E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8711CEAD4;
	Thu, 10 Oct 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYNNcnEV"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9261CB322;
	Thu, 10 Oct 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570580; cv=none; b=kYkseccJY5BpAy1S+geAq9HRY+T+rTxhegoPYdta63c/GJLJIe13faIeQVnjI6WpdvVe7NdKj1KPpZYgsHLz9WQ1glo2u8KEhnz+J+8A05NyJj5pD7FYMpQL0f8lsq5PQonMv2FLYzXOOR+nAvdWKcaODm6vSMJUfujbyjlbB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570580; c=relaxed/simple;
	bh=yt1fgw5vfOoo8fU0GJj0uv/oBhMl0HTiZdDC0jw0ECs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY2aqaRInS4qfjC6TfVzWKaAxb+GvuO8T8/ylnSq05vxi6URkOgCNBiFkqcW8ivtSc3XP9J0f10XwPg0TSvKZThs1x8vfJkc8ZE0iW4zyhz6tN5tXEqzJT2ApckfD2GVv6FyKeikLOdZBMakQsk+abpR9QLN7/m6XhZDsBE8rqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYNNcnEV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-45d8f76eca7so11610691cf.2;
        Thu, 10 Oct 2024 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728570578; x=1729175378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mPey1HDBZR8sZ2lxeY3V+1mHce7z0Zr74RVcUBXVlos=;
        b=VYNNcnEVV/S8VZIDPUwzdgEa+6FHuVBF2jeaxRbsYAcAI7nYH3aNnV8Ayxzw7p0inT
         jmULh5LocfBV0xHROZc5lk/Rk7BeFMmarroi/Inzi/ORRBRVQGFYfXZSpC9CWIVu4VGj
         8GwQ1mb1HkizM7qvrgxJpCy7ZJpuTz/Pi7ulujaMlDWjurDlshNGhKFYjKGSY2HTDl02
         zZ55FxKQQirHhAI1CiTvQkvvPjYEcJsUXMoq9A27+RLkvoydZ6dada8iTQx4EYN+kF0H
         sg9Fp3NO1wuZCP4tr22Y4SnHTgKmbQWlUOsRpLUuGVANcWy/t8PKlu0kJLrlR51kBcky
         hHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570578; x=1729175378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPey1HDBZR8sZ2lxeY3V+1mHce7z0Zr74RVcUBXVlos=;
        b=YD97KbzbzF/nxADmHFHQZUJ3RHknQGZzkU5jHth/GS0kY8YY0wxEQVd+sfjtN0zkDd
         5S4eM07pqk3wKuEAcWokTLYj+nkowce/VI4SJeIW+jlLFpyxiz+Jgi3u+uvZMbCG6KzL
         J/M386ruOyx8b674yfIu9mR0D0gFR3ff5mkr+oDe5+MTdmMg22kISTrmQePwCzWf23Ux
         1c/KR3bknocR3Rhpe6RxcLZBlU47UuuKl6BAfcCMPf5tWBAgZODDxpo4I3i7z0h4iGBa
         LCVkRUMDsBtT3DqTki3uXNIZQMr/xRv4El9auTk7PzZ3OaCJSnuLhWoW3SI9nK3YpgUN
         sJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCUqfEG+D+ppBHOMc6/AtQOufNx+Lc0ZIM0RTgzjiGYCODM4PfdJ0fnz/AUMgYQ9v7VPhOBZGQ9b603Iemc=@vger.kernel.org, AJvYcCWmH/oEUjPWEgcDTtNWvvZ5WfEiS5kBZszPoE+3ehaKUPTZdGDsjtvNwBTaT54OctK0vuMVBz6ldnnpNAKnsoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVHf3cokWcSLKiDy7WIKxHziBzYWvBmHWYti7fE3VK2cPTVIX0
	Mw/ah6T+1OOgpreDbSxIbBB8dkCy0o348pdvhejXPkN8k25P8AoH
X-Google-Smtp-Source: AGHT+IFdlF3uTv72bTDvXsjVsKTtr8dSKnPkTq2e+dwHD5Pbwt8OxDuseeoyXTahvqpos7fm69BVeQ==
X-Received: by 2002:a05:6214:5782:b0:6cb:e496:529b with SMTP id 6a1803df08f44-6cbe49653acmr55890536d6.24.1728570578022;
        Thu, 10 Oct 2024 07:29:38 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe862f82dsm5647566d6.107.2024.10.10.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:29:37 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68B88120006A;
	Thu, 10 Oct 2024 10:29:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 10 Oct 2024 10:29:37 -0400
X-ME-Sender: <xms:0eQHZxJp6aCDnBAUO9n4bBjIDkPDHjUAPxnO_teVxcecV6gIx8IV8Q>
    <xme:0eQHZ9IEVvhdQAC0Sm6Oq06P22BGnEdBPOwHgidem2nz2eIOcz_qW1iWl7M678eFT
    _9O3NtbQGSmBcPYrg>
X-ME-Received: <xmr:0eQHZ5sR7Yl9ZmkN32wm82mK-YLgMWsYp-5TZhY53pdXfq0hqOLF-8FK2PgG1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesgh
    grrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhm
    rghilhdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0eQHZyYtiaGx4YWEHMF8h3ro4p4lkKUJd6PixEU1P4BEfMj0qluGOw>
    <xmx:0eQHZ4YhRNVIEuRLqlc1Cyu-YJLb4Phq-jXoDOT-ExpWzWU7wVUkfg>
    <xmx:0eQHZ2BGj6Bcj80TlDJ_N0Ju7pXauu7LBb8UJo-WRejsYdeYRkFeqw>
    <xmx:0eQHZ2bIWKnep0Lp8weOZ1outlACuBefsuS9yRb0kwNyPD4NFmbDGQ>
    <xmx:0eQHZ0rEkRk0gmVKUV95-o752S6XjdymEDUuVK5J1j13wVqgpTvkSM1f>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 10:29:36 -0400 (EDT)
Date: Thu, 10 Oct 2024 07:29:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <ZwfkzKz5mz6UvZfK@boqun-archlinux>
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
 <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
 <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
 <Zwfcwg23tfrKIyrq@boqun-archlinux>
 <CAH5fLgjhTWjmYqxcTRRv6FTpv7Vg9nnVCGGWbSKPqOSjJ5XyQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjhTWjmYqxcTRRv6FTpv7Vg9nnVCGGWbSKPqOSjJ5XyQA@mail.gmail.com>

On Thu, Oct 10, 2024 at 03:58:07PM +0200, Alice Ryhl wrote:
> On Thu, Oct 10, 2024 at 3:55 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Thu, Oct 10, 2024 at 12:53:00PM +0200, Alice Ryhl wrote:
> > [...]
> > > > > +#[macro_export]
> > > > > +macro_rules! global_lock {
> > > > > +    {
> > > > > +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
> > > > > +        value: $value:expr;
> > > >
> > > > I would find it more natural to use `=` instead of `:` here, since then
> > > > it would read as a normal statement with the semicolon at the end.
> > > > Another alternative would be to use `,` instead of `;`, but that doesn't
> > > > work nicely with the static keyword above (although you could make the
> > > > user write it in another {}, but that also isn't ideal...).
> > > >
> > > > Using `=` instead of `:` makes my editor put the correct amount of
> > > > indentation there, `:` adds a lot of extra spaces.
> > >
> > > That seems sensible.
> > >
> >
> > While we are at it, how about we make the syntax:
> >
> >         global_lock!{
> >             static MY_LOCK: Mutex<u32> = unsafe { 0 };
> >         }
> >
> > or
> >
> >         global_lock!{
> >             static MY_LOCK: Mutex<u32> = unsafe { uninit { 0 } };
> >         }
> >
> > ?
> >
> > i.e. instead of a "value" field, we put it in the "initialization
> > expression". To me, this make it more clear that "value" is the
> > initialized value protected by the lock. Thoughts?
> 
> `uninit { 0 }` looks pretty terrible IMO. Can we come up with something better?
> 

I'm trying, but in the meanwhile, another idea comes to me, can we just
avoid using the `global_lock!` macro if "locked_by" is not needed? I.e.
as the global counter in your examples, we probably need a new lock type
in these cases but we don't use macros. I feel like macros don't bring
us anything in these usages. As a result, we make `global_lock!`
dedicated for locked_by usages, where values should usually be a `()`.

> > Besides, instead of a "guard" type name, could you make a
> > generic guard type over the "locked_by" type? E.g.
> >
> >         struct GlobalGuard<L: GlobalLockedBy>(Guard<...>, PhantomData<*mut L>);
> >
> > I feel like this could make the relationship between the guard type and
> > the locked_by type more obvious. But maybe there's something I'm
> > missing?
> 
> Sorry, I don't understand this. Why is the LockedBy type relevant to the guard?
> 

well, $locked_by's `as_ref()` and `as_mut()` both need a $guard
reference, instead of asking users to provide an arbitrary $guard name,
I thought it's better to just make $guard generic over $locked_by.
However, I realise that $locked_by is a generic type over T, so my
previous proposal doesn't work. How about another way around: making
$locked_by type generic over $guard:

	pub(crate) struct GlobalLockedBy<T: ?Sized, G>(::core::cell::UnsafeCell<T>, ...);

(G is a $guard type)

and if we do

	global_lock!{
	    static MY_LOCK ...;
	    guard: MyGuard;
	}

we can have a struct:

	struct MyStruct {
	    inner: GlobalLockedBy<u32, MyGuard>
	}

instead of asking users to provide a name of the $locked_by type.

Does this makes sense?

Regards,
Boqun

> Alice

