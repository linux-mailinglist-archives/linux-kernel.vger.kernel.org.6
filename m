Return-Path: <linux-kernel+bounces-375163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DD39A91C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF771F23401
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973041E22E8;
	Mon, 21 Oct 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OytrXp+Y"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20381E22F6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545030; cv=none; b=BTjXn9zzRiDk9uPnNJtTbnDDNDfzcaD7QHN84UdkAUtKnZe4IH9abNLxpPZzdtRMTU4Wv288jpAu6JDX8oHsVxpFulTfZt1HJrNdPRz2M2Obra/fg0WIt2XG6l8TRYDFmwMIs7Kq4z/VFGD801B+ELZoE+7HnhmSG9sjTWBoUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545030; c=relaxed/simple;
	bh=5IIUFhB9sePGpz0UvFjR2T7FCcjJPQ8x1nt2FAFMzcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkIwoPm1L14K91G2apG9/Z9Ks3PbkCYiOowD5PCpwtNLyCKjO9XCrQaWWvsaLp20KUkNxcQwEi2EueSOpAeujLSowbNfxMHkjY9wITMxsWmfyVwBR1Rffhbrn4WSdvzsYxuJBf18mG18RRTMToWNAWSybSKNme/GVkz4piSXH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OytrXp+Y; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so5061772e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729545027; x=1730149827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGaNgV0yGhUkl94jFkqUnmK0xlXlM006gLHr3N50u1A=;
        b=OytrXp+YqyhAAI8HQWXOeh5NdL16ACr71196LzeNlhUsu92FEasp7a/yM33ekTrTDG
         Zs08sa/blWMsLHYTi5RWCTou/Jafpqtc2a2LTFZ0r0QCPOUsMu10Q1Pp4e9e1eP181CI
         9E7PJFZX8nALVA6PehBgOEoZ4AzBSr6BiX1UJg3x820WwueWDdeJKivs2iOdgYvPSgq+
         Pk8xO6/atfCKbkiU2JSDBsTB+daoUWsVfDfbrh+wsm93YN/+yfVaDy7PHNLTKbbZCp1I
         U5e0iJBQEIbhTLZ2x4wFhjIS+qhdh+t7qwbOeRfXYxspXRqJFbsWJIXYXEeIi9OdEcMa
         4ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545027; x=1730149827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGaNgV0yGhUkl94jFkqUnmK0xlXlM006gLHr3N50u1A=;
        b=p+th31PKGyG8aegFV1y/emsPTuec9T98yzfqkZWLU6EpQdZB97P0swJcxoKO+gbjSJ
         2rcXf/ohDXblYSZyxx5crI1T1p7/QyZsLyCV/b6IjRzJlqg9Z4VSBEtL4SmDB/Vz7kxa
         Uj6qZCbLBcZSTA8D5sQtB1PzEFiVhY6wI8VU/Vk9o3yd6298WvbTRv+YiVzD0gKkkpL3
         UqPz7d/aBK/3PWwsR3k5veV3xn70RWPPjlAcSM4axGJP9bBeBgcbTFecJZkjT2TMYFF+
         +Fn6aTwCQ99EFArOfgettXUBdnUKcfd5hunQApxwhW4LyrwRKGas2ZPLRyVTq50P5Kmq
         8rDg==
X-Forwarded-Encrypted: i=1; AJvYcCWi/JY4GIiFQ//AfJEcH+aDHl6KRE2rhPYgcjCYJsz5gUXg4qJop/Wo4reFAabt9ApvJu++COHdK36aG3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRmDumYpJHQJWrd3Y71S3rXwAq/PsxKp34pEwNCZl4/QMV8nAT
	U+nGlmlWUFu7ECICx6J/B7Ely17n9YLkM6241ylfqZFPPSEUkcUG3jH4jZZwoPXVhQkwLZmR+iE
	Xh6XWCfltoIsDB4GnrciGsy6NnZVHKLCL9Oci
X-Google-Smtp-Source: AGHT+IH1UKPItaNggnum/3HGt/QwNhyRPmr6T8JA58WOYdnUxoMuqAbfHyTjT6Sc+2PC+sqJEVSMurrFtH3WTqnUMRI=
X-Received: by 2002:a05:6512:3b13:b0:539:e911:d20e with SMTP id
 2adb3069b0e04-53b13a2213fmr149122e87.47.1729545026794; Mon, 21 Oct 2024
 14:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com> <20241018105026.2521366-2-usamaarif642@gmail.com>
In-Reply-To: <20241018105026.2521366-2-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 21 Oct 2024 14:09:48 -0700
Message-ID: <CAJD7tkYEe10Xw-8azM-80pHv6YjvosZDHTdZfYttAuD5u1+s8A@mail.gmail.com>
Subject: Re: [RFC 1/4] mm/zswap: skip swapcache for swapping in zswap pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
	Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:50=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> As mentioned in [1], there is a significant improvement in no
> readahead swapin performance for super fast devices when skipping
> swapcache.

FYI, Kairui was working on removing the swapcache bypass completely,
which I think may be a good thing:
https://lore.kernel.org/lkml/20240326185032.72159-1-ryncsn@gmail.com/

However, that series is old, since before the large folio swapin
support, so I am not sure if/when he intends to refresh it.

In his approach there is still a swapin path for synchronous swapin
though, which we can still utilize for zswap.

>
> With large folio zswapin support added in later patches, this will also
> mean this path will also act as "readahead" by swapping in multiple
> pages into large folios. further improving performance.
>
> [1] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@=
kernel.org/T/#m5a792a04dfea20eb7af4c355d00503efe1c86a93
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/zswap.h |  6 ++++++
>  mm/memory.c           |  3 ++-
>  mm/page_io.c          |  1 -
>  mm/zswap.c            | 46 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index d961ead91bf1..e418d75db738 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -27,6 +27,7 @@ struct zswap_lruvec_state {
>  unsigned long zswap_total_pages(void);
>  bool zswap_store(struct folio *folio);
>  bool zswap_load(struct folio *folio);
> +bool zswap_present_test(swp_entry_t swp, int nr_pages);
>  void zswap_invalidate(swp_entry_t swp);
>  int zswap_swapon(int type, unsigned long nr_pages);
>  void zswap_swapoff(int type);
> @@ -49,6 +50,11 @@ static inline bool zswap_load(struct folio *folio)
>         return false;
>  }
>
> +static inline bool zswap_present_test(swp_entry_t swp, int nr_pages)
> +{
> +       return false;
> +}
> +
>  static inline void zswap_invalidate(swp_entry_t swp) {}
>  static inline int zswap_swapon(int type, unsigned long nr_pages)
>  {
> diff --git a/mm/memory.c b/mm/memory.c
> index 03e5452dd0c0..49d243131169 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4289,7 +4289,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         swapcache =3D folio;
>
>         if (!folio) {
> -               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> +               if ((data_race(si->flags & SWP_SYNCHRONOUS_IO) ||
> +                   zswap_present_test(entry, 1)) &&
>                     __swap_count(entry) =3D=3D 1) {
>                         /* skip swapcache */
>                         folio =3D alloc_swap_folio(vmf);
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4aa34862676f..2a15b197968a 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -602,7 +602,6 @@ void swap_read_folio(struct folio *folio, struct swap=
_iocb **plug)
>         unsigned long pflags;
>         bool in_thrashing;
>
> -       VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, fol=
io);
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>         VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7f00cc918e7c..f4b03071b2fb 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1576,6 +1576,52 @@ bool zswap_store(struct folio *folio)
>         return ret;
>  }
>
> +static bool swp_offset_in_zswap(unsigned int type, pgoff_t offset)
> +{
> +       return (offset >> SWAP_ADDRESS_SPACE_SHIFT) <  nr_zswap_trees[typ=
e];

I am not sure I understand what we are looking for here. When does
this return false? Aren't the zswap trees always allocated during
swapon?

> +}
> +
> +/* Returns true if the entire folio is in zswap */

There isn't really a folio at this point, maybe "Returns true if the
entire range is in zswap"?

Also, this is racy because an exclusive load, invalidation, or
writeback can cause an entry to be removed from zswap. Under what
conditions is this safe? The caller can probably guarantee we don't
race against invalidation, but can we guarantee that concurrent
exclusive loads or writebacks don't happen?

If the answer is yes, this needs to be properly documented.

> +bool zswap_present_test(swp_entry_t swp, int nr_pages)
> +{
> +       pgoff_t offset =3D swp_offset(swp), tree_max_idx;
> +       int max_idx =3D 0, i =3D 0, tree_offset =3D 0;
> +       unsigned int type =3D swp_type(swp);
> +       struct zswap_entry *entry =3D NULL;
> +       struct xarray *tree;
> +
> +       while (i < nr_pages) {
> +               tree_offset =3D offset + i;
> +               /* Check if the tree exists. */
> +               if (!swp_offset_in_zswap(type, tree_offset))
> +                       return false;
> +
> +               tree =3D swap_zswap_tree(swp_entry(type, tree_offset));
> +               XA_STATE(xas, tree, tree_offset);

Please do not mix declarations with code.

> +
> +               tree_max_idx =3D tree_offset % SWAP_ADDRESS_SPACE_PAGES ?
> +                       ALIGN(tree_offset, SWAP_ADDRESS_SPACE_PAGES) :
> +                       ALIGN(tree_offset + 1, SWAP_ADDRESS_SPACE_PAGES);

Does this work if we always use ALIGN(tree_offset + 1,
SWAP_ADDRESS_SPACE_PAGES)?

> +               max_idx =3D min(offset + nr_pages, tree_max_idx) - 1;
> +               rcu_read_lock();
> +               xas_for_each(&xas, entry, max_idx) {
> +                       if (xas_retry(&xas, entry))
> +                               continue;
> +                       i++;
> +               }
> +               rcu_read_unlock();
> +               /*
> +                * If xas_for_each exits because entry is NULL and

nit: add () to the end of function names (i.e. xas_for_each())

> +                * the number of entries checked are less then max idx,

s/then/than

> +                * then zswap does not contain the entire folio.
> +                */
> +               if (!entry && offset + i <=3D max_idx)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  bool zswap_load(struct folio *folio)
>  {
>         swp_entry_t swp =3D folio->swap;
> --
> 2.43.5
>

