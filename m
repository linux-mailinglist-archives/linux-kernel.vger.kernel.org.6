Return-Path: <linux-kernel+bounces-184323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF98CA56B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832F01C21008
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC526FDC;
	Tue, 21 May 2024 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R+Lj7Z7v"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610E8C13
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716252033; cv=none; b=pGl1nRQjuANlpVS8FbTXrWuzCiYePUIQTUH6jRg4XabE4JCvJ8zdVCswA4J/Om13vYap40j85VrMCz5dL4veUdD58W9R3DMVBf8NjiWKf2aeIHJJTRdMyiKIkvfOmUyvE9NvHXCJhlmckJVE4HsUXvPEUuky3phVA79gkIf5UqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716252033; c=relaxed/simple;
	bh=hMXl4GGJLrT92Xq0c93dhj+xTGmnztuMmWI3Q9ymWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyGmBytAn1r1sRUcnG+Mwo1tG9GhuvI4DP/47YB8BMeIv5fp0D4BgGxBQZL8vIO2M3r7rvc0qwFkrl/G2VrcxU/H0VmQseQVdNqCDlOnl9pzzGI2uEfA8covHCPi5awp4G/yKM7uOvfByZQBw9j6lS9xBschwhCUG5nTMSl4N6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R+Lj7Z7v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fhJpPLfuGesh5xjpS2ooud1QHAhQN17zzkTpX05wogo=; b=R+Lj7Z7v6/FN80b12xRt8G1B6L
	grttWoFFRn8nll+Zj0fbeGOQ4UpJxel0aNToiDuunEGDZG7KGSC8MdkyBiTmeB648GIBRUHaatq9H
	Fq1S7lbcKQL4q2zOI+ZwAJ0C8WjfVw0XrH9QTukhaHlPc5Q3Kiep8xKakIzbj0d7g2MFXC/K0vvno
	2VRQl7bYA9h4mr40KSKSFixezJ9Rbiu1Pew8y+yTqHLbdlZvwxH1mZOPP3nU/gTW6dia/ASyV9ru2
	JgVF8tDPZhETsFexqFumDANwDt6zPYpx1/mj/gH1IjWiR/Y7xoRLS5D9gRPjglYtOxhzeM0gPv2qG
	9wmt/kGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9DYI-0000000GXPM-3aa3;
	Tue, 21 May 2024 00:40:26 +0000
Date: Tue, 21 May 2024 01:40:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, vishal.moola@oracle.com,
	muchun.song@linux.dev, peterx@redhat.com, osalvador@suse.de
Subject: Re: [PATCH] mm/hugetlb: remove {Set,Clear}Hpage macros
Message-ID: <ZkvteqofTbUK2XAu@casper.infradead.org>
References: <20240520224407.110062-1-sidhartha.kumar@oracle.com>
 <ZkvdAGyua4daHg_S@casper.infradead.org>
 <26e49614-ddb5-4d4c-97c1-a3a8c06d5bb5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e49614-ddb5-4d4c-97c1-a3a8c06d5bb5@oracle.com>

On Mon, May 20, 2024 at 04:44:53PM -0700, Sidhartha Kumar wrote:
> On 5/20/24 4:30 PM, Matthew Wilcox wrote:
> > On Mon, May 20, 2024 at 03:44:07PM -0700, Sidhartha Kumar wrote:
> > > All users have been converted to use the folio version of these macros,
> > > we can safely remove the page based interface.
> > 
> > Yay!
> > 
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> There is only one remaining user of page-based Test version of these macros.
> 
> in mm/memory-hotplug.c:
> 
> 		if (!PageHuge(page))
> 			continue;
> 		head = compound_head(page);
> 		/*
> 		 * This test is racy as we hold no reference or lock.  The
> 		 * hugetlb page could have been free'ed and head is no longer
> 		 * a hugetlb page before the following check.  In such unlikely
> 		 * cases false positives and negatives are possible.  Calling
> 		 * code must deal with these scenarios.
> 		 */
> 		if (HPageMigratable(head))
> 			goto found;
> 		skip = compound_nr(head) - (pfn - page_to_pfn(head));
> 
> 
> I've previously sent a patch to convert this to folios[1] but got feedback
> that it was unsafe. But I'm not sure why replacing compound_head() with
> page_folio() and using folio_test_hugetlb_migratable(folio) rather than
> HPageMigratable(head) changes the existing behavior. With no reference or
> lock, can't the head pointer also be moved and no longer be a part of page
> like the comment states. So would the folio conversion just be maintaining
> this level of existing un-safety that the calling code should handle
> anyways?

To be fair, that wasn't the last thing I said about that ...

https://lore.kernel.org/lkml/Y89DK23hYiLtgGNk@casper.infradead.org/

and looked like David agreed that this was a case where false
postive/negative was fine; we were just looking to be right most of
the time.

