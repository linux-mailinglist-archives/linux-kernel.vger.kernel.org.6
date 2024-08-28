Return-Path: <linux-kernel+bounces-304395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCD961F89
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0853F1C2355E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC90156872;
	Wed, 28 Aug 2024 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvAZNVyP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01B14D452;
	Wed, 28 Aug 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825859; cv=none; b=P7eBHCDOFVpkr4gMHwKUSPYqU/D4bunoUHgtW+4Df9fXF1hvAGEGwHz9O4wdfxfAaDTxGxh8JG3zwWio7T+6Vk5Fg/q2lkCR4w4n68zb5yBYFV/xZRE+Hi/WmZSh7e7/YtQzgAmxy1/PjGceL34u17JXXiwOWtwe+89u9pWnvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825859; c=relaxed/simple;
	bh=N7D0w95cp/r1m6Xu8l24R+M33YOTjjUOZNZE60X/7Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFk4CLIZRQDcTcx8LHcR5DuwfIFIw5bnsw8HI8Yvggna7M7vRejoXbUtRNc1ooZAimBO1w9L5jfM9a+iHpf53HbpayHYMERycXbImyARynMi9yGsbl6Mf7soaDqBCoyWo6cBrsC4+VlkcN4ShrsRNCX7vzI2rM7Zu926YdumIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvAZNVyP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724825858; x=1756361858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N7D0w95cp/r1m6Xu8l24R+M33YOTjjUOZNZE60X/7Dg=;
  b=FvAZNVyPtDnT1Ztr59K4j0DkWn1AbM/YSqfJLu5HwwYt0JxrFOQSNL6o
   x1qCY/9AFk+IAzrD7Zpa1qVQimPTGe/4wHYOtLR7gQ7OrOSvP87rPmmAl
   ZsH5XKkMyaSky4mfxQqLsoGu2oltfSltoioSAQRRq5q80R94hNsehBQly
   zmmS+iQKxggOc11hUHFTrmCZUisKBAdI/WauTIVWdf0sjECMjMs3J24mq
   wjB9MLxOagPHai0IB1LsD5YTZ9PhBS4kDZc2XZvjlM3WC27lT1Kh+qdm/
   C7vEq+A0gT1Sq93WqkUP+D3ruWsUpIsmJM9lDo8WpS1XtsDxcP8aroZ1W
   Q==;
X-CSE-ConnectionGUID: QJyqN7/cTQyfePyYqssA6A==
X-CSE-MsgGUID: u8vtmIL0QbGnXi7E2cyX0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40809975"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="40809975"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 23:17:37 -0700
X-CSE-ConnectionGUID: 1mKfn2JpSu2KtJ8a7fNUCA==
X-CSE-MsgGUID: HuWHYxoBTY6lcwh4GJ9twg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="93827911"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 27 Aug 2024 23:17:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D8699142; Wed, 28 Aug 2024 09:17:30 +0300 (EEST)
Date: Wed, 28 Aug 2024 09:17:30 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Usama Arif <usamaarif642@gmail.com>, Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Barry Song <baohua@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lance Yang <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>, Rafael Aquini <aquini@redhat.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Zi Yan <ziy@nvidia.com>
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
Message-ID: <ouerpxb676mei3kndz53j4am4fo2duvygoatfnposo2rkct566@akl7ckd7nrvk>
References: <20240729222727.64319-1-npache@redhat.com>
 <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
 <CAA1CXcCD798gkLoZuz3Cd5-Wf2MRfnAG_EB0U3nbScZeFv09dw@mail.gmail.com>
 <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
 <61411216-d196-42de-aa64-12bd28aef44f@gmail.com>
 <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
 <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com>
 <20240827110959.GA438928@cmpxchg.org>
 <9cf237df1a7bb21bba1a464787938eba8f372658.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf237df1a7bb21bba1a464787938eba8f372658.camel@surriel.com>

On Tue, Aug 27, 2024 at 09:18:58PM -0400, Rik van Riel wrote:
> On Tue, 2024-08-27 at 13:09 +0200, Johannes Weiner wrote:
> > 
> > I agree with this. The defer mode is an improvement over the upstream
> > status quo, no doubt. However, both defer mode and the shrinker solve
> > the issue of memory waste under pressure, while the shrinker permits
> > more desirable behavior when memory is abundant.
> > 
> > So my take is that the shrinker is the way to go, and I don't see a
> > bonafide usecase for defer mode that the shrinker couldn't cover.
> > 
> > 
> I would like to take one step back, and think about what some real
> world workloads might want as a tunable for THP.
> 
> Workload owners are going to have a real problem trying to figure
> out what the best value of max_ptes_none should be for their
> workloads.
> 
> However, giving workload owners the ability to say "this workload
> should not waste more than 1GB of memory on zero pages inside THPs",
> or 500MB, or 4GB or whatever, would then allow the kernel to
> automatically adjust the max_ptes_none threshold.

The problem is that we don't have and cannot have the info on zero pages
inside THPs readily available. It requires memory scanning which is
prohibitively expensive if we want the info to be somewhat up-to-date.

We don't have enough input from HW on the access pattern. It would be nice
to decouple A/D bit (or maybe just A) from page table structure and get
higher resolution on the access pattern for THPs.

I tried to talk to HW folk, but it went nowhere. Maybe if there would be a
customer demand... Just saying...

-- 
Kiryl Shutsemau / Kirill A. Shutemov

