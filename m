Return-Path: <linux-kernel+bounces-227782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB4915684
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286D428217D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F91A00C4;
	Mon, 24 Jun 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vE8d0lxM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9B1E4AE;
	Mon, 24 Jun 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253996; cv=none; b=i/oBpaLXyDlstQRX2T2D7NOndcpiUpGhpYvPND9+CznStddfXvIGV4oWiNa8kMgwWfWh0Sqs3saNbDyMpvMBwkFj3pG/kePHFzbm0ywtMNe4L82+l/MewyHzJTo/fFF8djob3v1wk+qIOnNdfwx7V1w1UDjL2izGq+/Am+dD9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253996; c=relaxed/simple;
	bh=FImRCEJmQVuZdJUbFenwnuHnCEBuJyncLNxHvR/ex2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw5k4Jp3KabHkz8xnafGl2MJNJLIEJJjAJ3YEisXGe4A0UQfZfWkz2v16oMnnkbAYIfUJj3bqdcZKrYWMqD93GPpRzVjWBvsrRl290pzzNc74at+hUXx0YNw9kxg088+YD1Mo0o8Vgr01/aCFh7WMij7EdZh2quZZMwMALj/pvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vE8d0lxM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WZcanLtIBn58D6P4Ny2Mji71UPrni7o62c3guhZTyt8=; b=vE8d0lxMu1NwuMeo/zSO6sxXI1
	MAkftBHbgwA3nUxh2bs88Ur4e/jcH+hHc3evS+hsel7AmiPBbPmcRjTvND5X4q/ji1hRwt+uWMpM7
	ThFHA2WduMwXYbq829XqW85hPpuKZ3Cp0opoWIfMvIs7ni2u0J+1LJx+GFQiR2+IjnAmu2U/6Fe0r
	rliQ33+pB+UnsMVIBemr2MrS3RDi0mI09rCssODQ7S3PvpZ2f8HaBHaw71Q0OK5UWluaf+CpCcGPj
	VIgV5gtoozfEcrM5ChzmD/E9XmOntKir5GyNVb5JPH3EfL8gdsyMODSIpdYa8XeDRlEZc2D6pnjwH
	GXiU/EGw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLoV1-0000000AKbW-1xRU;
	Mon, 24 Jun 2024 18:33:07 +0000
Date: Mon, 24 Jun 2024 19:33:07 +0100
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
Message-ID: <Znm74wW3xARhR2qN@casper.infradead.org>
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>

On Mon, Jun 24, 2024 at 05:05:56AM -0700, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 1:49 AM kernel test robot <oliver.sang@intel.com> wrote:
> > kernel test robot noticed "WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof" on:
> >
> > commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pages to be swapped out in a bitmap")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
> is triggered by the new bitmap_zalloc() call in the swapon path. For a
> sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
> under the hood) cannot be used to allocate the bitmap.

Do we need to use a bitmap?

We could place a special entry in the swapcache instead (there's
XA_ZERO_ENTRY already defined, and if we need a different entry that's
not XA_ZERO_ENTRY, there's room for a few hundred more special entries).

