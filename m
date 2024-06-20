Return-Path: <linux-kernel+bounces-221977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FD090FB54
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21BF1F22A20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA11B5A4;
	Thu, 20 Jun 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jziNeJaD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1289101E2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718850742; cv=none; b=UX/Coz8RIszDBIamEFbvJIqQsLBWm+nDzRg5Tp+ChUO+SL3iaVhpj47p37B31xlgcKlR7WtyUchqqDvMMWI5TCUPEaC3NEDzQyB+DBP8t9RnV0b9kreD5E2tHLZd545P8NDDqr1G4DXa9Jx8yOg87o4nd3rcUZR4cKqrxF3iqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718850742; c=relaxed/simple;
	bh=2IVaSUq/iqjRz1dwkCv6hbmqTtIV5f/0QYK7K/TxyV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fs+cpap/C1+l2skLFMW7LJ/Mw6J0bQWNLByQ1FQ+2uAfINMM2VceI8V6stQ3H7WW1uObvK8iIHTaLWhE8CwVj/m/NLqmGntlcMHMJoSDUFMADtd1MTi287WnDjuJL8o7Q8zSn5RqGadumDpbWXdTAzLQ1RrrJyI3++SczsDv1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jziNeJaD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718850741; x=1750386741;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2IVaSUq/iqjRz1dwkCv6hbmqTtIV5f/0QYK7K/TxyV0=;
  b=jziNeJaDZhMe462o53yTea2kdU2aJSvp+Jl3UBR/SkhneuXGdWo175jl
   BohNBoq+zQpgmBz10T4GgjStWikQvNJDv9Piydj2LcBcM0y+H/slFWncO
   ts/urIQAwB3l3Rdx+ROg0GJXVLSvPY+zQzm7irg05S+X6aUYTTVoTAPG/
   NP05vQDCSSVn7NzR6QxuEUpHKU/6/CFsTbt9g/Tn8K3nmiHOgSGvsOj/P
   +R4fWEy2Vq0MV9p5G16vB5o6lgkgBK7XFcOP6ZhEVLVFe9PMaMpgC1F7V
   ze3SbFeKr3rTz6m1CO5QbA5U/gZ2o37TfcP3n/7qRoIQ6Dr3T3eS6sDVP
   Q==;
X-CSE-ConnectionGUID: 5+J9H+URTdeE64jWz8as5A==
X-CSE-MsgGUID: pn997zidQlaYXXPJteuPtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="19624456"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="19624456"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 19:32:20 -0700
X-CSE-ConnectionGUID: XGSfu4pGR66bCvhbMnSqcw==
X-CSE-MsgGUID: LPkXu6MRQAWDSmmn540Wow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46461011"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 19:32:18 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v3 0/2] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org> (Chris
	Li's message of "Wed, 19 Jun 2024 02:20:28 -0700")
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
Date: Thu, 20 Jun 2024 10:30:27 +0800
Message-ID: <87v8242vng.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Chris Li <chrisl@kernel.org> writes:

> This is the short term solutiolns "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.
>
> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> orders" is introduced, it only allocates the mTHP swap entries
> from new empty cluster list.  It has a fragmentation issue
> reported by Barry.
>
> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/
>
> The reason is that all the empty cluster has been exhausted while
> there are planty of free swap entries to in the cluster that is
> not 100% free.
>
> Remember the swap allocation order in the cluster.
> Keep track of the per order non full cluster list for later allocation.
>
> User impact: For users that allocate and free mix order mTHP swapping,
> It greatly improves the success rate of the mTHP swap allocation after the
> initial phase.
>
> Barry provides a test program to show the effect:
> https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gmail.com/
>
> Without:
> $ mthp-swapout                                                          
> Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%   
> Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%                                                    
> Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%   
> Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%            
> Iteration 5: swpout inc: 110, swpout fallback inc: 117, Fallback percentage: 51.54%                                                 
> Iteration 6: swpout inc: 0, swpout fallback inc: 230, Fallback percentage: 100.00%          
> Iteration 7: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00% 
> Iteration 8: swpout inc: 0, swpout fallback inc: 223, Fallback percentage: 100.00%                                                  
> Iteration 9: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%                                                  
> Iteration 10: swpout inc: 0, swpout fallback inc: 216, Fallback percentage: 100.00%                                                 
> Iteration 11: swpout inc: 0, swpout fallback inc: 212, Fallback percentage: 100.00%                                                 
> Iteration 12: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%                                                 
> Iteration 13: swpout inc: 0, swpout fallback inc: 214, Fallback percentage: 100.00%        
>
> $ mthp-swapout -s
> Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 5: swpout inc: 33, swpout fallback inc: 197, Fallback percentage: 85.65%
> Iteration 6: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00%
> Iteration 7: swpout inc: 0, swpout fallback inc: 223, Fallback percentage: 100.00%
> Iteration 8: swpout inc: 0, swpout fallback inc: 219, Fallback percentage: 100.00%
> Iteration 9: swpout inc: 0, swpout fallback inc: 212, Fallback percentage: 100.00%
>
> With:
> $ mthp-swapout       
> Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%                                                    
> Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%                                                    
> Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%                                                    
> Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%       
> Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00% 
> Iteration 6: swpout inc: 230, swpout fallback inc: 0, Fallback percentage: 0.00%            
> ...
> Iteration 94: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 95: swpout inc: 221, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 96: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 97: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 98: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 100: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
>
> $ mthp-swapout -s
> Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 5: swpout inc: 230, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 6: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 7: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 8: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%
> ...
> Iteration 94: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 95: swpout inc: 212, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 96: swpout inc: 220, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 97: swpout inc: 220, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 98: swpout inc: 216, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
> Iteration 100: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%

Unfortunately, the data is gotten using a special designed test program
which always swap-in pages with swapped-out size.  I don't know whether
such workloads exist in reality.  Otherwise, you need to wait for mTHP
swap-in to be merged firstly, and people reach consensus that we should
always swap-in pages with swapped-out size.

Alternately, we can make some design adjustment to make the patchset
work in current situation (mTHP swap-out, normal page swap-in).

- One non-full cluster list for each order (same as current design)

- When one swap entry is freed, check whether one "order+1" swap entry
  becomes free, if so, move the cluster to "order+1" non-full cluster
  list.

- When allocate swap entry with "order", get cluster from free, "order",
  "order+1", ... non-full cluster list.  If all are empty, fallback to
  order 0.

Do you think that this works?

> Reported-by: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Changes in v3:
> - Using V1 as base.
> - Rename "next" to "list" for the list field, suggested by Ying.
> - Update comment for the locking rules for cluster fields and list,
>   suggested by Ying.
> - Allocate from the nonfull list before attempting free list, suggested
>   by Kairui.

Haven't looked into this.  It appears that this breaks the original
discard behavior which helps performance of some SSD, please refer to
commit 2a8f94493432 ("swap: change block allocation algorithm for SSD").

And as pointed out by Ryan, this may reduce the opportunity of the
sequential block device writing during swap-out, which may hurt
performance of SSD too.

[snip]

--
Best Regards,
Huang, Ying

