Return-Path: <linux-kernel+bounces-198612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68458D7AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D58B1F21D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1C219E8;
	Mon,  3 Jun 2024 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjQrx3qg"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6422031D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 05:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717392542; cv=none; b=t2B8xiGJKOogSZQnECpnchCl25mK04y/yfoB4w+avAdyr6vRTxYiFne1Ew3bqwuHk+LZ4qbDi+gmkzUSqs7vcXor+wBA65+EuEbNagNstigkl/yIiQp1kIFWImbvyO2QFQ/JWtJ39latYUvZQooJNiTuzQRShf98c2/jWynr9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717392542; c=relaxed/simple;
	bh=dS2QYIGs3VjLxafKqf7jbo77fQ5K3RDxnTa1UIFBxo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaFkNpuqb9/8sf28V+vLctjo34XAK7qn9VUIQY1zZHczpzfQy7xKCj3Fm2Rhti5/sf7rws6W1TqVkPYkK07V2pl9QRFfgnHeE6fSG3OZZKvPceyN3aUBJtBdiIMDTSGBo61FANUrSTVxmcKFOM10mVzV8PQde2vcZWEm4W0hWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjQrx3qg; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4eb02c0c851so1129906e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717392540; x=1717997340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0C+djLy3MXJYIEa6rJxljDWo2CMo+1PKaqWv7bB1U8=;
        b=fjQrx3qggNlnX8hjD5lv9Ievp7tgGJEquwyYF5i7U9snX+Vsn8nm/+xynbCqw4K9WM
         11IGbPGkGJ5w02FFVV9t4qKU6tky9MTShvlD7G5sUpW9n+efLdgvV579Tj/BxetYeiQv
         NRfe/simbDTxdossQ1YlHSrtfXA8wo7vgsj+gbY0IHjalCQcmsHD4Y081BoMN5+Hj0FQ
         iOmtv2sP2utpGBcz9iTH1u9XbYgRDsdkMOilJfOOdiYAUkmDnE/vQz/+jAIqwqXBO5SD
         lEN4OX/ja0M2mkNZwR8lF/YCjFTLVoYKW+u18Uim1zrSAeqiNOsIFWWJif1NdwLIqtO/
         o9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717392540; x=1717997340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0C+djLy3MXJYIEa6rJxljDWo2CMo+1PKaqWv7bB1U8=;
        b=U0TthgOuVbBmS57+6gK2ywm7g8sMEmefEAmOcxyCUVIM0kWKKKh207ZPZB1gl+6lTI
         Q0ogmYLlSRl6ySSgV+cV9s4CXpUspL9nJ4s7/3KdY6KhUVfr8S7HIkLf/fv54LTfOp1R
         styT2clVYla+EAy2g8oBK0FusJQuvU1Spob2PFSxTR55dVuxqTVxJ5/Im8PkP5+yo5Hh
         nQCy/OwpMgdAE9biZi+AUFTJ3A9m4FTowxIV2DfSJib3VNnLPvqrK5raK1vZ7DXoTTjL
         w4aB9Ynpz/s/jkY1l5xcTPpkUgNLCDLSkn+oZD7kL8VKm64cQIknxfi7Yy0BzGT1DEC1
         1ewA==
X-Forwarded-Encrypted: i=1; AJvYcCWU6l9WxP3UU8nB8+k5b3TjpUNx4toORiuP7HAKby2/TQmT68SzxEcrUfznAru2MXOrsnvTVl3O7mUdypl5DMh0aH7do2DtsEi7hW7k
X-Gm-Message-State: AOJu0Yw92XnxrYl8dDD6ttvl/6zgqY+QWk1ufj8g/kGZQ/dm8T0yw0UE
	rcbNCEuhkDqElF1uNTXChKlH0/qh4R0im3JjhY5KiZds3C6T/bFm/tJUAjoBQs7N3fa9Qnq0ndD
	dezB73/qsDMzguo93jvSRKBZsWO8=
X-Google-Smtp-Source: AGHT+IHLV4FrSQQfyZhSbixlBJVKE5WxGGSJ/AhirATYsQGGWJMwykhGKOe/jc+jkdTuhw5x/kNa7XiWtHv/d1osufc=
X-Received: by 2002:a05:6122:e6f:b0:4e4:ed90:27cc with SMTP id
 71dfb90a1353d-4eb02d7cb9dmr6068331e0c.2.1717392538696; Sun, 02 Jun 2024
 22:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com> <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 3 Jun 2024 17:28:47 +1200
Message-ID: <CAGsJ_4z60mrjuQ5qKCKn0+knk_M1dy=NsH4nVLqe5Khue_5gFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm: memory: extend finish_fault() to support large folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 2:04=E2=80=AFPM Baolin Wang
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

I don't feel the comment explains the root cause.
For non-shmem, anyway we have allocated the memory? Avoiding inflating
RSS seems not so useful as we have occupied the memory. the memory footprin=
t
is what we really care about. so we want to rely on read-ahead hints of sub=
page
to determine read-ahead size? that is why we don't map nr_pages for non-shm=
em
files though we can potentially reduce nr_pages - 1 page faults?

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

In what case we can't use !pte_range_none(vmf->pte, 1) for nr_pages =3D=3D =
1
then unify the code for nr_pages=3D=3D1 and nr_pages > 1?

It seems this has been discussed before, but I forget the reason.

> +               for (i =3D 0; i < nr_pages; i++)
> +                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pt=
e + i);
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

Thanks
Barry

