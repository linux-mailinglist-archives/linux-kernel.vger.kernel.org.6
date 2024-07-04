Return-Path: <linux-kernel+bounces-241626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1D927D42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E833C285E7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF074BF5;
	Thu,  4 Jul 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MdOagRrY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133024964A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118627; cv=none; b=lWgm7eo2FTsb2OQmznqdyemkegzagDon/5vOtQHPpbepmgv58rskxNhAVgonzvzpZCJyx+dPgAbCP09gBSUnRPVjRlqqgsWskAq/J1k1L9r0/JKozXiMECUhJ/GpTigl+q7DHrbHgIJ0F6Po6ta9dRKu9brJYqJDWC5MLyVTbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118627; c=relaxed/simple;
	bh=rzKbnaZUmIdktLW7DeqDQh/+ZOewtJWOKFWPTVfkCWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDFnE+EQii4fPcj6/RYg3EcSUVNLU0RzenSgfplcb9ONr5yFBSB3MLD8DBlGeYUyIdslybeDmRyPEVkcpRkgvGUgWcn7eOzI5eIauDqac7sjyf3rq9uLJQ6TRpxMZQsOgC1heNjkqZwYVryAaXoh0OC/EL8pSP4EmUswfbJ3k0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MdOagRrY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sNKtxBcfq1FOj6FTpkpQvKnBvmpEW5e+Aixwe6zCgS0=; b=MdOagRrY9qMVl0YUfx5iwBc0EE
	0P1KFELrr68trhEYby80unYdLWGwZY5N0u0YpRLhVlL6IEnPzuwSLdigi3cOVSS3wn+kScJfSw+h5
	w1sDlmuAIK+0W7M6umWLTTAsO8h9Dn1FzwMWR3cCMiIoXCaCvEvjX8DqP2tLlxOt6gxDxDyyQ7AY+
	aWq5cx3r2fh4tOgkRPVVOBwrsoeU/twYCEkcU2M4mkZzJd1Nn8x3Prj7/FwE3NziISXnft/matHFc
	zx8bzFhPHBBrkmBClkKgh2WGbxx3PSKmDTGmOhXPfNoB7KihOQ7+8ioMSBxinnpbgJiZ9oUokqYBY
	Wry0GP4w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRQU-000000038qQ-0kqN;
	Thu, 04 Jul 2024 18:43:26 +0000
Date: Thu, 4 Jul 2024 19:43:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
	ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
Message-ID: <ZobtTmzj0AmNXcav@casper.infradead.org>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718090413.git.baolin.wang@linux.alibaba.com>

On Tue, Jun 11, 2024 at 06:11:04PM +0800, Baolin Wang wrote:
> Anonymous pages have already been supported for multi-size (mTHP) allocation
> through commit 19eaf44954df, that can allow THP to be configured through the
> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
> 
> However, the anonymous shmem will ignore the anonymous mTHP rule configured
> through the sysfs interface, and can only use the PMD-mapped THP, that is not
> reasonable. Many implement anonymous page sharing through mmap(MAP_SHARED |
> MAP_ANONYMOUS), especially in database usage scenarios, therefore, users expect
> to apply an unified mTHP strategy for anonymous pages, also including the
> anonymous shared pages, in order to enjoy the benefits of mTHP. For example,
> lower latency than PMD-mapped THP, smaller memory bloat than PMD-mapped THP,
> contiguous PTEs on ARM architecture to reduce TLB miss etc.

OK, this makes sense.

> As discussed in the bi-weekly MM meeting[1], the mTHP controls should control
> all of shmem, not only anonymous shmem, but support will be added iteratively.
> Therefore, this patch set starts with support for anonymous shmem.

But then this doesn't.  You say first that users want the same controls
to control all anonymous memory, then you introduce a completely
separate set of controls for shared anonymous memory.

shmem has two uses:

 - MAP_ANONYMOUS | MAP_SHARED (this patch set)
 - tmpfs

For the second use case we don't want controls *at all*, we want the
same heiristics used for all other filesystems to apply to tmpfs.

There's no reason to have separate controls for choosing folio size
in shmem.

> The primary strategy is similar to supporting anonymous mTHP. Introduce
> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> which can have almost the same values as the top-level
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> additional "inherit" option and dropping the testing options 'force' and
> 'deny'. By default all sizes will be set to "never" except PMD size, which
> is set to "inherit". This ensures backward compatibility with the anonymous
> shmem enabled of the top level, meanwhile also allows independent control of
> anonymous shmem enabled for each mTHP.

