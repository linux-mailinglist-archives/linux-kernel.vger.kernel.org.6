Return-Path: <linux-kernel+bounces-230243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F56E917A44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93E91F2426C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1543415ECF3;
	Wed, 26 Jun 2024 07:57:02 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C014532F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388621; cv=none; b=l8O8vRM4iKC+IflzHI2J9q7aNpvNZ83D2OfNQgOEUOw9F2zOLcHiJTnhXt8AyrRNl/hb0tUK7+QqWVfexF3EP6+AFMCjcOrAqzLT1pRzcG/nkQIbJb5CQssH7LmnHHAmhdihrnmsuyUpFkjtdXwttZp+u+S2Gb5UKBYz4QsAPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388621; c=relaxed/simple;
	bh=F93Fn46r5Pmll9Oshc2Sa4+Wtzu2QvPfx1KZHQZK8ZQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NWg63rdge/RQ9dAqv4MRMORHiuzJJY4BLMXV8coOvO9K/skbRMlYkrU/XdqHduLWB2M1crjuuiZcs3RDMgqK/EOPoRQrTCJqv2J4R+LjVkJA2NcjsNQcuHkILGghoVqoPbIjqDvF65GXa9eVbIltd+alr/L4Aauz1WTFhpIEGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8DSh4SGszxTqV;
	Wed, 26 Jun 2024 15:52:36 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AF72180087;
	Wed, 26 Jun 2024 15:56:56 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Jun 2024 15:56:55 +0800
Subject: Re: [PATCH] migrate_pages: modify max number of pages to migrate in
 batch
To: "Huang, Ying" <ying.huang@intel.com>, Zhenneng Li <lizhenneng@kylinos.cn>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240624045120.121261-1-lizhenneng@kylinos.cn>
 <87o77pzuq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1ffa1043-673b-fdd3-a33c-444c2e99fc54@huawei.com>
Date: Wed, 26 Jun 2024 15:56:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o77pzuq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/6/25 9:17, Huang, Ying wrote:
> Hi, Zhenneng,
> 
> Zhenneng Li <lizhenneng@kylinos.cn> writes:
> 
>> We restrict the number of pages to be migrated to no more than
>> HPAGE_PMD_NR or NR_MAX_BATCHED_MIGRATION, but in fact, the
>> number of pages to be migrated may reach 2*HPAGE_PMD_NR-1 or 2
>> *NR_MAX_BATCHED_MIGRATION-1, it's not in inconsistent with the context.
> 
> Yes.  It's not HPAGE_PMD_NR exactly.
> 
>> Please refer to the patch: 42012e0436d4(migrate_pages: restrict number
>> of pages to migrate in batch)
>>
>> Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
>> ---
>>  mm/migrate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 781979567f64..7a4b37aac9e8 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1961,7 +1961,7 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
>>  			break;
>>  	}
>>  	if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
>> -		list_cut_before(&folios, from, &folio2->lru);
>> +		list_cut_before(&folios, from, &folio->lru);
> 
> If the first entry of the list "from" is a THP with size HPAGE_PMD_NR,
> "folio" will be the first entry of from, so that "folios" will be empty.
> Right?

If "folios" list is empty, the "from" list is left unmodified. So we will reach "goto again" and
retry this ops again and again. This causes soft-lockup in my test env.

[  635.267324] watchdog: BUG: soft lockup - CPU#8 stuck for 26s! [bash:1031]
[  635.277957] Kernel panic - not syncing: softlockup: hung tasks
[  635.279519] CPU: 8 PID: 1031 Comm: bash Tainted: G             L     6.10.0-rc5-00327-g47fd2329f867 #45
[  635.279796] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  635.279796] Call Trace:
[  635.279796]  <IRQ>
[  635.279796]  panic+0x326/0x350
[  635.280827]  watchdog_timer_fn+0x226/0x270
[  635.280827]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  635.280827]  __hrtimer_run_queues+0x1a8/0x360
[  635.280827]  hrtimer_interrupt+0xfe/0x240
[  635.280827]  __sysvec_apic_timer_interrupt+0x71/0x1f0
[  635.280827]  sysvec_apic_timer_interrupt+0x6a/0x80
[  635.280827]  </IRQ>
[  635.280827]  <TASK>
[  635.282706]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  635.282928] RIP: 0010:migrate_pages_batch+0x780/0xd50
[  635.282928] Code: 6c 24 28 41 89 46 0c 48 8b 44 24 70 03 54 24 04 c7 44 24 58 f4 ff ff ff 41 01 56 04 48 39 c8 0f 84 d0 03 00 00 e8 d0 5c fa ff <c7> 44 24 54 00 00 00 00 48 8b 94 24 80 00 00 00 48 8b 02 48 8d 6a
[  635.282928] RSP: 0018:ffffa76f88e57a00 EFLAGS: 00000246
[  635.282928] RAX: 0000000000000000 RBX: ffffa76f88e57c50 RCX: ffffa76f88e57c60
[  635.284331] RDX: ffffa76f88e57b78 RSI: ffffffffa7d1eb10 RDI: ffffa76f88e57b78
[  635.284331] RBP: ffffdbcfc5000000 R08: 0000000000000000 R09: 0000000000000002
[  635.284331] R10: 0000000000000007 R11: 0000000000000000 R12: ffffa76f88e57b70
[  635.285800] R13: ffffa76f88e57ba8 R14: ffffa76f88e57bd0 R15: ffffa76f88e57b70
[  635.285800]  ? __pfx_alloc_migration_target+0x10/0x10
[  635.285800]  ? __pfx_alloc_migration_target+0x10/0x10
[  635.286824]  migrate_pages+0xaa7/0xd70
[  635.286824]  ? __pfx_alloc_migration_target+0x10/0x10
[  635.287433]  ? folio_lruvec_lock_irq+0x6a/0xf0
[  635.287433]  ? folio_isolate_lru+0x198/0x2a0
[  635.287433]  do_migrate_range+0x194/0x740
[  635.287433]  offline_pages+0x4ab/0x6e0
[  635.288614]  memory_subsys_offline+0x9e/0x1d0
[  635.288803]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[  635.289119]  device_offline+0xe2/0x110
[  635.289119]  state_store+0x6d/0xc0
[  635.289119]  kernfs_fop_write_iter+0x12c/0x1d0
[  635.290093]  vfs_write+0x380/0x540
[  635.290093]  ksys_write+0x64/0xe0
[  635.290551]  do_syscall_64+0xb9/0x1d0
[  635.290551]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  635.290551] RIP: 0033:0x7f99f5514887
[  635.290551] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  635.291480] RSP: 002b:00007ffe05712888 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  635.291480] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f99f5514887
[  635.292980] RDX: 0000000000000008 RSI: 000055c97b961e10 RDI: 0000000000000001
[  635.292980] RBP: 000055c97b961e10 R08: 00007f99f55d1460 R09: 000000007fffffff
[  635.292980] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
[  635.292980] R13: 00007f99f561b780 R14: 00007f99f5617600 R15: 00007f99f5616a00
[  635.294155]  </TASK>
[  635.294155] Kernel Offset: 0x26a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  635.294155] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---

Thanks.
.


