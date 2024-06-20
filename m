Return-Path: <linux-kernel+bounces-221949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1990FAFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226421C21038
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1A134C4;
	Thu, 20 Jun 2024 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElVYUtxG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CDC812
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847372; cv=none; b=F+mXmhiAdNnOzKsXCHNLHwNIu9wZ/HwEYKmrzCluAZig2/4Oom9GeiGEX/iGMhDi3ToBhUu9JhUKGmm4qCHGu/PLbkihPxWxqWHE3tCLfh73UZlDzhIsuchVp5/QYbGRdRofflE5NybQ19iOqsbLLrJiJVQ0KrhgIbwcgoQI/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847372; c=relaxed/simple;
	bh=MuG3tWGGG/ler89LdEK2mUf9s2KAAV+LwtcF+zUbd0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZCDX/K1hzusYKEw5+Bkh50t83/MsAIMHWCCnvmuu5FD5KM+ztknpJoBhLAqin7Sy2c9Flv9QSRWiQ+/XBD8Rhps+GCkvZe8GzPthXAxYA/GTzV65c/9wbucXv0w//ucPyUwZA1t7O+M3R6xjzca+UwvJLqKv7NzO+RToSqKCHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElVYUtxG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718847371; x=1750383371;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MuG3tWGGG/ler89LdEK2mUf9s2KAAV+LwtcF+zUbd0Y=;
  b=ElVYUtxG65ViA8/TsnnKcgUVfCG1YG8J4HV0Wt0hBp3LhOSkwFx4AlFk
   p5Z9sFJVdoWUCp3RubEh0jdvKyTByT51FLOig0nVY2eC2jIwSm8zEOXVF
   DVqPkUYxjZGAi+LQAr/PxnJeYDtDzXl9HtL0P8rtG4CzgR7SoA+oBEVsx
   AHIMPTbedVPo2Ik0s6FIK7+s4CZ08St0LDkKDYBWmtW4mGKVhY8KOAd3D
   VDkIBmJLnbAqcUthexaAiHEfU4RTaL6oFABZ1gfnajAf39+670KoDClHS
   RE7RQZfptRT7nHFmSC0ajwQtbXSODnBiEhKoSEXVELjBNt9sX8LGeyXng
   g==;
X-CSE-ConnectionGUID: tWr9IwRdTsuRHVqzgEtgZw==
X-CSE-MsgGUID: WC/uev7/QymlYNK1HIm19A==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15678719"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15678719"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:36:09 -0700
X-CSE-ConnectionGUID: oumdNgg9SeCa/IreWlo+eA==
X-CSE-MsgGUID: WfMEbfbMTEmCMTYOebg9iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46996389"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:36:06 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Chris Li
 <chrisl@kernel.org>,  Kairui Song <kasong@tencent.com>,  "Kalesh Singh"
 <kaleshsingh@google.com>,  Barry Song <baohua@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  David Hildenbrand <david@redhat.com>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
In-Reply-To: <f9f105d9-77ba-427c-9958-92710f70716b@arm.com> (Ryan Roberts's
	message of "Wed, 19 Jun 2024 10:17:08 +0100")
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
	<87tthp4cx9.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<f9f105d9-77ba-427c-9958-92710f70716b@arm.com>
Date: Thu, 20 Jun 2024 09:34:15 +0800
Message-ID: <878qz04ctk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 19/06/2024 08:19, Huang, Ying wrote:
>> Hi, Ryan,
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> Hi All,
>>>
>>> Chris has been doing great work at [1] to clean up my mess in the mTHP swap
>>> entry allocator.
>> 
>> I don't think the original behavior is something like mess.  It's just
>> the first step in the correct direction.  It's straightforward and
>> obviously correctly.  Then, we can optimize it step by step with data to
>> justify the increased complexity.
>
> OK, perhaps I was over-egging it by calling it a "mess". What you're describing
> was my initial opinion too, but I saw Andrew complaining that we shouldn't be
> merging a feature if it doesn't work.

I don't think it doesn't work.  It just works well for some workloads,
but doesn't work well for some other workloads.  We can always improve
the implementation to make it works better for more workloads.

From another point of view, even with your and Chris's improvement, mTHP
swap entry allocation will fallback for quite some workloads.

Use page allocator as an example.  Even in current kernel, THP allocation
may fallback for quite some workloads because of page fragmentation.
But I don't think THP doesn't work now.

> This series fixes the problem in a minimal
> way - if you ignore the last patch, which is really is just a performance
> optimization and could be dropped.
>
> If we can ultimately get Chris's series to 0% fallback like this one, and
> everyone is happy with the current state for v6.10, then agreed - let's
> concentrate on Chris's series for v6.11.

[snip]

--
Best Regards,
Huang, Ying

