Return-Path: <linux-kernel+bounces-424386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3AF9DB3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216AE281748
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA014A614;
	Thu, 28 Nov 2024 08:30:50 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0EE145B0F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782650; cv=none; b=hfZypk9BP7u0EKpQgmOysvJoeLW7/AvPU0rU8XHMVDkB+0IwSgX83wl4dCrOHBeztw4Epn6B/VO7JQHQduJL5kYrHD5h4OjKgaFqB5WYWrcu5fTTj5bw42+nNirbvX5CXGAHzBAvb2rGN7hrSU1fdvarGIgoZWqMJ05cVkUnuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782650; c=relaxed/simple;
	bh=m3mCNj6JLx5tq3Dj5xSnk6FCGUKDNblb2HKn/3ljWFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X8oi/I5apWNQOyJfi5aml5xNRTSQN9k2dTrw/b12iHCoS9DFELmC3ftcsCz38JO148Tpc1QzD5rcPGTeraXwMMLU6NLI1NH9HRShh9Sy0fh/dzsAae84oV6C80ZFEPaZOD/LrZMf3HGWLo03MQrU6k5hu1ChBiHc4UtCHZlz5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxGeE0KkhnDYFKAA--.14558S3;
	Thu, 28 Nov 2024 16:30:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMCxrkczKkhnejJrAA--.45781S2;
	Thu, 28 Nov 2024 16:30:44 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Add architecture specific huge_pte_clear
Date: Thu, 28 Nov 2024 16:30:43 +0800
Message-Id: <20241128083043.1208664-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxrkczKkhnejJrAA--.45781S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When executing mm selftests run_vmtests.sh, there is such error:

 BUG: Bad page state in process uffd-unit-tests  pfn:00000
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x0
 flags: 0xffff0000002000(reserved|node=0|zone=0|lastcpupid=0xffff)
 raw: 00ffff0000002000 ffffbf0000000008 ffffbf0000000008 0000000000000000
 raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
 Modules linked in: snd_seq_dummy snd_seq snd_seq_device rfkill vfat fat
    virtio_balloon efi_pstore virtio_net pstore net_failover failover fuse
    nfnetlink virtio_scsi virtio_gpu virtio_dma_buf dm_multipath efivarfs
 CPU: 2 UID: 0 PID: 1913 Comm: uffd-unit-tests Not tainted 6.12.0 #184
 Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
 Stack : 900000047c8ac000 0000000000000000 9000000000223a7c 900000047c8ac000
         900000047c8af690 900000047c8af698 0000000000000000 900000047c8af7d8
         900000047c8af7d0 900000047c8af7d0 900000047c8af5b0 0000000000000001
         0000000000000001 900000047c8af698 10b3c7d53da40d26 0000010000000000
         0000000000000022 0000000fffffffff fffffffffe000000 ffff800000000000
         000000000000002f 0000800000000000 000000017a6d4000 90000000028f8940
         0000000000000000 0000000000000000 90000000025aa5e0 9000000002905000
         0000000000000000 90000000028f8940 ffff800000000000 0000000000000000
         0000000000000000 0000000000000000 9000000000223a94 000000012001839c
         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
         ...
 Call Trace:
 [<9000000000223a94>] show_stack+0x5c/0x180
 [<9000000001c3fd64>] dump_stack_lvl+0x6c/0xa0
 [<900000000056aa08>] bad_page+0x1a0/0x1f0
 [<9000000000574978>] free_unref_folios+0xbf0/0xd20
 [<90000000004e65cc>] folios_put_refs+0x1a4/0x2b8
 [<9000000000599a0c>] free_pages_and_swap_cache+0x164/0x260
 [<9000000000547698>] tlb_batch_pages_flush+0xa8/0x1c0
 [<9000000000547f30>] tlb_finish_mmu+0xa8/0x218
 [<9000000000543cb8>] exit_mmap+0x1a0/0x360
 [<9000000000247658>] __mmput+0x78/0x200
 [<900000000025583c>] do_exit+0x43c/0xde8
 [<9000000000256490>] do_group_exit+0x68/0x110
 [<9000000000256554>] sys_exit_group+0x1c/0x20
 [<9000000001c413b4>] do_syscall+0x94/0x130
 [<90000000002216d8>] handle_syscall+0xb8/0x158
 Disabling lock debugging due to kernel taint
 BUG: non-zero pgtables_bytes on freeing mm: -16384

On LoongArch system, invalid huge pte entry should be invalid_pte_table
or _PAGE_HUGE. And it need be the same with invalid pmd entry, since
pmd_none() is called by function free_pgd_range(), pmd_none() return 0
by huge_pte_clear(). So _PAGE_HUGE is treated as valid pte table and
free_pte_range() will be called in free_pmd_range().

free_pmd_range()
        pmd = pmd_offset(pud, addr);
        do {
                next = pmd_addr_end(addr, end);
                if (pmd_none_or_clear_bad(pmd))
                        continue;
                free_pte_range(tlb, pmd, addr);
        } while (pmd++, addr = next, addr != end);

Here invalid_pte_table is used for both invalid huge pte entry and
pmd entry.

Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/hugetlb.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index b837c65a4894..c8e4057734d0 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -24,6 +24,16 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
+#define __HAVE_ARCH_HUGE_PTE_CLEAR
+static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
+				  pte_t *ptep, unsigned long sz)
+{
+	pte_t clear;
+
+	pte_val(clear) = (unsigned long)invalid_pte_table;
+	set_pte_at(mm, addr, ptep, clear);
+}
+
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr, pte_t *ptep)

base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
-- 
2.39.3


