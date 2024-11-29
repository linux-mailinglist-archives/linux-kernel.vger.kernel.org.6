Return-Path: <linux-kernel+bounces-425918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7949DEC87
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE2A16186D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2901A256F;
	Fri, 29 Nov 2024 19:38:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8B14D430
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732909110; cv=none; b=BORZMMRc8oEy9s4Ilgsq2ZpPA6TglV77Nju3HjEqmfNh7aCgiIfr0sfAHzBnyku9VyXL2esD9QlQKVCsLOnlE/nv3xhB8KAEIFIsdawDfy+y41CXGLhpRi8wXvOqNTcqNx0EbOkOq85hFYkCXmF/bgfyKvC52Nie/zrPTIKBaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732909110; c=relaxed/simple;
	bh=BS6jrRu6+sYgE9g4uWRmKXi0Ng/9na/wD645hYlYWmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR8nulRxHJTxBNOfh3QAOJ4Mm53fjRzoaq98EJX4s6EGDqB0cqmLXGgvc+vudduXuX1ZA0XzC7CSiWrmjQPuJ6KxphYU0MAUGFUwNnAxg2gks2y2UDJchIHXODUTopJsVh26cqQx5qfqf9kHdJboppImVtBZ+dVIv3MOy3RrdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE7AC4CECF;
	Fri, 29 Nov 2024 19:38:27 +0000 (UTC)
Date: Fri, 29 Nov 2024 19:38:25 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>,
	Baruch Siach <baruch@tkos.co.il>, will@kernel.org,
	ptesarik@suse.com, hch@lst.de, jiangyutang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: fix zone_dma_limit calculation
Message-ID: <Z0oYMXMGYgXoyon7@arm.com>
References: <20241125171650.77424-1-yang@os.amperecomputing.com>
 <87ttbu8q7s.fsf@tarshish>
 <98583682-a95e-440e-bd89-03828998b48e@os.amperecomputing.com>
 <Z0dbsRCsWT3hiVds@arm.com>
 <7720d275-bc52-49c3-949a-6a6a32157418@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7720d275-bc52-49c3-949a-6a6a32157418@arm.com>

On Fri, Nov 29, 2024 at 06:06:50PM +0000, Robin Murphy wrote:
> On 2024-11-27 5:49 pm, Catalin Marinas wrote:
> > If IORT or DT indicate a large mask covering the whole RAM (i.e. no
> > restrictions), in an ideal world, we should normally extend ZONE_DMA to
> > the same.
> 
> That's not right, ZONE_DMA should still be relatively limited in size
> (unless we really do only have a tiny amount of RAM) - just because a DT
> dma-ranges property says the system interconnect can carry >32 address bits
> in general doesn't mean that individual device DMA masks can't still be
> 32-bit or smaller. IIRC we're still implicitly assuming that if DT does
> describe an offset range into "high" RAM, it must represent a suitable
> lowest common denominator for all relevant devices already, and therefore we
> can get away with sizing ZONE_DMA off it blindly.

Fine by me to keep ZONE_DMA in the low range always. I was thinking of
only doing this if ZONE_DMA32 is enabled.

> After staring at it for long enough, I think $SUBJECT patch is actually
> correct as it is.

Thanks Robin for having a look. Can I add your reviewed-by?

> In fact I'm now wondering why the fix was put inside
> max_zone_phys() in the first place, since it's clearly pointless to clamp
> DMA_BIT_MASK(32) to U32_MAX in the dma32_phys_limit case...

I came to the same conclusion. I think it might have been some left-over
from when we had a ZONE_DMA32 in the above 4GB (AMD Seattle?). Than we
changed it a few times but only focused on this function for setting the
limits.

> However the commit message is perhaps not as clear as it could be -
> technically we are correctly *calculating* the appropriate effective
> zone_dma_limt value within the scope of zone_sizes_init(), we're just
> failing to properly update the actual zone_dma_limit variable for the
> benefit of other users.

I'll have a look next week at rewriting the commit message, unless Yang
does it first. I'm planning to queue this patch for -rc2.

-- 
Catalin

