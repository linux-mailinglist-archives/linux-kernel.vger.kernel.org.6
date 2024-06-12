Return-Path: <linux-kernel+bounces-211657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C192D9054F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C77328293B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A81169ACA;
	Wed, 12 Jun 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIlJle/Y"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE217DE35
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201922; cv=none; b=G1R6YDC+4Hw1t41Cjn7dwk8m5SCfe+uRCnlMI+iJlUujQ2u3Nqg1lx2t1iVWOtOq1WkGu1kxaBUo3KjHBT6NfhQ3fjIDZ9yFb/txbxTwy8hyk1d6aNLqvaLDjWU6We3VQCL8YyIqNoKfFQK2jE2IQKsKlfiWSzNaO/3NvDJuqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201922; c=relaxed/simple;
	bh=cWUsIBqBJ/97bmxnKU7BawRUZHR9jz5VDoKx3NZQ1R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fk2lkHf/8D5aDiRfcPH0+09fTd52UZFt8bFgWfu6Qp7ydDPd8FDCPj3rPIPui+ics4KLTYIGczyIDHLj4B47OdrM1YNevlfZqyWPMLixtrFuhpAnpUn0gZPXfc8zB7DwaHRdom7SwLFD0vwDkp8OE8UNyUu5ClfTPTydANbuWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIlJle/Y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c7681ccf3so4911019a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201918; x=1718806718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR6Mw/uBGrdLP+c87yF7rrJHnsUwR0tIZHnBvWUb2j0=;
        b=NIlJle/YpC2wA45CIXW6LMMQs/VdWB/tDc1jL2bYPJjeKvRAQv14R1hamKfhjZXXu8
         iNaa3WidFEkRMEu/OH0fghh0l4ioL8bw8ZhXKd0Muupmb/30nqZ6CnLdXlwIyEwKXjgt
         gW093S4kkErzLC+Tstx9x5rB9yFqG1XCXfbl10Y/JEw3x+kiqq7LhQi0+MCTLw2GJiah
         g1w7XSPaDaT0WX2gKjoPsnErIchI24brJDsVDvmakiBi/wadqnQOGMtjIuA0cX6W+C0i
         ZOBk8+a1HhL8aQMYD73u8MlL5ClLHMZvEU6UUjMt72OKeeW6ZiQOsU0qwcV6NFr3sFZE
         8CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201918; x=1718806718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR6Mw/uBGrdLP+c87yF7rrJHnsUwR0tIZHnBvWUb2j0=;
        b=aVD1RGLfVOZ/NyxJ0hKQSQS6GnwhuzlKUalhdwvnhL0v4mReW9KdqKreISdZ8RyBi0
         LunyKXHpkpDNvVT5FfkLQr4sC4G2MG1uDA3TyYY+Ha8ulOOdcGraJ3UrabMSdftlnzCx
         +gNjAXPB5Q4g2imT9d9BLDkws71N/2Js1fsL9WnodRDaQM0lSxUMJk691ajTSLGmIBI1
         +nH9cCeaf+uNrO3FgyKkl62ckXZKkyVzIIwBkMaIS1QDJ7J1etj43LpDl5aZ3e4kzoEI
         mAHsS3qAwhz+1Gv4O0FFZORqxsZr+DiX4Mt4mfa5avbnEQlibCKa4ycK94EW2VmjsooZ
         Luog==
X-Forwarded-Encrypted: i=1; AJvYcCU6RtuokMXPA9MdXzTRusny2zw+gKfuVCaYJza/XY8FAq32DWJZ/7GWyrFhiRINso8jfKRG+kLDNrdZ7F5ScaN28OeLTHq5TvdpSpcE
X-Gm-Message-State: AOJu0YwBgKTxMBCTEkQW/O8faM4kVETVb0pNWBtQuxIrUZOl+fzIzAkt
	kj88VNdjD2WC1Xn942Uvpb3QP1QrVCHU2PqjFFrtU0DCVMZypeS7s0EvSFkGejfB7UGHssflyjf
	Nt20p/ghhU9EAfLr7TDNvBzEv7wo=
X-Google-Smtp-Source: AGHT+IHpDL+y1qV0WViwduL3/EQ/4jVuUbfWn2uPTJDMWv9LlgaA1cXdBOkXmE6zmolWjGSI7EfcYjHSnbpOA06l7HY=
X-Received: by 2002:a05:6402:33d4:b0:57c:6955:41ea with SMTP id
 4fb4d7f45d1cf-57caaac6682mr1181981a12.38.1718201917780; Wed, 12 Jun 2024
 07:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com> <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 12 Jun 2024 22:18:25 +0800
Message-ID: <CAK1f24k0bYk2zGAj3znkkT=XnweTxF64XhLP9Xg_HUHeNtrAXA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: shmem: add mTHP counters for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:11=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Add mTHP counters for anonymous shmem.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

LGTM. Feel free to add:
Reviewed-by: Lance Yang <ioworker0@gmail.com>

Just a friendly reminder: We also need to update the documentation
for the counters in transhuge.rst.

Thanks,
Lance

> ---
>  include/linux/huge_mm.h |  3 +++
>  mm/huge_memory.c        |  6 ++++++
>  mm/shmem.c              | 18 +++++++++++++++---
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 909cfc67521d..212cca384d7e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -281,6 +281,9 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>         MTHP_STAT_SWPOUT,
>         MTHP_STAT_SWPOUT_FALLBACK,
> +       MTHP_STAT_FILE_ALLOC,
> +       MTHP_STAT_FILE_FALLBACK,
> +       MTHP_STAT_FILE_FALLBACK_CHARGE,
>         __MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1360a1903b66..3fbcd77f5957 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_=
ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHAR=
GE);
>
>  static struct attribute *stats_attrs[] =3D {
>         &anon_fault_alloc_attr.attr,
> @@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] =3D {
>         &anon_fault_fallback_charge_attr.attr,
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
> +       &file_alloc_attr.attr,
> +       &file_fallback_attr.attr,
> +       &file_fallback_charge_attr.attr,
>         NULL,
>  };
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f5469c357be6..99bd3c34f0fb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1773,6 +1773,9 @@ static struct folio *shmem_alloc_and_add_folio(stru=
ct vm_fault *vmf,
>
>                         if (pages =3D=3D HPAGE_PMD_NR)
>                                 count_vm_event(THP_FILE_FALLBACK);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
> +#endif
>                         order =3D next_order(&suitable_orders, order);
>                 }
>         } else {
> @@ -1792,9 +1795,15 @@ static struct folio *shmem_alloc_and_add_folio(str=
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
>                 }
>                 goto unlock;
>         }
> @@ -2168,6 +2177,9 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>                 if (!IS_ERR(folio)) {
>                         if (folio_test_pmd_mappable(folio))
>                                 count_vm_event(THP_FILE_ALLOC);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_FIL=
E_ALLOC);
> +#endif
>                         goto alloced;
>                 }
>                 if (PTR_ERR(folio) =3D=3D -EEXIST)
> --
> 2.39.3
>

