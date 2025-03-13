Return-Path: <linux-kernel+bounces-559482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C451FA5F450
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2F617EFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA00266F09;
	Thu, 13 Mar 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sVpWpDp5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22AE2673BA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868764; cv=none; b=R9DztV3ibWatLjs7L/dbtcXO8iZ1LJ3khPxRhZ/GSR2gD2jd6CKHi43VhavO0QZJ08X3pMtV2Z0iPRsVlQVG9VcLPg8vuRv38aoabvSV6ar1QW8mQfoyamK3TL1I7TpB43wM5sUjE8t0ou5IwNiW2+FceJSNlxqtlVSgddEdYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868764; c=relaxed/simple;
	bh=TQM9aeAbGb6lPiwXrEfPpKe6hBYFrT+PLjVC5oJ7W6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMXmIgWkcEMrwC3SJqBssN0WieC8Q2UsD2RV6IB3no8pCTbo4/hYgGTFehoAA5ljrvTeRbxq+QVm7oxdc8mgtlMFIHp7bT0i3W8ngshh2BSvjGTw3OMEyBY5lBC6yA8S1goiogPsk1AUExcOT3EQjOvIu4Ix8AmXvyDF8pc4ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sVpWpDp5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oUpCiEkkkXv8qjmMPM4PUHGiUlrQKPQ0xjfE1GNAcL4=; b=sVpWpDp5VfkvaKkumqZF0kF8ek
	N6iVPsAHPAjgEdL04cj/DenOsk9rXPpILf37hwGdsKmFPZ82RkswOTir4jT0sACy5fxv4erjo284N
	5h1kIYAc/p83ZsDKIqZe6/MUQApWO/R6Gs2h+5xRynztT1HSX+bqG+yTpjGTdervg2aKr6lSya8Kz
	hMQKxzeDoQg1aOWKzS+2Do2whRRpfixkoyeX2E2TJi5QJDPQ/oyn7vV6yBtggecmLyVv7odmLm7iy
	NWncyHtbgZ1bfwT6JffbwE04fzgMHDip8QTHZjBVfhiQeRzaHiyq4XF6WNdjmohHA8a6T1dDHEIvu
	zogP2oyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tshdH-0000000GDiR-0ejo;
	Thu, 13 Mar 2025 12:25:51 +0000
Date: Thu, 13 Mar 2025 12:25:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Zi Yan <ziy@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] mm: Move nth_page from folio_page into folio_next
Message-ID: <Z9LOzj17FDFDw7JM@casper.infradead.org>
References: <Z9JhwhMIn4uhkHrI@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9JhwhMIn4uhkHrI@gondor.apana.org.au>

On Thu, Mar 13, 2025 at 12:40:34PM +0800, Herbert Xu wrote:
> Discontiguous memory may require the use of nth_page instead of adding
> to struct page arithmetically.  However, discontiguous memory cannot
> exist within a single folio.

That isn't true.  HugeTLB can construct a folio which crosses a
contiguity boundary.


