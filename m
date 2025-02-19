Return-Path: <linux-kernel+bounces-522457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C3A3CA97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14A616C708
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA921B9C5;
	Wed, 19 Feb 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LVULq6oP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84121516A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998665; cv=none; b=tJRvYrvQZiakjH1SsokSHjbdgUN2AW/ThyT5XDNap8/XtWE0lHTgSHn8uypKcXhjQWmXFbzcMBcWUKJ0kGt2JZmOyvgP+p5KXEwcvp67f5NzfdxLHL+nOrrJyjwpI/H5eXPDrYmc+7hgGJE7PObhOxUS+mE14Iuf/XRC04F2fxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998665; c=relaxed/simple;
	bh=hKJ8Hjb2YjJG6xMLzZjpgVeKjJRPKbszhNIn4r9AUWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr6pfuoWnUrr47S9bK4ApHraZn9bzjzXybv4HO2wEHKlAh8TSFSNblceTF/Eof8Y974yHoIWgoc0Hi+31lKFq2mrv9CK5hrcMROMihVMQwi4pwfeHDT4KjXIu5hMM60qUDMsvaqBwLTlvkaspOD8C0a51jJ1xqjowbFvQdKNSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LVULq6oP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f94VpCiIl8a2I0qDr+LujsMvrVHieoe1sVcOcgeYMTE=; b=LVULq6oP2UzHNWOGK9KNudBmFg
	06TwrTMhQne+4T3RQ/fRXzrSLkzdane8eDpIPFLP1e7PSPGlh/BapVTlQMh/76TjEx2XcxVbVV5qY
	FEL3UFwAPkUfyh2XDgyHcM9vlxtvEpq92E41pyUWonGxU+OTuLRxgCrsrFrYA2Lc0OCW9RcHLemeD
	TzmW6gLpNYs1uJOIhFV5d7jmmMNG+A34KPBMTwUz8CT7JfSWgqKlq8SGljwBMF0+U9YdUtqYsDkaG
	jzTJ7CLcRy1w5XvtajVKtD77c9LbTmaXuUvVS4q2fNydYmGvhVqo9oXr6BkD4+N1o6ozTImz9pbPC
	Sjobfsww==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkr8T-00000007BID-1vcw;
	Wed, 19 Feb 2025 20:57:37 +0000
Date: Wed, 19 Feb 2025 20:57:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Peter Xu <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>, ZhangPeng <zhangpeng362@huawei.com>,
	Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z7ZFwff-8StHCzWl@casper.infradead.org>
References: <20250219112519.92853-1-21cnbao@gmail.com>
 <CAJuCfpEWFz14R1vD4Rezy98WBk25HWWX+6DsGBekeYMugKTsfQ@mail.gmail.com>
 <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yx1=jaQmDG_9rMqHFFkoXqMJw941eYvtby28OqDq+S7g@mail.gmail.com>

On Thu, Feb 20, 2025 at 09:37:50AM +1300, Barry Song wrote:
> > How complex would that be? Is it a matter of adding
> > folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
> > folio->index = linear_page_index like in move_present_pte() or
> > something more?
> 
> My main concern is still with large folios that require a split_folio()
> during move_pages(), as the entire folio shares the same index and
> anon_vma. However, userfaultfd_move() moves pages individually,
> making a split necessary.
> 
> However, in split_huge_page_to_list_to_order(), there is a:
> 
>         if (folio_test_writeback(folio))
>                 return -EBUSY;
> 
> This is likely true for swapcache, right?

I don't see why?  When they get moved to the swap cache, yes, they're
immediately written back, but after being swapped back in, they stay in
the swap cache, so they don't have to be moved back to the swap cache.
Right?


