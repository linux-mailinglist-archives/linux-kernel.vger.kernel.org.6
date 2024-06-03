Return-Path: <linux-kernel+bounces-198604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686838D7AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19381281EB3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418DB18E3F;
	Mon,  3 Jun 2024 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcVEYCSY"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21BE57B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 04:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389892; cv=none; b=ifSZZc2eXWNHuvBPqEWLD9j3FFpVFpchylwD6HHlVXq1RCJ5dBLUpeKJb6ZtmW9uJRWn57xAQiFj12oJC7oc80KmkdkKhTZiNYLXkXfkR4g2q2u8B8YiimZFNhJFs9bwmoZ+CGBdEqoh3iYiBtRE73GG9ag2A4maTskAlUPzAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389892; c=relaxed/simple;
	bh=Evq9L2OxAPUBZWDL1YbX09QQyA48cNGOGkYOrf6a2mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAP9seOwwFmxteErIEkc7VbVslGakjmYdnvq7H2qET89F5dxxTgQ7OS/aqHPB42uw0Js6V6zJ7HB7BjDhJGWLtVOchoid57A52J8v7qU2o8Ap+QFvwbetslPftArmxGfG4HWyS3g2M5eswTUDWzrAk+XiEpmY8BDPFDKSCDnLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcVEYCSY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so4226924a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 21:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717389889; x=1717994689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36DAp6c5wHQAG3f8vCocy5x73GV3ytJxTrWvAggCAeQ=;
        b=OcVEYCSYmTYEOYqdIh4IXdMRp4viQWK7eFKxJSNlsh+H4Ridn2I3MAbS981N6mf86U
         HZxGMdlwioSO7eUHBkSrr7Y6pPzosDbznzKSdqEh+CT76l6r++58XAAyqChT0Eq/lLXQ
         ZG+P6xOsl9ogDw/THZN1plsX5ZarCs1hRAbRYX7wsaTQcitMXq0vX3PkCb6QmavlYXjK
         qFkLa4EEbzsTzc1g9LbzyNzID9MpHCmAvU9FMseLN48eIKw31XW+E80kDaZEjx8V6NCy
         8Y3B5g3IHSROf0vGoxmBArzcILfDM+TpnpG3vcDC58Ib/7nfGrauebsg1KoELXtsjm88
         mwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717389889; x=1717994689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36DAp6c5wHQAG3f8vCocy5x73GV3ytJxTrWvAggCAeQ=;
        b=aMDJCT3JT83kMIGj8vuKZmgxtYXj+8dnitkQ5lpX6Zjn7MixnMDGC5z4z0YxQh4vrL
         N4MQVl96WJJqM/fcilPdQ4PBfRwUQgpvW1Vojh1lCtCyFTbdiI/Cjpb0RaIZzqwjjob/
         HGL4dXcjMLU89Op3WEaPqIiFmKfqNgZJ/u/v754HRW4Xh9hfE/F+TtafBKdYbUiqvRAg
         zp/rAkcne6VcRNIOpWz3Yb7Yo9B+x8XX+A3cOWaeZ5Yq5FRCXgTjTtO5sJtRhd8OVbuP
         KSKYcsd2waNxqJHZPdOKNRFuJuTIWwJxBEuasm5nDmL2hvAXWkUcip8w1/w7Dw2HaeCi
         WKAg==
X-Forwarded-Encrypted: i=1; AJvYcCXKqEPofTa+mFYZTczPvO6Wjd/4BZgyrS6oZgjPKa6WYncla+2/IL7PjdePvwfw7z7uqFWyCtGVnJvAzgniQH9T0XsOAJTYDOFDOQOS
X-Gm-Message-State: AOJu0YxKUD6KALLFZasf+H1aXGDNcgmhZOewOXG48TDEx2g8zYog49ls
	hJ0ePCwTTkWWNJ43blDApGEH6sAJjf2t7e/+gOfNR6643ihugF5f6Ovtl4hVBSZcqnKfJiXuMFi
	VvkQ53fHZl6sIanmGR4DdOFXshwI=
X-Google-Smtp-Source: AGHT+IFj0spnrgaVO4RVLb/0Xcf4qFJwEH01qjZDVGTeVkSMX7Tf+chVlk4bI9VroNgSzpkd5Pp9PKDbN4Ucg287zf0=
X-Received: by 2002:a50:a415:0:b0:578:5851:b0da with SMTP id
 4fb4d7f45d1cf-57a364e37dcmr4994453a12.36.1717389888891; Sun, 02 Jun 2024
 21:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com> <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 3 Jun 2024 12:44:35 +0800
Message-ID: <CAK1f24nxQi4ER+fLioHmOpH3dgGbhdyDiSvfwidEz-oSuWyAYA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm: memory: extend finish_fault() to support large folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Bang Li <libang.li@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:04=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Add large folio mapping establishment support for finish_fault() as a pre=
paration,
> to support multi-size THP allocation of anonymous shmem pages in the foll=
owing
> patches.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/memory.c | 58 ++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 10 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index eef4e482c0c2..435187ff7ea4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>         struct page *page;
> +       struct folio *folio;
>         vm_fault_t ret;
>         bool is_cow =3D (vmf->flags & FAULT_FLAG_WRITE) &&
>                       !(vma->vm_flags & VM_SHARED);
> +       int type, nr_pages, i;
> +       unsigned long addr =3D vmf->address;
>
>         /* Did we COW the page? */
>         if (is_cow)
> @@ -4864,24 +4867,59 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>                         return VM_FAULT_OOM;
>         }
>
> +       folio =3D page_folio(page);
> +       nr_pages =3D folio_nr_pages(folio);
> +
> +       /*
> +        * Using per-page fault to maintain the uffd semantics, and same
> +        * approach also applies to non-anonymous-shmem faults to avoid
> +        * inflating the RSS of the process.
> +        */
> +       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) =
{
> +               nr_pages =3D 1;
> +       } else if (nr_pages > 1) {
> +               pgoff_t idx =3D folio_page_idx(folio, page);
> +               /* The page offset of vmf->address within the VMA. */
> +               pgoff_t vma_off =3D vmf->pgoff - vmf->vma->vm_pgoff;
> +
> +               /*
> +                * Fallback to per-page fault in case the folio size in p=
age
> +                * cache beyond the VMA limits.
> +                */
> +               if (unlikely(vma_off < idx ||
> +                            vma_off + (nr_pages - idx) > vma_pages(vma))=
) {
> +                       nr_pages =3D 1;
> +               } else {
> +                       /* Now we can set mappings for the whole large fo=
lio. */
> +                       addr =3D vmf->address - idx * PAGE_SIZE;
> +                       page =3D &folio->page;
> +               }
> +       }
> +
>         vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> -                                     vmf->address, &vmf->ptl);
> +                                      addr, &vmf->ptl);
>         if (!vmf->pte)
>                 return VM_FAULT_NOPAGE;
>
>         /* Re-check under ptl */
> -       if (likely(!vmf_pte_changed(vmf))) {
> -               struct folio *folio =3D page_folio(page);
> -               int type =3D is_cow ? MM_ANONPAGES : mm_counter_file(foli=
o);
> -
> -               set_pte_range(vmf, folio, page, 1, vmf->address);
> -               add_mm_counter(vma->vm_mm, type, 1);
> -               ret =3D 0;
> -       } else {
> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
> +       if (nr_pages =3D=3D 1 && unlikely(vmf_pte_changed(vmf))) {
> +               update_mmu_tlb(vma, addr, vmf->pte);
>                 ret =3D VM_FAULT_NOPAGE;
> +               goto unlock;
> +       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> +               for (i =3D 0; i < nr_pages; i++)
> +                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pt=
e + i);

Just a friendly reminder: Bang has added the update_mmu_tlb_range()[1] batc=
h
function to update TLB in batches, so we can use it instead of the
update_mmu_tlb()
loop.

[1] https://lore.kernel.org/linux-mm/20240522061204.117421-1-libang.li@antg=
roup.com/

Thanks,
Lance

> +               ret =3D VM_FAULT_NOPAGE;
> +               goto unlock;
>         }
>
> +       folio_ref_add(folio, nr_pages - 1);
> +       set_pte_range(vmf, folio, page, nr_pages, addr);
> +       type =3D is_cow ? MM_ANONPAGES : mm_counter_file(folio);
> +       add_mm_counter(vma->vm_mm, type, nr_pages);
> +       ret =3D 0;
> +
> +unlock:
>         pte_unmap_unlock(vmf->pte, vmf->ptl);
>         return ret;
>  }
> --
> 2.39.3
>

