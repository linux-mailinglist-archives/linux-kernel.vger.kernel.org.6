Return-Path: <linux-kernel+bounces-206896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C99900F6B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 06:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7021F229B2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 04:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774BDDDA;
	Sat,  8 Jun 2024 04:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BElwNTsw"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA53DDA0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820026; cv=none; b=SaNPP8Q3wnbUiFBZSu1jVADpjt7r2pvsU1oxsZquY2zCzs5FbzRch41X+IEWnpEW4ogDZcjzbc3PoXcLofus5lCIy3toeHlSzm3Q4hSsNTOPZY5/MDcIaWlGaTzh5/TIIIgwVK0H8zryKxxjbaUfaSxMp/hTUmu/QY6cf/glJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820026; c=relaxed/simple;
	bh=O400+9wVp3g3fp4A8Of/xElXZbCrroY8e0GKkhpzmwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXj61F+LgUH7wcO9UUcAcpBfPP8O3Sl3KsS3vH6gqxbTCN1fwU2dC8PYX5TzjtHT6qzivEaXNAnkDB8LXDmsyg2GSNuSqLg8UTiHlMpKJi9dsWodZ6c5t9W4zCjKDhtaYKcjJG0gzdsQFuRtPjKSA4KiMNbNgu6i+puYI8lCqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BElwNTsw; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4e4f0020ca3so913834e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717820023; x=1718424823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFzQjQZ4PGhanSjiQrmvBxDd4Mvj6fEelSJPr221TPE=;
        b=BElwNTswZuhyh2iC0F8/URyNhDEoSSJevyUWpWb5Zt2MFtSROH/cFp7AY6B2HvKDpB
         yAo/fVzCI7QFIEe3Nap+YQW0adYSRKkI+UGG20HhGgwa/pFsfJNJVG67RvZm1dC9DOl1
         4xp9CXSt1E7Rj/nsDUvhxpFPudxnrBwN1vqY3zLqtHp1va4juCx0PLvwLJIo9xzVz+K/
         XaDBVQcHbV4K1Gm5VusC6hBj5lbjfc2VfWV7NOuIDz0Wzd7io7PeazhbHNrGY3r3sXvU
         Cziywtpfv94+QiM9mpRhgb9SqhpzF2mXUYjllDQDK1L4KmLxbj2ZotgfB3ZH2IQyL08c
         ISLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717820023; x=1718424823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFzQjQZ4PGhanSjiQrmvBxDd4Mvj6fEelSJPr221TPE=;
        b=Hl2TpiOlOBlcQW1THtHaYRkdG96wvgrVVMh4W5R7l1+yKpJGM/hiQiGZzXCYltsGrS
         wDdOgtrqVfnaiVXWEDPLAGjHHBnd0Xcjg6xcQEtzmG59UVGmOXCNUcEGCUnRld15tQk2
         /a5WkiMC8cxAI3lr/+NOgxG+JYQsFZsWMP/sIMir+fdNnf3UbgzMZta4nFCfqb6lcQ47
         aXZb/rLEGfO4CLQqoK9MpiyuFn+NjNAw7fwqAC80yDQ/TWgDocKoCo1s3Wt4IVtVB781
         vZUdIicBIhlyCV4jcusnJpNp4llkT3bV7g4VXQbH+P2qRnB8ks4nh+GHqyHhT32G03SJ
         Xdlw==
X-Forwarded-Encrypted: i=1; AJvYcCXPHFtPM0Ucr7x6O5rnJdmMoTFjy3yXF9z/z6kxPSM6rVvdOUQKeckxP6vQNOiklDy8KefURYRgXX1LKsZR97NP2pvvpHyW8BmUTG+U
X-Gm-Message-State: AOJu0YyAJBq3BL69HwgncusoSUNWQO7G470kOUVzIii2OH111FAMdPEN
	rNB8ozpYukwNYNiQCmHGLJslPt4PhYp4cGltINHZd8McnYqcg7t1RKUV6mvb5fzUkI1SVKiBGCE
	UfxU4NOEi2LYnij+UPxBjtKcNHRA=
X-Google-Smtp-Source: AGHT+IGB8gyEbx6UGGRkv/k8uHrQLYHd4Vp+ytT1kbDHAym/H76aBq32J8T6UxuIa9sjwIdW6m+nZoX1Z8m3CveKiHo=
X-Received: by 2002:a05:6122:4124:b0:4d3:31fc:4839 with SMTP id
 71dfb90a1353d-4eb5621b763mr4883410e0c.2.1717820023430; Fri, 07 Jun 2024
 21:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
In-Reply-To: <20240608023654.3513385-1-yosryahmed@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 8 Jun 2024 11:13:24 +0800
Message-ID: <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 10:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Zswap does not support storing or loading large folios. Until proper
> support is added, attempts to load large folios from zswap are a bug.
>
> For example, if a swapin fault observes that contiguous PTEs are
> pointing to contiguous swap entries and tries to swap them in as a large
> folio, swap_read_folio() will pass in a large folio to zswap_load(), but
> zswap_load() will only effectively load the first page in the folio. If
> the first page is not in zswap, the folio will be read from disk, even
> though other pages may be in zswap.
>
> In both cases, this will lead to silent data corruption. Proper support
> needs to be added before large folio swapins and zswap can work
> together.
>
> Looking at callers of swap_read_folio(), it seems like they are either
> allocated from __read_swap_cache_async() or do_swap_page() in the
> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so
> everything is fine for now.
>
> However, there is ongoing work to add to support large folio swapins
> [1]. To make sure new development does not break zswap (or get broken by
> zswap), add minimal handling of incorrect loads of large folios to
> zswap.
>
> First, move the call folio_mark_uptodate() inside zswap_load().
>
> If a large folio load is attempted, and any page in that folio is in
> zswap, return 'true' without calling folio_mark_uptodate(). This will
> prevent the folio from being read from disk, and will emit an IO error
> because the folio is not uptodate (e.g. do_swap_fault() will return
> VM_FAULT_SIGBUS). It may not be reliable recovery in all cases, but it
> is better than nothing.
>
> This was tested by hacking the allocation in __read_swap_cache_async()
> to use order 2 and __GFP_COMP.
>
> In the future, to handle this correctly, the swapin code should:
> (a) Fallback to order-0 swapins if zswap was ever used on the machine,
> because compressed pages remain in zswap after it is disabled.
> (b) Add proper support to swapin large folios from zswap (fully or
> partially).
>
> Probably start with (a) then followup with (b).
>
> [1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail=
.com/
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>
> v1: https://lore.kernel.org/lkml/20240606184818.1566920-1-yosryahmed@goog=
le.com/
>
> v1 -> v2:
> - Instead of using VM_BUG_ON() use WARN_ON_ONCE() and add some recovery
>   handling (David Hildenbrand).
>
> ---
>  mm/page_io.c |  1 -
>  mm/zswap.c   | 22 +++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index f1a9cfab6e748..8f441dd8e109f 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct swap=
_iocb **plug)
>         delayacct_swapin_start();
>
>         if (zswap_load(folio)) {
> -               folio_mark_uptodate(folio);
>                 folio_unlock(folio);
>         } else if (data_race(sis->flags & SWP_FS_OPS)) {
>                 swap_read_folio_fs(folio, plug);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b9b35ef86d9be..ebb878d3e7865 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> +       /*
> +        * Large folios should not be swapped in while zswap is being use=
d, as
> +        * they are not properly handled. Zswap does not properly load la=
rge
> +        * folios, and a large folio may only be partially in zswap.
> +        *
> +        * If any of the subpages are in zswap, reading from disk would r=
esult
> +        * in data corruption, so return true without marking the folio u=
ptodate
> +        * so that an IO error is emitted (e.g. do_swap_page() will sigfa=
ult).
> +        *
> +        * Otherwise, return false and read the folio from disk.
> +        */
> +       if (folio_test_large(folio)) {
> +               if (xa_find(tree, &offset,
> +                           offset + folio_nr_pages(folio) - 1, XA_PRESEN=
T)) {
> +                       WARN_ON_ONCE(1);
> +                       return true;
> +               }
> +               return false;

IMHO, this appears to be over-designed. Personally, I would opt to
use

 if (folio_test_large(folio))
               return true;

Before we address large folio support in zswap, it=E2=80=99s essential
not to let them coexist. Expecting valid data by lunchtime is
not advisable.

> +       }
> +
>         /*
>          * When reading into the swapcache, invalidate our entry. The
>          * swapcache can be the authoritative owner of the page and
> @@ -1590,7 +1610,7 @@ bool zswap_load(struct folio *folio)
>                 zswap_entry_free(entry);
>                 folio_mark_dirty(folio);
>         }
> -
> +       folio_mark_uptodate(folio);
>         return true;
>  }
>
> --
> 2.45.2.505.gda0bf45e8d-goog
>

Thanks
Barry

