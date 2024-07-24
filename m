Return-Path: <linux-kernel+bounces-261520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301693B838
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1869F284C81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4D13A40D;
	Wed, 24 Jul 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SPaJElmV"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E4139588
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854165; cv=none; b=oSykWp45x66R2AGGJSZwhImZ/aEm+LmlOnTVrvQpMZGQbNG1G1zQDVKy38FKJCgB7NeCBwk6v/P2IdT97kNAgx1C84vzIhjmkyPvKycE4qxS+ZLd3hfA6q12da8bdbZKYee9Bgo6w10w5FUFlV9uzQseDh+hnFGmjeWIgcAsriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854165; c=relaxed/simple;
	bh=0fu/E/bK1dMoj/WG7Bp2Ge25Eq9UliNn4nTlkf6+pR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjKDdtHbdDCda0xLDXshBVvDgco39TKK+BlASSnI3pe2HrCAOCituhUfQtbPTnbdodg3spoLK8ZfQCwRKvgCkN3AWx4ZXmU3eu7izP/1DibprsHKRWxNM28ZbHzbcQ11XbDy7+6iH6GQwc/49FHsyJr49wXg7TBNkPSSladIOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SPaJElmV; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 13:49:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721854160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAZfW6WxQIv+gWdwjAk4kAvT95Ddr/FprFcNMRbuDgI=;
	b=SPaJElmVWRpaglApV1kMYQu9p73SR83bBRwdiQ2mF1BsCLAZ4rISWOIPbMkxCYSSL5iw36
	iTs/UrFFk/ifZjN/k5HWUJfjRCE6htbwHXaaW8ZPWtO3JOs94RSOM3gQX5rc0DODWK13ef
	Ydz9RdAE4Q1iuPi87LqTVmvFOWGfAKo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 2/3] vmstat: Kernel stack usage histogram
Message-ID: <mpbxc7boje4aun4pzfoipz2hwaeq75rg3kl2epdpenq5hhomyn@6uj6brlaujwc>
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
 <20240724203322.2765486-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724203322.2765486-3-pasha.tatashin@soleen.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 08:33:21PM GMT, Pasha Tatashin wrote:
> As part of the dynamic kernel stack project, we need to know the amount
> of data that can be saved by reducing the default kernel stack size [1].
> 
> Provide a kernel stack usage histogram to aid in optimizing kernel stack
> sizes and minimizing memory waste in large-scale environments. The
> histogram divides stack usage into power-of-two buckets and reports the
> results in /proc/vmstat. This information is especially valuable in
> environments with millions of machines, where even small optimizations
> can have a significant impact.
> 
> The histogram data is presented in /proc/vmstat with entries like
> "kstack_1k", "kstack_2k", and so on, indicating the number of threads
> that exited with stack usage falling within each respective bucket.
> 
> Example outputs:
> Intel:
> $ grep kstack /proc/vmstat
> kstack_1k 3
> kstack_2k 188
> kstack_4k 11391
> kstack_8k 243
> kstack_16k 0
> 
> ARM with 64K page_size:
> $ grep kstack /proc/vmstat
> kstack_1k 1
> kstack_2k 340
> kstack_4k 25212
> kstack_8k 1659
> kstack_16k 0
> kstack_32k 0
> kstack_64k 0
> 
> Note: once the dynamic kernel stack is implemented it will depend on the
> implementation the usability of this feature: On hardware that supports
> faults on kernel stacks, we will have other metrics that show the total
> number of pages allocated for stacks. On hardware where faults are not
> supported, we will most likely have some optimization where only some
> threads are extended, and for those, these metrics will still be very
> useful.
> 
> [1] https://lwn.net/Articles/974367
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

