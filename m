Return-Path: <linux-kernel+bounces-330700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CEE97A2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8501F23959
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9D155741;
	Mon, 16 Sep 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLK7UosS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC61514C6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493110; cv=none; b=L2rZEHGC/DZWFTCg3GkCjCcFIxjwrrrCoZf8oUGt9FMMFSD8Soy9dXbEys5Xwyev35qmg/9TpJXCGcBVYdTuXwj3lDTmzqJJAjqwkWVIT3Dgcio/KTXNaYk//NOSYpg+Vn0a3827D4xDDKReu9vOC63N/FDGGIwBzRtVVi2c86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493110; c=relaxed/simple;
	bh=yfhbgNP+N8MQHK0CDy2hCXn6zAAVkLYuZ8Iv/Mc0aTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn2pIkyPnjg6GZKNLlOlexAlOOdDNG/MSU4JY/98Ef/BJ0J2hdaN+946xpUmak6XnK3jJD/p05Vv0MeHrCUx9S0pRTfx4Btz2xQJPM4UNbOQZZOMB3KAcNzZLpUY6q74rQUYU5m4Fos8Hl4Ost+ukLuUsPmsLsDzpVjx9V2u1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pLK7UosS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fgiODAfiQcb0LKfqO4iEQQE6Kpw0QZtjHhK24pMbkLw=; b=pLK7UosSI7zfM0lxSTdE5fkRGJ
	7SfEblXaqfdKCj2yXeY13OnINhemod0nNPXAEXEZ5DGQ6BHvKbmgGJfsh/ovfg4uLSBX3qXcrQspe
	PqZdIQDunZyRGUxlBkA28e/OL59LTHZtrF25Tmh4fAMtn8/L0d11iLI3KQ5NoGaKhOzYHFzXIFCAW
	WVR+ZlUacqfmlOc0/HaZRvRCUf8OTCZE5BNjJYhPPtdnqnkWApRiXcaGpllvxnQooRE39k819W1b/
	dUA/AhS6Kr/u6EFD7BGHDQZ+lVNW3ul22CkoJy6uTLNS0OsUiJWxuLfwFZsCE4Yqd/n18R5VefhSC
	v9CwVwYA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqBiq-00000001z5K-2z3n;
	Mon, 16 Sep 2024 13:24:56 +0000
Date: Mon, 16 Sep 2024 14:24:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, baohua@kernel.org, hughd@google.com,
	ioworker0@gmail.com, wangkefeng.wang@huawei.com,
	baolin.wang@linux.alibaba.com, gshan@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
Message-ID: <ZugxqJ-CjEi5lEW_@casper.infradead.org>
References: <20240913091902.1160520-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913091902.1160520-1-dev.jain@arm.com>

On Fri, Sep 13, 2024 at 02:49:02PM +0530, Dev Jain wrote:
> We use pte_range_none() to determine whether contiguous PTEs are empty
> for an mTHP allocation. Instead of iterating the while loop for every
> order, use some information, which is the first set PTE found, from the
> previous iteration, to eliminate some cases. The key to understanding
> the correctness of the patch is that the ranges we want to examine
> form a strictly decreasing sequence of nested intervals.

This is a lot more complicated.  Do you have any numbers that indicate
that it's faster?  Yes, it's fewer memory references, but you've gone
from a simple linear scan that's easy to prefetch to an exponential scan
that might confuse the prefetchers.

