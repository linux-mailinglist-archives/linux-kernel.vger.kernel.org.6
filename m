Return-Path: <linux-kernel+bounces-271844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE09453DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CE61F2219E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1514AD2C;
	Thu,  1 Aug 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsMr1FH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43821494C3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722545763; cv=none; b=R8m9qUG1xCC8o0lvrJfIO6s9PaLUvAlPGgNZm4CMzWHc0uXI7IYAcWegicAymknSEkLWEqx2VMTv0uH6P31Z04VJGRESCG/9Co9ziSKeC7SUnspeM2FokPiiOqgtG3WJdy6hUulI9QXBl79ZpGOnVuJUGW9JmPS2RYhoPbUpfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722545763; c=relaxed/simple;
	bh=sIrnSJw83glUqUNpuUrGKfKjyFNGaOkzu4eYNDdxWRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVY1mbQ8CVGjBdxoPPqEfxI1KlB616N7c0cfMgCYjoKIqsdVPoRKO+FG1rT9Q4fdXXIpN6MJUoBHEovTmPvDhL1Zgk4u8i4kRTzB6ZwsfaaVsnOZyc7P21A6z8JbmZkz0kb2xj+Qd+gNL9OSMx9Fg+r45Hol405VgOouvDK4Ymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsMr1FH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50562C4AF0F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722545763;
	bh=sIrnSJw83glUqUNpuUrGKfKjyFNGaOkzu4eYNDdxWRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QsMr1FH4fqEHyezoy+ARz1/C9C8f7DI209A0Exz9m/HBPUglDeGslAPKssoacI27d
	 yK5ZbKFnBAd4P5sygcxkWFwHcYT0gq31AGCVynJIJiRCgMhafJiZhvGKwh/Q+hWp4E
	 4/w1kszZRbM7QFkS93lRe9HVofnMkTq/WadmnvXxpjYyQqhlRvpxaCUG9Z/9BvaIS5
	 8on965JouoMwUEZYobwcDrmqazGlFIT7qaWu5xlwXsdZLwfvA6yrxgGlJnPgTUUQBe
	 YIttW2bSCdz1RW9f4BE6FLKUUUuaWiaOuyRSLcM0Au+cM+PUUQxg3PElWsOQBgxZtS
	 TtjSIDmrcnSvQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6659e81bc68so66613887b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 13:56:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOGtcYswPWuRS3MNQCdJpa5RFifDbq9YlDw3vnJXNWRILjtS2HBvI5ieE8py+bxD6JlIxJbAzhqSurZpvSKcNSUN2uEzfFNzmgbIGM
X-Gm-Message-State: AOJu0YwvY428akox1lmhJfyiCQ9yP5tWqKOea4/TUDT4XcapVgeHKJWm
	3x3f0r07VkoyAoe9qDF6bm0kZmgtEOVVl7lX2uM6+pvYvjI5c6uNgIFOuvz8d9LBufgGFBEePoH
	flr0zICV5sVp7u7FfP1Dufs3W3Hl+RYUD5joCrQ==
X-Google-Smtp-Source: AGHT+IGBANcF1oiO704BXaP+cr5WZav5BHERyJAT1vW6BA4zxVjL2rmZvMYad1m5ZTWTk2eeh/D3bVG6rLQQJ04fV/A=
X-Received: by 2002:a81:c24e:0:b0:631:43e1:6b99 with SMTP id
 00721157ae682-689601ab907mr16336177b3.12.1722545762584; Thu, 01 Aug 2024
 13:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org> <Zqe_Nab-Df1CN7iW@infradead.org>
 <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com> <ZqkVMpbl5pH35uOq@infradead.org>
In-Reply-To: <ZqkVMpbl5pH35uOq@infradead.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 1 Aug 2024 13:55:51 -0700
X-Gmail-Original-Message-ID: <CACePvbV9DZJcYL17MyYrEjRehqfj1LQtj3TwrKuP913NAP4sZA@mail.gmail.com>
Message-ID: <CACePvbV9DZJcYL17MyYrEjRehqfj1LQtj3TwrKuP913NAP4sZA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Christoph Hellwig <hch@infradead.org>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, ying.huang@intel.com, baolin.wang@linux.alibaba.com, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 9:30=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Jul 30, 2024 at 08:11:16AM +1200, Barry Song wrote:
> > > We also really need to stop optimizing for this weird zram case and m=
ove
> > > people to zswap instead after fixing the various issues.  A special
> > > block device that isn't really a block device and needs various speci=
al
> > > hooks isn't the right abstraction for different zwap strategies.
> >
> > My understanding is zRAM is much more popularly used in embedded
> > systems than zswap. I seldomly(or never) hear who is using zswap
> > in Android. it seems pointless to force people to move to zswap, in
> > embedded systems we don't have a backend real block disk device
> > after zswap.
>
> Well, that is the point.  zram is a horrible hack that abuses a block
> device to implement a feature missing the VM layer.  Right now people
> have a reason for it because zswap requires a "real" backing device
> and that's fine for them and for now.  But instead of building VM
> infrastructure around these kinds of hacks we need to fix the VM
> infrastructure.  Chris Li has been talking about and working towards
> a proper swap abstraction and that needs to happen.

Yes, I have been working on the swap allocator for the mTHP usage
case. Haven't got to the zswap vs zram yet.
Currently there is a feature gap between zswap and zram, so zswap
doesn't do all the stuff zram does. For the zswap "real" backend
issue, Google has been using the ghost swapfile for many years. That
can be one way to get around that. The patch is much smaller than
overhauling the swap back end abstraction.

Currently Android uses zram and it needs to be the Android team's
decision to move from zram to something else. I don't see that
happening any time soon. There are practical limitations.
Personally I have been using zram as some way to provide a block like
device as my goto route for testing the swap stack. I still do an SSD
drive swap test, but at the same time I want to reduce the SSD swap
usage to avoid the wear on my SSD drive. I already destroyed two of my
old HDD drives during the swap testing. The swap random seek is very
unfriendly to HDD, not sure who is still using HDD for swap any more.

Anyway, removing zram is never a goal of the swap abstraction because
I am still using it. We can start with reducing the feature gap
between zswap and ZRAM. The end of the day, it is the Android team's
call using zram or not.

Chris

