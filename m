Return-Path: <linux-kernel+bounces-262611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E793C989
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731641F22667
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18DA13A3E4;
	Thu, 25 Jul 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZxiQtO3"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967FA3CF5E;
	Thu, 25 Jul 2024 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939384; cv=none; b=NxscGUZPGyX8arFKNb+psdQJWVYBFotSzu3lH8Zce8/tyMVrYGxXTyxwAAAl+mLq9MNyluV9h3l1ucE/ZoAN3Jr25w1PYX6+Rd+c+BJPZ0Grtv6+xbSs76A95XGqTONgXeEa6V8b1TcHB3H1FfrpjdiCnAAgD5cpsChsdqb6aMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939384; c=relaxed/simple;
	bh=yIOrGJw3/wy8lYDfslWXWRcdgiWW4lqtUcp2/F3Xvn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsEidov6RKOZxTjA5ArCU7WIRJLI3o58emrr8GvzkUELgq0GTfb/Fht5gc/gGfdZlNXCDqCFV2sQ3A3+lSWi84pEF6pQ6u+6gdYzIS/SKcsY0PpPUK05tdcadbJLEgjxhQAIVivlZ+VmpTzygVK8gDaOKMdiMkKs11gFSKwqquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZxiQtO3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fe106616eso7024311cf.1;
        Thu, 25 Jul 2024 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721939381; x=1722544181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtQTXFhqHAwujKa2OcAbO7wIrqd2cinc7mxsU14TaUg=;
        b=FZxiQtO3V8PloGNfiayesNaK0uNE6HkvPJR536W2OHrMF+DEr2H1oiT5ar6De4iICf
         Br+YlCzllGTKf2A9QxI8RssKKVqXDlqDfPrLI34ikSInAo3byRQNWqd1z2j7hLwq1Den
         e5QARYHAUkK5TSykU38E3nZ9r06aif7g+qYpGxdawLLaKG7tVSwkuY7mP+qmLJf5MU4c
         imQ/SSYpKDEfivEtBauT/wWt10q2fgJsHtLIejBFFTRrMnPIJwj7z4DstjAugkRmwvjJ
         spDOwdwlS+X/6QJ45Kl/laJg4hAFlKXgBDsyGOO77DU207+HjY+kqg5zwHU1A3Lk/jgC
         n1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939381; x=1722544181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtQTXFhqHAwujKa2OcAbO7wIrqd2cinc7mxsU14TaUg=;
        b=v8f48CzRw6IJJFG5o1d7eHWOZgwSbEYDsV7ZlgYsG1Cd0ubHVjS0rxkO9LZlq6cSYC
         ObcwdGuSuybNBbDJG6tuOudW8LjF0IIlrsrNXazkHT7pBWmCYaTii0tFi5tWrSLkTabR
         s8slyWWwtFVUMNJJx8fPmoQm00WeDF4suOznIyamzhLBHqTTJHQbtaWEWasmTPV0AD8A
         lm6ffDg+F2fbPP+MAChBZfhRfIw+FHjCrBfgfAXnhzK0gC/v0r1CAh8AqkI4tr+RjtZM
         mQ4/KTLWOmklHqD1elJaAjh0fvwgRh/fJqpZLJBxAc7fodMZffNM5CO9rdveor8zNxqT
         AP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVI8KTL+7MCdaeiJ8inbAt24aI/+LMLPvgAruxh+wnWSytFPMBlp4zAE+boOUscOK+bwBegqi52nLMm7LKPOqkIBZTOR8k1ttRX0J2R4xaou9HvdSimsQe0HBf2FxjvXNVIDAzdCaviG8zjaRKvscDsUoqnhqj/btkNSriO0Z/K3q5wviY21g=
X-Gm-Message-State: AOJu0YwdoOFLhhvOI5NTdFTpf2J703dTa+NBU9kGvhsHo2iufn2ypaCu
	Yo2SBBme9I4pvjIb4Ezbg4XWmZaKQjkECmGnozCMO1t+2X9sCCAM
X-Google-Smtp-Source: AGHT+IFxn2jYmJ6H0PtQJorYBU8RTcQAMO6kJp7hasSszQ1RqYQhjL8mezCx0O9OCgxnxuCHL052tg==
X-Received: by 2002:ac8:7f85:0:b0:447:bfb2:f9fc with SMTP id d75a77b69052e-44fe32a0a3bmr55517011cf.12.1721939381357;
        Thu, 25 Jul 2024 13:29:41 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8208549sm8847511cf.59.2024.07.25.13.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:29:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E4E501200069;
	Thu, 25 Jul 2024 16:29:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 25 Jul 2024 16:29:39 -0400
X-ME-Sender: <xms:s7WiZnGhjXCEms9JvDmu5dzUcYNp0OV8-r6ReiaU7PNrmgfQL_fz1g>
    <xme:s7WiZkVfe0X37Us0FFSpZCUBf0pYxGwTzLLbNNNgKx9A65IUDs7qkLIMJhgxMMD_H
    6wisWxx9jm2HPET-g>
X-ME-Received: <xmr:s7WiZpLmGw4HfuYHVwYt17V8XeX_ApJ9cziEsLwfmWjxtVPF6s2SuMwBKqvqnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:s7WiZlHEg4ImW0c04R5TLS9h_AILbmSWUmMJd4ODoBN-V3wD_T7IaQ>
    <xmx:s7WiZtUga2nxC8vfZaWv8DHCQ-nshqnTCPv220oSdsF9n2MNwx1TvA>
    <xmx:s7WiZgP1Xp0GYyEsjuEYId3Ps0oyDbVN80AGtUyq0qZC0hbhv1bkLQ>
    <xmx:s7WiZs2V8DzzIC6zM51b3APnjG8XPbDI5QC3nejN8LwEA9vIfu9DAQ>
    <xmx:s7WiZiXDsgBAcv6wdoioaGysFqPZhAteR4JJ1krunMyOJxPtyJDzS48a>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 16:29:39 -0400 (EDT)
Date: Thu, 25 Jul 2024 13:29:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <ZqK1l05zcCwGforV@boqun-archlinux>
References: <20240710032447.2161189-1-boqun.feng@gmail.com>
 <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com>
 <ZqE9dzfNrE3Xg3tV@boqun-archlinux>
 <bcdd74f3-d0c0-4366-976a-5a935081a704@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcdd74f3-d0c0-4366-976a-5a935081a704@proton.me>

On Thu, Jul 25, 2024 at 06:12:56PM +0000, Benno Lossin wrote:
> On 24.07.24 19:44, Boqun Feng wrote:
> > On Tue, Jul 23, 2024 at 11:14:29AM +0200, Alice Ryhl wrote:
> >>> +/// However `&Self` represents a reference to the object, and the lifetime of the **reference** is
> >>> +/// known at compile-time. E.g. the `Foo::as_ref()` above.
> >>> +///
> >>> +/// ## `impl Drop` of an `impl AlwaysRefCounted` should not touch the refcount
> >>> +///
> >>> +/// [`ARef`] descreases the refcount automatically (in [`ARef::drop`]) when it goes out of the
> >>> +/// scope, therefore there's no need to `impl Drop` for the type of objects (e.g. `Foo`) to decrease
> >>> +/// the refcount.
> >>>  pub struct ARef<T: AlwaysRefCounted> {
> >>>      ptr: NonNull<T>,
> >>>      _p: PhantomData<T>,
> >>> --
> >>> 2.45.2
> >>>
> >>
> >> I think this is missing some basic information related to `&Self` ->
> >> `ARef<Self>` conversions. We should explain that these conversions are
> >> possible, and that you usually don't want `raw_ptr` -> `ARef<Self>` to
> >> increment the refcount - instead provide a `raw_ptr` -> `&Self` and
> >> convert the `&Self` to `ARef<Self>`.
> >>
> > 
> > I could be more explicit on this, but could there be a case where a `T`
> > only wants to return `ARef<T>` as a public API? In other words, the
> > author of `T` doesn't want to expose an `-> &T` function, therefore a
> > `-> ARef<T>` function makes more sense? If all the users of `T` want to
> > operate on an `ARef<T>` other than `&T`, I think it makes sense, right?
> 
> You can always get a `&T` from `ARef<T>`, since it implements `Deref`.
> 

Yeah, but this is unrelated. I was talking about that API providers can
decide whether they want to only provide a `raw_ptr` -> `ARef<Self>` if
they don't need to provide a `raw_ptr` -> `&Self`.

> > Overall, I feel like we don't necessarily make a preference between
> > `->&Self` and `->ARef<Self>` functions here, since it's up to the users'
> > design?
> 
> I would argue that there should be a clear preference for functions
> returning `&Self` when possible (ie there is a parameter that the

If "possible" also means there's going to be `raw_ptr` -> `&Self`
function (as the same publicity level) anyway, then agreed. In other
words, if the users only need the `raw_ptr` -> `ARef<Self>`
functionality, we don't want to force people to provide a `raw_ptr` ->
`&Self` just because, right?

Regards,
Boqun

> lifetime can bind to). This is because then you get the two versions of
> the function (non-incrementing and incrementing) for the price of one
> function.
> 
> ---
> Cheers,
> Benno
> 

