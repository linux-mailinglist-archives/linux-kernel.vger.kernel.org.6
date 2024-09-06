Return-Path: <linux-kernel+bounces-318067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3696E7F0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B62286310
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2568022334;
	Fri,  6 Sep 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="trTtWYnu"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AD3D68
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725591650; cv=none; b=F+cy5AfhaqafMu/XLs+UpLoyY27ydsXAhtxguP4hafKLLcvB6RB70z5BKrpV0f4yOddsHD9LLatYoosF/4hKAtehNYOAmKbkY4jOoKtUgE3MKD3yrLrI+jslUGZr+IpSHo9qGME9nyM67BuvRAsCHHPkG7b9aUqfgdIjqE7fWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725591650; c=relaxed/simple;
	bh=aPuZwJuBg5VWysrUAu9Ahiw7Xv/H487l+Hj806f5kcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceXMovdchraYw2gJGN25Cy3RbdPiwqqCv64GsOirbtpUh23gbzsy+wSSosLMfGQtCw7v+/F0q5iR1/d6AvK1ibDudxbQkBg3r1GGPFEQIpxG2Ei04tzEKX/fyiKZ7LptFOzB9vX3vIL9PqzFgZskajqVDb47iUHMm0w1hcRtwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=trTtWYnu; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-457c6389a3aso97271cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 20:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725591647; x=1726196447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTsFBCFFaXLue3y9fxeSovsc+6lMLee2VRnbsZWDcbI=;
        b=trTtWYnuIFOQS2wplMu13VbvThb7H4kZkWuVIl4US+OL4Kj71EO6WEBhXUEO66Sd4W
         gfq9epKhhmtCnV3cR9oOZlHOrzcz5sKYsGOH9fjfdSvpH+ArZOC5snJD+MI3JUB5I6JR
         53ODifiV6/H2+KfW9Yx0OE88990mRsph9T9j+DZidnjsgi2YJk68EOOHdgZu77Jx9Zo5
         sfmRKyCDVUNbY4LRGMpWorwWQKVer9rLH3Ah1/3PUJOpKHOpKfADF61Le5t1vCcFLKT6
         lDTK4Jln5RoOFkcuOqrFMlSbpUmk9OjlqzsyiND6BdIDIhbDgsFd36SXhAdwB0uDSKf1
         N1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725591647; x=1726196447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTsFBCFFaXLue3y9fxeSovsc+6lMLee2VRnbsZWDcbI=;
        b=XF+8c0BbhPcOmuy8ihnZolD43Zj97U30l0c5YzVFoq4FuOcZHNzZ5ywQn+x8d6wP4H
         DExrXMl9/ZSrM9q1s1rpcRf/piTvBd/sEGXy7fDZWXq72WFU+XE6l8Xn+fMIroKtbVmL
         R7GgT7BAY57otC+rqqajRbCAtPQYbeMApMU5ZcTBWFm7EOlq/ZPtnbUAhaKPwCdZ7c24
         EUk59tlL8SmgLuMSm9eAfgabhdKq1anUMrj8Qn0sbDfPXHybrH+alH9UsJZpX1xvxy9W
         SKoVIa4cnhwon0x/x0XOrXNLez/2lVxVqbYLAU3feIBQ2hTeF20ozoLbUm11TAvwP4I6
         R0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfntWcf+CjlCOCo2CGetJZOLiaDl2Ct5FfGCNk/grt2m1lrLKY6Gz1lDrmVD2fL1CGysMUiQrpA7Tcl3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGXHaJem6kpuZCLaUGdwj57a3RUevypeIcdZg8cDC13zwG3BH
	C9BCNqcuCSCx0gniTQuSwRM3UsFR8Lxin6jV0S8biFTr+mXM70IRXHteufMCyV2kvJPjMm/xWJ4
	pxyVUR3bkQJgWyrPzTGR8mevSEnb8qyWT63i3
X-Google-Smtp-Source: AGHT+IGFhlRcKSnHb7qnr3x+BEWd0gahj8Hw8W2cGgAhJIvbRKdGt/cZk32y1QzFyFfzc119DwH5CPb0vdMQd13+ZBc=
X-Received: by 2002:ac8:5852:0:b0:456:9498:6b53 with SMTP id
 d75a77b69052e-4580e501817mr766401cf.16.1725591647062; Thu, 05 Sep 2024
 20:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903213649.3566695-1-yuzhao@google.com> <20240903213649.3566695-2-yuzhao@google.com>
In-Reply-To: <20240903213649.3566695-2-yuzhao@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 5 Sep 2024 20:00:35 -0700
Message-ID: <CAJuCfpFdFjf7CCu_=PkUJdxbMH9+zE4wsifaqXiQakhBBiFW8A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 2/3] mm/codetag: fix pgalloc_tag_split()
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:36=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> Only tag the new head pages when splitting one large folio to multiple
> ones of a lower order. Tagging tail pages can cause imbalanced "calls"
> counters, since only head pages are untagged by pgalloc_tag_sub() and
> reference counts on tail pages are leaked, e.g.,
>   # echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
>   # echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   # time echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>   # grep alloc_gigantic_folio /proc/allocinfo
>
> Before this patch:
>   0  549427200  mm/hugetlb.c:1549 func:alloc_gigantic_folio
>
>   real  0m2.057s
>   user  0m0.000s
>   sys   0m2.051s
>
> After this patch:
>   0          0  mm/hugetlb.c:1549 func:alloc_gigantic_folio
>
>   real  0m1.711s
>   user  0m0.000s
>   sys   0m1.704s
>
> Not tagging tail pages also improves the splitting time, e.g., by
> about 15% when demoting 1GB hugeTLB folios to 2MB ones, as shown
> above.
>
> Fixes: be25d1d4e822 ("mm: create new codetag references during page split=
ting")
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/mm.h          | 30 ++++++++++++++++++++++++++++++
>  include/linux/pgalloc_tag.h | 31 -------------------------------
>  mm/huge_memory.c            |  2 +-
>  mm/hugetlb.c                |  2 +-
>  mm/page_alloc.c             |  4 ++--
>  5 files changed, 34 insertions(+), 35 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b31d4bdd65ad..a07e93adb8ad 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4137,4 +4137,34 @@ void vma_pgtable_walk_end(struct vm_area_struct *v=
ma);
>
>  int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_=
addr_t *size);
>
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +static inline void pgalloc_tag_split(struct folio *folio, int old_order,=
 int new_order)
> +{
> +       int i;
> +       struct alloc_tag *tag;
> +       unsigned int nr_pages =3D 1 << new_order;
> +
> +       if (!mem_alloc_profiling_enabled())
> +               return;
> +
> +       tag =3D pgalloc_tag_get(&folio->page);
> +       if (!tag)
> +               return;
> +
> +       for (i =3D nr_pages; i < (1 << old_order); i +=3D nr_pages) {
> +               union codetag_ref *ref =3D get_page_tag_ref(folio_page(fo=
lio, i));
> +
> +               if (ref) {
> +                       /* Set new reference to point to the original tag=
 */
> +                       alloc_tag_ref_set(ref, tag);
> +                       put_page_tag_ref(ref);
> +               }
> +       }
> +}
> +#else /* !CONFIG_MEM_ALLOC_PROFILING */
> +static inline void pgalloc_tag_split(struct folio *folio, int old_order,=
 int new_order)
> +{
> +}
> +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> index 207f0c83c8e9..59a3deb792a8 100644
> --- a/include/linux/pgalloc_tag.h
> +++ b/include/linux/pgalloc_tag.h
> @@ -80,36 +80,6 @@ static inline void pgalloc_tag_sub(struct page *page, =
unsigned int nr)
>         }
>  }
>
> -static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
> -{
> -       int i;
> -       struct page_ext *first_page_ext;
> -       struct page_ext *page_ext;
> -       union codetag_ref *ref;
> -       struct alloc_tag *tag;
> -
> -       if (!mem_alloc_profiling_enabled())
> -               return;
> -
> -       first_page_ext =3D page_ext =3D page_ext_get(page);
> -       if (unlikely(!page_ext))
> -               return;
> -
> -       ref =3D codetag_ref_from_page_ext(page_ext);
> -       if (!ref->ct)
> -               goto out;
> -
> -       tag =3D ct_to_alloc_tag(ref->ct);
> -       page_ext =3D page_ext_next(page_ext);
> -       for (i =3D 1; i < nr; i++) {
> -               /* Set new reference to point to the original tag */
> -               alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), ta=
g);
> -               page_ext =3D page_ext_next(page_ext);
> -       }
> -out:
> -       page_ext_put(first_page_ext);
> -}
> -
>  static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
>  {
>         struct alloc_tag *tag =3D NULL;
> @@ -142,7 +112,6 @@ static inline void clear_page_tag_ref(struct page *pa=
ge) {}
>  static inline void pgalloc_tag_add(struct page *page, struct task_struct=
 *task,
>                                    unsigned int nr) {}
>  static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {=
}
> -static inline void pgalloc_tag_split(struct page *page, unsigned int nr)=
 {}
>  static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { ret=
urn NULL; }
>  static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned=
 int nr) {}
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0993dfe9ae94..aa8a4c938ba9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3244,7 +3244,7 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
>         /* Caller disabled irqs, so they are still disabled here */
>
>         split_page_owner(head, order, new_order);
> -       pgalloc_tag_split(head, 1 << order);
> +       pgalloc_tag_split(folio, order, new_order);

Looks like here and in the next diff you are fixing an additional bug.
I was assuming that we are always splitting into order-0 pages, which
is not the case anymore. It's worth mentioning that in the changelog.
With that added:

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
>         /* See comment in __split_huge_page_tail() */
>         if (folio_test_anon(folio)) {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3faf5aad142d..a8624c07d8bf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3778,7 +3778,7 @@ static long demote_free_hugetlb_folios(struct hstat=
e *src, struct hstate *dst,
>                 list_del(&folio->lru);
>
>                 split_page_owner(&folio->page, huge_page_order(src), huge=
_page_order(dst));
> -               pgalloc_tag_split(&folio->page, 1 <<  huge_page_order(src=
));
> +               pgalloc_tag_split(folio, huge_page_order(src), huge_page_=
order(dst));
>
>                 for (i =3D 0; i < pages_per_huge_page(src); i +=3D pages_=
per_huge_page(dst)) {
>                         struct page *page =3D folio_page(folio, i);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c242d61fc4fd..13ce8e8899ed 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2822,7 +2822,7 @@ void split_page(struct page *page, unsigned int ord=
er)
>         for (i =3D 1; i < (1 << order); i++)
>                 set_page_refcounted(page + i);
>         split_page_owner(page, order, 0);
> -       pgalloc_tag_split(page, 1 << order);
> +       pgalloc_tag_split(page_folio(page), order, 0);
>         split_page_memcg(page, order, 0);
>  }
>  EXPORT_SYMBOL_GPL(split_page);
> @@ -5020,7 +5020,7 @@ static void *make_alloc_exact(unsigned long addr, u=
nsigned int order,
>                 struct page *last =3D page + nr;
>
>                 split_page_owner(page, order, 0);
> -               pgalloc_tag_split(page, 1 << order);
> +               pgalloc_tag_split(page_folio(page), order, 0);
>                 split_page_memcg(page, order, 0);
>                 while (page < --last)
>                         set_page_refcounted(last);
> --
> 2.46.0.469.g59c65b2a67-goog
>

