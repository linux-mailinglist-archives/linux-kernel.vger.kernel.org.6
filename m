Return-Path: <linux-kernel+bounces-327564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B899777B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9292871C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A711BC078;
	Fri, 13 Sep 2024 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmDD9/iR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D93EA64
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726200055; cv=none; b=fjmvX2iAcWpi8ICH8Y8+GpadMGnpFaHW2QCWNUmawxgSbHg71I0Q5lb/sLXMQ3iGJ0+/QzN5dmpkIABFY3QgiATZkcB2axUmfHlaumrXJ3+Ha/YOzeIXoN1N3CwydYUqFPd2JobEpm+tHW7pxqvoOqhZNzdNExt7PtCeuAnPdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726200055; c=relaxed/simple;
	bh=AGU8oW2VkIQczxGH1AKW27KabmMuxPVommcOqMkQ9Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghZretdq9lkqLDZ8bvkUYgUMlJx0GIR8AtZw1oQhOrNOyctm+Bksq+ELPO86TdmILTXS3zLgasMwP4uMcxZmJQUZUvGseae7ZylGU6bhSJzAYwhVQ86kxhXKJcKLS1WFAAUyGZxwtTc1a1jeGOv4Fg91R5n23sl3JsejU5KNObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmDD9/iR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726200054; x=1757736054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AGU8oW2VkIQczxGH1AKW27KabmMuxPVommcOqMkQ9Wo=;
  b=nmDD9/iR9VgxBhYPqCJEUbD8suRbwlmKNmDA/Cu09y5DszF0NqA6j1UZ
   TO+u1Priw0Ft7gSsiCT9y5J9b/XOMhTZoQd/xKSBVP38wT/t9z091Lrs4
   cWQnFj4h4nJrxCUHetpfBcJiTT15bKffmed03CP1i+tZFAHNFm8HqOYLp
   Uo80ET9dPvCOm/7Qb5Cpu2QPc1+oaJRUS/YlXGAZOJ6JES+DQ1dPSJL5l
   Ni41Z3m3ICdhFX3jz6QbyupVwzIl2beYUIHCGd2ep2yd0/BC3Ki9qnHCV
   1EfFxhxRRj7Eo4STzP1EOzjzqgePOElsJNVNukE2IEcG8h8cQcKfMym22
   A==;
X-CSE-ConnectionGUID: 7XjfXYZaQJetHZE+XX8Z+g==
X-CSE-MsgGUID: eVjKU1lvQg6WxtTkMaWb9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24962845"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="24962845"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:00:53 -0700
X-CSE-ConnectionGUID: JBEVXyBLQWGChKAWfpuiHw==
X-CSE-MsgGUID: qFBNViP7Tj29GaiaKFBEug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="72728425"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:00:52 -0700
Date: Thu, 12 Sep 2024 21:06:35 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20240913040635.GA9167@ranerica-svr.sc.intel.com>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
 <20240905060036.5655-3-ricardo.neri-calderon@linux.intel.com>
 <20240911140844.GFZuGkbHQ_E-K5LW1q@fat_crate.local>
 <20240911233410.GA7043@ranerica-svr.sc.intel.com>
 <20240912105918.GBZuLJhtVBHKK54KFD@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912105918.GBZuLJhtVBHKK54KFD@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Sep 12, 2024 at 12:59:18PM +0200, Borislav Petkov wrote:
> On Wed, Sep 11, 2024 at 04:34:10PM -0700, Ricardo Neri wrote:
> > Yes, both patches address issues during CPU hotplug (both NULL-pointer
> > dereference). However, IHMO, they are separate issues. Patch 1/4 fixes
> > a missing allocation check. Patch 2/4 causes the allocation to happen in
> > case early allocation is not used.
> > 
> > If I did not convince you, I am happy to merge together patches 1 and 2.
> 
> Well, what is easier to handle by stable and/or backporters: one patch or two
> patches fixing two very similar CPU hotplug isuses in cacheinfo?

Indeed, one patch would be easier to handle.

> 
> IOW, what is the benefit in having two patches instead of one?

Marginal I guess. I can put all the background and rationale in the commit
message.

I will post a new version merging patches 1 and 2... and fixing the
formatting of allocate_cache_info().

