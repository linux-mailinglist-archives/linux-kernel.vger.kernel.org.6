Return-Path: <linux-kernel+bounces-406174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 214439C5C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E70B42A15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D92003D0;
	Tue, 12 Nov 2024 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vmcd1H8D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8F2003C7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424747; cv=none; b=WwzOdASb/cfK9ugM7hqJzNd8rV/sfT5/M0Q7edSdQNX8/JUvEjKqHtm/+XDm7FikQMPYzIu02EAy5F1ZjmC1/ftBPnA+/hLfvgfPh2HTdUjTaYjqxSTTj05qkS/Yaf7uSjKmrTSpCoT7Vql7+dyNE2PhueRyqO/20zHIQcjxUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424747; c=relaxed/simple;
	bh=vRvyBq2ix1ZzyxuxoGvplur4rUnPOqD8lxpB8hJU82M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9PVLgI5Lf9J3s5SRS5YPyfSODZVVtoJq4rWjxA/KEdUqUrlndsmg3VU/TpP9WPmkI/J2PxcGoe3DTFiLg0zd2NgSJxLighFVvLySZLBCu4PRtxBgooHgihKvE3p4HQoXddeeZBHOKRLL3WOn9bdn27rnOTRJAa6N4g1GpxZsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vmcd1H8D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731424746; x=1762960746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vRvyBq2ix1ZzyxuxoGvplur4rUnPOqD8lxpB8hJU82M=;
  b=Vmcd1H8DiQI6YeHAbmTuidS7azV9qJUtNgU+mC8kbAJz3m12HRQH0iOO
   5cyg9CDd0CT9HSdVd3wS9ShmGA4NiQ5j+wbEr5TddyFiwcCraplD4+2ad
   tsrbVQYHkyTXQDlFAGYIBVPgfo/wNEq+n+BRdgUd7eanADAlhAcQ1sqsL
   QmGvW6PGUkTQZ5/heD1Ju7X6mEp/VlokPGwHhLy1UbIkjthgPak/rL4uA
   nycpTLpjftPQRUDRzlM7XD31WA43zAsYlWc5znECuoczIrGAc3aqJSOi0
   62jUhB33S1iRzDAn5uWaSZDgGwR++rWMDOqR3tAYc3wMwVKxBM1BT5VeW
   g==;
X-CSE-ConnectionGUID: 58bRBkQ3QkCP7fhLnZZxJw==
X-CSE-MsgGUID: Q6p7ME6ISqavYY8WRO/CLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="18874578"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="18874578"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:19:04 -0800
X-CSE-ConnectionGUID: aw5apPfpSfOxf0vvArEDJA==
X-CSE-MsgGUID: 6NO57tGfQTaQdOQtBRg6jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87475582"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:19:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tAsfR-0000000E2WR-0rPM;
	Tue, 12 Nov 2024 17:18:57 +0200
Date: Tue, 12 Nov 2024 17:18:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] sched/fair: Mark cfs_bandwidth_used() and
 m*_vruntime() with __maybe_unused
Message-ID: <ZzNx4D5lWVhTG7bk@smile.fi.intel.com>
References: <20240905171210.267626-1-andriy.shevchenko@linux.intel.com>
 <xhsmh7c98d65h.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh7c98d65h.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 12, 2024 at 12:48:42PM +0100, Valentin Schneider wrote:
> On 05/09/24 20:12, Andy Shevchenko wrote:
> > When cfs_bandwidth_used() is unused, it prevents kernel builds
> > with clang, `make W=1` and CONFIG_WERROR=y:
> >
> > kernel/sched/fair.c:526:19: error: unused function 'max_vruntime' [-Werror,-Wunused-function]
> >   526 | static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
> >       |                   ^~~~~~~~~~~~
> > kernel/sched/fair.c:6580:20: error: unused function 'cfs_bandwidth_used' [-Werror,-Wunused-function]
> >  6580 | static inline bool cfs_bandwidth_used(void)
> >       |                    ^~~~~~~~~~~~~~~~~~
> >
> > Fix this by marking them with __maybe_unused (all cases for the sake of
> > symmetry).
> >
> 
> I assume that's with CONFIG_CFS_BANDWIDTH=n? Looks like
> cfs_bandwidth_used() uses are tucked away under helpers that themselves
> only really do something for CONFIG_CFS_BANDWIDTH=y, so you could remove
> the CONFIG_CFS_BANDWIDTH=n definition of cfs_bandwidth_used() directly.

Thanks for looking into this!

> This compiles:

okay, consider then my patch as a report. Can you submit your version as you
seems much more familiar with this code than me?

-- 
With Best Regards,
Andy Shevchenko



