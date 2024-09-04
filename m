Return-Path: <linux-kernel+bounces-315429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC496C2A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB391F25D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C01DEFC0;
	Wed,  4 Sep 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnRbvL1B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1C39FFE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464459; cv=none; b=osTyuUFkH/H7QrQz1IXO/fqUCXjlLWKm3/o90d8xn9cvzyGwBnguUd2WhJCXDLdHxoA/YGraG/CtMZpgn2RqAqYnr1Ii92r0phm8HzLbpvn9C6qna8zo+3GJY2sLKY8m0u/3tRwPaoc8Lh5mGVDewcI004eTyUAA1qR3O9AZWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464459; c=relaxed/simple;
	bh=eBOFrT6g1MH/GsUkaWrL4ij93taIsUu6H4VISTRTlxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg1G7hnUJeoGlMG0PUczjjYBrBw1GT2zh7bQe+4lkOp4A2rvljZE1mSKZW+TWISdC2aDiTWBZt/38u4/d/6TGmuW4TEfDIpxuA/LNHbDeaPqsQ/c6tpGazkWNH+N9zpm1WBTebirlHfXeAcXVMrp3xC+RgwM5ANsXZWBIwlprQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnRbvL1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505F9C4CEC2;
	Wed,  4 Sep 2024 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725464458;
	bh=eBOFrT6g1MH/GsUkaWrL4ij93taIsUu6H4VISTRTlxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnRbvL1BOCSeM9auP/uCAF73FuFEBTFTcIhhEylHe8QUOL4/QSUAkSdeV7eLxYIW6
	 sEuNToUWEZh7UndkaIy0oFtOOP25q8sMQg+QnVPQBbAHDazeO+W314f7AVPDV/dMVA
	 KJlraCLUteg9zmL5liSstWNuEnx8+PMfJvr+BdhQYNeigY4y2YOtXqrPzfyqfs7Cz5
	 aSXgJTCEVdFaTNNGPNtv/NTsWuPjcLz2lDZ4Efz10/cJy4XhmGijIi5fjGqzew2V3o
	 3M6/2WvsXOYq/3tjtG2rLGOnMIS3EwmCGxbSg4sW340FtjlwFRejzwaCk3xDlWBABX
	 y/PzHmndcVQnw==
Date: Wed, 4 Sep 2024 18:38:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Rong Qianfeng <11065417@vivo.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, vbabka@suse.cz,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
	Rong Qianfeng <rongqianfeng@vivo.com>
Subject: Re: [PATCH] mm: Skip the reserved bootmem for compaction
Message-ID: <Zth-40Vzyh8zeDSu@kernel.org>
References: <20240902122445.11805-1-rongqianfeng@vivo.com>
 <5fmd2poyeas2pomho2io5zgmqd26vnxd77czmlhqn5tapy4fv4@5tdcqamzgyj5>
 <d1939f2a-24a2-48a7-9c64-5acdd7c5d478@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1939f2a-24a2-48a7-9c64-5acdd7c5d478@vivo.com>

On Wed, Sep 04, 2024 at 07:59:37PM +0800, Rong Qianfeng wrote:
> Hi Mel,
> 
> 在 2024/9/4 19:13, Mel Gorman 写道:
> > On Mon, Sep 02, 2024 at 08:24:43PM +0800, Rong Qianfeng wrote:
> > > Reserved pages are basically non-lru pages. This kind of memory can't be
> > > used as migration sources and targets, skip it can bring some performance
> > > benefits.
> > > 
> > > Because some drivers may also use PG_reserved, we just set PB_migrate_skip
> > > for those clustered reserved bootmem during memory initialization.
> > > 
> > > Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
> > I'm not convinced the savings due to skipping a few pages during the scan
> > would justify the additional code. There would have to be a large number
> > of reserved pages scattered throughout the zone to make a difference and
> > even that situation would be a big surprise. I'm not even sure this can be
> > explicitly tested unless you artifically create reserved pages throughout the
> > zone, which would not be convincing, or know if a driver that exhibits such
> > behaviour in which case my first question is -- what is that driver doing?!?
> 
> Thanks for taking the time to reply.
> 
> At first I thought that there was not much PageReserved pages, but when I
> looked at the memory initialization code, I found that no-map pages were
> also marked as PageReserved.  On mobile platforms, there is a lot of no-map
> pages (for example, ARM64 MT6991 no-map pages has 1065MB).  These
> pages are usually used by various hardware subsystems such as modem.  So
> I think it makes sense to skip these pages.
> 
> 
> //no-map and  reserved memory marked as PageReserved
> static void __init memmap_init_reserved_pages(void)
> {
> ...
>     for_each_mem_region(region) {
> ...
>         if (memblock_is_nomap(region))
>             reserve_bootmem_region(start, end, nid);  //for no-map memory

If nomap regions are a problem won't that be simpler to make all pageblocks
of a nomap region PB_migrate_skip here and leave other reserved pages
alone?

> 
>         memblock_set_node(start, end, &memblock.reserved, nid);
>     }
> 
>     for_each_reserved_mem_region(region) {
>         if (!memblock_is_reserved_noinit(region)) {
> ...
>             reserve_bootmem_region(start, end, nid); //for reserved memory
>         }
>     }
> 
> }
> 
> Best Regards,
> Qianfeng

-- 
Sincerely yours,
Mike.

