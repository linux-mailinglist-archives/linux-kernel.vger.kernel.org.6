Return-Path: <linux-kernel+bounces-340521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52901987494
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0861D1F2351A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947814503C;
	Thu, 26 Sep 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TjsX2Bcw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413517BD3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358019; cv=none; b=RCA67XbTX27PUopj6hhT7rYR6pnmQ5hOEtDGfU5i077CJ7tsxUoO988wxh67qdXHcPSdrfWqS5QWaXURuAM3SQpMUYWW1yEH+Gq/JpEV81pUPv/IeUF4su4P4vZpoIuncTr+42T8SB0fab1+pk6fLgBVIfeRnY9JSluVOxzT8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358019; c=relaxed/simple;
	bh=wKix4F36LAKU/0XmZkDm7p9mSU7oRAeQs9PfB99udGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8DAN1pBaqpP89s43K5HVWEF2zJdjYLmjFhZsO1T4pE9y2PRyEnr1aSZtGRV0fI/G5OZ2XgH/Urc1HKVaF4GuP6dJajP1OsVgL68WOw1tCCJrp9zSChJ9/gn3kAssRgjJsMIgnR6Eyti7zJ7kIJkgOXHG1RWOt0lG8NhMjNZTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TjsX2Bcw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FxPbI0QvyMKRaRZxxEIytMMMKgGjtJHw/Q/FOqAhZqI=; b=TjsX2BcwwhzvBP7n//axyX50/7
	06KZeafFuQVk3q2JXRrSPzSDMUaC6VCydBytx+jheTbdYUzUOSsX9tMim2mEC70E+CHDMI+uAeH0k
	1pQ1HHlxmXKgzQQu/HkYuLtfJrTAC5O9fNcgW6PvDYsPgf/b3ZIy2tzLZAyrudrnauZykDSjH/FIj
	gPb7v8numy/sexw7C1jaSGeq6HqozTL5Bfr2NUBc9b6rUnr/yvYjrfc5jnmq7GB698/4A0gyN/rNd
	IX6saKYFnnn4Fvi8STePqbv2+IwlXBknKvU0uzf81snpwzoVtSTDgtTAXNA/IGGrDtI/g5DrH+011
	a+Xv70xA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stoix-00000006kkw-1gPv;
	Thu, 26 Sep 2024 13:40:03 +0000
Date: Thu, 26 Sep 2024 14:40:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com, david@redhat.com, wangkefeng.wang@huawei.com,
	21cnbao@gmail.com, ryan.roberts@arm.com, ioworker0@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] mm: shmem: add large folio support to the
 write and fallocate paths
Message-ID: <ZvVkM0VWK5E_MfJH@casper.infradead.org>
References: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
 <c03ec1cb1392332726ab265a3d826fe1c408c7e7.1727338549.git.baolin.wang@linux.alibaba.com>
 <CGME20240926121649eucas1p2aec9398cab6db6fee1251a1a61568857@eucas1p2.samsung.com>
 <ZvVQoY8Tn_BNc79T@casper.infradead.org>
 <18532bd8-08bd-4494-a3af-fe252a803380@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18532bd8-08bd-4494-a3af-fe252a803380@samsung.com>

On Thu, Sep 26, 2024 at 02:58:31PM +0200, Daniel Gomez wrote:
> On 9/26/2024 2:16 PM, Matthew Wilcox wrote:
> > On Thu, Sep 26, 2024 at 04:27:26PM +0800, Baolin Wang wrote:
> > > +static inline unsigned int
> > > +shmem_mapping_size_order(struct address_space *mapping, pgoff_t index, size_t size)
> > > +{
> > > +	unsigned int order = get_order(max_t(size_t, size, PAGE_SIZE));
> > 
> > Why introduce the max_t() call here?  Did nobody read the documentation
> > or implementation for get_order() before writing this patch?
> 
> get_order() result is undefined if the size is 0. I've used max_t() here to
> avoid that case. Perhaps should we prevent that case before getting here?

Surely we've handled a length-0 write before we get here?

> I think one of my earlier attemps was to use fgf_set_order + FGF_GET_ORDER()
> as in iomap. But the solution taken there was to share code between shmem
> and filemap and that wasn't considered a good idea. Shall we just replicate
> iomap_get_folio()? Or else, what do you suggest here?

We could move three of the four lines from fgf_set_order() into a
new function and call it from both fgf_set_order() and shmem?
> 

