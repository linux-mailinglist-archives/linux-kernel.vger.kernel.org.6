Return-Path: <linux-kernel+bounces-340441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF4987375
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3741F275B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D74017BEBD;
	Thu, 26 Sep 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+iZ8zT+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6AD1714BD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353232; cv=none; b=Te6NKAsYsDt0lpPc8OThTBZKILck1Zo0SI/sqv9KjsI1KMreNUz626jkKiayvH7wLBi9oM06l1YxK1CF3kN31jx1VllcUf1O2tVmGVjABiR0iKTwKSMjgqJTN2d+ANcksuukWotnI1cz6vPG9f8Zijlb0muqAbV60SbutVpYDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353232; c=relaxed/simple;
	bh=u3BDYtcuEBdJuX14wijn1+yKrF5lw/If6dbSrEjpRRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ1OUgIkP8eE193C6bAZoFOt999YRnF1g+XerrIxZGq4m3SZRBDUn33FJ7eOcHpm2XlllT9goeNdIEdZDQNTP1xWou6nvcv4XiNfGmxQ7OaJzJLB2vhZ4os414ZT/JgZ0eORu2PTf0TNxxrqRfnG5aj6FUwlr7YSUHU5+i4Z81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u+iZ8zT+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ZdSVGWk34/kGEegWA4c5xkhFSAJiSLDxkV6IKWrllY=; b=u+iZ8zT+9Zyie6sCCPjCzLaRj0
	VRhyFx5h9SQA+9wjWtEDJBG+upmmVL7KlMqwuvdvCqwvMOr2eoKuGjkeb3sBK8HvqRRSOhh/fA2Yn
	TIIWsytqgykm1OftMxsvmRVta29feFzat9RySex23WCvHJHd50qNILTuGBXuJ/jliYe1r47N1Mugt
	SZh5TtkTzAZ5PjUTuhTCctDlxf2rOXFi3coByKMgDMIVq+hD+2BJrp5YznBDh15c8LH2uCq8cXPJ1
	xsDOAkYVJYS4DUH/wWVHNLHax0x5TA2CQw8E1B5/UaaVuEzsoL3yZxuIjQjE/fwU06GTAJmP0Pr0O
	M4hitnWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stnTt-00000006bEF-0NbM;
	Thu, 26 Sep 2024 12:20:25 +0000
Date: Thu, 26 Sep 2024 13:20:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
	ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] Support large folios for tmpfs
Message-ID: <ZvVRiJYfaXD645Nh@casper.infradead.org>
References: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727338549.git.baolin.wang@linux.alibaba.com>

On Thu, Sep 26, 2024 at 04:27:25PM +0800, Baolin Wang wrote:
> This RFC patch series attempts to support large folios for tmpfs. The first
> patch is based on Daniel's previous patches in [1], mainly using the length
> in the write and fallocate paths to get a highest order hint for large
> order allocation. The last patch adds mTHP filter control for tmpfs if mTHP
> is set for the following reasons:
> 
> 1. Maintain backward compatibility for the control interface. Tmpfs already
> has a global 'huge=' mount option and '/sys/kernel/mm/transparent_hugepage/shmem_enabled'
> interface to control large order allocations. mTHP extends this capability to a
> per-size basis while maintaining good interface compatibility.

... it's confusing as hell to anyone who tries to understand it and
you've made it more complicated.  Well done.

> 2. For the large order allocation of writable mmap() faults in tmpfs, we need
> something like the mTHP interfaces to control large orders, as well as ensuring
> consistent interfaces with shmem.

tmpfs and shmem do NOT need to be consistent!  I don't know why anyone
thinks this is a goal.  tmpfs should be consistent with OTHER FILE
SYSTEMS.  shmem should do the right thing for the shared anon use case.

> 3. Ryan pointed out that large order allocations based on write length could
> lead to memory fragmentation issue. Just quoting Ryan's comment [2]:
> "And it's possible (likely even, in my opinion) that allocating lots of different
> folio sizes will exacerbate memory fragmentation, leading to more order-0
> fallbacks, which would hurt the overall system performance in the long run, vs
> restricting to a couple of folio sizes."

I disagree with this.  It's a buddy allocator; it's resistant to this
kind of fragmentation.


