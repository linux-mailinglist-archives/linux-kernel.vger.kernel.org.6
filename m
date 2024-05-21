Return-Path: <linux-kernel+bounces-185478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F98CB557
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD2FB20A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FFA46521;
	Tue, 21 May 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk3n8El9"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E34B1EB2F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326514; cv=none; b=PDXNToIsJGTXFnYPFeRZ6vZvSZ4xvv1q+WXKj1iwPnsKh5hgRTD780wJZ7+jXhmN+sYMuZhktVB0CZuDdwoSsJv+B84pXOjSJDrmqmyJoU4RA5QNZyT1P8VvoP5CNK0L2lmYmUREJfgLqSiqQhTMRLgthFDdnsyDHcApXFGSbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326514; c=relaxed/simple;
	bh=/0hzNstHcsqDNaiTEvZXePQMugpUMGIa3adzqOK/65I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUTzybatf/N2B4SFzTVRZW41TgqvFleeqAvxW6AsR82g0s/+LuLxtFpZ4BiD8qjfqCJL0lUoVosbIFW8O6a3diBFYKpIF+0DgWzKTlUf6nJ+FhNt1gWeqlV5RjqYGyscNZL2HaMIn6P/O6wk+KXxX9XOGDhn87RnLmADh5rcw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk3n8El9; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7f3ff632a51so141019241.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716326511; x=1716931311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LE+QaOi0STLoMyp++2CZ6z+zmct4TVKtkE/0uydbf8=;
        b=Gk3n8El9jCOy6Jt+TJP9F6Bsynr3H8AEVrs4k+OWCkP9wMQqb7SdV2LJBRiJ5vqk0s
         WKbBYcWCR6CE94dZyaNfy7qczHM8PQb9RRpZqEoRVUVxYHNGsnfB/iKCfTWm4PEwx4cZ
         pPXcorBThwb8Eqi9w8agRXISICxgQa50kwqiXs4DLoOZ4N0KEBoGlatMwu6sWvyi+V+J
         DhKCXB8YTtLSHbY4aRc7qdWCGJzRCbIUoXvtsNuMpmd+x/7aRmZ4IAp+KBh3up+sUoa0
         D4pK1xFQDqY9lDGj9FmtkAQy5jOHpUubqBZtkztqDTW0T/tGi6fUgQoAtj+duEagZA5U
         rDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716326511; x=1716931311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LE+QaOi0STLoMyp++2CZ6z+zmct4TVKtkE/0uydbf8=;
        b=DR4U+/HGcNCWz/COerJc4F533qk0NEDoClj0oTjqaqpsK1UmiVV8JINmN9Jo5ofGL5
         k6b61n09fsNdyRcLeluFgfOU9xa9of2Qevp3Atb9sQxcOy7htUKlUuyX3Xdo8ukA1Mqr
         zHq6xUNWFshz1PQ48W9J4cLgn4isSytgUV/RqOv6zHWFc05GObDamZMKA5A61naCugKx
         T1ep3G++oVXI9vQT1RCjJJ6mN4eaG26fDj+2y5yN1NgGEwGvS8NIUUVgHov6kelHoLol
         fNzmxGDGIqDke5VFbjt7F1UsoQYXU3SedrJ0LuYulzUrrTxaz5NuOU58YnaXyQEj9gWw
         EGBw==
X-Forwarded-Encrypted: i=1; AJvYcCVV4dOW09BwPBwL2QLlLz4GY1Kq4Kl0b8gA78rT0HP7AVreUtW7wHIIASsWTVLbbwI9NXxyfEUY4wlD2n+T2yjjUa+mtXbaEDadC83R
X-Gm-Message-State: AOJu0YwkjMOLdIA1Pt2hsgeN0dDsD7/kiZAtz8wiikMDHLmM89fMk7xn
	7irEKzGejH3MLIeg75VlAaA5u4sVoFT3gfQ+n6URVm1ySbhp0WrO0i+41fJ5EuzrB9LJy8NAUMX
	U/RNEicK6yzFjFkbZFgTfyqa8lTk=
X-Google-Smtp-Source: AGHT+IF4Usb8JXxLtpHWSKMqp+mmx4qtwULKUWMjXScJdBMIR9/BMziw/7vGbjpYf2hoWMjiggkR190giyJ5p6zQ7ek=
X-Received: by 2002:a05:6122:20a4:b0:4bd:54d0:e6df with SMTP id
 71dfb90a1353d-4e1c94bc1dfmr276547e0c.1.1716326510034; Tue, 21 May 2024
 14:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508224040.190469-1-21cnbao@gmail.com>
In-Reply-To: <20240508224040.190469-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 May 2024 09:21:38 +1200
Message-ID: <CAGsJ_4zX1r8aQRuAbnTc0O5sPxDs11yhScz2T2t9uJ84GEjOoA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] large folios swap-in: handle refault cases first
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

This patchset missed the merge window, but I've tried and found that it sti=
ll
applies cleanly to today's mm-unstable. Would you like me to resend it or j=
ust
proceed with using this v4 version?

Thanks
Barry

On Thu, May 9, 2024 at 10:41=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> This patch is extracted from the large folio swapin series[1], primarily =
addressing
> the handling of scenarios involving large folios in the swap cache. Curre=
ntly, it is
> particularly focused on addressing the refaulting of mTHP, which is still=
 undergoing
> reclamation. This approach aims to streamline code review and expedite th=
e integration
> of this segment into the MM tree.
>
> It relies on Ryan's swap-out series[2], leveraging the helper function
> swap_pte_batch() introduced by that series.
>
> Presently, do_swap_page only encounters a large folio in the swap
> cache before the large folio is released by vmscan. However, the code
> should remain equally useful once we support large folio swap-in via
> swapin_readahead(). This approach can effectively reduce page faults
> and eliminate most redundant checks and early exits for MTE restoration
> in recent MTE patchset[3].
>
> The large folio swap-in for SWP_SYNCHRONOUS_IO and swapin_readahead()
> will be split into separate patch sets and sent at a later time.
>
> -v4:
>  - collect acked-by/reviewed-by of Ryan, "Huang, Ying", Chris, David and
>    Khalid, many thanks!
>  - Simplify reuse code in do_swap_page() by checking refcount=3D=3D1, per
>    David;
>  - Initialize large folio-related variables later in do_swap_page(), per
>    Ryan;
>  - define swap_free() as swap_free_nr(1) per Ying and Ryan.
>
> -v3:
>  - optimize swap_free_nr using bitmap with single one "long"; "Huang, Yin=
g"
>  - drop swap_free() as suggested by "Huang, Ying", now hibernation can ge=
t
>    batched;
>  - lots of cleanup in do_swap_page() as commented by Ryan Roberts and "Hu=
ang,
>    Ying";
>  - handle arch_do_swap_page() with nr pages though the only platform whic=
h
>    needs it, sparc, doesn't support THP_SWAPOUT as suggested by "Huang,
>    Ying";
>  - introduce pte_move_swp_offset() as suggested by "Huang, Ying";
>  - drop the "any_shared" of checking swap entries with respect to David's
>    comment;
>  - drop the counter of swapin_refault and keep it for debug purpose per
>    Ying
>  - collect reviewed-by tags
>  Link:
>   https://lore.kernel.org/linux-mm/20240503005023.174597-1-21cnbao@gmail.=
com/
>
> -v2:
>  - rebase on top of mm-unstable in which Ryan's swap_pte_batch() has chan=
ged
>    a lot.
>  - remove folio_add_new_anon_rmap() for !folio_test_anon()
>    as currently large folios are always anon(refault).
>  - add mTHP swpin refault counters
>   Link:
>   https://lore.kernel.org/linux-mm/20240409082631.187483-1-21cnbao@gmail.=
com/
>
> -v1:
>   Link: https://lore.kernel.org/linux-mm/20240402073237.240995-1-21cnbao@=
gmail.com/
>
> Differences with the original large folios swap-in series
>  - collect r-o-b, acked;
>  - rename swap_nr_free to swap_free_nr, according to Ryan;
>  - limit the maximum kernel stack usage for swap_free_nr, Ryan;
>  - add output argument in swap_pte_batch to expose if all entries are
>    exclusive
>  - many clean refinements, handle the corner case folio's virtual addr
>    might not be naturally aligned
>
> [1] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmai=
l.com/
> [2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.robert=
s@arm.com/
> [3] https://lore.kernel.org/linux-mm/20240322114136.61386-1-21cnbao@gmail=
com/
>
> Barry Song (3):
>   mm: remove the implementation of swap_free() and always use
>     swap_free_nr()
>   mm: introduce pte_move_swp_offset() helper which can move offset
>     bidirectionally
>   mm: introduce arch_do_swap_page_nr() which allows restore metadata for
>     nr pages
>
> Chuanhua Han (3):
>   mm: swap: introduce swap_free_nr() for batched swap_free()
>   mm: swap: make should_try_to_free_swap() support large-folio
>   mm: swap: entirely map large folios found in swapcache
>
>  include/linux/pgtable.h | 26 +++++++++++++-----
>  include/linux/swap.h    |  9 +++++--
>  kernel/power/swap.c     |  5 ++--
>  mm/internal.h           | 25 ++++++++++++++---
>  mm/memory.c             | 60 +++++++++++++++++++++++++++++++++--------
>  mm/swapfile.c           | 48 +++++++++++++++++++++++++++++----
>  6 files changed, 142 insertions(+), 31 deletions(-)
>
> --
> 2.34.1
>

