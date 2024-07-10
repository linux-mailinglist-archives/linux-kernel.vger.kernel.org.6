Return-Path: <linux-kernel+bounces-247741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02392D3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C5B219C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CE19345F;
	Wed, 10 Jul 2024 14:08:34 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7119309A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620513; cv=none; b=LrNpic0BtBnro7N39e9CVo6JAcpna9o9ppd/DOROfXz65Rz8uKIfu3wY6kgbO3ZAipaVKTV+J1VZyF/GdFBoLoeyhMJSfkIB3G7Ef/Mhiv/md/GgMll6+WQre5McX+Lx0X3p9rZ+O04kECQDFM1WJLzoZDIPrGtZtR7oPjE+Aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620513; c=relaxed/simple;
	bh=HzgJS4tYAjbMx06YjLeQEIBWrZ8Lri4QCWztMcUuZtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTa5cDQ0M+PAs7FT+AZlypOCwm+67FrvNY2vGNwxPxai7v8OGMB23b8VpZbsqX9JStrerub1lZnOMqYrKML8hiz47JMpY0rfX4DZ5rsz6LI6WniclqF1n6W+w8q5kbvzvwoGizuhwvFp2bHeZFyfU0K9U3bLXdnVfVwullepaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9bcb47182so678483b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720620511; x=1721225311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEUae8LL4yTltrn/8LVs2k9hfnmoKZsI7ZDNm1zTbEk=;
        b=bt35Zr8Iomfz93JVlBk7modTCxBKbyCUugWHQ8YTIWxO1EYrEnF/4STAjCBFFbJLJw
         dt+BEt7c1eVLe0sOGNS3q5pqu91odSteIv4uQbF8j8VvJKhIl+tgysvnr/xJzZehsFg+
         WhnKuWdkkAAGkW1f3/scQsZiKjpUW9XKKlg4u4znjLhjuBQ8ftzFqIIP/+bbYCWC5juH
         zKrgmP5luP8Zz1+i7zjHOB4Dz5TGMmJgtQG6VSHAYH+TpaQWJIjxh1DypYSJwC8BDpky
         FDg1kGlxhLVIGfM9J4CGRFLWZ8THg0hw465mRY3bz3wu3PwPzdYd7w60fuuqXLeemZIC
         mDLw==
X-Forwarded-Encrypted: i=1; AJvYcCU6xqh3nm3kmDoB3ccmsLV2AGlz0AJqyEagIzPNbvwI6fIV9dmHt8Jn3xrIgjKeF3PDQQt9aQJC7GV5tW8TIrNCt7jqfkFPO29XqTcB
X-Gm-Message-State: AOJu0YyyVbNpTjdpt/TmSprduBYyhk0YvCO7BzKDrDUV6hkOWY3nLJs5
	qDaL4meOsOeSVu5vnCuJ6+hjkBuq6eiTUIvQV5TNUL+qxQWBwbrEpdR1MbbwHyDgeEeOL4V8Zhc
	P0K8jRM5hcAZ9vwWXPGmU1tvrewI=
X-Google-Smtp-Source: AGHT+IGd7WsiNXVe+9MM6aRnm5OIIEGJUvbHnAWwyCRYxRmj1HUpucvEUd5b+jyo73PS1RpgEj+P4NZNAhPBd9QQDvc=
X-Received: by 2002:a05:6808:128c:b0:3c7:3106:e2e1 with SMTP id
 5614622812f47-3d93bde36acmr7753462b6e.8.1720620510052; Wed, 10 Jul 2024
 07:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710095503.3193901-1-ryan.roberts@arm.com>
In-Reply-To: <20240710095503.3193901-1-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 10 Jul 2024 22:08:18 +0800
Message-ID: <CAGsJ_4xQtV=08qakiyi4kMVQx9aXs+P0FMDiDjq3Lv7vA=nEXA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 5:55=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> The legacy PMD-sized THP counters at /proc/vmstat include
> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
> rather confusingly refer to shmem THP and do not include any other types
> of file pages. This is inconsistent since in most other places in the
> kernel, THP counters are explicitly separated for anon, shmem and file
> flavours. However, we are stuck with it since it constitutes a user ABI.
>
> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
> same "file_" prefix in the names. But in future, we may want to add
> extra stats to cover actual file pages, at which point, it would all
> become very confusing.
>
> So let's take the opportunity to rename these new counters "shmem_"
> before the change makes it upstream and the ABI becomes immutable. While
> we are at it, let's improve the documentation for the legacy counters to
> make it clear that they count shmem pages only.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lance Yang <ioworker0@gmail.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>
> Hi All,
>
> Applies on top of yesterday's mm-unstable (2073cda629a4) and tested with =
mm
> selftests; no regressions observed.
>
> The backstory here is that I'd like to introduce some counters for regula=
r file
> folio allocations to observe how often large folio allocation succeeds, b=
ut
> these shmem counters are named "file" which is going to make things confu=
sing.
> So hoping to solve that before commit 66f44583f9b6 ("mm: shmem: add mTHP
> counters for anonymous shmem") goes upstream (it is currently in mm-stabl=
e).
>
> Changes since v1 [1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   - Updated documentation for existing legacy "file_" counters to make it=
 clear
>     they only count shmem pages.
>
> [1] https://lore.kernel.org/linux-mm/20240708112445.2690631-1-ryan.robert=
s@arm.com/
>
> Thanks,
> Ryan
>
>  Documentation/admin-guide/mm/transhuge.rst | 29 ++++++++++++----------
>  include/linux/huge_mm.h                    |  6 ++---
>  mm/huge_memory.c                           | 12 ++++-----
>  mm/shmem.c                                 |  8 +++---
>  4 files changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 747c811ee8f1..3528daa1f239 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -412,20 +412,23 @@ thp_collapse_alloc_failed
>         the allocation.
>
>  thp_file_alloc
> -       is incremented every time a file huge page is successfully
> -       allocated.
> +       is incremented every time a shmem huge page is successfully
> +       allocated (Note that despite being named after "file", the counte=
r
> +       measures only shmem).
>
>  thp_file_fallback
> -       is incremented if a file huge page is attempted to be allocated
> -       but fails and instead falls back to using small pages.
> +       is incremented if a shmem huge page is attempted to be allocated
> +       but fails and instead falls back to using small pages. (Note that
> +       despite being named after "file", the counter measures only shmem=
).
>
>  thp_file_fallback_charge
> -       is incremented if a file huge page cannot be charged and instead
> +       is incremented if a shmem huge page cannot be charged and instead
>         falls back to using small pages even though the allocation was
> -       successful.
> +       successful. (Note that despite being named after "file", the
> +       counter measures only shmem).
>
>  thp_file_mapped
> -       is incremented every time a file huge page is mapped into
> +       is incremented every time a file or shmem huge page is mapped int=
o
>         user address space.
>
>  thp_split_page
> @@ -496,16 +499,16 @@ swpout_fallback
>         Usually because failed to allocate some continuous swap space
>         for the huge page.
>
> -file_alloc
> -       is incremented every time a file huge page is successfully
> +shmem_alloc
> +       is incremented every time a shmem huge page is successfully
>         allocated.
>
> -file_fallback
> -       is incremented if a file huge page is attempted to be allocated
> +shmem_fallback
> +       is incremented if a shmem huge page is attempted to be allocated
>         but fails and instead falls back to using small pages.
>
> -file_fallback_charge
> -       is incremented if a file huge page cannot be charged and instead
> +shmem_fallback_charge
> +       is incremented if a shmem huge page cannot be charged and instead
>         falls back to using small pages even though the allocation was
>         successful.
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index acb6ac24a07e..cff002be83eb 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -269,9 +269,9 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>         MTHP_STAT_SWPOUT,
>         MTHP_STAT_SWPOUT_FALLBACK,
> -       MTHP_STAT_FILE_ALLOC,
> -       MTHP_STAT_FILE_FALLBACK,
> -       MTHP_STAT_FILE_FALLBACK_CHARGE,
> +       MTHP_STAT_SHMEM_ALLOC,
> +       MTHP_STAT_SHMEM_FALLBACK,
> +       MTHP_STAT_SHMEM_FALLBACK_CHARGE,
>         MTHP_STAT_SPLIT,
>         MTHP_STAT_SPLIT_FAILED,
>         MTHP_STAT_SPLIT_DEFERRED,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9ec64aa2be94..f9696c94e211 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -568,9 +568,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_=
ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> -DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> -DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> -DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHAR=
GE);
> +DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CH=
ARGE);
>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> @@ -581,9 +581,9 @@ static struct attribute *stats_attrs[] =3D {
>         &anon_fault_fallback_charge_attr.attr,
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
> -       &file_alloc_attr.attr,
> -       &file_fallback_attr.attr,
> -       &file_fallback_charge_attr.attr,
> +       &shmem_alloc_attr.attr,
> +       &shmem_fallback_attr.attr,
> +       &shmem_fallback_charge_attr.attr,
>         &split_attr.attr,
>         &split_failed_attr.attr,
>         &split_deferred_attr.attr,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 921d59c3d669..f24dfbd387ba 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1777,7 +1777,7 @@ static struct folio *shmem_alloc_and_add_folio(stru=
ct vm_fault *vmf,
>                         if (pages =3D=3D HPAGE_PMD_NR)
>                                 count_vm_event(THP_FILE_FALLBACK);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
> +                       count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
>  #endif
>                         order =3D next_order(&suitable_orders, order);
>                 }
> @@ -1804,8 +1804,8 @@ static struct folio *shmem_alloc_and_add_folio(stru=
ct vm_fault *vmf,
>                                 count_vm_event(THP_FILE_FALLBACK_CHARGE);
>                         }
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FIL=
E_FALLBACK);
> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FIL=
E_FALLBACK_CHARGE);
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHM=
EM_FALLBACK);
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHM=
EM_FALLBACK_CHARGE);
>  #endif
>                 }
>                 goto unlock;
> @@ -2181,7 +2181,7 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>                         if (folio_test_pmd_mappable(folio))
>                                 count_vm_event(THP_FILE_ALLOC);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FIL=
E_ALLOC);
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHM=
EM_ALLOC);
>  #endif
>                         goto alloced;
>                 }
> --
> 2.43.0
>
Thanks
Barry

