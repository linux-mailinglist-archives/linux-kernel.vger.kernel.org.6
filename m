Return-Path: <linux-kernel+bounces-573116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF34A6D32F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2289A3AAAA3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928031411DE;
	Mon, 24 Mar 2025 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vXomMG2j"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144223A9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742785080; cv=none; b=H1zviGnV+xjDjokA/Bm+NmLyxQtlTQDV5Yubpzv9RkmyWhXRwzDXjHJluVau07vCX/u4TjBJjFXq0zkkVImxC2EX/+JonAOtYItCEm8BtjC4IX+B7ewskHYArxH6sdCQ4Bt5s+niLknl8PkUGnGUkcel79F2luH+SXwkktTP1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742785080; c=relaxed/simple;
	bh=8ul0KMr/RNQ7Hi+rpiV33i6WR7W+5S+funoRaLHaa7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ4CebWbvaqxhehiS38BfzUxM+PQD9O2qNVsCiRJ0JdTbRdDNgg0Uw1BZM3HYuWedh9nxr6YOoiGjw+SmwIPZBxDZcxflinyIug6HSzv5T/3RX7AwbbFsfd2PnlFtMb0ORXDx1YIcBBcdcLRsDR82ALMfODoBtoenoTsD8Dl4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vXomMG2j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TJ90vDCXBicUUJaSFbuZEIdMu4AIlum58EPatQ/+ADo=; b=vXomMG2jBYWuMmBPV4woZcGzQM
	mJMq+fH6SWVXGjNLwubYJWniS3O6NZb53yFXL+zcQYbY/oQzPTL2I04YoDqEZ3uOxvWyqX+WULbry
	XQcSkQWU0x4RBwJC1fedyDmrpZJMqXM9jTdVyglRcWNBQS/idFR+8+No7BDIbAZAbyv/c9PxU1F8p
	s+yR0MH0Vz3m7iXfvVxPv9SOFhu2VAEYWSxFBPQueNMF7f8NrLX83Wou6YF8zX6tubgSvJXjGq7pR
	Z3a44GbbfzWJaY56NYLUsaUfaiANrVFvKei9VcqOy+7QqsmzWmFfOrNrkvxtyF3/j5hsuoqHaVLLk
	uZjpIMyA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1twY0Y-0000000HDX7-0EKp;
	Mon, 24 Mar 2025 02:57:46 +0000
Date: Mon, 24 Mar 2025 02:57:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Huan Yang <link@vivo.com>, akpm@linux-foundation.org,
	bingbu.cao@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	opensource.kernel@vivo.com, rppt@kernel.org, ryan.roberts@arm.com,
	urezki@gmail.com, ziy@nvidia.com, vivek.kasireddy@intel.com,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Message-ID: <Z-DKKQcc0dSdSrw8@casper.infradead.org>
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
 <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
 <20250318083330.GB18902@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318083330.GB18902@lst.de>

On Tue, Mar 18, 2025 at 09:33:30AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 04:20:17PM +0800, Huan Yang wrote:
> > This prevents us from properly invoking vmap, which is why we have turned to using vmap_pfn instead.
> >
> > Even if a folio-based vmap is implemented, it still cannot handle mapping multiple folio ranges of physical
> >
> > memory to vmalloc regions. A range of folio is important, it maybe an offset in memfd, no need entire folio.
> >
> > So, I still consider vmap_pfn to be the optimal solution for this specific scenario. :)
> 
> No, vmap_pfn is entirely for memory not backed by pages or folios,
> i.e. PCIe BARs and similar memory.  This must not be mixed with proper
> folio backed memory.
> 
> So you'll need a vmap for folios to support this use case.

https://lore.kernel.org/linux-mm/20250131001806.92349-1-vishal.moola@gmail.com/
seems like a good match for "we need to vmap a range from a file".

Vishal has some updates since this version, and I'm sure he can send
them out after LSFMM.

