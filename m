Return-Path: <linux-kernel+bounces-373920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DE9A5EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8061C22256
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3721E25F0;
	Mon, 21 Oct 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjDCJ7Zc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2661D2707
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500237; cv=none; b=Z3CcKfet25fHZ1+SR+5Z6ADkFBmX6oLwDDCRfpd7f06yc5vw9rSf//2Gq4ThXtYyrcm0HPL3HJjblgBfgrKsoQIT2HtAaMlAoUUiBGCSyS1u0cCOF1WEJMVIJr4POuvRgy4/CePZRt7JaqIj0Sq1hD9vJmmTakPBNNOrOX2ndGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500237; c=relaxed/simple;
	bh=7NZ5IAV6kJg8ahNCBPuuATIcY4aHBnpr5IMvRSMT+0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LL408ifqiqmCtoAJBgSm5zewlW9CNu7+VeYhCwi0JsFTI2z2PxslarWMHGQKCP5jJkDMsUALzpgvH3YXjLwCzL23CPBCb1kVH8QzdAUJPvnNxACkCfo/ScpLhsunBUve85LnNqCVZIosiwBX7x85OZif8OHPKWLWhhEGjKzWPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjDCJ7Zc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500234; x=1761036234;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7NZ5IAV6kJg8ahNCBPuuATIcY4aHBnpr5IMvRSMT+0A=;
  b=WjDCJ7ZchW8SUjIMW/QWj+qjtcxgMKxIowZj287DiGj3gOB3lrg1BvTU
   2u7WlCxPT93mEY4aEgmLIEEX0QL+z7FYkS3c7ysE6+cMp1CiqKuhOUynr
   g1G687JARFeAKFMQ7HFYWbMu05y1N7F9YXpz0lEepLTWQla+zq3RigsHx
   DNx2RlA+s3gvilv7+U8F+0Sx01U1k47EVxK6pvPgmZdZHlJVFDcF+yGYv
   bFQzvfrFJYZQJbwgaPGMADWYy0mH2vCmJ45Egy5tYpnlnJk4/auD/Zh0i
   DGft+zp7xwUpW9ppPJoXrL+ber6ZFE4NE6OD3qQmClQMCTazvObOHbHrX
   Q==;
X-CSE-ConnectionGUID: 9Bo8QExES2iNwt732OYV2g==
X-CSE-MsgGUID: r+eo0U83Q4qGdsL8Op+VQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39511168"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39511168"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:43:54 -0700
X-CSE-ConnectionGUID: yTYjJvMgShaNdjahtACFkQ==
X-CSE-MsgGUID: GxzvPMRgTqixoeTkjqiWig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79399878"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:43:52 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: mengensun88@gmail.com
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  alexjlzheng@tencent.com,  MengEn Sun
 <mengensun@tencent.com>
Subject: Re: [PATCH linux-mm v2] mm: make pcp_decay_high working better with
 NOHZ full
In-Reply-To: <1729238277-26683-1-git-send-email-mengensun@tencent.com>
	(mengensun's message of "Fri, 18 Oct 2024 15:57:57 +0800")
References: <1729238277-26683-1-git-send-email-mengensun@tencent.com>
Date: Mon, 21 Oct 2024 16:40:19 +0800
Message-ID: <87msix6e8c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Mengen,

mengensun88@gmail.com writes:

> From: MengEn Sun <mengensun@tencent.com>
>
> When a cpu entring NOHZ full, quiet_vmstat may flush percpu
> zonestats and nodestats.
>
> The vmstat_shepherd only check percpu zonestats and nodestats
> to determine whether it is necessary to fire vmstat_update on
> the target cpu for now.
>
> If a process on a certain CPU allocates a large amount of memory,
> then frees that memory, and subsequently the CPU enters NOHZ, and
> the process not freeing and allocating memory anymore,the
> vmstat_update not being executed on the cpu. Because
> vmstat_shepherd may not see zonestats and nodestats of the cpu
> changed, so may resulting in vmstat_update on the cpu not fired
> for a long time.

The issue description is too long, can you make it a little shorter?
And can you correct your grammar with some tool?  Something like chatgpt
is good for that, e.g., "fix the grammar of the following text: ...".
To make variable and function name distinct, I personally prefer to add
"()" after the function name.

Have verified the issue with some test?  If not, I suggest you to do
that.

> While, This seems to be fine:
> - if freeing and allocating memory occur later, it may the
>   high_max may be adjust automatically
> - If memory is tight, the memory reclamation process will
>   release the pcp

This could be a real issue for me.

> Whatever, we make vmstat_shepherd to checking whether we need
> decay pcp high_max, and fire pcp_decay_high early if we need.
>
> Fixes: 51a755c56dc0 ("mm: tune PCP high automatically")
> Reviewed-by: Jinliang Zheng <alexjlzheng@tencent.com>
> Signed-off-by: MengEn Sun <mengensun@tencent.com>
> ---
> changelog:
> v1: https://lore.kernel.org/lkml/20241012154328.015f57635566485ad60712f3@linux-foundation.org/T/#t
> v2: Make the commit message clearer by adding some comments.
> ---
>  mm/vmstat.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 1917c034c045..07b494b06872 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2024,8 +2024,17 @@ static bool need_update(int cpu)
>  
>  	for_each_populated_zone(zone) {
>  		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> +		struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>  		struct per_cpu_nodestat *n;
>  
> +		/* per_cpu_nodestats and per_cpu_zonestats maybe flush when cpu
> +		 * entering NOHZ full, see quiet_vmstat. so, we check pcp
> +		 * high_{min,max} to determine whether it is necessary to run
> +		 * decay_pcp_high on the corresponding CPU
> +		 */

Please follow the comments coding style.

                /*
                 * comments line 1
                 * comments line 2
                 */

> +		if (pcp->high_max > pcp->high_min)
> +			return true;
> +

We don't tune pcp->high_max/min in fact.  Instead, we tune pcp->high.
Your code may make need_update() return true in most cases.

>  		/*
>  		 * The fast way of checking if there are any vmstat diffs.
>  		 */

--
Best Regards,
Huang, Ying

