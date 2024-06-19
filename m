Return-Path: <linux-kernel+bounces-220790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C601190E71D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1735C281414
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85C87E58F;
	Wed, 19 Jun 2024 09:32:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB9A20B34
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789525; cv=none; b=P1nNBxa3FizuEslqIMQPrpqIYX2sku8DAOnWbYnPDmWes6iDgD+vkDZpA5kqlP3P/29M/zd5HYwxMOvpmDPTr78xN7Q17RfgVEZdyLvpn/bQIzxd9slXfdNtOHWc62TFvFlGt1dRn3MlcwEz/dSaisx9Z05I0q+0DlZuS+09SB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789525; c=relaxed/simple;
	bh=V1ffL/PhAeo4peyAcLvwR8276v37fCfBHyqqvQXiUew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo3gwDpQJm8TY9oig5hO5IMoAV+JWLdRi7JktOhIQcDCWyS+72XCAsJ14L0Ygg6m0y+yrD6d1OBklIcD85D0JD4Ht2dxsteCEP2E9QPh4rL6PZCRMzkujbiKtPmK698ADnUVirXwS1DwaUxGEZm8HYnBax7AtPjyBVx8PKqsmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2325DA7;
	Wed, 19 Jun 2024 02:32:26 -0700 (PDT)
Received: from [10.1.36.163] (XHFQ2J9959.cambridge.arm.com [10.1.36.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 246B53F64C;
	Wed, 19 Jun 2024 02:32:01 -0700 (PDT)
Message-ID: <1f02756f-a753-459b-8e8b-85fbbe5c5126@arm.com>
Date: Wed, 19 Jun 2024 10:31:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
Content-Language: en-GB
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Barry Song <baohua@kernel.org>
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/06/2024 10:20, Chris Li wrote:
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

Excellent!

> 
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

Sorry I didn't follow this original conversation. But the original intent of
having a per-cpu current cluster was to prevent interleving pages from multiple
processes and therefore optimize IO. See commit ebc2a1a69111 ("swap: make
cluster allocation per-cpu"). I wonder if this change could lead to a swap
performance regression in the common order-0 case?

Thanks,
Ryan

> - Link to v2: https://lore.kernel.org/r/20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org
> 
> Changes in v2:
> - Abandoned.
> - Link to v1: https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org
> 
> ---
> Chris Li (2):
>       mm: swap: swap cluster switch to double link list
>       mm: swap: mTHP allocate swap entries from nonfull list
> 
>  include/linux/swap.h |  30 +++----
>  mm/swapfile.c        | 248 +++++++++++++++++----------------------------------
>  2 files changed, 95 insertions(+), 183 deletions(-)
> ---
> base-commit: 19b8422c5bd56fb5e7085995801c6543a98bda1f
> change-id: 20240523-swap-allocator-1534c480ece4
> 
> Best regards,


