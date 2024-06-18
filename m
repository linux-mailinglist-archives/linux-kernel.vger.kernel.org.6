Return-Path: <linux-kernel+bounces-220140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AB90DD22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A111B21DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254816CD01;
	Tue, 18 Jun 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E+ZnJbf5"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DB39AEC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741872; cv=none; b=pPs+x5OF1UZnZaEgQy4f0f9skYHUFW0/xDhYX8uYM8pfOI0b2mFicpxIYEZr8eqsCukA9mJnF4GI7pcTyvGfBgQBQXociokVoDZWdZe3+4bL7R4+SLmix1nmkCZuyuuEjXH0220Q7+Wo/nd497sCobKw/g89zpk591AZ3Knq3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741872; c=relaxed/simple;
	bh=yyrfiLjqPi0uO1ISvzwWt3Wh6ZRh8LSDYclWV6U83tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OSm4FLxH1nsCWFMFeEqsmWrZ8au6za2FAuIEVqT2zJvwCC+eW22wk5xEPUHXsi/dwnOwwrrr9djBcV9nqhmiW3oIrf40aPo7JU5IAK+SAkAwDN20I1clpA71iN8BoT6rNoc8Jf73ITCeTTIRfEBk/JRnZk3bDa2lrcJ4VfUS7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E+ZnJbf5; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240618201745euoutp016e523b2df511b3490c6a3cb895087735~aMp7DFLNH0106201062euoutp01b
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:17:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240618201745euoutp016e523b2df511b3490c6a3cb895087735~aMp7DFLNH0106201062euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718741865;
	bh=dB0AWSkQTUOU9QyCV/W0Hl3ec8vt1AE5YCai3dZxvxE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=E+ZnJbf56qX8YDIZQAfxnrF5IKiXc2wLCJcGlqRtS5nNlpRD9L7N4nS4rAwevEmVU
	 YGf14SwPeLV7F3et75LHiHaH62umUjmZsqTC+mGTM4J5gT24z+UqpMkZLDPG5EYLQ5
	 KkKX/MsQ6Fbu3D1yE/aQZNTR0tqXGGLY4ygSt/9Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240618201745eucas1p2325c1b00dbb107b983278aff464c5ddf~aMp69O3iV2058020580eucas1p2W;
	Tue, 18 Jun 2024 20:17:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 12.EE.09620.96BE1766; Tue, 18
	Jun 2024 21:17:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240618201744eucas1p1d5ea63c6b776e2e1770a6d0ba9c86ae4~aMp6tkffr0594905949eucas1p1L;
	Tue, 18 Jun 2024 20:17:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240618201744eusmtrp2ee4b83c956fdf522fec86d97c74046b4~aMp6tHBih0178501785eusmtrp25;
	Tue, 18 Jun 2024 20:17:44 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-ae-6671eb6994d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A5.B2.08810.86BE1766; Tue, 18
	Jun 2024 21:17:44 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240618201744eusmtip153bb8ff0d0e262733b53e0f3787050f0~aMp6SvKOr0174501745eusmtip1c;
	Tue, 18 Jun 2024 20:17:44 +0000 (GMT)
Message-ID: <7afd05e8-21bb-42c0-8c11-ff2108a74880@samsung.com>
Date: Tue, 18 Jun 2024 22:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] mm/hugetlb_cgroup: register lockdep key for
 cftype
To: Xiu Jianfeng <xiujianfeng@huawei.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240618071922.2127289-1-xiujianfeng@huawei.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned3M14VpBnP+slrMWb+GzeLyrjls
	FvfW/Ge12D5rB6MDi0fLkbesHps+TWL3ODHjN4vH501yASxRXDYpqTmZZalF+nYJXBlndq9m
	LtigUDF72USmBsafUl2MnBwSAiYSd1/fZepi5OIQEljBKLFo7XpGCOcLo8ThbY1Qmc+MEuvn
	fGWGafm06w8bRGI5o8TeuUfYIZyPjBKX309l7WLk4OAVsJP4/jYFpIFFQFVi17LzbCA2r4Cg
	xMmZT1hAbFEBeYn7t2awg9jCAkESh08sYwWxRQRcJNqOzwSrYQZadr/1ISuELS5x68l8JhCb
	TcBQouttF9hMTqBVu2Y2sUPUyEtsfzuHGeQeCYE9HBK71u1kgbjaRWJZ82I2CFtY4tXxLewQ
	tozE/53zmSAa2hklFvy+D+VMYJRoeH6LEaLKWuLOuV9sIJ8xC2hKrN+lDxF2lGj/fRXsYQkB
	PokbbwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164xDyBUWkWUrDMQvLmLCTvzELYu4CR
	ZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgcjn97/jXHYwrXn3UO8TIxMF4iFGCg1lJ
	hNdpWl6aEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQimCwTB6dUA1Nt
	f9DKyZMaAv/daE5unmZ/oUT7S4/E7n0pYn8nP7zYXizL6Z9801vIgu/NZOWpfPcnljarnw54
	UnkncXoJ/5aDDNEHt83PnGjftTN4zcI7QvulZr2s7ru6/N3LDre2K6UX+N5YxrztupK2qmzD
	5Sd2ttUz3+SLlipG823iuvG8XTvKaI3+SQ91H77rS9w5N5n9lIqvf1IhMdvsk9gyw+Ue6a0c
	Nn4GQZ8Xd1zJ0hfRDVO4z/rk51LRZI2qnoVG7wzSAtgmTYt7UrE6eJYve/PPCa4/Dj3aZLt1
	1qIeZeNXzdOMo7j6Bf5t2f3qbm7aPrtZrzo2Tmt+bFPUn3RMvWW92qGb71Yw+SueOlH9UVOJ
	pTgj0VCLuag4EQD6WVh+nQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7oZrwvTDO7dM7CYs34Nm8XlXXPY
	LO6t+c9qsX3WDkYHFo+WI29ZPTZ9msTucWLGbxaPz5vkAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLO7F7NXLBBoWL2solMDYw/pboYOTkk
	BEwkPu36w9bFyMUhJLCUUaJh1l42iISMxMlpDawQtrDEn2tdYHEhgfeMEkt6yrsYOTh4Bewk
	vr9NAQmzCKhK7Fp2HqyEV0BQ4uTMJywgtqiAvMT9WzPYQWxhgSCJwyeWgY0UEXCRaDs+E6yG
	GeiG+60PWSHG20o0tu9mhoiLS9x6Mp8JxGYTMJToegtxAifQ2l0zm9ghaswkurZ2MULY8hLb
	385hnsAoNAvJGbOQjJqFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNp27Gf
	m3cwznv1Ue8QIxMH4yFGCQ5mJRFep2l5aUK8KYmVValF+fFFpTmpxYcYTYFhMZFZSjQ5HxjL
	eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTEVd0bxz9A7Zm8Sv
	CPldUCuTnZm3iHfKx0DeXcFtR86zf2jN8TreJbduj5uMYfit6St2/DPpSVk1/Y1Gau3F+b3H
	FjTL/BbQsOadK3pcx+Rzylqlaw3OOhzhtzJFfkZYds+eO8+gfELwkU+J6TVc2Tp5MoYCR5Ss
	z3ButWD6yirq5xSUe9Bz3y/e/zz3/gQYuswXtuWVmdrjy/fi/Z2bkktnp7CYzm9TjM1bdmKx
	Er8L/zUb9l0WRv9X/FcwiPb4/+uY9U+JXz9OVGYd0axq28q/J3/H7yM56dtNt3H+WaYo5zJp
	qUjp8n0nuRj5GZ5ql8QyGs3pe/JwycKmd4+1VHgq/2lY6137/tbNoMBZiaU4I9FQi7moOBEA
	3WT5by0DAAA=
X-CMS-MailID: 20240618201744eucas1p1d5ea63c6b776e2e1770a6d0ba9c86ae4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240618201744eucas1p1d5ea63c6b776e2e1770a6d0ba9c86ae4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240618201744eucas1p1d5ea63c6b776e2e1770a6d0ba9c86ae4
References: <20240618071922.2127289-1-xiujianfeng@huawei.com>
	<CGME20240618201744eucas1p1d5ea63c6b776e2e1770a6d0ba9c86ae4@eucas1p1.samsung.com>

On 18.06.2024 09:19, Xiu Jianfeng wrote:
> When CONFIG_DEBUG_LOCK_ALLOC is enabled, the following commands can
> trigger a bug,
>
> mount -t cgroup2 none /sys/fs/cgroup
> cd /sys/fs/cgroup
> echo "+hugetlb" > cgroup.subtree_control
>
> The log is as below:
>
> BUG: key ffff8880046d88d8 has not been registered!
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 3 PID: 226 at kernel/locking/lockdep.c:4945 lockdep_init_map_type+0x185/0x220
> Modules linked in:
> CPU: 3 PID: 226 Comm: bash Not tainted 6.10.0-rc4-next-20240617-g76db4c64526c #544
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:lockdep_init_map_type+0x185/0x220
> Code: 00 85 c0 0f 84 6c ff ff ff 8b 3d 6a d1 85 01 85 ff 0f 85 5e ff ff ff 48 c7 c6 21 99 4a 82 48 c7 c7 60 29 49 82 e8 3b 2e f5
> RSP: 0018:ffffc9000083fc30 EFLAGS: 00000282
> RAX: 0000000000000000 RBX: ffffffff828dd820 RCX: 0000000000000027
> RDX: ffff88803cd9cac8 RSI: 0000000000000001 RDI: ffff88803cd9cac0
> RBP: ffff88800674fbb0 R08: ffffffff828ce248 R09: 00000000ffffefff
> R10: ffffffff8285e260 R11: ffffffff828b8eb8 R12: ffff8880046d88d8
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880067281c0
> FS:  00007f68601ea740(0000) GS:ffff88803cd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005614f3ebc740 CR3: 000000000773a000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   ? __warn+0x77/0xd0
>   ? lockdep_init_map_type+0x185/0x220
>   ? report_bug+0x189/0x1a0
>   ? handle_bug+0x3c/0x70
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? lockdep_init_map_type+0x185/0x220
>   __kernfs_create_file+0x79/0x100
>   cgroup_addrm_files+0x163/0x380
>   ? find_held_lock+0x2b/0x80
>   ? find_held_lock+0x2b/0x80
>   ? find_held_lock+0x2b/0x80
>   css_populate_dir+0x73/0x180
>   cgroup_apply_control_enable+0x12f/0x3a0
>   cgroup_subtree_control_write+0x30b/0x440
>   kernfs_fop_write_iter+0x13a/0x1f0
>   vfs_write+0x341/0x450
>   ksys_write+0x64/0xe0
>   do_syscall_64+0x4b/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f68602d9833
> Code: 8b 15 61 26 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 08
> RSP: 002b:00007fff9bbdf8e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f68602d9833
> RDX: 0000000000000009 RSI: 00005614f3ebc740 RDI: 0000000000000001
> RBP: 00005614f3ebc740 R08: 000000000000000a R09: 0000000000000008
> R10: 00005614f3db6ba0 R11: 0000000000000246 R12: 0000000000000009
> R13: 00007f68603bd6a0 R14: 0000000000000009 R15: 00007f68603b8880
>
> For lockdep, there is a sanity check in lockdep_init_map_type(), the
> lock-class key must either have been allocated statically or must
> have been registered as a dynamic key. However the commit e18df2889ff9
> ("mm/hugetlb_cgroup: prepare cftypes based on template") has changed
> the cftypes from static allocated objects to dynamic allocated objects,
> so the cft->lockdep_key must be registered proactively.
>
> Fixes: e18df2889ff9 ("mm/hugetlb_cgroup: prepare cftypes based on template")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202406181046.8d8b2492-oliver.sang@intel.com
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> v2: add bug log to commit message
> ---
>   mm/hugetlb_cgroup.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 2b899c4ae968..4ff238ba1250 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -836,6 +836,8 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
>   			cft->file_offset = MEMFILE_OFFSET0(offset) +
>   					   MEMFILE_FIELD_SIZE(offset) * idx;
>   		}
> +
> +		lockdep_register_key(&cft->lockdep_key);
>   	}
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


