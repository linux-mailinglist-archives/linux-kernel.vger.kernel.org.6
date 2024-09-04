Return-Path: <linux-kernel+bounces-314458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77FC96B39B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0421A1C24A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD115574C;
	Wed,  4 Sep 2024 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY2vcxuY"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395AFC12
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436478; cv=none; b=SU7RssMoxVypnE77i0YA6WGmkxzARH9+jCfn0zJj1QBQbqGX79wmYMeXC4s5v9J1GDAHz8UmHeYFJx50nGqWE1Yg555ahYhA4sBqUWGRVOsKqEY8Ki9HTl+xBvnrvsAJjx3y/OMSnan7AQ9OseaII0ZVuDEif1IpEKQBm5LUfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436478; c=relaxed/simple;
	bh=4vyNiNiH1v08P0yMcB0Tpdo2B83NyylFDODnvzqYY4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHzPX+0O36E5V0tRgasgr/7WwlsM6g9QE8tZ9cJ0ed/If7OS4NTUrvMSBa56wG5jiQQB5rkANKahgVaFgX2Ntr/VWUaMkoX1VZHa+fKjpDdX2LcA+IVYGS3DU8+v/+bVGeav2jfvfwA1ypJewRujyYrSx94FbFgLUYecYNtLulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY2vcxuY; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-498c3d1d788so1919985137.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725436476; x=1726041276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxP8uxBrxXEUMSrhNgWV8NVY8CGnEdtra3EFMhwcZVE=;
        b=PY2vcxuYBMnknFGvcg4+zUJApGBgl/FLXWzaodHvKBbZc4kpoa021AfIUfNh5ysN5k
         bLvoxspaM7hxokjbXAVYPBpGx1VRe2ACzCZhTRIWGMD77bZnN2cf0fBs9mnQQbkl90o3
         qivpbFTCcU/UTRWC0OQhYMmvIgGvcsE+sKp99t43vmH6KV7dg+6ZMYqJ07Wo76zy7PlM
         ZLwToTaGZINyms7A2Ck7TjGpUtYOGegR+2ldLZI8uDEtXV5stnJ5T0XCyd6/xKc/XhM+
         D06OMEEzy5/3OEZA3Y4ON9y8/OznwDaGd10iWZgDAspxNHVoOp/VQXjr1houQOBdi6ju
         wtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725436476; x=1726041276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxP8uxBrxXEUMSrhNgWV8NVY8CGnEdtra3EFMhwcZVE=;
        b=HqewB/Q9JMGLfYSD6j86Kcsw/Awkw0GY7mQp8Hov4bDlYJbxiyZLPy2mm5XQGnfqbA
         HNh2s/6dHC4L4wyR0H+MjOAzLZFAQqEReuaV58mGb4IvuG5HkkHsIEmgLEvJeCMlxeUP
         QN35lYw54uqD7g7nSoJZP0z21JwxPqUIfIzr2gTyTv9Rp7aj1faZbDgfw7SiYWBZiavU
         RhRKYtj+XT2Z8HMuA79c+kYVX9+FmP5w8NAGEA+qq4RLIPKg8ZdQU+b6q2Kvj7aqBdrp
         wW2jC1DVpS3Lr1ODwq1EV+pjGNGmhzV1/ZTLvMICiCygR2wIVlXPyb4XUrrSebvf9AQh
         8PGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWanpLTVU8xzOfNekwBP1oeTE4OamDSQBmBYabINDF5A4747OUFO0KP34ENequCkQ+BbF5UcAmhmjPUHZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+oWmQ50sUcubyY/YG2j5RkpqpzrKjyMI9jk6AMvFV6cjuYD02
	sIMiePOf3rSKBByLo1OY0M2Jhaa3Jj+c7Azhgv7p/XnuE7N+7ZfUh4xKexaKvUg8Jgk/bv1U6tA
	AduwcjcuTZbir900wnrZEBAIsfWo=
X-Google-Smtp-Source: AGHT+IGj3e9LihOyTv2RTKK+ffTsTHLy4Q57XPgdreaMh7p6JHnGSNd1hg/5aRjmybMIvr0brZIQFjh24MDeXcupEtk=
X-Received: by 2002:a05:6102:c46:b0:493:eebc:d77d with SMTP id
 ada2fe7eead31-49a779b68eamr10223208137.15.1725436475730; Wed, 04 Sep 2024
 00:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com> <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
In-Reply-To: <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 4 Sep 2024 19:54:24 +1200
Message-ID: <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 7:22=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Wed, Sep 4, 2024 at 12:17=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Wed, Sep 4, 2024 at 7:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > [..]
> > > > > @@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *=
iocb, long ret)
> > > > >         mempool_free(sio, sio_pool);
> > > > >  }
> > > > >
> > > > > +static bool swap_read_folio_zeromap(struct folio *folio)
> > > > > +{
> > > > > +       unsigned int idx =3D swap_zeromap_folio_test(folio);
> > > > > +
> > > > > +       if (idx =3D=3D 0)
> > > > > +               return false;
> > > > > +
> > > > > +       /*
> > > > > +        * Swapping in a large folio that is partially in the zer=
omap is not
> > > > > +        * currently handled. Return true without marking the fol=
io uptodate so
> > > > > +        * that an IO error is emitted (e.g. do_swap_page() will =
sigbus).
> > > > > +        */
> > > > > +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > > > > +               return true;
> > > >
> > > > Hi Usama, Yosry,
> > > >
> > > > I feel the warning is wrong as we could have the case where idx=3D=
=3D0
> > > > is not zeromap but idx=3D1 is zeromap. idx =3D=3D 0 doesn't necessa=
rily
> > > > mean we should return false.
> > >
> > > Good catch. Yeah if idx =3D=3D 0 is not in the zeromap but other indi=
ces
> > > are we will mistakenly read the entire folio from swap.
> > >
> > > >
> > > > What about the below change which both fixes the warning and unbloc=
ks
> > > > large folios swap-in?
> > >
> > > But I don't see how that unblocks the large folios swap-in work? We
> > > still need to actually handle the case where a large folio being
> > > swapped in is partially in the zeromap. Right now we warn and unlock
> > > the folio without calling folio_mark_uptodate(), which emits an IO
> > > error.
> >
> > I placed this in mm/swap.h so that during swap-in, it can filter out an=
y large
> > folios where swap_zeromap_entries_count() is greater than 0 and less th=
an
> > nr.
> >
> > I believe this case would be quite rare, as it can only occur when some=
 small
> > folios that are swapped out happen to have contiguous and aligned swap
> > slots.
>
> I am assuming this would be near where the zswap_never_enabled() check
> is today, right?

The code is close to the area, but it doesn't rely on zeromap being
disabled.

>
> I understand the point of doing this to unblock the synchronous large
> folio swapin support work, but at some point we're gonna have to
> actually handle the cases where a large folio being swapped in is
> partially in the swap cache, zswap, the zeromap, etc.
>
> All these cases will need similar-ish handling, and I suspect we won't
> just skip swapping in large folios in all these cases.

I agree that this is definitely the goal. `swap_read_folio()` should be a
dependable API that always returns reliable data, regardless of whether
`zeromap` or `zswap` is involved. Despite these issues, mTHP swap-in should=
n't
be held back. Significant efforts are underway to support large folios in
`zswap`, and progress is being made. Not to mention we've already allowed
`zeromap` to proceed, even though it doesn't support large folios.

It's genuinely unfair to let the lack of mTHP support in `zeromap` and
`zswap` hold swap-in hostage.

Nonetheless, `zeromap` and `zswap` are distinct cases. With `zeromap`, we
permit almost all mTHP swap-ins, except for those rare situations where
small folios that were swapped out happen to have contiguous and aligned
swap slots.

swapcache is another quite different story, since our user scenarios begin =
from
the simplest sync io on mobile phones, we don't quite care about swapcache.

Thanks
Barry

