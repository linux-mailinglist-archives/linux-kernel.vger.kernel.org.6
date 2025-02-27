Return-Path: <linux-kernel+bounces-535705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D106A47640
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B053A587F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD521B9CB;
	Thu, 27 Feb 2025 07:04:41 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF0221542
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639880; cv=none; b=GNugUKbOSY4MJjYSNA7ILxPpK3IzPMhLtpz6OmOAEdbPAQ26pHDkGFnucPC8iTdpBqsKPSZdhH4dzH2PnzB89/ppX6YWQwTO+n8Zd7tkgxO42SLkIDcR3KyN1aGoMsrGuNlEAG6E9P2y0lzdeaqGwdmBf63oexO33GZwxxbIQ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639880; c=relaxed/simple;
	bh=E1P3SIAYAWhybl/UsUeGA/UsCtA/rwx7cWZPws1FXU8=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FRbve2+rZYumHZExR7WWc+ODWobmtu1dClSAsAj7gPjwtXJ11iPfBg03Tt/Xsb+SDEdp8wRyXOQgTWOsDEKEDkTt5IA5GO5ywyjzGRoeLSeixkzOzX/uJnmiriXZUfpp7JaZS3imjKK2OBXzHDupouyW5sNf7onEGXFQp0o6n3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z3Mg13vpHz1dyn1;
	Thu, 27 Feb 2025 15:00:29 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id D8AA7140154;
	Thu, 27 Feb 2025 15:04:34 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 kwepemg200013.china.huawei.com (7.202.181.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Feb 2025 15:04:33 +0800
Subject: Re: Softlockup when test shmem swapout-swapin and compaction
To: Baolin Wang <baolin.wang@linux.alibaba.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
References: <28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com>
 <c4a07dd6-fffa-41f4-b6ff-3e333d1b5fc2@linux.alibaba.com>
CC: Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh
 Dickins <hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Lance
 Yang <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>, Ryan
 Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Zi
 Yan <ziy@nvidia.com>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <acbfc1da-f743-b11b-191c-ce6e476f1709@huawei.com>
Date: Thu, 27 Feb 2025 15:04:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c4a07dd6-fffa-41f4-b6ff-3e333d1b5fc2@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200013.china.huawei.com (7.202.181.64)



On 2025/2/26 15:22, Baolin Wang wrote:
> Add Zi.
>
> On 2025/2/26 15:03, Liu Shixin wrote:
>> Hi all,
>>
>> I found a softlockup when testing shmem large folio swapout-swapin and compaction:
>>
>>   watchdog: BUG: soft lockup - CPU#30 stuck for 179s! [folio_swap:4714]
>>   Modules linked in: zram xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat xt_addrtype iptable_filter ip_tantel_rapl_msr intel_rapl_common intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel kvm rapl cixt4 mbcache jbd2 sr_mod cdrom ata_generic ata_piix virtio_net net_failover ghash_clmulni_intel libata sha512_ssse3
>>   CPU: 30 UID: 0 PID: 4714 Comm: folio_swap Kdump: loaded Tainted: G             L     6.14.0-rc4-next-20250225+ #2
>>   Tainted: [L]=SOFTLOCKUP
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>>   RIP: 0010:xas_load+0x5d/0xc0
>>   Code: 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 73 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 48 3d
>>   RSP: 0000:ffffadf142f1ba60 EFLAGS: 00000293
>>   RAX: ffffe524cc4f6700 RBX: ffffadf142f1ba90 RCX: 0000000000000000
>>   RDX: 0000000000000011 RSI: ffff9a3e058acb68 RDI: ffffadf142f1ba90
>>   RBP: fffffffffffffffe R08: ffffadf142f1bb50 R09: 0000000000000392
>>   R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000011
>>   R13: ffffadf142f1bb48 R14: ffff9a3e04e9c588 R15: 0000000000000000
>>   FS:  00007fd957666740(0000) GS:ffff9a41ac0e5000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 00007fd922860000 CR3: 000000025c360001 CR4: 0000000000772ef0
>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   PKRU: 55555554
>>   Call Trace:
>>    <IRQ>
>>    ? watchdog_timer_fn+0x1c9/0x250
>>    ? __pfx_watchdog_timer_fn+0x10/0x10
>>    ? __hrtimer_run_queues+0x10e/0x250
>>    ? hrtimer_interrupt+0xfb/0x240
>>    ? __sysvec_apic_timer_interrupt+0x4e/0xe0
>>    ? sysvec_apic_timer_interrupt+0x68/0x90
>>    </IRQ>
>>    <TASK>
>>    ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>>    ? xas_load+0x5d/0xc0
>>    xas_find+0x153/0x1a0
>>    find_get_entries+0x73/0x280
>>    shmem_undo_range+0x1fc/0x640
>>    shmem_evict_inode+0x109/0x270
>>    evict+0x107/0x240
>>    ? fsnotify_destroy_marks+0x25/0x180
>>    ? _atomic_dec_and_lock+0x35/0x50
>>    __dentry_kill+0x71/0x190
>>    dput+0xd1/0x190
>>    __fput+0x128/0x2a0
>>    task_work_run+0x57/0x90
>>    syscall_exit_to_user_mode+0x1cb/0x1e0
>>    do_syscall_64+0x67/0x170
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>   RIP: 0033:0x7fd95776eb8b
>>
>> If CONFIG_DEBUG_VM is enabled, we will meet VM_BUG_ON_FOLIO(!folio_test_locked(folio)) in
>> shmem_add_to_page_cache() too.  It seems that the problem is related to memory migration or
>> compaction which is necessary for reproduction,  although without a clear why.
>>
>> To reproduce the problem, we need firstly a zram device as swap backend, and then run the
>> reproduction program. The reproduction program consists of three parts:
>>   1. A process constantly changes the status of shmem large folio by these interfaces:
>>          /sys/kernel/mm/transparent_hugepage/hugepages-<size>/shmem_enabled
>>   2. A process constantly echo 1 > /proc/sys/vm/compact_memory
>>   3. A process constantly alloc/free/swapout/swapin shmem large folios.
>>
>> I'm not sure whether the first process is necessary but the second and third are. In addition,
>> I tried hacking to modify compaction_alloc to return NULL, and the problem disappeared,
>> so I guess the problem is in migration.
>>
>> The problem is different with https://lore.kernel.org/all/1738717785.im3r5g2vxc.none@localhost/
>> since I have confirmed this porblem still existed after merge the fixed patch.
>
> Could you check if your version includes Zi's fix[1]? Not sure if it's related to the shmem large folio split.
>
> [1] https://lore.kernel.org/all/AF487A7A-F685-485D-8D74-756C843D6F0A@nvidia.com/
> .
>
Already include this patch when test.

