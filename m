Return-Path: <linux-kernel+bounces-214040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39171907E59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4053D1C2207D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E514A4F8;
	Thu, 13 Jun 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHZ/nct7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD114A609
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718315473; cv=none; b=QLiF80iLDxnMkvvwAE2HEvOzE/6112b55JhgRk4mwg9uYQlK+jHA82I9NS6kb5lKnHVsvHHiMNBaiot0XTtJvzPVsogCd9hXOSqShhDB8/SuLb87hAMWqh09u9AFDdeYgRuZZwYNLVFthptQ49EEZtQyIxjOydZs1Uxo2vBRvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718315473; c=relaxed/simple;
	bh=h7ZYaLUnbyEDCV5YGCPdni1FFJfjSHwyfBet/qMVQeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5Y0/iLcVR+57FThz4Y899Ac/pBZoHmePsKBtZaQOSoukqkk4LspSSgdeOYBalZ3sqmATjKMXWR//168w6mxI8IkrPzKT/V18dm+SxI8F6/kNXnaw2StYrrtGq30+OYUPEwSk9Ii2V2AGJhlqd/sjp9m5CccsWyi+KoexlWuePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHZ/nct7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso210113766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718315470; x=1718920270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6bz8L/h1k+FIBPPZpQUcXkrKApwtkDytHjPb/V0heg=;
        b=vHZ/nct78bQ9Qj0uf1dmWAclTuqBB149HZ/RticJAsD7N/rCY4Kis/RvzbZ2YM5BAG
         HGQOOEiFSw8GX/fwb5UXj+B8+Zqt+3hGpc71qPhQS0ujNjKxdwv77+LIW5uhavYOMyog
         Ualwz8NjU40IZG3d/j4/vGGjgFVOvNKuiav6frXuA6TdROKo0L/i1kqOe7vaXfotpTM2
         ffwlMOW5pZNV31MhcuvfIStgiU4qnn+cEReqsHzPbA3cPbHxNPyhd9A9GFHSWVqguloC
         4dNK46g3kNvj55XVYh6fyZtcWQABVwVa1SkZHKpvf8gCiYUcNN8hCWoMTUeleYBYnr8y
         8hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718315470; x=1718920270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6bz8L/h1k+FIBPPZpQUcXkrKApwtkDytHjPb/V0heg=;
        b=pUOjPfk41yhGVsHRECKs4UUKj5RrB2x8qnNnqWWFXjDbbYeR445oU3BBm0GeMfITeN
         zMvX704Fc+5sVb5OV+yCyvypMEEsrXVPx68qMp89sZNGHax7qb64muejbU18NehI93qe
         Y8Pv27foGodpEArJNYiQzG9plBc4pQs559gBI067oIsEM0Z0iE66qKqbs/6yEdUzCqls
         W/bor41Muv3+2PhZYrkwl1AOtHEwxDJLheJ+Wx+rzOq2GKve/f6dBUq1kXgQBM6Liedu
         m0bQc/ZzJHQ0FAFCU8iaN5uO2xaDXKt0dKnyjRdfWF+RsXMdgLm3X0412giWfOiH90Ci
         771Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4v5T7IQSw9WSzen/C2CrtuECD3r/HW5vEzQHPsfpKGmBu5MJDovdjuQlsDfR2DzcyyqoaJYNfEFqLlt8vTzNw55zE4VoLFMJs4I1I
X-Gm-Message-State: AOJu0YwyU7C4ymCPoyEbWygV8Kd0b7JbxSIzZ+it0dc4AljNQoRI7T4A
	p8sO5ne0FZvgPDWXvUHFEDV+c7ufPBgQeIGJ/MpRR6soDLTO3knvdiRO41/b3dF/PEd/CWjTi3r
	A7hNnyqzWdpuXKli82le0QgNo8y4kmdXf7aEb
X-Google-Smtp-Source: AGHT+IEcxkIl9tLNWOgQbELckRaul7UJVzCCnWvSHXBXg+3D9gzHygpatFOn1ltiQVUjW6rxD+m6IWXCgP1wqe4il98=
X-Received: by 2002:a17:906:adc5:b0:a6f:2d9a:cec1 with SMTP id
 a640c23a62f3a-a6f60de607bmr53114366b.76.1718315469521; Thu, 13 Jun 2024
 14:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
In-Reply-To: <20240610121820.328876-1-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 13 Jun 2024 14:50:31 -0700
Message-ID: <CAJD7tkZdx7xJiDcvayH1aRW9Q6GQaZnF58UhspEOe=GQMBqFiQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:18=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> Going back to the v1 implementation of the patchseries. The main reason
> is that a correct version of v2 implementation requires another rmap
> walk in shrink_folio_list to change the ptes from swap entry to zero page=
s to
> work (i.e. more CPU used) [1], is more complex to implement compared to v=
1
> and is harder to verify correctness compared to v1, where everything is
> handled by swap.
>
> ---
> As shown in the patchseries that introduced the zswap same-filled
> optimization [2], 10-20% of the pages stored in zswap are same-filled.
> This is also observed across Meta's server fleet.
> By using VM counters in swap_writepage (not included in this
> patchseries) it was found that less than 1% of the same-filled
> pages to be swapped out are non-zero pages.
>
> For conventional swap setup (without zswap), rather than reading/writing
> these pages to flash resulting in increased I/O and flash wear, a bitmap
> can be used to mark these pages as zero at write time, and the pages can
> be filled at read time if the bit corresponding to the page is set.
>
> When using zswap with swap, this also means that a zswap_entry does not
> need to be allocated for zero filled pages resulting in memory savings
> which would offset the memory used for the bitmap.
>
> A similar attempt was made earlier in [3] where zswap would only track
> zero-filled pages instead of same-filled.
> This patchseries adds zero-filled pages optimization to swap
> (hence it can be used even if zswap is disabled) and removes the
> same-filled code from zswap (as only 1% of the same-filled pages are
> non-zero), simplifying code.

There is also code to handle same-filled pages in zram, should we
remove this as well? It is worth noting that the handling in zram was
initially for zero-filled pages only, but it was extended to cover
same-filled pages as well by commit 8e19d540d107 ("zram: extend zero
pages to same element pages"). Apparently in a test on Android, about
2.5% of the swapped out pages were non-zero same-filled pages.

However, the leap from handling zero-filled pages to handling all
same-filled pages in zram wasn't a stretch. But now that zero-filled
pages handling in zram is redundant with this series, I wonder if it's
still worth keeping the same-filled pages handling.

Adding Minchan and Sergey here.

>
> This patchseries is based on mm-unstable.
>
>
> [1] https://lore.kernel.org/all/e4d167fe-cb1e-41d1-a144-00bfa14b7148@gmai=
l.com/
> [2] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03=
d1344dde9fce0@epcms5p1/
> [3] https://lore.kernel.org/lkml/20240325235018.2028408-1-yosryahmed@goog=
le.com/
>
> ---
> v2->v3:
> - Going back to the v1 version of the implementation (David and Shakeel)
> - convert unatomic bitmap_set/clear to atomic set/clear_bit (Johannes)
> - use clear_highpage instead of folio_page_zero_fill (Yosry)
>
> v1 -> v2:
> - instead of using a bitmap in swap, clear pte for zero pages and let
>   do_pte_missing handle this page at page fault. (Yosry and Matthew)
> - Check end of page first when checking if folio is zero filled as
>   it could lead to better performance. (Yosry)
>
> Usama Arif (2):
>   mm: store zero pages to be swapped out in a bitmap
>   mm: remove code to handle same filled pages
>
>  include/linux/swap.h |  1 +
>  mm/page_io.c         | 92 +++++++++++++++++++++++++++++++++++++++++++-
>  mm/swapfile.c        | 21 +++++++++-
>  mm/zswap.c           | 86 ++++-------------------------------------
>  4 files changed, 119 insertions(+), 81 deletions(-)
>
> --
> 2.43.0
>

