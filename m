Return-Path: <linux-kernel+bounces-563359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661D3A63FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DABD16E8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F9219303;
	Mon, 17 Mar 2025 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="To2zotj1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D71218E96
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742189662; cv=none; b=UXSHQ1cJ081c0tMKlB3la/8+F2Kwg8pGY9wvAGYWk94edTy0ax8NtBd91W3ArmzpBwyKy1VEJ94bSBMWsNQC9Us4FyfZojh2ZwztzRUpL6MePokaquha1K+uoH3SdHbQ2XmepSmQGNKTR4ciRR0RqlPvuD1txMADSUX8qqUmUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742189662; c=relaxed/simple;
	bh=SPOSJLEimivS+ZLN9l6+WYlamjrqwtKjwdzaxUUNrlg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uH077FHh1PrQWEFp8CPkJPVMK2WyXch1lWgx7wHsXX238qY5om6eL597LNFD1f1Qg2lxNhKTz697M/lZOhOH+uH2YiBJGi5mQr2/WrtcLhVs9C4KdWxxmZdeN/x+CbDvT5Z1D3mkoboKKJFTe4OFVco6knHh/jPTbxg0yJQOoYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=To2zotj1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742189661; x=1773725661;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SPOSJLEimivS+ZLN9l6+WYlamjrqwtKjwdzaxUUNrlg=;
  b=To2zotj1HKSZxS1qV5kDu8Bh5WvnYp1fg2VPp68EyvCTX9qmuJkGN/2J
   iHTwB6NoxK230hMbJxVRqGx1Yqd3YidxgeUQvylakhBHQlLQmRbLffeLr
   f+TKjeZAYQOzX4qfyjPaKd5QFpkDnPp4Q6N5Sg97iZlpSKTWL6k65QhiZ
   aBZb4vII/miWknOjRQXa80fzNQoLdDp1dPoBk3zibqVYf3hSusZW0eLh6
   DKUzsh8WFmCgO46p/auioDbY5ZTdpBeCmGJKFYhaod2lKM2JY1NYQRiCQ
   GZyjkh9OQI2wS95cHbqQ6VbR17ZBoldv0AHTlU1pWeGXbNMJc7GJs75X0
   g==;
X-CSE-ConnectionGUID: jyNlms+0RC6s5JBg4r1QOw==
X-CSE-MsgGUID: TwlNlawTSlGffXxJqtHDuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="54646084"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="54646084"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 22:34:10 -0700
X-CSE-ConnectionGUID: 1pTgq5ilRRqfmV2zPcyG4Q==
X-CSE-MsgGUID: miYrzQDUQ2arH3JPugCg1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="121554714"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.136]) ([10.238.232.136])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 22:34:07 -0700
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: Huan Yang <link@vivo.com>, hch@lst.de
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com,
 rppt@kernel.org, ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com
References: <20250312061836.GA12841@lst.de>
 <339b0c1f-ce90-449f-a1fc-2656d5a1115c@vivo.com>
From: Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <79247edd-761c-82e3-b8d2-acdbe31c8205@linux.intel.com>
Date: Mon, 17 Mar 2025 13:29:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <339b0c1f-ce90-449f-a1fc-2656d5a1115c@vivo.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit


On 3/17/25 10:12 AM, Huan Yang wrote:
> HI Christoph,
> 
> Thanks for your reply, and I'm sorry for my late reply. Your response
> didn't appear in my email client; I only saw it on the website.:(
> 
>>> On Wed, Mar 12, 2025 at 02:15:12PM +0800, Huan Yang wrote:
>>> When invoke vmap_pfns, it call vmap_pfn_apply to set pfn into pte. >> It check pfn is valid, if true then warn and return. >> >> This is 
> a mischeck, actually we need set a valid pfn into pte, not an >> invalid pfn. >
>> As just discussed this is wrong.  vmap_pfn is for mapping non-page
> Thank you for your explanation. I now understand that the design of vmap_pfn
> is indeed intentional. It's design to do this.
>> PFNs and the check is what enforces that.  What is the point of having
>> that detailed discussion if you just send the broken patch anyway with
>> a commit log not even acknowledging the facts?
> Sorry for that.
> 
> We now have a new use case where, in udmabuf, memory is passed via memfd and can
> be either shmem or hugetlb.
> When the memory is hugetlb and HVO is enabled, the tail page's struct is no longer
> reliable because it has been freed. Can't use vmap.
> Therefore, when making modifications, I recorded the pfn of the folio base pfn + offset and called vmap_pfns.
> And, these pfns are valid. So rejected by vmap_pfns.
> 
> Can we just remove pfn_valid check in vmap_pfns, so make it suit for both of they?
> If you agree, I wanna send a new patch.

Huan,

Why not update udmabuf to make it work with both vmap_pfns() and
vmap()? As only the udmabuf knows it is actually working on?

I don't think it's a good idea to hack the common API, the WARN_ON()
is really a mandatory check, and current case is a good example.

> 
> Thank you,
> Huan Yang
> 

-- 
Best regards,
Bingbu Cao

