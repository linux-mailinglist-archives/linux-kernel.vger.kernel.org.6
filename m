Return-Path: <linux-kernel+bounces-362096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C338799B10C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E09C283480
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710864642D;
	Sat, 12 Oct 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgU7j5A"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290EE1F5FA
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728709733; cv=none; b=UgPydwznqslHrImo/JXts6F2rW2fSqAU/br6xUCkCALC5TTEibyRjSYrOKktEMq5P+oBQMBzt8qdhGuiQ0RzNFaXvViQ4b4B0jzKlYEMESRpZjRXLvsAyuPIB/zmIswDiVeoBKFj9l1uRxfsu7oqeOogihzkUwq2ncQ0jJ1p/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728709733; c=relaxed/simple;
	bh=aBVW3SQyE0zqfNHXFgMNjAiAp3AJ9GFBop3pmTFWLYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaPgquIAMLRsjonyv3BnXSQrvGe/DB8omTOtOy9N/q+EnM+R7srZL7c0RUOIgv+vlPPkQwzeZ2GIOOUJRbk7PMSFZD1u6FBEKIaImN8BLJLQjdb6TS7MKMvhQQo1dGbrM11L+nZwRivx14eqr/VGHyCM8TlrzgK/n2IJbUV4Vwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGgU7j5A; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso24678191fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728709730; x=1729314530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNtdbvyx4u7PmRsUXDr0pbN27HikJwX4DWxT/0fngAg=;
        b=NGgU7j5AbhE1rlamugDchW9oZ7WVYzoCYnp+Bp8uLa8SwlsA3HgVefH5VOxiO5V440
         ADUre7FQCngssrrrf3PQvMfRvWqE54RGSEqX8Edz+aHGUrmRBjvem9Qcg/EytBwu5eQc
         1NKLjmdcPBwX3ISyTOYBRHhEp7dtsx7w3LEUzvmsLqsF3kaOJh2bGqJHmcL631Z8fMuZ
         tmW2TEMACBY26C3bqqjRKV44vg9nlRHRwlM1fFTWnjfb4gv96o6J4ZOGDbJAbiIaBqDJ
         A1KbKuFJy0PwQztdd42eKlM6PgyJG73n7jpEzwFyfUxR9p1vxBEaWyBIIbsFGVVF3a0p
         EjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728709730; x=1729314530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNtdbvyx4u7PmRsUXDr0pbN27HikJwX4DWxT/0fngAg=;
        b=G93qIbp3/dABeCPQ1tAEWsIFFY+9zIfjj28KlW5W5E0E2qm+4y9s+Qnl6qqeD6lX6Q
         rZUguETjRhNUjEFpnQwDbre/DmKjP4rBDXCcS2q0/cNcN8yxulC+nCyIj+M1iQbEn0ko
         Jyt36vwq0hJNtTE1q+HfoLhBnGlOU74RFV9dCqDAq6Klrld7/JpKHYFCobJBEUNDk9T3
         ANjPTeEkoUVvMtUWUKaS3/fHH5mTq9xdgx9/mAC6zHvjJWz4TghbNKWZdYJ32u+byY3c
         kcYHljrkjnRoZSnsbVSf0irruLusCltAMDbwIOMD4quoodDxp0jRLTdmpo8z7zTzg9lR
         mwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmxwwniv4rkGGghOT/aY9cA77szt11Kf8nHpQm5MDkjoW8eomKWrsmnI3GPiALkuKGi94kIgyh1lvVPw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydA1FdvegOcjwwScGjnQYzymnxROGaj/nofuZ6WJUBXUYNidn+
	b/N0T8Yngea11AUppT2hfwe+F5bpfX2eBwOeMQG0kc6liXQMmfRTk8yAox1OYzINRZG6rUuc/Uv
	b+Pt54YapRpsSs81CtcaF73oux0U=
X-Google-Smtp-Source: AGHT+IGrs/xVb53uh/iaB0+AM1qJ9DJ+UtjgSlB1WMXrx+bbJdDfv0kPbGzsYVBhu2SEMs+6REzBiNgrUsGDNQG6kqo=
X-Received: by 2002:a05:651c:b29:b0:2f7:4e8c:9bfa with SMTP id
 38308e7fff4ca-2fb329a79bfmr19302571fa.33.1728709730030; Fri, 11 Oct 2024
 22:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011171950.62684-1-ryncsn@gmail.com> <CAJD7tkaZgEHUNce5c8LWpWXKnTZ7geOuBym41t+UoZax_nky7Q@mail.gmail.com>
 <20241011182831.GC351101@cmpxchg.org> <CAMgjq7Ajen_XQHGznNp3hFWOes+K=fn6HssW3-SUL8i4xDebhQ@mail.gmail.com>
 <CAJD7tkaDEizi63vWSLVZk7RXRiKs6xyDG7pFA-bcLLcG15bUxQ@mail.gmail.com>
In-Reply-To: <CAJD7tkaDEizi63vWSLVZk7RXRiKs6xyDG7pFA-bcLLcG15bUxQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 12 Oct 2024 13:08:33 +0800
Message-ID: <CAMgjq7Dt-prvfpPiSRkYBskSxiDndMNosxrN54VqKzSenLLafQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: avoid touching XArray for unnecessary invalidation
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, "Huang, Ying" <ying.huang@intel.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 11:27=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Fri, Oct 11, 2024 at 8:05=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > Johannes Weiner <hannes@cmpxchg.org> =E4=BA=8E 2024=E5=B9=B410=E6=9C=88=
12=E6=97=A5=E5=91=A8=E5=85=AD 02:28=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Oct 11, 2024 at 10:53:31AM -0700, Yosry Ahmed wrote:
> > > > On Fri, Oct 11, 2024 at 10:20=E2=80=AFAM Kairui Song <ryncsn@gmail.=
com> wrote:
> > > > >
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > zswap_invalidation simply calls xa_erase, which acquires the Xarr=
ay
> > > > > lock first, then does a look up. This has a higher overhead even =
if
> > > > > zswap is not used or the tree is empty.
> > > > >
> > > > > So instead, do a very lightweight xa_empty check first, if there =
is
> > > > > nothing to erase, don't touch the lock or the tree.
> > >
> > > Great idea!
> > >
> > > > XA_STATE(xas, ..);
> > > >
> > > > rcu_read_lock();
> > > > entry =3D xas_load(&xas);
> > > > if (entry) {
> > > >     xas_lock(&xas);
> > > >     WARN_ON_ONCE(xas_reload(&xas) !=3D entry);
> > > >     xas_store(&xas, NULL);
> > > >     xas_unlock(&xas);
> > > > }
> > > > rcu_read_unlock():
> > >
> > > This does the optimization more reliably, and I think we should go
> > > with this version.
> >
> > Hi Yosry and Johannes,
> >
> > This is a good idea. But xa_empty is just much lighweighter, it's just
> > a inlined ( =3D=3D NULL ) check, so unsurprising it has better performa=
nce
> > than xas_load.
> >
> > And surprisingly it's faster than zswap_never_enabled. So I think it
> > could be doable to introduce something like zswap_may_have_swpentry as
> > Yosry suggested.
>
> That is surprising indeed, but it is cleaner anyway to use the xarray
> check than the static key.
>
> >
> > So how about a combined version with xas_load and xa_empty? Check
> > xa_empty first as a faster path, then xas_load, then xas_store.
>
> Yeah I think having an additional xa_empty() check before xas_load() is f=
ine.
>
> >
> > Here is the benchmark result (time of swapin 2G zero pages in us):
> >
> > Before:   1908944 1905870 1905322 1905627 1901667
> > xa_empty: 1835343 1827367 1828402 1831841 1832719
> > z.._enabled: 1838428 1831162 1838205 1837287 1840980
> > xas_load: 1874606 1878971 1870182 1875852 1873403
> > combined: 1845309 1832919 1831904 1836455 1842570
> >
> > `combined` is xa_empty + xas_load.
>
> Is this with SSD swap? If you are using brd, it bypasses the swapcache
> so the benefit from the xas_load() optimization won't be much visible
> (see my earlier email as well as Johannes's).

Hi, I'm using brd indeed.

This test is trying to show the zswap disabled case, so I think swap
cache has no effect here?

For the zswap enabled case I do believe xas_load will work better,
I'll add some test info in the combined V2, will test some other
workload with the brd SYNC flag removed, sequential swapin with zswap
enabled have almost no performance change with this commit.

