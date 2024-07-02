Return-Path: <linux-kernel+bounces-237850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A2923EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC924289308
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2681B5802;
	Tue,  2 Jul 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="aDQg/cO3"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBE1B4C5E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926785; cv=none; b=e+p72xlnmhtchZ/7niGg27FX0mTGgxplVJItwKviuDW0L0esyfNiVPiMcoJFmXqH3foPjukH7U7O93oKBG2pvxDR9oaWPco6Cfiw57GnPFLWYqstiVlRvjro3Mq/S4ccJgILsuRJoT1s/Qru/KTITJgS0Oak9a1WjxycmJLvtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926785; c=relaxed/simple;
	bh=pQ2gI6plLJepHCSVBtuyD1p5ceTw2DTdf9Y2AGto4XU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CEe7WhlxVJQTZ9OqDt6QiCLReb4WwY4xKUf6OLxB20logq8f3rNg4QegURQ7TO5BsHd6z4JyKUL3UvPo9Oa8LT+SjlmAR2Gt/KutCFmlDFTs9VYaX938nxk+jkv6rGh+dRKa40Hoy1y2M+7XTRyEma1zstgwFPBLwTJneWOf388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=aDQg/cO3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719926780;
	bh=UGTwS/DKg+8pMXk0DI9KdA5PsJ49u27dDjQ27xdvrOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aDQg/cO3ChtGupOyDrsKCvhp3Wj5I2zvRwE5aNcedmdk8tx+t0nZ35mD2Sgfglk6c
	 wHyzUcEsUkk2oK/1dwxn4IPMeJRBlIItgOXUp2hIKqm72RVwTLM6EtDPKhn+hgM0IE
	 77bDh5Dfs5fDf2kMOHjqXSGuyyHMM2ZTDZmTzx/XS4oatFogUOUQCqA29oc6sCaUss
	 zVteowZUNrEuQv3HVz2TIIwaVqJIw5szCFxnN6EWj4TXxb2GIWb+zDlw2i7ovRVWnP
	 rIpmwVkonUgH1purEDe7D8IcnUQrGitkCcRUSWpcbf27m/JpC4Ax1XIp0shJHPFvD1
	 +aJKCunhITUCA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WD3Zz5DnTz4wny;
	Tue,  2 Jul 2024 23:26:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Morton
 <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>, Peter Xu
 <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 21/23] powerpc/64s: Use contiguous PMD/PUD instead of
 HUGEPD
In-Reply-To: <23f3fe9e8fe37cb164a369850d4569dddf359fdf.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
 <23f3fe9e8fe37cb164a369850d4569dddf359fdf.1719240269.git.christophe.leroy@csgroup.eu>
Date: Tue, 02 Jul 2024 23:26:19 +1000
Message-ID: <87plrwj56s.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> On book3s/64, the only user of hugepd is hash in 4k mode.
>
> All other setups (hash-64, radix-4, radix-64) use leaf PMD/PUD.
>
> Rework hash-4k to use contiguous PMD and PUD instead.
>
> In that setup there are only two huge page sizes: 16M and 16G.
>
> 16M sits at PMD level and 16G at PUD level.
>
> pte_update doesn't know page size, lets use the same trick as
> hpte_need_flush() to get page size from segment properties. That's
> not the most efficient way but let's do that until callers of
> pte_update() provide page size instead of just a huge flag.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3:
> - Add missing pmd_leaf_size() and pud_leaf_size()
> - More cleanup in hugetlbpage_init()
> - Take a page fault when DIRTY or ACCESSED is missing on hash-4 hugepage
>
> v4: Rebased on v6.10-rc1
>
> v6: Added a WARN_ON_ONCE() in hash__pte_update() in case the pagesize is unexpected.
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 15 ------
>  arch/powerpc/include/asm/book3s/64/hash.h     | 40 +++++++++++++---
>  arch/powerpc/include/asm/book3s/64/hugetlb.h  | 38 ---------------
>  .../include/asm/book3s/64/pgtable-4k.h        | 47 -------------------
>  .../include/asm/book3s/64/pgtable-64k.h       | 20 --------
>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 22 +++++++--
>  arch/powerpc/include/asm/hugetlb.h            |  4 ++
>  .../powerpc/include/asm/nohash/hugetlb-e500.h |  4 --
>  arch/powerpc/include/asm/page.h               |  8 ----
>  arch/powerpc/mm/book3s64/hash_utils.c         | 11 +++--
>  arch/powerpc/mm/book3s64/hugetlbpage.c        | 10 ++++
>  arch/powerpc/mm/book3s64/pgtable.c            | 12 -----
>  arch/powerpc/mm/hugetlbpage.c                 | 26 ----------
>  arch/powerpc/mm/pgtable.c                     |  2 +-
>  arch/powerpc/platforms/Kconfig.cputype        |  1 -
>  15 files changed, 74 insertions(+), 186 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-4k.h

This looks good to me. I've run a few tests on it and haven't seen any
issues.

I also dumped the page tables of a test program and checked they looked
sensible. And I checked that the hash insert path is actually inserting
a huge page entry (of course it is, but just to be sure).

On mainline using a hugepd page hits the first warning in
try_grab_folio() (via gup_hugepd()) and hangs the process. I haven't
seen that reported (it goes back to v6.5), so my impression is hugepd on
hash-4k is essentially unused these days.

This series is an improvement on that, so let's get it into mm-unstable
for some wider testing.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

