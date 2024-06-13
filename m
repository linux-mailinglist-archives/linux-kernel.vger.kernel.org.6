Return-Path: <linux-kernel+bounces-212753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D99065B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF131C236F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6EB13C8FF;
	Thu, 13 Jun 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/1nRjC1"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112580039
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265139; cv=none; b=QaXEGrHOBvXBnBWYfQNBu33ZhsDqTUyI/8ayF43ppVmmxxmrxYmy8C+HGb1weRR5EYAmgpFkN+Tmi43GZRXy1RHDXz5imO5J/JU7U+CzwKUXj9VMeNzjsNdL25UQDR2jbQ+kZyWquHA9sgw/7MpunN7iskWI7J+Ks2OtkA+T3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265139; c=relaxed/simple;
	bh=UBW84QNzhviZ1YYYQHOy+kjynP3pIZcQ2FC6mJcA0rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTVy7dUG+tPnCxAyrPNjQYd5OdVMlhifjC2tCA464T5WYFFyy8wJRB0yvuZVR6J88HddcSb9Si2dnZBaC0AO6unGPoKAum8qadTMpAJBd+Bva6+l6xREqyIpcwfG5915u5tMRrBhQPAEyJku1ChS+05+6WBXjC3/5KpxBL8JViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/1nRjC1; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4ecf2fff1cdso203731e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718265136; x=1718869936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVAot2rBlUp/5AtT89Dnk6Db/qhauHUEK+I0Utm4dKY=;
        b=V/1nRjC1fOf7TI4uyyIXeCNAmJHM9k/mmZF8tU216dfpQYtD/xW2uPB7+8msZjLkSW
         3/xmHF+Rc2uhqMf84Dh80kKdxoQ/1rT2UQrAZyjh26hi78e4USxN2hnyj3AKkuioPNdx
         ML0ymUg6Gb039myxh4Wz8TxIloQFaVbzvK0Zhk2BHCmSs2QfLFcWdkH8VEZqIKxXwFxM
         jfcSgKIWY+aAXeuWCUrcOshB5H6ohv+aaJodVUjvCaWIFGRisopokilgB5QsQek5HZeD
         ZqGaRnJ3QRZiwojdZqYXmf77JtWcezrNo4kc9ICqJt2I/e3twNZN+ejf5NVLQZk1tU2D
         FspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265136; x=1718869936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVAot2rBlUp/5AtT89Dnk6Db/qhauHUEK+I0Utm4dKY=;
        b=rzdSGFr/aJqPejz3viIgQBMs4tKgL6m69XcXEMDbDF5b/hqjNkECS1AHrZv6gk4M43
         t/hmCPoyH6Lvd37kndzXOJbnQFpCSIV9a2xsZ+JYJMEB3IOYD3DEnz0Z6399UQ66CjyV
         w83PlOwLqHz64H5AzOXkU2JzYFHoOrYP6Zmsfp8M8VCPqRSjTKmERnk9Y/i2Fib46Dun
         2x2X9HK3W/dyE8S7rFWPLxtM9W2e5sKuyB6hHPQIppLr3UNnGxQpYiqHGbbj+HFuAHSM
         0qn0wllCdGFgSWqqQXW9FjJISDeAXASGfEALHwQfpAvUBoVM7WOxHWprbngIU06Eq2ze
         MKDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6XD8bH6aHs/bBDFwaqkdBlm0UhF5Wj7qRRyvgv1BzHwKAkDJvbJe7ubQ8qo4Kqm/HD52pbHDVf0LFjziG3AIH50w8vhNUmFFTtwnZ
X-Gm-Message-State: AOJu0YwwRKFbGa89dYHI39gQejxbFpYwxdTInAWNXq8IiofTCYGnAcCT
	fBErJkqNth5pSPbMla8c/BojJlcaLnshRTPVbAjvPF0uQURMHuvcMySDtZ++OpKCZAWazHoMAMh
	77pPlIVu11pBy+ZfHQIKlkoyp1Rw=
X-Google-Smtp-Source: AGHT+IFARuBVRgH5ZSETF1WprKkZ2/+FliDRYgvLKglKhTBw1qpD0mkDTG4ohLO6I+cFd7Bsicjz+ynPNNOvZNHUcG0=
X-Received: by 2002:a05:6122:2a4d:b0:4ec:f4ea:6495 with SMTP id
 71dfb90a1353d-4ed07bb5f97mr4810171e0c.11.1718265136370; Thu, 13 Jun 2024
 00:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610120209.66311-1-ioworker0@gmail.com> <20240610120209.66311-2-ioworker0@gmail.com>
In-Reply-To: <20240610120209.66311-2-ioworker0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 13 Jun 2024 19:52:04 +1200
Message-ID: <CAGsJ_4y4sKXbq4_ra9tTD-LWgB-x-HECyouxm_9r_N7Kw2We4g@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mm/rmap: remove duplicated exit code in pagewalk loop
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, david@redhat.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:02=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> Introduce the labels walk_done and walk_done_err as exit points to
> eliminate duplicated exit code in the pagewalk loop.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

I don't think "return false" necessarily indicates an error, so
"walk_done_err" doesn't seem like an appropriate name.
However, this is a minor issue.

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/rmap.c | 40 +++++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index e8fc5ecb59b2..ddffa30c79fb 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1679,9 +1679,7 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>                         /* Restore the mlock which got missed */
>                         if (!folio_test_large(folio))
>                                 mlock_vma_folio(folio, vma);
> -                       page_vma_mapped_walk_done(&pvmw);
> -                       ret =3D false;
> -                       break;
> +                       goto walk_done_err;
>                 }
>
>                 pfn =3D pte_pfn(ptep_get(pvmw.pte));
> @@ -1719,11 +1717,8 @@ static bool try_to_unmap_one(struct folio *folio, =
struct vm_area_struct *vma,
>                          */
>                         if (!anon) {
>                                 VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> -                               if (!hugetlb_vma_trylock_write(vma)) {
> -                                       page_vma_mapped_walk_done(&pvmw);
> -                                       ret =3D false;
> -                                       break;
> -                               }
> +                               if (!hugetlb_vma_trylock_write(vma))
> +                                       goto walk_done_err;
>                                 if (huge_pmd_unshare(mm, vma, address, pv=
mw.pte)) {
>                                         hugetlb_vma_unlock_write(vma);
>                                         flush_tlb_range(vma,
> @@ -1738,8 +1733,7 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>                                          * actual page and drop map count
>                                          * to zero.
>                                          */
> -                                       page_vma_mapped_walk_done(&pvmw);
> -                                       break;
> +                                       goto walk_done;
>                                 }
>                                 hugetlb_vma_unlock_write(vma);
>                         }
> @@ -1811,9 +1805,7 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>                         if (unlikely(folio_test_swapbacked(folio) !=3D
>                                         folio_test_swapcache(folio))) {
>                                 WARN_ON_ONCE(1);
> -                               ret =3D false;
> -                               page_vma_mapped_walk_done(&pvmw);
> -                               break;
> +                               goto walk_done_err;
>                         }
>
>                         /* MADV_FREE page check */
> @@ -1852,23 +1844,17 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
>                                  */
>                                 set_pte_at(mm, address, pvmw.pte, pteval)=
;
>                                 folio_set_swapbacked(folio);
> -                               ret =3D false;
> -                               page_vma_mapped_walk_done(&pvmw);
> -                               break;
> +                               goto walk_done_err;
>                         }
>
>                         if (swap_duplicate(entry) < 0) {
>                                 set_pte_at(mm, address, pvmw.pte, pteval)=
;
> -                               ret =3D false;
> -                               page_vma_mapped_walk_done(&pvmw);
> -                               break;
> +                               goto walk_done_err;
>                         }
>                         if (arch_unmap_one(mm, vma, address, pteval) < 0)=
 {
>                                 swap_free(entry);
>                                 set_pte_at(mm, address, pvmw.pte, pteval)=
;
> -                               ret =3D false;
> -                               page_vma_mapped_walk_done(&pvmw);
> -                               break;
> +                               goto walk_done_err;
>                         }
>
>                         /* See folio_try_share_anon_rmap(): clear PTE fir=
st. */
> @@ -1876,9 +1862,7 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>                             folio_try_share_anon_rmap_pte(folio, subpage)=
) {
>                                 swap_free(entry);
>                                 set_pte_at(mm, address, pvmw.pte, pteval)=
;
> -                               ret =3D false;
> -                               page_vma_mapped_walk_done(&pvmw);
> -                               break;
> +                               goto walk_done_err;
>                         }
>                         if (list_empty(&mm->mmlist)) {
>                                 spin_lock(&mmlist_lock);
> @@ -1918,6 +1902,12 @@ static bool try_to_unmap_one(struct folio *folio, =
struct vm_area_struct *vma,
>                 if (vma->vm_flags & VM_LOCKED)
>                         mlock_drain_local();
>                 folio_put(folio);
> +               continue;
> +walk_done_err:
> +               ret =3D false;
> +walk_done:
> +               page_vma_mapped_walk_done(&pvmw);
> +               break;
>         }
>
>         mmu_notifier_invalidate_range_end(&range);
> --
> 2.33.1
>

