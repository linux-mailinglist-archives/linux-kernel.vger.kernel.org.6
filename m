Return-Path: <linux-kernel+bounces-178826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D38C5845
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5091C219F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D2817EB8A;
	Tue, 14 May 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJT2dliR"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A3017B518
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698210; cv=none; b=sisuRP4XWdMIZu9szEKW0UVAryLFrplA6vjBumTpYsAzrUcCy5J9ImtCU8WN1Cx54S0whfdMf2JD0+TxNAoiwgDeTpp40Tks82GF3QsbzALAxQ5+MYZ8EwpwcUQr5O9tClbS3afWQB1qVADXC/MJ5ZPXb3AzhCJi6htNxwgsuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698210; c=relaxed/simple;
	bh=HTuosK5KAw7yvUHZJC+cw0gBJf4t8e/08mopzqrJz+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3uD8Xam0F36N5AttGluKEUo6kpfybqCp6hpA8A6qm+HagJ7ub8AFgkgSGTnVcmO0jRQ0P7mJVTfxQ0cfBC2IW+NTaTnkgeo/QEliT/MMc77M8aiKYIb8J4Ah2uaqJwBIdgcwwNFz67IH189jaJgD4n7CikzLj/dpg2077hhOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJT2dliR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5731ffcc905so322301a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715698207; x=1716303007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8weezbce1chIPNAjmlh4Y40a69OCRhuQpQAgvmJPtVM=;
        b=XJT2dliRenYk4IKjVFY5uhEJHgFNEAfcuCM87YrLGSF89sERJCx+gKvERcaClXGwQ5
         KPPtSjvTSYL0zFxoR7ieEL0Rs68TM/pzyJqcltc1uHZoi1U/E/2ZQkcWanz6TnlvhSDQ
         htTVxFLL0DAzbvSv8J1MKK6L6DB2XH/ZuVcz8Pr7+05wL35as8EmY5y+D4DFu3l3cmeW
         yHzRYCq3zc4WsZCIszqa9MnvyIod23S/MiXw0AJzizoJqQ0BlllqLJCG+XxxEkKabdd/
         ksdL1GPtfl0pDDMVAZlBzg4O8CrF2fmiA44uJZwjv+BIST5/699ia/edM/CU3539P6IA
         vMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715698207; x=1716303007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8weezbce1chIPNAjmlh4Y40a69OCRhuQpQAgvmJPtVM=;
        b=Cb94Bjp8wt4+890B86mpfcxDJbjotzmwsT7DwhEWrHJLm6AAzyFEn2yijT+Nv0dvNt
         yv8AHw7KoYDo9mNdxY/LrmnvYrHPqjTPgiLwFBNsd7XK0D4pChSA459/Yz3xizHzqw+z
         Sk6hmz+2XCJwJF/jIBJD5i5TpuMhwwTM5brZJK00e+6oqxqG9PuyapeO4O4d3K9OfRik
         LfPLl2N6Fv9yoPdJNizBRFQWQuPmpb97ViHucYcherAEk/rcsRg9qJbK5IZ4b6cfxWHm
         YhVBUXhzWzumy9hyqZlKTprbrJjumHTPPPUKJpng6xA/ZfaIEz7Xpuqx+f/fi873k389
         mr4g==
X-Forwarded-Encrypted: i=1; AJvYcCWgwG8HjGFiazdlw2CBIc6zH9mB0xFwCYZnmt8YfVAZ2hw20BoKHl/i6TMvw2pg5ALNw4dOeVIFVQxoRoBSa+/V/+yEQB2H7YM+Op+m
X-Gm-Message-State: AOJu0Yz0oesuj/ZL22XubZl5Vg/xpGUWqGuzRVZNqVGQeK1xvlkrd33r
	tMtIrr0fLebaRARZ4X+oxMtWzCrOA8J+UnqoR5ACNABCbvF+uOR+SAlQv0yAPODh5dRhgOkX9yW
	dhZ19K7I2NKOhQkmqPSu6TH2EvCE=
X-Google-Smtp-Source: AGHT+IFilomLYc85uAZnrYnzW/q4t2Ff1CPHHNg6/nJRgYwW18yfWpCgFToKCC3HM5O9nkzwLrVTnhCBulJo9/SNy7Q=
X-Received: by 2002:a50:cd5d:0:b0:574:f26f:cb63 with SMTP id
 4fb4d7f45d1cf-574f26fd504mr17921a12.27.1715698206867; Tue, 14 May 2024
 07:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com> <b9babe1857917ff217ed0988d95ba3468845479c.1715571279.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <b9babe1857917ff217ed0988d95ba3468845479c.1715571279.git.baolin.wang@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 14 May 2024 22:49:55 +0800
Message-ID: <CAK1f24kfR-LOk_vvhBWddVnDdiDZYh8aZeknknWkhi7_5fhQ=A@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mm: shmem: add mTHP counters for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Mon, May 13, 2024 at 1:08=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Add mTHP counters for anonymous shmem.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/huge_mm.h |  3 +++
>  mm/huge_memory.c        |  6 ++++++
>  mm/shmem.c              | 18 +++++++++++++++---
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index b5339210268d..e162498fef82 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -281,6 +281,9 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>         MTHP_STAT_ANON_SWPOUT,
>         MTHP_STAT_ANON_SWPOUT_FALLBACK,
> +       MTHP_STAT_FILE_ALLOC,
> +       MTHP_STAT_FILE_FALLBACK,
> +       MTHP_STAT_FILE_FALLBACK_CHARGE,
>         __MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d3080a8843f2..fcda6ae604f6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_=
ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBA=
CK);
> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHAR=
GE);
>
>  static struct attribute *stats_attrs[] =3D {
>         &anon_fault_alloc_attr.attr,
> @@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] =3D {
>         &anon_fault_fallback_charge_attr.attr,
>         &anon_swpout_attr.attr,
>         &anon_swpout_fallback_attr.attr,
> +       &file_alloc_attr.attr,
> +       &file_fallback_attr.attr,
> +       &file_fallback_charge_attr.attr,
>         NULL,
>  };
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8b020ff09c72..fd2cb2e73a21 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1786,6 +1786,9 @@ static struct folio *shmem_alloc_and_add_folio(stru=
ct vm_fault *vmf,
>
>                         if (pages =3D=3D HPAGE_PMD_NR)
>                                 count_vm_event(THP_FILE_FALLBACK);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
> +#endif

Seems like we don't need these conditional compilation directives here.

The THP_FILE_FALLBACK above will result in a compilation error if
CONFIG_TRANSPARENT_HUGEPAGE is not defined. So we don't
worry about that :)

See THP_FILE_FALLBACK in include/linux/vm_event_item.h.

>                         order =3D next_order(&suitable_orders, order);
>                 }
>         } else {
> @@ -1805,9 +1808,15 @@ static struct folio *shmem_alloc_and_add_folio(str=
uct vm_fault *vmf,
>                 if (xa_find(&mapping->i_pages, &index,
>                                 index + pages - 1, XA_PRESENT)) {
>                         error =3D -EEXIST;
> -               } else if (pages =3D=3D HPAGE_PMD_NR) {
> -                       count_vm_event(THP_FILE_FALLBACK);
> -                       count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +               } else if (pages > 1) {
> +                       if (pages =3D=3D HPAGE_PMD_NR) {
> +                               count_vm_event(THP_FILE_FALLBACK);
> +                               count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +                       }
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_FIL=
E_FALLBACK);
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_FIL=
E_FALLBACK_CHARGE);
> +#endif

As above.

>                 }
>                 goto unlock;
>         }
> @@ -2178,6 +2187,9 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>                 if (!IS_ERR(folio)) {
>                         if (folio_test_pmd_mappable(folio))
>                                 count_vm_event(THP_FILE_ALLOC);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_FIL=
E_ALLOC);
> +#endif

As above.

Perhaps we need to define MTHP_STAT_FILE_ALLOC and friends
using a same way as THP_FILE_ALLOC, set as '{ BUILD_BUG(); 0; }'
If CONFIG_TRANSPARENT_HUGEPAGE is not defined.

Likely:

#ifndef CONFIG_TRANSPARENT_HUGEPAGE
#define MTHP_STAT_FILE_ALLOC ({ BUILD_BUG(); 0; })
..
#endif

Thanks,
Lance


>                         goto alloced;
>                 }
>                 if (PTR_ERR(folio) =3D=3D -EEXIST)
> --
> 2.39.3
>

