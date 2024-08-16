Return-Path: <linux-kernel+bounces-290327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D17955244
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E3EB21DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F151BF324;
	Fri, 16 Aug 2024 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QOtK3PIl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACFB7DA64
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843040; cv=none; b=YKpDXPBcOL3nXBRTkucFhd4HiWwT13pUvBYYfA9l+WyX2eeEjvxrhxVMsRFlSx16yNloZU4kTMDqcyId1fzM+W3TTPzCf8xwiFznD5VTsJK3IOasOcxrF4qBkqsemiZPUmU7+XKjGF72ozJUK+zwWKrUD1946H6qpIAQ9bS0YE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843040; c=relaxed/simple;
	bh=ihnBIC5Mr4Db4zQ3ByiKI5jmHpPgw59NIhVTY7lBHs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOJFYK0vo9SsybnUIoqKlIarLdYhunDqKvRRRWukls5eA5wzLVVV4gsj1FTZ9ael5+6l97bhWIUqESF6tKAAQxHlhqJDdEIoLWAgI5QSN3rVbkn+muLViUbN3UFUSdHhZaCai9w2QrTwI0dGmuSIXoJ+Nog7SdnLg9fZR1bWisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QOtK3PIl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rS71YMLfit1EALalhCPrRhHSkDiUzIHUeAnRBQ5Q7xY=; b=QOtK3PIl6AMduVJvAJEly2uwQo
	yUACaryvdl15PuzQkXkyHUBTKUjQbhdAbiS+x0mccotcDPs8BcUu5jS/Mf/5IYTqGE1cby6DgT5kL
	5lRkT9ziMptjwEwRSId95vobvlBM4nj54bxmTm7vJiAK4mxv2GTCsE44p8WyKH2YFw5qU5qqIiBlY
	YCW6CUnIyeSYAUg6CxYWd52T88OQKCc+MA8/2d5hWQl6Hn2sXixBW42jO9pBODYNL7/uuO4xdRv5G
	RrM7cLsfbhiXh/yWV5C8WCGGJYFp6aBJEgfzdQ3pr68Kkd1sQ2eOO34oJnwAyq2tRN1bhtsJOrMvZ
	0SUolidw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sf4Jd-000000047E2-3hIW;
	Fri, 16 Aug 2024 21:16:57 +0000
Date: Fri, 16 Aug 2024 22:16:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: wangkefeng.wang@huawei.com, akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hch@infradead.org,
	hughd@google.com, kaleshsingh@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	ryncsn@gmail.com, senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like
 devices
Message-ID: <Zr_BydCiQInI0ZMz@casper.infradead.org>
References: <20ed69ad-5dad-446b-9f01-86ad8b1c67fa@huawei.com>
 <20240815230612.77266-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815230612.77266-1-21cnbao@gmail.com>

On Fri, Aug 16, 2024 at 11:06:12AM +1200, Barry Song wrote:
> When memcg approaches its limit, charging mTHP becomes difficult.
> At this point, when the charge fails, we fallback to the next order
> to avoid repeatedly retrying larger orders.

Why do you always find the ugliest possible solution to a problem?

> @@ -4244,7 +4248,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				}
>  				need_clear_cache = true;
>  
> -				if (mem_cgroup_swapin_charge_folio(folio,
> +				if (nr_pages == 1 && mem_cgroup_swapin_charge_folio(folio,
>  							vma->vm_mm, GFP_KERNEL,
>  							entry)) {
>  					ret = VM_FAULT_OOM;

Just make alloc_swap_folio() always charge the folio, even for order-0.

And you'll have to uncharge it in the swapcache_prepare() failure case.

