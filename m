Return-Path: <linux-kernel+bounces-551915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2423A572E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21F116CC64
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595FA254868;
	Fri,  7 Mar 2025 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J0DvUIAb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06413C8EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378992; cv=none; b=lEdl4wR1K+ajRewto7o5ZFw3lXGtNo4aQ1SIvtchq2olZL8ZoWKX46EYrE40f+4ojiF2EBqx5q798EZKdb13YuzqtkPYIU0qWlgNu1t1+CpN3GbTAqiXAMLrDrAFs+wnuoufc5VwT4f1WjUGm5+d9OZQjcu3EMIUXrAy+eIeQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378992; c=relaxed/simple;
	bh=Pa/zYC4hi/VgODj6rKBd9+OLmCo91YBFkb1liSvkpeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXkHQons03Ttol/3FiCZ069Tg97Uz0rkyebu7FdGI0R9cGqPNhB8jrIIB4zIiCJ1kdT+86RJJQNZ2tgO81UJqfU2yw1I7Ij6IVNgk8d8eeloM3X04uUi9xPu2CzhKq/g4ROuWrQ9hbuX2xLz8fgpEVetSx4kF3KyGZ66N7OB3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J0DvUIAb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a7isCmZUDJbjXt/eUigbnQpYb1FxUOZNJqfMhSY/Gzk=; b=J0DvUIAb7e0ZtF+aKGwlzxApf2
	Vl34l5EwjBcThiXmBSYVkpUMEMT1RfzN7xABUDukLYDtvWECaZ+6/lWgVqAR3Es5Xb8n0LRiYAkhd
	o2PN2TsWYEOL/gpmTPzZPh3ofoBwEHP7w7vMgv490YUQyWr10GcpwGm7qyfYhwnmZs510Cr8O+1oM
	Q91LEoJzhiTHTL5dnvuRGjvZyrZNI9hNtqXw9hok63dIDULu+mrIOf2Uw3PJyB2wTIP+TAM4527QO
	mi+MuzUjKdhawVFXBmOkXrwUim5ehON2PgEiiU2UnAtYpxWOpOdgVanK04va53ByxIlQyI1BuUbHt
	csBFShLA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqeDs-0000000EMwh-11KQ;
	Fri, 07 Mar 2025 20:23:08 +0000
Date: Fri, 7 Mar 2025 20:23:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sooyong Suk <s.suk@samsung.com>, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, jaewon31.kim@gmail.com, spssyr@gmail.com
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
Message-ID: <Z8tVrOezU2q_0ded@casper.infradead.org>
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com>
 <Z8m-vJ6mP1Sh2pt3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8m-vJ6mP1Sh2pt3@infradead.org>

On Thu, Mar 06, 2025 at 07:26:52AM -0800, Christoph Hellwig wrote:
> On Thu, Mar 06, 2025 at 04:40:56PM +0900, Sooyong Suk wrote:
> > There are GUP references to pages that are serving as direct IO buffers.
> > Those pages can be allocated from CMA pageblocks despite they can be
> > pinned until the DIO is completed.
> 
> direct I/O is eactly the case that is not FOLL_LONGTERM and one of
> the reasons to even have the flag.  So big fat no to this.
> 
> You also completely failed to address the relevant mailinglist and
> maintainers.

You're right; this patch is so bad that it's insulting.

Howver, the problem is real.  And the alternative "solution" being
proposed is worse -- reintroducing cleancache and frontswap.

What I've been asking for and don't have the answer to yet is:

 - What latency is acceptable to reclaim the pages allocated from CMA
   pageblocks?
    - Can we afford a TLB shootdown?  An rmap walk?
 - Is the problem with anonymous or pagecache memory?

I have vaguely been wondering about creating a separate (fake) NUMA node
for the CMA memory so that userspace can control "none of this memory is
in the CMA blocks".  But that's not a great solution either.

