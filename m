Return-Path: <linux-kernel+bounces-523621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29EA3D95C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F167317EF2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B31F5402;
	Thu, 20 Feb 2025 11:59:16 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4F1EE01B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052755; cv=none; b=bamuiNzNmq28aNqc6ji068bM4pYjGWOLWnBt+6O6B40Xby2tNpQoWMKLRpoqast13x4cGVtrtZGz3LiByru8zDLvnc3q3dad5+FHRosm0iAb22mT0dJKqj4nfnmEo0uGPJHIi93w36wcIxBBJYiqSZ6y8xKLOBKJ+PSpGY/earg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052755; c=relaxed/simple;
	bh=VnBygHI1QJwOIYQ/g2J+eJivC5SOxDBSn4PU3NWh0V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRGpG8VtsGWwXGg3PzpM+6m3XDa7fBiYAvcINSo8MyqunzWCoYU7FGKsnlURCO/rUBxHUZNYTIqokSS+6MpvtkUpWBNDvci/fiWSyNOg8+VJwwGt83riXdWdWp3oV4ReU3+x2+4UsinQIJGrcMU109feBfV3p9QFPgBiDwOwb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.172])
	by sina.com (10.185.250.22) with ESMTP
	id 67B716C700007EBD; Thu, 20 Feb 2025 19:49:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5901547602708
X-SMAIL-UIID: EDD8DF5FFF434C329343F466FEF693FA-20250220-194931-1
From: Hillf Danton <hdanton@sina.com>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Thu, 20 Feb 2025 19:49:19 +0800
Message-ID: <20250220114920.2383-1-hdanton@sina.com>
In-Reply-To: <20250220110935.GA64704@system.software.com>
References: <20250220052027.58847-1-byungchul@sk.com> <20250220103223.2360-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> On Thu, Feb 20, 2025 at 06:32:22PM +0800, Hillf Danton wrote:
> > On Thu, 20 Feb 2025 14:20:01 +0900 Byungchul Park <byungchul@sk.com>
> > > To check luf's stability, I ran a heavy LLM inference workload consuming
> > > 210GiB over 7 days on a machine with 140GiB memory, and decided it's
> > > stable enough.
> > > 
> > > I'm posting the latest version so that anyone can try luf mechanism if
> > > wanted by any chance.  However, I tagged RFC again because there are
> > > still issues that should be resolved to merge to mainline:
> > > 
> > >    1. Even though system wide total cpu time for TLB shootdown is
> > >       reduced over 95%, page allocation paths should take additional cpu
> > >       time shifted from page reclaim to perform TLB shootdown.
> > > 
> > >    2. We need luf debug feature to detect when luf goes wrong by any
> > >       chance.  I implemented just a draft version that checks the sanity
> > >       on mkwrite(), kmap(), and so on.  I need to gather better ideas
> > >       to improve the debug feature.
> > > 
> > > ---
> > > 
> > > Hi everyone,
> > > 
> > > While I'm working with a tiered memory system e.g. CXL memory, I have
> > > been facing migration overhead esp. tlb shootdown on promotion or
> > > demotion between different tiers.  Yeah..  most tlb shootdowns on
> > > migration through hinting fault can be avoided thanks to Huang Ying's
> > > work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> > > is inaccessible").
> > > 
> > > However, it's only for migration through hinting fault.  I thought it'd
> > > be much better if we have a general mechanism to reduce all the tlb
> > > numbers that we can apply to any unmap code, that we normally believe
> > > tlb flush should be followed.
> > > 
> > > I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), that defers tlb
> > > flush until folios that have been unmapped and freed, eventually get
> > > allocated again.  It's safe for folios that had been mapped read-only
> > > and were unmapped, as long as the contents of the folios don't change
> > > while staying in pcp or buddy so we can still read the data through the
> > > stale tlb entries.
> > >
> > Given pcp or buddy, you are opening window for use after free which makes
> > no sense in 99% cases.
> 
> Just in case that I don't understand what you meant and for better
> understanding, can you provide a simple and problematic example from
> the u-a-f?
> 
Tell us if it is illegal to commit rape without pregnancy in your home town?

PS defering flushing tlb [1,2] is no go.

Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
[1] https://lore.kernel.org/lkml/20250127155146.GB25757@willie-the-truck/
[2] https://lore.kernel.org/lkml/xhsmhwmdwihte.mognet@vschneid-thinkpadt14sgen2i.remote.csb/

