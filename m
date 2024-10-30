Return-Path: <linux-kernel+bounces-388107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328299B5AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0711C2102D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80521194151;
	Wed, 30 Oct 2024 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJ8yYR0Y"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B478F58
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730262810; cv=none; b=c3Ymr+DtyX8v41VmlpiAyiSkU3CKdtUs8Q3KJ3Q9uqlK5ZkXqmBChYSOE3sfEHelLKxyOXL5SAeCP0ZwFZET9iBOSD6/dzTuQHd/Xhd+df3SBI1/EhdALUkx6VNafnOL+76TojI4/2BwGR3Voh5s8FLErz/xZwUcvyfQY3MfG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730262810; c=relaxed/simple;
	bh=7MYoUADX/p3i4JXe76Yp7utNi3GSHnJGT3PZCpfrgp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7Mwbf3NTdGa9t9EpPLXwzFwMf5Kpx0aJkklgvva+ZdV3QXD20v9PN2wqVbphxXRBYmY6Ard4mLfqc6+0dGTWmQKQbQhu9P/sGaw2gIFDVBIuS5FCn0yOz3ILKydWTpcO8I85igZk+7NImsqrqFWxfqfOH/e2gt6TTphkedvQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nJ8yYR0Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ztXonWeHlXSXD26VwgY5O/UQHUJOn+ojrlIUafH4x58=; b=nJ8yYR0YAQvy5Q1/oFYfUYBHRX
	LI6EO3DygMTZ4Ktsi7bT+fG0e6tsgrMhy2DXxVsRpjogDkK6iMPvTmeqE6UoJ/yvbKJAMhQHUI/H8
	9c4voPJL2sH6jDHp904ZI4p3gsp5/f4Z6uuK/d1CmpDtQhA9ClBytDfYGvenXD5CUi2hFT1MNJW2u
	nFyqI2cwHvox0nWl8Fhc0CUhQavFiwio0RAR8zI8yXP6G41RlLL646RvhewYWfThQgJBp90y8sXfT
	Z9PMvrlQeAMsbwfflWvT/nebKgIxMe1uYfuODkPhiWWh0p+CzDMRhKt0tGuaiISB3aF7p8yf1s8ni
	by1OL8qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t60Oe-0000000Gg1Q-1E7V;
	Wed, 30 Oct 2024 04:33:28 +0000
Date: Tue, 29 Oct 2024 21:33:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	linux-stable@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <ZyG3GAvTHpRL9tnU@infradead.org>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 29, 2024 at 09:30:41PM -0700, John Hubbard wrote:
> I do, yes. And what happens is that when you use GPUs, drivers like
> to pin system memory, and then point the GPU page tables to that
> memory. For older GPUs that don't support replayable page faults,
> that's required.
> 
> So this behavior has been around forever.
> 
> The customer was qualifying their software and noticed that before
> Linux 6.10, they could allocate >2GB, and with 6.11, they could
> not.
> 
> Whether it is "wise" for user space to allocate that much at once
> is a reasonable question, but at least one place is (or was!) doing
> it.

Still missing a callchain, which make me suspect that it is your weird
out of tree driver, in which case this simply does not matter.


