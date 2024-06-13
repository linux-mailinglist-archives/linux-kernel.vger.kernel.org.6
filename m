Return-Path: <linux-kernel+bounces-214071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC1907F11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DBF28237A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA8B14D281;
	Thu, 13 Jun 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l4FAwlRB"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5C13B5AD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318481; cv=none; b=sspgdyfkots6MZWU73ZawhFaofglMgNM1TNogfz1IqOtpQMjtFLPsrsFbJt1+txjlOT0oHp4gPIokr2KmXvlP757r+v/E0SV3rc+9NtOp9BDKHENlQFcIJCpeyAndFf4Yl5MXXMYD1kmgjoeWG31/QgVKLxHO+9fUPlPWJf3sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318481; c=relaxed/simple;
	bh=vKi8gbaNhSZ/mamp916rK3s03rXlqy17Sk3LVQ6HuPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeb/B48w77fTl+44IQX8HpotkBzPMb/qYFJ4sRuKH8zLokn6f6+Glb6I8FHLLD+J6Gj8nEv4F6pHGdY6DEogen3+3VPSCAQRi0TLwkv1kDF3uEMrAKAPJZL3ZV6sl4UYQPJI+Aey6GRBYgznYnOW8I5w4NExJNtR8/LNG+9qTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l4FAwlRB; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718318476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axMkgrlRNzbazn3gKxpjsc5NsZWIHblTZHRj4tETIAI=;
	b=l4FAwlRBM34rKqh9pvULsxJDfbGyY49ey30g82j5czLphMHWWYOvEx8+63TFPEa4Kagd9+
	8FSwfqQ0sKWjXYdyZ9yCQnRZnbovTskFfjE6UmX5bBO7cBG4cpj2G4UxDyafUeha+V5cDq
	bhpP9XDLntFqjrVc3NjJfq1mAA8SS2g=
X-Envelope-To: usamaarif642@gmail.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: david@redhat.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: hughd@google.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: minchan@kernel.org
X-Envelope-To: senozhatsky@chromium.org
Date: Thu, 13 Jun 2024 15:41:10 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, david@redhat.com, ying.huang@intel.com, hughd@google.com, 
	willy@infradead.org, nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/2] mm: store zero pages to be swapped out in a bitmap
Message-ID: <etjzs45r7derztzgrb5b4tub4c72vobo6esc3ndksyke6kpiov@qj3ar7xwh6ee>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <CAJD7tkZdx7xJiDcvayH1aRW9Q6GQaZnF58UhspEOe=GQMBqFiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZdx7xJiDcvayH1aRW9Q6GQaZnF58UhspEOe=GQMBqFiQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 13, 2024 at 02:50:31PM GMT, Yosry Ahmed wrote:
> On Mon, Jun 10, 2024 at 5:18 AM Usama Arif <usamaarif642@gmail.com> wrote:
> >
> > Going back to the v1 implementation of the patchseries. The main reason
> > is that a correct version of v2 implementation requires another rmap
> > walk in shrink_folio_list to change the ptes from swap entry to zero pages to
> > work (i.e. more CPU used) [1], is more complex to implement compared to v1
> > and is harder to verify correctness compared to v1, where everything is
> > handled by swap.
> >
> > ---
> > As shown in the patchseries that introduced the zswap same-filled
> > optimization [2], 10-20% of the pages stored in zswap are same-filled.
> > This is also observed across Meta's server fleet.
> > By using VM counters in swap_writepage (not included in this
> > patchseries) it was found that less than 1% of the same-filled
> > pages to be swapped out are non-zero pages.
> >
> > For conventional swap setup (without zswap), rather than reading/writing
> > these pages to flash resulting in increased I/O and flash wear, a bitmap
> > can be used to mark these pages as zero at write time, and the pages can
> > be filled at read time if the bit corresponding to the page is set.
> >
> > When using zswap with swap, this also means that a zswap_entry does not
> > need to be allocated for zero filled pages resulting in memory savings
> > which would offset the memory used for the bitmap.
> >
> > A similar attempt was made earlier in [3] where zswap would only track
> > zero-filled pages instead of same-filled.
> > This patchseries adds zero-filled pages optimization to swap
> > (hence it can be used even if zswap is disabled) and removes the
> > same-filled code from zswap (as only 1% of the same-filled pages are
> > non-zero), simplifying code.
> 
> There is also code to handle same-filled pages in zram, should we
> remove this as well? It is worth noting that the handling in zram was
> initially for zero-filled pages only, but it was extended to cover
> same-filled pages as well by commit 8e19d540d107 ("zram: extend zero
> pages to same element pages"). Apparently in a test on Android, about
> 2.5% of the swapped out pages were non-zero same-filled pages.
> 
> However, the leap from handling zero-filled pages to handling all
> same-filled pages in zram wasn't a stretch. But now that zero-filled
> pages handling in zram is redundant with this series, I wonder if it's
> still worth keeping the same-filled pages handling.

Please correct me if I am wrong but zram same-filled page handling is
not just limited to swap-on-zram use-case and any zram as block device
user can benefit from it. Also zram might not see any simplification
similar to zswap in this patch series. I would say motivation behind
zswap changes seems quite different from possible zram changes. I would
recommed to evaluate these cases independently.

