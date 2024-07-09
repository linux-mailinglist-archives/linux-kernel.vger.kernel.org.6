Return-Path: <linux-kernel+bounces-245060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4E92ADCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A1B1C21487
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921B2C69B;
	Tue,  9 Jul 2024 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGmSPQlX"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947C2837D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488423; cv=none; b=Ec3tv2h33t4GU+DBnoA4x9NbyTKKYvl6alxefibIZmdEfkp1M2osZft+xTUJKmqa+LWRz+lK/mb0mOvurfXSe+pcnICbErtsm3g9dic/DsPGt3UJSxMUcwQXh/iflLtL6zRuazMEhH44MlRA4kzltZI6AdUE2IypYCJYihYVhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488423; c=relaxed/simple;
	bh=e86dGy3tsuZGkV5rnriZkq3NuWCvpOE21ZMEB6i5j+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6k9sLroit/zEgBzJWBl9rh8UJX4bzcLamJgfZW7H4JIFdPMnVyN/zRlzw60EgcCtv0pY6Qg0zwb3nGmy4M5gSBUzeOhYn3ymTVd0yXuC9duwal+ZuBcQjRM/xW0/OkySMl07bzqXYOa9Mat9N8DmTqDIBaMND/Z0PdLpTyVH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGmSPQlX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso6079061e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720488420; x=1721093220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHITuDKct4GjdiGtn+rduATm9eEjApODvQxhrD3sy0g=;
        b=QGmSPQlXJaZVHl0XiqaMZXM23vgCMzrvntw3XAyPZnzH0rbikF4dWPvbxRxrISWhoD
         YC/qAvrOAZZNEf3rZ0mRdMDVelULat6l5E14de3pKeASWQ04Tdc6PR1hNtWU+tLzBa+y
         GCzK/WiSFfIiDt2k07n+f07LsjiUGTS32LYZV5F22fhQBbwr7WHZHdEZZFD2futPZRJj
         vxxwePGoJo4KgAaqqobYIaP9tTBSU16odbCNU/WGElr9GCUwYop+prOT+Ng6NLGGWRou
         vZXdL3zzKKklanIH0+RbArDrn9oeIes+QrTxVdqUKpRnsXmplgoPmCvuolL5tAmXrI/x
         v83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720488420; x=1721093220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHITuDKct4GjdiGtn+rduATm9eEjApODvQxhrD3sy0g=;
        b=omWj0hiQs93THE4p6Jt9FsxNXLpW3gc6OExS6MJ6l24kGaRFf165weVwzsBhPFw5Ql
         dLfRUe8fk3zGclgelR2hP1+wniZiUcP8GwNnn3KH6N6q3rhfGzgvRXmL8T3X9x5qQmHR
         uatakxAomCohG6fKeYbWgFW1CpnVwDaAEQIi5ChQ9MZWecDNWPT4gjNg84POlwSMsvkO
         yaXmMjcmTlvI0W2k8EUe/nwyYLjjleelIbhUzwCh9GtazSDNUK5nxT/67x+3QzaV16rU
         deCWi6mdZuclA9GZNNeMxfvj1v5a+JSohj/m/hjWmx12gvkK8zh/2lSELJOtdM3n+E1D
         sYtA==
X-Forwarded-Encrypted: i=1; AJvYcCXWbgTokp+Bsz655ZQ6m26ou5Zzmr3Lyqc4IW9PMr/A1xWF+J+b6xoNrMXnXA92AST5QhommOMF5KPKiN2YuSjlYtdJvN/+a4XRo9NL
X-Gm-Message-State: AOJu0YwdOwEB02Jv+GPGEo/0H68E+yuNx7eMCAbg3G47lWybNUmqzF5g
	27AiEnq536ENk5ccXgbeMfqicogDaooaNw4wFiWvTyE5AiNTqZYY8UDO56NxG/vm8n2DtTw5lSa
	9ikTFJ6PNGfPOiJMWckk6DC10zOE=
X-Google-Smtp-Source: AGHT+IH8RfvVjbcPkpXmd+DCWBIcr62Wjtwq4GXhfgVElF5EdGLnUR8/spgSrKnRjD6wFRwbqGSKvuwqzhYUXPIOYX4=
X-Received: by 2002:ac2:41da:0:b0:52c:90b6:170f with SMTP id
 2adb3069b0e04-52eb99a0e7emr547960e87.29.1720488419687; Mon, 08 Jul 2024
 18:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708112445.2690631-1-ryan.roberts@arm.com>
In-Reply-To: <20240708112445.2690631-1-ryan.roberts@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 9 Jul 2024 09:26:48 +0800
Message-ID: <CAK1f24nnJKysBi9N=p-Lf9yfQv0+Z3AY2+F2u3vC+e5yvW3yvQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Matthew Wilcox <willy@infradead.org>, 
	Zi Yan <ziy@nvidia.com>, Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 7:24=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
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
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM. Feel free to add:
Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

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

