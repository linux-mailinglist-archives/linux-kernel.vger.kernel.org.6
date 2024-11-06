Return-Path: <linux-kernel+bounces-398974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1F9BF8BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4033B22405
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3EC1D88D7;
	Wed,  6 Nov 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ3zFXZw"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B9518FDA5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930005; cv=none; b=PYl2Z+jwGHlcjQ/w8aO+OTG99xX6F2+6sjyWpudiBsn8K3PZnj80gbeCxHwWp81mRcqlKAETh0LyM+ZLnA1aht3jcFD0fqGywnIofGeDEGHOsp+b3PZAT320nYfvBe+bJ73xJ5JDKku3mjEsqt2o1xj14roOjK0Pcla39uwBXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930005; c=relaxed/simple;
	bh=/5dLYBymStii8ysWHL/5x3cFlohClo3vfr0XxH6eZ3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1kkjbGUV34T0+uGAUvhW6uQwCOM9YQLgNMK0/MUjTlOzJ0+YiZRhPLNNEwHnhaE8dSmz2xj7SvHHvl4cOSfNmlFc755vdhXrStWgInZWu+LXUIGe+t/MCV0mkTxffQZ/tR3kwhuskUBRzx3zLs3f1mp3Qn1VA747f5WlLh1RdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ3zFXZw; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-851f5d3001fso95099241.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730930002; x=1731534802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF/zxMWhYdd3F+5qWwSaKGM6vouZPDy8y9g97i1mZbo=;
        b=gJ3zFXZwzJP9FSXTNEr1mwh79HiS8ACABXhW141d7Y6zo5DEidb7mTBFZCLrd/LG9D
         bGNlaX1+JvJYCCxjvLwH5cY3SG7z9ZFV1wVg6tc1r1p00bSPizPSnNExXKE5LSAMjKKl
         QD6XK1Uvzcp0kO3vqeFnn7WjmqaICbe6vHTTMjb8Hng55+4YnxJNz0Jcb0PfnCAoklKJ
         AkPynPWiYGQMO2+L196MPWSVfFogT74z39jR/1WQTkjyLiPhJFfAOAbyugmvAi+w9zv9
         q0jm/O9EGhfZQa7Tus9cKRklEnfd47RMcaP6NDSZLrFQ5stwxLlDLaqk7fLu42lW/GEt
         MZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730930002; x=1731534802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF/zxMWhYdd3F+5qWwSaKGM6vouZPDy8y9g97i1mZbo=;
        b=CzYcjCnF0lrbzx/w176Z9xzd6onLUFqwoU4wpe8Vb8XAVbg2Wg7zZM1mrZrDQnG+UX
         jajDMGdFDDuGL3bTw8MEI70kA/pDU2s3e32IX+SORZd9XP6T7uUyLZxugM1N+DkK+y+Y
         p7dEl1ErL1L+PqetM5wl+LrXN3ZCzjeKnRNgtwLCzCKYKGiu6IhAvsRaOAqUNTfscZnY
         UaVr9YR5S3HDdu8pDB4Tmy1amw8ONHUDBc4gETo4VPDFhWnwqp0VcQpT4IhacUca9dmm
         8Ekp9RPu+jLdYzIKEvj6zhtw1K3e/J1zR2suhVLpy9CoTA4KLWICo/ayRtu2QvftJxaa
         CuNg==
X-Forwarded-Encrypted: i=1; AJvYcCX5suqHBsDSdeKkO4G6Rum8Put485WSmdmBl/t+axM+ET0LVI+EZBFpGMiQEZzFWz039joON5rW75y2YAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/h8vTmxojY3AYZppYECo/g4zVU1r1/2cHrp4YlAN6r3sGTnG5
	FUKcx6Wpwv5g16FuVPTZdx6Sm3py1ic9EDOtINVCWwmpJQnGC8XYPv3Sk+PvsRU3PYA9mQ4fM0o
	vjcG9OXjn4YOYMGFPoTa+qGyQcTI=
X-Google-Smtp-Source: AGHT+IHzVx0GzHxGxE7gncrXRX7YZTwBsFmcbvBR/mGsOtf6FSBN5/kujypl1V+CAG8IQXObE0r1Bca490Jx6n6jjhg=
X-Received: by 2002:a05:6102:2ac7:b0:4a4:8ef0:25ae with SMTP id
 ada2fe7eead31-4a901045900mr28978994137.25.1730930002472; Wed, 06 Nov 2024
 13:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105211934.5083-1-21cnbao@gmail.com> <20241106150631.GA1172372@cmpxchg.org>
 <CAGsJ_4zYiRzG6mBnW-2wh7YCo_PJQc7u1syd05DNdic7MaE7Zw@mail.gmail.com>
 <20241106124225.632b42c3680cae0b940d2871@linux-foundation.org>
 <CAGsJ_4xoHbg+6CtGhC7dPePPC44OMH8azQsOWMEJnXpCQs=bDQ@mail.gmail.com> <20241106134446.aaadc57a2a88c9efe899c838@linux-foundation.org>
In-Reply-To: <20241106134446.aaadc57a2a88c9efe899c838@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Nov 2024 10:53:11 +1300
Message-ID: <CAGsJ_4zLv=HpPL3g085vUaMo8tZZnPZBGT_SfLVCV-10zn+D3Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm: count zeromap read and set for swapout and swapin
To: Andrew Morton <akpm@linux-foundation.org>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Nhat Pham <nphamcs@gmail.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Hailong Liu <hailong.liu@oppo.com>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:44=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 7 Nov 2024 10:00:47 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > On Thu, Nov 7, 2024 at 9:42=E2=80=AFAM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Thu, 7 Nov 2024 09:01:14 +1300 Barry Song <21cnbao@gmail.com> wrot=
e:
> > >
> > > > Oops, it seems that it depends on Kanchana's 'mm: change count_objc=
g_event() to
> > > > count_objcg_events() for batch event updates,' which also isn't pre=
sent in 6.12.
> > > >
> > > > Otherwise, it won't build, as reported here:
> > > > https://lore.kernel.org/linux-mm/CAGsJ_4whD31+Lk0m2uq-o=3DygvkRsw1u=
XcPeqxBONV-RUXkeEzg@mail.gmail.com/
> > >
> > > argh.
> > >
> >
> > Apologies for the inconvenience.
> >
> > > > Hi Andrew,
> > > > What=E2=80=99s the best approach here? Should we include Kanchana's=
 patch that extends
> > > > the nr argument for count_objcg_events() in 6.12-rc as well?
> > >
> > > Let's do the right thing here.  I'll drop this patch from mm-hotfixes=
.
> > > Please send a v4 against Linus mainline fairly soon then I'll redo
> > > Kanchana's series around that.
> >
> > Alright. The question is whether we should integrate Kanchana's 'mm:
> > change count_objcg_event() to count_objcg_events() for batch event
> > updates' into 'mm: count zeromap read and set for swapout and swapin,'
> > or keep it as a separate patch as patch 1/2?
> >
> > I guess integration would be better, as hotfixes may not be ideal for a=
 patch
> > series?
>
> I don't fully understand what you're asking here.
>
> I'm suggesting that you prepare a minimal patch that fixes the bug in
> Linus's kernel.  Then we figure out what to do with Kanchana's 6.13-rc1
> material after the bugfix is sorted out.

Kanchana's commit 'mm: change count_objcg_event() to count_objcg_events()'
changes count_objcg_event() to count_objcg_events() and supports
nr_pages more than 1. This is what we need for the minimal patch of
fixing zeromap
as zeromap could be nr_pages > 1 for large folios.

So my question is that, do I combine Kanchana's change into my patch
and send a single patch, or do I send a patch series with 2 patches:

1: Kanchana's mm: change count_objcg_event() to count_objcg_events()
2: mm: count zeromap read and set for swapout and swapin

If we combine them into a single patch, I'll need to incorporate the change=
s
from 1 into 2. I'm also unsure how to acknowledge Kanchana's contribution
=E2=80=94perhaps mark it as co-developed?

Cc'd Kanchana as well.

Thanks
barry

