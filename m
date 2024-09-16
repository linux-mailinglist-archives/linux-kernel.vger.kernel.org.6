Return-Path: <linux-kernel+bounces-330183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0311979AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB70E28162F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55492744E;
	Mon, 16 Sep 2024 05:13:04 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF51F61C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463584; cv=none; b=VBIbVEaOCI+3UCNTqkcApmRErzyIuIITd2s/NZDCGLYd0uqlzkS3zNL56Xu1CI4QN2xvDl/Mk7U3pM+fjK30p4egcsPXbH7gqkpPI1RXwDDJLM87rXSzII31oPBUquFEGcEmuYCrTBOdnC7I0sM+MZSByRUGWj9q96MKvgeoKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463584; c=relaxed/simple;
	bh=0qfVnXfPCc3shG5F1A6Lei3FxXW0KX0d+OeSxZsois8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeeBCFktcQ5brkPj9omRnlLGdK51xRBN/f7oXTPR3RPYbWuwyZ3ygiwX6Z8THEeV2QEs4aHIpfUBq9HBIbuTcN8jHeq4ewj7RWEW6Yty/vb3fv/w3VJtnHImCpAuFxd5DxmX6LgrCmgGGhGxdAO50H5iyEb4IQHLgVZwQl55P0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5010c0e16baso1100917e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 22:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726463582; x=1727068382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pKy0GP+8orlCXwX2+qmhzpwl+/GiUUqhznaxwn8qJs=;
        b=KM4zTeyjAWEBxXkRrcHJUVYpcyS9NSJH1nmVbVT1wJDrLiMTvByyFLndvMjiCwJwy0
         9UrIa1KmozN+xSxyd4/YBv1+/OZOCiyM7a3Ni7WCyDs/IO/QdA2NrpB6rTsJHBd2Zclt
         wsWbD9BTYdn0jsI8iGE2uMNI0iCtCvwqY++kA/rWk076Jk+AnsVO9ZDtNbEf9QljQmyK
         ymxcujeoBx0hyMtn813BrhQ8oJ/qbDWIcTt0L9GYCYEp4/Pe5IqwVYOh6HHHb3M/wjZi
         uiOygw/SE243xVOmzRbUHH5VEK34oEIvzUbKtQRFFx8VvjnI+Peyr1hnDdv1ZUCa0KI6
         ZC1A==
X-Forwarded-Encrypted: i=1; AJvYcCUWX3LC496pSMC93oPIFJY98DXx+W7JOzsTCYoa4reUF9Y1+yDLcb1v75fpqxdqGPTN9DzRcgt7oyIOr1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPOo59fV9xb0miUsWXdzUS0k2CIepLg5ZjjCyGK9Z4TDW5m+S
	pu5CCJmqR/lKcPI40mkkj9I4ntWLcvPrQcvdX2SfxSPUFvVvJSrV0429BIaXCKbxk1lOEswcZ6P
	E3PqMcbR12CL/IB2zb1eK6oaxo9Y=
X-Google-Smtp-Source: AGHT+IE4LCTrTz3eMBNZ0MVDw9K0mJlvzp1bv5Nv9ZrYzGCXgkjYLFu2wy9Cra/7E6/3br0p4YaV/3+Za2KvRsPcO1I=
X-Received: by 2002:a05:6122:1d0e:b0:502:bd0d:abe2 with SMTP id
 71dfb90a1353d-5032d3f813amr12379643e0c.6.1726463581614; Sun, 15 Sep 2024
 22:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913091902.1160520-1-dev.jain@arm.com>
In-Reply-To: <20240913091902.1160520-1-dev.jain@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 16 Sep 2024 13:12:50 +0800
Message-ID: <CAGsJ_4yRadEPiO5H7Nd1jXQ1Gydt43VtUjfQDEp5Q+U9yddTnA@mail.gmail.com>
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, hughd@google.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, 
	baolin.wang@linux.alibaba.com, gshan@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:19=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> We use pte_range_none() to determine whether contiguous PTEs are empty
> for an mTHP allocation. Instead of iterating the while loop for every
> order, use some information, which is the first set PTE found, from the
> previous iteration, to eliminate some cases. The key to understanding
> the correctness of the patch is that the ranges we want to examine
> form a strictly decreasing sequence of nested intervals.
>
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

I like this patch, but could we come up with a better subject for
pte_range_none()?
The subject is really incorrect.

Also, I'd prefer the change for alloc_anon_folio() to be separated
into its own patch.
So, one patchset with two patches, please.

> ---
>  mm/memory.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 3c01d68065be..ffc24a48ef15 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4409,26 +4409,27 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         return ret;
>  }
>
> -static bool pte_range_none(pte_t *pte, int nr_pages)
> +static int pte_range_none(pte_t *pte, int nr_pages)
>  {
>         int i;
>
>         for (i =3D 0; i < nr_pages; i++) {
>                 if (!pte_none(ptep_get_lockless(pte + i)))
> -                       return false;
> +                       return i;
>         }
>
> -       return true;
> +       return nr_pages;
>  }
>
>  static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       pte_t *first_set_pte =3D NULL, *align_pte, *pte;
>         unsigned long orders;
>         struct folio *folio;
>         unsigned long addr;
> -       pte_t *pte;
> +       int max_empty;
>         gfp_t gfp;
>         int order;
>
> @@ -4463,8 +4464,23 @@ static struct folio *alloc_anon_folio(struct vm_fa=
ult *vmf)
>         order =3D highest_order(orders);
>         while (orders) {
>                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -               if (pte_range_none(pte + pte_index(addr), 1 << order))
> +               align_pte =3D pte + pte_index(addr);
> +
> +               /* Range to be scanned known to be empty */
> +               if (align_pte + (1 << order) <=3D first_set_pte)
>                         break;
> +
> +               /* Range to be scanned contains first_set_pte */
> +               if (align_pte <=3D first_set_pte)
> +                       goto repeat;
> +
> +               /* align_pte > first_set_pte, so need to check properly *=
/
> +               max_empty =3D pte_range_none(align_pte, 1 << order);
> +               if (max_empty =3D=3D 1 << order)
> +                       break;
> +
> +               first_set_pte =3D align_pte + max_empty;
> +repeat:
>                 order =3D next_order(&orders, order);
>         }
>
> @@ -4579,7 +4595,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>         if (nr_pages =3D=3D 1 && vmf_pte_changed(vmf)) {
>                 update_mmu_tlb(vma, addr, vmf->pte);
>                 goto release;
> -       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> +       } else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) !=
=3D nr_pages) {
>                 update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>                 goto release;
>         }
> @@ -4915,7 +4931,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>                 update_mmu_tlb(vma, addr, vmf->pte);
>                 ret =3D VM_FAULT_NOPAGE;
>                 goto unlock;
> -       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> +       } else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) !=
=3D nr_pages) {
>                 update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>                 ret =3D VM_FAULT_NOPAGE;
>                 goto unlock;
> --
> 2.30.2
>

Thanks
Barry

