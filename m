Return-Path: <linux-kernel+bounces-308245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68996593C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE3628435F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87077165EEB;
	Fri, 30 Aug 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NojuWygG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236F15CD7D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004625; cv=none; b=kq5fv20por++Plk4QBntZHyQAMeHpxrfK38Na6p5dzv3fseefjrSjXvj1UxULQBPnOegNn3UzJfW8N1Tt45RF2dGj+9r9btz5pqlrM6bJ5nY7CsPossagGYotnju0Klj4hU1ssvNBtlK4D185pHljfrGLSZFA5S1tEZOmKT/4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004625; c=relaxed/simple;
	bh=HIAvs73fLU+Odeaq7PISmfEAdxt18VJxlK8OmK1aY88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mlhWjQGZD1ZN46X+nVo3ReB+3JhZTqNYbZdDtd6IV4B50rx4FOWOhEXvNZJSSYi2PDPjlrPttK0A9cJ6/fx9nonEFsNKO8lye1gcLVLQQFVvvlW00F1cfscinJXcQmcWIAgvUl0tyuI/2qQrdJ4wW6VKtOcdueZPqX7Aypxgtsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NojuWygG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725004625; x=1756540625;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HIAvs73fLU+Odeaq7PISmfEAdxt18VJxlK8OmK1aY88=;
  b=NojuWygGF31wQ46dm6kxc7vVPMB4z1WRzC8QSBlUhkok2BHDurVDIcRd
   8eKqwmkKy0WTUTHfGaGEhHIeGKPMvYFSQfkptHG35/ggqtV01qnSRxjbA
   EgzoBO+mCFcucG+XwLTMslLkYho6njkFCP7cOgbY27LyxiZoPvLtDs6zY
   769sNw5LtuEClx005Pr+/oc1eN1t5526zv15XPJLKoG6/fJZ1KM5v5nCK
   TK0mtt2XDvAV0C8s3k7ThgUHQS9shpC5hwrvQVVntoihUzUyfcv6121pt
   yLcfmP7iV05yrVH42H0N7uRFrSCX/YjS8ahpbCkTvjF6rp8EvOYxT8/4c
   A==;
X-CSE-ConnectionGUID: cVck+VntQgaLc/Kgunkviw==
X-CSE-MsgGUID: hfswYV5aRuaGb5Iqz7wBXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34796293"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="34796293"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:57:04 -0700
X-CSE-ConnectionGUID: hOym2mxlTm6JTAiHi6VU+Q==
X-CSE-MsgGUID: TzTDP3QASsGnATZ61G8kkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64013392"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:57:01 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Wupeng Ma <mawupeng1@huawei.com>
Cc: <akpm@linux-foundation.org>,  <mgorman@techsingularity.net>,
  <mhocko@suse.com>,  <dmaluka@chromium.org>,  <liushixin2@huawei.com>,
  <wangkefeng.wang@huawei.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
In-Reply-To: <20240830014453.3070909-1-mawupeng1@huawei.com> (Wupeng Ma's
	message of "Fri, 30 Aug 2024 09:44:53 +0800")
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
Date: Fri, 30 Aug 2024 15:53:28 +0800
Message-ID: <87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Wupeng,

Wupeng Ma <mawupeng1@huawei.com> writes:

> From: Ma Wupeng <mawupeng1@huawei.com>
>
> The introduction of Per-CPU-Pageset (PCP) per zone aims to enhance the
> performance of the page allocator by enabling page allocation without
> requiring the zone lock. This kind of memory is free memory however is
> not included in Memfree or MemAvailable.
>
> With the support of higt-order pcp and pcp auto-tuning, the size of the
> pages in this list has become a matter of concern due to the following
> patches:
>
>   1. Introduction of Order 1~3 and PMD level PCP in commit 44042b449872
>   ("mm/page_alloc: allow high-order pages to be stored on the per-cpu
>   lists").
>   2. Introduction of PCP auto-tuning in commit 90b41691b988 ("mm: add
>   framework for PCP high auto-tuning").

With PCP auto-tuning, the idle pages in PCP will be freed to buddy after
some time (may be as long as tens seconds in some cases).

> Which lead to the total amount of the pcp can not be ignored just after
> booting without any real tasks for as the result show below:
>
> 		   w/o patch	  with patch	      diff	diff/total
> MemTotal:	525424652 kB	525424652 kB	      0 kB	        0%
> MemFree:	517030396 kB	520134136 kB	3103740 kB	      0.6%
> MemAvailable:	515837152 kB	518941080 kB	3103928 kB	      0.6%
>
> On a machine with 16 zones and 600+ CPUs, prior to these commits, the PCP
> list contained 274368 pages (1097M) immediately after booting. In the
> mainline, this number has increased to 3003M, marking a 173% increase.
>
> Since available memory is used by numerous services to determine memory
> pressure. A substantial PCP memory volume leads to an inaccurate estimation
> of available memory size, significantly impacting the service logic.
>
> Remove the useless CONFIG_HIGMEM in si_meminfo_node since it will always
> false in is_highmem_idx if config is not enabled.
>
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

This has been discussed before in the thread of the previous version,
better to refer to it and summarize it.

[1] https://lore.kernel.org/linux-mm/YwSGqtEICW5AlhWr@dhcp22.suse.cz/

--
Best Regards,
Huang, Ying

