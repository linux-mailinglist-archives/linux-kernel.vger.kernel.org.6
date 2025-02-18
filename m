Return-Path: <linux-kernel+bounces-518627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DCA39225
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834B9165F95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4941A4F2F;
	Tue, 18 Feb 2025 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gOU7yBLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB581E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739853258; cv=none; b=R0BJ18y+qQozLX4Hvqd4lyuGncqWzTqnxNCP4PvNhAEd5wLNODLiwjr3yWGBndOCcpMZX+AIfKwg7P5hztcEEadMFzMr8bjtEaj2G/kJjxros0jbM281bJM90tl5Pw0jdr5kCtkbEoLOCUmzS6Ttdg33/x/ZD+xo/Dfcf8ckp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739853258; c=relaxed/simple;
	bh=msCy2hEI5k2c9d4ihF237AdXQfcEufNHXJA14T/WN7Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h93FZBEixAoktp317Zzn1DQ6N+JyCaKKlyFkuzzV34GpjNfTuF4ciPF90JRTEuryienVLlW0V2jwJ1YqCTYyitDo4Oh/GRHmhP6tmRbpzGE7UNwLaR7lLTmdOHbQhWTtCb7XzBdRvf5BHnuMrFr4MK3PJG1/1KKYYjJq6PNQwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gOU7yBLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7D0C4CEE2;
	Tue, 18 Feb 2025 04:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739853257;
	bh=msCy2hEI5k2c9d4ihF237AdXQfcEufNHXJA14T/WN7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gOU7yBLD5sSPSWgLpcPPEy8dEgtH68b/dwH9ijB2n/ptDrnqBVpNWhyjogjUhwOzl
	 5K7ogGsGAIm0mkqZA6ngOKEogRItkYriZ2VUfFz4uakxlvXLzWTrLOdwGkMpREfPvd
	 uWLbEIU4XXK+CtN35gAh67tmTG+Fd1mdyRjKu6RE=
Date: Mon, 17 Feb 2025 20:34:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: yangge1116@126.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 david@redhat.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
Subject: Re: [PATCH V2] mm/hugetlb: wait for hugepage folios to be freed
Message-Id: <20250217203417.9689a271f792a4e23da322aa@linux-foundation.org>
In-Reply-To: <1739604026-2258-1-git-send-email-yangge1116@126.com>
References: <1739604026-2258-1-git-send-email-yangge1116@126.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 15:20:26 +0800 yangge1116@126.com wrote:

> From: Ge Yang <yangge1116@126.com>
> 
> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer freeing
> of HugeTLB pages"), which supports deferring the freeing of HugeTLB pages,
> the allocation of contiguous memory through cma_alloc() may fail
> probabilistically.
> 
> In the CMA allocation process, if it is found that the CMA area is occupied
> by in-use hugepage folios, these in-use hugepage folios need to be migrated
> to another location. When there are no available hugepage folios in the
> free HugeTLB pool during the migration of in-use HugeTLB pages, new folios
> are allocated from the buddy system. A temporary state is set on the newly
> allocated folio. Upon completion of the hugepage folio migration, the
> temporary state is transferred from the new folios to the old folios.
> Normally, when the old folios with the temporary state are freed, it is
> directly released back to the buddy system. However, due to the deferred
> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately leading
> to the failure of cma_alloc().
> 
> Here is a simplified call trace illustrating the process:
> cma_alloc()
>     ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>         ->unmap_and_move_huge_page()
>             ->folio_putback_hugetlb() // Free old folios
>     ->test_pages_isolated()
>         ->__test_page_isolated_in_pageblock()
>              ->PageBuddy(page) // Check if the page is in buddy
> 
> To resolve this issue, we have implemented a function named
> wait_for_hugepage_folios_freed(). This function ensures that the hugepage
> folios are properly released back to the buddy system after their migration
> is completed. By invoking wait_for_hugepage_folios_freed() before calling
> PageBuddy(), we ensure that PageBuddy() will succeed.
> 
> Fixes: b65d4adbc0f0 ("mm: hugetlb: defer freeing of HugeTLB pages")

Do you feel that this issue is serious enough to justify a -stable
backport of the fix?


