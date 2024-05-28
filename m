Return-Path: <linux-kernel+bounces-193200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C18D2834
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC07F1F254FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74113E057;
	Tue, 28 May 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hL2s/v1t"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714F17E8F3
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936483; cv=none; b=NSexVuaTB/19CPxmLW37Fv3kjWzvkddmUstqQLHKVoBJuSuTz/Zu5VJnqfKkX4vJgkH6VhBQlGpuZSjXCkBpYZ1m73j1ZZZqnSK2Fn/NrgnSldkyjYTj1mrJ/XzevxB9bo6zwZuDHNVaEDBjxOjZsKF84OzIg/62e/+sF9GLg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936483; c=relaxed/simple;
	bh=axSEsC+gneSz5MfgJHsNfBxzzcGCPFR2XD6onipT1Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUkH8pk9zCVw/Gn/ucs9V8AkYh+oui973KBG/eZh3b5c2vO3lYMKMtbN0QAROzU15vbRU4SqE4+hldbPkMHHgq+3hCYnYoRhXc3sarO8xVjcNF81ZBvFOG/7jgWvsjacfsHX+01sBV4wNIoL5m/6CBj4fmn9eJZOhT3phyYUd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hL2s/v1t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Arg3zNJfo7OaVad4zVHjBNkJznEpcaVhGh3Yi10lCXA=; b=hL2s/v1tfAtUEo1XUaMmMp9B5B
	+CWhw1le8tj+XzUWpvv95xY8vyT0m7liz182rkXpnU2U38ulXRMmxaCQVc0roZn1GFBZfmG+A3qlg
	NuKYpuWn3MoYpjoUdfpXpZnVHNs/MJYz7m3h6+PAPjg8kzCxbLkILxrpy4xjLjwiQn8RA52L+Y683
	g4BrnNv5hpAZ2esQhL7jEhcjiYTRlW+NmGXyIgItfuEuTo8usymFyeCLK9xBRBuYcB+r4IIE7Wmp8
	kZXmE3HAKkfwg4ocJkKw5LmVfZyDpEq5JVUGlLnVrjveP0VXCnC3eK3C6CBJyz8rMgTqgSBY1HJRM
	U9M4KUCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC5bo-000000099bN-22l4;
	Tue, 28 May 2024 22:47:56 +0000
Date: Tue, 28 May 2024 23:47:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, vishal.moola@oracle.com,
	muchun.song@linux.dev, david@redhat.com, osalvador@suse.de
Subject: Re: [PATCH] mm/hugetlb: mm/memory_hotplug: use a folio in
 scan_movable_pages()
Message-ID: <ZlZfHNkWHxtpcXhO@casper.infradead.org>
References: <20240528220321.144535-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528220321.144535-1-sidhartha.kumar@oracle.com>

On Tue, May 28, 2024 at 03:03:21PM -0700, Sidhartha Kumar wrote:
> @@ -1761,9 +1762,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>  		 * cases false positives and negatives are possible.  Calling
>  		 * code must deal with these scenarios.
>  		 */
> -		if (HPageMigratable(head))
> +		if (folio_test_hugetlb_migratable(folio))
>  			goto found;
> -		skip = compound_nr(head) - (pfn - page_to_pfn(head));
> +		skip = folio_nr_pages(folio) - folio_page_idx(folio, page);
>  		pfn += skip - 1;

Isn't this an unnecessarily complicated way of writing:

		pfn |= folio_nr_pages(folio) - 1;
?

