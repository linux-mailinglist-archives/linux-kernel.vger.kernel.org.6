Return-Path: <linux-kernel+bounces-211132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A288904D89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD1FB25D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3870116C86C;
	Wed, 12 Jun 2024 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvX2hvCc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B825605
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179463; cv=none; b=L9DDh8uS94219MKah3AY/BG4KUGDQ7MWye9YxH6Pfk71NQoe6MPElzmmixpceTWLDFVnlFfcBYK0HducHmHqTQn+3sVibcEni/IQbPJR+bQ0llEVKD3D/AVB/8Ld9+csw1XKPERsrfubZb0FtlSPf2GFrFpAI8DbI45mnL2Qwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179463; c=relaxed/simple;
	bh=vIKWDXQW8UZKXiRyHz0ld2IRta1zl8qtRQ/SifNfOhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ot9m0r4W2Nx29ftey1OlTxN/0VxINWcRB222Z6Va1QfyGc0IQUSFptqdJQisR+J0ITkMC1tf401zY5EVqbrjASBwSxwmvZgyFg/LuTS8zMPeh7qtxjDk77HmulTSrDxuoOHC6Bj8w7ctwmCGwsckO1f3PRa82KrwEPtNkfCmPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvX2hvCc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so2499272a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718179460; x=1718784260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js3E3DUFwU3FB+ZM+04Gkpcvw7j3IczAyXGTYjRRVWo=;
        b=KvX2hvCc1CKreEl6TGC3fd4Dw+kd9b0xTzTiOfPobazAcHHsHBJxgXgHRRGW26Oy8l
         whKNkVU2hBvoqggzI+Cl/ruuAOLNpQe0Ru6hyULvd4gN0IrGOArcX6bne2e/VuX6OZnQ
         9xlIUzPGlPVG7IUHxCRIE18IZq2clouV0xzBzPI4GVh9APW3cLFEWu85Oez/g5Mx82oa
         wNE7TKCYaJjyesg56f2MsI5QVDoaSq3L2CrwPhTlPEOHBRoxGPJp3q0pfe0nyaQym1J+
         jv2FUvWGPZ1CD0N5lyit3c8ZXK3QvqlDYElE3dg+GzzjUgWPkfghc0I8+Lvry5VENtZg
         Mp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179460; x=1718784260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js3E3DUFwU3FB+ZM+04Gkpcvw7j3IczAyXGTYjRRVWo=;
        b=HnlJKmxyc8U/w60pF1Hf/xQ/hyYsZCG6yW8rgvdgzS2LpERaqjl0oLHvniWKtJICK8
         63z+hripT8vsKxiPf9J8c/5OMvha58UARqRboczy7bymmZA/KcqWZx/V93pN9ZTRI4/1
         xyZhutbkLWgpQCrJCVTrlLNK2vJuX3CPW+l/Qc5+oLXr8/Y/FaLChqq0Xcu4Vhqd89VB
         vVCGwGBOsC0xSO2cO3lu1uSYkFzHIArihdM1vkU5JD7mZSQe9yb2yO6bbh3sju7FMTN2
         IBhR0c2bC2cdYOJUcvYNwMZAUQa9nQ6Y/i/SJxStCIXtPtnZc4vpTSz71iXK/lkP77SK
         xnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsDucFYPYQwi6h1CG0oWqoG5ZZnnCbDHh13NXmnBaO24/UJaswpJV9GiTElwCuD89gj5puwYKKESYBjgq/3+f0aBQ2U0m6ZQmtgPwu
X-Gm-Message-State: AOJu0YyXJltkZX8YOO8D+/WmNEchxn5/8fwuHh31X/w5ivUOkSVhuBjU
	M+gBCy4PaUk3TvIUUdPxdkxYh9SUh7p9A5rpAiQL6eXlDDtX+HaH45rkSc3sEpjxvN72n92s1G6
	ICLz+XtMqeRXNBH3lrwIf5dGzAtU=
X-Google-Smtp-Source: AGHT+IG1Q8MXusEULXXlSBWhyYV1z5qWXyGVXkXKcSdxTpBqsBPO6/ovkRW9BoPcFsKqz8vYHU+1TkuJL2zSI5yhOdM=
X-Received: by 2002:a50:96d1:0:b0:57a:339f:1b2d with SMTP id
 4fb4d7f45d1cf-57ca9749c57mr684876a12.5.1718179459833; Wed, 12 Jun 2024
 01:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com> <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 12 Jun 2024 16:04:08 +0800
Message-ID: <CAK1f24=Rz4qPyw9pfTHTAuQO6Yv9mFHccjCd75a0kvHvCBH3uA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: shmem: add mTHP counters for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Tue, Jun 11, 2024 at 6:11=E2=80=AFPM Baolin Wang
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

Using the conditional compilation directives here is a bit weird :)
Would there be any issues if we were to drop them?

Since THP_FILE_FALLBACK is working as expected, MTHP_STAT_FILE_FALLBACK
should work as well without the conditional compilation directives, IIUC.

Thanks,
Lance

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

