Return-Path: <linux-kernel+bounces-300605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A22A95E5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D96F1C20A80
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D9F77104;
	Sun, 25 Aug 2024 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dYiZvETC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55D6BFC7
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724628569; cv=none; b=liOre5KJdugt8s77pS8GYlwz2hixG4SDS3/umvPdGZ6l4mNkJxetQPb33Dj2JtkP8zXM4k2PGpb2p1/FSL/w1aUBS0fPVExIMkzX8aAwqMUB2yUONCONYtDg2ZqIbn18Xx1WU7Qd70iuAwQzmqg907bhhZMgptugQzh1JSnS/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724628569; c=relaxed/simple;
	bh=BLVhj000wKo9s66rw2blw0rhyQLyunot2S12h4z2QAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAavasXkCQ6Ve+9rseHdjzZgEuIyBNW2MbwFZrrHqhTn+/R3LQMrIyL4o6nkCAKcCzqGvs6XTExcNvZhqudFKUvXjSTS0bnfHThYBiPO6U6+JTeMfoXn4++wZBiWpNE4Zz5EIFm7jsZdZAqU6c1dGVc7RPfabFw08cYgbwOY19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dYiZvETC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6WmqFAxCOp6Wliq2cYkJz9GIAwrqWnHFntY1ZSayFFE=; b=dYiZvETC4JIeF5bkrobqpWY9EM
	G/NyA4FO2OhvvZD+d51CgYP8gk5PEZSzyAR0iT0AWEPdPmns7i2kppBtCdQOgUa66xAmCRsvhyPwA
	qea4zaYlht2arz69kk+wmQ4/Swv6fuQej2JLyTSXstM/xnnT2X4uhWDg319I/N1YUfe7dmvC+Mr71
	GvSd4kkEM239V/M0w+HM8J4XQ+hNHDV91ntpS0jgsHmYSBIGIhneTljyp2ZWZSRcMBVmLtGnVSteQ
	bht5EzchQNJ4nXpW6Y+Evsht297TS/LLUlOmPmolMlZQ7kY8PljZPwIs6XGPTb6dokrksg6ZlXMr3
	5bTpjo6A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siMfI-0000000EinG-2sB6;
	Sun, 25 Aug 2024 23:28:56 +0000
Date: Mon, 26 Aug 2024 00:28:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org,
	ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
	shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
	da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] mm: filemap: use xa_get_order() to get the swap
 entry order
Message-ID: <Zsu-OCxgB9OAK050@casper.infradead.org>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
 <6876d55145c1cc80e79df7884aa3a62e397b101d.1723434324.git.baolin.wang@linux.alibaba.com>
 <d3dc75e2-40a7-8439-734c-19d83707164c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3dc75e2-40a7-8439-734c-19d83707164c@google.com>

On Sun, Aug 25, 2024 at 02:55:41PM -0700, Hugh Dickins wrote:
> The second issue is that swap is more slippery to work with than
> folios or pages: in the folio_nr_pages() case, that number is stable
> because we hold a refcount (which stops a THP from being split), and
> later we'll be taking folio lock too.  None of that in the swap case,
> so (depending on how a large entry gets split) the xa_get_order() result
> is not reliable. Likewise for other uses of xa_get_order() in this series.
> 
> There needs to be some kind of locking or retry to make the order usable,
> and to avoid shmem_free_swap() occasionally freeing more than it ought.
> I'll give it thought after.

My original thought was that we'd take a bit from the swap entry in
order to indicate the order of the entry.  I was surprised to see the
xa_get_order() implementation, but didn't remember why it wouldn't work.
Sorry.

Anyway, that's how I think it should be fixed.  Is that enough?  Holding
a reference on the folio prevents truncation, splitting, and so on.
There's no reference to be held on a swap entry, so could we have some
moderately implausible series of operations while holding only the RCU
read lock that would cause us to go wrong?

