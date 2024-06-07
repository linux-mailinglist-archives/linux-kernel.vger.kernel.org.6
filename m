Return-Path: <linux-kernel+bounces-205747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF68FFFBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4192AB264D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6232D15B969;
	Fri,  7 Jun 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD4Or4dx"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFB915B552
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753266; cv=none; b=k/UD0/l1j4XBMuRy3Fa03VSEA1MXSVctTwvKvJ1o1bkNcMC4rolR4WTn5NNpuEh0AGpZC3F5zwvQNk0T94ss1iR2VqfdbxabJPmqQrinG+ozBigQX8wQzfTBHLQ7jojM9ZWzYA5B3nwlr2ZqbEEKvakiGxqlWPVtTyVVJOT7NJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753266; c=relaxed/simple;
	bh=npvEOU5cyF70vE44vDzXkaPj0XAa/Rf93Ec8FtjtAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1BHtMepdFnrb3ONR3/psugABQRTyekNEtG+c3EAyGo4Mme/aP/An+kl1cvLmfI3oE60qIhcnynBoxyhObn5KfguEIwDdjlmZPeU/E2uOob2jZGlbbUoSz76cF3mBqxhoXLdyeNRG3e29WD7iPznVTfywYEA/HCgsPAOsGKluwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aD4Or4dx; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ae1b32752aso10112526d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717753264; x=1718358064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/oSqpRfe691rKkuHYiQBq4OSn10B5HpGWWM65PH/D8=;
        b=aD4Or4dxJEun99ib2N1e/imo03mKC9zISluKYMHoUjxHcNUxyq81pf+7z0OGIL2eFE
         dw+vDdkZzbVBIPFkRfx1NGPefPSYYIKETIsM2rXao6W3lkhsPhUI30QDHYqYAlwuVg76
         bgOgwCjQ88VNwPzvjUcN2AkViVZO25vvjoGidItGD+GwoK8iDr5qbIGRfBsNFSn6YzFE
         cNcfjUcuj9YbBYVLkE9zyeqzLQdnKB4+CTZ7naehcAvEeDq18HD8yKdBS2hTIKsQp8ZR
         X6Gc7IheqQfsvO1D9NpF3eYYyjukv7mP0kBU86ZQGiqlX89lZcvZl21Rjvhmv0ANBS1v
         igaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717753264; x=1718358064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/oSqpRfe691rKkuHYiQBq4OSn10B5HpGWWM65PH/D8=;
        b=sW27Fy5W8uC2YyB/k2D5qZckuQ+7bw02x/YZIBz4gIJk9s33sOnyOvXzI5y3J2eMQi
         /3X2tjnMrYkBrVGbEcqyQ8Vd4i6jiJIAXzUxJoNCfALyg9akY2CTKZ+sY7jY+b9rILI6
         n7ArSVV5+1IWHT2MSIZVBFRY+sf++pK2QLNIKumfGWGy0/p8cUgx56UQ4RFT79g4YCQ0
         R6t71Tr9Ipo0V2unv72e3Tdm1tXzH3Afiy7j5ruQ6/+V7agyYbzSC57ovJfp0BxymLEN
         YcFmSQQfi6ctrCiYbFET9JQYQI5O0pm+waY+mhdIjtaEtRvOWEdXY/SOSXSIq5oIgg/o
         Ma5A==
X-Forwarded-Encrypted: i=1; AJvYcCVLVXtuPqs5LvdTC8ZmmO+7j1d2x2CC3RyUUqd6XtlyIPO9ZlCvXgDjlL5TJIjZG7ZOoElzxtfRxUFAS3TGBVcp+Jd6TJ5CvxWB/+vF
X-Gm-Message-State: AOJu0YweBbkK0BeeIHrGDLQJw0LKsSvPTTSy4sSC1ptPtvDCOpZEXziS
	dCQ7EjpVH704Zi5RHOIkeKE0f8mSLsgz7YkgQCGa4+OsROhDZzR1qTmzNJwMEecN+YJ9O9wwt3O
	7wM4dv69pJHCvIe/xa+QJi3zG78M=
X-Google-Smtp-Source: AGHT+IHn0b6EwReH7VI6F17pOZO2Pe20rM3RuA+jzTt8WWs3Xl1Tg5kPGQ/pBjjGZKYKADka1oStpZieFokTq4hFc6k=
X-Received: by 2002:a05:6214:534a:b0:6b0:5933:3a8a with SMTP id
 6a1803df08f44-6b059b851a8mr20938446d6.15.1717753263959; Fri, 07 Jun 2024
 02:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea> <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <e68bcc6a-25b1-42aa-83b3-5d457b254cbe@linux.dev> <20240606043156.GC11718@google.com>
 <6335c05d-9493-4b03-85a7-f2dd91db9451@linux.dev> <20240606054334.GD11718@google.com>
In-Reply-To: <20240606054334.GD11718@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 7 Jun 2024 10:40:52 +0100
Message-ID: <CAKEwX=OAEzKW9zO9pn41V71A8Ua2dJjD3DY6RsDMNdSd-4ts5w@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Erhard Furtner <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 6:43=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/06/06 12:46), Chengming Zhou wrote:
> > >> Agree, I think we should try to improve locking scalability of zsmal=
loc.
> > >> I have some thoughts to share, no code or test data yet:
> > >>
> > >> 1. First, we can change the pool global lock to per-class lock, whic=
h
> > >>    is more fine-grained.
> > >
> > > Commit c0547d0b6a4b6 "zsmalloc: consolidate zs_pool's migrate_lock
> > > and size_class's locks" [1] claimed no significant difference
> > > between class->lock and pool->lock.
> >
> > Ok, I haven't looked into the history much, that seems preparation of t=
rying
> > to introduce reclaim in the zsmalloc? Not sure. But now with the reclai=
m code
> > in zsmalloc has gone, should we change back to the per-class lock? Whic=
h is
>
> Well, the point that commit made was that Nhat (and Johannes?) were
> unable to detect any impact of pool->lock on a variety of cases.  So
> we went on with code simplification.

Yeah, we benchmarked it before zsmalloc writeback was introduced (the
patch to remove class lock was a prep patch of the series). We weren't
able to detect any regression at the time with just using a global
pool lock.

>
> > obviously more fine-grained than the pool lock. Actually, I have just d=
one it,
> > will test to get some data later.
>
> Thanks, we'll need data on this.  I'm happy to take the patch, but
> jumping back and forth between class->lock and pool->lock merely
> "for obvious reasons" is not what I'm extremely excited about.

FWIW, I do think it'd be nice if we can make the locking more granular
- the pool lock now is essentially a global lock, and we're just
getting around that by replicating the (z)pools themselves.

Personally, I'm not super convinced about class locks. We're
essentially relying on the post-compression size of the data to
load-balance the queries - I can imagine a scenario where a workload
has a concentrated distribution of post-compression data (i.e its
pages are compressed to similar-ish sizes), and we're once again
contending for a (few) lock(s) again.

That said, I'll let the data tell the story :) We don't need a perfect
solution, just a good enough solution for now.

