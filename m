Return-Path: <linux-kernel+bounces-375165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF39A91C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7001C22279
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7004A1E22F8;
	Mon, 21 Oct 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AO2cA6zY"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20251E1045
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545128; cv=none; b=bdiAnV5Uh77hQjVoymJY5XP9O4VFHSrCutMNhUhy45l5FabqDZhn7YPoeoPH3LJj8ejmXzPOLeaGz9Ef3Dc0Fy2XTM1zO8iVRhzbnfxMyY2YZJalM32P2A6o5T759XVZroXqrUwWIRzVmMlDgDXaWWqw1+26Ie0tB8NpfiBcZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545128; c=relaxed/simple;
	bh=eWpP4knb0630Ur0JHkxtYGcw7w/Ru4t2RXOGZQQxa14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2O2oUvRKD9Pn1vahZ9b+HtAiJ1wP4UyV/slTIsDOm/+XyWUETliOv+nk94Ffr61pl8krY8V5yfOcpKkUf+Xp0ia7KBN0aVb3wh0rSkynqL5ucouCeBX1OT8JasRCES1iT0cakV+fqz5IWJPSfkvNqsDyFdSizzypI8+EfcWhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AO2cA6zY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a4031f69fso711279766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729545125; x=1730149925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxZWb+WS7qDoH32HBtuD0Xo9X4+gFBKJHHXT+qJNXmQ=;
        b=AO2cA6zY9oDltS8pi70ty3B+tnKVLe6S8sm3mAED30He+bXScLoRnZN4Hpk2iotMuU
         nNrN5U0xP3GkrBEGNVSVSs5YE2QrIA13YeMugf6hBrMBVkrsLlqnGThHwxgnV5v8GTgm
         g95kNmBlcmRE76jos7tnwPeLRxIg8RtRq0iVdSZTkuTzpJ7YxFavxjzALzIs5A2Lokxc
         DX4eomgGAtsYnrKfowbDmL3R8RN9+lklrGiaPKTulyIYbknaPEO+3/mblfc9ImX7mkQj
         Cxe//upjQz8us96YO0bfDNAbFGI63gashNH5n6dvOOl04GibjIDKLiYWtUFIbvqw8LhN
         +OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545125; x=1730149925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxZWb+WS7qDoH32HBtuD0Xo9X4+gFBKJHHXT+qJNXmQ=;
        b=WDZgJGv55Rh2YKwvdL0ltUQZib6r3vkiuKkV6XKVfI4TWsaInVKXIruPancV1KM+ln
         1BOb4Yf0kLOcL8ijMcfBeKkIL24gD/PgI/8+JYThe/ip3ev94nYVJnk65te25PVjtuH7
         WdF0Wc5QTahFNe/ky6Bv2SH4RM0ev6PTgXtBNwMwH3hr/du/nus5f3O4uLQIo3wBkJ0s
         wIUbaGQ49g/JHTqTg2qbE8HRzQ50YRwMh//sbnr+V/5IEo2bMkSD6sl2QacAdGG97IuU
         PIZl1SvwpNwHTkgPZ4SnphgiWcCB103gWi7vm4PHU/9c6rPASWnTm6cuT5m53sLiThv7
         bHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW93BwEVR/DPqbBhgkAXmlbbBMynHwo/CQFTycL82aVac0T7ZA+zZtDbYr0OFXTQhRHhf/tqXucyELmYQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBs6zRIWymX/yiK2+0mGzfY2QBt/p7uKtnk4aXa6tYlsM5oDi
	OPrAu/XfT74PQ+Rd6F9G1jaG75Ir4hAuD/lF18fXO2fbx6HSRZqcCtv1JHOxkgfZ6RjHx9LNRv2
	WGUvVG+FZmeNhBYVt/hf16YB5rWJZLD4ylOCU
X-Google-Smtp-Source: AGHT+IGfI7U1CpQcRa4n8SZQbKYJ/MwffcQXTK4JDslxT7srPqADrekslOpc2rstiPY3ZmcOcUZiV31xzp/1soR96HQ=
X-Received: by 2002:a17:907:7252:b0:a9a:134:9887 with SMTP id
 a640c23a62f3a-a9a69c9eb2dmr1252133066b.41.1729545124959; Mon, 21 Oct 2024
 14:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com> <20241018105026.2521366-2-usamaarif642@gmail.com>
In-Reply-To: <20241018105026.2521366-2-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 21 Oct 2024 14:11:29 -0700
Message-ID: <CAJD7tkYOGA2oQ=BSP3oXeV0Fh2=QRZZ=_5t2Wg6qrYZixCkZAg@mail.gmail.com>
Subject: Re: [RFC 1/4] mm/zswap: skip swapcache for swapping in zswap pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:50=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> As mentioned in [1], there is a significant improvement in no
> readahead swapin performance for super fast devices when skipping
> swapcache.
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
> +}
> +
> +/* Returns true if the entire folio is in zswap */
> +bool zswap_present_test(swp_entry_t swp, int nr_pages)

Also, did you check how the performance changes if we bring back the
bitmap of present entries (i.e. what used to be frontswap's bitmap)
instead of the tree lookups here?

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
> +
> +               tree_max_idx =3D tree_offset % SWAP_ADDRESS_SPACE_PAGES ?
> +                       ALIGN(tree_offset, SWAP_ADDRESS_SPACE_PAGES) :
> +                       ALIGN(tree_offset + 1, SWAP_ADDRESS_SPACE_PAGES);
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
> +                * the number of entries checked are less then max idx,
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

