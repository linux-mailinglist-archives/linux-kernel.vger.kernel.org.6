Return-Path: <linux-kernel+bounces-375560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA39A974E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FA01C242A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814612BB09;
	Tue, 22 Oct 2024 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPYEsg+D"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAA46BA;
	Tue, 22 Oct 2024 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568848; cv=none; b=Uu6l2HcYbWFoqLmecfC6xxLLa24rav07PMfZtUI1hrAE3WAd5XXiKvstnpft9tPHNVkzggkl3f/gb0v9AjU0wRDjGDAHnHpRF0WiHMSsuLAMCQzn/3kLmFvVlKH3J4X3VY3mHw9vuDdpn8SAZ2m866tWwEziDzPlE1gMPOg5vZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568848; c=relaxed/simple;
	bh=S3HSAmudI1I6oYccVhHSIWLounlaQW7bscypFgwlY8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRBq2i+7XY/QruT8wWnvFMxaZ2hSZR0+hWZNAUqqMeP33EjneQt5Qt107JAwfI8VUS5tN5Kzo9I9TYOqTyuZYqLi0p7Yj25iohk2gAGpAnCZQetp5D4gWDoqrAzoqViIbWYS5AaU0EPW8L4aL1YevWOO9tUOSVRyMf+mQcqtoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hPYEsg+D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q0X7i+0aRUlONZNiN6Q45nEvrk+L/+N1T0pRsBP18nM=; b=hPYEsg+DTgh4nxkHsiCAcw+RiA
	rUQ6PzIR0AbGubFV0pQu/2hC+Ia96xI9s85ji/7z7if9D8GtjXKipRWyqW6NbARaBin0vpSquMqNA
	P9dAN93UxAMdQkSTkJyhWG/qfrDHz3hq6QGcspkgkQqigF1+YH5dGyfjDNmQGd9jasGEVPFUN4xDx
	lbd7f+YRGOxJC6rMpYeQusmScbf947q6fVboY8PG9bl96Ro9szupHXq7iRsbI3bfFzK31hUD5xzko
	iUVdsiJ0GOOjxVnVKHxhbEYYrXJKW0NItcaf45BZsvt6+Gu9Wo1N2uoPm97bV50WiiIR+lnwAkk/t
	9WRnJXkg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t35rb-0000000H4mW-2IUg;
	Tue, 22 Oct 2024 03:47:19 +0000
Date: Tue, 22 Oct 2024 04:47:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Message-ID: <ZxcgR46zpW8uVKrt@casper.infradead.org>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <Zxa60Ftbh8eN1MG5@casper.infradead.org>
 <ZxcKjwhMKmnHTX8Q@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxcKjwhMKmnHTX8Q@google.com>

On Tue, Oct 22, 2024 at 02:14:39AM +0000, Roman Gushchin wrote:
> On Mon, Oct 21, 2024 at 09:34:24PM +0100, Matthew Wilcox wrote:
> > On Mon, Oct 21, 2024 at 05:34:55PM +0000, Roman Gushchin wrote:
> > > Fix it by moving the mlocked flag clearance down to
> > > free_page_prepare().
> > 
> > Urgh, I don't like this new reference to folio in free_pages_prepare().
> > It feels like a layering violation.  I'll think about where else we
> > could put this.
> 
> I agree, but it feels like it needs quite some work to do it in a nicer way,
> no way it can be backported to older kernels. As for this fix, I don't
> have better ideas...

Well, what is KVM doing that causes this page to get mapped to userspace?
Don't tell me to look at the reproducer as it is 403 Forbidden.  All I
can tell is that it's freed with vfree().

Is it from kvm_dirty_ring_get_page()?  That looks like the obvious thing,
but I'd hate to spend a lot of time on it and then discover I was looking
at the wrong thing.

The reason I'm interested in looking in this direction is that we're
separating pages from folios.  Pages allocated through vmalloc() won't
have refcounts, mapcounts, mlock bits, etc.  So it's quite important to
look at currently existing code and figure out how they can be modified
to work in this new environment.

