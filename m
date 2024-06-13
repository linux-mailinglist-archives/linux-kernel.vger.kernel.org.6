Return-Path: <linux-kernel+bounces-212851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F10C906737
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A84282DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B1513DDDC;
	Thu, 13 Jun 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhz8vEyH"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E369142E83
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267981; cv=none; b=jrzvZMU5b0KA7ypmg5zvegKovr+K02CRFriAP+0enEHOapN5VN2h1UNLQP5SnQI4Uhd06eiq8XrRutmz/yu9E2PXzvEi0BlNzUhDu3NsbVog7vj7O68y2k2t5pws2atk1amw1icLGgjhylK4mnZwXHTNS69AVt0byOcWr1R8IQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267981; c=relaxed/simple;
	bh=uDr6HxWvHhfShcXc4vQONpTIMWmLy3ZwtLrYu4MX2p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ak5ZW1wcy1f/JZ8cSvIpWXwRk2/jkqGI4CKZDkt3cKxcoLIJIUCPH+ZMzMt0oaDht6t2drbSbYsA5cDotLMLXGiaglnHCS7GFxgHqaHzjjnuVfzLDQERtXzM5SmVo6yZo9L/gVp8vHaW32WZ81dg8bQHoaS0oIbKUEh23Icb7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhz8vEyH; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80b8e5cab7bso222328241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718267978; x=1718872778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npy/tVALy92xNTq5ifJYDeAYI5e9q2XgMxsDAa0dZso=;
        b=bhz8vEyHXwCG64HNefKVhNkiqU95TYiVTqIzpFfS2OaOxeqZbriN2MPLyU1tAhZXQu
         w5j7vU9zrb+h8vi9cIiuvtoXNjEKLKAaTx6ZrS8WnhJYvSVJkWJ9Y4v1U7RLTVQrrkhB
         uR+vPqVvtWGTgNIvrZz/Z1kzfANd+wb6sW9JA43gwRnJGn3qK/KAo35/Hqj0bj9WunTd
         S1w8conszpyGcw5rWa+TtmVNsiEumd5nhJ4rasRUeQjrh7ATNhgZJ1HXLkLSU0VUMitq
         izVFGFSQ1kXAiMnH1xiIb0rYQnyRvPFAzDxX3Zdds4ORxhH/h56ngqbCE1yQornIpFsA
         QTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267978; x=1718872778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npy/tVALy92xNTq5ifJYDeAYI5e9q2XgMxsDAa0dZso=;
        b=u1Pa5zX7EsBp4JvWQK17ejtrsLSZe6/ApJ0wskVFH0CAHyT4a3OwIlDrNOmeXasV2n
         EPWjyy0ndZSs4U63a/poaD6nSILJKn1ygcOWUca5T7srfNYZOZAgtDFz8AMPH4cdAygr
         //NzkwWZBeAcz8HHdi+SlKmrCyWamHKXlU9iu9HE7iLzjjomqlyxDCJ4vqkSMvNjRLtb
         KdJq9wCQaSJ3d3hC6YRXM3d2q3iKtv0GwKieIuR9mMDCRydhFPueoOHEsGQqZQW3pOwg
         AiFsr7PCmwrBss/GjZUZTS1xVE0HvFs5DvrCv2r/TwKgWZPKiZJqccyfMjGaOnsaZSA+
         bRSw==
X-Forwarded-Encrypted: i=1; AJvYcCWIrP9G1IOFI6vRInD2G5QvkvTZyz49rnuM+TXK2cbHQzwA6fxYMAZIbs7RpQjU4CWwylzGT0AWd1paXlC6SL0vDADhZaGaf6sQAV00
X-Gm-Message-State: AOJu0Yxu8SRjqXkrvSO+uYBnNkmOP8u4gxIHjfDClcDSk0Q8sEFlMMPo
	O/CrzY68Xzl6IkKU6XBz+ZAAFFpFF2T/2WM/nPKu/MlGL2FbNp70Z6Wh7mmZ1tZsq4EEDq8XpKQ
	HK+owaYfnSy1TCxPpt6ELaoPuRl0=
X-Google-Smtp-Source: AGHT+IGI3v7bwhyn4kqTRc4d3er1NrJnAX685qyVCqxNRSRto/Wbh8/qblcWI068rxwMykFYpbKKNPUfb6m9w5bnavk=
X-Received: by 2002:a67:fd0e:0:b0:48c:374c:b30c with SMTP id
 ada2fe7eead31-48d91db93bfmr4478589137.9.1718267978042; Thu, 13 Jun 2024
 01:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613000721.23093-1-21cnbao@gmail.com> <20240613000721.23093-2-21cnbao@gmail.com>
In-Reply-To: <20240613000721.23093-2-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 13 Jun 2024 20:39:26 +1200
Message-ID: <CAGsJ_4wKCEHcSMz0Zu+dFH4wR2memTLtf9Cv5EsaxwbA5+jA-A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] mm: extend rmap flags arguments for folio_add_new_anon_rmap
To: david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	ryan.roberts@arm.com, baolin.wang@linux.alibaba.com, yosryahmed@google.com, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 12:07=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> In the case of do_swap_page(), a new anonymous folio isn=E2=80=99t necess=
arily
> exclusive. This patch extends the rmap flags to allow treating a new
> anon folio as either exclusive or non-exclusive. To maintain the current
> behavior, we always use EXCLUSIVE as arguments.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/rmap.h    |  2 +-
>  kernel/events/uprobes.c |  2 +-
>  mm/huge_memory.c        |  2 +-
>  mm/khugepaged.c         |  2 +-
>  mm/memory.c             | 10 +++++-----
>  mm/migrate_device.c     |  2 +-
>  mm/rmap.c               | 15 +++++++++------
>  mm/swapfile.c           |  2 +-
>  mm/userfaultfd.c        |  2 +-
>  9 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index cae38a2a643d..01a64e7e72b9 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -244,7 +244,7 @@ void folio_add_anon_rmap_ptes(struct folio *, struct =
page *, int nr_pages,
>  void folio_add_anon_rmap_pmd(struct folio *, struct page *,
>                 struct vm_area_struct *, unsigned long address, rmap_t fl=
ags);
>  void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
> -               unsigned long address);
> +               unsigned long address, rmap_t flags);
>  void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_page=
s,
>                 struct vm_area_struct *);
>  #define folio_add_file_rmap_pte(folio, page, vma) \
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2c83ba776fc7..c20368aa33dd 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -181,7 +181,7 @@ static int __replace_page(struct vm_area_struct *vma,=
 unsigned long addr,
>
>         if (new_page) {
>                 folio_get(new_folio);
> -               folio_add_new_anon_rmap(new_folio, vma, addr);
> +               folio_add_new_anon_rmap(new_folio, vma, addr, RMAP_EXCLUS=
IVE);
>                 folio_add_lru_vma(new_folio, vma);
>         } else
>                 /* no new page, just dec_mm_counter for old_page */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f409ea9fcc18..09a83e43c71a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -973,7 +973,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct=
 vm_fault *vmf,
>
>                 entry =3D mk_huge_pmd(page, vma->vm_page_prot);
>                 entry =3D maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> -               folio_add_new_anon_rmap(folio, vma, haddr);
> +               folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE=
);
>                 folio_add_lru_vma(folio, vma);
>                 pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable)=
;
>                 set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 774a97e6e2da..4d759a7487d0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1213,7 +1213,7 @@ static int collapse_huge_page(struct mm_struct *mm,=
 unsigned long address,
>
>         spin_lock(pmd_ptl);
>         BUG_ON(!pmd_none(*pmd));
> -       folio_add_new_anon_rmap(folio, vma, address);
> +       folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>         folio_add_lru_vma(folio, vma);
>         pgtable_trans_huge_deposit(mm, pmd, pgtable);
>         set_pmd_at(mm, address, pmd, _pmd);
> diff --git a/mm/memory.c b/mm/memory.c
> index 54d7d2acdf39..2f94921091fb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -930,7 +930,7 @@ copy_present_page(struct vm_area_struct *dst_vma, str=
uct vm_area_struct *src_vma
>         *prealloc =3D NULL;
>         copy_user_highpage(&new_folio->page, page, addr, src_vma);
>         __folio_mark_uptodate(new_folio);
> -       folio_add_new_anon_rmap(new_folio, dst_vma, addr);
> +       folio_add_new_anon_rmap(new_folio, dst_vma, addr, RMAP_EXCLUSIVE)=
;
>         folio_add_lru_vma(new_folio, dst_vma);
>         rss[MM_ANONPAGES]++;
>
> @@ -3400,7 +3400,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf=
)
>                  * some TLBs while the old PTE remains in others.
>                  */
>                 ptep_clear_flush(vma, vmf->address, vmf->pte);
> -               folio_add_new_anon_rmap(new_folio, vma, vmf->address);
> +               folio_add_new_anon_rmap(new_folio, vma, vmf->address, RMA=
P_EXCLUSIVE);
>                 folio_add_lru_vma(new_folio, vma);
>                 BUG_ON(unshare && pte_write(entry));
>                 set_pte_at(mm, vmf->address, vmf->pte, entry);
> @@ -4337,7 +4337,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>
>         /* ksm created a completely new copy */
>         if (unlikely(folio !=3D swapcache && swapcache)) {
> -               folio_add_new_anon_rmap(folio, vma, address);
> +               folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSI=
VE);
>                 folio_add_lru_vma(folio, vma);
>         } else {
>                 folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, addr=
ess,
> @@ -4592,7 +4592,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
>  #endif
> -       folio_add_new_anon_rmap(folio, vma, addr);
> +       folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
>         folio_add_lru_vma(folio, vma);
>  setpte:
>         if (vmf_orig_pte_uffd_wp(vmf))
> @@ -4790,7 +4790,7 @@ void set_pte_range(struct vm_fault *vmf, struct fol=
io *folio,
>         /* copy-on-write page */
>         if (write && !(vma->vm_flags & VM_SHARED)) {
>                 VM_BUG_ON_FOLIO(nr !=3D 1, folio);
> -               folio_add_new_anon_rmap(folio, vma, addr);
> +               folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE)=
;
>                 folio_add_lru_vma(folio, vma);
>         } else {
>                 folio_add_file_rmap_ptes(folio, page, nr, vma);
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 051d0a3ccbee..6d66dc1c6ffa 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -658,7 +658,7 @@ static void migrate_vma_insert_page(struct migrate_vm=
a *migrate,
>                 goto unlock_abort;
>
>         inc_mm_counter(mm, MM_ANONPAGES);
> -       folio_add_new_anon_rmap(folio, vma, addr);
> +       folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
>         if (!folio_is_zone_device(folio))
>                 folio_add_lru_vma(folio, vma);
>         folio_get(folio);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b9e5943c8349..e612d999811a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1406,14 +1406,14 @@ void folio_add_anon_rmap_pmd(struct folio *folio,=
 struct page *page,
>   * This means the inc-and-test can be bypassed.
>   * The folio does not have to be locked.
>   *
> - * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
> - * is new, it's assumed to be mapped exclusively by a single process.
> + * If the folio is pmd-mappable, it is accounted as a THP.
>   */
>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct =
*vma,
> -               unsigned long address)
> +               unsigned long address, rmap_t flags)
>  {
>         int nr =3D folio_nr_pages(folio);
>         int nr_pmdmapped =3D 0;
> +       bool exclusive =3D flags & RMAP_EXCLUSIVE;
>
>         VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>         VM_BUG_ON_VMA(address < vma->vm_start ||
> @@ -1424,7 +1424,8 @@ void folio_add_new_anon_rmap(struct folio *folio, s=
truct vm_area_struct *vma,
>         if (likely(!folio_test_large(folio))) {
>                 /* increment count (starts at -1) */
>                 atomic_set(&folio->_mapcount, 0);
> -               SetPageAnonExclusive(&folio->page);
> +               if (exclusive)
> +                       SetPageAnonExclusive(&folio->page);
>         } else if (!folio_test_pmd_mappable(folio)) {
>                 int i;
>
> @@ -1433,7 +1434,8 @@ void folio_add_new_anon_rmap(struct folio *folio, s=
truct vm_area_struct *vma,
>
>                         /* increment count (starts at -1) */
>                         atomic_set(&page->_mapcount, 0);
> -                       SetPageAnonExclusive(page);
> +                       if (exclusive)
> +                               SetPageAnonExclusive(page);
>                 }
>
>                 /* increment count (starts at -1) */
> @@ -1445,7 +1447,8 @@ void folio_add_new_anon_rmap(struct folio *folio, s=
truct vm_area_struct *vma,
>                 /* increment count (starts at -1) */
>                 atomic_set(&folio->_large_mapcount, 0);
>                 atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
> -               SetPageAnonExclusive(&folio->page);
> +               if (exclusive)
> +                       SetPageAnonExclusive(&folio->page);
>                 nr_pmdmapped =3D nr;
>         }
>

I am lacking this:

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1408,7 +1408,7 @@ void folio_add_new_anon_rmap(struct folio
*folio, struct vm_area_struct *vma,
        VM_BUG_ON_VMA(address < vma->vm_start ||
                        address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
        __folio_set_swapbacked(folio);
-       __folio_set_anon(folio, vma, address, true);
+       __folio_set_anon(folio, vma, address, exclusive);

        if (likely(!folio_test_large(folio))) {
                /* increment count (starts at -1) */


> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9c6d8e557c0f..ae1d2700f6a3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1911,7 +1911,7 @@ static int unuse_pte(struct vm_area_struct *vma, pm=
d_t *pmd,
>
>                 folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flag=
s);
>         } else { /* ksm created a completely new copy */
> -               folio_add_new_anon_rmap(folio, vma, addr);
> +               folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE)=
;
>                 folio_add_lru_vma(folio, vma);
>         }
>         new_pte =3D pte_mkold(mk_pte(page, vma->vm_page_prot));
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 5e7f2801698a..8dedaec00486 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -216,7 +216,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
>                         folio_add_lru(folio);
>                 folio_add_file_rmap_pte(folio, page, dst_vma);
>         } else {
> -               folio_add_new_anon_rmap(folio, dst_vma, dst_addr);
> +               folio_add_new_anon_rmap(folio, dst_vma, dst_addr, RMAP_EX=
CLUSIVE);
>                 folio_add_lru_vma(folio, dst_vma);
>         }
>
> --
> 2.34.1
>

