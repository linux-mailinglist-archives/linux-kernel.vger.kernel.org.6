Return-Path: <linux-kernel+bounces-369985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B81799A254C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D9FB23CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566381DE898;
	Thu, 17 Oct 2024 14:40:25 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD71DE4F3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176025; cv=none; b=VEPjscvaIhyj1uDN4e/5Jvffr7JL3gucnq98Kg8wUzC4E66gMb9J/qeA7Ha8ss0eZNJICpKpIpbkhbDyVji0deKCRt0pnhYf8Z6GuT0YX1ygd0Faojfi9qdq5PP9h5DC0IKpLFwv+8CxJznOx/fbZBY9pOixDv82gEVQK7RKAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176025; c=relaxed/simple;
	bh=VNXOcPPL96CUjAR/fznSgD34cEuHPgz0ihnCoh4TgAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5aSkzLykVdce4uTj/fZucTpm6P7NMoTOGgwB0Rp2dKq82/r/vY7LJ7+UJC+EWeuwI5Q50+tQLYXn369FlVNAViUma3Bx3LIZwD8lpdBv3jKPxdN2slBJfG+70hQvSbrn1riwAme74asN4+BKG6qH9ovPys2bTdoi5yxWBZSWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DE40227A8E; Thu, 17 Oct 2024 16:40:20 +0200 (CEST)
Date: Thu, 17 Oct 2024 16:40:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	syzbot <syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iommu?] kernel BUG in dma_alloc_attrs
Message-ID: <20241017144020.GA22666@lst.de>
References: <670ebde5.050a0220.d9b66.0154.GAE@google.com> <20241016080240.GA30380@lst.de> <da9db10e-98fd-405c-9167-a29235f5470b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9db10e-98fd-405c-9167-a29235f5470b@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 17, 2024 at 10:31:40AM -0400, Sean Anderson wrote:
> On 10/16/24 04:02, Christoph Hellwig wrote:
> > The problem is that the dma alloc/free tracing calls virt_to_phys
> > on the allocated/free memory.  But that memory can be vmalloced as
> > in this case.  I think we don't have weirdo allocators or pools any
> > more that are neither in the direct kernel mapping or vmalloc, so
> > we might be able to do an
> > 
> > 		if (is_vmalloc_addr())
> > 			page_to_phys(vmalloc_to_page()))
> 
> Do we need offset_in_page?

The DMA allocator always returns page aligned memory.

> Since this function returns a virtual address, I think that would be
> fine.

Ok, I'll look into that.  I'll need to check if %p gets obsfucated
for traces like it does for normal dmesg first, though.


