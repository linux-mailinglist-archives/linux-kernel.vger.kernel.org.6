Return-Path: <linux-kernel+bounces-194157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED38D3794
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D71287540
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53F12B87;
	Wed, 29 May 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2cRTPc+"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4CF1758B;
	Wed, 29 May 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989287; cv=none; b=l/JDQy6Ak236VCS9OCukE6wTGgE758S13d9GcY0iG7FJC3OBLSN6yQAgHuR2XReZ2yICe/ZA9cMs2gKg5CVmUE+eFORKppLmkxVhgMlEMa3PbY8gThMtRKF/4IR89ugM/idVE1bnx05wayN7IlVhGPSxnlpiTNxEkYY4YT4V514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989287; c=relaxed/simple;
	bh=2D9bsF8IboVFVHlZqy8N3BUVc0dB5uLL5L7p85Qzrp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USeSj/JzdCc1z/9wIw1TUqJGIzOO2SGGJ8a3/An0CvkegPicsZ3u7OUaaetd15qzMx2aaxlQY0a3IqIxzM6JlfKTfDBnjQuWWljJCoX3TLQQ/kS79lQm3SvnIvLOe0umu/eRc70Ok7rgir4236Kz4xa0y/bNvhgMpNqcb32SdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2cRTPc+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a0849f5a8so20547727b3.2;
        Wed, 29 May 2024 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716989285; x=1717594085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feB/56QcRvQlMzL2KSQZZ9GD4whRaX0bA2BQ/DYpEpE=;
        b=F2cRTPc+9HfkIdaoetLG2OFAbna4RVlAuFCuFM681Cv5FkknHp2L71tEtoAv9gQ/9x
         C1aDdbGENmIJpt/5pkatdDlEXZbNz5z/3wMgKgqeGVAI6YDXL4PO1Xk2GYSn9AY9an/U
         vKTPu2oZlzEhN28KP/qU9wbEHkSuh2ETAVSMISVUw3CmgUHb39e02OD6PPvPbZgEgpc/
         MX2mC8dezIXm/Jq/W4ahHYyr+tUz4zHVOS8+TJPz4N+/zYwJ+C6UrIhNRUf7t+uBv3xz
         Nm02AxLkHjg3uoTNS7pGECVww2OGoL4QXO8hNEiFORSpE4qrwGy0X+VvXkHgDAWqsBZK
         7LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716989285; x=1717594085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feB/56QcRvQlMzL2KSQZZ9GD4whRaX0bA2BQ/DYpEpE=;
        b=kL2je20yze6H+vWqAUJe5mB4te+B5QcjImB3/3nAcuEwoI+yVRwDZQqDbmjXE6bjU1
         7K6OXlULgre+6DsKkpP2D9lUU4w0vkuLIyaE0bfLaqxVDU+JPb50s6VReDYWHcQ4kUEf
         9cL1Fvcljz42Ycq4utsXq0sx/lZin/3Zk/xsutYSsUQemm8cc9o59ioS4ddZNn1oviEQ
         z47sm6CFMDXlpQpAcuoFvgHTGJiXV8p7coVX8YTSJ3b6hOE1w6HzBjohCk0SsNyb+LYV
         SZWekJWAitO3/mBOwYVgZLhlOTAIc27zKGHqeLJhQymhUCG2M+HN1ibv+UVJ1iy3xORM
         dDlw==
X-Forwarded-Encrypted: i=1; AJvYcCVYsCZg1NyB8v3YMiQbU9VODGZoUP2n4FRoAfRaKpH/sDEERJYuQXZk+3RmdMUYcpGaLVqlXUpcUqr/oJ+ShNNNNS8ti16ry7stYMjQqCkdQmQD4kY0EdJIu0e2Gl5nJUhVD1oMNQ0C
X-Gm-Message-State: AOJu0YzTZ3OiRLE1kpeEF+CxMf3Pzk7NGs94dZ8EqDB73Jn9spHgd8l5
	sZrvPkOqJ86QGEi5Foex453msbxp3O43eFT07QOYcGFXh3kRyrzqPx2QZYwb9ZeapKguH/+R6Ra
	T1CACkMbAwLG9pOHmbzL6Cy0Zono=
X-Google-Smtp-Source: AGHT+IFnI9mmjeBQWyXqd2gNmeCooUG1lmc3tLc06VpUQ3YLD+iLEKKuHLgn24xSsUDXY/kOhkHfBCiukUoSkgposW8=
X-Received: by 2002:a0d:e2cd:0:b0:61b:33b6:41dd with SMTP id
 00721157ae682-62a08ea7e34mr149139207b3.37.1716989284656; Wed, 29 May 2024
 06:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528043404.39327-2-flintglass@gmail.com> <20240528043404.39327-5-flintglass@gmail.com>
 <CAKEwX=NcdpgGTp8Kj_kiTkvAK=k8kzayhMo+oeaXGZFA5RuoEw@mail.gmail.com>
In-Reply-To: <CAKEwX=NcdpgGTp8Kj_kiTkvAK=k8kzayhMo+oeaXGZFA5RuoEw@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Wed, 29 May 2024 22:27:53 +0900
Message-ID: <CAPpoddeKguLK3paGKAXQ+jO30jC05hvdvZiro2yfVGgrZWnOeA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: zswap: proactive shrinking before pool size limit
 is hit
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=B0=B4) 1:01 Nhat Pham <nphamcs@gmail=
com>:
>
> On Mon, May 27, 2024 at 9:34=E2=80=AFPM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > This patch implements proactive shrinking of zswap pool before the max
> > pool size limit is reached. This also changes zswap to accept new pages
> > while the shrinker is running.
> >
> > To prevent zswap from rejecting new pages and incurring latency when
> > zswap is full, this patch queues the global shrinker by a pool usage
> > threshold at the middle of 100% and accept_thr_percent, instead of the
> > max pool size.  The pool size will be controlled between 90% to 95% for
> > the default accept_thr_percent=3D90.  Since the current global shrinker
> > continues to shrink until accept_thr_percent, we do not need to maintai=
n
> > the hysteresis variable tracking the pool limit overage in
> > zswap_store().
> >
> > Before this patch, zswap rejected pages while the shrinker is running
> > without incrementing zswap_pool_limit_hit counter. It could be a reason
> > why zswap writethrough new pages before writeback old pages.  With this
> > patch, zswap accepts new pages while shrinking, and zswap increments
> > the counter when and only when zswap rejects pages by the max pool size=
.
> >
> > The name of sysfs tunable accept_thr_percent is unchanged as it is stil=
l
> > the stop condition of the shrinker.
> > The respective documentation is updated to describe the new behavior.
>
> I'm a bit unsure about using this tunable. How would the user
> determine the level at which the zswap pool should be kept empty?
>
> I was actually thinking of removing this knob altogether :)
>

If we see a large pool_limit_hit, that indicates we should lower the
accept threshold to make more space proactively, to store new pages
from active processes rather than rejecting.
If not, we can set a higher accept threshold for swapin, s.t.
low-activity background processes.
That depends on one's workload, and can be tuned by the admin, I think.

> >
> > Signed-off-by: Takero Funaki <flintglass@gmail.com>
> > ---
> >  Documentation/admin-guide/mm/zswap.rst | 17 +++++----
> >  mm/zswap.c                             | 49 +++++++++++++++-----------
> >  2 files changed, 37 insertions(+), 29 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/adm=
in-guide/mm/zswap.rst
> > index 3598dcd7dbe7..a1d8f167a27a 100644
> > --- a/Documentation/admin-guide/mm/zswap.rst
> > +++ b/Documentation/admin-guide/mm/zswap.rst
> > @@ -111,18 +111,17 @@ checked if it is a same-value filled page before =
compressing it. If true, the
> >  compressed length of the page is set to zero and the pattern or same-f=
illed
> >  value is stored.
> >
> > -To prevent zswap from shrinking pool when zswap is full and there's a =
high
> > -pressure on swap (this will result in flipping pages in and out zswap =
pool
> > -without any real benefit but with a performance drop for the system), =
a
> > -special parameter has been introduced to implement a sort of hysteresi=
s to
> > -refuse taking pages into zswap pool until it has sufficient space if t=
he limit
> > -has been hit. To set the threshold at which zswap would start acceptin=
g pages
> > -again after it became full, use the sysfs ``accept_threshold_percent``
> > -attribute, e. g.::
> > +To prevent zswap from rejecting new pages and incurring latency when z=
swap is
> > +full, zswap initiates a worker called global shrinker that proactively=
 evicts
> > +some pages from the pool to swap devices while the pool is reaching th=
e limit.
> > +The global shrinker continues to evict pages until there is sufficient=
 space to
> > +accept new pages. To control how many pages should remain in the pool,=
 use the
> > +sysfs ``accept_threshold_percent`` attribute as a percentage of the ma=
x pool
> > +size, e. g.::
> >
> >         echo 80 > /sys/module/zswap/parameters/accept_threshold_percent
> >
> > -Setting this parameter to 100 will disable the hysteresis.
> > +Setting this parameter to 100 will disable the proactive shrinking.
> >
> >  Some users cannot tolerate the swapping that comes with zswap store fa=
ilures
> >  and zswap writebacks. Swapping can be disabled entirely (without disab=
ling
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 08a6f5a6bf62..0186224be8fc 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -71,8 +71,6 @@ static u64 zswap_reject_kmemcache_fail;
> >
> >  /* Shrinker work queue */
> >  static struct workqueue_struct *shrink_wq;
> > -/* Pool limit was hit, we need to calm down */
> > -static bool zswap_pool_reached_full;
> >
> >  /*********************************
> >  * tunables
> > @@ -118,7 +116,10 @@ module_param_cb(zpool, &zswap_zpool_param_ops, &zs=
wap_zpool_type, 0644);
> >  static unsigned int zswap_max_pool_percent =3D 20;
> >  module_param_named(max_pool_percent, zswap_max_pool_percent, uint, 064=
4);
> >
> > -/* The threshold for accepting new pages after the max_pool_percent wa=
s hit */
> > +/*
> > + * The percentage of pool size that the global shrinker keeps in memor=
y.
> > + * It does not protect old pages from the dynamic shrinker.
> > + */
> >  static unsigned int zswap_accept_thr_percent =3D 90; /* of max pool si=
ze */
> >  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
> >                    uint, 0644);
> > @@ -487,6 +488,14 @@ static unsigned long zswap_accept_thr_pages(void)
> >         return zswap_max_pages() * zswap_accept_thr_percent / 100;
> >  }
> >
> > +/*
> > + * Returns threshold to start proactive global shrinking.
> > + */
> > +static inline unsigned long zswap_shrink_start_pages(void)
> > +{
> > +       return zswap_max_pages() * (100 - (100 - zswap_accept_thr_perce=
nt)/2) / 100;
> > +}
> > +
> >  unsigned long zswap_total_pages(void)
> >  {
> >         struct zswap_pool *pool;
> > @@ -504,21 +513,6 @@ unsigned long zswap_total_pages(void)
> >         return total;
> >  }
> >
> > -static bool zswap_check_limits(void)
> > -{
> > -       unsigned long cur_pages =3D zswap_total_pages();
> > -       unsigned long max_pages =3D zswap_max_pages();
> > -
> > -       if (cur_pages >=3D max_pages) {
> > -               zswap_pool_limit_hit++;
> > -               zswap_pool_reached_full =3D true;
> > -       } else if (zswap_pool_reached_full &&
> > -                  cur_pages <=3D zswap_accept_thr_pages()) {
> > -                       zswap_pool_reached_full =3D false;
> > -       }
> > -       return zswap_pool_reached_full;
> > -}
> > -
> >  /*********************************
> >  * param callbacks
> >  **********************************/
> > @@ -1475,6 +1469,8 @@ bool zswap_store(struct folio *folio)
> >         struct obj_cgroup *objcg =3D NULL;
> >         struct mem_cgroup *memcg =3D NULL;
> >         unsigned long value;
> > +       unsigned long cur_pages;
> > +       bool need_global_shrink =3D false;
> >
> >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > @@ -1497,8 +1493,18 @@ bool zswap_store(struct folio *folio)
> >                 mem_cgroup_put(memcg);
> >         }
> >
> > -       if (zswap_check_limits())
> > +       cur_pages =3D zswap_total_pages();
> > +
> > +       if (cur_pages >=3D zswap_max_pages()) {
> > +               zswap_pool_limit_hit++;
> > +               need_global_shrink =3D true;
> >                 goto reject;
> > +       }
> > +
> > +       /* schedule shrink for incoming pages */
> > +       if (cur_pages >=3D zswap_shrink_start_pages()
> > +                       && !work_pending(&zswap_shrink_work))
> > +               queue_work(shrink_wq, &zswap_shrink_work);
>
> I think work_pending() check here is redundant. If you look at the
> documentation, queue_work only succeeds if zswap_shrink_work is not
> already on the shrink_wq workqueue.
>
> More specifically, if you check the code, queue_work calls
> queue_work_on, which has this check:
>
> if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
>    !clear_pending_if_disabled(work)) {
>
> This is the same bit-check as work_pending, which is defined as:
>
> #define work_pending(work) \
> test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))
>

Thanks for the review and info. I will remove the tests.

>
> >
> >         /* allocate entry */
> >         entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio))=
;
> > @@ -1541,6 +1547,9 @@ bool zswap_store(struct folio *folio)
> >
> >                 WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %=
d\n", err);
> >                 zswap_reject_alloc_fail++;
> > +
> > +               /* reduce entry in array */
> > +               need_global_shrink =3D true;
> >                 goto store_failed;
> >         }
> >
> > @@ -1590,7 +1599,7 @@ bool zswap_store(struct folio *folio)
> >         zswap_entry_cache_free(entry);
> >  reject:
> >         obj_cgroup_put(objcg);
> > -       if (zswap_pool_reached_full)
> > +       if (need_global_shrink && !work_pending(&zswap_shrink_work))
> >                 queue_work(shrink_wq, &zswap_shrink_work);
> >  check_old:
> >         /*
> > --
> > 2.43.0
> >



--=20

<flintglass@gmail.com>

