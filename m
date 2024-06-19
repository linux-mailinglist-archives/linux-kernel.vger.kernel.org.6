Return-Path: <linux-kernel+bounces-220598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716F90E43D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4F41C2231C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B476035;
	Wed, 19 Jun 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqA2EesC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5797580C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781702; cv=none; b=XY02scucDhy48vWi6Qn0JQ7k51Uil6WDWISItWuHyeQTy3Md6rUYgDSdvlAPMWb4i5xfMDAldYt7mQ6u+LTNjNv1Jbdm6gXkdSai2wmfv88rIZCc4zd3i1zN5uMjyjxaoNRwRb9h479bDr8y3nS4pod++auNYVVTDbviEtyZYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781702; c=relaxed/simple;
	bh=5NX5iiU81yy2F1qdPkNYoivs4g/8uNde2WeXBaAV8gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pugh29HQ0GghB3FWXzodaiCxvRK4lmfbsN4rbyYPdzLgCsIl9zD6ESnbPRUNblk8J/sWmbCYcA7JM9rkDur6NHruNuk8Du9iJR1dmsfkGc8YbkGyOtuiBw8+1Cnh3L+P+5IQo0lVhEQYZorEM1/6gfivNkdRSAgGie5d+08673s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqA2EesC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718781701; x=1750317701;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5NX5iiU81yy2F1qdPkNYoivs4g/8uNde2WeXBaAV8gs=;
  b=dqA2EesCwvTjXJoPRKZ3ixD5opC6qoe6H3sYyrNr+wzc8VKf3bDr1dnG
   1LTDyaCVZvZ8dAUxNFC8/9vn/o5TQ4BGUEubVX8m32sKrS8SB8kPM3xo4
   EH9pWl7EoC7dENpNobj3xiXwqu/8SiZ9y2fl/L28bau1KbzLyeJlMOdSz
   sHq7GJkpWDNFeCcFkR87EF83wdQTruBeiB94QHHlVPYgXPRdpVKVjsXZN
   r3V4hBHZr0Kf19oFLZeedAt6sfG+WYFyyDOYwt0fi1pNxKP+Ij0hxxoEa
   Nt+38cKSSidUPM0vbeC1Z+a7FWk/+rwPWJaMrixL0cykQSBzLofqu4lN8
   A==;
X-CSE-ConnectionGUID: t13y3AXuQQ+EIqHBz3PfvQ==
X-CSE-MsgGUID: yQ9winVuTEqHLDA5WMsebw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33246286"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="33246286"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:21:40 -0700
X-CSE-ConnectionGUID: WeLi016KS06Ap6ULkPjc7g==
X-CSE-MsgGUID: 9dpHGKYFQ5OhO5xixyqfBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="41965015"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 00:21:38 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>,  Kairui Song <kasong@tencent.com>,  Kalesh
 Singh <kaleshsingh@google.com>,  Barry Song <baohua@kernel.org>,  "Hugh
 Dickins" <hughd@google.com>,  David Hildenbrand <david@redhat.com>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
In-Reply-To: <20240618232648.4090299-1-ryan.roberts@arm.com> (Ryan Roberts's
	message of "Wed, 19 Jun 2024 00:26:40 +0100")
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
Date: Wed, 19 Jun 2024 15:19:46 +0800
Message-ID: <87tthp4cx9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Ryan,

Ryan Roberts <ryan.roberts@arm.com> writes:

> Hi All,
>
> Chris has been doing great work at [1] to clean up my mess in the mTHP swap
> entry allocator.

I don't think the original behavior is something like mess.  It's just
the first step in the correct direction.  It's straightforward and
obviously correctly.  Then, we can optimize it step by step with data to
justify the increased complexity.

> But Barry posted a test program and results at [2] showing that
> even with Chris's changes, there are still some fallbacks (around 5% - 25% in
> some cases). I was interested in why that might be and ended up putting this PoC
> patch set together to try to get a better understanding. This series ends up
> achieving 0% fallback, even with small folios ("-s") enabled. I haven't done
> much testing beyond that (yet) but thought it was worth posting on the strength
> of that result alone.
>
> At a high level this works in a similar way to Chris's series; it marks a
> cluster as being for a particular order and if a new cluster cannot be allocated
> then it scans through the existing non-full clusters. But it does it by scanning
> through the clusters rather than assembling them into a list. Cluster flags are
> used to mark clusters that have been scanned and are known not to have enough
> contiguous space, so the efficiency should be similar in practice.
>
> Because its not based around a linked list, there is less churn and I'm
> wondering if this is perhaps easier to review and potentially even get into
> v6.10-rcX to fix up what's already there, rather than having to wait until v6.11
> for Chris's series? I know Chris has a larger roadmap of improvements, so at
> best I see this as a tactical fix that will ultimately be superseeded by Chris's
> work.

I don't think we need any mTHP swap entry allocation optimization to go
into v6.10-rcX.  There's no functionality or performance regression.
Per my understanding, we merge optimization when it's ready.

Hi, Andrew,

Please correct me if you don't agree.

[snip]

--
Best Regards,
Huang, Ying

