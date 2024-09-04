Return-Path: <linux-kernel+bounces-315549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5555E96C413
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B91E1F2482A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED50A1E00A0;
	Wed,  4 Sep 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKrhGWgk"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77141DFE1C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467114; cv=none; b=E934kHJ00R+I9TMnH4ljnnG3JrMvUUj5z8F+u2KxKA8vtwWilCoedZ6CyZM7T0Wq2htVpg3DHEISo/0z6Rnx1zxQhPivUISymjwviwX6kn17koLMm9eoTPp/cF/4p9nSZLLyUZrfCRhRZyKlTUxrq8qGfPZN5g4O/Nz+76l5qUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467114; c=relaxed/simple;
	bh=/9NUGw4ZrmIYkfkcP8FTGQDpE7pj0HvZPhJYhuZ8ZLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGhDBmWXYxFr7tqUU4Mh/87tBF8kffdfi0U2b7YqUvwsSwhdX3qnHJQaxuSZ8ar6XdvpzPT0UArIV3ChgjT7FppYCxn06AtKtokoJe8rApU0gO5FyUdB6DmdYEldNGXb3YRqq9XMJpyERr/GmjOsFkOHTLBpT3u2m/QO0vSSl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKrhGWgk; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 12:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725467108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POkmkN/JwEJ0aZ0J8P8Ljm8OXcYXD7e6BRva/o/vMPo=;
	b=qKrhGWgkIZu6+5ik7KWOzXV2F69wHv7gO/jlVAa3+Cs46uX7R2i1PHFBV2ZW2/R4qT8fBL
	ydkWpXJEDKp3KYYmPSYyGPM7lunMwDRchs+vtWYbHlY+Iyng1kZ/QfM9vd/j5snphs+CN4
	+OTcYl0m8ZRJZSAJum+dlzPfUpUh4SU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	keescook@chromium.org, dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 5/6] alloc_tag: make page allocation tag reference
 size configurable
Message-ID: <yuu6tc2gxqp4ob2su4btd3f7gsnwmwtgrh2em7wwihajdfv2fj@vrrmk4sx77vp>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-6-surenb@google.com>
 <20240901220931.53d3ad335ae9ac3fe7ef3928@linux-foundation.org>
 <CAJuCfpHL04DyQn5WLz0GZ_zMYyg1b6UwKd_+8DSko843uSk7Ww@mail.gmail.com>
 <3kfgku2oxdcnqgtsevsc6digb2zyapbvchbcarrjipyxgytv2n@7tolozzacukf>
 <CAJuCfpGbHShimigbm7ckT76hK9YUc_gy0jb9e5ddq7yjqDKOig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGbHShimigbm7ckT76hK9YUc_gy0jb9e5ddq7yjqDKOig@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 03, 2024 at 07:04:51PM GMT, Suren Baghdasaryan wrote:
> On Tue, Sep 3, 2024 at 6:17 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, Sep 03, 2024 at 06:07:28PM GMT, Suren Baghdasaryan wrote:
> > > On Sun, Sep 1, 2024 at 10:09 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Sun,  1 Sep 2024 21:41:27 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > > Introduce CONFIG_PGALLOC_TAG_REF_BITS to control the size of the
> > > > > page allocation tag references. When the size is configured to be
> > > > > less than a direct pointer, the tags are searched using an index
> > > > > stored as the tag reference.
> > > > >
> > > > > ...
> > > > >
> > > > > +config PGALLOC_TAG_REF_BITS
> > > > > +     int "Number of bits for page allocation tag reference (10-64)"
> > > > > +     range 10 64
> > > > > +     default "64"
> > > > > +     depends on MEM_ALLOC_PROFILING
> > > > > +     help
> > > > > +       Number of bits used to encode a page allocation tag reference.
> > > > > +
> > > > > +       Smaller number results in less memory overhead but limits the number of
> > > > > +       allocations which can be tagged (including allocations from modules).
> > > > > +
> > > >
> > > > In other words, "we have no idea what's best for you, you're on your
> > > > own".
> > > >
> > > > I pity our poor users.
> > > >
> > > > Can we at least tell them what they should look at to determine whether
> > > > whatever random number they chose was helpful or harmful?
> > >
> > > At the end of my reply in
> > > https://lore.kernel.org/all/CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com/#t
> > > I suggested using all unused page flags. That would simplify things
> > > for the user at the expense of potentially using more memory than we
> > > need.
> >
> > Why would that use more memory, and how much?
> 
> Say our kernel uses 5000 page allocations and there are additional 100
> allocations from all the modules we are loading at runtime. They all
> can be addressed using 13 bits (8192 addressable tags), so the
> contiguous memory we will be preallocating to store these tags is 8192
> * sizeof(alloc_tag). sizeof(alloc_tag) is 40 bytes as of today but
> might increase in the future if we add more fields there for other
> uses (like gfp_flags for example). So, currently this would use 320KB.
> If we always use 16 bits we would be preallocating 2.5MB. So, that
> would be 2.2MB of wasted memory. Using more than 16 bits (65536
> addressable tags) will be impractical anytime soon (current number
> IIRC is a bit over 4000).

I see, it's not about the page bits, it's about the contiguous array of
alloc tags?

What if we just reserved address space, and only filled it in as needed?

