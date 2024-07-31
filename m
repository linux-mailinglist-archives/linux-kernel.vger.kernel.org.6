Return-Path: <linux-kernel+bounces-268806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4673494297C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05631F23026
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8311A8C1F;
	Wed, 31 Jul 2024 08:46:41 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C81A8BF3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415601; cv=none; b=Qz8hlw+zfNBvMA/SyNxOGGdHIpKmxsn3/Wt/efCCwlQm7nvU+593SBGCZmSYlHndcXuPia/2KcmJaJGILHENRdsSgFHOH9fEGUG3RNIqBBgt5+BS0J1RBMZ9YfQ9ewxYAcuhpZwfYXhgPhcc94qkuH0wWPwnJjr40/JziRVw47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415601; c=relaxed/simple;
	bh=hrz93HvjivqZ5V5bHZKOQM4qfzHXw4zHOmAzTYfhr0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZDgtNacHKcegedq2wGu8rECCCU4r5bv8lEOxl04VVgdKcVmnX3n1r55yoD9DXi8nEwwk8MR/idRRy8nmeu6v7uB9pJITWHKhjVsA/CEf5Mz2RNPZuUJvP6ot7fJ3kCILowF6yDNSy9ee+goVSS5qC/wAmk5CRCt5vtVgPeYXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowAAnL0vM+almQ41wAg--.11181S2;
	Wed, 31 Jul 2024 16:46:05 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	surenb@google.com,
	akpm@linux-foundation.org,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn,
	willy@infradead.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()
Date: Wed, 31 Jul 2024 16:45:47 +0800
Message-ID: <20240731084547.85380-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnL0vM+almQ41wAg--.11181S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw13urW8uw1fJFy5WrWUtwb_yoW8XrWDpF
	Wakay7urZ2qrnayFZ2kr1UXa1ruas5tw1jkry2kasY9r4Uur15Wws5Aw4kXryjqFy8JFy5
	Ar4YkryrZa4q9wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

Handle VM_FAULT_SIGSEGV in the page fault path so that we correctly
kill the process and we don't BUG() the kernel.

Fixes: 07037db5d479 ("RISC-V: Paging and MMU")
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
v1->v2:
Modify commit message.
---
 arch/riscv/mm/fault.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 5224f3733802..a9f2b4af8f3f 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -61,26 +61,27 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 
 static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
 {
+	if (!user_mode(regs)) {
+		no_context(regs, addr);
+		return;
+	}
+
 	if (fault & VM_FAULT_OOM) {
 		/*
 		 * We ran out of memory, call the OOM killer, and return the userspace
 		 * (which will retry the fault, or kill us if we got oom-killed).
 		 */
-		if (!user_mode(regs)) {
-			no_context(regs, addr);
-			return;
-		}
 		pagefault_out_of_memory();
 		return;
 	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
 		/* Kernel mode? Handle exceptions or die */
-		if (!user_mode(regs)) {
-			no_context(regs, addr);
-			return;
-		}
 		do_trap(regs, SIGBUS, BUS_ADRERR, addr);
 		return;
+	} else if (fault & VM_FAULT_SIGSEGV) {
+		do_trap(regs, SIGSEGV, SEGV_MAPERR, addr);
+		return;
 	}
+
 	BUG();
 }
 
-- 
2.43.0


