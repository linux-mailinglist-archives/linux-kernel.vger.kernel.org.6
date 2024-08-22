Return-Path: <linux-kernel+bounces-297847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5B595BE69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C018F1F23E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2821D048C;
	Thu, 22 Aug 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lBnYwbwI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704DEC5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352150; cv=none; b=AjS61PpusQEEtHTBxqsPUXQtSFxs1/CP4nMUpg1CWYiBLBmli6WBXhIveberht2sBrVBausr0qMSxxmCWRMxOd7bOwkAInvZ8g5VaNzEkVzDRjygZSikoBgIw8pw6AxihWdh7nggxLJ6ablqemR7OD93dmMOq7o2Y2lRBN6iJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352150; c=relaxed/simple;
	bh=QCYwIGD+oMpesXyI/O/wwJZ5gqDzfWha4FsqIcdEzEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiPZcF2+uWTrEVZ7kIyXIORJ6Ke61uMMhtP81YwQRL+S8mIBiRwnSTTD1oD9YOpb+6MzDpAFvzPgGfZf/Bgt1MrPXZir8D53meFUPH16dJL3grkd3JEicSBUS4MHmXJ3pFk5uS97cwa1SUniTU1I+TsB9lvou+60VHgZfHZp3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lBnYwbwI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nDXnKMlzLOPb3GpSNnjPH1Hko34txp09ffWMfDxuwp8=; b=lBnYwbwIEpmHXZe2vv2gGxfnJV
	OXswbincFzP4Ay9PV2SG2mV2hJyE52ajgfa5mylHWn4MIZPyzMPyhK7gc7xqKPkPmP5BIhci9Pbt8
	7Ih0nZyhEjRpKOHXoqGETHwkIXd9i9z4wMLh5tYptJPWjpxAOEwxEuurDOBi8Tba0FiBRPKHQVwQx
	PEfaIaheLTR3twTN1Pn8YB61941L+2T22rDMaVEKUWyjL3TTVRoiWR9OHQLmUU8rdvVxJq4gH43gt
	VAdqhP/yY/it+XusJ+n7hQ7xk+kVtLkYXhlCdQU4z7oMq4iz8zDUjGLFcZg5nV8batRzgaqsomP2+
	4S4j/zvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shClI-0000000ApD1-24pk;
	Thu, 22 Aug 2024 18:42:20 +0000
Date: Thu, 22 Aug 2024 19:42:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Message-ID: <ZseGjKXaZIvgu9vQ@casper.infradead.org>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <Zsdz-NFl4oqZ37_h@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsdz-NFl4oqZ37_h@google.com>

On Thu, Aug 22, 2024 at 11:23:04AM -0600, Yu Zhao wrote:
> Andrew, could you patch up the line above? This is what it's supposed
> to check:
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 59266df56aeb..03ba9563c6db 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -452,7 +452,7 @@ static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
>  {
>  	struct page *page;
>  
> -	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
> +	if (WARN_ON(!order || !(gfp & __GFP_COMP)))
>  		return NULL;

I don't think we should do this at all.  Just this should be enough:

	gfp |= __GFP_COMP;

same as folio_alloc() (or now folio_alloc_noprof()).
Do we really caree if somebody tries to allocate a gigantic page with an
order of 0?  It's weird, but would work, so I don't see the need for the
warning.

>  	page = alloc_contig_pages_noprof(1 << order, gfp, nid, node);
> 

