Return-Path: <linux-kernel+bounces-372475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49099A4902
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C217B21788
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD82B18E379;
	Fri, 18 Oct 2024 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a71QD695"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B918D640
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287510; cv=none; b=PMawf+ZkVE63KdlRoZm9bi+GA1p2QraxE1X7yIhAPoU675PeRUe3+jRjMQpbLuWD1sUuFexwD4x2jIKTuH/ynCV97wcke0ju+1DRK6Tw6fi+oTI30ynJzzxSfLtdpzsyIBW3Xf8GM54A8VrDk1l9F58f6SM/+gGLFGfY34FTUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287510; c=relaxed/simple;
	bh=9/mR0strc0i71LGWOH3cbh5Ge6oQp5idlV4zItldwEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYcGBWCFNiwMsQ5hWjkXVow1HUJAK2+EKTlHP468rRz8xhju5dYldQ7WpRikbn71gpCs5/YimufwIssXpd9HNrljkDs4omHPgDtCoqRfAVsJoKCel3y+zRhNLpoFi6vLZRJ/uJBOOQgxJzwaBgLjd+GtufzvGSMWkE1+V/0/XJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a71QD695; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nzyRG3Z7ZIbPjAZ+tjsUIqSFqFzTEvGVVhA8rfQPaao=; b=a71QD695gI2GeQXJO1lHwGfGD8
	ngDqs9+mdtFf4bvRaUwaGnRQPIsGZAmJjR1mL/SjSU05b1V+vYmWFW92aJs66x/GmtlPpv6dYhgav
	WNJKrrzONZF2sP7wKzcWnOhGKsM7BWIyGUmlD5RkxupxLyTPv2hjzKpd52V4VkuWiza8TN1ugu9ZH
	tXz25z1GXGzokfKcXdC05X126JuGgNcn/pM6U5GUKToT5xeavL3DSI/ofC+1/HVQWIH6GZi2a3vGp
	f8l8jtr/uwNSXOXyU2pOt77095+/WLCi6JO1sUbn2XqwWJmER9igO77mTI/9La6eivYrF0Yf9avVK
	+EalVuXw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1ufq-0000000DcXM-2o2A;
	Fri, 18 Oct 2024 21:38:18 +0000
Date: Fri, 18 Oct 2024 22:38:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, zswap: don't touch the XArray lock if there is no
 entry to free
Message-ID: <ZxLVSkEr_Zd2Ai3Q@casper.infradead.org>
References: <20241018192525.95862-1-ryncsn@gmail.com>
 <ZxK7G3S0N42ejJMh@casper.infradead.org>
 <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>
 <CAJD7tkZMTJKYR+au2rjP1v+c8PvdP4D39j86tHg=o2riKGYynQ@mail.gmail.com>
 <ZxLLNfbLifp-b3W7@casper.infradead.org>
 <CAJD7tkaycBYvtTCoGsuNUekSDNnE5SZb-XyS5a8j83JsKQw4FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaycBYvtTCoGsuNUekSDNnE5SZb-XyS5a8j83JsKQw4FQ@mail.gmail.com>

On Fri, Oct 18, 2024 at 02:00:16PM -0700, Yosry Ahmed wrote:
> On Fri, Oct 18, 2024 at 1:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Oct 18, 2024 at 01:40:18PM -0700, Yosry Ahmed wrote:
> > > Oh I thought xas_reload() is enough here to check that the entry is
> > > still there after the lock is acquired. Do we have to start the walk
> > > over after holding the lock?
> >
> > Yes.  The entry is guaranteed to still be valid, but the node you're
> > looking in might have been freed, so you can't modify the node without
> > making sure the node is still in the tree.  We could make that cheaper
> > than a rewalk, but you're going to need to write that code since you're
> > the first to want to do something like this.
> 
> I see, thanks for elaborating.
> 
> Could you confirm if the current patch with the xas_reset() added
> would be equivalent to just checking xa_load() before using
> xa_erase()?

Yes, I think it would, so it's probably a poor tradeoff.

