Return-Path: <linux-kernel+bounces-388103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F29B5AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D28B2234A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568EA194C90;
	Wed, 30 Oct 2024 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aVyr+rj7"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABE194151
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730262105; cv=none; b=LPYWcqgXpaheTVOViqK6je9ELQfzRghQGFTAPPJIV9MBL9y/vQEQIHgHvmx85D0MF2NJS2LQ1ghUOWbQr4l/B4uqJgy7HOeeqxJpioSWMXCr9p8ZxJjEiMFFrUfZSqLJoMqVp7pvvcNkGQJMCxsPNSGGQCjnl1enSZ1pA+iRrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730262105; c=relaxed/simple;
	bh=wisanbO9hLmDR0lw3aQP7ml9Syvd6hHkMusbSUf2w5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd+uWdgc2sXzsrZeR7GkvBmzqX67xjbmCiNrR0IIOy9XVKiTBDxpz3hmozYN/zK98KqOCWYEGPOnDvO/IwGmlGHulZLK6ikeOGeo0iTmHuOweOGSsuBJnQrYZTsYP/AqqG6Cm0uhOrycsNYPjrwE8DSjZ4Q7cmn0zAlK6eNS1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aVyr+rj7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/EH/V12UsM1/TM05QBwWJvuVH4xuMqzOX/VopV1zqM8=; b=aVyr+rj7YrlBs+JNebgkybqyr3
	sCqqY/si1/Q5O2W3XT9AiyqgxAzEVkhyVYhuDMdF4fCk8ZvdHolgrz4emoz6dn3HIjf5lGpzvjwvc
	8zzCagMUGCPJzUqvpteovDvITyexAximlvruCHuSuj89PkLNU5h0z9+ZhEitCbPtItaWLN7icHLMW
	rf0HJiaOFeKNWwqyByKB4ck9FWFr4MuHdoUbSoV81Gw7jBqVZjyZZdxgZ3vnTvds4tvX7lKHxY/NR
	Vr8SIMT6x8Hoo7wTmXDHS6QpHDQpMbOeawuKrTRaqP0EAr3yzZY529EmR2jMXgfnpL62ZKC11JcCK
	de4pmWig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t60DE-0000000GfAB-2XTe;
	Wed, 30 Oct 2024 04:21:40 +0000
Date: Tue, 29 Oct 2024 21:21:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	linux-stable@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
Message-ID: <ZyG0VKUpFttPF30f@infradead.org>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030030116.670307-1-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 29, 2024 at 08:01:16PM -0700, John Hubbard wrote:
> A user-visible consequence has now appeared: user space can no longer
> pin more than 2GB of memory anymore on x86_64. That's because, on a 4KB
> PAGE_SIZE system, when user space tries to (indirectly, via a device
> driver that calls pin_user_pages()) pin 2GB, this requires an allocation
> of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
> kmalloc().

Do you have a report whee someone tries to pin that much memor in a
single call?  What driver is this?  Because it seems like a not very
smart thing to do.


