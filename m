Return-Path: <linux-kernel+bounces-191928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1218D1634
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562B41F2296B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121413C3F3;
	Tue, 28 May 2024 08:26:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDEE13B5B9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884779; cv=none; b=Ymql2bn2Lmo1Z6D3eYaW4lrzpgVLXjF3eOD5yw1dpeLt55kE6HyeSrKrwHx7J5mM20kV3jThoqy4anK9yuDkkPHAavhz1ETQb/ZiiozIobXt2GnmRhTk1ywuOLAA1HWhSBFc8VHL6HKQuhQDYpL5qgexwcccLP0a2wNwnMhQmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884779; c=relaxed/simple;
	bh=x2IHaJM8J5TB06sb2x6TNXAMd6bzS8tMr8l83fqo+4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4qXfETsG/FSgZykO0TrdHPhvdtTj0X0GBwLPuKuYr2tNFp0UWuE6Z457TGtDWF+G4XHa/HfL7lCT8dMgMDOua6/9cv8s8ZQ/SbbGIhb161gdEYFj1uAZBYiiu1V+vzls9WSON1b261ewzE7DpDUwjeOsF0jM4JSNLLkS+FbZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D455C339;
	Tue, 28 May 2024 01:26:38 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71A4D3F641;
	Tue, 28 May 2024 01:26:11 -0700 (PDT)
Date: Tue, 28 May 2024 09:26:04 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Barry Song <21cnbao@gmail.com>, Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Jeff Xie <xiehuan09@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Zach O'Keefe <zokeefe@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] mm: arm64: Fix the out-of-bounds issue in
 contpte_clear_young_dirty_ptes
Message-ID: <ZlWVHC0e2OadjwIa@J2N7QTR9R3>
References: <20240524005444.135417-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524005444.135417-1-21cnbao@gmail.com>

On Fri, May 24, 2024 at 12:54:44PM +1200, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> We are passing a huge nr to __clear_young_dirty_ptes() right
> now. While we should pass the number of pages, we are actually
> passing CONT_PTE_SIZE. This is causing lots of crashes of
> MADV_FREE, panic oops could vary everytime.
> 
> Fixes: 89e86854fb0a ("mm/arm64: override clear_young_dirty_ptes() batch helper")

I was seeing ths same thing on v6.10-rc1 (syzkaller splat and reproducer
included at the end of the mail). The patch makes sense to me, and fixed the
splat in testing, so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Since this only affects arm64 and is already in mainline, I assume the fix
should go via the arm64 tree even though the broken commit went via mm.

Mark.

> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jeff Xie <xiehuan09@gmail.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  arch/arm64/mm/contpte.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 9f9486de0004..a3edced29ac1 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -376,7 +376,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
>  	 * clearing access/dirty for the whole block.
>  	 */
>  	unsigned long start = addr;
> -	unsigned long end = start + nr;
> +	unsigned long end = start + nr * PAGE_SIZE;
>  
>  	if (pte_cont(__ptep_get(ptep + nr - 1)))
>  		end = ALIGN(end, CONT_PTE_SIZE);
> @@ -386,7 +386,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
>  		ptep = contpte_align_down(ptep);
>  	}
>  
> -	__clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
> +	__clear_young_dirty_ptes(vma, start, ptep, (end - start) / PAGE_SIZE, flags);
>  }
>  EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
>  
> -- 
> 2.34.1

---->8----
Syzkaller hit 'KASAN: use-after-free Read in contpte_clear_young_dirty_ptes' bug.

==================================================================
BUG: KASAN: use-after-free in __ptep_get arch/arm64/include/asm/pgtable.h:315 [inline]
BUG: KASAN: use-after-free in __clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1309 [inline]
BUG: KASAN: use-after-free in contpte_clear_young_dirty_ptes+0x264/0x288 arch/arm64/mm/contpte.c:389
Read of size 8 at addr ffff000018c0d000 by task syz-executor392/193

CPU: 0 PID: 193 Comm: syz-executor392 Not tainted 6.10.0-rc1-00001-g30b7f99b25b6 #1
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x12c/0x1f8 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x34/0x50 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x184/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xf4/0x5b0 mm/kasan/report.c:488
 kasan_report+0xc0/0x100 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x20/0x30 mm/kasan/report_generic.c:381
 __ptep_get arch/arm64/include/asm/pgtable.h:315 [inline]
 __clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1309 [inline]
 contpte_clear_young_dirty_ptes+0x264/0x288 arch/arm64/mm/contpte.c:389
 clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1715 [inline]
 madvise_free_pte_range+0xa5c/0x16d8 mm/madvise.c:767
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0xca4/0x1900 mm/pagewalk.c:293
 __walk_page_range+0x4bc/0x5b8 mm/pagewalk.c:395
 walk_page_range+0x4a4/0x840 mm/pagewalk.c:521
 madvise_free_single_vma+0x3a0/0x798 mm/madvise.c:815
 madvise_dontneed_free mm/madvise.c:929 [inline]
 madvise_vma_behavior mm/madvise.c:1046 [inline]
 madvise_walk_vmas mm/madvise.c:1268 [inline]
 do_madvise+0x54c/0x2990 mm/madvise.c:1464
 __do_sys_madvise mm/madvise.c:1481 [inline]
 __se_sys_madvise mm/madvise.c:1479 [inline]
 __arm64_sys_madvise+0x94/0xf8 mm/madvise.c:1479
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x8c/0x2e0 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0xec/0x2a8 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x4c/0x70 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x160 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x120/0x130 arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:598

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x58c0d
flags: 0x3fffe0000000000(node=0|zone=0|lastcpupid=0x1ffff)
raw: 03fffe0000000000 fffffdffc0630388 fffffdffc071cc48 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000018c0cf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff000018c0cf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff000018c0d000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff000018c0d080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff000018c0d100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Syzkaller reproducer:
# {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false HandleSegv:false Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
madvise(&(0x7f0000ffd000/0x3000)=nil, 0x3000, 0x17)
mprotect(&(0x7f0000ffc000/0x4000)=nil, 0x4000, 0x0)
mprotect(&(0x7f0000800000/0x800000)=nil, 0x800000, 0x1)
madvise(&(0x7f0000400000/0xc00000)=nil, 0xc00000, 0x8)


C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE 

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_madvise
#define __NR_madvise 233
#endif
#ifndef __NR_mmap
#define __NR_mmap 222
#endif
#ifndef __NR_mprotect
#define __NR_mprotect 226
#endif

int main(void)
{
		syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
				if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {}
	syscall(__NR_madvise, /*addr=*/0x20ffd000ul, /*len=*/0x3000ul, /*advice=MADV_POPULATE_WRITE*/0x17ul);
	syscall(__NR_mprotect, /*addr=*/0x20ffc000ul, /*len=*/0x4000ul, /*prot=*/0ul);
	syscall(__NR_mprotect, /*addr=*/0x20800000ul, /*len=*/0x800000ul, /*prot=PROT_READ*/1ul);
	syscall(__NR_madvise, /*addr=*/0x20400000ul, /*len=*/0xc00000ul, /*advice=*/8ul);
	return 0;
}



