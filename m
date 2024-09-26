Return-Path: <linux-kernel+bounces-340436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75950987364
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E701B26A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6281B175D29;
	Thu, 26 Sep 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VvkAnkYF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1914E2CF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353009; cv=none; b=QAIffmtF3q47zkvD1l3mpLytzviV1Or0iq8RNklTkXAOFIGXiI4JfEP2hJ3f3bQrwjgXzhKLHrk3Er4YpCl3PDgcdk1xyLT+AwtX29ycoq46SrPg2FG+omRoPePf91vpVVPNi9rOMMMuRQQ1PlMmBYM26KlCMhxaKnWmKGSp0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353009; c=relaxed/simple;
	bh=BICPlQSWSF9H1rR//NarsKMWfMLqkeUN5ozPx2vNYPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5aaJcLPGRxbY53H7Xpefmf7sw39ZRw0GtIDxm2MNOgPhbaCniHu8OzvV680xS9DCKEF1xoKHI5qO5rpoHjF3v3x1pH4uZ+5/XQwEf3vOuCiRjghty1xtDV8lSmAHjotIvAw6Hu2Ip3u1CTsv7Ohj+epWJG9Gt1mHbxC1gBOPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VvkAnkYF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3JXNnfCuu1FGFtKqoh7Vb8SASSIWNgmcdOP5HIJ3eY8=; b=VvkAnkYFethV6nNbSDLPYYVpx8
	1AY0iZNwy7XaY3WK3e+EQps9A3CbSfTitVOqnPsYqkVm9MzNAh9Zo21t9TjXBNSfxBCPr1AK97HcR
	3BWDTzI1UuDeSdYSR2bw/i0Nxu6vJIYDJGyCgqB/m+H2B75Anjc9Xs8kXIrKx0OIgkns85AM4tJAk
	2FfiOuwqjoPl9N9dNREJjzB78tLKG4qCmmo/iAZDBHuVpv/tFXm6aUkuqog909ESWColhkiScCMzQ
	NsQA1BANqYJTA+DC6+KIBOT15z6h6gfH7qdAbCaMDG3iIXdj2P4foV6IqjS67Xg/FA9x1P8LWnuUx
	/zzqCgWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stnQ9-00000006aqg-1qAG;
	Thu, 26 Sep 2024 12:16:33 +0000
Date: Thu, 26 Sep 2024 13:16:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
	ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] mm: shmem: add large folio support to the
 write and fallocate paths
Message-ID: <ZvVQoY8Tn_BNc79T@casper.infradead.org>
References: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
 <c03ec1cb1392332726ab265a3d826fe1c408c7e7.1727338549.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03ec1cb1392332726ab265a3d826fe1c408c7e7.1727338549.git.baolin.wang@linux.alibaba.com>

On Thu, Sep 26, 2024 at 04:27:26PM +0800, Baolin Wang wrote:
> +static inline unsigned int
> +shmem_mapping_size_order(struct address_space *mapping, pgoff_t index, size_t size)
> +{
> +	unsigned int order = get_order(max_t(size_t, size, PAGE_SIZE));

Why introduce the max_t() call here?  Did nobody read the documentation
or implementation for get_order() before writing this patch?

Besides, get_order() is wrong (at least relative to other filesystems).
get_order() rounds up instead of down, so what should we do for a write()
of size 512 * 1024 + 1 byte?  Other filesystems allocate an order-8 folio
plus an order-0 folio.  This code would have us allocate an order-9 folio.
I think that's a bad idea.


