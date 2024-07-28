Return-Path: <linux-kernel+bounces-264874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4EC93E985
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4182812E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD297581F;
	Sun, 28 Jul 2024 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byR5GtVz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC63EA9B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722201459; cv=none; b=W6fGHTo9I12imw2A9uDYyTSvZHrUk2r8Wezg3bxL6R7YlEjxeiTrWiGdQx1pMiOKEg6EFA8d8oWvM1jJ6EhicaSXoUUK7aNYwxF4C45mIHVTPcriBEcvEgoodoWVC4NqZe6ek+ZXMwwZthq0IRKpw+PqWd8DmhuyKqX4jPFCWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722201459; c=relaxed/simple;
	bh=kPn5XB9MJ2hFzb3QbC8qO8zKz36/qxUqdCyPprX+dkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIYhIakocl8sRpJi16Y7vzI7MTCL7/kchE70fhFlKYDVImKE3VCjW7ol+Nfdih2oX+Q2bavRiah1GMfOsiTCwqJD5cPYv8jAAbuBtOjYUzqAU1TTghdc4FJGVnPUnl9ZDnEgq8W3bngfXoP+esHhsI0T0LBzmVSPkdrzvzT8piQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byR5GtVz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qImPaow6K9GVHVx8GaOpIgdQelo0sFfSZ0Ixl6jVzdw=; b=byR5GtVzh1rHHOH3wsEEKeTCbc
	jnoj6wMcK0tH7bb+uM0IswzzpyEjKYt6X9rnpE7OIgngvR23XHK/+cKQIdo3USsTKHzIHC+lQRCNM
	f8fcIM5LkBAEX6vffX2loAFxUHxoLfffRye0U1rKb4dYAYqVFVNOsIwCnXdac/NZGIN47bTq9KVN4
	wIuWUxk8GsqkhSFC3vJTFDr5T8YRxv61VhmvsWQaFlBh/gZmgebeIgfMd90tqmsaN7a6kPDd7rZTU
	OesfKTZji1Z7OsgfiIzkjdvk45yET2ZgS1yBAL68oUDBL4pApaNbPkMZuCiQgnyHBFJCHwhiwGawx
	o1vETHww==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYBGf-0000000CoVl-38SQ;
	Sun, 28 Jul 2024 21:17:25 +0000
Date: Sun, 28 Jul 2024 22:17:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
Message-ID: <Zqa1ZZrrlp5jHElW@casper.infradead.org>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
 <20240728125005.c1171fa2d1beb6c1fe867d48@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728125005.c1171fa2d1beb6c1fe867d48@linux-foundation.org>

On Sun, Jul 28, 2024 at 12:50:05PM -0700, Andrew Morton wrote:
> On Sun, 28 Jul 2024 23:49:13 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > Currently, migrate_pages_batch() can lock multiple locked folios
> > with an arbitrary order.  Although folio_trylock() is used to avoid
> > deadlock as commit 2ef7dbb26990 ("migrate_pages: try migrate in batch
> > asynchronously firstly") mentioned, it seems try_split_folio() is
> > still missing.
> 
> Am I correct in believing that folio_lock() doesn't have lockdep coverage?

Yes.  It can't; it is taken in process context and released by whatever
context the read completion happens in (could be hard/soft irq, could be
a workqueue, could be J. Random kthread, depending on the device driver)
So it doesn't match the lockdep model at all.

> > It was found by compaction stress test when I explicitly enable EROFS
> > compressed files to use large folios, which case I cannot reproduce with
> > the same workload if large folio support is off (current mainline).
> > Typically, filesystem reads (with locked file-backed folios) could use
> > another bdev/meta inode to load some other I/Os (e.g. inode extent
> > metadata or caching compressed data), so the locking order will be:
> 
> Which kernels need fixing.  Do we expect that any code paths in 6.10 or
> earlier are vulnerable to this?

I would suggest it goes back to the introduction of large folios, but
that's just a gut feeling based on absolutely no reading of code or
inspection of git history.

