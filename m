Return-Path: <linux-kernel+bounces-526047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78145A3F922
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA6A179C02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C421C5D62;
	Fri, 21 Feb 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjKRDHQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A18632E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152521; cv=none; b=Gqa038umOHnmHtGcd1sCXYbWGQmLFYi/HmVdWDGmQ3eEWN6UHEfmCBG8gg/sLuHJB+FRJJ7B1iQotdlLHiDPqRJ/CgPalR7d19LfWDnzfzE31ZcTkmIq2+gewtTwxSkpNjCd6RzUP58KtGcv3koT7Qyx8CkRPqhj03ZD55o0ask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152521; c=relaxed/simple;
	bh=WwwYdepPVfXGQt6TJoehiecmQZzDSZ9gbFfiLyqFhlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6mi+J+fnfB2h28NpTM2NB/GobjX34x61AIZ0nchjEvNTmMsm2vWMQR4mvT/O5hiysk2NpZHJJLWiiDQt3I0kUy5CHjKuE5dBbBHaIOoxYsYmE0eO6uSC4lM+iP8acPKESqJoW/UsvWwufdc6NS6UzfL37Agi6nv96DPEKATawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjKRDHQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2698C4CED6;
	Fri, 21 Feb 2025 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152521;
	bh=WwwYdepPVfXGQt6TJoehiecmQZzDSZ9gbFfiLyqFhlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjKRDHQ6dgEuuAVSrZXfKwM3BHcPorKJuS1mM0ThcTQu0GlztYPn0UIFlJ/AAE4jW
	 Pav9wCthU+U2IcIB+bI4CT2HO82K5NYFzmmYj4r1sTY6WOBpolMngrRZh9dacQRspo
	 XW0Ou5gaa4TAW5x8py/uvJHwwBoPV1+6qzmhej1VAnEIAQQp/C0+5FoJNI/8Cd/AZx
	 HrHJwm7QrOYltxQeqDsUYltF4Mhxqnl+9vu1GZhh6Nu4j/ygpsx0cLV2frkp43BXy5
	 5EDPsYC5YExdV2mHv7GX1T4rJpc7mak/V2r9uPOeFA6ApxDkHv0so5EA6mTeWOXMEG
	 klC+hX7plG7dQ==
Date: Fri, 21 Feb 2025 15:41:56 +0000
From: Will Deacon <will@kernel.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: fix memory loads
 ordering
Message-ID: <20250221154155.GE20567@willie-the-truck>
References: <20250108074822.722696-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108074822.722696-1-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 08, 2025 at 12:48:21AM -0700, Yu Zhao wrote:
> Using x86_64 as an example, for a 32KB struct page[] area describing a
> 2MB hugeTLB, HVO reduces the area to 4KB by the following steps:
> 1. Split the (r/w vmemmap) PMD mapping the area into 512 (r/w) PTEs;
> 2. For the 8 PTEs mapping the area, remap PTE 1-7 to the page mapped
>    by PTE 0, and at the same time change the permission from r/w to
>    r/o;
> 3. Free the pages PTE 1-7 used to map, hence the reduction from 32KB
>    to 4KB.
> 
> However, the following race can happen due to improperly memory loads
> ordering:
>   CPU 1 (HVO)                     CPU 2 (speculative PFN walker)
> 
>   page_ref_freeze()
>   synchronize_rcu()
>                                   rcu_read_lock()
>                                   page_is_fake_head() is false
>   vmemmap_remap_pte()
>   XXX: struct page[] becomes r/o
> 
>   page_ref_unfreeze()
>                                   page_ref_count() is not zero
> 
>                                   atomic_add_unless(&page->_refcount)
>                                   XXX: try to modify r/o struct page[]
> 
> Specifically, page_is_fake_head() must be ordered after
> page_ref_count() on CPU 2 so that it can only return true for this
> case, to avoid the later attempt to modify r/o struct page[].
> 
> This patch adds the missing memory barrier and makes the tests on
> page_is_fake_head() and page_ref_count() done in the proper order.
> 
> Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
> Reported-by: Will Deacon <will@kernel.org>
> Closes: https://lore.kernel.org/20241128142028.GA3506@willie-the-truck/
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/page-flags.h | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/page_ref.h   |  2 +-
>  2 files changed, 38 insertions(+), 1 deletion(-)

Sorry for the very late reply, but I finally found time to sit down and
go through this. I think it resolves the problem I pointed out, so:

Acked-by: Will Deacon <will@kernel.org>

Thanks!

Will

