Return-Path: <linux-kernel+bounces-280180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D6A94C6D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F75285472
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54EE15ECF9;
	Thu,  8 Aug 2024 22:11:58 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CE55769
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155117; cv=none; b=qzBRc/Mh7AlHRPcVHu6cG1QpMPMeaVviam7+QKIGmV/kuOO3hZNyYQ+ywjGJVu8BOMr0YUK8Wf3tt8qekeiRFCrFeG/nlno0dE2vpDimxrs5Jeoaax4GSV7J5+CcS208FKaInqBwKLjm0+WqtIiqB1aJZGMjL5FiGBySCdqBuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155117; c=relaxed/simple;
	bh=j5ZxBWJJcT/KEkUUXEuzzf4IFxOJ6k0P39rHR74PyDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJXx/nrQ7b8txZCH5n/V1L4VgvKq2YG/48ylGpnuf23ySf95gtWKhJdoGXehgOWa3jp9hXPw3s6evKXhL8m55AxnM0h9xxKw0SRiMuc41AN5Rw+njbct2v/FiTmOZ/YI3Ood8CQhZm4ds7if+uA/YPdxboSAj5wpfH+KIoFdgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so493415241.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 15:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723155115; x=1723759915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0VjPC9FhICDRukaHcLj0OuE5d0VlKMg+AXegZg76cI=;
        b=C+6ftWhii1SxPtYPkJVGEOQDUK495xzH9tn+a29B+luzm6B8tVtZ37Fc9B8R10gq3o
         sXWZhBda0SnfJ/WTbDIYuluPAMIjZWMO+HkFzYYKb6v5hPzfaLzksHXsrVIvRwbCs9zu
         MaxmYva3I4eV7ekwXoO1sHBm6xnXWQdqrcQyC4JvkGKuPFbkuIYJOjQBbqwwSEScEd6M
         Dhl5FP3PBug8WE0DzhGEv7/mURGCXC3ir17wpDQM/vvWACM0dmesT5J/qGgeLWWchPqT
         wonpe3smy37jKubmfRm07/PGsnsyo5UwT7LKuRsW0ULYhvyNBEgKY3SwF/A0BCoLV0aW
         vJkA==
X-Forwarded-Encrypted: i=1; AJvYcCUJuDfZEFXAZ7biH+evKnXANwJb1/hw2MPQh10VxbJX+BDw3mJrs7tGm38aOLaI/qdgzmwR65bdYz4oFuUJ4C6zWa69jSkPXIlqQnWW
X-Gm-Message-State: AOJu0YwXbtHHEsvWWyN+7037jylZUEvG3IzWMo5VLIxkL54WLMnROwUJ
	7UDRLk+e8HYzSBFyWRq3dPtbcNZSLY1Ay3ysVWclTswu68tfIFyUPaN5tdrvF6/ye6rVhrm1f5W
	uCpMwMMzqZ4f7VAr5dVATZPjosms=
X-Google-Smtp-Source: AGHT+IHPaKSdrM0O/hqKxQX/iOh6yuNaoANYQr82wyOoBbu+7s0YIuhHpgIiWmK60c1tIzkI76WYu0fnyl2XoRyA7qw=
X-Received: by 2002:a05:6122:3088:b0:4f5:1363:845b with SMTP id
 71dfb90a1353d-4f9027ba8c3mr3981314e0c.9.1723155114874; Thu, 08 Aug 2024
 15:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808111849.651867-1-ryan.roberts@arm.com> <20240808111849.651867-3-ryan.roberts@arm.com>
In-Reply-To: <20240808111849.651867-3-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 9 Aug 2024 10:11:43 +1200
Message-ID: <CAGsJ_4w8HAUVFt-hR5CNmgDEgwBv0M3kMyMXAL6esVbL9q3yKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: Tidy up shmem mTHP controls and stats
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 11:19=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Previously we had a situation where shmem mTHP controls and stats were
> not exposed for some supported sizes and were exposed for some
> unsupported sizes. So let's clean that up.
>
> Anon mTHP can support all large orders [2, PMD_ORDER]. But shmem can
> support all large orders [1, MAX_PAGECACHE_ORDER]. However, per-size
> shmem controls and stats were previously being exposed for all the anon
> mTHP orders, meaning order-1 was not present, and for arm64 64K base
> pages, orders 12 and 13 were exposed but were not supported internally.
>
> Tidy this all up by defining ctrl and stats attribute groups for anon
> and file separately. Anon ctrl and stats groups are populated for all
> orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
> populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.
>
> Additionally, create "any" ctrl and stats attribute groups which are
> populated for all orders in (THP_ORDERS_ALL_ANON |
> THP_ORDERS_ALL_FILE_DEFAULT). swpout stats use this since they apply to
> anon and shmem.

This passage is a bit confusing to me. I'm not sure whether it's about
creating any control and stats for both file and anon, or creating them
separately depending on the situation. However, the previous passage
mentions that file and anon create control and stats separately based
on different orders, and the orders they create might differ.

But after running your patches, I understood it. For instance, I'm now
seeing 8kB folder that didn't exist before:

           /sys/kernel/mm/transparent_hugepage # ls -l
           drwxr-xr-x 3 root root    0 Aug  8 22:01 hugepages-1024kB
            ...
           drwxr-xr-x 3 root root    0 Aug  8 22:01 hugepages-8kB
           drwxr-xr-x 2 root root    0 Aug  8 22:01 khugepaged
           ...

Then, when I entered the 8kB folder, I found 'shmem_enabled'
but not 'enabled' for anon:
            /sys/kernel/mm/transparent_hugepage/hugepages-8kB # ls
            shmem_enabled  stats

However, in the 16kB folder, I found both:
            /sys/kernel/mm/transparent_hugepage/hugepages-16kB # ls
            enabled  shmem_enabled stats

In the 8kB 'stats,' I see 'shmem_alloc' but not 'anon_alloc.' Since
both shmem and anon require swapout, I am seeing 'swpout' and
'swpout_fallback':

            /sys/kernel/mm/transparent_hugepage/hugepages-8kB/stats # ls
            shmem_alloc  shmem_fallback  shmem_fallback_charge  swpout
 swpout_fallback

Everything observed seems to meet expectations, so:

Tested-by: Barry Song <baohua@kernel.org>

>
> The side-effect of all this is that different hugepage-*kB directories
> contain different sets of controls and stats, depending on which memory
> types support that size. This approach is preferred over the
> alternative, which is to populate dummy controls and stats for memory
> types that do not support a given size.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/huge_memory.c | 144 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 114 insertions(+), 30 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0c3075ee00012..082d86b7c6c2f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -482,8 +482,8 @@ static void thpsize_release(struct kobject *kobj);
>  static DEFINE_SPINLOCK(huge_anon_orders_lock);
>  static LIST_HEAD(thpsize_list);
>
> -static ssize_t thpsize_enabled_show(struct kobject *kobj,
> -                                   struct kobj_attribute *attr, char *bu=
f)
> +static ssize_t anon_enabled_show(struct kobject *kobj,
> +                                struct kobj_attribute *attr, char *buf)
>  {
>         int order =3D to_thpsize(kobj)->order;
>         const char *output;
> @@ -500,9 +500,9 @@ static ssize_t thpsize_enabled_show(struct kobject *k=
obj,
>         return sysfs_emit(buf, "%s\n", output);
>  }
>
> -static ssize_t thpsize_enabled_store(struct kobject *kobj,
> -                                    struct kobj_attribute *attr,
> -                                    const char *buf, size_t count)
> +static ssize_t anon_enabled_store(struct kobject *kobj,
> +                                 struct kobj_attribute *attr,
> +                                 const char *buf, size_t count)
>  {
>         int order =3D to_thpsize(kobj)->order;
>         ssize_t ret =3D count;
> @@ -544,19 +544,35 @@ static ssize_t thpsize_enabled_store(struct kobject=
 *kobj,
>         return ret;
>  }
>
> -static struct kobj_attribute thpsize_enabled_attr =3D
> -       __ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_store=
);
> +static struct kobj_attribute anon_enabled_attr =3D
> +       __ATTR(enabled, 0644, anon_enabled_show, anon_enabled_store);
>
> -static struct attribute *thpsize_attrs[] =3D {
> -       &thpsize_enabled_attr.attr,
> +static struct attribute *anon_ctrl_attrs[] =3D {
> +       &anon_enabled_attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group anon_ctrl_attr_grp =3D {
> +       .attrs =3D anon_ctrl_attrs,
> +};
> +
> +static struct attribute *file_ctrl_attrs[] =3D {
>  #ifdef CONFIG_SHMEM
>         &thpsize_shmem_enabled_attr.attr,
>  #endif
>         NULL,
>  };
>
> -static const struct attribute_group thpsize_attr_group =3D {
> -       .attrs =3D thpsize_attrs,
> +static const struct attribute_group file_ctrl_attr_grp =3D {
> +       .attrs =3D file_ctrl_attrs,
> +};
> +
> +static struct attribute *any_ctrl_attrs[] =3D {
> +       NULL,
> +};
> +
> +static const struct attribute_group any_ctrl_attr_grp =3D {
> +       .attrs =3D any_ctrl_attrs,
>  };
>
>  static const struct kobj_type thpsize_ktype =3D {
> @@ -595,64 +611,132 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_ST=
AT_ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> +#ifdef CONFIG_SHMEM
>  DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CH=
ARGE);
> +#endif
>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>
> -static struct attribute *stats_attrs[] =3D {
> +static struct attribute *anon_stats_attrs[] =3D {
>         &anon_fault_alloc_attr.attr,
>         &anon_fault_fallback_attr.attr,
>         &anon_fault_fallback_charge_attr.attr,
> +#ifndef CONFIG_SHMEM
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
> -       &shmem_alloc_attr.attr,
> -       &shmem_fallback_attr.attr,
> -       &shmem_fallback_charge_attr.attr,
> +#endif
>         &split_attr.attr,
>         &split_failed_attr.attr,
>         &split_deferred_attr.attr,
>         NULL,
>  };
>
> -static struct attribute_group stats_attr_group =3D {
> +static struct attribute_group anon_stats_attr_grp =3D {
> +       .name =3D "stats",
> +       .attrs =3D anon_stats_attrs,
> +};
> +
> +static struct attribute *file_stats_attrs[] =3D {
> +#ifdef CONFIG_SHMEM
> +       &shmem_alloc_attr.attr,
> +       &shmem_fallback_attr.attr,
> +       &shmem_fallback_charge_attr.attr,
> +#endif
> +       NULL,
> +};
> +
> +static struct attribute_group file_stats_attr_grp =3D {
> +       .name =3D "stats",
> +       .attrs =3D file_stats_attrs,
> +};
> +
> +static struct attribute *any_stats_attrs[] =3D {
> +#ifdef CONFIG_SHMEM
> +       &swpout_attr.attr,
> +       &swpout_fallback_attr.attr,
> +#endif
> +       NULL,
> +};
> +
> +static struct attribute_group any_stats_attr_grp =3D {
>         .name =3D "stats",
> -       .attrs =3D stats_attrs,
> +       .attrs =3D any_stats_attrs,
>  };
>
> +static int sysfs_add_group(struct kobject *kobj,
> +                          const struct attribute_group *grp)
> +{
> +       int ret =3D -ENOENT;
> +
> +       /*
> +        * If the group is named, try to merge first, assuming the subdir=
ectory
> +        * was already created. This avoids the warning emitted by
> +        * sysfs_create_group() if the directory already exists.
> +        */
> +       if (grp->name)
> +               ret =3D sysfs_merge_group(kobj, grp);
> +       if (ret)
> +               ret =3D sysfs_create_group(kobj, grp);
> +
> +       return ret;
> +}
> +
>  static struct thpsize *thpsize_create(int order, struct kobject *parent)
>  {
>         unsigned long size =3D (PAGE_SIZE << order) / SZ_1K;
>         struct thpsize *thpsize;
> -       int ret;
> +       int ret =3D -ENOMEM;
>
>         thpsize =3D kzalloc(sizeof(*thpsize), GFP_KERNEL);
>         if (!thpsize)
> -               return ERR_PTR(-ENOMEM);
> +               goto err;
> +
> +       thpsize->order =3D order;
>
>         ret =3D kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, pare=
nt,
>                                    "hugepages-%lukB", size);
>         if (ret) {
>                 kfree(thpsize);
> -               return ERR_PTR(ret);
> +               goto err;
>         }
>
> -       ret =3D sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
> -       if (ret) {
> -               kobject_put(&thpsize->kobj);
> -               return ERR_PTR(ret);
> +
> +       ret =3D sysfs_add_group(&thpsize->kobj, &any_ctrl_attr_grp);
> +       if (ret)
> +               goto err_put;
> +
> +       ret =3D sysfs_add_group(&thpsize->kobj, &any_stats_attr_grp);
> +       if (ret)
> +               goto err_put;
> +
> +       if (BIT(order) & THP_ORDERS_ALL_ANON) {
> +               ret =3D sysfs_add_group(&thpsize->kobj, &anon_ctrl_attr_g=
rp);
> +               if (ret)
> +                       goto err_put;
> +
> +               ret =3D sysfs_add_group(&thpsize->kobj, &anon_stats_attr_=
grp);
> +               if (ret)
> +                       goto err_put;
>         }
>
> -       ret =3D sysfs_create_group(&thpsize->kobj, &stats_attr_group);
> -       if (ret) {
> -               kobject_put(&thpsize->kobj);
> -               return ERR_PTR(ret);
> +       if (BIT(order) & THP_ORDERS_ALL_FILE_DEFAULT) {
> +               ret =3D sysfs_add_group(&thpsize->kobj, &file_ctrl_attr_g=
rp);
> +               if (ret)
> +                       goto err_put;
> +
> +               ret =3D sysfs_add_group(&thpsize->kobj, &file_stats_attr_=
grp);
> +               if (ret)
> +                       goto err_put;
>         }
>
> -       thpsize->order =3D order;
>         return thpsize;
> +err_put:
> +       kobject_put(&thpsize->kobj);
> +err:
> +       return ERR_PTR(ret);
>  }
>
>  static void thpsize_release(struct kobject *kobj)
> @@ -692,7 +776,7 @@ static int __init hugepage_init_sysfs(struct kobject =
**hugepage_kobj)
>                 goto remove_hp_group;
>         }
>
> -       orders =3D THP_ORDERS_ALL_ANON;
> +       orders =3D THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE_DEFAULT;
>         order =3D highest_order(orders);
>         while (orders) {
>                 thpsize =3D thpsize_create(order, *hugepage_kobj);
> --
> 2.43.0
>

Thanks
Barry

