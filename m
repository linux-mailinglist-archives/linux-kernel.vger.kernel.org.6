Return-Path: <linux-kernel+bounces-438977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F49EA8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD71E167620
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDD822CBCC;
	Tue, 10 Dec 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cVlCVeo8"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57451D7E31
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813597; cv=none; b=sGTTuzyJnGW3l5MCPBkYi1gKtlDS3seYzqP15BIc1eUofg169AOR8zYurEB0prTFz1ZnmxBWgUHEjBZ4ortVEbGZHyxTPzglvkLxc+LKqH4yMwueS0kyX/UqLLYDjWqJ0NMpAXhbwerTTz07mesSQR39rZ/zr7gSwV8xDlqW5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813597; c=relaxed/simple;
	bh=ut5JAkYztnQBo6RdRBF+10lftaJlehSlM8UEIZYLWwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kjab3EEeJQ8UvKauKxrYnLpBPIFVBCm9Rbcpb3m97ZGM3NyUX+YRjybQU3ta0X3M7QTwgPbfkReKQcnL/4YlGzxe6Et115NajuTerP9iD3GXovMRG5GnT80AG/2Gm9aGaifknRPQRlvD1oqUmFwWZU13ZyXEdkcsLaZiqmwGE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cVlCVeo8; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733813591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e12qJKNRrXaJEuaxEsHAVfWP9J4uhR6b+tP4H87o7vQ=;
	b=cVlCVeo8wkb+TN/q0OW+dRDF9yAUygDh+uxzILPdJknnZBEXoiswET2A/BIq2/KRdEOQ70
	JHAnmfPA2BuCXKbH6D4NVtXsISWG5S6qCdtC9Ka2zoI/0fjtbs0GaKXDAbAn+FCxDMy3Z/
	egMpZo/FcmJ7gF1G6/snxcIqfcDe23s=
From: Hao Ge <hao.ge@linux.dev>
To: surenb@google.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	greearb@candelatech.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] mm/alloc_tag: Add kasan_alloc_module_shadow when CONFIS_KASAN_VMALLOC disabled
Date: Tue, 10 Dec 2024 14:53:04 +0800
Message-Id: <20241210065304.781620-1-hao.ge@linux.dev>
In-Reply-To: <20241210041515.765569-1-hao.ge@linux.dev>
References: <20241210041515.765569-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

When CONFIG_KASAN is enabled but CONFIG_KASAN_VMALLOC
is not enabled, we may encounter a panic during system boot.

Because we haven't allocated pages and created mappings
for the shadow memory corresponding to module_tags region,
similar to how it is done for execmem_vmalloc.

The difference is that our module_tags are allocated on demand,
so similarly,we also need to allocate shadow memory regions on demand.
However, we still need to adhere to the MODULE_ALIGN principle.

Here is the log for panic:

[   18.349421] BUG: unable to handle page fault for address: fffffbfff8092000
[   18.350016] #PF: supervisor read access in kernel mode
[   18.350459] #PF: error_code(0x0000) - not-present page
[   18.350904] PGD 20fe52067 P4D 219dc8067 PUD 219dc4067 PMD 102495067 PTE 0
[   18.351484] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   18.351961] CPU: 5 UID: 0 PID: 1 Comm: systemd Not tainted 6.13.0-rc1+ #3
[   18.352533] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   18.353494] RIP: 0010:kasan_check_range+0xba/0x1b0
[   18.353931] Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 dd 00 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 c2 0f 84 c1 00 00 00 <48> 83 38 00 74 ed 48 8d 50 08 eb 0d 48 83 c0 01 48 39 d0 0f 84 90
[   18.355484] RSP: 0018:ff11000101877958 EFLAGS: 00010206
[   18.355937] RAX: fffffbfff8092000 RBX: fffffbfff809201e RCX: ffffffff82a7ceac
[   18.356542] RDX: fffffbfff8092018 RSI: 00000000000000f0 RDI: ffffffffc0490000
[   18.357153] RBP: fffffbfff8092000 R08: 0000000000000001 R09: fffffbfff809201d
[   18.357756] R10: ffffffffc04900ef R11: 0000000000000003 R12: ffffffffc0490000
[   18.358365] R13: ff11000101877b48 R14: ffffffffc0490000 R15: 000000000000002c
[   18.358968] FS:  00007f9bd13c5940(0000) GS:ff110001eb480000(0000) knlGS:0000000000000000
[   18.359648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.360178] CR2: fffffbfff8092000 CR3: 0000000109214004 CR4: 0000000000771ef0
[   18.360790] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   18.361404] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   18.362020] PKRU: 55555554
[   18.362261] Call Trace:
[   18.362481]  <TASK>
[   18.362671]  ? __die+0x23/0x70
[   18.362964]  ? page_fault_oops+0xc2/0x160
[   18.363318]  ? exc_page_fault+0xad/0xc0
[   18.363680]  ? asm_exc_page_fault+0x26/0x30
[   18.364056]  ? move_module+0x3cc/0x8a0
[   18.364398]  ? kasan_check_range+0xba/0x1b0
[   18.364755]  __asan_memcpy+0x3c/0x60
[   18.365074]  move_module+0x3cc/0x8a0
[   18.365386]  layout_and_allocate.constprop.0+0x3d5/0x720
[   18.365841]  ? early_mod_check+0x3dc/0x510
[   18.366195]  load_module+0x72/0x1850
[   18.366509]  ? __pfx_kernel_read_file+0x10/0x10
[   18.366918]  ? vm_mmap_pgoff+0x21c/0x2d0
[   18.367262]  init_module_from_file+0xd1/0x130
[   18.367638]  ? __pfx_init_module_from_file+0x10/0x10
[   18.368073]  ? __pfx__raw_spin_lock+0x10/0x10
[   18.368456]  ? __pfx_cred_has_capability.isra.0+0x10/0x10
[   18.368938]  idempotent_init_module+0x22c/0x790
[   18.369332]  ? simple_getattr+0x6f/0x120
[   18.369676]  ? __pfx_idempotent_init_module+0x10/0x10
[   18.370110]  ? fdget+0x58/0x3a0
[   18.370393]  ? security_capable+0x64/0xf0
[   18.370745]  __x64_sys_finit_module+0xc2/0x140
[   18.371136]  do_syscall_64+0x7d/0x160
[   18.371459]  ? fdget_pos+0x1c8/0x4c0
[   18.371784]  ? ksys_read+0xfd/0x1d0
[   18.372106]  ? syscall_exit_to_user_mode+0x10/0x1f0
[   18.372525]  ? do_syscall_64+0x89/0x160
[   18.372860]  ? do_syscall_64+0x89/0x160
[   18.373194]  ? do_syscall_64+0x89/0x160
[   18.373527]  ? syscall_exit_to_user_mode+0x10/0x1f0
[   18.373952]  ? do_syscall_64+0x89/0x160
[   18.374283]  ? syscall_exit_to_user_mode+0x10/0x1f0
[   18.374701]  ? do_syscall_64+0x89/0x160
[   18.375037]  ? do_user_addr_fault+0x4a8/0xa40
[   18.375416]  ? clear_bhb_loop+0x25/0x80
[   18.375748]  ? clear_bhb_loop+0x25/0x80
[   18.376119]  ? clear_bhb_loop+0x25/0x80
[   18.376450]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populated area calculation")
Reported-by: Ben Greear <greearb@candelatech.com>
Closes: https://lore.kernel.org/all/1ba0cc57-e2ed-caa2-1241-aa5615bee01f@candelatech.com/
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Add comments to facilitate understanding of the code.
    Add align nr << PAGE_SHIFT to MODULE_ALIGN,even though kasan_alloc_module_shadow
    already handles this internally,but to make the code more readable and user-friendly

commit 233e89322cbe ("alloc_tag: fix module allocation
tags populated area calculation") is currently in the
mm-hotfixes-unstable branch, so this patch is
developed based on the mm-hotfixes-unstable branch.
---
 lib/alloc_tag.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index f942408b53ef..bd3ee57ea13f 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -10,6 +10,7 @@
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
+#include <linux/math.h>
 
 #define ALLOCINFO_FILE_NAME		"allocinfo"
 #define MODULE_ALLOC_TAG_VMAP_SIZE	(100000UL * sizeof(struct alloc_tag))
@@ -422,6 +423,17 @@ static int vm_module_tags_populate(void)
 			return -ENOMEM;
 		}
 		vm_module_tags->nr_pages += nr;
+
+		/*
+		 * Kasan allocates 1 byte of shadow for every 8 bytes of data.
+		 * When kasan_alloc_module_shadow allocates shadow memory,
+		 * it does so in units of pages.
+		 * Therefore, here we need to align to MODULE_ALIGN.
+		 */
+		if ((phys_end & (MODULE_ALIGN - 1)) == 0)
+			kasan_alloc_module_shadow((void *)phys_end,
+						  round_up(nr << PAGE_SHIFT, MODULE_ALIGN),
+						  GFP_KERNEL);
 	}
 
 	/*
-- 
2.25.1


