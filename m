Return-Path: <linux-kernel+bounces-250119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C092F470
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3373128329B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631171078F;
	Fri, 12 Jul 2024 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MvJ6mJj1"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155FDDDC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720755368; cv=none; b=KpZulrw5ajvUkSHA7SgQy7BWus6zeKNSmdhKvQaesmaRwSfF7R2MhBMwjJp1/CjzzvFO6oEzsStMkNA9MvhQDEg4t0xoaXBZ9XGlocBL5AaKzjQFBfTC02AmbxQNO34r2MNS+2CGOBG5rsWVVxhzYAbNBRj2/giUteZM4sIIpiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720755368; c=relaxed/simple;
	bh=VRyGjFQolawRZImK+IOGOg0G+EPEMAJ0J9NsIWlAf8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbxZ6qy2AlBiT2b3lZGqnAhw8FyLeZQgMSEsEXxEb5YIpIu5cvuQ8+sMFbPbD52loYy3IYMrPkWYGKLDwNfBVYK/mKdJMlrmnV239qxJ/x4oB8crGbboR7VZhRMM6jL7mC5f4fKxZDCpG9l2aRZz+lHdKeRhNojmZiYngKSCr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MvJ6mJj1; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720755363; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zj6wPj6Zh6XgSISd6AOm8AXZp2rbbWBD8O1Iq+f1CSU=;
	b=MvJ6mJj1kMxhpyeQqIavw8N3oK4M+zjKIAUdScXky4ZvdF1tqqQ8rKxDKUT7cXYc5yceEsLV2e8wrhbNSEmTK8Ne3Sw27AjkyolUnddsaMua1ztYJBmXmiAzOJ/AxHCW9hFGacuMn7NGT4wnRFKQPHWHli6eh4XNmlytav9RUVk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WAMhTxo_1720755361;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAMhTxo_1720755361)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 11:36:02 +0800
Message-ID: <8066aaff-e7df-42fa-8142-d7cb22af3835@linux.alibaba.com>
Date: Fri, 12 Jul 2024 11:36:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm: shmem: move shmem_huge_global_enabled() into
 shmem_allowable_huge_orders()
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, willy@infradead.org,
 david@redhat.com, 21cnbao@gmail.com, ryan.roberts@arm.com, ziy@nvidia.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <6e5858d345304d0428c1c2c2a25c289c062b4ea8.1720668581.git.baolin.wang@linux.alibaba.com>
 <202407121052.Jbq6PSIi-lkp@intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <202407121052.Jbq6PSIi-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/12 11:10, kernel test robot wrote:
> Hi Baolin,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on next-20240711]
> [cannot apply to linus/master v6.10-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-shmem-simplify-the-suitable-huge-orders-validation-for-tmpfs/20240711-134512
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/6e5858d345304d0428c1c2c2a25c289c062b4ea8.1720668581.git.baolin.wang%40linux.alibaba.com
> patch subject: [PATCH 3/3] mm: shmem: move shmem_huge_global_enabled() into shmem_allowable_huge_orders()
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240712/202407121052.Jbq6PSIi-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407121052.Jbq6PSIi-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407121052.Jbq6PSIi-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> mm/shmem.c:1160:6: error: call to undeclared function 'shmem_huge_global_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      1160 |         if (shmem_huge_global_enabled(inode, 0, false, NULL, 0))
>           |             ^
>     1 error generated.

Thanks for reporting. I forgot to add a dummy function in case 
CONFIG_TRANSPARENT_HUGEPAGE is not enabled. Will fix in next version.

