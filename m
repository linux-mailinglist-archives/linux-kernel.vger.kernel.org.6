Return-Path: <linux-kernel+bounces-390140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B039B7613
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC21285481
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7855D1531C0;
	Thu, 31 Oct 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKLZoSdV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9614B976
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362170; cv=none; b=WPBVfWYM+V1U/RDRbK3Se8aL+HlkIg7OAaRSVFFL4Qe6jnqjueA/1+lRCtt++R1epDOdzTWX/KpRIz65G1xiFdVrmkYOLiZyt+IzKBUZaFmGxK4eyCG4PoTZIoN9EQUrhk6l2mJ9lzP4dUvMd7hrOFvu9NgjVarAcpg9D1Tz4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362170; c=relaxed/simple;
	bh=OduQWEYzeSln40DXDvJmmJDTyUAxtKw1X3u8GoAzHnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/6nHsbcwEM/F4tlCxsG4u8024MNpMa+u8pUm5n1kB7qowc8isKKwsa0d8gyLlo3lBz3dOjL81yLpzevx/TFcfb4UIPQ95fYcU7Ccv/NaNHKuO0aUae3z2pwnJOqRnuCXceHXP+bX/vzclSfPJtSJGPHb+ol4/pVgPpZOQGm0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKLZoSdV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730362168; x=1761898168;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OduQWEYzeSln40DXDvJmmJDTyUAxtKw1X3u8GoAzHnw=;
  b=oKLZoSdVXydR0ZgNd2w0ofrrbb45ghnJ8mfqFCw2UQ6ymltk2lfEO77I
   M1u79qafYC7/6iJKzdAwUM8FC2W0exg7wvPrlrnl5xIJDy4QwASk9rxdB
   p+5Wv9Df2pvWVoHSMU8JTDetN+o/gHs8WU1Oo1O7vQ+RtFDgb8UYc9HC3
   1ZWeRgwoERXiNiQDxKQi9Dzzo5daW2arsLoxZH7D1Ko51mCQvSVwVyu6H
   H4m+tmNR2O2jyUaKTlAG1bQsEBSiInrYw9XH/2Qj3C2vPmXvBt6CYKyAg
   J20cNYXAwPXFhh/ZH4JY5KfezaVAuFDCyDGQVQq6Xcqe9Fj+VXlhM8OZH
   A==;
X-CSE-ConnectionGUID: aZByH0o+Sv62Va8w34FbAg==
X-CSE-MsgGUID: xbszlRaxTHu9GHn0NYPx8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41479453"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="41479453"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:09:26 -0700
X-CSE-ConnectionGUID: e9w6h8c+T0+M0WD44OQ4Bw==
X-CSE-MsgGUID: E+61GCXYRzaAVQZHcBLltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82469816"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:09:23 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,  David Hildenbrand
 <david@redhat.com>,  Chris Li <chrisl@kernel.org>,  Yosry Ahmed
 <yosryahmed@google.com>,  Kairui Song <kasong@tencent.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Kanchana P Sridhar
 <kanchana.p.sridhar@intel.com>,  Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH v3] mm: add per-order mTHP swpin counters
In-Reply-To: <20241031075325.1037-1-21cnbao@gmail.com> (Barry Song's message
	of "Thu, 31 Oct 2024 20:53:25 +1300")
References: <20241031075325.1037-1-21cnbao@gmail.com>
Date: Thu, 31 Oct 2024 16:05:49 +0800
Message-ID: <874j4sae8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> This helps profile the sizes of folios being swapped in. Currently,
> only mTHP swap-out is being counted.
> The new interface can be found at:
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin
> For example,
> $ cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
> 12809
> $ cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
> 4763
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> ---
>  -v3: minor refine changelog per Huang, Ying. thanks!
>
>  Documentation/admin-guide/mm/transhuge.rst | 4 ++++
>  include/linux/huge_mm.h                    | 1 +
>  mm/huge_memory.c                           | 3 +++
>  mm/page_io.c                               | 3 +++
>  4 files changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 2a171ed5206e..5caa3fb2feb1 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -534,6 +534,10 @@ zswpout
>  	is incremented every time a huge page is swapped out to zswap in one
>  	piece without splitting.
>  
> +swpin
> +	is incremented every time a huge page is swapped in from a non-zswap
> +	swap device in one piece.
> +
>  swpout
>  	is incremented every time a huge page is swapped out to a non-zswap
>  	swap device in one piece without splitting.

In Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage, I
found

"
What:		/sys/kernel/mm/transparent_hugepage/
Date:		April 2024
Contact:	Linux memory management mailing list <linux-mm@kvack.org>
Description:
		/sys/kernel/mm/transparent_hugepage/ contains a number of files and
		subdirectories,

			- defrag
			- enabled
			- hpage_pmd_size
			- khugepaged
			- shmem_enabled
			- use_zero_page
			- subdirectories of the form hugepages-<size>kB, where <size>
			  is the page size of the hugepages supported by the kernel/CPU
			  combination.

		See Documentation/admin-guide/mm/transhuge.rst for details.
"

So, Documentation/admin-guide/mm/transhuge.rst will be used as ABI
document?

[snip]

--
Best Regards,
Huang, Ying

