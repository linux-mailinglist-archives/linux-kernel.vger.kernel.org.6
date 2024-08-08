Return-Path: <linux-kernel+bounces-278843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A584394B58C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF10B22FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AB4317B;
	Thu,  8 Aug 2024 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ToO2+3tZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6D84047
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088289; cv=none; b=AI4k+3JFwO/VZQNA/FfhqSYnrWqX1PWxS8Ijj/OMlLlzH+/xc/egUvDmXsTgKjEiKXaACRQs+r+xNiJ4fZzuHavRCRyHrEEANE1shdUNiJIa4B9mqiGHsdbgbaMj4J2oA09bSDR8TZ0q46mgRJuOtRbNDOL8Gu4/IDiY5JHcQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088289; c=relaxed/simple;
	bh=h1fQ6oOu5qM814cpSWIfiMzDsDByfjlzRueTVvi5zf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/h6Pts/Jicw5Z9+pNTjLc1b5e78OKWtr7ps29CrZZ4+8cbV+9bozfF7uH4rRQgev6mHkpscxkHGeIbl8Y0wQoQ1hrE6nLDbfMj62XdafRNHujTG6HPJH6NlAzaZJPG7hJabjnGWfjyOq62jYyhvPVaqe5tskGMn6i6+Y8qEc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ToO2+3tZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mg+rAaQV6uHCHFuKE6cEx9PFXjNi2reAUID+6kuiVYw=; b=ToO2+3tZpKTnZZVMENmOHaRWXF
	YK0MnsWEJGe61JEJAsI6qF6KPpWQ1C7r6F+qjEzKqfcLmCNuf3KXjNrnZvMrWG51/YSgfbQs/xJop
	sXzTikQcEsMkU5WEXu5M+IRaPwtfESKnYIbOqMODNOvXuyEP8q2xS4awmIPB+xvGUiDYg9Xtg2ipA
	ia/soPjsg83x4+/L6ybzghl7FfP43qzqMUPIl67bvgjVPMQ5jCpdjVZRejeTwGWnl6hM7GwUp6uWC
	8igLfpjd3Q04RMCtmFI6Vck7lV/s+abrRresDTwfdYTLTNU9tI4ogQ0uT+zNNHTfn3rRsXfk8j2cv
	51Z03BmA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbtyQ-00000008J2z-47q0;
	Thu, 08 Aug 2024 03:37:59 +0000
Date: Thu, 8 Aug 2024 04:37:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, david@redhat.com,
	42.hyeyoo@gmail.com, nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807051754.GA428000@google.com>

On Wed, Aug 07, 2024 at 02:17:54PM +0900, Sergey Senozhatsky wrote:
> On (24/08/06 12:34), Yosry Ahmed wrote:
> [..]
> > > So the sole reason for this work is as a part of the mem_desc
> > > conversion.  I'd like to hear from others who are to be involved in
> > > that conversion, please - it this patchset something we should be
> > > merging?
> > >
> > 
> > Matthew asked an important question here that needs to be answered by
> > zsmalloc experts:
> > https://lore.kernel.org/lkml/Zq0zucMFsOwATsAC@casper.infradead.org/
> 
> Iff "zsmalloc experts" include me: I was under impression that there was
> a zsmalloc conversion plan otherwise this zpdesc effort is a little
> confusing, and, frankly, it hasn't appeared to me that this is "my problem"
> now.

I don't know if it's _your_ problem.  It's _our_ problem.  The arguments
for (at least attempting) to shrink struct page seem quite compelling.
We have a plan for most of the users of struct page, in greater or
lesser detail.  I don't think we have a plan for zsmalloc.  Or at least
if there is a plan, I don't know what it is.

> > Do you allocate a per-page struct zpdesc, and have each one pointing
> > to a zspage?
> 
> I'm not very knowledgeable when it comes to memdesc, excuse my
> ignorance, and please feel free to educate me.

I've written about it here:
https://kernelnewbies.org/MatthewWilcox/Memdescs
https://kernelnewbies.org/MatthewWilcox/FolioAlloc
https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

> So I guess if we have something
> 
> struct zspage {
> 	..
> 	struct zpdesc *first_desc;
> 	..
> }
> 
> and we "chain" zpdesc-s to form a zspage, and make each of them point to
> a corresponding struct page (memdesc -> *page), then it'll resemble current
> zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
> will need to maintain a dedicated kmem_cache?

Right, we could do that.  Each memdesc has to be a multiple of 16 bytes,
sp we'd be doing something like allocating 32 bytes for each page.
Is there really 32 bytes of information that we want to store for
each page?  Or could we store all of the information in (a somewhat
larger) zspage?  Assuming we allocate 3 pages per zspage, if we allocate
an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.

