Return-Path: <linux-kernel+bounces-544025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54526A4DC89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5741883B30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A7A1FFC55;
	Tue,  4 Mar 2025 11:27:22 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D551FCCEF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087642; cv=none; b=nW95ZckMLxE/zm42G9aYiQBmh6JSKkOF2mxqmpKYAMtIUpOcwjZlam0AAhoUd8n2VS842Id3Q/MqEKAI5jBUlLU3GOtIqMksMR37n/TZZtX6aBCLTyUX0p49kLDmXgEXr+v4U7OFELQ1QiYrhXg4GCq++9t4oZDh9oM3L8rsxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087642; c=relaxed/simple;
	bh=6fliJUFEpXP72FbzoYszbCLB843kh8wcfw0Q7PucuuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MN9YM2MDZVKop9Up6fvYYwjYO8k/Y5BZXb0RNxPNxUf30OE8ppQQ5Hog4UDis8YquJGsnA2e/9bN03GLjP1hmChZtPXSMAb17Kli+4t++TAJBMC7d1PVHYqYRLnflwoVoauTPy9HX1W1jZ7vJltD+DhdnoBf5qBzNdqvC/cyiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx12mW48ZnEwuKAA--.39381S3;
	Tue, 04 Mar 2025 19:27:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMAxDcWW48ZnkII1AA--.64929S2;
	Tue, 04 Mar 2025 19:27:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: mm: Set hugetlb mmap base address aligned with pmd size
Date: Tue,  4 Mar 2025 19:27:17 +0800
Message-Id: <20250304112717.1810047-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxDcWW48ZnkII1AA--.64929S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With ltp test case "testcases/bin/hugefork02", there is dmesg error
report message such as
 kernel BUG at mm/hugetlb.c:5550!
 Oops - BUG[#1]:
 CPU: 0 UID: 0 PID: 1517 Comm: hugefork02 Not tainted 6.14.0-rc2+ #241
 Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
 pc 90000000004eaf1c ra 9000000000485538 tp 900000010edbc000 sp 900000010edbf940
 a0 900000010edbfb00 a1 9000000108d20280 a2 00007fffe9474000 a3 00007ffff3474000
 a4 0000000000000000 a5 0000000000000003 a6 00000000003cadd3 a7 0000000000000000
 t0 0000000001ffffff t1 0000000001474000 t2 900000010ecd7900 t3 00007fffe9474000
 t4 00007fffe9474000 t5 0000000000000040 t6 900000010edbfb00 t7 0000000000000001
 t8 0000000000000005 u0 90000000004849d0 s9 900000010edbfa00 s0 9000000108d20280
 s1 00007fffe9474000 s2 0000000002000000 s3 9000000108d20280 s4 9000000002b38b10
 s5 900000010edbfb00 s6 00007ffff3474000 s7 0000000000000406 s8 900000010edbfa08
    ra: 9000000000485538 unmap_vmas+0x130/0x218
   ERA: 90000000004eaf1c __unmap_hugepage_range+0x6f4/0x7d0
  PRMD: 00000004 (PPLV0 +PIE -PWE)
  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
 ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
 PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
 Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfkill vfat fat virtio_net net_failover failover efi_pstore virtio_balloon pstore fuse nfnetlink virtio_scsi dm_multipath efivarfs
 Process hugefork02 (pid: 1517, threadinfo=00000000a670eaf4, task=000000007a95fc64)
 Call Trace:
 [<90000000004eaf1c>] __unmap_hugepage_range+0x6f4/0x7d0
 [<9000000000485534>] unmap_vmas+0x12c/0x218
 [<9000000000494068>] exit_mmap+0xe0/0x308
 [<900000000025fdc4>] mmput+0x74/0x180
 [<900000000026a284>] do_exit+0x294/0x898
 [<900000000026aa30>] do_group_exit+0x30/0x98
 [<900000000027bed4>] get_signal+0x83c/0x868
 [<90000000002457b4>] arch_do_signal_or_restart+0x54/0xfa0
 [<90000000015795e8>] irqentry_exit_to_user_mode+0xb8/0x138
 [<90000000002572d0>] tlb_do_page_fault_1+0x114/0x1b4

The problem is that base address allocated from hugetlbfs is not aligned
with pmd size. Here add checking for hugetlbfs and align base address
with pmd size. After this patch rest case "testcases/bin/hugefork02"
passes to run.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index 914e82ff3f65..1df9e99582cc 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 #include <linux/export.h>
+#include <linux/hugetlb.h>
 #include <linux/io.h>
 #include <linux/kfence.h>
 #include <linux/memblock.h>
@@ -63,8 +64,11 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	}
 
 	info.length = len;
-	info.align_mask = do_color_align ? (PAGE_MASK & SHM_ALIGN_MASK) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
+	else
+		info.align_mask = do_color_align ? (PAGE_MASK & SHM_ALIGN_MASK) : 0;
 
 	if (dir == DOWN) {
 		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-- 
2.39.3


