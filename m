Return-Path: <linux-kernel+bounces-213174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D513906EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863911C22B19
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E77146591;
	Thu, 13 Jun 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bZPrxzej"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0121448F2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280522; cv=none; b=ok+BeAAeExWEMLlhz4mPxFNzAdLccZc6sXXS7bQeCYIaOh0QMXqPnUfW8hypiy8FIpfwVltG9JE0Ynaalq7qHTYnBiXHxKnkcEGwplnzPWwYKTY/IcIG909tE6HgSmmRbZW13ke55YTLaoQn5gIbMRtouoWZk1sfOVjhlGxPSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280522; c=relaxed/simple;
	bh=WuA9U6X5yxQnrH5pEU9/6y5D10PqSgAOLq9u7rAvJ+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G0G6OVJcirmzaGNTzJ9ECD0EuUykE24UYcrNrmGGZzcZZ4o1drvZZNkO+juMeNM+9U6Z27fChqXbNieCJGT7ON53/1cEK0fhdqaLLRM4zhzAbZVmExHUOpm0El3yuXthbQvE4lVViTEQmKIvCwNx56b1feZMXdvqIn1rHsWjZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bZPrxzej; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718280511; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+ybivgLRs3V47AmWOiMtdHW+UOwYmEorpegVchSb5tE=;
	b=bZPrxzejA+HrSv47ojA222RcmyjKqim5k/VeQsxLMy7HaOavFqQgDSYqdHcGbmzM0rtQrRNDnbAcAZp563J3w4Che76ArLzx6FlUcHAQZvGY7T7PdzrsC+sg2zMOiAdiw2MKae5RA6PJA1EbjnpLeTbbVnK3kgS23+zzrTkUMwU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W8O.f6t_1718280510;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8O.f6t_1718280510)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 20:08:30 +0800
Message-ID: <4e578713-c907-4bec-b2c2-f585772eae13@linux.alibaba.com>
Date: Thu, 13 Jun 2024 20:08:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in finish_fault
To: syzbot <syzbot+d6e5c328862b5ae6cbfe@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000e21956061ac3eff0@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <000000000000e21956061ac3eff0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/13 19:38, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d35b2284e966 Add linux-next specific files for 20240607
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=178b77ba980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6e5c328862b5ae6cbfe
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174c680a980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111b9696980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e0055a00a2cb/disk-d35b2284.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/192cbb8cf833/vmlinux-d35b2284.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/57804c9c9319/bzImage-d35b2284.xz
> 
> The issue was bisected to:
> 
> commit 1c05047ad01693ad92bdf8347fad3b5c2b25e8bb
> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
> Date:   Tue Jun 4 10:17:45 2024 +0000
> 
>      mm: memory: extend finish_fault() to support large folio
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11267f94980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13267f94980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15267f94980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d6e5c328862b5ae6cbfe@syzkaller.appspotmail.com
> Fixes: 1c05047ad016 ("mm: memory: extend finish_fault() to support large folio")
> 
> ==================================================================
> BUG: KASAN: use-after-free in ptep_get include/linux/pgtable.h:317 [inline]
> BUG: KASAN: use-after-free in ptep_get_lockless include/linux/pgtable.h:581 [inline]
> BUG: KASAN: use-after-free in pte_range_none mm/memory.c:4409 [inline]
> BUG: KASAN: use-after-free in finish_fault+0xf87/0x1460 mm/memory.c:4905
> Read of size 8 at addr ffff88807bfb7000 by task syz-executor149/5117
> 
> CPU: 0 PID: 5117 Comm: syz-executor149 Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:91 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   ptep_get include/linux/pgtable.h:317 [inline]
>   ptep_get_lockless include/linux/pgtable.h:581 [inline]
>   pte_range_none mm/memory.c:4409 [inline]
>   finish_fault+0xf87/0x1460 mm/memory.c:4905
>   do_read_fault mm/memory.c:5052 [inline]
>   do_fault mm/memory.c:5178 [inline]
>   do_pte_missing mm/memory.c:3948 [inline]
>   handle_pte_fault+0x3db5/0x7130 mm/memory.c:5502
>   __handle_mm_fault mm/memory.c:5645 [inline]
>   handle_mm_fault+0x10df/0x1ba0 mm/memory.c:5810
>   faultin_page mm/gup.c:1339 [inline]
>   __get_user_pages+0x6ef/0x1590 mm/gup.c:1638
>   populate_vma_page_range+0x264/0x330 mm/gup.c:2078
>   __mm_populate+0x27a/0x460 mm/gup.c:2181
>   mm_populate include/linux/mm.h:3442 [inline]
>   __do_sys_remap_file_pages mm/mmap.c:3177 [inline]
>   __se_sys_remap_file_pages+0x7a1/0x9a0 mm/mmap.c:3103
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Thanks for reporting. I think the problem is I should also consider the 
pagetable of PMD size in case the pte entry overflows. I will fix this 
issue ASAP.

