Return-Path: <linux-kernel+bounces-430464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187479E3135
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDA1B2389D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8A27466;
	Wed,  4 Dec 2024 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o3Ios+EV"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62634D9FB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278367; cv=none; b=GWvaRa/UILZPZDYpIKDU+pq/6AIlIBs3HlOR60Gln6FQF+AHYSMcRwTTrZqcU58P3cxIrZcE54G7pKzmN//VhaA+2zxtGxL+1kr/++9YoYoYRRVpijnIS5YndzVffgC0BCr5jA+sVNmeim98/ZrMLzyIHKWtzY/m7P8Jr6NxnyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278367; c=relaxed/simple;
	bh=EjQeGL7BD5q3M9dHieO9LJSkh2voy+MYsKaYhEpMrCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+7S8fDeMJRxNT3BJCeoYEJUHLIbrvkjGZDCQF8WqcVfv2z9dDO0L7RoQ4M4zKm3+KLH6y5gNohrWh7QMvkTNcisU3+fJivIGn26WME7/vhKDfzOsKl9MPRoRQzGrySKhAlCZLO2Flz/NPfMZRjO9QO1xBqrBXVOCkWgGXPLN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o3Ios+EV; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733278357; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g5gsjhvOhFxzwq83Lz4lsBhAQcZ8kfOOYigLnb8TSiA=;
	b=o3Ios+EVvViJmMG9HBoMHhQXSwlHnlJE+Hntke7qnG64mT7Timlqw4qBceBPFtqo3cvrZdLu7j7Ws9F2vwZ210DMJLazVhstf3kPeh/boqLXR0qpWrh1LHLujE9I8AepCEVWMRnXKbs9tWsETm4nK+F9KGE1NseSgV8RiMVO3xY=
Received: from 30.221.130.89(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKoKN8w_1733278356 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Dec 2024 10:12:36 +0800
Message-ID: <b0454659-630e-44a4-b309-f6d9cd0fbc63@linux.alibaba.com>
Date: Wed, 4 Dec 2024 10:12:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
 <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
 <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
 <CAKPOu+_4z4NDG1CmqsBatJVF1rQXHvqHV6fUiHEcnBswa_u8BQ@mail.gmail.com>
 <CAKPOu+_ZGtCX48bntZQU=nGxqFPon+D_wDPiagtZPKmtYRfpgQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAKPOu+_ZGtCX48bntZQU=nGxqFPon+D_wDPiagtZPKmtYRfpgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/3 22:00, Max Kellermann wrote:
> On Tue, Dec 3, 2024 at 2:30 PM Max Kellermann <max.kellermann@ionos.com> wrote:
>> __builtin_return_address(1) instantly crashes the kernel
> 
> I was able to capture the __builtin_return_address crash on a serial
> console (this has nothing to do with the PSI memstall bug):

Ok.. so __builtin_return_address(1) doesn't actually work?

Thanks,
Gao Xiang

> 
> [16438.331677] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [16438.338693] #PF: supervisor read access in kernel mode
> [16438.343866] #PF: error_code(0x0000) - not-present page
> [16438.349038] PGD 0 P4D 0
> [16438.351588] Oops: Oops: 0000 [#1] SMP PTI
> [16438.355625] CPU: 18 UID: 2147486501 PID: 23486 Comm: less Not
> tainted 6.11.10-cm4all4-hp+ #291
> [16438.364297] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380
> Gen10, BIOS U30 09/05/2019
> [16438.372880] RIP: 0010:psi_memstall_enter+0x7f/0xa0
> [16438.377708] Code: 89 df 80 8b 19 05 00 00 01 48 8b 45 08 48 89 83
> c0 08 00 00 48 8b 45 00 48 8b 40 08 48 89 83 c8 08 00 00 48 8b 45 00
> 48 8b 00 <48> 8b 40 08 48 89 83 d0 08 00 00 e8 d1 fe ff ff 4c 89 e7 e8
> 29 28
> [16438.396609] RSP: 0000:ffff9ee683bc7bd0 EFLAGS: 00010002
> [16438.401869] RAX: 0000000000000000 RBX: ffff90c70c291740 RCX: 0000000000000001
> [16438.409052] RDX: 000000000000000a RSI: 0000000000000000 RDI: ffff90c70c291740
> [16438.416234] RBP: ffff9ee683bc7be0 R08: 000000000007cec1 R09: 0000000000000007
> [16438.423418] R10: ffff90c727d83678 R11: 0000000000000000 R12: ffff9124bd0ae000
> [16438.430600] R13: 0000000000000014 R14: ffff9ee683bc7ce8 R15: 0000000000000000
> [16438.437785] FS:  00007ff15f1f4740(0000) GS:ffff9124bd080000(0000)
> knlGS:0000000000000000
> [16438.445929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16438.451714] CR2: 0000000000000008 CR3: 000000010c54a002 CR4: 00000000007706f0
> [16438.458896] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [16438.466079] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [16438.473263] PKRU: 55555554
> [16438.475984] Call Trace:
> [16438.478446]  <TASK>
> [16438.480557]  ? __die+0x1f/0x60
> [16438.483636]  ? page_fault_oops+0x15c/0x450
> [16438.487761]  ? exc_page_fault+0x5e/0x100
> [16438.491710]  ? asm_exc_page_fault+0x22/0x30
> [16438.495923]  ? psi_memstall_enter+0x7f/0xa0
> [16438.500135]  read_pages+0x205/0x220
> [16438.503647]  ? free_unref_page+0x2c1/0x420
> [16438.507771]  page_cache_ra_order+0x1d3/0x2b0
> [16438.512069]  filemap_fault+0x548/0xba0
> [16438.515845]  __do_fault+0x32/0x90
> [16438.519182]  do_fault+0x2a1/0x4a0
> [16438.522519]  __handle_mm_fault+0x337/0x1ca0
> [16438.526730]  handle_mm_fault+0x128/0x260
> [16438.530677]  do_user_addr_fault+0x1d8/0x5b0
> [16438.534889]  exc_page_fault+0x5e/0x100
> [16438.538663]  asm_exc_page_fault+0x22/0x30
> [16438.542697] RIP: 0033:0x55ebb60829a0
> [16438.546298] Code: Unable to access opcode bytes at 0x55ebb6082976.
> [16438.552519] RSP: 002b:00007fffd2a03658 EFLAGS: 00010246
> [16438.557779] RAX: 0000000000000016 RBX: 000055ebdb88b410 RCX: 000055ebdb88b410
> [16438.564963] RDX: 0000000000000ee4 RSI: 000055ec5b0b1e30 RDI: 000055ebdb88b910
> [16438.572147] RBP: 0000000000000010 R08: 00000000ffffffff R09: 0000000000000000
> [16438.579331] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000046
> [16438.586514] R13: 000055ebb6099e6c R14: 000055ebb6099c93 R15: 00007fffd2a03706
> [16438.593697]  </TASK>
> [16438.595895] Modules linked in:
> [16438.598970] CR2: 0000000000000008
> [16438.602307] ---[ end trace 0000000000000000 ]---


