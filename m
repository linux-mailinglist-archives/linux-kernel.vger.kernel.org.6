Return-Path: <linux-kernel+bounces-362059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94699B06B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7BE282638
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161191272A6;
	Sat, 12 Oct 2024 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4wqVVAY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B81799F
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728703634; cv=none; b=aEyAs5ml4KNmTkOzpEp/5Bmg5uE0Snk8OGc2yMf8QDzN50p+7kh+nZHdbQkCChr5vHzknZusJbkz6j+O0KTip4HVBZO83doSeyeQeehPuOFHfBCgpI+BmxWPGcwE8MGsmKKe2r+/ODAPpuwvHkHSWPAAiceb8hTbCwOp+/wRyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728703634; c=relaxed/simple;
	bh=F8DFHqv1+dGqlCxt8XMF4a/WhTcYfXPdcxkvKn+qs6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P59PPuc/V4Sbh0bvAwhqy6hOHKFSIZA1MWft1vuJ+P8i41iNCK2fzP8MoA5nRmTcsRaoRnLrfSBB84FyS88SI6b5FSA86c4YkGbCStGHl/ZNWhCUjjyn3wiAeL9RluSipslP3gOYKGUVei6J1PNWca12gShoPPVnSn+Vrj/GGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4wqVVAY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99b1f43aceso311316366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728703631; x=1729308431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWTezJHR9Vq4+Q9HVaoXpPlGXcBP8rtz9ZwlcdC9EN4=;
        b=b4wqVVAYs+fdonnVOzMVMFccII299Rlj1EyUyqrjOtESexNA5EgVxu+WLS9f5H9Cen
         0DiSlVS+c4JOZFo5jHWI7bOr+bkpqK6xru6HvLxUeXT3/rzRQsryid9DfdwbRJw/lHSt
         snjD6wt9zRy3eIbqTx3AhAowOogd9F8ckxveZUM3veYJnAFqnO/j9zb+7fFfS+g7H7bH
         nTqShhZspqqQMmZA1B9InBZOgB+W8YI6kTneJwTqHZ19JobT9x16i8Mt/37RquEwsaI3
         ID8W97qa+tc/WEUooJuibCgJMNUmFvIiKEmMHXWbGV5PF/mRh3gpzuvc9eCP3sH6iuU4
         FqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728703631; x=1729308431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWTezJHR9Vq4+Q9HVaoXpPlGXcBP8rtz9ZwlcdC9EN4=;
        b=RvUhA3rQUvuPsvYKf1KQbuWNowDI/ZDLS7euL+F2vNxfZgpeeaU2EPHy/LP5azHQ4/
         9gzniSnmyp/PcthM+l1i4z0fOc00mbTq1j40vd5EzKDWPd7TdE/JvVCw3lUvwAysh/3r
         WiV/l/9ly7unGN+rIQ59v+S0Kq5K7Gvct8qJGPvB7mgTnHAZtqF29zciN2BKkW31/xd5
         e+SxrQsFcR/k9J+IsWRGB03XeuQwKaWxQG7NaGFOjnjj4/zRQysEZQ0pMlMCxUsXiOA7
         L73PSh73GrKRXGbMUPb2gu56Tez6LQ3KgqP0S1h9cKbG3+wQb4wJu4AWlvtph/LREbTk
         OQQw==
X-Forwarded-Encrypted: i=1; AJvYcCWD0R12+Nhfp5+C2owhchB3eqUsU1JMhhu4UVMJV7fnzJOsZcQYN89IfXo7MUFR5sPmh+YlLTrV+dHGe1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JY9jiFf9va0+Bt5pykSUY46YjQ24/FMKqVYIZ1a+ySKoskIJ
	i/Tqgsv/CYCXPllzGbNTQRvBeptR3DDs9USUuUKXb3ypM/wHxf0TGnrgd5KVYPs4NdT7S9Ip9iz
	/zy9ENhoJXnoMFPMJGyyDN+ptOY1ERSOeOSyU
X-Google-Smtp-Source: AGHT+IFTZZoruKvDa4wWJWY4hwy38IqKlTFgrtJMgUvabVxU/vEEAu7T75+M5mSUOo9XTzDZeNZFdKP//gpGOey5wNc=
X-Received: by 2002:a17:907:3e14:b0:a99:f209:cea3 with SMTP id
 a640c23a62f3a-a99f209cf34mr6850166b.11.1728703630697; Fri, 11 Oct 2024
 20:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011171950.62684-1-ryncsn@gmail.com> <CAJD7tkaZgEHUNce5c8LWpWXKnTZ7geOuBym41t+UoZax_nky7Q@mail.gmail.com>
 <20241011182831.GC351101@cmpxchg.org> <CAMgjq7Ajen_XQHGznNp3hFWOes+K=fn6HssW3-SUL8i4xDebhQ@mail.gmail.com>
In-Reply-To: <CAMgjq7Ajen_XQHGznNp3hFWOes+K=fn6HssW3-SUL8i4xDebhQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 11 Oct 2024 20:26:33 -0700
Message-ID: <CAJD7tkaDEizi63vWSLVZk7RXRiKs6xyDG7pFA-bcLLcG15bUxQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: avoid touching XArray for unnecessary invalidation
To: Kairui Song <ryncsn@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, "Huang, Ying" <ying.huang@intel.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:05=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> Johannes Weiner <hannes@cmpxchg.org> =E4=BA=8E 2024=E5=B9=B410=E6=9C=8812=
=E6=97=A5=E5=91=A8=E5=85=AD 02:28=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Oct 11, 2024 at 10:53:31AM -0700, Yosry Ahmed wrote:
> > > On Fri, Oct 11, 2024 at 10:20=E2=80=AFAM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > > >
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > zswap_invalidation simply calls xa_erase, which acquires the Xarray
> > > > lock first, then does a look up. This has a higher overhead even if
> > > > zswap is not used or the tree is empty.
> > > >
> > > > So instead, do a very lightweight xa_empty check first, if there is
> > > > nothing to erase, don't touch the lock or the tree.
> >
> > Great idea!
> >
> > > XA_STATE(xas, ..);
> > >
> > > rcu_read_lock();
> > > entry =3D xas_load(&xas);
> > > if (entry) {
> > >     xas_lock(&xas);
> > >     WARN_ON_ONCE(xas_reload(&xas) !=3D entry);
> > >     xas_store(&xas, NULL);
> > >     xas_unlock(&xas);
> > > }
> > > rcu_read_unlock():
> >
> > This does the optimization more reliably, and I think we should go
> > with this version.
>
> Hi Yosry and Johannes,
>
> This is a good idea. But xa_empty is just much lighweighter, it's just
> a inlined ( =3D=3D NULL ) check, so unsurprising it has better performanc=
e
> than xas_load.
>
> And surprisingly it's faster than zswap_never_enabled. So I think it
> could be doable to introduce something like zswap_may_have_swpentry as
> Yosry suggested.

That is surprising indeed, but it is cleaner anyway to use the xarray
check than the static key.

>
> So how about a combined version with xas_load and xa_empty? Check
> xa_empty first as a faster path, then xas_load, then xas_store.

Yeah I think having an additional xa_empty() check before xas_load() is fin=
e.

>
> Here is the benchmark result (time of swapin 2G zero pages in us):
>
> Before:   1908944 1905870 1905322 1905627 1901667
> xa_empty: 1835343 1827367 1828402 1831841 1832719
> z.._enabled: 1838428 1831162 1838205 1837287 1840980
> xas_load: 1874606 1878971 1870182 1875852 1873403
> combined: 1845309 1832919 1831904 1836455 1842570
>
> `combined` is xa_empty + xas_load.

Is this with SSD swap? If you are using brd, it bypasses the swapcache
so the benefit from the xas_load() optimization won't be much visible
(see my earlier email as well as Johannes's).

