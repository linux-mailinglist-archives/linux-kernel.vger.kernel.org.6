Return-Path: <linux-kernel+bounces-200207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC88FACF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEE91C20F12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36D1411F9;
	Tue,  4 Jun 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVTG/M33"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD21446CF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487990; cv=none; b=nFP6ntypmL+1j0/fs5woARLdFS4QmRKcjEVt1RewpWCfDTCpx+8Mj0AYei/DmPZiVcm7BQBJcUXRej2LhoQwILvAk3nUCZ/GFOSyaQbjgeRNcJrjdtEfqGHZ63sIxsnzM13POUP1k5/SaoR2g8UogOnNzYkKe0gdO9JJffXvBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487990; c=relaxed/simple;
	bh=FW5MO1A3RijbLPhQAw8aoJYzQGdRnwECT/nsnX6u0rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RKIbtZxYNhiGanr1IDtIjtOPJtlZVFYRaAmGVW0YKbmUcnds2Z9SEQKbROfXFtfal5ImFsfUMnioffTAttSd+PoOdQHXr6KQRGvHI0aCMhiu9DrOsqPBWT5Bsm5daK0b9AT6nVEzdodmM4p7j4PLwdNL349gzMExE77PGsOqkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVTG/M33; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717487989; x=1749023989;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FW5MO1A3RijbLPhQAw8aoJYzQGdRnwECT/nsnX6u0rY=;
  b=CVTG/M33XWov3D3m6Eye8j/jfJLbKrQzcDnc+jm8QWiE6yB+JbwIXcx5
   QCIzVs2Bu/DQxIpx5JSGFxUtPOdnWKTlSsf2y0/FS9LIhmGccRzq+C7BR
   PmAbP+gjUvYSVUAxQlQJs8GmO5lUHqCJUZcyhYe/ZqkgULLLF0Px9S6qQ
   XnHJ2pubTumscHjeNdvA+nsjurB+Pm4DMbW9FuQRRC+1dWDgQKcFu6NxN
   7vZnhdb3dLXUoeAw4/zvOzn2kfoSEzJJqspasZ9R6AStfl57mvXPxq7ua
   UXjDp9Oe1RfCUXsgnqxcHJ+Vti7zUe5gWdJl43rzWACcs07eehXSNb/lI
   Q==;
X-CSE-ConnectionGUID: OfU94RqVQd6dy7ikyc8reA==
X-CSE-MsgGUID: gv/B7GksRBmxyRvAqxYuSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13965203"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13965203"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 00:59:48 -0700
X-CSE-ConnectionGUID: sDrlrulOSTmw1CWWzxYJ5g==
X-CSE-MsgGUID: 0nzFEGt2SdWI+j/s8rysQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37796359"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 00:59:46 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <akpm@linux-foundation.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,  <hannes@cmpxchg.org>,
  <iamjoonsoo.kim@lge.com>,  <rientjes@google.com>
Subject: Re: [PATCH v2] mm: let kswapd work again for node that used to be
 hopeless but may not now
In-Reply-To: <20240604072323.10886-1-byungchul@sk.com> (Byungchul Park's
	message of "Tue, 4 Jun 2024 16:23:23 +0900")
References: <20240604072323.10886-1-byungchul@sk.com>
Date: Tue, 04 Jun 2024 15:57:54 +0800
Message-ID: <87bk4hcf7h.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> Changes from v1:
> 	1. Don't allow to resume kswapd if the system is under memory
> 	   pressure that might affect direct reclaim by any chance, like
> 	   if NR_FREE_PAGES is less than (low wmark + min wmark)/2.
>
> --->8---
> From 6c73fc16b75907f5da9e6b33aff86bf7d7c9dd64 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Tue, 4 Jun 2024 15:27:56 +0900
> Subject: [PATCH v2] mm: let kswapd work again for node that used to be hopeless but may not now
>
> A system should run with kswapd running in background when under memory
> pressure, such as when the available memory level is below the low water
> mark and there are reclaimable folios.
>
> However, the current code let the system run with kswapd stopped if
> kswapd has been stopped due to more than MAX_RECLAIM_RETRIES failures
> until direct reclaim will do for that, even if there are reclaimable
> folios that can be reclaimed by kswapd.  This case was observed in the
> following scenario:
>
>    CONFIG_NUMA_BALANCING enabled
>    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>    numa node0 (500GB local DRAM, 128 CPUs)
>    numa node1 (100GB CXL memory, no CPUs)
>    swap off
>
>    1) Run a workload with big anon pages e.g. mmap(200GB).
>    2) Continue adding the same workload to the system.
>    3) The anon pages are placed in node0 by promotion/demotion.
>    4) kswapd0 stops because of the unreclaimable anon pages in node0.
>    5) Kill the memory hoggers to restore the system.
>
> After restoring the system at 5), the system starts to run without
> kswapd.  Even worse, tiering mechanism is no longer able to work since
> the mechanism relies on kswapd for demotion.

We have run into the situation that kswapd is kept in failure state for
long in a multiple tiers system.  I think that your solution is too
limited, because OOM killing may not happen, while the access pattern of
the workloads may change.  We have a preliminary and simple solution for
this as follows,

https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=17a24a354e12d4d4675d78481b358f668d5a6866

where we will try to wake up kswapd to check every 10 seconds if kswapd
is in failure state.  This is another possible solution.

> However, the node0 has pages newly allocated after 5), that might or
> might not be reclaimable.  Since those are potentially reclaimable, it's
> worth hopefully trying reclaim by allowing kswapd to work again.
>

[snip]

--
Best Regards,
Huang, Ying

