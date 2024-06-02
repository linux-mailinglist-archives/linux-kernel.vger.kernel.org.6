Return-Path: <linux-kernel+bounces-198127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386E78D73BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 06:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652991C20F9E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 04:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D04CA7D;
	Sun,  2 Jun 2024 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lL+ACjZN"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FABA46
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717301820; cv=none; b=uLFY1WsNQgEm52dEm3lUIDifKk/jhRFV6bOepCodtuOduAxH0iychrsJ9iP69soBvevJKmoUp98drb051kP68rPyj0QKoso59t2NxHG44iwK5+CPeSQozd7fhTwNIuWwgFm6Pwu9zynMmLk7iIaO5d7PJVOWR7iyku0fQNzpn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717301820; c=relaxed/simple;
	bh=JNWq8IPKk7PrsPl7hktkVKNVpVOyMrlNF/BTNAohg/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWmLVE+XaXTXv87EaWWk4jNJPVsgX9SmOFnWxuUIl6sow4Mqs0Q6q5vGEfjohCD2pMpNIP+91Ga0etvLK7uLzAYWSu5eGEzofCss1PdF3jEP6ZqvPVqvhFcvd9p2njyQ/6XXSznT85/y6O7JK3XC781bq5R0i3A4+kJywoAFkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lL+ACjZN; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717301810; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BBVFMf4e3TqS0Oa0nQR45WmAiVghu2BOQgzSAUs3Mfg=;
	b=lL+ACjZNxPy2XiZsFWu+h3zBUpeBMsQWF1s3Cc84C1Ga+iIkgtF2tFW6pB/XQrT8OJj5V5JmpzCAkTI0Qno+PvRwJD1iHlNIK/o+vK5MVaBCpOCstQmoROKHdCKE4ScniX8Rf58yF9MWWtneaXwPZ1yPhdScKAL79kcyPK7fTVU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W7do2aW_1717301742;
Received: from 192.168.0.106(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7do2aW_1717301742)
          by smtp.aliyun-inc.com;
          Sun, 02 Jun 2024 12:16:49 +0800
Message-ID: <515fba2a-342e-4d8b-85c2-a89038a0c4e0@linux.alibaba.com>
Date: Sun, 2 Jun 2024 12:16:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: shmem: add mTHP support for anonymous shmem
To: kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <ec35a23026dd016705d211e85163cabe07681516.1717033868.git.baolin.wang@linux.alibaba.com>
 <202405301430.0NRLTOWU-lkp@intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <202405301430.0NRLTOWU-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/30 14:36, kernel test robot wrote:
> Hi Baolin,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on next-20240529]
> [cannot apply to linus/master v6.10-rc1]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-memory-extend-finish_fault-to-support-large-folio/20240530-100805
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/ec35a23026dd016705d211e85163cabe07681516.1717033868.git.baolin.wang%40linux.alibaba.com
> patch subject: [PATCH v3 4/6] mm: shmem: add mTHP support for anonymous shmem
> config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240530/202405301430.0NRLTOWU-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405301430.0NRLTOWU-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405301430.0NRLTOWU-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from mm/shmem.c:28:
>     In file included from include/linux/ramfs.h:5:
>     In file included from include/linux/fs_parser.h:11:
>     In file included from include/linux/fs_context.h:14:
>     In file included from include/linux/security.h:33:
>     In file included from include/linux/mm.h:2245:
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>>> mm/shmem.c:1748:14: warning: variable 'suitable_orders' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>      1748 |                 } else if (orders & BIT(HPAGE_PMD_ORDER)) {
>           |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     mm/shmem.c:1766:25: note: uninitialized use occurs here
>      1766 |                 order = highest_order(suitable_orders);
>           |                                       ^~~~~~~~~~~~~~~
>     mm/shmem.c:1748:10: note: remove the 'if' if its condition is always true
>      1748 |                 } else if (orders & BIT(HPAGE_PMD_ORDER)) {
>           |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     mm/shmem.c:1736:31: note: initialize the variable 'suitable_orders' to silence this warning
>      1736 |         unsigned long suitable_orders;
>           |                                      ^
>           |                                       = 0
>     2 warnings generated.

Thanks for reporting. Will fix the warning in next version.

