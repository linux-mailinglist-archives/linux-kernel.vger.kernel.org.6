Return-Path: <linux-kernel+bounces-214148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F56908037
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042FA1F2290C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1CA1C3D;
	Fri, 14 Jun 2024 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RmeH3smL"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772763D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718325892; cv=none; b=MTPC7IADtnaSu2zL1H9zrC+ngGrin9ZaKPXNq4Rsd7CRDboFgAnhrQNEoKfUrbyBZLKQuhLVStmyio/B/iMhO5k/8rm3/iQTuJqaWl/BYhcUTJGvxRBrfIrX/VLlBMG+OIYwzVHT6miRXKIHSDjncCbX2C2SbPG793Dzb5NyHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718325892; c=relaxed/simple;
	bh=lBEVDig1ev0I5Vei27NtyEKynDGYtlQucybkHibQQYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsonDlrlDLos49RIedqFG5qI0YLmdlf1lLt9pkZKEKlwOo+px7hGOrWswe2ktO6RfvlZ5gxKs9WHwTJXUCwNn4Q2qdV+An8Jnpq5PCvrtmSXQIIKuV465Xq6Sw6BYr4e8MF89aN9fDlXeOsflUXOMUyVkCWTZv1sLh8+4mzxrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RmeH3smL; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718325885; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kloQcFjYAvJ98yJJXSAgNR+FbPv4lnwNM8DOebShWTY=;
	b=RmeH3smLQ4Kfz3tW/AS1Kqv9Ofm+oy1ANbEXkmrW6eRqVJGQQiJ1SaaxrCjJHK9dkRAB5rEHVvIojfvO7AwrRKFIFAQGV2GWoNoUAjcVIKVhDvslg52HmPWSH09fPP4q8hjWsvF7P1SV55ALmg0+puRgn9rpaIbkIPqjpvDT/Cs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W8PHSfz_1718325884;
Received: from 30.97.56.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8PHSfz_1718325884)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 08:44:45 +0800
Message-ID: <bacd22ac-a6c8-477f-8626-b42832845ee0@linux.alibaba.com>
Date: Fri, 14 Jun 2024 08:44:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix getting incorrect lruvec when replacing a
 shmem folio
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
 nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <3c11000dd6c1df83015a8321a859e9775ebbc23e.1718266112.git.baolin.wang@linux.alibaba.com>
 <mf3nogu57jxgb3mxlunktykpw4a4dsw6d2qrjkdpafoz7uc7jd@rkfd4ypqiyw6>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <mf3nogu57jxgb3mxlunktykpw4a4dsw6d2qrjkdpafoz7uc7jd@rkfd4ypqiyw6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/14 06:20, Shakeel Butt wrote:
> On Thu, Jun 13, 2024 at 04:21:19PM GMT, Baolin Wang wrote:
>> When testing shmem swapin, I encountered the warning below on my machine.
>> The reason is that replacing an old shmem folio with a new one causes
>> mem_cgroup_migrate() to clear the old folio's memcg data. As a result,
>> the old folio cannot get the correct memcg's lruvec needed to remove itself
>> from the LRU list when it is being freed. This could lead to possible serious
>> problems, such as LRU list crashes due to holding the wrong LRU lock, and
>> incorrect LRU statistics.
>>
>> To fix this issue, we can fallback to use the mem_cgroup_replace_folio()
>> to replace the old shmem folio.
>>
>> [ 5241.100311] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5d9960
>> [ 5241.100317] head: order:4 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>> [ 5241.100319] flags: 0x17fffe0000040068(uptodate|lru|head|swapbacked|node=0|zone=2|lastcpupid=0x3ffff)
>> [ 5241.100323] raw: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
>> [ 5241.100325] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> [ 5241.100326] head: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
>> [ 5241.100327] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> [ 5241.100328] head: 17fffe0000000204 fffffdffd6665801 ffffffffffffffff 0000000000000000
>> [ 5241.100329] head: 0000000a00000010 0000000000000000 00000000ffffffff 0000000000000000
>> [ 5241.100330] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
>> [ 5241.100338] ------------[ cut here ]------------
>> [ 5241.100339] WARNING: CPU: 19 PID: 78402 at include/linux/memcontrol.h:775 folio_lruvec_lock_irqsave+0x140/0x150
>> [...]
>> [ 5241.100374] pc : folio_lruvec_lock_irqsave+0x140/0x150
>> [ 5241.100375] lr : folio_lruvec_lock_irqsave+0x138/0x150
>> [ 5241.100376] sp : ffff80008b38b930
>> [...]
>> [ 5241.100398] Call trace:
>> [ 5241.100399]  folio_lruvec_lock_irqsave+0x140/0x150
>> [ 5241.100401]  __page_cache_release+0x90/0x300
>> [ 5241.100404]  __folio_put+0x50/0x108
>> [ 5241.100406]  shmem_replace_folio+0x1b4/0x240
>> [ 5241.100409]  shmem_swapin_folio+0x314/0x528
>> [ 5241.100411]  shmem_get_folio_gfp+0x3b4/0x930
>> [ 5241.100412]  shmem_fault+0x74/0x160
>> [ 5241.100414]  __do_fault+0x40/0x218
>> [ 5241.100417]  do_shared_fault+0x34/0x1b0
>> [ 5241.100419]  do_fault+0x40/0x168
>> [ 5241.100420]  handle_pte_fault+0x80/0x228
>> [ 5241.100422]  __handle_mm_fault+0x1c4/0x440
>> [ 5241.100424]  handle_mm_fault+0x60/0x1f0
>> [ 5241.100426]  do_page_fault+0x120/0x488
>> [ 5241.100429]  do_translation_fault+0x4c/0x68
>> [ 5241.100431]  do_mem_abort+0x48/0xa0
>> [ 5241.100434]  el0_da+0x38/0xc0
>> [ 5241.100436]  el0t_64_sync_handler+0x68/0xc0
>> [ 5241.100437]  el0t_64_sync+0x14c/0x150
>> [ 5241.100439] ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migration")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks for reviewing.

> One request: please add VM_BUG_ON_FOLIO(folio_test_lru(folio), folio) in
> mem_cgroup_migrate().

Good suggestion. I will create a separate patch to do this.

