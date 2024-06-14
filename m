Return-Path: <linux-kernel+bounces-214299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB3A908273
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7411C226F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6D2AEE9;
	Fri, 14 Jun 2024 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QJ9FO89Q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEA19D8A5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718335343; cv=none; b=RpkO1fv//lckqWo9zretwAZbhIPURei78kFioqd3jIHD3V/GHvomcjD6kMT5fPZK/5ndSwDdAbIfkADYzOwjMg51BpIO5g6ITLHSZSZ0K02m2E39rsn0mMXdeE/OjjSufWaF2CcKZf0RhOrKxiB80FgzJ6MlWL1f2NqztGylNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718335343; c=relaxed/simple;
	bh=aAG5WkabnWljBhObPT99xr8j+f8JhtWaGALckcX6W98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkX76Zuw4nEy9RYrdag/uCH+m16Ln63wGBPrCguUK+GPs/DZnxtw59VwVDWU+GqYtXcM41i2dNh3q/twisAxRMna2s+3jIAQjfNh3o3dTe8jfqYFMNqanCSBFQa2ENWuGX5fJT0E+1DN8+c83oh3cAfJwR17L3Lsg6lfx0Tn0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QJ9FO89Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WC+OS8tP73IzC9fklby77PSdBXo2i/N8oh9tXyRadYk=; b=QJ9FO89QDAgII0sbVpbQTVCGAO
	g5Mshs6nS0CQ3O1tfNPcooP17fejBeSapIRJr8ELGdpjJyi3WAdiENCOtulbG6nwLO2YnI+ncOCOF
	C3bMAS7a5AwLZ1xW9+maUlu91qoac1tc2MtgrImMSfJU1cHc810foyuJSF3uqXHc0irkCY16BW9GE
	MD2PWCMv9V2V+aU4cPB4RSG/PYEXFnQZUmgzLivgO5Aj07Os1TRt1iz9xfeXGhmQ4wK05rZ9WfOen
	XF1v22kHhlhnLyQHYF5b6jQdBcgrWU2uiBw3R7LDy1yV8xxdQvnMnIukD+ANjeor7BmeBRMhPiXbU
	kGg2dj/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHxVx-0000000GWuH-1daT;
	Fri, 14 Jun 2024 03:22:09 +0000
Date: Fri, 14 Jun 2024 04:22:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, hannes@cmpxchg.org, nphamcs@gmail.com,
	yosryahmed@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: shmem: fix getting incorrect lruvec when
 replacing a shmem folio
Message-ID: <Zmu3YVFfUA6_uToA@casper.infradead.org>
References: <5ab860d8ee987955e917748f9d6da525d3b52690.1718326003.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab860d8ee987955e917748f9d6da525d3b52690.1718326003.git.baolin.wang@linux.alibaba.com>

On Fri, Jun 14, 2024 at 08:49:13AM +0800, Baolin Wang wrote:
>   * Charge @new as a replacement folio for @old. @old will
> - * be uncharged upon free. This is only used by the page cache
> - * (in replace_page_cache_folio()).
> + * be uncharged upon free. This is used by the page cache
> + * and shmem (in replace_page_cache_folio() and
> + * shmem_replace_folio()).

Please just delete this sentence.  Functions do not keep track of who
their callers are.


