Return-Path: <linux-kernel+bounces-198577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834B8D7A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C281C209D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1205101F4;
	Mon,  3 Jun 2024 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a1zXJSxO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB09631
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717385818; cv=none; b=pWXsMT7lrGTwcwPqybYJbuU9/U8leM71kuOnHOR1XjX+tLxRXtOiDfVLxwjAs2QOYLY8R9A07O2efrF+WJFvvwhuW78z873ESXDNv10NbhiJfsY8ozv+DIL30EFkVrq7w6OoM2PNqXkCXQavGCnICv8SZJSyRkbmX1T6zQ+5WIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717385818; c=relaxed/simple;
	bh=Lbtr77jWigHqruPwEIWG2BUQE9zwD+1PlKO6vXIoWlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKYpqLnsaObptGFae+X/gdrho0A2LjEIzrgHRIqM9FxcpQkn5srhEhAathrXm+5bbt7PuumLR46euQztzLhiBCDaIGVKXQWjrTQVjc3Uyl7DC3wjEfaabiG8CX1bJhV7AwjY73IqPS+l1BBuOu7tMskgHlcE9ZmeXSr+ghusP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a1zXJSxO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ECUDepRIy736K/Vh5Dkt+vDYxIgaP6kH7QsAiqgBifw=; b=a1zXJSxO3qG+nRJGpA7LRxR5zK
	qe+abRm9vlX5iWt4hlIWQLhGWtfj24qy5r71KtqOy8VEbF8TIpU5jt351JPj37z5Z8jYwvOXWJR8A
	olP6+mus0VFz9kRXAaqDWWBfwtFt6qK+3bepnKgWdzCvV3gLPN8DpmMg4pdTEwGgIgbELYyGPp90w
	KbyCWaEPUjm3X0Vj0VP4+qgyMrjYlIO1NChDmb4IujUMP98TMl3tEaDUjGG63dGto6VmDMh43zF2N
	DGiB0t3XS5/HGylnEFUbgN6aeIFrUteuleOexHdleKJqYfwJNIYRvWaBBG5ZJEAt59Pu0Onud/Rxz
	eUR7ImpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDyUq-0000000DoO2-0Bih;
	Mon, 03 Jun 2024 03:36:32 +0000
Date: Mon, 3 Jun 2024 04:36:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
	21cnbao@gmail.com, baolin.wang@linux.alibaba.com, ziy@nvidia.com,
	fengwei.yin@intel.com, ying.huang@intel.com, libang.li@antgroup.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/mlock: implement folio_mlock_step() using
 folio_pte_batch()
Message-ID: <Zl06P-qdpca2V9aJ@casper.infradead.org>
References: <20240603033118.76457-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603033118.76457-1-ioworker0@gmail.com>

On Mon, Jun 03, 2024 at 11:31:17AM +0800, Lance Yang wrote:
>  {
> -	unsigned int count, i, nr = folio_nr_pages(folio);
> -	unsigned long pfn = folio_pfn(folio);
> -	pte_t ptent = ptep_get(pte);

Please don't move type declarations later in the function.  Just because
you can doesn't mean you should.

> -	if (!folio_test_large(folio))
> +	if (likely(!folio_test_large(folio)))
>  		return 1;

How likely is this now?  How likely will it be in two years time?
Does this actually make any difference in either code generation or
performance?


