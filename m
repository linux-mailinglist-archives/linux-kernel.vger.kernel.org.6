Return-Path: <linux-kernel+bounces-245773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4D92B909
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628C9B238E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A071158A09;
	Tue,  9 Jul 2024 12:07:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B9158D89
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526861; cv=none; b=YIikV7ZM3JQL36KQAjhze6hmu3T3sGJslsazX3oN0K4FMfi7IY4uSY82e8M/cTGrtHPIGnvypModA9PgC9gaBJwgkXPfKi+eKS26YfNuS5hb+9PxMEc/V6lBkOz+7dPZqCjn8aekicfg2Bp4kqS5IIyY6mdN41dMehzTaZbd0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526861; c=relaxed/simple;
	bh=4UFAIN/wPLuo4sk4ehkUPHU4DAAyeY3w5QRw+RB5jo8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D4ZZJiX+v5A4oWszx8MQqcqoNwI0YtbG53fD66TlO5QpLZA7hkPyPtIyhuu3XY5L2xrZS+Ac3CaxuWYrnfFeVmyuCTdE49jCV9yOcTsGwwb3HojGKrtAHGQPfNr/nUq1YmxjLykxTVwB2FlpsmoFx+jKp3EH79Jss1e+IJeAvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WJKVQ0R5PzcpJ1;
	Tue,  9 Jul 2024 20:07:10 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 23B78180ADD;
	Tue,  9 Jul 2024 20:07:36 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jul 2024 20:07:35 +0800
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 migrating hugetlb folio
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>, <hughd@google.com>,
	<willy@infradead.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240709115841.4098393-1-linmiaohe@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e5303713-d704-b430-86b7-f7bb0891d949@huawei.com>
Date: Tue, 9 Jul 2024 20:07:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240709115841.4098393-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/9 19:58, Miaohe Lin wrote:
> A kernel crash was observed when migrating hugetlb folio:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> PGD 0 P4D 0
> Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
> CPU: 0 PID: 3435 Comm: bash Not tainted 6.10.0-rc6-00450-g8578ca01f21f #66
> RIP: 0010:__folio_undo_large_rmappable+0x70/0xb0
> RSP: 0018:ffffb165c98a7b38 EFLAGS: 00000097
> RAX: fffffbbc44528090 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffffa30e000a2800 RSI: 0000000000000246 RDI: ffffa3153ffffcc0
> RBP: fffffbbc44528000 R08: 0000000000002371 R09: ffffffffbe4e5868
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffa3153ffffcc0
> R13: fffffbbc44468000 R14: 0000000000000001 R15: 0000000000000001
> FS:  00007f5b3a716740(0000) GS:ffffa3151fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000010959a000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __folio_migrate_mapping+0x59e/0x950
>  __migrate_folio.constprop.0+0x5f/0x120
>  move_to_new_folio+0xfd/0x250
>  migrate_pages+0x383/0xd70
>  soft_offline_page+0x2ab/0x7f0
>  soft_offline_page_store+0x52/0x90
>  kernfs_fop_write_iter+0x12c/0x1d0
>  vfs_write+0x380/0x540
>  ksys_write+0x64/0xe0
>  do_syscall_64+0xb9/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5b3a514887
> RSP: 002b:00007ffe138fce68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f5b3a514887
> RDX: 000000000000000c RSI: 0000556ab809ee10 RDI: 0000000000000001
> RBP: 0000556ab809ee10 R08: 00007f5b3a5d1460 R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
> R13: 00007f5b3a61b780 R14: 00007f5b3a617600 R15: 00007f5b3a616a00
> 
> It's because hugetlb folio is passed to __folio_undo_large_rmappable()
> unexpectedly. large_rmappable flag is imperceptibly set to hugetlb folio
> since commit f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to
> use a folio"). Then commit be9581ea8c05 ("mm: fix crashes from deferred
> split racing folio migration") makes folio_migrate_mapping() call
> folio_undo_large_rmappable() triggering the bug. Fix this issue by
> clearing large_rmappable flag for hugetlb folios. They don't need that
> flag set anyway.
> 
> Fixes: f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to use a folio")
> Fixes: be9581ea8c05 ("mm: fix crashes from deferred split racing folio migration")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>

Sorry for make noise. This is not newest version. Will resend soon.
Thanks.
.

