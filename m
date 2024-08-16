Return-Path: <linux-kernel+bounces-290201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D09550A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3851F23611
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075721C3F10;
	Fri, 16 Aug 2024 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UnMJYcnr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41211BF32C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832172; cv=none; b=OGmvs2opYfFTZ764vEvWVmhEVKBr09Pbk04Kk8eP/m1jE915moRtN0f4whywIR/ejgpTVkJKVHNrqhXVBIUWFemDa6OlLZXHK0hlopIDKekJsGA5zb0ZNAbOWcmVfGLs+x1ElLbTP/8kTsF75VILxgEvAr0hDAapto3BOzbrvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832172; c=relaxed/simple;
	bh=k4GNUDgq1rdKwWJZPQjg2jXsjDkBJpVO6LjrpxDhD2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlZL+q3/YEaiitTRTcWLqKbQpPZo/PtOCRG2HfMqnlz8qdRbNNgBjlb2oTwCMqf4N5RvmFFc3yc96USh0A3UZiN+XVR+NRJ+Wx8MVi6WbessJFTR9R22r46qTrAlkU4AgCGY/qyvXOJ15JXJ2CCWnnUZWLhpD9kWbd9g9LJ+YMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UnMJYcnr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k4GNUDgq1rdKwWJZPQjg2jXsjDkBJpVO6LjrpxDhD2E=; b=UnMJYcnrEmeNJjC1MJFMZo79Tc
	ITF5CxuT2bnaoEAqV3adHHQp4LoLGcZTA2yNUq2MmjrkEQogqOrPd/B2gDO5zxN0zsygfJKXYDJhc
	TDeWAGtDEg/NSoQS+rJnjQJBWlUyKQIR+HT2nsYp3zTBlW+aVT5cXqKaybsm3D8SlZI1BcyaAg5+O
	0T60VFJ4f+o/jVCYfQwEiksImTBZOdqiPVAhrYcQ+NFjO/Y6W06cxba1WT8TR3QSuqDKgADaQtaMn
	Hxmo7c1rdVEKdUKiEg1emlWZXfkUgiDlDGfI2afKQkKzmy+G6oRYs+lXHhkDYOBP8Oz/HnIJZjstN
	QKOJz7CA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sf1UN-00000003w0J-0rr9;
	Fri, 16 Aug 2024 18:15:51 +0000
Date: Fri, 16 Aug 2024 19:15:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: hughd@google.com, akpm@linux-foundation.org, david@redhat.com,
	ryan.roberts@arm.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, ioworker0@gmail.com,
	peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: control mthp per process/cgroup
Message-ID: <Zr-XVn1ExJ7_LSLS@casper.infradead.org>
References: <20240816091327.54183-1-sunnanyong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816091327.54183-1-sunnanyong@huawei.com>

On Fri, Aug 16, 2024 at 05:13:27PM +0800, Nanyong Sun wrote:
> Now the large folio control interfaces is system wide and tend to be
> default on: file systems use large folio by default if supported,
> mTHP is tend to default enable when boot [1].
> When large folio enabled, some workloads have performance benefit,
> but some may not and some side effects can happen: the memory usage
> may increase, direct reclaim maybe more frequently because of more
> large order allocations, result in cpu usage also increases. We observed
> this on a product environment which run nginx, the pgscan_direct count
> increased a lot than before, can reach to 3000 times per second, and
> disable file large folio can fix this.

Can you share any details of your nginx workload that shows a regression?
The heuristics for allocating large folios are completely untuned, so
having data for a workload which performs better with small folios is
very valuable.

