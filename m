Return-Path: <linux-kernel+bounces-520840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B759A3AFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF883AEA78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F917BB0D;
	Wed, 19 Feb 2025 03:17:19 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338D8F7D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935038; cv=none; b=VSPSmWvbg/Iq9DittUNjMp8+tCSxghgYd6MG8CnJV2r1LnUE6QSkH3p/fKdgLpg4bT9x/0Q+Xt6rbBkhfPBUqu5ydM1frXPpZ3KPl4z2F0QqTnTFaeu6RTckH5SM7nRcXpwquxwKSDfDujrCHYERL+MqfVqNFkGTj5pjG3iXBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935038; c=relaxed/simple;
	bh=oCsssqWPW0qmyq7g81yKblvqjhAXS6CvBYXUrzG1Yd0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RjqvrYitHWzEp0eIroZBgkf4w/47LPRTLWGP9PtManwC6Anois8lg+qhJAULbPkjpOPegGO94Bu1r9LYg5e3xEJD/yvBsS+FJG03Nvr0oe1hygUqx/Hj44Elyzld6CfEcveEvLghvyUVKdforQDkZORD+0u9gI//cMqGrxyXOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YyM0Z2Gs2z1wn68;
	Wed, 19 Feb 2025 11:13:18 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B1A11401F0;
	Wed, 19 Feb 2025 11:17:13 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 11:17:12 +0800
Subject: Re: [PATCH v3 3/3] hwpoison, memory_hotplug: lock folio before unmap
 hwpoisoned folio
To: Wupeng Ma <mawupeng1@huawei.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<nao.horiguchi@gmail.com>, <mhocko@suse.com>
References: <20250217014329.3610326-1-mawupeng1@huawei.com>
 <20250217014329.3610326-4-mawupeng1@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <30404cb1-d95a-1396-e4c1-dc511b29e01b@huawei.com>
Date: Wed, 19 Feb 2025 11:17:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217014329.3610326-4-mawupeng1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/2/17 9:43, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Commit b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to
> be offlined) add page poison checks in do_migrate_range in order to make
> offline hwpoisoned page possible by introducing isolate_lru_page and
> try_to_unmap for hwpoisoned page. However folio lock must be held before
> calling try_to_unmap. Add it to fix this problem.
> 
> Warning will be produced if folio is not locked during unmap:
> 
>   ------------[ cut here ]------------
>   kernel BUG at ./include/linux/swapops.h:400!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 4 UID: 0 PID: 411 Comm: bash Tainted: G        W          6.13.0-rc1-00016-g3c434c7ee82a-dirty #41
>   Tainted: [W]=WARN
>   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>   pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : try_to_unmap_one+0xb08/0xd3c
>   lr : try_to_unmap_one+0x3dc/0xd3c
>   Call trace:
>    try_to_unmap_one+0xb08/0xd3c (P)
>    try_to_unmap_one+0x3dc/0xd3c (L)
>    rmap_walk_anon+0xdc/0x1f8
>    rmap_walk+0x3c/0x58
>    try_to_unmap+0x88/0x90
>    unmap_poisoned_folio+0x30/0xa8
>    do_migrate_range+0x4a0/0x568
>    offline_pages+0x5a4/0x670
>    memory_block_action+0x17c/0x374
>    memory_subsys_offline+0x3c/0x78
>    device_offline+0xa4/0xd0
>    state_store+0x8c/0xf0
>    dev_attr_store+0x18/0x2c
>    sysfs_kf_write+0x44/0x54
>    kernfs_fop_write_iter+0x118/0x1a8
>    vfs_write+0x3a8/0x4bc
>    ksys_write+0x6c/0xf8
>    __arm64_sys_write+0x1c/0x28
>    invoke_syscall+0x44/0x100
>    el0_svc_common.constprop.0+0x40/0xe0
>    do_el0_svc+0x1c/0x28
>    el0_svc+0x30/0xd0
>    el0t_64_sync_handler+0xc8/0xcc
>    el0t_64_sync+0x198/0x19c
>   Code: f9407be0 b5fff320 d4210000 17ffff97 (d4210000)
>   ---[ end trace 0000000000000000 ]---
> 
> Fixes: b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined")
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

