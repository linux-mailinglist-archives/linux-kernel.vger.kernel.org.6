Return-Path: <linux-kernel+bounces-342351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E1988DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 06:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CE5282F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6A19CCE8;
	Sat, 28 Sep 2024 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A/Tb5/cf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCC15A8
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727499069; cv=none; b=uZsazwH4yWAw38PH/E1OmQqSft4KX9pfi15OeBgbI2rYWoWEpG9o1P+TfRTnxX8FmoQuNYAq94TCUqoN8dzlyYesgXBmH/W+tfly0KVmoR00msi3/Df1xyzoa5xQyHgulazZi0/rOwUQHgrybq6b1IZj8sWtEejhgelkl9H3eM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727499069; c=relaxed/simple;
	bh=WR2AuSiiBSTPeDaYv2VjsZ5GAMmUorRYiW3/BvalMeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRpgOF4VwmAPcgo73F0fEguqFiC7YanbLBMwUv/VokpUIUfY7RpqcXdbBcisuX0aaJgfsp/sELMyPVcgT+86YkZLMI+JHDMx6lIBQQm1lRqcByLxAUCiIet8FHglaNqKHWHtH5um3r7Ebmls59ohkiUgF2FXvdqqQ3SgHHethUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A/Tb5/cf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SWosS3jl6trCdAKJuZfWE5QOA2qArqoNUePynF1px8o=; b=A/Tb5/cfs5SOYAcs9otvzgfLQL
	jQXxisSnET+Vb4GFBlp5AU7bKcuy8oKLJ5Dnzo5rD99vVCdrYaAjNCD/LdhOBsyKvpdjnHnjpPklI
	4Bg2+zNB82wnVu8ugEvkfJkC7uCT43JoEdGzuFd6dLD7LKyOVqZ5p7Owc+CZzAXU+2KeE2av6qoTc
	t2e3VALxvDWXTFRJxoDvlbjtaCi/Y02Qf6MpgyOl5gGPDq4GMdxOUrUMuvUD83Vg+daSfNWjo11SN
	vfHvOtwd25vfLlegCwB9GG/gDWR9t7z48DenUtMLBHqhclYZd41WMQiDptPQdRd6o5ND+ifLtgm8M
	JG+IDnrA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1suPQ3-0000000BTN5-23aY;
	Sat, 28 Sep 2024 04:50:59 +0000
Date: Sat, 28 Sep 2024 05:50:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev,
	usamaarif642@gmail.com, shakeel.butt@linux.dev,
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
	akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be
 atomic_long_t.
Message-ID: <ZveLM6EINpVWwJZD@casper.infradead.org>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
 <CAJD7tka0qyRWhgHrC9p1ytfDKVPr9bBTFCYy7HC4DZ-Ovfu7VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka0qyRWhgHrC9p1ytfDKVPr9bBTFCYy7HC4DZ-Ovfu7VQ@mail.gmail.com>

On Fri, Sep 27, 2024 at 07:57:49PM -0700, Yosry Ahmed wrote:
> On Fri, Sep 27, 2024 at 7:16 PM Kanchana P Sridhar
> <kanchana.p.sridhar@intel.com> wrote:
> >
> > For zswap_store() to support large folios, we need to be able to do
> > a batch update of zswap_stored_pages upon successful store of all pages
> > in the folio. For this, we need to add folio_nr_pages(), which returns
> > a long, to zswap_stored_pages.
> 
> Do we really need this? A lot of places in the kernel assign the
> result of folio_nr_pages() to an int (thp_nr_pages(),
> split_huge_pages_all(), etc). I don't think we need to worry about
> folio_nr_pages() exceeding INT_MAX for a while.

You'd be surprised.  Let's assume we add support for PUD-sized pages
(personally I think this is too large to make sense, but some people can't
be told).  On arm64, we can have a 64kB page size, so that's 13 bits per
level for a total of 2^26 pages per PUD.  That feels uncomfortable close
to 2^32 to me.

Anywhere you've found that's using an int to store folio_nr_pages() is
somewhere we should probably switch to long.  And this, btw, is why I've
moved from using an int to store folio_size() to using size_t.  A PMD is
already 512MB (with a 64KB page size), and so a PUD will be 4TB.

thp_nr_pages() is not a good example.  I'll be happy when we kill it;
we're actually almost there.

