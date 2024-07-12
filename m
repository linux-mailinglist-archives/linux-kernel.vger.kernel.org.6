Return-Path: <linux-kernel+bounces-250628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B576D92FA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C699B20FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E615A4B3;
	Fri, 12 Jul 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrvLZYx5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC916DC1A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720786992; cv=none; b=LDXLPEbLAWW5S0urpDUou3ysY1IiUd1vnoSolj1p8jFGWoX+GxxYGcUqNGVHUsHa1cLhSbcKcetNpjvQxDw30Dfn0GFLE0817Copf0Gq26PJh1eGQ76fq36E7hSKjQkE5vmm9kgjhilaIDbYotksFaVnVyt1MOjtpAR2zE2cLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720786992; c=relaxed/simple;
	bh=ZtcHQEe0A9zHVpoW+FsGz9VSWGJS97Ll1hGO+heG+BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KL2lKpWOUxb8wUcILsRyizTk+K1U0B+G7ZrYEiMRbs3Nb2lXoqCYfWFiwu4lYkzn+WNJ+r5jL7DUfvEGymaf28KFtvR1azBU+JZC5XqYSoeP/0eTkJOjoQowK08O41eEZF7Puu+hU0HQdh77dMNweWmWSjT7RsQEYRlMZULJzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrvLZYx5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso264356866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720786988; x=1721391788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhiqbETTWcozFlAHDLKTjrYIwdph/hMIshsUTKEoalA=;
        b=VrvLZYx5mGy3t9tRJTmiYzU5lsT+1mNrc7pKZ1qxFjeWgzVsKCUIPai2BgK36lvcIX
         wOXJ3EjUgIt2/ZE8pkV2BpnJv4qHYxQHvLaYr8Og1T5NyD8Fx+DA1uzFAdZLhu5ZUrA0
         EhadtVDHKck5aVkWbrU4JiVFmTRTQ7m/925xrm987czTH+TKzhnfidSne6smsH4LIIa0
         HHQwCpZSObiwSrCQPatFGMC9wpug/N2zD9ADUdYfS3kjHvsDPJM5iZnTtMZ6tLaPEJVL
         GLhHPMdy7i1u7HmxCsQ+LlBeCt9h2Xqo6U35ecTZkHDj5fHCvMSw2Lg9e+ET+4P1GVSw
         7Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720786988; x=1721391788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhiqbETTWcozFlAHDLKTjrYIwdph/hMIshsUTKEoalA=;
        b=qVslcGpkn7qejblcBQR5VuU2ST1JWKXPJ0w0X56n8hyTUgVWtgwFbNKxbWBGWURdNZ
         ctUyjQZBXJ3VsCRw5Go4+gFK4u2Fcp2YpUF6ZA73dWC2cPuvsueTxgf3IEujeAfsgYND
         zRxmZYVsg0YcpoaTb0an8ZYo9Rv1/l9Gt+XoUlWLNHBbBH+irURz3aRTtB1eJfKHUvOF
         1ay9jpKT+K8I5lnGW8Ti/p4BzhmCBpxgO6OxSR8hD3opHB0kv4Z0zTIprPGfKSvH0WyH
         xlI1BPnj9t2jbqbL53fuPYBucCzENtk/rFcG+ps0LRNL6X21fZS5Bw+CB/wg07cTDpla
         KIlw==
X-Forwarded-Encrypted: i=1; AJvYcCW86qEkzReYcweRSDqNkH0YEUsiRVpOSOs5wXM5SSWKvE6lXgrYEOd3cm8KD3l0ju/xye+zg3CZNNe8Sdzw9p1WFpjhcVdzc1hGMNQF
X-Gm-Message-State: AOJu0Yxn7ZJwJwQHrrkVubfw2fdyazN9JE4NtCMJjeFilZZDHU90uk7x
	7IFcC4CEDDxJLO+DbLku24u/ZR0iMrPynhcfvaEip8XGDzc0MmmW/U6GtGf0CYVzISkFwpnYVg5
	RmObDkvHFSq2pomRHLyGPwIub50k=
X-Google-Smtp-Source: AGHT+IHkOtgqIhIlCaHcSo2ryZ6N4ZdnSfcLbIKs8ZFt8VhICo+9fJSIFftbg5sv3pHkujmCn1wSYNnfKnZMSZcOtg4=
X-Received: by 2002:a17:906:6c93:b0:a75:2387:7801 with SMTP id
 a640c23a62f3a-a780b885f65mr646392566b.61.1720786988213; Fri, 12 Jul 2024
 05:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
 <20240711072929.3590000-3-ryan.roberts@arm.com> <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
In-Reply-To: <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 12 Jul 2024 20:22:31 +0800
Message-ID: <CAK1f24nCDZM8aa9z_ZtgLbdj695JJri01q2HJUJb9pJt2uqy=w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 11:00=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/7/11 15:29, Ryan Roberts wrote:
> > Expose 3 new mTHP stats for file (pagecache) folio allocations:
> >
> >    /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_alloc
> >    /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallbac=
k
> >    /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallbac=
k_charge
> >
> > This will provide some insight on the sizes of large folios being
> > allocated for file-backed memory, and how often allocation is failing.
> >
> > All non-order-0 (and most order-0) folio allocations are currently done
> > through filemap_alloc_folio(), and folios are charged in a subsequent
> > call to filemap_add_folio(). So count file_fallback when allocation
> > fails in filemap_alloc_folio() and count file_alloc or
> > file_fallback_charge in filemap_add_folio(), based on whether charging
> > succeeded or not. There are some users of filemap_add_folio() that
> > allocate their own order-0 folio by other means, so we would not count
> > an allocation failure in this case, but we also don't care about order-=
0
> > allocations. This approach feels like it should be good enough and
> > doesn't require any (impractically large) refactoring.
> >
> > The existing mTHP stats interface is reused to provide consistency to
> > users. And because we are reusing the same interface, we can reuse the
> > same infrastructure on the kernel side. The one small wrinkle is that
> > the set of folio sizes supported by the pagecache are not identical to
> > those supported by anon and shmem; pagecache supports order-1, unlike
> > anon and shmem, and the max pagecache order may be less than PMD-size
> > (see arm64 with 64K base pages), again unlike anon and shmem. So we now
> > create a hugepages-*kB directory for the union of the sizes supported b=
y
> > all 3 memory types and populate it with the relevant stats and controls=
.
>
> Personally, I like the idea that can help analyze the allocation of
> large folios for the page cache.
>
> However, I have a slight concern about the consistency of the interface.
>
> For 64K, the fields layout:
> =E2=94=9C=E2=94=80=E2=94=80 hugepages-64kB
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 enabled
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 shmem_enabled
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 stats
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 anon_fault_alloc
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 anon_fault_fallback
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 anon_fault_fallback_charge
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 file_alloc
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 file_fallback
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 file_fallback_charge
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 shmem_alloc
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 shmem_fallback
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 shmem_fallback_charge
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 split
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 split_deferred
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 split_failed
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 swpout
> =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 swpout_fallback
>
> But for 8K (for pagecache), you removed some fields (of course, I
> understand why they are not supported).
>
> =E2=94=9C=E2=94=80=E2=94=80 hugepages-8kB
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 stats
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 file_alloc
> =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 file_fallback
> =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 file_fallback_charge
>
> This might not be user-friendly for some user-space parsing tools, as
> they lack certain fields for the same pattern interfaces. Of course,
> this might not be an issue if we have clear documentation describing the
> differences here:)
>
> Another possible approach is to maintain the same field layout to keep
> consistent, but prohibit writing to the fields that are not supported by
> the pagecache, and any stats read from them would be 0.

I agree that maintaining a uniform field layout, especially at the stats
level, might be necessary ;)

Keeping a consistent interface could future-proof the design. It allows
for the possibility that features not currently supported for 8kB pages
might be enabled in the future.

Anyway, like David said, it's always tough messing with such stuff ;p

Thanks,
Lance

>
>
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >   Documentation/admin-guide/mm/transhuge.rst |  13 +++
> >   include/linux/huge_mm.h                    |   6 +-
> >   include/linux/pagemap.h                    |  17 ++-
> >   mm/filemap.c                               |   6 +-
> >   mm/huge_memory.c                           | 117 ++++++++++++++++----=
-
> >   5 files changed, 128 insertions(+), 31 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 058485daf186..d4857e457add 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -512,6 +512,19 @@ shmem_fallback_charge
> >       falls back to using small pages even though the allocation was
> >       successful.
> >
> > +file_alloc
> > +     is incremented every time a file huge page is successfully
> > +     allocated.
> > +
> > +file_fallback
> > +     is incremented if a file huge page is attempted to be allocated
> > +     but fails and instead falls back to using small pages.
> > +
> > +file_fallback_charge
> > +     is incremented if a file huge page cannot be charged and instead
> > +     falls back to using small pages even though the allocation was
> > +     successful.
> > +
> >   split
> >       is incremented every time a huge page is successfully split into
> >       smaller orders. This can happen for a variety of reasons but a
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index cb93b9009ce4..b4fba11976f2 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -117,6 +117,9 @@ enum mthp_stat_item {
> >       MTHP_STAT_SHMEM_ALLOC,
> >       MTHP_STAT_SHMEM_FALLBACK,
> >       MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> > +     MTHP_STAT_FILE_ALLOC,
> > +     MTHP_STAT_FILE_FALLBACK,
> > +     MTHP_STAT_FILE_FALLBACK_CHARGE,
> >       MTHP_STAT_SPLIT,
> >       MTHP_STAT_SPLIT_FAILED,
> >       MTHP_STAT_SPLIT_DEFERRED,
> > @@ -292,11 +295,10 @@ unsigned long thp_vma_allowable_orders(struct vm_=
area_struct *vma,
> >
> >   struct thpsize {
> >       struct kobject kobj;
> > -     struct list_head node;
> >       int order;
> >   };
> >
> > -#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
> > +#define to_thpsize(_kobj) container_of(_kobj, struct thpsize, kobj)
> >
> >   #define transparent_hugepage_use_zero_page()                         =
       \
> >       (transparent_hugepage_flags &                                   \
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 6e2f72d03176..f45a1ba6d9b6 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -365,6 +365,7 @@ static inline void mapping_set_gfp_mask(struct addr=
ess_space *m, gfp_t mask)
> >    */
> >   #define MAX_XAS_ORDER               (XA_CHUNK_SHIFT * 2 - 1)
> >   #define MAX_PAGECACHE_ORDER min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACH=
E_ORDER)
> > +#define PAGECACHE_LARGE_ORDERS       ((BIT(MAX_PAGECACHE_ORDER + 1) - =
1) & ~BIT(0))
> >
> >   /**
> >    * mapping_set_large_folios() - Indicate the file supports large foli=
os.
> > @@ -562,14 +563,26 @@ static inline void *detach_page_private(struct pa=
ge *page)
> >   }
> >
> >   #ifdef CONFIG_NUMA
> > -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order=
);
> > +struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int ord=
er);
> >   #else
> > -static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsi=
gned int order)
> > +static inline struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, un=
signed int order)
> >   {
> >       return folio_alloc_noprof(gfp, order);
> >   }
> >   #endif
> >
> > +static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsi=
gned int order)
> > +{
> > +     struct folio *folio;
> > +
> > +     folio =3D __filemap_alloc_folio_noprof(gfp, order);
> > +
> > +     if (!folio)
> > +             count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
> > +
> > +     return folio;
> > +}
> > +
> >   #define filemap_alloc_folio(...)                            \
> >       alloc_hooks(filemap_alloc_folio_noprof(__VA_ARGS__))
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 53d5d0410b51..131d514fca29 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -963,6 +963,8 @@ int filemap_add_folio(struct address_space *mapping=
, struct folio *folio,
> >       int ret;
> >
> >       ret =3D mem_cgroup_charge(folio, NULL, gfp);
> > +     count_mthp_stat(folio_order(folio),
> > +             ret ? MTHP_STAT_FILE_FALLBACK_CHARGE : MTHP_STAT_FILE_ALL=
OC);
> >       if (ret)
> >               return ret;
> >
> > @@ -990,7 +992,7 @@ int filemap_add_folio(struct address_space *mapping=
, struct folio *folio,
> >   EXPORT_SYMBOL_GPL(filemap_add_folio);
> >
> >   #ifdef CONFIG_NUMA
> > -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order=
)
> > +struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int ord=
er)
> >   {
> >       int n;
> >       struct folio *folio;
> > @@ -1007,7 +1009,7 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gf=
p, unsigned int order)
> >       }
> >       return folio_alloc_noprof(gfp, order);
> >   }
> > -EXPORT_SYMBOL(filemap_alloc_folio_noprof);
> > +EXPORT_SYMBOL(__filemap_alloc_folio_noprof);
> >   #endif
> >
> >   /*
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index f9696c94e211..559553e2a662 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -452,8 +452,9 @@ static const struct attribute_group hugepage_attr_g=
roup =3D {
> >
> >   static void hugepage_exit_sysfs(struct kobject *hugepage_kobj);
> >   static void thpsize_release(struct kobject *kobj);
> > +static void thpsize_child_release(struct kobject *kobj);
> >   static DEFINE_SPINLOCK(huge_anon_orders_lock);
> > -static LIST_HEAD(thpsize_list);
> > +static LIST_HEAD(thpsize_child_list);
> >
> >   static ssize_t thpsize_enabled_show(struct kobject *kobj,
> >                                   struct kobj_attribute *attr, char *bu=
f)
> > @@ -537,6 +538,18 @@ static const struct kobj_type thpsize_ktype =3D {
> >       .sysfs_ops =3D &kobj_sysfs_ops,
> >   };
> >
> > +static const struct kobj_type thpsize_child_ktype =3D {
> > +     .release =3D &thpsize_child_release,
> > +     .sysfs_ops =3D &kobj_sysfs_ops,
> > +};
> > +
> > +struct thpsize_child {
> > +     struct kobject kobj;
> > +     struct list_head node;
> > +};
> > +
> > +#define to_thpsize_child(_kobj) container_of(_kobj, struct thpsize, ko=
bj)
> > +
> >   DEFINE_PER_CPU(struct mthp_stat, mthp_stats) =3D {{{0}}};
> >
> >   static unsigned long sum_mthp_stat(int order, enum mthp_stat_item ite=
m)
> > @@ -557,7 +570,7 @@ static unsigned long sum_mthp_stat(int order, enum =
mthp_stat_item item)
> >   static ssize_t _name##_show(struct kobject *kobj,                   \
> >                       struct kobj_attribute *attr, char *buf)         \
> >   {                                                                   \
> > -     int order =3D to_thpsize(kobj)->order;                           =
 \
> > +     int order =3D to_thpsize(kobj->parent)->order;                   =
 \
> >                                                                       \
> >       return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));  \
> >   }                                                                   \
> > @@ -591,41 +604,93 @@ static struct attribute *stats_attrs[] =3D {
> >   };
> >
> >   static struct attribute_group stats_attr_group =3D {
> > -     .name =3D "stats",
> >       .attrs =3D stats_attrs,
> >   };
> >
> > -static struct thpsize *thpsize_create(int order, struct kobject *paren=
t)
> > +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> > +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> > +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CH=
ARGE);
> > +
> > +static struct attribute *file_stats_attrs[] =3D {
> > +     &file_alloc_attr.attr,
> > +     &file_fallback_attr.attr,
> > +     &file_fallback_charge_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group file_stats_attr_group =3D {
> > +     .attrs =3D file_stats_attrs,
> > +};
> > +
> > +static int thpsize_create(int order, struct kobject *parent)
> >   {
> >       unsigned long size =3D (PAGE_SIZE << order) / SZ_1K;
> > +     struct thpsize_child *stats;
> >       struct thpsize *thpsize;
> >       int ret;
> >
> > +     /*
> > +      * Each child object (currently only "stats" directory) holds a
> > +      * reference to the top-level thpsize object, so we can drop our =
ref to
> > +      * the top-level once stats is setup. Then we just need to drop a
> > +      * reference on any children to clean everything up. We can't jus=
t use
> > +      * the attr group name for the stats subdirectory because there m=
ay be
> > +      * multiple attribute groups to populate inside stats and overlay=
ing
> > +      * using the name property isn't supported in that way; each attr=
 group
> > +      * name, if provided, must be unique in the parent directory.
> > +      */
> > +
> >       thpsize =3D kzalloc(sizeof(*thpsize), GFP_KERNEL);
> > -     if (!thpsize)
> > -             return ERR_PTR(-ENOMEM);
> > +     if (!thpsize) {
> > +             ret =3D -ENOMEM;
> > +             goto err;
> > +     }
> > +     thpsize->order =3D order;
> >
> >       ret =3D kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, pare=
nt,
> >                                  "hugepages-%lukB", size);
> >       if (ret) {
> >               kfree(thpsize);
> > -             return ERR_PTR(ret);
> > +             goto err;
> >       }
> >
> > -     ret =3D sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
> > -     if (ret) {
> > +     stats =3D kzalloc(sizeof(*stats), GFP_KERNEL);
> > +     if (!stats) {
> >               kobject_put(&thpsize->kobj);
> > -             return ERR_PTR(ret);
> > +             ret =3D -ENOMEM;
> > +             goto err;
> >       }
> >
> > -     ret =3D sysfs_create_group(&thpsize->kobj, &stats_attr_group);
> > +     ret =3D kobject_init_and_add(&stats->kobj, &thpsize_child_ktype,
> > +                                &thpsize->kobj, "stats");
> > +     kobject_put(&thpsize->kobj);
> >       if (ret) {
> > -             kobject_put(&thpsize->kobj);
> > -             return ERR_PTR(ret);
> > +             kfree(stats);
> > +             goto err;
> >       }
> >
> > -     thpsize->order =3D order;
> > -     return thpsize;
> > +     if (BIT(order) & THP_ORDERS_ALL_ANON) {
> > +             ret =3D sysfs_create_group(&thpsize->kobj, &thpsize_attr_=
group);
> > +             if (ret)
> > +                     goto err_put;
> > +
> > +             ret =3D sysfs_create_group(&stats->kobj, &stats_attr_grou=
p);
> > +             if (ret)
> > +                     goto err_put;
> > +     }
> > +
> > +     if (BIT(order) & PAGECACHE_LARGE_ORDERS) {
> > +             ret =3D sysfs_create_group(&stats->kobj, &file_stats_attr=
_group);
> > +             if (ret)
> > +                     goto err_put;
> > +     }
> > +
> > +     list_add(&stats->node, &thpsize_child_list);
> > +     return 0;
> > +err_put:
>
> IIUC, I think you should call 'sysfs_remove_group' to remove the group
> before putting the kobject.
>
> > +     kobject_put(&stats->kobj);
> > +err:
> > +     return ret;
> >   }
> >
> >   static void thpsize_release(struct kobject *kobj)
> > @@ -633,10 +698,14 @@ static void thpsize_release(struct kobject *kobj)
> >       kfree(to_thpsize(kobj));
> >   }
> >
> > +static void thpsize_child_release(struct kobject *kobj)
> > +{
> > +     kfree(to_thpsize_child(kobj));
> > +}
> > +
> >   static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
> >   {
> >       int err;
> > -     struct thpsize *thpsize;
> >       unsigned long orders;
> >       int order;
> >
> > @@ -665,16 +734,14 @@ static int __init hugepage_init_sysfs(struct kobj=
ect **hugepage_kobj)
> >               goto remove_hp_group;
> >       }
> >
> > -     orders =3D THP_ORDERS_ALL_ANON;
> > +     orders =3D THP_ORDERS_ALL_ANON | PAGECACHE_LARGE_ORDERS;
> >       order =3D highest_order(orders);
> >       while (orders) {
> > -             thpsize =3D thpsize_create(order, *hugepage_kobj);
> > -             if (IS_ERR(thpsize)) {
> > +             err =3D thpsize_create(order, *hugepage_kobj);
> > +             if (err) {
> >                       pr_err("failed to create thpsize for order %d\n",=
 order);
> > -                     err =3D PTR_ERR(thpsize);
> >                       goto remove_all;
> >               }
> > -             list_add(&thpsize->node, &thpsize_list);
> >               order =3D next_order(&orders, order);
> >       }
> >
> > @@ -692,11 +759,11 @@ static int __init hugepage_init_sysfs(struct kobj=
ect **hugepage_kobj)
> >
> >   static void __init hugepage_exit_sysfs(struct kobject *hugepage_kobj)
> >   {
> > -     struct thpsize *thpsize, *tmp;
> > +     struct thpsize_child *child, *tmp;
> >
> > -     list_for_each_entry_safe(thpsize, tmp, &thpsize_list, node) {
> > -             list_del(&thpsize->node);
> > -             kobject_put(&thpsize->kobj);
> > +     list_for_each_entry_safe(child, tmp, &thpsize_child_list, node) {
> > +             list_del(&child->node);
> > +             kobject_put(&child->kobj);
> >       }
> >
> >       sysfs_remove_group(hugepage_kobj, &khugepaged_attr_group);

