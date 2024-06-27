Return-Path: <linux-kernel+bounces-231769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE0B919DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920AD2827EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1613FF9;
	Thu, 27 Jun 2024 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAO89mXe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBA1171C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457606; cv=none; b=u7xGZp94BOj9D99d1QFStoAzy9baxceR49CUpn9vn7hkdZh25yeQVEy6I4MLpGeeg72AXRPUo7jgbGpbT+YnNsBlFjjzlNiK91U6RywnJXVVFxwSCfDxIcyP5yZYTlMJzQiPqJvRP4SD89gZiZsd8BQsQlTdAnNolGcqBzbeqYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457606; c=relaxed/simple;
	bh=m20LtT3zH1rzWB1D7Km3gbP09DhEv34gcr+Vpi2RTgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jRsweDk3mfqzybf28frSgmzwkdkGR6VrTeHhsMBoxqlALc8duJRT5R273pUatJe0RIV6UMeW7Wi5RVsCq67BqDyUsMzM83egb8o7G7n9A10hkHxIJf5Px6o+lvurRDIQao7oH1Ipgtka33Ff9Jd5kjrZqlx3s/hKoZXPdc70eOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAO89mXe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719457605; x=1750993605;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=m20LtT3zH1rzWB1D7Km3gbP09DhEv34gcr+Vpi2RTgc=;
  b=eAO89mXeokyiKfd12Pad82lZVYIs04mcHjCEMi+VDC9DpoWiaB0HNOFn
   hEB7j9/Az+vTV319Yl807rxgpSjeY4T9RwXgmhIXXI0whuzj1QSyr0b4g
   yfkvjxIy0drFFOqzhF06wquvSw8mtEoLiEQtRqaxNzNvGMG5QkXsAuIpM
   1jLkak7M4YwSI5djSZyIemZ+fjU6wak/73Vpbiu4Rv+4xyVMXTncWuXYw
   sOmhmnFRaF0TVKD5oBXIG8L8DB0IdhyTsSD6sXGU/amdZFZsYFGZrS+2G
   EHzB4Z2LZuj91kjJKvPIvEy/l3Kw7Ei7arwsf5LamL+8PDYa2USOb4rid
   A==;
X-CSE-ConnectionGUID: 2JwZNfo4QveLs3hEkaC3mQ==
X-CSE-MsgGUID: JXI3//6eTAiLAr4IWkm1Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16691910"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16691910"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 20:06:45 -0700
X-CSE-ConnectionGUID: tfrjDlomSv2iIUNwnug9Dw==
X-CSE-MsgGUID: p1YwwIuBS0Wqen2b4xFs3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44126371"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 20:06:41 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Tvrtko Ursulin <tursulin@igalia.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com,  Mel Gorman
 <mgorman@suse.de>,  Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar
 <mingo@redhat.com>,  Rik van Riel <riel@surriel.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,
  Dave Hansen <dave.hansen@intel.com>,  Andi Kleen <ak@linux.intel.com>,
  Michal Hocko <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
In-Reply-To: <9355e4b3-9892-4e5c-9288-103c93bd3bca@igalia.com> (Tvrtko
	Ursulin's message of "Wed, 26 Jun 2024 12:51:08 +0100")
References: <20240625132605.38428-1-tursulin@igalia.com>
	<87r0ckozs4.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<9355e4b3-9892-4e5c-9288-103c93bd3bca@igalia.com>
Date: Thu, 27 Jun 2024 11:04:49 +0800
Message-ID: <87ikxvozla.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Tvrtko Ursulin <tvrtko.ursulin@igalia.com> writes:

> On 26/06/2024 09:48, Huang, Ying wrote:
>> Tvrtko Ursulin <tursulin@igalia.com> writes:
>> 
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> If a task has had MPOL_F_NUMA_BALANCING set it is useful to show that in
>> IIUC, MPOL_F_NUMA_BALANCING works for VMA area via mbind() too.
>
> Ah okay.. I think I forgot to actually check and went by what commit
> text of bda420b98505 said, which is probably outdated.
>
>>> procfs. Teach the mpol_to_str helper about its existance and while at it
>>> update the comment to account for "weighted interleave" when suggesting
>>> a recommended buffer size.
>> Otherwise LGTM, Thanks!
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> Thank you! Would you have an idea of which tree this should go to aka
> which maintainer to ask to merge it?

You can use scripts/get_maintainer.pl in kernel source tree to find out
the maintainer.  And IIUC, Andrew Morton is the maintainer for this.

> Second question - I also have a patch which enables choosing balancing
> for tmpfs (mpol_parse_str) but I am unsure of its value. It would make
> things symmetrical, but is there some other benefit I don't know. Any
> thoughts on this?

I am not familiar with tmpfs NUMA policy, after checking the source
code, my understanding is that the change may have user visible effect.
For example, you can mount tmpfs with numa balancing enabled/disabled
and check whether pages can be balanced among NUMA nodes.

[snip]

--
Best Regards,
Huang, Ying

