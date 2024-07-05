Return-Path: <linux-kernel+bounces-242479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC092889E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4719D2849D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46091144D2B;
	Fri,  5 Jul 2024 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m20HrPY7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B4149DE3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182198; cv=none; b=RcWoARB/afJyuK2d1O0UT1RQTDkYMBPZme6grXvcNH6OH0xP8oYE1hbAXDDcZgkh5mYZLQAQjxQUu4mL7tc1SAMrXERfq9quCkD76/sqa65LZ/KUb2lmyV+SeKDPnufqYGKa+Vo4FH0Lu9e93XO3k62eFv8xNjsNMC9WYQlwRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182198; c=relaxed/simple;
	bh=x/n++De4icayafQhuBtAEpliZtdcRpQ8wL4f3sJ4144=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFUQrsFFHE8vFsJ5/ZF0r20faVBRAhhiEL9E0pzvP0Xs3ALAcrXVwHg8ZsRZjYuajEsWXczqeMbIkt9N0Ar7R+9wsJsK3gxFgdCEzLNHGGOTMuPbL8cCCLCSweQEVw9tAaE6Uj0l468KDnjoGbQAU2TlywxgyPIr4kXYPo3BK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m20HrPY7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720182196; x=1751718196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x/n++De4icayafQhuBtAEpliZtdcRpQ8wL4f3sJ4144=;
  b=m20HrPY74+AIkJmTmTG4iVuocl6+w2b+EkN9na7he1fl9AosQLTE/F5c
   93xzY/Ip7T6Jkq5HFg7OHsfmq+fZJLRNA7JcEBaifCqhT/th4SPKCeFcd
   yKQ0uaIk8NR9ita9JqDbOgsutWTF9EXyM471p5MEnFjMoVOt+V8nVkDfR
   5boMHWHD/y9knzhxxEEZ+mCMTiNm1t5MQPrUpjzjqgBPiMdAu9XUX9i7Y
   EvRr3c4FSn5QEF0ElVggk9kpMOjXmezx7KHagIKycuzbtbacHplvct0LA
   WnRrGFKhkkt5wfBcxtMbPKKqFr2aSj9sL6NmRSkIt1gHv+aDB4XJW4cCa
   w==;
X-CSE-ConnectionGUID: VKd8z496RI+Qhupxd+Rbxw==
X-CSE-MsgGUID: MfnMnmlMTUeiEjbTAG8blw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17604035"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17604035"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:23:16 -0700
X-CSE-ConnectionGUID: /FIIEb0NQUqsLCH5FRLEzg==
X-CSE-MsgGUID: v6ZIHCviT266Fy4Yj62F2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46931636"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 05 Jul 2024 05:23:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 95453914; Fri, 05 Jul 2024 15:23:11 +0300 (EEST)
Date: Fri, 5 Jul 2024 15:23:11 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Tony Battersby <tonyb@cybernetics.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, jj@black.fi.intel.com
Subject: Re: [PATCH] fs/hugetlbfs/inode.c: Ensure
 generic_hugetlb_get_unmapped_area() returns higher address than
 mmap_min_addr
Message-ID: <n5jwq5uq3hrgu3ksyg34tjtl3hw5izpc5s5lac4pkjfjt2tf22@co5rgjcznsma>
References: <20240705071150.84972-1-donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705071150.84972-1-donettom@linux.ibm.com>

On Fri, Jul 05, 2024 at 02:11:50AM -0500, Donet Tom wrote:
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 412f295acebe..428fd2f0e4c4 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -228,7 +228,7 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  	if (len & ~huge_page_mask(h))
>  		return -EINVAL;
> -	if (len > TASK_SIZE)
> +	if (len > mmap_end - mmap_min_addr)
>  		return -ENOMEM;
>  
>  	if (flags & MAP_FIXED) {
> @@ -240,7 +240,7 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	if (addr) {
>  		addr = ALIGN(addr, huge_page_size(h));
>  		vma = find_vma(mm, addr);
> -		if (mmap_end - len >= addr &&
> +		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
>  		    (!vma || addr + len <= vm_start_gap(vma)))
>  			return addr;
>  	}

There's more difference with generic_get_unmapped_area() than what you are
fixing. I think we also need vm_end_gap() here.

Hugetlb code duplication is annoying.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

