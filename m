Return-Path: <linux-kernel+bounces-263381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B883C93D52E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F409285BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465218EAB;
	Fri, 26 Jul 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T95WVML+"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B3812;
	Fri, 26 Jul 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004586; cv=none; b=TTQCdaFviDi9aSrUIrFVeom34oEjpZUC3CC4dd4Beek5apJX7r587GnOUBBFCBQxAfE6Xm0AhvSncQKFsw59r1vljFOsBWGE3hMXyATJsTRxuXZNWGHCs+LZ8m6ABCTOskE/YCiGPMWSpJ3MwnYAI5qKLUtHaeOX1zjFz4omZ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004586; c=relaxed/simple;
	bh=4Dd5AoHU0SMLTCIF6OFvhFgmGSeR8YEhVFZWnBmhg+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJBG5YCYGuHiaJX669+Xm1RpbwMtFElyn/EojpLeeuPF75SPES/Guq7ZKAd8iPhdO3BJuVYYyjs/NqE+ZjTQotY3ITLPxUAmN0QrJqlFnt5FbscYHpERVLMYiJ07hKc0rwXb6u2sBCWSktqiPGvuXVauYslcQKkQhWCX3plxzvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T95WVML+; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5aeaa9751so717269eaf.1;
        Fri, 26 Jul 2024 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722004584; x=1722609384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh29toBTVf8xzVna8B6Q5StEADLpjsmJZZuQq5lxN00=;
        b=T95WVML+574zogKm1EW134Pt36kAd5gMmqIVMsUxvh6Wyp5KlPIM7qW9a3GlUAcPh0
         DirzIB2TvmGqE38UPRbUTY+0nPhbc7HVvGEsO58zvtH62MunqEHu/0AKOP5gkQlZG27e
         SikbnRocmFcyQfUdTOoVNpM7y/oz2qrBjjKIbyIFEzOPek14ayyPOH5vo30g9K2mwHDQ
         faAYyIrNmZRBBVb4anUUcm6uGtrKqhHdd9XZC05rzH0wg8q26tp+dx6bOj9REtrW+UGh
         THEXyGj4PIP7vmfbUEenwtQu3rGHRsfZlFDA6JyDb7LpHk0zhp+QURFZjpvnqchiQMlD
         Vuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722004584; x=1722609384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh29toBTVf8xzVna8B6Q5StEADLpjsmJZZuQq5lxN00=;
        b=eVlr2SfycXPSZld25Bx5/icpDsjZoCCbZfKR4A5Ahv4VHPrLidHbkwRFCjxQWLj79z
         jEy8scBMa5zGL7zPIUSUMIaSIQi/zzujcY3cVGKilMoJHZT2FkoWNzhH8gTLF0gsL/8o
         50oJJehxthVF+S0+B2bk6QebRy6VkopAd6tO0hSmbWiEVOuMI1QWlGZm+YpO3fwybFsk
         ADHBiranILymTZVu1N/CEM8R5jMustbn/1P3xXyaC67wosOYoPZ/is/mEYFp/kEdbu6u
         zW7tiuwlPLa1nFLndY6MtnYw8fv8Y3mzSDqFoa1lVkrHCUvegwV1M9EONILlBmgEzWK+
         bA2A==
X-Forwarded-Encrypted: i=1; AJvYcCXG04UG/YFzxpBLjua+FfGoxSWpqcX/vfpyFhzreTGd05mSgV5NAbqcVDUSKG9EhFgYwmBBGXyQZOVmejbtnfj0ds4NcDkvO1wENg0iaC7TlLLP08VBnoOahiBfSMX8FRjwhN5Lj/R9+zXjJrxsuvjZrpTCYyIk75HWklB7mEL8W7bekODRuPo=
X-Gm-Message-State: AOJu0Yysq7ziKyKXYHL5GscxXYiW1n5wkbfRs4RphqApNQak6ADsDyaf
	8KaOIbC6gYOUZFhhP8jYLchbFfAbmPKXiPim/DarzYx79SnK1aG7
X-Google-Smtp-Source: AGHT+IHVj3Io/Se1zpac5kyA9nJZOi+gzcUQgfuFUuJLo90pSUL7UIAfe8asXAwD7BCwOyP/S7L5+g==
X-Received: by 2002:a05:6358:5694:b0:1aa:b152:c7c5 with SMTP id e5c5f4694b2df-1acf8869d74mr828174255d.12.1722004583487;
        Fri, 26 Jul 2024 07:36:23 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fae6efbsm17093786d6.127.2024.07.26.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:36:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 90E1F1200043;
	Fri, 26 Jul 2024 10:26:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 10:26:59 -0400
X-ME-Sender: <xms:M7KjZkeOGYZvyelOvx8VcU1lkk5PYPBY-5k6d6-8pUfcPbeb3x4oIw>
    <xme:M7KjZmN6HxKVdkYP-gSDvy0QJeCa1DAs2t-0AKaT6K8eyrU5bvHeNyxgFnP7JVNb_
    nnbdMmvchs1SrZsVw>
X-ME-Received: <xmr:M7KjZlhmAKTW-7_-oOVMIRx4Wio9MohUChHlg460imFEooyHTD7KwCxlsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:M7KjZp8PIh6YY1wlXJPAB2tvnGcwDSBf9fyefcxsLVgRcNeDZhv9gQ>
    <xmx:M7KjZgtFYfP5H5TFVZXuR9_9GmKqfS2IxLH-6-ZMrffBEjradqsnnw>
    <xmx:M7KjZgHkfLU5AJXNK4ySQrqXcDMyRLqB1z_qWXS80QgU9QTSOI1CXA>
    <xmx:M7KjZvOLj_ycMtsy9ALWX-66yAqsPXmEC52r8USklAgd3fMSP_2f7Q>
    <xmx:M7KjZlO1j0dZVK4FelT0oimbWkHNCU9mMJ0ql8IWv80F7qv5kSqVRr6G>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 10:26:59 -0400 (EDT)
Date: Fri, 26 Jul 2024 07:26:57 -0700
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
Message-ID: <ZqOyMbi7xl67UfjY@Boquns-Mac-mini.home>
References: <20240710032447.2161189-1-boqun.feng@gmail.com>
 <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com>
 <ZqE9dzfNrE3Xg3tV@boqun-archlinux>
 <bcdd74f3-d0c0-4366-976a-5a935081a704@proton.me>
 <ZqK1l05zcCwGforV@boqun-archlinux>
 <beaf1fa3-eebe-443c-bc51-abd9348a411d@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beaf1fa3-eebe-443c-bc51-abd9348a411d@proton.me>

On Fri, Jul 26, 2024 at 01:43:38PM +0000, Benno Lossin wrote:
[...]
> >>
> >> You can always get a `&T` from `ARef<T>`, since it implements `Deref`.
> >>
> > 
> > Yeah, but this is unrelated. I was talking about that API providers can
> > decide whether they want to only provide a `raw_ptr` -> `ARef<Self>` if
> > they don't need to provide a `raw_ptr` -> `&Self`.
> > 
> >>> Overall, I feel like we don't necessarily make a preference between
> >>> `->&Self` and `->ARef<Self>` functions here, since it's up to the users'
> >>> design?
> >>
> >> I would argue that there should be a clear preference for functions
> >> returning `&Self` when possible (ie there is a parameter that the
> > 
> > If "possible" also means there's going to be `raw_ptr` -> `&Self`
> > function (as the same publicity level) anyway, then agreed. In other
> > words, if the users only need the `raw_ptr` -> `ARef<Self>`
> > functionality, we don't want to force people to provide a `raw_ptr` ->
> > `&Self` just because, right?
> 
> I see... I am having a hard time coming up with an example where users
> would exclusively want `ARef<Self>` though... What do you have in mind?
> Normally types wrapped by `ARef` have `&self` methods.
> 

Having `&self` methods doesn't mean the necessarity of a `raw_ptr` ->
`&Self` function, for example, a `Foo` is wrapped as follow:

	struct Foo(Opaque<foo>);
	impl Foo {
	    pub fn bar(&self) -> Bar { ... }
	    pub unsafe fn get_foo(ptr: *mut foo) -> ARef<Foo> { ... }
	}

in this case, the abstration provider may not want user to get a
`raw_ptr` -> `&Self` function, so no need to have it.

Regards,
Boqun

> Cheers,
> Benno
> 

