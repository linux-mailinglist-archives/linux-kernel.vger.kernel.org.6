Return-Path: <linux-kernel+bounces-523710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F651A3DA3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894483B2398
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACFB1F4639;
	Thu, 20 Feb 2025 12:41:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06463286298
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055263; cv=none; b=GQx8fi+yP5oYY5m+15WRPrpUeWZKfRJLDCKaO68wgR1SQ4BDE6mcm8rnIRsg0/iFt8YrohhBFR9PjI8echqgmuUlAt6CBnWzW231lqVWcwKPH4jDHc4a9Tqz4Lyqh1mBepvRx6QEB3rXoRPzmPaJFn4uxnZXPqtkShVNTgRz+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055263; c=relaxed/simple;
	bh=DaDf7XPFvzBZcppXRgBLDzEIu49JiuU5kD0XH7velAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfIHSOj7BI0XOdhWLpouYuF9vS0i1lHBaDAUUN1PyLdHkRw90UVSLWysA8+Ete6Wjn17YkrqCAkmuN66pdaEu8yjQAqVWBO75s1dae5bjwGFi7q4rA36kRSibEekahSrwgjX4NVwHtfvqvnVdFh3BQTXq1gtBapRsps1v+thUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-dc-67b722d7adf2
Date: Thu, 20 Feb 2025 21:40:50 +0900
From: Byungchul Park <byungchul@sk.com>
To: Hillf Danton <hdanton@sina.com>, torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20250220124050.GB8305@system.software.com>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220114920.2383-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsXC9ZZnoe51pe3pBttnKlsc+PmcxeLyrjls
	FvfW/Ge1eNT3lt2BxWPTp0nsHidm/GbxmPTC3ePzJrkAligum5TUnMyy1CJ9uwSujMsPXrMV
	vJOsuLfpNnsD4zvhLkZODgkBE4nGCTuZYOynd44zgtgsAqoS6xa9YgWx2QTUJW7c+MkMYosI
	OEk8OnMCrJ5ZwF9iwq0NLCC2sECExJNDIHEODl4Bc4nenRYgYSGBbkaJNc/SQWxeAUGJkzOf
	sEC0aknc+PcSrJxZQFpi+T8OkDCngKlE/5FFYBeICihLHNh2HKiEC+iyHjaJY5tmMkOcKSlx
	cMUNlgmMArOQjJ2FZOwshLELGJlXMQpl5pXlJmbmmOhlVOZlVugl5+duYgSG67LaP9E7GD9d
	CD7EKMDBqMTDO6N1W7oQa2JZcWXuIUYJDmYlEd62+i3pQrwpiZVVqUX58UWlOanFhxilOViU
	xHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhiN4/rZsvxXSWVqTc69sfSwhKtr2ccGvwO/rq5v
	elUqI753XWLt9L31S5pDW2wX3ub79oC1SflkL9uasx9YdD7weh5dFh3m+n1zZJDpFk8Gpo+S
	VVcrVBSkf3ncmCftPzl/xt+bzw/PLRMI+p9UMP/Lhhcyf6b3Mb5YkWiafOn7DjalZY2Lm54q
	sRRnJBpqMRcVJwIAzcjJIlMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsXC5WfdrHtdaXu6wY7rEhYHfj5nsTg89ySr
	xeVdc9gs7q35z2rxqO8tuwOrx6ZPk9g9Tsz4zeIx6YW7x+IXH5g8Pm+SC2CN4rJJSc3JLEst
	0rdL4Mq4/OA1W8E7yYp7m26zNzC+E+5i5OSQEDCReHrnOCOIzSKgKrFu0StWEJtNQF3ixo2f
	zCC2iICTxKMzJ5hAbGYBf4kJtzawgNjCAhESTw6BxDk4eAXMJXp3WoCEhQS6GSXWPEsHsXkF
	BCVOznzCAtGqJXHj30uwcmYBaYnl/zhAwpwCphL9RxaBXSAqoCxxYNtxpgmMvLOQdM9C0j0L
	oXsBI/MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwOBbVvtn4g7GL5fdDzEKcDAq8fA+eLw1
	XYg1say4MvcQowQHs5IIb1v9lnQh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZ
	qakFqUUwWSYOTqkGxpXn+ZvFtj7huvj94Hz27vPVPyctPrZSLF5i/nw+3ZjeX3v2XdnmsDD9
	unA8++qJLm4aO+PqjtyOrvB+ZpPXxmoU+XeWWsRxpzt2rbsNT63rnLWyvrJ/Q8Ff8WkrOA3C
	jov6bFqwW/qyhLrVvY9a6R4aqYbee56v80jlnDKra6aS1Pz123TZPJVYijMSDbWYi4oTAXu2
	oKk6AgAA
X-CFilter-Loop: Reflected

On Thu, Feb 20, 2025 at 07:49:19PM +0800, Hillf Danton wrote:
> On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> > On Thu, Feb 20, 2025 at 06:32:22PM +0800, Hillf Danton wrote:
> > > On Thu, 20 Feb 2025 14:20:01 +0900 Byungchul Park <byungchul@sk.com>
> > > > To check luf's stability, I ran a heavy LLM inference workload consuming
> > > > 210GiB over 7 days on a machine with 140GiB memory, and decided it's
> > > > stable enough.
> > > > 
> > > > I'm posting the latest version so that anyone can try luf mechanism if
> > > > wanted by any chance.  However, I tagged RFC again because there are
> > > > still issues that should be resolved to merge to mainline:
> > > > 
> > > >    1. Even though system wide total cpu time for TLB shootdown is
> > > >       reduced over 95%, page allocation paths should take additional cpu
> > > >       time shifted from page reclaim to perform TLB shootdown.
> > > > 
> > > >    2. We need luf debug feature to detect when luf goes wrong by any
> > > >       chance.  I implemented just a draft version that checks the sanity
> > > >       on mkwrite(), kmap(), and so on.  I need to gather better ideas
> > > >       to improve the debug feature.
> > > > 
> > > > ---
> > > > 
> > > > Hi everyone,
> > > > 
> > > > While I'm working with a tiered memory system e.g. CXL memory, I have
> > > > been facing migration overhead esp. tlb shootdown on promotion or
> > > > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > > > migration through hinting fault can be avoided thanks to Huang Ying's
> > > > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > > > is inaccessible").
> > > > 
> > > > However, it's only for migration through hinting fault.  I thought it'd
> > > > be much better if we have a general mechanism to reduce all the tlb
> > > > numbers that we can apply to any unmap code, that we normally believe
> > > > tlb flush should be followed.
> > > > 
> > > > I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), that defers tlb
> > > > flush until folios that have been unmapped and freed, eventually get
> > > > allocated again.  It's safe for folios that had been mapped read-only
> > > > and were unmapped, as long as the contents of the folios don't change
> > > > while staying in pcp or buddy so we can still read the data through the
> > > > stale tlb entries.
> > > >
> > > Given pcp or buddy, you are opening window for use after free which makes
> > > no sense in 99% cases.
> > 
> > Just in case that I don't understand what you meant and for better
> > understanding, can you provide a simple and problematic example from
> > the u-a-f?
> > 
> Tell us if it is illegal to commit rape without pregnancy in your home town?

+to Torvalds

Logical blame is welcome but I don't want to see potty-mouthed busters
like him in Linux community any more.  Please, ban him for better
community.

	Byungchul

> PS defering flushing tlb [1,2] is no go.
> 
> Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
> [1] https://lore.kernel.org/lkml/20250127155146.GB25757@willie-the-truck/
> [2] https://lore.kernel.org/lkml/xhsmhwmdwihte.mognet@vschneid-thinkpadt14sgen2i.remote.csb/

