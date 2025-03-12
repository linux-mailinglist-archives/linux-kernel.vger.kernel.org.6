Return-Path: <linux-kernel+bounces-557999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D9DA5E038
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4783018893DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CC4252906;
	Wed, 12 Mar 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uAx3Sg8D"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F782528F5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792867; cv=none; b=IrVmc8H9n22y0FXgPgd+zkXbQQed8ZbLTjNYZ7zqpmSPvCKSEtQ3c8MFjnOykRYw7v567nzECWUPZe+udukwbcNNCo8VLi9gFKsDjm311NGxKcMFn5dJslyZZrOb9RpIY9/fHNaNV1jzy89PO8Nk8f548PrOIO/Sq5GCC6Ak4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792867; c=relaxed/simple;
	bh=g33keADMtBTqLGGeUZPNTEZup2ruOa4uwufaq/VDLLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7K3ciCiC/lNQff1O5skQoVKcWZDOhCoy3n3nMpXsIhSqwokwUCzo+0YQFQ0NoZM93wrD+TqZHV0eYqMXVqPJWT+ftrTBB62+uqEP8S/517wlOiHngKT+kGz/4NVa5DqGydIELuWXe7698iyaXptsKi0Kdb4/vO5sW+da6apUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uAx3Sg8D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XIdDKUptq8/xr7ZlXrpuZGXg2rNejNyZjWJ17UFWXoA=; b=uAx3Sg8DEVn2bO+FLZ2H/E0FXN
	pN7+jJ0z2ZGvmfweRPXTkRsVwZasFYeNeahstq3t6wIyzQlKCwfcAF3kPiqipF4dJtxxOStaF5MZ3
	j3E8fvMo7erQpBjN9R2cSyF2QXQL63JYCTRluKyq82oFEB4iZ934PrrfA9BqPZapMGotudMjuXgZn
	EyIWu+COxuWyU8iQjvbZCXHLUyzLy7OOrAJXCKqsdOrkeFdJcd1fJAdaO1NGPaGtymlJ1pRO1JyUy
	w8teCd0fLAyBuTA5wtDyVlKljiyadacOPpg0fgwGOyMzFOicDVGWDqa+ssXxiursKSAki0yo1/83G
	pIBCz7Zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNtJ-00000008q5u-1zfY;
	Wed, 12 Mar 2025 15:21:05 +0000
Date: Wed, 12 Mar 2025 08:21:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sooyong Suk <s.suk@samsung.com>,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	jaewon31.kim@gmail.com, spssyr@gmail.com
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
Message-ID: <Z9GmYe-bdOZ8LQV5@infradead.org>
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com>
 <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <Z8tVrOezU2q_0ded@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8tVrOezU2q_0ded@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 07, 2025 at 08:23:08PM +0000, Matthew Wilcox wrote:
> Howver, the problem is real.

What is the problem?

> What I've been asking for and don't have the answer to yet is:
> 
>  - What latency is acceptable to reclaim the pages allocated from CMA
>    pageblocks?
>     - Can we afford a TLB shootdown?  An rmap walk?
>  - Is the problem with anonymous or pagecache memory?
> 
> I have vaguely been wondering about creating a separate (fake) NUMA node
> for the CMA memory so that userspace can control "none of this memory is
> in the CMA blocks".  But that's not a great solution either.

Maybe I'm misunderstanding things, but CMA basically provides a region
that allows for large contiguous allocations from it, but otherwise
is used as bog normal kernel memory.  But anyone who wants to allocate
from it needs to move all that memory.  Which to me implies that:

 - latency can be expected to be horrible because a lot of individual
   allocations need to possibly be moved, and all of them could
   be temporarily pinned for I/O
 - any driver using CMA better do this during early boot time, or
   at least under the expectation that doing a CMA allocation
   temporarily causes a huge performance degradation.

If a caller can't cope with that it better don't use CMA.

