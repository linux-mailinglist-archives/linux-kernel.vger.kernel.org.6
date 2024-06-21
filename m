Return-Path: <linux-kernel+bounces-225175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D0912D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E493B1C22DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB156179202;
	Fri, 21 Jun 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="exm+5gBM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0C156227
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993642; cv=none; b=Ze2LOiZbpO9cSYFQgDx10U7N/QB9DJByPSNFAQd2S0JtPXfEVrRZUnfUq+9+RnjkqSUYerZfq7FGrEM+2oOEJc9leFIhek9ZLiGRncN5qv7ZjjgkDKXp0GR+xUD/2UUll0+HgVRyYRv8RYYSRM8RH7fbFrEwQhOihNQTKvkwuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993642; c=relaxed/simple;
	bh=TTsj2YNoQ6/dtVSKs4TxAaXgrBdBy/eSZcbDthrumo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNnKnCjOeUPDNoBFk8RgQL9YILJJBFc0J6ugKVULOS04gWG3UhiiUuLPRRwcUH8u4++1ad4eicWCHco79jR8gFFMews8+5adei9bXBNiNdBiVlEDEChbL2gAlt7roYg12JX7cNsNI53eUb/86KJDxHZnNGURK2uWVLChNdOAyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=exm+5gBM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8CaEQPz8O8rxqBnGpTbHDs7svMvy0Qf5Sggnc6KPEyQ=; b=exm+5gBM0vKdyiPkc7w8hOqrjj
	EJeERKQpbiqJrHqYCBN/yoUl9zH4e+9TFixngqwpq8dNe0itUlJM306cfIbQJUCyhwsQRWeLwRqG0
	jTRg+tTnsG3555RsrQ7boEfhZgsL11xqGJlTfGQKrmAIEAOR2GaNFel8dxH44xyV8Y6PxQ8zrmWnm
	wUfzLN1lQroylfu0JiBm0SaUTYnEPzmXtREvm3ZpHekToDBrwBdtd6NZQW5fT3SDCg0z8bhOdctIb
	CY1HRGUfQ9W9Kvr6zDlmGvqThfIN3V389zOUdukmSwKds3EPkOQpdMMfRq5r5cPnQzuKwAGNGIvtd
	Eky3gdAA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKilq-00000007T4K-03r0;
	Fri, 21 Jun 2024 18:13:58 +0000
Date: Fri, 21 Jun 2024 19:13:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
	anna-maria@linutronix.de, tglx@linutronix.de
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Message-ID: <ZnXC5Xa4R0Mp7FCB@casper.infradead.org>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>

On Fri, Jun 21, 2024 at 01:16:04PM +0200, Shivamurthy Shastri wrote:
> A W=1 build with -Wenum-enum-conversion enabled, results in the
> following build warning due to an arithmetic operation between different
> enumeration types 'enum node_stat_item' and 'enum lru_list':

OK, but why do we want -Wenum-enum-conversion enabled?  The code looks
perfectly fine before, and now it looks ugly.  What bugs does this
warning catch?

>  static inline const char *lru_list_name(enum lru_list lru)
>  {
> -	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> +	return node_stat_name(NR_LRU_BASE + (enum node_stat_item)lru) + 3; // skip "nr_"
>  }

and honestly, I'd convert it to an int instead of enum node_stat_item.
Because it is not a node_stat_item, and it wouldn't make sense to
add two node_stat_items together.  Just like it doesn't make sense to
add two pointers together (but it does make sense to add an integer to a
pointer).

