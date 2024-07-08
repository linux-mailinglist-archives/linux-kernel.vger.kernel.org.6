Return-Path: <linux-kernel+bounces-244234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFDD92A14A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E03B28238A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101482B9D4;
	Mon,  8 Jul 2024 11:36:46 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286C101E2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438605; cv=none; b=EG5saoIBCvlZllDak5t275FmWuayO2jXcLPvAfCpwqCaTYXcHq6NM8fZE5oVkYQy8KxzJgY2MgDRbk1FYYA+FoQ9dhrikF4Xy7uiEMgwY9rgFicNdBh5mk/Bmcyjmkv2tuulMbGAFYwpf460E4jFkdN2SB7Keu9euer6TOjq6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438605; c=relaxed/simple;
	bh=7F6Kp7PjtMwYyOaOeM67KI3nyJH4rgdxkPIIo3IJI2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpDVWAEyz5bLxUWtbYAMmlpF5TR3jCefnBYnXdh3u8STixGBRXgwp5Ai0O2nk6pGB1cwFgsgtoz3QKwg2aLilvkHjS9lp34ngnhxIHXqjVRX7kkQZNEGHsz9rA4TwVSstc8lr80rxf+epLOtmD6d3uw9JUtvGNGjyauSUaTLJiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48fde3a2b17so1298097137.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 04:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720438602; x=1721043402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mcw6UNrBJv8rAqjjTUhPR1XEJKbzTv66sPWbmXvxFww=;
        b=jr2DfsivQR+Qt1j2b43iinOylJBa0tAAM34BDPJHsXTRhHIlwUsL2fkX5gmhkiHA9w
         1m6uG2TcydOFmjNqHOoKxZ+wAPE7/OIjJKSlKM+aAwgFHTACLAGtDo5qK2TcmArTRXia
         YTvOQYAi5QDp0HFCBeX3Im3w8sSHZuW+EQpc9Lxg/YALnrTzi4pgyjaZcvWlCM2y3bAI
         ONx1bVBNWVur5bDP32ulhQtiWBbFGUCbwqb2iwcHXX8oPWaW87HMIoXU1zmXVxRaKc/1
         rKbJQ1unWWa5/6J3ZIoM4hAVjXeEGX1maf3XYe8SW8pqvJRWGs9Dw72psSFwdvrcFtY9
         rEJw==
X-Forwarded-Encrypted: i=1; AJvYcCUG1iuBZBy0R4zsxDkFrt4qzkIasUfRb5Dx2AJBEM1KnQAnGZamoIK9+VsmVMyxbu0GQ4K1dM7K9VwFqZeh9QdGoFLMB0PFXHfI9Gb6
X-Gm-Message-State: AOJu0Yx/9s19GEDijtG4mdHE4QN4x/Uz/TJqz0rNaX1QegN69kBykIa4
	Waehr80Cu7utVHwInhH+TN/1BXYQOwj6ktqHZ9Us0PQorPvH+Z/vEZosxKMkIgCw+l9iHmurr53
	4bKWU9cRM+9wMRPalRE9sQ5LtgvI=
X-Google-Smtp-Source: AGHT+IHAhIdUk9D9MXk/PrnUS4YRbkVtUJ0XMVFt2+q9PpbWqoAja6N72rk/4Gy6UkQoFGKnVETbzpwi51GmbcjCiFA=
X-Received: by 2002:a05:6102:d7:b0:48f:df86:db3 with SMTP id
 ada2fe7eead31-48fee64f3b0mr11713010137.3.1720438602575; Mon, 08 Jul 2024
 04:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708112445.2690631-1-ryan.roberts@arm.com>
In-Reply-To: <20240708112445.2690631-1-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 8 Jul 2024 23:36:31 +1200
Message-ID: <CAGsJ_4zH72FyLq5gJm215oiWrtd6uf40L_F1UO6cFZ4sy7qt0A@mail.gmail.com>
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:24=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
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
> before the change makes it upstream and the ABI becomes immutable.

Personally, I think this approach is much clearer. However, I recall
we discussed this
before [1], and it seems that inconsistency is a concern?

[1] https://lore.kernel.org/linux-mm/05d0096e4ec3e572d1d52d33a31a661321ac15=
51.1713755580.git.baolin.wang@linux.alibaba.com/


>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> Hi All,
>
> Applies on top of today's mm-unstable (2073cda629a4) and tested with mm
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
> Admittedly, this change means the mTHP stat names are not the same as the=
 legacy
> PMD-size THP names, but I think that's a smaller issue than having "file_=
" mTHP
> stats that only count shmem, then having to introduce "file2_" or "pgcach=
e_"
> stats for the regular file memory, which is even more inconsistent IMHO. =
I guess
> the alternative is to count both shmem and file in these mTHP stats (that=
's how
> they were documented anyway) but I think it's better to be able to consid=
er them
> separately like we do for all the other counters.
>
> Thanks,
> Ryan
>
>  Documentation/admin-guide/mm/transhuge.rst | 12 ++++++------
>  include/linux/huge_mm.h                    |  6 +++---
>  mm/huge_memory.c                           | 12 ++++++------
>  mm/shmem.c                                 |  8 ++++----
>  4 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 747c811ee8f1..8b891689fc13 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -496,16 +496,16 @@ swpout_fallback
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

