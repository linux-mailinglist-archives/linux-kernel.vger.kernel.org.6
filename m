Return-Path: <linux-kernel+bounces-313607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A60E96A78E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91291F253A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8719419146E;
	Tue,  3 Sep 2024 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7RHc2QL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566111D7E2B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392506; cv=none; b=G27xWas1LCJdVl/B6m0o2t9LSVrvwGEckBbxBuGbBHCCkZIP3SmZnyPllv6MMINBa5l8z+AP8EgtBupgllKZ/7Du5ucYnQA7Z5AFxYRdkOMpJDVe+8mWAqXcztewq2UXIrWVlIINCpRfZGut+R2X5534Te8MEZ02NM0cNqZPJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392506; c=relaxed/simple;
	bh=lCLcP/4pBzrbKB3K6R2PBfySPUEIU8EtOA2en+9rTUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1NhWw0L2qUq4ERaU3GYlFaVtWv2SVxQCuvjiZUoNYOgHNMoIYkEzjZ0G/rntNoFDre0+pHl4iAORf0+4yOqcq01el4UpRxgLN8zIXlVqcd6xZzd50cC9fv+W4SnRBqvUKCACaLpM2Kuig+vCb2QaKB2enC1U1WJI/XGT9qZEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7RHc2QL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8682bb5e79so1411966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725392504; x=1725997304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulJe0DxztcTweeavIBv/J7BVFYkM1MVqEhbfxPn4s+s=;
        b=F7RHc2QLzFFS/y4zEP9/+XMMF5tbBpzk8EP83635aYthkYYExktDXQARFGMMLyNyl0
         JccTrk4V+2EnvqedKpzB6L5XFCy1y3Yu5qNgugPgGq8KLgA901YENEtHPMmklgZd9Thh
         rUBiruhRcu4/GfDBrH0A+ZWEY9/ZhbZhNoDoY/RD/ZaduqN26fdN4WTrguHqDy2l7rfi
         lxnPOZU5MwYIFOJz+ISjc3pADkDMaF9HNSW8+loR+aIeAw9tzENtT8GoogJ9CcI1KWML
         78VDP+Ew0EWvBCxP3IbBx6BuXLKqIFX+r20HmOQDAoGROtMoWxQQp4t7bndWbAwKYN4U
         ZVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392504; x=1725997304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulJe0DxztcTweeavIBv/J7BVFYkM1MVqEhbfxPn4s+s=;
        b=JxhDwSCn4x46186TUTHGjJbSOiXJ3mOtmdrpsfadfM90h2byW1+/GFO8eoh35c1S9y
         0S5npZdg9XFw4W+ZQqbHJQTEbsCfIEztSh+ucqK1nXhn5yaSUkhSsfm8erkfPHORB4Yf
         bsjN5kxLfoL+4/8ZWqdE8I6mtFhX46W7AVUU1VSBeXSpuzEhcICfOeABUBvm2qzTHmzH
         x+V0/93S9uKmQliftUr1c6U8qIfsOxX8ANjgfQ0izuHDX4uL8hZPu+c5ssDWtvnnrlVE
         JBovjOz8/OpOoAcrm6UIt+zo49dtLSDL/Px8JeH6ri7WRj0/qnbJkzTT70d4nBpETjpF
         2fBw==
X-Forwarded-Encrypted: i=1; AJvYcCWYVK+2rJmk3uyxTa6xSWnuufT2UChI8ewx7VxFzdrQVx7U8SzkezT1HcLzfS2DPh8yWOO5gB6D7FCDyIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBohx1nbIGYY81t6PP24zA5D8eC7c9rpDZrw/KCVCbe/qB3pBg
	VsEhLG2Ru7knwE17xdb/W9JuixB3MXhngYtdOnim2J/Mc2G5vhe+qN3mVM1Nb/nYRpmmbJTreXO
	KYIuj72HyBaWzqHHqOi5QRHXZQFmHZS1LDXgE
X-Google-Smtp-Source: AGHT+IHJcJq7aFM6e/h0j+rnGvilIYdEVljFkR6d/pNz6/Bk0XabK3Er/a+7iPLrhB/W6ZT2+co5ktIrnqIcPcHKTRM=
X-Received: by 2002:a17:907:efe2:b0:a86:a178:42de with SMTP id
 a640c23a62f3a-a8a3f532680mr7874966b.54.1725392502780; Tue, 03 Sep 2024
 12:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
 <20240821054921.43468-1-21cnbao@gmail.com> <CAMgjq7Czvr+PXF7Q5eSChAdmiLH-uvd7HTred63T8JPCCYzTSQ@mail.gmail.com>
 <CAJD7tkYxAUVhvb_khBngRg5d504-KYVbW-v=GNfUPR-6_f-rVQ@mail.gmail.com>
 <CAJD7tkamz0RHzv3yy7833GhhhBzGB1ozRo085wB4xZjXppEBWg@mail.gmail.com> <CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmesW_59W1BWw@mail.gmail.com>
In-Reply-To: <CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmesW_59W1BWw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Sep 2024 12:41:06 -0700
Message-ID: <CAJD7tkYO3fPz0n4HXCH6iXKfM_H29DAoH2wGT+mEm8hdtpw3vA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 11:51=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Sep 4, 2024 at 2:22=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
>
> Hi Yosry,
>
> > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > index c1638a009113..8ff58be40544 100644
> > > > > --- a/mm/swapfile.c
> > > > > +++ b/mm/swapfile.c
> > > > > @@ -1514,6 +1514,8 @@ static bool __swap_entries_free(struct swap=
_info_struct *si,
> > > > >         unlock_cluster_or_swap_info(si, ci);
> > > > >
> > > > >         if (!has_cache) {
> > > > > +               for (i =3D 0; i < nr; i++)
> > > > > +                       zswap_invalidate(swp_entry(si->type, offs=
et + i));
> > > > >                 spin_lock(&si->lock);
> > > > >                 swap_entry_range_free(si, entry, nr);
> > > > >                 spin_unlock(&si->lock);
> > > > >
>
> This fix from Barry have been applied for mm-unstable and it's looking
> good so far.

Are we sure it fixes the problem? Unfortunately we don't have a
reproducer. The swap entry freeing paths are getting too tangled to
know for sure if zswap_invalidate() is being called in all cases,
which is why I prefer having a centralized callback for all swap entry
freeing hooks.

>
> > Kairui, Barry, any thoughts on this? Any preferences on how to make
> > sure zswap_invalidate() is being called in all possible swap freeing
> > paths?
>
> I have a set of patched that removed the si->lock around
> swap_entry_range_free, and the slot return cache is removed too. So we
> can move zswap_invalidate into it as locking or caching is no longer
> an issue, I will post it ASAP.

That sounds good, but I am not sure I understand what you mean by
removing the slot return cache. I will wait to see the patches.

