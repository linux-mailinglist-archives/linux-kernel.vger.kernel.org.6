Return-Path: <linux-kernel+bounces-538856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75392A49DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4616816A6BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA59271824;
	Fri, 28 Feb 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoG3ZUxB"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FE270ED9;
	Fri, 28 Feb 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757591; cv=none; b=ZbEop1daAUO8i3hK0r6fKlcjx8Nfey7BKPJ4hyCGD+CAvumaiXDY2+IeHe4QeLBaFfVySrc74Qo2w2LgMdLUYxvCqA/6AzINr9zMPB9QvlNqrkjRjqkWFinUmL1V7x+cCXrfKuwY8AkRPJZid8dYT9ByaBDcI93+CT2rz9cJSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757591; c=relaxed/simple;
	bh=93toOTzdlszPdXfBpILzqJNYhUGcnCo6bDJ01p3btH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ite2TIWwz09b9hhYfR+1O5/YQdGvkQkP5l7vPzWVHPRxXgV1YA8QJ6BUaTT43Eng2CZxL9xxOmmJZPYpJ1vrwNqrs1tFQs4w3pbs9hM9M0MNuOhBkTQfSsSZdYWtG/PpvLNsCifuntEcXzxUEtAmHbRivq+xtpEmHeBcaXu4KX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoG3ZUxB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd049b5428so20205046d6.2;
        Fri, 28 Feb 2025 07:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757586; x=1741362386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JevkdLl+IvqRF4ouBtFMwmKyKELM3VPA3+3KL+J5nD4=;
        b=YoG3ZUxBI3TIoMn0TXqQdalJEk5GQjBJol2AIDcWAmRxzT7i/d2GH9YgH9XE4SSjSJ
         ZRAjlKiqmus6gIaMQOVflneCuNqpQ88W1uYEdmcNyzD2RcH9FmhEJfAgLWZUKxSmky3y
         HhlW0bgfv2o9E7Vnx0AbLY6LL7XxV6K48b2nR81Z/Z+rLgeJPNizXZPO6b7WiJEJyrjk
         kCV2v84S9Y0iGP5weByzMHL8y0pjwgVHVmjBeH77B7k5WfGWCdJqDm3r90IMhMHfVblz
         s0BiPPU6DJe4f4GJ9+lrsfUXJ4xuTNUpff3cXPOiTEkxy4g+yv+ZJzMX4zjgFGEzl9Z+
         3pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757586; x=1741362386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JevkdLl+IvqRF4ouBtFMwmKyKELM3VPA3+3KL+J5nD4=;
        b=wNmJKxQF+1LW+zAD5njE+5yKdd5iNGwKpXQu9APNGudL/DxGeY6LdtLOhLzUYb4dJm
         ThfEO3dyQa6uSzT/q+FUDyR40LzGj2zdxUSDx4yFVH6iSq9xbSswI6sIK3miJ3UaUQ77
         +KVixCUsBbjPHXQ0Otstyl/kY407sWpKs78TeqZbmfiiznALkaXoPCG/oBSd/ZmTrSxE
         ldOUxxK4Aae52mKu3BnCBm+3CkBTrC+S0O9aNFcpOJQ2XS+r30Yd6J1BDPz7i/+Aiswy
         BuZjQ0/BKRxMA/kZ+ap3h1i14DrRSe5NPV1j/IPNm4s2UjQUvBT63lQRJ4yGzqX5uPVG
         +PfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtXlIEqGfZM40CPwjbB4y0BpZpyXjfArdSYJlnZf/q40pofKuY8TozrAHdx3qS+S6Lk2QAIYjAthuh5dQ=@vger.kernel.org, AJvYcCWeJ6Hz9qdHxpP/840MprwRZq4VYp/RaRhkKM7f4gTYXqI5tgiYSC5gnil3oTMsy34K7gM7MvvrBQSGSBY2viA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBl6AQnrskVHl/xxRhuTswG0DgGAcgDNAQsbUYkiTOi7AMA06
	4pYfycy8/kat3U9nH+90dAQaEBHY3jJ5NJjP/QVChXvHMSr8JmWw
X-Gm-Gg: ASbGncvEXYQ6IYsb+kPJuN/QhR3DNQKNWEK3bnTDYW1HaP0zDLxkddMITkOBe4+vx+U
	1uG+0POIcpj+qgi0bmWe+kiKJMTTJbiWII9QPS0lqibKpZuKOiIbw/bgvtiArrCbmSr64+lzh4O
	PDk7KQZGrRWA7e/5ss5ivYueBUsg3rvEptw2gPfyDcehm/QZqyTBu/CcgEelzaCD/Kse/cBIE//
	IHwr3b0tuAdDY85V2/aHEKHi3rCywBm2GCK5In7Gxi75XmalOQHd1cHNRT4KFpmOxLpkparSDAV
	dg+bodD4bLn6XEx+GI7aIyAXuX2buKYjgNznqvezqDuPQ9Q3Pt68zVs41jmrYbrouJPrrT1rqXR
	IZrsmBT0m0RSldFXA
X-Google-Smtp-Source: AGHT+IGE6hF/EVT6SerT8YHInl7Zr7QacSOaIb/JKNpVEuaabbXatPIIhtmcsYOLxuyVqJ3hVwa+Pw==
X-Received: by 2002:a05:6214:2462:b0:6e6:6964:ca77 with SMTP id 6a1803df08f44-6e8a0d84b69mr65479686d6.28.1740757586393;
        Fri, 28 Feb 2025 07:46:26 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ccbacsm23432136d6.93.2025.02.28.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:46:25 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 51EAD1200043;
	Fri, 28 Feb 2025 10:46:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 10:46:25 -0500
X-ME-Sender: <xms:UdrBZw_ZDARev7pGErMo_0DXuYkEmR5gTozJqGPgCJIc1alkt2fhxg>
    <xme:UdrBZ4sBRqg-anLIYIR7Wm0cbKR_LR_R6K9TBJInUpoahorByA0NS4Na2isbuHKwa
    AUzII21EWj0c4A_gg>
X-ME-Received: <xmr:UdrBZ2DitXiyBf-lloMcO21klyujy1HrEj1APIRl3G9z1tggkg6mvnO-oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdejkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:UdrBZwcPNwSOPquwqf_86xR36wkA6giTK_l0fWwUuDJEaSJIRHp-xg>
    <xmx:UdrBZ1N0qWvFunHJE6BxERI2047gzAp8OtYLDB7KZ0_kYtGkpm4Kjw>
    <xmx:UdrBZ6m1E821DTNhjwC1oUwHPgDbGoiacMRAq2i6wDSqn8mS19pkJA>
    <xmx:UdrBZ3vAA3_wuY48KJuubyt8qDjc2kIPABZswGnWyrX2RpFyk4NIjA>
    <xmx:UdrBZztDnJdbCwm2kIJDAItmtwGfy0BN189C_dhP0nX5R4f_Z0JB24CX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 10:46:24 -0500 (EST)
Date: Fri, 28 Feb 2025 07:46:23 -0800
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
Message-ID: <Z8HaT4X4ikQzAghu@Mac.home>
References: <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home>
 <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <07acc636-75d9-4e4b-9e99-9a784d88e188@ralfj.de>
 <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbwwitktndx6vpkyhp5znkxmdfpforylvcmimyewel6mett2cw@i5yxaracpso2>

On Fri, Feb 28, 2025 at 10:41:12AM -0500, Kent Overstreet wrote:
> On Fri, Feb 28, 2025 at 08:44:58AM +0100, Ralf Jung wrote:
> > Hi,
> > 
> > > > I guess you can sum this up to:
> > > > 
> > > >    The compiler should never assume it's safe to read a global more than the
> > > >    code specifies, but if the code reads a global more than once, it's fine
> > > >    to cache the multiple reads.
> > > > 
> > > > Same for writes, but I find WRITE_ONCE() used less often than READ_ONCE().
> > > > And when I do use it, it is more to prevent write tearing as you mentioned.
> > > 
> > > Except that (IIRC) it is actually valid for the compiler to write something
> > > entirely unrelated to a memory location before writing the expected value.
> > > (eg use it instead of stack for a register spill+reload.)
> > > Not gcc doesn't do that - but the standard lets it do it.
> > 
> > Whether the compiler is permitted to do that depends heavily on what exactly
> > the code looks like, so it's hard to discuss this in the abstract.
> > If inside some function, *all* writes to a given location are atomic (I
> > think that's what you call WRITE_ONCE?), then the compiler is *not* allowed
> > to invent any new writes to that memory. The compiler has to assume that
> > there might be concurrent reads from other threads, whose behavior could
> > change from the extra compiler-introduced writes. The spec (in C, C++, and
> > Rust) already works like that.
> > 
> > OTOH, the moment you do a single non-atomic write (i.e., a regular "*ptr =
> > val;" or memcpy or so), that is a signal to the compiler that there cannot
> > be any concurrent accesses happening at the moment, and therefore it can
> > (and likely will) introduce extra writes to that memory.
> 
> Is that how it really works?
> 
> I'd expect the atomic writes to have what we call "compiler barriers"
> before and after; IOW, the compiler can do whatever it wants with non

If the atomic writes are relaxed, they shouldn't have "compiler
barriers" before or after, e.g. our kernel atomics don't have such
compiler barriers. And WRITE_ONCE() is basically relaxed atomic writes.

Regards,
Boqun

> atomic writes, provided it doesn't cross those barriers.

