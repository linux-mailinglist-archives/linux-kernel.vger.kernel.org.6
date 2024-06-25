Return-Path: <linux-kernel+bounces-228913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AD5916895
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A2E1C20FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9369157A5C;
	Tue, 25 Jun 2024 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nhr9RXwE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E214D2A0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320821; cv=none; b=QO36/+r98PIM68TkDNnDUxjzZfmSttDOFIGulobrFZrFrgaHq63LRLXP9SbHDtC/k/6iBiXfENfaNLPjQeuCSZU/d0tVlHKmSQZAeVCnO8nA2ZcrHAHYP+fm6mx7TF34U8iDXtoanRx62nIK+zFakbVo9V4N5/guWotu87tvbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320821; c=relaxed/simple;
	bh=J0gMuqeU5deUjx2w7hQdtf5w71OL8YpI9dPnPhTvBjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvtcDdtM01ic8C3ek+Fs0MRu3EmKEjy0/g/yx1GE7QUHp/60vG6/PFd1k9bZQu6Td2TOjXT6YFruNGtnrV7i8VrYg2InkB4uJYp7XsPcMTTNPS5/NqPac5KmsMC20lmGQ78YWRypJi7vaNfADljNGtDhqOmpLZjFF1Gmyh7a1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nhr9RXwE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uJ7hWaXxJ9nttN5wvvdvZmPC2/6Vfv3y1uigVrqH7Wc=; b=nhr9RXwE9gNy4OxfhLEOHIpamL
	ye0Qbn2AedJX6y4THUoBgdvfvgo9EoOXhpHNkr5KOyNeEYUNfojioKzG53I5Isac2gb3KmmXWr9Zv
	iipNwIsmmgeCD+gjub6Emqg3hsQjwg235rTqbYqIWFgdhFJjNt9D7L8hHkCtC4EGDE1NsQoaJRVfH
	2UD4DYd/tDzYBRypix7EfPaqFY/yCRCa9rvOkywadiqHZIhy5thxRuFNFmmIS/OJ3hZpWX1tYP8+y
	j3kQsfHW6IcNO6ibjv9VsKWHV+24TrZNPzM5JiScsOesw0xXV2GIbpcVqn4b73l4YN/goXk1oYKmQ
	0ZIYEO7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM5sM-0000000B9hI-2XAv;
	Tue, 25 Jun 2024 13:06:22 +0000
Date: Tue, 25 Jun 2024 14:06:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/18] arm64/mm: Automatically fold contpte mappings
Message-ID: <ZnrAzjm5Fqg0d1CL@casper.infradead.org>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-19-ryan.roberts@arm.com>
 <1285eb59-fcc3-4db8-9dd9-e7c4d82b1be0@huawei.com>
 <8d57ed0d-fdd0-4fc6-b9f1-a6ac11ce93ce@arm.com>
 <018b5e83-789e-480f-82c8-a64515cdd14a@huawei.com>
 <b75aa60d-e058-4b5c-877a-9c0cd295e96f@linux.alibaba.com>
 <b6b485ee-7af0-42b8-b0ca-5a75f76a69e2@arm.com>
 <43a5986a-52ea-4090-9333-90af137a4735@linux.alibaba.com>
 <306874fe-9bc1-4dec-a856-0125e4541971@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <306874fe-9bc1-4dec-a856-0125e4541971@arm.com>

On Tue, Jun 25, 2024 at 01:41:02PM +0100, Ryan Roberts wrote:
> On 25/06/2024 13:37, Baolin Wang wrote:
> 
> [...]
> 
> >>> For other filesystems, like ext4, I did not found the logic to determin what
> >>> size of folio to allocate in writable mmap() path
> >>
> >> Yes I'd be keen to understand this to. When I was doing contpte, page cache
> >> would only allocate large folios for readahead. So that's why I wouldn't have
> > 
> > You mean non-large folios, right?
> 
> No I mean that at the time I wrote contpte, the policy was to allocate an
> order-0 folio for any writes that missed in the page cache, and allocate large
> folios only when doing readahead from storage into page cache. The test that is
> regressing is doing writes.

mmap() faults also use readahead.

filemap_fault():

        folio = filemap_get_folio(mapping, index);
        if (likely(!IS_ERR(folio))) {
                if (!(vmf->flags & FAULT_FLAG_TRIED))
                        fpin = do_async_mmap_readahead(vmf, folio);
which does:
        if (folio_test_readahead(folio)) {
                fpin = maybe_unlock_mmap_for_io(vmf, fpin);
                page_cache_async_ra(&ractl, folio, ra->ra_pages);

which has been there in one form or another since 2007 (3ea89ee86a82).


