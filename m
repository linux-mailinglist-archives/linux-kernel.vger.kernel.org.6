Return-Path: <linux-kernel+bounces-252636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB7931625
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85948B211B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3818E763;
	Mon, 15 Jul 2024 13:55:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C231741CF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051755; cv=none; b=bViqSrhg+kXKaxc2TBGZWm0UrQ8pkhExGatk4m4bIg2GMe7xQLsINDVTngyX2a68cxMpaFPvFukiudaAldF3G/QQix1YByTDSoKp/EgmtbPZwtXD8aWhTtDjIPKFE2rbFQ6nJsZb5lDswhdWf1KDpG3QGyT17u8fiUV0oQb0p7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051755; c=relaxed/simple;
	bh=o7SPAJO8iOMaSTIdeOb07rqXUTWi+XHsVu4Xl9ncQP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFxp+lJYX5q8xYhmF4l/YduvzHifhrKUvDHyS6yMXHn1af+qw5ckExICQMAugxRZXxp0zL7hI5WY5fbnu/HdPbi+ycuB30CSTy67rJJYz9nQ5ivhq9Hnd+zex529lRFA34zhMI61HkxXK0KRN1ynTAOPzN+i2La38UB2hhDdXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DEC2DA7;
	Mon, 15 Jul 2024 06:56:18 -0700 (PDT)
Received: from [10.57.77.136] (unknown [10.57.77.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 116DD3F766;
	Mon, 15 Jul 2024 06:55:50 -0700 (PDT)
Message-ID: <aab4c18a-a30e-482d-9c4b-9ae04840881a@arm.com>
Date: Mon, 15 Jul 2024 14:55:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <20240711072929.3590000-3-ryan.roberts@arm.com>
 <202407130620.DbyYULnj-lkp@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202407130620.DbyYULnj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 23:44, kernel test robot wrote:
> Hi Ryan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on next-20240712]
> [cannot apply to linus/master v6.10-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-Cleanup-count_mthp_stat-definition/20240711-154455
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240711072929.3590000-3-ryan.roberts%40arm.com
> patch subject: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240713/202407130620.DbyYULnj-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407130620.DbyYULnj-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407130620.DbyYULnj-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):

[...]

>>> ERROR: modpost: "mthp_stats" [fs/btrfs/btrfs.ko] undefined!

I'm assuming this last line is the problem one? I can't reproduce this following
your instructions and I can't see any issue based on inspection. Is it possible
this is a false positive?

Thanks,
Ryan


