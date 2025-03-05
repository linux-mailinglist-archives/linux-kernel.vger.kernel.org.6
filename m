Return-Path: <linux-kernel+bounces-547536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02486A50A8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBAC17319D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F5253333;
	Wed,  5 Mar 2025 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LH6d/at1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1322512EB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201006; cv=none; b=YU+AW4zjjKf1iMXv1fhHASyklL9odBMAsoNMu1Tsezr0NGttZWidVZAhtqSVzmP8rS5IzFSwdwKPVo0m4jQaVRkdOb8pOokZC+eiF68vpqZkI9hCFAKlJNV7bDdvTxVW4mtt7zyiRLxWZnXh5jXGiUyBGAdIkgUMeTofOkrPL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201006; c=relaxed/simple;
	bh=weoLDQd0UNq+h4CWeAknLOxFPT6f8yJeliG5klaJWpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1fAPy2os2SVdBbhjf7sxZXu34g+CzninxrbHEM/scYV+hOHI1c5JKKAehWxKMiBT6Z6eeSkNQyLR7uL4dp+Uy1+vl9F/DXWGVXnPYJXPA4kdGmK+3L8dsD/H0WFBOVtDNznMgAkvU1cgS1js7VpABV895BC+bNEqbASSu25vs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LH6d/at1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gEej6CXH1CV2BnQ31fBeizuHauDDNf4vDJ4qs+EfxyE=; b=LH6d/at14InSRczwufVCXusV4q
	d+qqSKX36ZVtMaIT3LEUnT+jG5rNrf0j/KV2NJ4cXwVfEkU2ZAk8+hKkB7XPW2B4vnDkoxWe3xfIw
	sLPShUF1nV4mLXwgxAHVwpdH4ZP76J79AQV8JAJp2v455uDl8oG0+lA/DtfRHz+k6fCFfDblp/JYa
	2EzRfACb2rxCkPdZon4UEywvAoEfHa1QnHLji4zlt6X/vH+/DlEE2Xmgj2/oIlT9KoxMWq86xAuwS
	OJ4Hj5cv9Y2CLQnIrArcH453ZYy2jVUoW9PepF73Q5N0AHRjRdPE2lPFVXUWhkeQzHgat2Szo3RV/
	1qfwHRmA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tptv4-000000062iY-0DXZ;
	Wed, 05 Mar 2025 18:56:38 +0000
Date: Wed, 5 Mar 2025 18:56:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for
 MADV_DONTNEED and MADV_FREE
Message-ID: <Z8ieZVFEa6vAouvu@casper.infradead.org>
References: <20250305181611.54484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>

On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> can happen for each vma of the given address ranges.  Because such tlb
> flushes are for address ranges of same process, doing those in a batch
> is more efficient while still being safe.  Modify madvise() and
> process_madvise() entry level code path to do such batched tlb flushes,
> while the internal unmap logics do only gathering of the tlb entries to
> flush.

Do real applications actually do madvise requests that span multiple
VMAs?  It just seems weird to me.  Like, each vma comes from a separate
call to mmap [1], so why would it make sense for an application to
call madvise() across a VMA boundary?

[1] Yes, I know we sometimes merge and/or split VMAs

