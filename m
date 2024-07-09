Return-Path: <linux-kernel+bounces-245646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08C92B570
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8312283875
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0EF156967;
	Tue,  9 Jul 2024 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyewVVfs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E42E62D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521299; cv=none; b=tFacp2VSrPqsvIKXpGEnxCwQTp7txNvPD1dI/R8KGSSO4KFk7q9AQfXo976CIZzBFheusdwOmeuWtpmd4IHzZ8f+tlbpLnbXvI2u+hedNdrS5RfZ3aKCuej+JX1b+2AJuh//aNv/gGOI7Ijc5N4662WiEUQLJhjNWY1FwfXIgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521299; c=relaxed/simple;
	bh=3P2DFYn1DBKMPF40DT1RbJd0AgqHL2WhUpStkH84zJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxnAxN2E0mWWPVxG9pNqCM+AY51I2sYam3/fUcJ+hVJ6xRcVcx1kENM1yedrTZs/ivRMD2G02QL85CoKzoYJ7pqwyWp3ZUPrpxwXUxzf3LlUQs79zMxRpYIgShc8DX4P6+Uy2soCFmVjdp/1CLqFL9NhD8ak8QTiPvPM6gOKCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyewVVfs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720521298; x=1752057298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3P2DFYn1DBKMPF40DT1RbJd0AgqHL2WhUpStkH84zJI=;
  b=cyewVVfsBqeJM+BZWaxjRqciXoSEEyiJH4WTnafLDOetWmDqhcMh1WmA
   rJUS2GOdFd3qIe9TSP4DuYrWGDF0iPaUQmlRRo7o6tJOf8GePBbq9+o+t
   5Fdl4oRgc0xGvyOxmArXWVcRbaE9a1/ZFV5L+18LFuM5khU6ijRvmqtVn
   tgLUsdsaXOy5a14D57Z3TTXflTIe6GvN/3oWg0P+m1pYwHE5544skv+V/
   aebKHHTWoFoQWCbpi+45kaHaM3VybaLIYKz1s3BqWB0S5ow/8rKjL5WNp
   huf3urBWEMblJcoiSXTddmBwalSTaMaWrnLZgShHY+L8E3exRHC1k4HBT
   A==;
X-CSE-ConnectionGUID: F1uTROpPQeeYB2Nhj67ViQ==
X-CSE-MsgGUID: KOxMg7bURqeMs7xOLUIB6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="12449716"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="12449716"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 03:34:58 -0700
X-CSE-ConnectionGUID: pDxVPSVaSYyj7rLcSun4KA==
X-CSE-MsgGUID: gR3cPS93So+DFacnnGLSUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="52216252"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 03:34:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9B18215B; Tue, 09 Jul 2024 13:34:53 +0300 (EEST)
Date: Tue, 9 Jul 2024 13:34:53 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Tony Battersby <tonyb@cybernetics.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: Ensure
 generic_hugetlb_get_unmapped_area() returns higher address than
 mmap_min_addr
Message-ID: <kbypmoemiq43kuok7c3f3rxhzigpva6ov7ua2wfblkjmaccyes@6k4b37lj7msd>
References: <20240709092122.41232-1-donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709092122.41232-1-donettom@linux.ibm.com>

On Tue, Jul 09, 2024 at 04:21:22AM -0500, Donet Tom wrote:
> generic_hugetlb_get_unmapped_area() was returning an address less
> than mmap_min_addr if the mmap argument addr, after alignment, was
> less than mmap_min_addr, causing mmap to fail.
> 
> This is because current generic_hugetlb_get_unmapped_area() code does
> not take into account mmap_min_addr.
> 
> This patch ensures that generic_hugetlb_get_unmapped_area() always returns
> an address that is greater than mmap_min_addr. Additionally, similar to
> generic_get_unmapped_area(), vm_end_gap() checks are included to ensure
> that the address is within the limit.

checks are included to maintain stack gap.

> 
> How to reproduce
> ================
> 
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/mman.h>
>  #include <unistd.h>
> 
>  #define HUGEPAGE_SIZE (16 * 1024 * 1024)
> 
>  int main() {
> 
>     void *addr = mmap((void *)-1, HUGEPAGE_SIZE,
>                  PROT_READ | PROT_WRITE,
>                  MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>     if (addr == MAP_FAILED) {
>         perror("mmap");
>         exit(EXIT_FAILURE);
>     }
> 
>     snprintf((char *)addr, HUGEPAGE_SIZE, "Hello, Huge Pages!");
> 
>     printf("%s\n", (char *)addr);
> 
>     if (munmap(addr, HUGEPAGE_SIZE) == -1) {
>         perror("munmap");
>         exit(EXIT_FAILURE);
>     }
> 
>     return 0;
>  }
> 
> Result without fix
> ==================
>  # cat /proc/meminfo |grep -i HugePages_Free
>  HugePages_Free:       20
>  # ./test
>  mmap: Permission denied
>  #
> 
> Result with fix
> ===============
>  # cat /proc/meminfo |grep -i HugePages_Free
>  HugePages_Free:       20
>  # ./test
>  Hello, Huge Pages!
>  #
> 
> V2:
> Added vm_end_gap() check.
> 
> V1:
> https://lore.kernel.org/all/20240705071150.84972-1-donettom@linux.ibm.com/
> 
> Reported-by Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Please use "hugetlbfs:" as subject prefix. No need to spell out full path.

Otherwise,

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

