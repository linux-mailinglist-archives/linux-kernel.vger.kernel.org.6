Return-Path: <linux-kernel+bounces-202041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED238FC709
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B24E1F21333
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722E18C324;
	Wed,  5 Jun 2024 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WWowJ2OJ"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2091946A0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577730; cv=none; b=XRfUw6bpYj5c2RAc1J9mniTtJSOKFrNc9WKBWcH6DzlKyelTLhwT+z0e7J6IMb9gLNMohAfenvVeHQT3swn72KAQFhefOfZoqby9msD7gQw7I35LCFgqv4ThiPFWzypPWbhVDS8iST9RLrwFCsBbxg5YNcuIk3ynbLV5a/Pyw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577730; c=relaxed/simple;
	bh=lQ5AUNN0CW1W7erE1/RLb+6Gz+kZYCiIUB73oejVdds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx+fNaie01D7fHByrReREtE3htWnStlm42PcLoyB5qphO4+Tswt5SkrDfrtbjF7GgAEGjF8GFZUfYSTzryhNcuHHWHApBV6j71k9oAkFah9c1Hg9yFvu6x4TGjphl5Wzj2NTYc90zdpwbg07tBd7IyeHhaZVyMX1a+Y+BySGwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WWowJ2OJ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: usamaarif642@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717577725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4mCPcq6Gp0ug8l4Qe9KHcC8Y+s6DU5bqT1iov4dcRI=;
	b=WWowJ2OJCy5MK9lP1nsuFyx6zyS+SlOXc5ZQzy1lnLyYBmq1BtVu7GpMLPW5m51VT6uO2z
	4xqk0FM5FsMAHbRgFQqZZnLy2MQ4L2JID9KRaYN+s8SLtJ2p6T+xx6uWlelNqBTaqlxCIc
	GqjPD9OEwrUw8qS3zlhPmLl8v8oRP+A=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@meta.com
Date: Wed, 5 Jun 2024 01:55:17 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org, 
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm: clear pte for folios that are zero filled
Message-ID: <nes73bwc5p6yhwt5tw3upxcqrn5kenn6lvqb6exrf4yppmz6jx@ywhuevpkxlvh>
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
 <20240604105950.1134192-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604105950.1134192-2-usamaarif642@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 04, 2024 at 11:58:24AM GMT, Usama Arif wrote:
[...]
>  
> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> +{
> +	unsigned long *data;
> +	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
> +	bool ret = false;
> +
> +	data = kmap_local_folio(folio, i * PAGE_SIZE);
> +
> +	if (data[last_pos])
> +		goto out;
> +

Use memchr_inv() instead of the following.

> +	for (pos = 0; pos < last_pos; pos++) {
> +		if (data[pos])
> +			goto out;
> +	}
> +	ret = true;
> +out:
> +	kunmap_local(data);
> +	return ret;
> +}
> +
[...]
> +
>  /*
>   * shrink_folio_list() returns the number of reclaimed pages
>   */
> @@ -1053,6 +1085,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		enum folio_references references = FOLIOREF_RECLAIM;
>  		bool dirty, writeback;
>  		unsigned int nr_pages;
> +		bool folio_zero_filled = false;
>  
>  		cond_resched();
>  
> @@ -1270,6 +1303,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			nr_pages = 1;
>  		}
>  
> +		folio_zero_filled = is_folio_zero_filled(folio);

You need to check for zeroes after the unmap below otherwise you may
lost data. So you need to do two rmap walks. Most probably the first one
would be the standard one (inserting swap entry in the ptes) but the
second one would be different where swap entries should be replaced by
the zeropage. Also at the end you need to make sure to release all the
swap resources associated with the given page/folio.

>  		/*
>  		 * The folio is mapped into the page tables of one or more
>  		 * processes. Try to unmap it here.
> @@ -1295,6 +1329,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
>  				flags |= TTU_SYNC;
>  
> +			if (folio_zero_filled)
> +				flags |= TTU_ZERO_FOLIO;
> +
>  			try_to_unmap(folio, flags);
>  			if (folio_mapped(folio)) {
>  				stat->nr_unmap_fail += nr_pages;

