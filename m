Return-Path: <linux-kernel+bounces-193424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8588D2BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FB72841B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 04:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3366915B125;
	Wed, 29 May 2024 04:39:58 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522013D899
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716957597; cv=none; b=JFwKlYch3EBoJCS/o3kJ8eOVcXp2hjE2odZdm4aIlqm08zeA50BTeW9CdOseiXa53bFnEUWYppOtG2h21dLC2NlhNQ2Zm3Us69zXTKI8lDHvkBWGPfaB9Rp0JV9l3igqnkx743DE2256gKYgO1FKKnsT8y35l0a1EoZQ1akhsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716957597; c=relaxed/simple;
	bh=yymlrI/jYHDZxXM9UsGXUapIfxbptjZZU5nRU2+Il+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nww0nh96Eqd5Ivt0A7m6VtNdOBWKHrP1XhwjyLu4UY5KEIEJFqngvLIJb12dasDywntKx/ggrSTuc6UgoD0+RcSjQHHd/NPV6pyfFv+SAq8T8F1d3llyuhOra3FNIhCzY07lWGz/zbP3O1bgk+BmVCo2ppW/nF0LrLGq0NY/eD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7f-6656b1909438
Date: Wed, 29 May 2024 13:39:39 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240529043938.GA20307@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <07686f06-f1a8-4282-bb48-fc4a5b554552@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07686f06-f1a8-4282-bb48-fc4a5b554552@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC9ZZnke6EjWFpBo+WSFrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	K9scCg5KVLx4/IGpgXGxcBcjJ4eEgInEmf4FLDD2ss/nmUFsFgFViUVtu8HibALqEjdu/ASL
	iwhoSGxq2wBkc3EwC7xlkpgyp5kNJCEsECIx7cMapi5GDg5eAQuJdzvTQMJCApkS56YcZgSx
	eQUEJU7OfAI2k1lAS+LGv5dg5cwC0hLL/3GAmJwCdhLff6eCVIgKKEsc2HacCWSThMAqdolf
	Z+ZAnSkpcXDFDZYJjAKzkEydhWTqLISpCxiZVzEKZeaV5SZm5pjoZVTmZVboJefnbmIExuCy
	2j/ROxg/XQg+xCjAwajEw2txIDRNiDWxrLgy9xCjBAezkgjvmUlAId6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSwADenx9//VJTkwP7e5vnpcekMuOtrn/Z
	+0A71m/yC5WP9p2qx05UfDK+0yQa8eTqxXJdPpdotk1b10m7LAy/d3OFq1Q9Y+G7teLKpo3B
	ooIKr2L728pVdm/MWLNrvoT1fMk5KUxFhr/qGysa+g+5lf1PV+qw6Pzxk8Xsc7lAV/Kbiukd
	8zeyKLEUZyQaajEXFScCACnS0mG9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC5WfdrDthY1iawfp+Xos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZVzZ5lBwUKLixeMPTA2Mi4W7GDk5JARMJJZ9Ps8MYrMIqEosatvNAmKzCahL
	3LjxEywuIqAhsaltA5DNxcEs8JZJYsqcZjaQhLBAiMS0D2uYuhg5OHgFLCTe7UwDCQsJZEqc
	m3KYEcTmFRCUODnzCdhMZgEtiRv/XoKVMwtISyz/xwFicgrYSXz/nQpSISqgLHFg23GmCYy8
	s5A0z0LSPAuheQEj8ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAiFpW+2fiDsYvl90PMQpw
	MCrx8BrsDE0TYk0sK67MPcQowcGsJMJ7ZhJQiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqC
	kEB6YklqdmpqQWoRTJaJg1OqgXGqk1KeTPZhubX6psJ66xk7q1f3dd+1L+/KOJ9mulVIWFxM
	VC6+kvNMYOv0EBvuS86lJVWizqp7alli6t2q4lwC3B01OTmCH5bdOZDyJdwq/ubuoxbMPL/u
	Zk95Ou93rcV2J7V9Zq7zd5RGyTZ2/oyrrGh1b5Z60HHIuPWcjdOyNHNOEX8lluKMREMt5qLi
	RAD1/kjxpAIAAA==
X-CFilter-Loop: Reflected

On Tue, May 28, 2024 at 10:41:54AM +0200, David Hildenbrand wrote:
> Am 10.05.24 um 08:51 schrieb Byungchul Park:
> > Hi everyone,
> > 
> > While I'm working with a tiered memory system e.g. CXL memory, I have
> > been facing migration overhead esp. tlb shootdown on promotion or
> > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > migration through hinting fault can be avoided thanks to Huang Ying's
> > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > is inaccessible").  See the following link for more information:
> > 
> > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> > 
> > However, it's only for migration through hinting fault.  I thought it'd
> > be much better if we have a general mechanism to reduce all the tlb
> > numbers that we can apply to any unmap code, that we normally believe
> > tlb flush should be followed.
> > 
> > I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), defers tlb flush
> > until folios that have been unmapped and freed, eventually get allocated
> > again.  It's safe for folios that had been mapped read-only and were
> > unmapped, since the contents of the folios don't change while staying in
> > pcp or buddy so we can still read the data through the stale tlb entries.
> > 
> > tlb flush can be defered when folios get unmapped as long as it
> > guarantees to perform tlb flush needed, before the folios actually
> > become used, of course, only if all the corresponding ptes don't have
> > write permission.  Otherwise, the system will get messed up.
> > 
> > To achieve that:
> > 
> >     1. For the folios that map only to non-writable tlb entries, prevent
> >        tlb flush during unmapping but perform it just before the folios
> >        actually become used, out of buddy or pcp.
> 
> Trying to understand the impact: Effectively, a CPU could still read data
> from a page that has already been freed, until that page gets reallocated
> again.
> 
> The important part I can see is
> 
> 1) PCP/buddy must not change page content (e.g., poison, init_on_free),
> otherwise an app might read wrong content.

Exactly.  I will take them into account.  Thank you.

> 2) If we mess up the flush-before-realloc, an app might observe data written
> by whoever allocated the page.

Yes.  However, appropiate TLB flush is performed in prep_new_page().
Basically you are right.  I need to pay enough attention to it.

> 3) We must reliably detect+handle any read-only PTEs for which we didn't
> flush the TLB yet, otherwise an app could see its memory writes getting
> lost. I recall that at least uffd-wp might defer TLB flushes (see comment in
> do_wp_page()). Not sure about other pte_wrprotect() callers that flush the
> TLB after processing multiple page tables, whereby rmap code might succeed
> in unmapping a page before the TLB flush happened.
> 
> Any other possible issues you stumbled over that are worth mentioning?

You mentioned all that I'm concerning but in a clear way.

	Byungchul

> 
> -- 
> Thanks,
> 
> David / dhildenb

