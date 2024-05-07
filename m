Return-Path: <linux-kernel+bounces-170569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01C8BD92F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59142B23C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA77441D;
	Tue,  7 May 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rh7g+0H1"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF823A6
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046441; cv=none; b=nt7pcU3giqhRJbEkrhEw/AR962YdhZrLZqNFjBko+c5934mLqnirPMcJIfLQ0XcBloSgZsCgpdnAQftJNRlBPz1Gnxr4AOHu27wrRO2oGhUaX77nzLwcit4OGqjDkSiUAEKJa+D2SKe75l1leHOPzIonyPzf6U44jdSb8XIjCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046441; c=relaxed/simple;
	bh=AQPMVWxid0ALT3wc0GAhZv1ub/n/eqP1MJ5BpLhMAy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlCGDYnCnmZqVZiDGs9N37U9DRHawM9TbIGQePYfCSPc4UwjrT0GaigiGK2iNLpfS05fS7l77KMFwb7OQDlKqL5T+TlNh8ijthRkdpN4KnMvEEHdsxntRptykKVBkM5PQ1NwuJEhHEIqhI6++8Tt0s3oHS3Uc8xCt1kcgMQSkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rh7g+0H1; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715046436; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Dpx0yvmheJb/T/XlRkV3cxPjBuNg/KGEhlA/osbYz3g=;
	b=rh7g+0H1n3dr9RSZeFyh4+/NliFzB+OaGw7aGOmA0f4WkzNfT2yFvO5Zid1WQzEwsO6qo12bxGKD5mC4cfcKBRxYYUTW32GzQjnfqQC4rsoiqf9ou5WWMTZBdTXqvA5t9lOIZGad18FadkTGiwu7IWwr5iPB4EtUOwggNxbHwdk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W6-HUJs_1715046433;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6-HUJs_1715046433)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 09:47:14 +0800
Message-ID: <eaddd00d-8160-4800-b60f-25280dfe339b@linux.alibaba.com>
Date: Tue, 7 May 2024 09:47:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
To: Lance Yang <ioworker0@gmail.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
 hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ryan.roberts@arm.com, shy828301@gmail.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, ying.huang@intel.com, ziy@nvidia.com
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <20240506105447.1171-1-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240506105447.1171-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lance,

On 2024/5/6 18:54, Lance Yang wrote:
> Hey Baolin,
> 
> I found a compilation issue that failed one[1] of my configurations
> after applying this series. The error message is as follows:
> 
> mm/shmem.c: In function ‘shmem_get_unmapped_area’:
> ././include/linux/compiler_types.h:460:45: error: call to ‘__compiletime_assert_481’ declared with attribute error: BUILD_BUG failed
>          _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                              ^
> ././include/linux/compiler_types.h:441:25: note: in definition of macro ‘__compiletime_assert’
>                           prefix ## suffix();                             \
>                           ^~~~~~
> ././include/linux/compiler_types.h:460:9: note: in expansion of macro ‘_compiletime_assert’
>          _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                       ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>   #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                       ^~~~~~~~~~~~~~~~
> ./include/linux/huge_mm.h:97:28: note: in expansion of macro ‘BUILD_BUG’
>   #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>                              ^~~~~~~~~
> ./include/linux/huge_mm.h:104:35: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>   #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
>                                     ^~~~~~~~~~~~~~~
> mm/shmem.c:2419:36: note: in expansion of macro ‘HPAGE_PMD_SIZE’
>          unsigned long hpage_size = HPAGE_PMD_SIZE;
>                                     ^~~~~~~~~~~~~~~
> 
> It seems like we need to handle the case where CONFIG_PGTABLE_HAS_HUGE_LEAVES
> is undefined.
> 
> [1] export ARCH=arm64 && make allnoconfig && make olddefconfig && make -j$(nproc)

Thanks for reporting. I can move the use of HPAGE_PMD_SIZE to after the 
check for CONFIG_TRANSPARENT_HUGEPAGE, which can avoid the building error:

diff --git a/mm/shmem.c b/mm/shmem.c
index 1af2f0aa384d..d603e36e0f4f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2416,7 +2416,7 @@ unsigned long shmem_get_unmapped_area(struct file 
*file,
         unsigned long inflated_len;
         unsigned long inflated_addr;
         unsigned long inflated_offset;
-       unsigned long hpage_size = HPAGE_PMD_SIZE;
+       unsigned long hpage_size;

         if (len > TASK_SIZE)
                 return -ENOMEM;
@@ -2446,6 +2446,7 @@ unsigned long shmem_get_unmapped_area(struct file 
*file,
         if (uaddr == addr)
                 return addr;

+       hpage_size = HPAGE_PMD_SIZE;
         if (shmem_huge != SHMEM_HUGE_FORCE) {
                 struct super_block *sb;
                 unsigned long __maybe_unused hpage_orders;

