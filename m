Return-Path: <linux-kernel+bounces-263434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51893D5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D00283BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588417838B;
	Fri, 26 Jul 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDPKRqXM"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31217577;
	Fri, 26 Jul 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006934; cv=none; b=pnneFb3+iwgr/6Snt58hVp2xnrHvdnFsb0U3wZfGP3ItsmmVIpSAFRg4sBCHc7LPfTBkK6Ky4va4K8SMiRr0QjPSNbJ/Yvt44PSrUpXtivfnapxqr+ID1giexeykLDgmOSUopfGCjilxIZE0hYrphER7iLTw6QT4XgaVsb+yAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006934; c=relaxed/simple;
	bh=OsJJCaPxrl7RDPderqUC/MqhFU212Lp96yDsuIjk7RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq5vhDVwzvRwWSJWADaYfyUjLrE6+v6LOmVguNmc8/EVfn0z4MEE9/dl8h/+ZGb8UYxFwx/VnzYEP9o4fASiFelpPTbNtfa9MOQup0ah2mEZWd2ib5JSU7GweSsY0Auk+0S3vwIDNdz/abFXMdgFjVXGltenpJi3YgvDP75Inq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDPKRqXM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f19f19059so50927985a.0;
        Fri, 26 Jul 2024 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722006932; x=1722611732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAAkqhXSNI4atUtqGzcRGBk007BlpzKq2aYaR6VMJOw=;
        b=HDPKRqXMj+FalAsccFJ3dKOVztyD6EcFNbHeqOvY6N0O6j9D4hOnDBvzxQuyZbZF7U
         p4tAyMeIbCdqOxMhTawrFR2teNnPWxekA+vRU8rNwjj7Z2eXVJQb8RGfhtwupmxddRSw
         K92SN1lqoSB87rpmQNdrDeV3BkHj0M6tXTJome2eCeoULe9BsVrZDA+wdY5WVA/JZ5/J
         j9pIXPwfRcAn25blEH36aJHeOuGWXHQ/zy6jsgtyrU2hjyFmxt9nTLk61dZsdkQf15+M
         hPpiGlTmqOOlQsK3YeKDW6oo5FpHeat8C7dT1VkmqrqzGalPeTOFzPCgDHcR6ofYO9xg
         4roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722006932; x=1722611732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAAkqhXSNI4atUtqGzcRGBk007BlpzKq2aYaR6VMJOw=;
        b=q1lAiFrcwbYFly37x84Mx5GqXTzFJw8tLDkx5xfkLi2HtYPWw/wZixdWvptYL9D+H1
         wwIjLlVABP48/7NHMEKSrqIGFsNVEpehkml9v4U7Qn6sjUKlNWxWU/b4Rei4fhN6DTIV
         WPXXeu+Nll+ZqMlpXMr2T6+EoyVhdTl1oZCyvQSeBwurS27xVOj87SOhS3V20QcVlVtI
         ihfDqLOrUXJDyhAwqatXVt4/KmV5OPAHTW0JVWgyUQDJcbS6T3rHyeodj0REJw7MN4Q/
         qvU2GCU2urelcMnpqAGPyBuvCcpPHrRDnxZHIOJLVm3rXPIi1WM9MqNTOrlXXPspwMx1
         d8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjdYbH3BO4DQ2rAyhTLDB16OKrUtNox5ngmrz/YUUyKuM0g9WuZ56ENvTbCwl8wEamYVjoDNKIqzyT6MiTFMdcWWt8DT9AUpptsgpwjvkSLESnbklxRJDO9IlHpzna8xcPheN1rdDmo2nn0ENfG370G7wHHIWeC78tAs2knwkWKtJ4dvaepNA=
X-Gm-Message-State: AOJu0YxMKolkM2kKru7jFIN3/55NbkYocsc3aBJcFsm5c4E7iRwOBqNi
	qSI8cfCZ5aHFU3VmUWsSQ/zn28nQ1SN6XeRDFOXqaulM30vl97u+NbBFjA==
X-Google-Smtp-Source: AGHT+IE980FiekM2UyfX6/SfodixEsD7/hGI43yrK9RBU92VtmfMY1jKBW1iRDH+IyE1R+z6/qIo4g==
X-Received: by 2002:ad4:5cc2:0:b0:6b7:a8ef:e366 with SMTP id 6a1803df08f44-6bb5599f08cmr1480726d6.9.1722006931838;
        Fri, 26 Jul 2024 08:15:31 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d825esm17243136d6.29.2024.07.26.08.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:15:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 10A6512000B1;
	Fri, 26 Jul 2024 11:15:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 26 Jul 2024 11:15:30 -0400
X-ME-Sender: <xms:kb2jZiSmrs7gzQ0Sno2Ckw4N-9uJKyaLoYyQtlwmU3FXvg5H6nK8rw>
    <xme:kb2jZnwxx5JXQZpVprmrJfrTlx7JwiegtUrUhN1Co5cczzb-2-KSKmtPwcK7n4wCh
    QuMexHGxVmACtnfag>
X-ME-Received: <xmr:kb2jZv3R9ZJkxF7E-TC3O-3skLUoVtstlLqS3li35SxMXfLhgkALquSWKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:kb2jZuAic61nGD_pQn8laWq8ecHTEb8SSAwBNYPFaBVn2ACMVAPJ3g>
    <xmx:kr2jZrjdHu5zq7Zyflw8LBGxDYWJH2svGhUq14Qgsh6l3Z0mjYoT_A>
    <xmx:kr2jZqpT3pQFIEQDfaiffVUBpJlbeNp6vKDHf0sB3moYt839NX3tvA>
    <xmx:kr2jZujsKSG3s7eUlTvCkzEKLQc6zaA5E7G63dZazCrC62S6OIcLvw>
    <xmx:kr2jZqQbQ2j7nPZSr_YyHitROko23okxhnrUMiLMlQ2PvRzK5IgSmyAU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 11:15:29 -0400 (EDT)
Date: Fri, 26 Jul 2024 08:15:27 -0700
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
Message-ID: <ZqO9j1dCiHm3r-pz@Boquns-Mac-mini.home>
References: <20240710032447.2161189-1-boqun.feng@gmail.com>
 <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com>
 <ZqE9dzfNrE3Xg3tV@boqun-archlinux>
 <bcdd74f3-d0c0-4366-976a-5a935081a704@proton.me>
 <ZqK1l05zcCwGforV@boqun-archlinux>
 <beaf1fa3-eebe-443c-bc51-abd9348a411d@proton.me>
 <ZqOyMbi7xl67UfjY@Boquns-Mac-mini.home>
 <81ceeca9-8ae5-4a82-9a46-f47767e60f75@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ceeca9-8ae5-4a82-9a46-f47767e60f75@proton.me>

On Fri, Jul 26, 2024 at 02:42:36PM +0000, Benno Lossin wrote:
> On 26.07.24 16:26, Boqun Feng wrote:
> > On Fri, Jul 26, 2024 at 01:43:38PM +0000, Benno Lossin wrote:
> > [...]
> >>>>
> >>>> You can always get a `&T` from `ARef<T>`, since it implements `Deref`.
> >>>>
> >>>
> >>> Yeah, but this is unrelated. I was talking about that API providers can
> >>> decide whether they want to only provide a `raw_ptr` -> `ARef<Self>` if
> >>> they don't need to provide a `raw_ptr` -> `&Self`.
> >>>
> >>>>> Overall, I feel like we don't necessarily make a preference between
> >>>>> `->&Self` and `->ARef<Self>` functions here, since it's up to the users'
> >>>>> design?
> >>>>
> >>>> I would argue that there should be a clear preference for functions
> >>>> returning `&Self` when possible (ie there is a parameter that the
> >>>
> >>> If "possible" also means there's going to be `raw_ptr` -> `&Self`
> >>> function (as the same publicity level) anyway, then agreed. In other
> >>> words, if the users only need the `raw_ptr` -> `ARef<Self>`
> >>> functionality, we don't want to force people to provide a `raw_ptr` ->
> >>> `&Self` just because, right?
> >>
> >> I see... I am having a hard time coming up with an example where users
> >> would exclusively want `ARef<Self>` though... What do you have in mind?
> >> Normally types wrapped by `ARef` have `&self` methods.
> >>
> > 
> > Having `&self` methods doesn't mean the necessarity of a `raw_ptr` ->
> > `&Self` function, for example, a `Foo` is wrapped as follow:
> > 
> > 	struct Foo(Opaque<foo>);
> > 	impl Foo {
> > 	    pub fn bar(&self) -> Bar { ... }
> > 	    pub unsafe fn get_foo(ptr: *mut foo) -> ARef<Foo> { ... }
> > 	}
> > 
> > in this case, the abstration provider may not want user to get a
> > `raw_ptr` -> `&Self` function, so no need to have it.
> 
> I don't understand this, why would the abstraction provider do that? The

Because no user really needs to convert a `raw_ptr` to a `&Self` whose
lifetime is limited to a scope?

Why do we provide a function if no one needs and the solely purpose is
to just avoid providing another function?

> user can already get a `&Foo` reference, so what's the harm having a
> function supplying that directly?

Getting a `&Foo` from a `ARef<Foo>` is totally different than getting a
`&Foo` from a pointer, right? And it's OK for an abstraction provider to
want to avoid that.

Another example that you may not want to provide a `-> &Self` function
is:
 	struct Foo(Opaque<foo>);
 	impl Foo {
 	    pub fn bar(&self) -> Bar { ... }
 	    pub fn find_foo(idx: u32) -> ARef<Foo> { ... }
 	}

in other words, you have a query function (idx -> *mut foo), and I think
in this case, you would avoid `find_foo(idx: u32) -> &Foo`, right?

Honestly, this discussion has been going to a rabit hole. I will mention
and already mentioned the conversion `&Self` -> `ARef<Self>`. Leaving
the preference part blank is fine to me, since if it's a good practice,
then everybody will follow, otherwise, we are missing something here.
Just trying to not make a descision for the users...

Regards,
Boqun

> I get the argument that you need to always convert to `ARef` if users
> only use that, but when `Foo` provides `&self` methods, you're not
> required to have an `ARef`.
> 
> ---
> Cheers,
> Benno
> 

