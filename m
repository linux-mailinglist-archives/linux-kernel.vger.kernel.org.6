Return-Path: <linux-kernel+bounces-188966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A899F8CE91E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B150E2823B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5212EBE2;
	Fri, 24 May 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeXpyq5L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261F12C460
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571007; cv=none; b=niVRT2JY8SsEqS4lTdxqN/CNYnT4i/X5RuYpaolab/FEw0NFgGhlKYBcGkbk+8vKf+96LcV58M5vboHKRoll6qqJXlkzeMd8E/RkPUM4t2Xd/ugwFfoidGhe2OI2jWbhuZ7c3h275R/bva6vauOe7C/9jsr6G8MUDFGE+6w7nXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571007; c=relaxed/simple;
	bh=fgqt50EO1ZSclEoqjtlJo4WQ5WUzjv+CTx8jKXMYmVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epdC+bPTAUEH8OeVcDF96yIRln6sxXb2nnEV/haIxg0SGMH07dDoHAKM5bHm3xiR3ThlkjhmNiYEaDoO/t94JzQh/f0bXo+9z+RvYpuYDsUw3byU44A8yOe7zTvxNUkcnzLyqvNdW21R/4hl64Jv+j0z+xiMPy3BMbrdIczVsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeXpyq5L; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716571006; x=1748107006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fgqt50EO1ZSclEoqjtlJo4WQ5WUzjv+CTx8jKXMYmVc=;
  b=LeXpyq5LG0JqKllDChU5JJK8Jo25XRMX/g6bkPGy75cwtEaAzsORXBel
   96lw7d3gamuRwRE217dPSkqAuZi5cpn7AO8Aq61W4HjbxVGY/cEf1Av+F
   8QjBewG+t9jZtG+2KnsetIJoD5a/1gV+AbBZcAB3j42rxNTErbbWJJzGa
   VBXFiJ5WbbvuC4GN8JkSWjA2EC10JIxdLRBF57sHzhT21hF0H3eXeP0TO
   b5eDAcYG4dxx+PAiR8hqshUD1RpKzGJVPSY/hX4ybN/7d71U8zAXrNguF
   YSG6q0aaT+sGT9F1kf9Y7Dmr2b/888JBEAc8zt+GsAu+S+e0a7miTdvLZ
   Q==;
X-CSE-ConnectionGUID: MnijglncQ2COgh3aXbrcGg==
X-CSE-MsgGUID: hz4Hn7OvSQK8Kkgx0QpdRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="12898209"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="12898209"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 10:16:41 -0700
X-CSE-ConnectionGUID: A2uDE7CXTFqPqgJTWs4a4w==
X-CSE-MsgGUID: GUTIiLWcSjWUBMGg8FnWvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="34102877"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 10:16:40 -0700
Message-ID: <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
Date: Fri, 24 May 2024 10:16:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers over
 90%
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org, ying.huang@intel.com,
 vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
 willy@infradead.org, david@redhat.com, peterz@infradead.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240510065206.76078-1-byungchul@sk.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/24 23:51, Byungchul Park wrote:
> To achieve that:
> 
>    1. For the folios that map only to non-writable tlb entries, prevent
>       tlb flush during unmapping but perform it just before the folios
>       actually become used, out of buddy or pcp.

Is this just _pure_ unmapping (like MADV_DONTNEED), or does it apply to
changing the memory map, like munmap() itself?

>    2. When any non-writable ptes change to writable e.g. through fault
>       handler, give up luf mechanism and perform tlb flush required
>       right away.
> 
>    3. When a writable mapping is created e.g. through mmap(), give up
>       luf mechanism and perform tlb flush required right away.

Let's say you do this:

	fd = open("/some/file", O_RDONLY);
	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
	foo1 = *ptr1;

You now have a read-only PTE pointing to the first page of /some/file.
Let's say try_to_unmap() comes along and decides it can_luf_folio().
The page gets pulled out of the page cache and freed, the PTE is zeroed.
 But the TLB is never flushed.

Now, someone does:

	fd2 = open("/some/other/file", O_RDONLY);
	ptr2 = mmap(ptr1, size, PROT_READ, MAP_FIXED, fd, ...);
	foo2 = *ptr2;

and they overwrite the old VMA.  Does foo2 have the contents of the new
"/some/other/file" or the old "/some/file"?  How does the new mmap()
know that there was something to flush?

BTW, the same thing could happen without a new mmap().  Someone could
modify the file in the middle, maybe even from another process.

	fd = open("/some/file", O_RDONLY);
	ptr1 = mmap(-1, size, PROT_READ, ..., fd, ...);
	foo1 = *ptr1;
	// LUF happens here
	// "/some/file" changes
	foo2 = *ptr1; // Does this see the change?



