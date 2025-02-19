Return-Path: <linux-kernel+bounces-521123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BEDA3B452
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B97A2CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093271DEFDC;
	Wed, 19 Feb 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx13HUKz"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD421DEFD4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954109; cv=none; b=BtSCEVWJTHPdfAuy2Io/6SNTqCSlIa8wM7n6Ml/1hh4gLqLQoV+B8JFUdkJk8bOs7cYS+kUEG8t7470MH4i/5VkDrf2k+t2rcVOiiV4SfKwPcA2gTANk/h4LMZZy0TA+BJz62gZffeaDycPBl0BAk4eaG/st2dq73rnZ+8e3DaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954109; c=relaxed/simple;
	bh=n7H9TXtXn1vG1HHhCEri+d8DCew1NKpGfIM7cXGAqvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l58pF7TZtzjY958RQXvGAKemFOjBQDg5mcHnct7exmEgYqNAxqjjB2kBDRXyOJk3TVAr54zIS7Hq+wK8rzBdQHFPCkZVszbED1uWYiU+iAXzHXm/lN6G1KczYvll4yHu8PKz3mZgjdNLyXc0ASp3/xd94Dki9ERj6cMqy6vjMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx13HUKz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-307325f2436so54889541fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739954102; x=1740558902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymf/r5WVS2oRidQjYGCcOUX71UniPr2O+cwqDyy+uhM=;
        b=Jx13HUKzsGpKCk3q/4j/rCxqIAtFrSdKUwyIIZZFn4h2WZx6xlWntbDtGaZUBjkRou
         OSMaNyQkI+gQc2gzT2s6ZRuJ2pAX/CmuWnrF+wBXRtEpJYIBMyaaXyYiNImRTbemy5ZY
         QGSmejplO044/jFyqbcnTjMoFEQsxpgqPYONzYSZqkO6fZ/msnAh+DxeCp14HHGukSxv
         1vTCXJGIK20OkCv5VDcQiyzHC9HHzqS/izBvqTGQePLST5uhQLfqCAfcXytF79PxAIDt
         iNTXDgmUxUYGy54qX9Z8i5XNIKbNeCjy48YgcNO6Dxa0fuYnV+6Lgk6h8v9hHXfV6x/y
         mAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954102; x=1740558902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymf/r5WVS2oRidQjYGCcOUX71UniPr2O+cwqDyy+uhM=;
        b=Xach1d4YWzB2Zd1IRb4nJ3KxYvPdJBjoMXuNOgV5b9U76mjbymlngGscVaIUdVf/D3
         3hgV1udINSZvJdvhzJo/3aR/m/GbI1X+KjkeCvpzqO8bYNcdF8/ddl8XfkuHFuV2F9et
         9wFLuaMOJDci8zqzjlSi1XsCRMuuUJamUry9ODuH0ESClHuwXUQ4/VsD5oYieD4CNcEJ
         VZ1rltAS9dcM5ctxQloOnewU2RiZYBDf19zTCh9B4UR5LiaFU3M4rUcZvaoggt15H6Mc
         1DnfTpSmSd2IWyX8t95i3WEevwOw2vRqsHj0LAZw/e5xopFBnGrb3bmH8UPnQQn1nZgP
         5vIg==
X-Forwarded-Encrypted: i=1; AJvYcCWyRVkCbj5yAquW6NyeMQVBc2Pv3UzWrtKffylowEgvbn2hQA7jFsiwISwtnsVplvSkFW/XlZwQKah/gJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfidEICeVUCwKPU07bP/Vp2LZ5S/eBscWcWHzjPSX8BgGX+4Ux
	8cs6JFPbWISghK8sNUd6ObKKWYvOYCO2yj7cXHpxhuUp7L7NHtxRJ9N1bsU6LEn9+qBxWvy60f4
	gy5UOpf21oixOk5OchvZBRySTExY=
X-Gm-Gg: ASbGncuh5Yb5EpL00GIIGgKREFCMVYU2QSBILt12DJfQaV9EuuN1/P+Blvn182j8Xgt
	750KRlLl73PbQ93+TTT0WH+2Qm+fkUA7HS6B27OCmwvyd/nC4vy6z0kyK0bk1BOhnVze0DtZ/
X-Google-Smtp-Source: AGHT+IGv3q5/LIOR6BIzcIw9PSev1r9ulF73uf4A99AqseTCJq9zL6QOHf9tiO80xMKCoXG+cgrSDbNIpOZ/oHeBbEU=
X-Received: by 2002:a05:6512:3d15:b0:545:a2f:22bd with SMTP id
 2adb3069b0e04-5462ef23810mr1112660e87.48.1739954101418; Wed, 19 Feb 2025
 00:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214175709.76029-1-ryncsn@gmail.com> <20250214175709.76029-6-ryncsn@gmail.com>
 <Z7WOCvQq3xi9wxnt@MiWiFi-R3L-srv>
In-Reply-To: <Z7WOCvQq3xi9wxnt@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 19 Feb 2025 16:34:45 +0800
X-Gm-Features: AWEUYZkPJOd4SwyQaKWas7yryXBRZnRYFVtmL1SihZNVdbYFgqLG0htrQyLOR4o
Message-ID: <CAMgjq7C0Yg164SHJcP6wDC0od-xRuBMxLsJJwB0oWavpgsr8tg@mail.gmail.com>
Subject: Re: [PATCH 5/7] mm, swap: use percpu cluster as allocation fast path
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:54=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:

Hi Baoquan,

Thanks for the review!

>
> On 02/15/25 at 01:57am, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Current allocation workflow first traverses the plist with a global loc=
k
> > held, after choosing a device, it uses the percpu cluster on that swap
> > device. This commit moves the percpu cluster variable out of being tied
> > to individual swap devices, making it a global percpu variable, and wil=
l
> > be used directly for allocation as a fast path.
> >
> > The global percpu cluster variable will never point to a HDD device, an=
d
> > allocation on HDD devices is still globally serialized.
> >
> > This improves the allocator performance and prepares for removal of the
> > slot cache in later commits. There shouldn't be much observable behavio=
r
> > change, except one thing: this changes how swap device allocation
> > rotation works.
> >
> > Currently, each allocation will rotate the plist, and because of the
> > existence of slot cache (64 entries), swap devices of the same priority
> > are rotated for every 64 entries consumed. And, high order allocations
> > are different, they will bypass the slot cache, and so swap device is
> > rotated for every 16K, 32K, or up to 2M allocation.
> >
> > The rotation rule was never clearly defined or documented, it was chang=
ed
> > several times without mentioning too.
> >
> > After this commit, once slot cache is gone in later commits, swap devic=
e
> > rotation will happen for every consumed cluster. Ideally non-HDD device=
s
> > will be rotated if 2M space has been consumed for each order, this seem=
s
>
> This breaks the rule where the high priority swap device is always taken
> to allocate as long as there's free space in the device. After this patch=
,
> it will try the percpu cluster firstly which is lower priority even thoug=
h
> the higher priority device has free space. However, this only happens whe=
n
> the higher priority device is exhausted, not a generic case. If this is
> expected, it may need be mentioned in log or doc somewhere at least.

Hmm, actually this rule was already broken if you are very strict
about it. The current percpu slot cache does a pre-allocation, so the
high priority device will be removed from the plist while some CPU's
slot cache holding usable entries.

If the high priority device is exhausted, some CPU's percpu cluster
will point to a low priority device indeed, and keep using it until
the percpu cluster is drained. I think this should be
OK. The high priority device is already full, so the amount of
swapouts falls back to low priority device is only a performance
issue, I think it's a tiny change for a rare case.

>
> > reasonable. HDD devices is rotated for every allocation regardless of t=
he
> > allocation order, which should be OK and trivial.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/swap.h |  11 ++--
> >  mm/swapfile.c        | 120 +++++++++++++++++++++++++++----------------
> >  2 files changed, 79 insertions(+), 52 deletions(-)
> ......
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index ae3bd0a862fc..791cd7ed5bdf 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -116,6 +116,18 @@ static atomic_t proc_poll_event =3D ATOMIC_INIT(0)=
;
> >
> ......snip....
> >  int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_or=
der)
> >  {
> >       int order =3D swap_entry_order(entry_order);
> > @@ -1211,19 +1251,28 @@ int get_swap_pages(int n_goal, swp_entry_t swp_=
entries[], int entry_order)
> >       int n_ret =3D 0;
> >       int node;
> >
> > +     /* Fast path using percpu cluster */
> > +     local_lock(&percpu_swap_cluster.lock);
> > +     n_ret =3D swap_alloc_fast(swp_entries,
> > +                             SWAP_HAS_CACHE,
> > +                             order, n_goal);
> > +     if (n_ret =3D=3D n_goal)
> > +             goto out;
> > +
> > +     n_goal =3D min_t(int, n_goal - n_ret, SWAP_BATCH);
>
> Here, the behaviour is changed too. In old allocation, partial
> allocation will jump out to return. In this patch, you try the percpu
> cluster firstly, then call scan_swap_map_slots() to try best and will
> jump out even though partial allocation succeed. But the allocation from
> scan_swap_map_slots() could happen on different si device, this looks
> bizarre. Do you think we need reconsider the design?

Right, that's a behavior change, but only temporarily affects slot cache.
get_swap_pages will only be called with size > 1 when order =3D=3D 0, and
only by slot cache. (Large order allocation always use size =3D=3D 1,
other users only uses order =3D=3D 0 && size =3D=3D 1). So I didn't' notice
it, as this series is removing slot cache.

The partial side effect would be "returned slots will be from
different devices" and "slot_cache may get drained faster as
get_swap_pages may return less slots when percpu cluster is drained".
Might be a performance issue but seems slight and trivial, slot cache
can still work. And the next commit will just remove the slot cache,
and the problem will be gone. I think I can add a comment about it
here?

