Return-Path: <linux-kernel+bounces-227818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4859156D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1501C22859
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D71A0B12;
	Mon, 24 Jun 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cwp3yrx8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A819F482;
	Mon, 24 Jun 2024 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255385; cv=none; b=rhoZNTEcZ3hyFrqxSuYc+PunOySJvl30TxRi7J9e1sbHUq6AmlwVontxH1pOpyMxzeVnMwQhzPjPZ6os4Nkj1Y0WjgpXIjBc39WEpSpUUyXfpklDN0lghTEOOAaOP+ya8aleGcaDbHAEhrzROmyVhC1DkItVE6Jfo4okp+mH1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255385; c=relaxed/simple;
	bh=3L+b7Z9ucGhuYrpsuLqxpNySOov7ijAdVucNB3GT/4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDl29iEfEGF6OmHY41fO2QGpWcbuD5x9jxLwjbF11mWFD2HkS5tqNdbngpf82TUZBGZV1cGfwSrUW7zM8BPRwOzDbaZ46kxdA59GzhWtGQFH/BFtbMfemg4LUQS43/ERf7FUh/oLzRKmTBVDR4uirF8wp8aTljDFNixODI6jWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cwp3yrx8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BMTLXpb48lqB4H2o7jAA2KG7ULb3l4ZNE6T9+BrgCYE=; b=cwp3yrx8APpmDUuKC7Sk7YVK4G
	CyMEyYnFYmpa/KNibnHnR0bZD0DO/9/IQXwOlytTtv95xkhAzk8bDb/88Hf8TKqrIqop6bH29ZZ7v
	G7t0sISpix4HY4SB0DQahM2+6BGysYSa7TAP+ta6R299utvgC2HkZwuH1BhUFeyG/zs3aoI4sf9hI
	jnyHCJs1gwtfnTML2IX8sQKX5jfkwsNJgmXJ/W3fQP2Wp1if+feot/ajWt6KRiiwk84DIENefgoer
	2lf3bT9NwRVJQuynRnrDHOwxilTrqOiAvhCZRs53zlDWcU7MQAhSJFhDIi2IPiDiTkbrKQ1a6/A9c
	lII6MfRg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLorU-0000000ALgu-2jlA;
	Mon, 24 Jun 2024 18:56:20 +0000
Date: Mon, 24 Jun 2024 19:56:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Usama Arif <usamaarif642@gmail.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
Message-ID: <ZnnBVBItTNWZE42u@casper.infradead.org>
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org>
 <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>

On Mon, Jun 24, 2024 at 11:53:30AM -0700, Yosry Ahmed wrote:
> After a page is swapped out during reclaim, __remove_mapping() will
> call __delete_from_swap_cache() to replace the swap cache entry with a
> shadow entry (which is an xa_value).

Special entries are disjoint from shadow entries.  Shadow entries have
the last two bits as 01 or 11 (are congruent to 1 or 3 modulo 4).
Special entries have values below 4096 which end in 10 (are congruent
to 2 modulo 4).


