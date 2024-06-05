Return-Path: <linux-kernel+bounces-201643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038BE8FC131
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BC0B212DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16F84414;
	Wed,  5 Jun 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ChlzmGhg"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E576FB1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550200; cv=none; b=VMCRmgicDSR+uq9DhVP1uXWnstUOlJApbYlkOYw3phhI0UmGl8kKNSh1SXxZVOyhiVpS1okhFZZH4lZIye4FFDTOD+J3afzfjeGZb3I7qAbVmMRPTNhXVwi7o76vU9zcxdRJ+bzABN9rpKObRKK4omT/EJP9bb68H2InhrZsQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550200; c=relaxed/simple;
	bh=B7aAgCjt6WbbepssZ4AyCIiFzF8+p/RFOWUH8gVv2Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVppnviJt+jyHCZ5yJogEjZaM6pmC6WJ4+Jfb9Z77QiRXTxbxLYpH8wS1Jzo+x80OYs8iOQUq2KK2t3UtlzGl67+vNrWaCRb0Knjt4FlXUb7Jc1CkFzCMD1oawoBOXRnar1q6YC3L3DFSPkMjy6Wxl4v/ptqWFPI4B7uAD54YYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ChlzmGhg; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717550195; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Wy3xNJR1KJ+N/+Jfm1hOIO1N9m58IGwP3etp2KEF2CQ=;
	b=ChlzmGhgf6PyRwLkGmFkzlhI1Hs++Jlq4MUWVQP0qbhGpgWhXvz0P7YJwkVOs81lQkyv9cXsimFP981WijnVNS7RYMJa5LlR2c6eCNdtDPSbY2tT3pAWMQkFjsqwgn/hDkgKqjcFargphS31SkPgabRt/cnzEhJFQaKe+NSMg1U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W7sRSJ5_1717550192;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7sRSJ5_1717550192)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 09:16:33 +0800
Message-ID: <3340f80d-432c-4c71-a5bb-4a686ae052f9@linux.alibaba.com>
Date: Wed, 5 Jun 2024 09:16:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] mm: memory: extend finish_fault() to support large
 folio
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: oe-kbuild-all@lists.linux.dev, willy@infradead.org, david@redhat.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <bee11bfd9157e60aaea6db033a4af7c13c982c82.1717495894.git.baolin.wang@linux.alibaba.com>
 <202406042210.20LfqwNd-lkp@intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <202406042210.20LfqwNd-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/4 22:58, kernel test robot wrote:
> Hi Baolin,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.10-rc2 next-20240604]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-memory-extend-finish_fault-to-support-large-folio/20240604-182028
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/bee11bfd9157e60aaea6db033a4af7c13c982c82.1717495894.git.baolin.wang%40linux.alibaba.com
> patch subject: [PATCH v4 1/6] mm: memory: extend finish_fault() to support large folio
> config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240604/202406042210.20LfqwNd-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406042210.20LfqwNd-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406042210.20LfqwNd-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     mm/memory.c: In function 'finish_fault':
>>> mm/memory.c:4838:29: warning: unused variable 'i' [-Wunused-variable]
>      4838 |         int type, nr_pages, i;
>           |                             ^

Oops, thanks for reporting. Forgot to remove the variable 'i' when 
changing to use update_mmu_tlb_range().

I see Andrew has already helped to remove this unused variable 'i'. 
Thanks Andrew.

