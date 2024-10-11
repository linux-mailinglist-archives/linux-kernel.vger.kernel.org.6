Return-Path: <linux-kernel+bounces-360725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A05999EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0851F2639F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D4720ADF4;
	Fri, 11 Oct 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRrHwCpR"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BC20A5D9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633773; cv=none; b=TRaTHEB9j8fz60bD4eprLlfCcCCgqVIXtEGSTGzMCgANeXVxXPOmCKL8Vhw0RoB81xEPxv5UejASlhShulc+3lAMsExvt5hlalDwbiqV33qx7Gn1zt6/lBV6Jt7184dT6LZ6QSXLWm5XfbGf/saicYMyp5po7Xgp4ZqnzztQl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633773; c=relaxed/simple;
	bh=0r+O5n2NKctexJ+j5Td+RKODjkXPlVEJy6a3GOnylt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZMT8enX6mY2cz2DFNBCeZ7rMNkG/iqulkX/wr8GaqpBTmS82scwXQU9olApYNn7IbgZ/g+8HV7tOh+mX7zCWPIK6llLJVmZ5QrafCePsAw8IBvu9qWdDKIxYLKD76+G8l5VWWQlHIfv6euowX+P4SK92u7vek2xneRkt/sbkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRrHwCpR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398e7341a3so281931e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728633769; x=1729238569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0MvWrkv0ntC258PAjHA4sTrGInlD3TJEzWXe3jYd50=;
        b=KRrHwCpR/o52LgtiaW8Z6mY4UrTTXXpTTvBQW5Y4cmAZkwapTC6rlhJx2JCgEWx9sV
         LpAU5lTQpDwBOfxgHV9UT841BU+STRoDAz0zXhu5yUa8IV75XDfUY0HrqnWJRgPbVEA/
         52rzs7ZmeMRWqyMkE6Io8CjvbAvqib5ZCoWYADqzdfH9ag3dMqloAmrH1YMxoVoskXsG
         cDDKe2ujUaqtsBJJS6PKpx29dKW9Z3p/AOqtnfq49oJGhX4IMKXwxTN8JwINIRw011Bf
         Y2uhMtAxD8x0/2H4GCJ93p6Rl68otQ1jDxS2JoR17y4SZGoyDTfV7Nomad9T3/3GfQyN
         yOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633769; x=1729238569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0MvWrkv0ntC258PAjHA4sTrGInlD3TJEzWXe3jYd50=;
        b=bQuFXRR9wTORvQQPC3wqzx2fYL12kovWAq/7K2UyXB3W94+zGOjko+aHOQXy4cHTBr
         zRgF7+twUYQJUUjMYLyeVZIEyNCcHEfT/FmILXoK6d/XTPfUmx2ZONPFFd/U1LkxWN0t
         4LntXfIHsLJnnHmeckMZFKuWFjrSAYOEYJn3nXCBPEEnFZXuJ5Sm6hEnt9q+mZv90yHT
         9S6sL3O1wm+1Kp/o65fhpkPeXd6rlaGZUtPkyKTKCyf26ee6XqiwNjdZNsNxOLpgOi4k
         89NUvj7Zr88wRAj+mr48aOxraY/GujZsiOLts+Ucmoq9Q2VtQANUu/Dh2PWHDoIjTifU
         qdaA==
X-Forwarded-Encrypted: i=1; AJvYcCWZDax48qubdgIvRNFpCwdbnbpUUrqPhTFw2TkLDO62mT5J5Dsdx3ZZ357houIcOYzSTsmOBUTMdq716H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO981pHv0qW+ZpJi/2DZaujYHPdGCJsUixKZu1wrPGzxO2X28m
	ba1wX1p1YlgEVFtMO5npsvcSVehp4DtO41hBaMjpNOrMFUXulhTCdhhr9mwzX+ZnNeqKq+m+X6y
	habVnHYn4Mbsza29AWt+I+Gjsnfk=
X-Google-Smtp-Source: AGHT+IGQBsc+s67Y9dtP/Nqo/WXr4fyofXRCXEMfyRVr2g6j6uPJvtdnug0xWckMppaIyBMouiWcSXZ7dDxP9Zrrjx8=
X-Received: by 2002:a05:6512:3e26:b0:535:681d:34b6 with SMTP id
 2adb3069b0e04-539da5e2afdmr210814e87.10.1728633768604; Fri, 11 Oct 2024
 01:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009074953.608591-1-zhaoyang.huang@unisoc.com> <CAOUHufaiKFZ6LjoQ8SChK+m0-nPzT6RYpDfLHp69vn1OYm3qhQ@mail.gmail.com>
In-Reply-To: <CAOUHufaiKFZ6LjoQ8SChK+m0-nPzT6RYpDfLHp69vn1OYm3qhQ@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 11 Oct 2024 16:02:37 +0800
Message-ID: <CAGWkznGBWxVD0La5PArU1F2Q1Tqk40EGP1V0+jRiLNaxWy5zbg@mail.gmail.com>
Subject: Re: [PATCH] mm: throttle and inc min_seq when both page types reach MIN_NR_GENS
To: Yu Zhao <yuzhao@google.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:37=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Oct 9, 2024 at 1:50=E2=80=AFAM zhaoyang.huang <zhaoyang.huang@uni=
soc.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > The test case of [1] leads to system hang which caused by a local
> > watchdog thread starved over 20s on a 5.5GB RAM ANDROID15(v6.6)
> > system. This commit solve the issue by have the reclaimer be throttled
> > and increase min_seq if both page types reach MIN_NR_GENS, which may
> > introduce a livelock of switching type with holding lruvec->lru_lock.
> >
> > [1]
> > launch below script 8 times simutanously which allocates 1GB virtual
> > memory and access it from user space by each thread.
> > $ costmem -c1024000 -b12800 -o0 &
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/vmscan.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index cfa839284b92..83e450d0ce3c 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4384,11 +4384,23 @@ static int scan_folios(struct lruvec *lruvec, s=
truct scan_control *sc,
> >         int remaining =3D MAX_LRU_BATCH;
> >         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> >         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
> > +       struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> >
> >         VM_WARN_ON_ONCE(!list_empty(list));
> >
> > -       if (get_nr_gens(lruvec, type) =3D=3D MIN_NR_GENS)
> > -               return 0;
> > +       if (get_nr_gens(lruvec, type) =3D=3D MIN_NR_GENS) {
> > +               /*
> > +                * throttle for a while and then increase the min_seq s=
ince
> > +                * both page types reach the limit.
> > +                */
>
> Sorry but this isn't going to work because in try_to_inc_min_seq(), there=
 is
>    `while (min_seq[type] + MIN_NR_GENS <=3D lrugen->max_seq) {`
> to prevent reclaimers from evicting hot memory -- they need to do aging f=
irst.
Thanks for heads up. What I thought was assuming there is a running
reclaimer will do the aging and the throttled reclaimers increase the
min_seq when scheduled back and move on. Or could we just drop the
lock and throttle for a while to avoid a livelock on 'type =3D !type'
with holding the lock?

>
> >
> > +               if (get_nr_gens(lruvec, !type) =3D=3D MIN_NR_GENS) {
> > +                       spin_unlock_irq(&lruvec->lru_lock);
> > +                       reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATE=
D);
> > +                       spin_lock_irq(&lruvec->lru_lock);
> > +                       try_to_inc_min_seq(lruvec, get_swappiness(lruve=
c, sc));
> > +               } else
> > +                       return 0;
> > +       }
> >
> >         gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
> >
> > --
> > 2.25.1
> >

