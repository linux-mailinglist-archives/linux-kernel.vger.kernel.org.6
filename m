Return-Path: <linux-kernel+bounces-266070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF193FA56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F6E281229
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF415A86D;
	Mon, 29 Jul 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sTp9Xcl1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488036B17
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269508; cv=none; b=j68BrOk+Fh02Lt6N2K2ZDsQ9Z7LRmlmFlUVDj8xbuq1LRFvIMJqKUhtQbTSEvHTa7CiO2PKhhzOJiP5VxSO2dcrFURIXiIuaH92fVLzrYoLs/uGYkCbGArwcQo2dsSZ7a63d02sypApejdIoN3zEoWLQK36GEyAlHk9OTA3nz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269508; c=relaxed/simple;
	bh=EG0Kx8RzpbW11x60N0Ym+oEpBgT9uFZkobcZibkeU2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ1l5s7TD6pd4X/9ynO1mXpCQ1QBThN517OHIpttv2KPwpcihUZcC/oiZ4X8iMkk+DbELJ6Z0Ca3dh74SQI+HoFdp3wOpqkPZVTNAh00xvC+qnCffh8jHA6bL/8hEi/bTjVOR/8PzW2Zrq2xG8PL6U9YBKkuydgjv1tOd9iCcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sTp9Xcl1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=biFznc2Qk3fSa0fTy3cAGb+McXgGU5nJpYsuEccoPOw=; b=sTp9Xcl1SMPRS5wM/FYYNInedS
	IbVy1u1KWVzmQjuzthx57pEkmC1oj100Yo4vxoR1npEZiRbcEKomiR/rM/OeCHbrInkR6VZ72E0LI
	e/bknNteJrrKjLPqgF8lhQOd38IoPpbey41fujnCT0IvWR9Qco9LZ/0NDH67n1qc9MourPUR6nLJq
	wTBzglB3WO6IX3hYXbq+XU6VhzfJbndwep9MnyPPCZdATXTM5OicePRkioD6TYjdUa0DLo0PFxUlG
	K4qlMyjX+RAfgzfneP87g2dAiHXd9I5AC1l7B1NJR1ejfTBtGxD+qh50vWdSSf8qPL+6xkSnP+zw4
	l2OSL8mA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYSyD-0000000BxWA-1zi7;
	Mon, 29 Jul 2024 16:11:33 +0000
Date: Mon, 29 Jul 2024 09:11:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	xiang@kernel.org, yosryahmed@google.com
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Message-ID: <Zqe_Nab-Df1CN7iW@infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqcR_oZmVpi2TrHO@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 29, 2024 at 04:52:30AM +0100, Matthew Wilcox wrote:
> I strongly disagree.  Use the same sysctl as the other anonymous memory
> allocations.

I agree with Matthew here.

We also really need to stop optimizing for this weird zram case and move
people to zswap instead after fixing the various issues.  A special
block device that isn't really a block device and needs various special
hooks isn't the right abstraction for different zwap strategies.


