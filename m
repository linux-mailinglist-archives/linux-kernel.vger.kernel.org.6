Return-Path: <linux-kernel+bounces-524212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F1A3E0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B02189E2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6220CCF2;
	Thu, 20 Feb 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IBK9tEAg"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61012045AB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068649; cv=none; b=EvHKat+9MVvIcdAVfydecC8XpVpzHy3m104SxpKZ04CIwa6N7wjIpxF92wjENXKM13MZgWf34xgJ+dcuRX4xWikcIgVwgdxmf9YGrdbn7+KO2mIToh19U3k+Z+tw+iw3MspfUJZ4ZHo1HciL5RXRM5o34u2VRAv2dgBY2dFJRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068649; c=relaxed/simple;
	bh=A98u9Pi7cA4PP0YNnK0cMws0e33F70bGk0qUEsxsUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnIb0azLSTCi/8uV3tfoUHfFPx5v7t2k78hWtmlbf4zWf0olaJIq4Ary3gxznK6HiNL6kCc7R5/AyZP/ogHbB6Hsp+9ENFNyelOwJ9kE99lEzAkBJXm8BP6AEGsUmE1/qH95/rL9yeD/OkmSNg1gQUEjOOwsfVeaiHlNtWNL+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=IBK9tEAg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so7440275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740068646; x=1740673446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHNQaW7mzEdCd/TPuQOkmBComqEtaa6hiKEAKod6XVI=;
        b=IBK9tEAgkZtHD61zrjMCR4jAz6GZqjDPbL7lIfZRgkqqukUmtH19IFXkrzxxovmb8t
         46xCZo0L7fOBGtEK3HKaGoneo2Vvguu27tj8nmelGzSImCwcpKuzsQjlT4OKp7lAbR39
         gompR/0AOvtRPQWdHLrb5MacZYY0gPmwOeLXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068646; x=1740673446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHNQaW7mzEdCd/TPuQOkmBComqEtaa6hiKEAKod6XVI=;
        b=HzVOiNFdbeoeBHtCLcdyWrSh+eti5kvfFJee+sqa7r2anjmKeZ2qkb9AZhUEK7yZtJ
         FsAevOC2FdjrFztl7W0InDRiJTJNhuwa5N4UTYDpYUEdxgs3C5l2PYWqVV5ox3rwNRuH
         XTB5xnS6+73nqbQA76vI9z3zmAFFcqp7NhTQ199ud1z3ZgrVwbsXbrKGbW55vwxEggBD
         s7YuCgRXqNFaaSLuCP0F8G0c7TTkTJfu309ehqvyTeijRPmz5bD6w91cjTycBCsoGKLZ
         F5LtpikEzPF3mjEGo9CIgbO9uzLCF2kHrp99Di+IjqIH+SP1yioKO9ic0cV9sjp7tl+d
         VVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbxGrsJwyJDu5VUaHAciWvoYB+awo3io5eWyEuU2cAyQeO+k0F1a1AGDVJuwLsZnJYo5MYvsfU973hc+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxauOsKIGM39n6EBFRFIX6ZVHs8AvNFj4t65ONuEy4AlQrHTn3X
	SY13XDZ+ZMEvrDTjaO2Dlhqz/ksw2+WrW9JTQT9+eqf2PZAh8ZOSp3pX72WibCk=
X-Gm-Gg: ASbGncttK82g1x0uQaRgUxBNA7vXgvHZ2QWcqn2I32J3rBXIYbuYfS7BFTdEFifdxfD
	mNjHmDJmYMa/9r+3foX67uRTVavT/6UTKCn+Z2Wt2k/Nu0e1vAcLPA5uLBR8+boFfhdqKJFUMNL
	soDv8q1q9Gap69fVSzL75ogT7ZUe2jz870Uv9pdWSajFtQcYwL6I/wVBXhC39jK/K8iR9/HChU3
	arfKHjA3cf9+FB/q0X/4K6ETa4JTIUAKs3lgbqgSk5KBxpsO/wnnV5STEJcOtJR0YkVqmgVBUnj
	p/WOPOwHbZp90e6n9/4sxS6sIIo=
X-Google-Smtp-Source: AGHT+IGO2UBg3ppa7TE2D8LMax0SXOyah2tNEU1Go0U95uL3vj126aJdb3xWmggfe65ARa8Fbl4nTQ==
X-Received: by 2002:a05:600c:4fc2:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43991ddd158mr132576415e9.10.1740068645761;
        Thu, 20 Feb 2025 08:24:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7c7sm249594765e9.27.2025.02.20.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:24:05 -0800 (PST)
Date: Thu, 20 Feb 2025 17:24:01 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: David Airlie <airlied@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>, "Dr. Greg" <greg@enjellic.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hector Martin <marcan@marcan.st>, Dave Airlie <airlied@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
Message-ID: <Z7dXIfFJ2qXNKtwT@phenom.ffwll.local>
Mail-Followup-To: David Airlie <airlied@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, "Dr. Greg" <greg@enjellic.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hector Martin <marcan@marcan.st>, Dave Airlie <airlied@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
References: <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
 <20250207121638.GA7356@wind.enjellic.com>
 <20250208204416.GL1130956@mit.edu>
 <CAMwc25pxz2+B329BArDQMpxOvpMtvhop1u_Uwc0axn2LqNP0vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMwc25pxz2+B329BArDQMpxOvpMtvhop1u_Uwc0axn2LqNP0vA@mail.gmail.com>
X-Operating-System: Linux phenom 6.12.11-amd64

On Thu, Feb 13, 2025 at 08:20:52PM +1000, David Airlie wrote:
> On Sun, Feb 9, 2025 at 6:48 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Fri, Feb 07, 2025 at 06:16:38AM -0600, Dr. Greg wrote:
> > >
> > > The all powerful sub-system maintainer model works well if the big
> > > technology companies can employ omniscient individuals in these roles,
> > > but those types are a bit hard to come by.
> >
> > I'll let you in a secret.  The maintainers are not "all-powerfui".  We
> > are the "thin blue line" that is trying to keep the code to be
> > maintainable and high quality.  Like most leaders of volunteer
> > organization, whether it is the Internet Engineerint Task Force (the
> > standards body for the Internet), we actually have very little power.
> > We can not *command* people to work on retiring technical debt, or to
> > improve testing infrastructure, or work on some particular feature
> > that we'd very like for our users.
> 
> Just as a courtesy to others can we not use the "thin blue line"
> analogy in this community, it has had some bad connotation thrown on
> it in the US context over the past few years, and I'd rather not as a
> maintainer be aligned with current connotation/interpretations of it,
> despite having family involved in our local force.

Agreed. I dropped a bit the ball on this, because at first I thought this
was only posted on part of the thread that wasn't cc'ed to dri-devel - I
can't pick a fight with the kernel community at large for everything that
happens. And then I let Dave handle this, because I couldn't come up with
anything that's not a nuclear table flip. 2 weeks later I'm still not
better, so let me instead express positively what kind of maintainership I
strive for by linking to an old talk of mine:

https://blog.ffwll.ch/2017/01/maintainers-dont-scale.html

> I'm open to suggestions for any better analogies.

Better analogy aside, I fundamentally disagree with understanding
maintainership as a gatekeeper role that exists to keep the chaos out. My
goal is to help build a community where people enjoy collaborating, and
then gtfo so I don't hinder them. I think the talk I linked above is
holding up quite well even years later, but the last part really embodies
that idea, so let me just quote that:

    Be a Steward, Not a Lord

    I think one of key advantages of open source is that people stick
    around for a very long time. Even when they switch jobs or move
    around. Maybe the usual “for life” qualifier isn’t really a great
    choice, since it sounds more like a mandatory sentence than something
    done by choice. What I object to is the “dictator” part, since if your
    goal is to grow a great community and maybe reach world domination,
    then you as the maintainer need to serve that community. And not that
    the community serves you.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

