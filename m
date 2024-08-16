Return-Path: <linux-kernel+bounces-290044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1482C954EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DBC286FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144C51BE86C;
	Fri, 16 Aug 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSrcELY+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C41136E30;
	Fri, 16 Aug 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825737; cv=none; b=lGgp0zWiV9CU+eLcaKjavNyp4qpxjmdrvXazRKGmrtttm7+/6ZW0V4/wr50DJ/IqvjzZiW228sgIP6arUFzdfltc2hRwy+S3SrLWl/H4OQX5SUwK5jOxRxLqNIHzXwlYUpAB6A8z0NkYlSJwOgr8HZVpcNPrbXSgLiuAFJ+2OAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825737; c=relaxed/simple;
	bh=0J+rLTMp8kiLZd1JqjyJt5eF9jyu5SOJIppMBhBEPCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVhHJu9Z9oFy6966YDxnXiBtXF1vgs6B6KlYs0wml/1HduxvylA3510QApDWmyEiNTH5WBuK6yvTfDvf1lp9fMdiJOLrThSffT/ZWR0aV36U7rK1PxbC97Ua4t/GixZqxvWODSZwWZhftLurOnRAzLXbNnny/DgYfti3jUJfkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SSrcELY+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4yETDy6MieaRsK+UJbUVgFce/NUzNCq0nlWM4sO6NJ0=; b=SSrcELY+pxuudhB8eAMj5Qb8nK
	ATzqkMhKMU84KnY4hQFZe/qm3oTvOyZN1lblqSbxv4lcyoXTVPEI5bvacTPXqRGOOz46ysRCzfT6R
	QJjrcUoeoPFoezmHOxIDTuhKPKBtmFl1Fg2DMjEqrS4bz2bEGTT9jzNC+JzTnSlk9ZNJzwjEQBDPG
	7OJ/oW3J3ahPTGgwidi7KCLBQCACNHdvD7loAIWyGiXn44UMLYqFm1AEqTfEPutpzjJ3kxfJvnqLe
	nzultZDxbJS44Akl7bNgCJIT75yVLhOssFc2bmdMKUxeXDc3t8QAx3k8mu/0CoT+nAb6xKE+5BTbv
	rTaKhNQw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sezoi-00000003ois-3CuC;
	Fri, 16 Aug 2024 16:28:44 +0000
Date: Fri, 16 Aug 2024 17:28:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
	yuzhao@google.com, david@redhat.com, baohua@kernel.org,
	ryan.roberts@arm.com, rppt@kernel.org, cerasuolodomenico@gmail.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
Message-ID: <Zr9-PA8xBSJJzmdx@casper.infradead.org>
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com>
 <Zr9zx74W6-oRwKXB@casper.infradead.org>
 <7e9e209b-b6b4-485b-ad43-9e1efbd63a7d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e9e209b-b6b4-485b-ad43-9e1efbd63a7d@gmail.com>

On Fri, Aug 16, 2024 at 05:08:35PM +0100, Usama Arif wrote:
> On 16/08/2024 16:44, Matthew Wilcox wrote:
> > On Tue, Aug 13, 2024 at 01:02:47PM +0100, Usama Arif wrote:
> >> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >> index a0a29bd092f8..cecc1bad7910 100644
> >> --- a/include/linux/page-flags.h
> >> +++ b/include/linux/page-flags.h
> >> @@ -182,6 +182,7 @@ enum pageflags {
> >>  	/* At least one page in this folio has the hwpoison flag set */
> >>  	PG_has_hwpoisoned = PG_active,
> >>  	PG_large_rmappable = PG_workingset, /* anon or file-backed */
> >> +	PG_partially_mapped, /* was identified to be partially mapped */
> > 
> > No, you can't do this.  You have to be really careful when reusing page
> > flags, you can't just take the next one.  What made you think it would
> > be this easy?
> > 
> > I'd suggest using PG_reclaim.  You also need to add PG_partially_mapped
> > to PAGE_FLAGS_SECOND.  You might get away without that if you're
> > guaranteeing it'll always be clear when you free the folio; I don't
> > understand this series so I don't know if that's true or not.
> 
> I am really not sure what the issue is over here.

You've made the code more fragile.  It might happen to work today, but
you've either done something which is subtly broken today, or might
break tomorrow when somebody else rearranges the flags without knowing
about your fragility.

> >From what I see, bits 0-7 of folio->_flags_1 are used for storing folio order, bit 8 for PG_has_hwpoisoned and bit 9 for PG_large_rmappable.
> Bits 10 and above of folio->_flags_1 are not used any anywhere in the kernel. I am not reusing a page flag of folio->_flags_1, just taking an unused one.

No, wrong.  PG_anon_exclusive is used on every page, including tail
pages, and that's above bit 10.

> Please have a look at the next few lines of the patch. I have defined the functions as FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE). I believe thats what you are saying in your second paragraph?
> I am not sure what you meant by using PG_reclaim.

I mean:

-	PG_usama_new_thing,
+	PG_usama_new_thing = PG_reclaim,


