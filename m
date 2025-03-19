Return-Path: <linux-kernel+bounces-568001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F29A68CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6A3424FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B053F2561DC;
	Wed, 19 Mar 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScrZ32LJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13082255249
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387025; cv=none; b=ajiYcZH1wBlVle1yTKcN+eFwk/EVoMUMBeZaFzvrmK4X5LyDswk8tt36V8g6+hDpl7vT1acD4wCTeUN2LUmLUSC5R8v+Cyl2BFu0KgTaqxuI18+95PQharQYuDf8ux7ULul+Qk2qEAofY009kS88c3eqxyxzjEqNzFC8Rconlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387025; c=relaxed/simple;
	bh=hNFl32LCeGeA501PNntP8FtpjSqRnIpS4NJTM3v5P28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7yBbCcb0OXAFGZB0eH13jZ7rSbCH5j7Cf1S/fUUc4qNTIBUP6zgM1P9mUqtaT2sZbYefgpfH1mgGwUQ+tf2A9UpGwdjAv47Tdzx96O1AEGduejV0r+VSYNzziM5MwZnAyvJComK+FRsB0woyQhUJD+hqnQHFI6LAF3yscLQHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScrZ32LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713CCC4CEE9;
	Wed, 19 Mar 2025 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742387024;
	bh=hNFl32LCeGeA501PNntP8FtpjSqRnIpS4NJTM3v5P28=;
	h=From:To:Cc:Subject:Date:From;
	b=ScrZ32LJZUhOdZyhp8qOjdoI3eTXhdJ+dz1KpqA8EJDXsRMc/CIPaYi/OsJ42e00o
	 j2m/H7jqZbgz6DEi1/+ZjJsrcJ2UOgQvQpqZ1nJuvJDcemfRwignNzJpXmycU6lKAV
	 +lDxlAUNzbv4WsxBms7Agm6wnk9u9cBK/fgw6bN+yVqhNzfUOJ02vi33XdtolXMa/C
	 o9q5lW5MtvHupf6Aib7Wk2f49EczVkTW7A07Y9QqwgMOnU04YdRfzDKChXXl3Tey8y
	 3RJHpj+LeL3496JsqYnFUBcnm0yX6xuj0nIf+R5hxnBeqAysKaiPNfuQupMJkf2nOr
	 XZbnOUQ8IzIaA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] x86/mm: restore early initialization of high_memory for 32-bits
Date: Wed, 19 Mar 2025 14:23:37 +0200
Message-ID: <20250319122337.1538924-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Kernel test robot reports the following crash on 32-bit system with
HIGHMEM and DEBUG_VIRTUAL:

[    0.056128][    T0] kernel BUG at arch/x86/mm/physaddr.c:77!
PANIC: early exception 0x06 IP 60:c116539d error 0 cr2 0x0
[    0.056916][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc4-00010-ga4dbe5c71817 #1
[    0.057570][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.058299][ T0] EIP: __phys_addr (arch/x86/mm/physaddr.c:77)
[ 0.058633][ T0] Code: 00 74 33 89 f0 e8 d3 8b 2e 00 89 c3 0f b6 d0 b8 58 bb 4b c5 31 c9 6a 00 e8 70 f5 15 00 83 c4 04 84 db 74 25 ff 05 78 de 5d c5 <0f> 0b b8 c8 91 ea c4 e8 e7 6e ea ff b8 58 bb 4b c5 31 d2 31 c9 6a
All code
[    0.060017][    T0] EAX: 00000000 EBX: c61f7001 ECX: 00000000 EDX: 00000000
[    0.060519][    T0] ESI: c61f7000 EDI: 061f7000 EBP: c4e31f04 ESP: c61f7000
[    0.061016][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: cff4 EFLAGS: 00210002
[    0.061560][    T0] CR0: 80050033 CR2: 00000000 CR3: 059fc000 CR4: 00000090
[    0.062060][    T0] Call Trace:
[ 0.062288][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:478)
[ 0.062588][ T0] ? early_fixup_exception (arch/x86/include/asm/nospec-branch.h:595)
[ 0.062968][ T0] ? early_idt_handler_common (arch/x86/kernel/head_32.S:352)
[ 0.063360][ T0] ? __phys_addr (arch/x86/mm/physaddr.c:77)
[ 0.063677][ T0] ? one_page_table_init (arch/x86/mm/init_32.c:100)
[ 0.064037][ T0] ? page_table_range_init (arch/x86/mm/init_32.c:227)
[ 0.064411][ T0] ? permanent_kmaps_init (include/linux/pgtable.h:191 include/linux/pgtable.h:196 arch/x86/mm/init_32.c:395)
[ 0.064814][ T0] ? paging_init (arch/x86/mm/init_32.c:677)
[ 0.065118][ T0] ? native_pagetable_init (arch/x86/mm/init_32.c:481)
[ 0.065503][ T0] ? setup_arch (arch/x86/kernel/setup.c:1131)
[ 0.065819][ T0] ? start_kernel (include/linux/jump_label.h:267 init/main.c:920)
[ 0.066143][ T0] ? i386_start_kernel (arch/x86/kernel/head32.c:79)
[ 0.066501][ T0] ? startup_32_smp (arch/x86/kernel/head_32.S:292)

The crash happens because commit e120d1bc12da ("arch, mm: set high_memory
in free_area_init()") moved initialization of high_memory after
__vmalloc_start_set and with high_memory still set to 0 any address passes
is_vmalloc_addr() check.

Restore early initialization of high_memory on 32-bit systems in
initmem_init().

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503191442.112e954f-lkp@intel.com
Fixes: e120d1bc12da ("arch, mm: set high_memory in free_area_init()")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---

@Andrew, if it's still possible would be great to fold it into e120d1bc12da
("arch, mm: set high_memory in free_area_init()").

I think it can be fixed without restoring high_memory initialization in
initmem_init(), but I didn't want to try anything less straightforward 


 arch/x86/mm/init_32.c | 3 +++
 arch/x86/mm/numa_32.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 95b2758b4e4d..f69d2436d780 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -626,6 +626,9 @@ void __init initmem_init(void)
 		highstart_pfn = max_low_pfn;
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 		pages_to_mb(highend_pfn - highstart_pfn));
+	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
+#else
+	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
index 442ef3facff0..65fda406e6f2 100644
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@ -41,6 +41,9 @@ void __init initmem_init(void)
 		highstart_pfn = max_low_pfn;
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 	       pages_to_mb(highend_pfn - highstart_pfn));
+	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
+#else
+	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(max_low_pfn));

base-commit: a211c6550efcc87aa2459ca347bda10721c7a46a
-- 
2.47.2


