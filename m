Return-Path: <linux-kernel+bounces-538891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B3A49E69
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA261757A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5E188CCA;
	Fri, 28 Feb 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeoVdfwg"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FB270041;
	Fri, 28 Feb 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759194; cv=none; b=GWzByK3rs9JByjT76kvIzqiJD25id5/2Kkpw1W7zObmfMyXHJukMQl1gvYnOjNtxIKLqFTgE8hAZNrWlMVms8PLFQurqrid8yuoMMCYg8kJKvKVdXS2BlmT3IF5I3H2211y6Yw0E7hMd/NAFAlQ/qF5ncXpPIimOYs6d6dM/Gek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759194; c=relaxed/simple;
	bh=aQbZFZw95EDnWnnm5Up2Iqn4SASjIZZz8iv12PkMVvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=livLmW2Tvrp81iSCOE/RSq9Rqh6blvp1NsmBgwIT5VMQg0grNPOnAd7HTEM9TxLwdzK6OlQQvJKJVDGCFCLi6FUOGoIMNZp5TuaskOhAxK7ssjmbeAxpO1AyzFC24QQlR1xR8WO3k6eQF15l6lDrO3pPEpyLDhXFWgXx5R5B0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeoVdfwg; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be49f6b331so238688685a.1;
        Fri, 28 Feb 2025 08:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740759192; x=1741363992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uDxNY+Uqq+02fq06XSBgP/6hyJZmqPGyV6kja8+czU=;
        b=LeoVdfwgdUGkXNlz94lv7mZKM37x263y0ObzQhHAActFOF+7cEVEdbnCaCsyYuVt3u
         X1ymPKcIBAl2M9OI8VS3xi8MXYQPOITC6XWjrhBt8ULkOrv7yiE8ESH8lv4eU0HXVvLJ
         GzuciB9075QZgAik5D6vLsx/O1WORIiG3RZk6A+dwtuDzvgmTUNwVzUb0T6F6P2Y2XpP
         zt5HG7IyOkKZTM7JcHKZ86c4+4QjfBTXWTMig74Ofkq7U15FC+1tTkDA/+ce/qsIHtGp
         0LbfH3XlL3kk7lRL/0vdi1/7DD2F86ns0gotKqQSp30tYP7+MojQo1ym1IjvsQvrvW3Q
         fq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759192; x=1741363992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uDxNY+Uqq+02fq06XSBgP/6hyJZmqPGyV6kja8+czU=;
        b=mTeGnWTuBlx0dY+GkhVeDXoBm9D7QW7dkFXeBtBH7/Xkv8HBJfOTXpQEl8bO1hk151
         MazEoTWJ4gulqx8dHgITx2IOMFqHPWVZF2pasy7eL4NJj7tdZNc2k3HHRk7xxPi5Zhoj
         NuRXSFG5TAeShqH64h8GR0l9LRjdoTgtwDVFARjuTZM9s6XO1ziQJF0hnGmVTgMVCIBQ
         G4BNVVbM9O4+LGISt098uTX6tCy24qbWlCS4/0Kn5FK5KGCcWjUTbvl44OGK+oANMYnE
         8pOQc6c7JjBzX7g6CfRmPjAO2irArEyWVOPmR/L8CBJWuyOkXPVLqBLt9uU0VYN1OvTV
         aySQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkFfyjqqkU7SqjqdXyqnmCw/qz7K+qfLoesLE2G6cE17pFHiPMwMyIuSroGOHyhLSnjPXWeaTCYPc9kfA=@vger.kernel.org, AJvYcCX55jS1D9R4uy7q/lODRzz1G8jZAiUc4wHCwudKjMcQ+nccCs/GCLQgC0D00ZvLhDMNX4MYeQfgY7ROM7ED/lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnN8RHpPVGNiKRb0SpF0des9q2r+L11wVSMwplXuU3kZw+KUZ
	l4ip9ElVW69FjcKmLvwhmA7/79QlnJyrx7l3JK5GLdoq0bI8bOuc
X-Gm-Gg: ASbGnctX5bk8MGpXPn2hUf7E1KEI5gmT/tHC3UId4rJyGIsdyVieOT6mjaRz9vWZUYz
	1nrVoX8ho996EcSCEkIxuO+bVsf4Ygnx6fjIWvHRMEYHAO07FKskmGy23OaeqNHbRbJECdSPwBx
	zpsoRXPMoOATyUbaIq3mlf3MBSf6NDkuzC9lsg0edTpkKC2J55PaO6tmNwLHnTcUz3ZLQCa07Fk
	jtxE16K35ala+T0LTDgZ6lM3oGlmHJ0FTK/PhIwdbpcRFBV2+FAlY+yQHMBDq7Z5ojsJyt/80XJ
	X7xXkrrtAZu9SPs7PlNmMHu61PkLY1IWzCjdGMaTx9wxnGJPWN3y6bolCZ3wM6vc+5LN0Hc+gKJ
	/25ROjwWvZ4lPiNGY
X-Google-Smtp-Source: AGHT+IFYQ5tDufmCV6JPils1aA5CgyD3jh43Ss63OcBP2BW8XCYdQrgrvlXVQ8ZgCMPfast1dCho8A==
X-Received: by 2002:a05:620a:8281:b0:7c3:9d34:7c8e with SMTP id af79cd13be357-7c39d347e6fmr438960485a.55.1740759191773;
        Fri, 28 Feb 2025 08:13:11 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378dad24asm261910485a.107.2025.02.28.08.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:13:11 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B54BB1200068;
	Fri, 28 Feb 2025 11:13:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 11:13:10 -0500
X-ME-Sender: <xms:luDBZ7N2krPLAj6KEEuvSUyp_ELkJlv1IPwcZvsPYZBYyrOnrJCwgQ>
    <xme:luDBZ194-_q6pQuCRkkmiRVN-egzxb03Va6DBw8aVUeEaB5nw3M4sPhR_6gJEl1k9
    2z1Luhy8eiNDtMGUw>
X-ME-Received: <xmr:luDBZ6TyKxy9EkBaPJkGIgWzSPmNjwJSzKjepHPkiVg9mGcb1UE4Wkaq5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvnhhtrdhovhgvrhhsthhrvggvtheslh
    hinhhugidruggvvhdprhgtphhtthhopehpohhsthesrhgrlhhfjhdruggvpdhrtghpthht
    ohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehtohhrvhgr
    lhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuhgvtg
    hkvghrsehtuhhgrhgriidrrghtpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepvhgvnhhtuhhrrghjrggtkhekheesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:luDBZ_sTyaYAAUlFB5JJn6L-PGd3fHqWRwxp8gP6IML3E8L_-Qow2Q>
    <xmx:luDBZzfIOP1HgagwsH9sJGxuK_iG551P2RhSuNR5EBj72TDRB23DcQ>
    <xmx:luDBZ71FqZpvxTRa8v5EMsM6wuWU8wVt-3ootBya-gma4t_jF2AMMQ>
    <xmx:luDBZ_8QlJGtq-siq3g32d-sfhwmAEqZ-K6HyoDXXFE-QPJgKgYUfw>
    <xmx:luDBZ28jFdmS9EVSpQe0nMUF14hMl1zhvaVFMHQc_YXkqYoUNUwCkg3j>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 11:13:10 -0500 (EST)
Date: Fri, 28 Feb 2025 08:13:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Ralf Jung <post@ralfj.de>, David Laight <david.laight.linux@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Uecker <uecker@tugraz.at>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>,
	airlied@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <Z8HglTh3EKO63lmu@Mac.home>
References: <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
 <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>
 <Z8HaT4X4ikQzAghu@Mac.home>
 <vvtxa4jjk2wy7q6wnnxxgidopfd3pzxgntuehsu4skex24x5ml@yejfkrtg5dqc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vvtxa4jjk2wy7q6wnnxxgidopfd3pzxgntuehsu4skex24x5ml@yejfkrtg5dqc>

On Fri, Feb 28, 2025 at 11:04:28AM -0500, Kent Overstreet wrote:
> On Fri, Feb 28, 2025 at 07:46:23AM -0800, Boqun Feng wrote:
> > On Fri, Feb 28, 2025 at 10:41:12AM -0500, Kent Overstreet wrote:
> > > On Fri, Feb 28, 2025 at 08:44:58AM +0100, Ralf Jung wrote:
> > > > Hi,
> > > > 
> > > > > > I guess you can sum this up to:
> > > > > > 
> > > > > >    The compiler should never assume it's safe to read a global more than the
> > > > > >    code specifies, but if the code reads a global more than once, it's fine
> > > > > >    to cache the multiple reads.
> > > > > > 
> > > > > > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > > > > > And when I do use it, it is more to prevent write tearing as you mentioned.
> > > > > 
> > > > > Except that (IIRC) it is actually valid for the compiler to write something
> > > > > entirely unrelated to a memory location before writing the expected value.
> > > > > (eg use it instead of stack for a register spill+reload.)
> > > > > Not gcc doesn't do that - but the standard lets it do it.
> > > > 
> > > > Whether the compiler is permitted to do that depends heavily on what exactly
> > > > the code looks like, so it's hard to discuss this in the abstract.
> > > > If inside some function, *all* writes to a given location are atomic (I
> > > > think that's what you call WRITE_ONCE?), then the compiler is *not* allowed
> > > > to invent any new writes to that memory. The compiler has to assume that
> > > > there might be concurrent reads from other threads, whose behavior could
> > > > change from the extra compiler-introduced writes. The spec (in C, C++, and
> > > > Rust) already works like that.
> > > > 
> > > > OTOH, the moment you do a single non-atomic write (i.e., a regular "*ptr =
> > > > val;" or memcpy or so), that is a signal to the compiler that there cannot
> > > > be any concurrent accesses happening at the moment, and therefore it can
> > > > (and likely will) introduce extra writes to that memory.
> > > 
> > > Is that how it really works?
> > > 
> > > I'd expect the atomic writes to have what we call "compiler barriers"
> > > before and after; IOW, the compiler can do whatever it wants with non
> > 
> > If the atomic writes are relaxed, they shouldn't have "compiler
> > barriers" before or after, e.g. our kernel atomics don't have such
> > compiler barriers. And WRITE_ONCE() is basically relaxed atomic writes.
> 
> Then perhaps we need a better definition of ATOMIC_RELAXED?
> 
> I've always taken ATOMIC_RELAXED to mean "may be reordered with accesses
> to other memory locations". What you're describing seems likely to cause

You lost me on this one. if RELAXED means "reordering are allowed", then
why the compiler barriers implied from it?

> problems.
> 
> e.g. if you allocate a struct, memset() it to zero it out, then publish
> it, then do a WRITE_ONCE()...

How do you publish it? If you mean:

	// assume gp == NULL initially.

	*x = 0;
	smp_store_release(gp, x);

	WRITE_ONCE(*x, 1);

and the other thread does

	x = smp_load_acquire(gp);
	if (p) {
		r1 = READ_ONCE(*x);
	}

r1 can be either 0 or 1.

What's the problem?

Regards,
Boqun

