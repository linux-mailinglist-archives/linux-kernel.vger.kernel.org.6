Return-Path: <linux-kernel+bounces-250111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2572A92F45D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DCD1F21556
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9ADDBE;
	Fri, 12 Jul 2024 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZ6TbvmG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C5DDBC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754686; cv=none; b=icUgEkiCisDqLoc0Okk67CPRpIYoAX2k5NaUKgAvIlV3TmgFf+U7Yw7gELPKwdUH3vR83kxkQKOwNcgSwRaYzKyiVKwoTW/JqXwL5msM9PD3kRuSFpvJDviwM91heKEpd/YHacr5G6yhogGVm8Qs63YIG5SJtt9ji/4vDGxoFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754686; c=relaxed/simple;
	bh=Oi57v7GuK/09YKFkv9pnNthQOxjrDZLk4NqBoE3db/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pXJHiWhdJlieBufZAXSLJz5f3qPqQBVeponqRS3P902y9uMCBlU9ccMeinYBQ0YLhVBNgMgnvXiSJxh0Y1gTSOTLwpcjUJQ3vqD4k5nVGShgXGMf6qaD6zN6WC5jymqiPFrbIvnOeiHYDAanOrJgJSbhExsF1gr2Qg/3uzk0CY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZ6TbvmG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720754685; x=1752290685;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Oi57v7GuK/09YKFkv9pnNthQOxjrDZLk4NqBoE3db/k=;
  b=IZ6TbvmGDVSqhLPS4q26cCNPHLvLOivrJypooCgv99+E3VbLOhkAi7em
   4VkW/PKUBddLiRuXQ0VE+I2sp/hkSaQKicdekXl7wSiH3TFTt3WHHmGC3
   WrrirpPuL+p3Q4HoCcDAMKSX6qxr5SwYaDl6D61EofS/RweLRg5+tM0Gh
   WRgwuryTZv2zt1pxckCJ4x9hvosHOKWXnXgQfrhSJEdPRfcOIq9ATSocz
   2YTd+Ed3dLFfU6zmWWianUC5cC3TkJIuZSF7kDOUuq6QP94fVp1Ke9eE+
   WoQoTIbB87FvpVphXpgUmiCaHY7gGATdyVvChcTb+6gZHcFMgqyrwe28l
   Q==;
X-CSE-ConnectionGUID: rd1IRsUeQNGtfUN4yxbGOw==
X-CSE-MsgGUID: o7gHJmyNRQ26fDWQha6Q7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28772187"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="28772187"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:24:44 -0700
X-CSE-ConnectionGUID: JQXs+Q0iQxKY+Mv3VkM2Kg==
X-CSE-MsgGUID: A1ftitm1T2aDUcvS7PP8Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48792332"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:24:42 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <zi.yan@sent.com>
Cc: David Hildenbrand <david@redhat.com>,  linux-mm@kvack.org,  Zi Yan
 <ziy@nvidia.com>,  Andrew Morton <akpm@linux-foundation.org>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] memory tiering: read last_cpupid correctly in
 do_huge_pmd_numa_page()
In-Reply-To: <20240712024455.163543-2-zi.yan@sent.com> (Zi Yan's message of
	"Thu, 11 Jul 2024 22:44:53 -0400")
References: <20240712024455.163543-1-zi.yan@sent.com>
	<20240712024455.163543-2-zi.yan@sent.com>
Date: Fri, 12 Jul 2024 11:22:51 +0800
Message-ID: <87le278fas.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> last_cpupid is only available when memory tiering is off or the folio
> is in toptier node. Complete the check to read last_cpupid when it is
> available.
>
> Before the fix, the default last_cpupid will be used even if memory
> tiering mode is turned off at runtime instead of the actual value. This
> can prevent task_numa_fault() from getting right numa fault stats, but
> should not cause any crash. User might see performance changes after the
> fix.
>
> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Good catch!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/huge_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d7c84480f1a4..07d9dde4ca33 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1705,7 +1705,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	 * For memory tiering mode, cpupid of slow memory page is used
>  	 * to record page access time.  So use default value.
>  	 */
> -	if (node_is_toptier(nid))
> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> +	    node_is_toptier(nid))
>  		last_cpupid = folio_last_cpupid(folio);
>  	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>  	if (target_nid == NUMA_NO_NODE)

