Return-Path: <linux-kernel+bounces-304806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C096252A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4380FB21AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466C316CD3A;
	Wed, 28 Aug 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c68NHvjB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67640161B43;
	Wed, 28 Aug 2024 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841912; cv=none; b=lMFBk0rCBOsyVMyv6xXWI0XcERS5jIx1Fg5QLMpR1yLcO9C7xCZgNckFBC144SMG5YKj/6gXq+mUGjbB+cDsNqanT3VIFP2NAf2czMpyqoLVKlH+KquXudC9B7PRheQq4WbRaslClAy9cHyIzJEUhMJYM6vhVfHRzfYARK2/P5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841912; c=relaxed/simple;
	bh=CSttk8qWYh0L7FtKrtbr/wO88fqBxzV+ophC2i98DGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C77TBUwvI1H3n1dBa2bm5fprvFdo2IgeHoM2DDELlHYUrACX3OoEUeeqaNDqpJmARtvB83uJ12NaJu/bSVARMYR31AYpt5oJ9TiyXeZL0xz33beHjgdq0qfqPP9zZdEG1vf1j/DF5erSG36yzH9VUJoqyJgztqWuX7zsJx67ef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c68NHvjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31275C98EC0;
	Wed, 28 Aug 2024 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724841912;
	bh=CSttk8qWYh0L7FtKrtbr/wO88fqBxzV+ophC2i98DGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c68NHvjBM6D+u2lLDRMa6o8NA+g9NjrVI++9Qlw9jnAX6+zv4LvKlk3JugFiiHsQP
	 UaYN0iFg0+8vVnzFuGuosm2QZq8yz1HJxNGPd8W+p6QAm0BfVCxgMSi9QpaaX04zUV
	 5my9jLnm5/1ZKYits0+FB5Z+x9VNW8o9tN6/TM8ZfMr+TNr2/yOY39mImVALGVx7Tj
	 aEthHFxG+a1ZfbqME+A8oiKy8hEvg004vPg56TYqWsYwdmdivg5I01HZFc6Yly6Q4+
	 6I+m3tWnLMP5Ocn7aPAzU+pv2EYLQxMsSdRZ1sTjEijpvmXHgyC520J+jjG8QLjYDp
	 R+IlHG0xeysBQ==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com
Subject: [PATCH v5 2/6] x86/tdx: Add validation of userspace MMIO instructions
Date: Wed, 28 Aug 2024 12:44:32 +0200
Message-ID: <3204e85f96694e81817b22bf1d46ab3ff1ee5a91.1724837158.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724837158.git.legion@kernel.org>
References: <cover.1724248680.git.legion@kernel.org> <cover.1724837158.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

Instructions from kernel space are considered trusted. If the MMIO
instruction is from userspace it must be checked.

For userspace instructions, it is need to check that the INSN has not
changed at the time of #VE and before the execution of the instruction.

Once the userspace instruction parsed is enforced that the address
points to mapped memory of current process and that address does not
point to private memory.

After parsing the userspace instruction, it is necessary to ensure that:

1. the operation direction (read/write) corresponds to #VE info;
2. the address still points to mapped memory of current process;
3. the address does not point to private memory.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 131 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index af0b6c1cacf7..99634e12f9a7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -405,6 +406,87 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 			       EPT_WRITE, addr, val);
 }
 
+static inline bool is_private_gpa(u64 gpa)
+{
+	return gpa == cc_mkenc(gpa);
+}
+
+static int get_phys_addr(unsigned long addr, phys_addr_t *phys_addr, bool *writable)
+{
+	unsigned int level;
+	pgd_t *pgdp;
+	pte_t *ptep;
+
+	/*
+	 * Address validation only makes sense for a user process. The lock must
+	 * be obtained before validation can begin.
+	 */
+	mmap_assert_locked(current->mm);
+
+	pgdp = pgd_offset(current->mm, addr);
+
+	if (!pgd_none(*pgdp)) {
+		ptep = lookup_address_in_pgd(pgdp, addr, &level);
+		if (ptep) {
+			unsigned long offset;
+
+			if (!pte_decrypted(*ptep))
+				return -EFAULT;
+
+			offset = addr & ~page_level_mask(level);
+			*phys_addr = PFN_PHYS(pte_pfn(*ptep));
+			*phys_addr |= offset;
+
+			*writable = pte_write(*ptep);
+
+			return 0;
+		}
+	}
+
+	return -EFAULT;
+}
+
+static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
+		       unsigned long vaddr)
+{
+	phys_addr_t phys_addr;
+	bool writable = false;
+
+	/* It's not fatal. This can happen due to swap out or page migration. */
+	if (get_phys_addr(vaddr, &phys_addr, &writable) || (ve->gpa != cc_mkdec(phys_addr)))
+		return -EAGAIN;
+
+	/*
+	 * Re-check whether #VE info matches the instruction that was decoded.
+	 *
+	 * The ve->gpa was valid at the time ve_info was received. But this code
+	 * executed with interrupts enabled, allowing tlb shootdown and therefore
+	 * munmap() to be executed in the parallel thread.
+	 *
+	 * By the time MMIO emulation is performed, ve->gpa may be already
+	 * unmapped from the process, the device it belongs to removed from
+	 * system and something else could be plugged in its place.
+	 */
+	switch (mmio) {
+	case INSN_MMIO_WRITE:
+	case INSN_MMIO_WRITE_IMM:
+		if (!writable || !(ve->exit_qual & EPT_VIOLATION_ACC_WRITE))
+			return -EFAULT;
+		break;
+	case INSN_MMIO_READ:
+	case INSN_MMIO_READ_ZERO_EXTEND:
+	case INSN_MMIO_READ_SIGN_EXTEND:
+		if (!(ve->exit_qual & EPT_VIOLATION_ACC_READ))
+			return -EFAULT;
+		break;
+	default:
+		WARN_ONCE(1, "Unsupported mmio instruction: %d", mmio);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
 			     struct pt_regs *regs, struct ve_info *ve)
 {
@@ -489,7 +571,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	enum insn_mmio_type mmio;
 	struct insn insn = {};
 	unsigned long vaddr;
-	int size;
+	int size, ret;
 
 	/* Only in-kernel MMIO is supported */
 	if (WARN_ON_ONCE(user_mode(regs)))
@@ -505,6 +587,17 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
+	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
+
+	if (user_mode(regs)) {
+		if (mmap_read_lock_killable(current->mm))
+			return -EINTR;
+
+		ret = valid_vaddr(ve, mmio, size, vaddr);
+		if (ret)
+			goto unlock;
+	}
+
 	/*
 	 * Reject EPT violation #VEs that split pages.
 	 *
@@ -514,30 +607,39 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	 *
 	 * load_unaligned_zeropad() will recover using exception fixups.
 	 */
-	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
-	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE)
-		return -EFAULT;
+	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE) {
+		ret = -EFAULT;
+		goto unlock;
+	}
 
 	switch (mmio) {
 	case INSN_MMIO_WRITE:
 	case INSN_MMIO_WRITE_IMM:
 	case INSN_MMIO_MOVS:
-		return handle_mmio_write(&insn, mmio, size, regs, ve);
+		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
+		break;
 	case INSN_MMIO_READ:
 	case INSN_MMIO_READ_ZERO_EXTEND:
 	case INSN_MMIO_READ_SIGN_EXTEND:
-		return handle_mmio_read(&insn, mmio, size, regs, ve);
+		ret = handle_mmio_read(&insn, mmio, size, regs, ve);
+		break;
 	case INSN_MMIO_DECODE_FAILED:
 		/*
 		 * MMIO was accessed with an instruction that could not be
 		 * decoded or handled properly. It was likely not using io.h
 		 * helpers or accessed MMIO accidentally.
 		 */
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	default:
 		WARN_ONCE(1, "Unknown insn_decode_mmio() decode value?");
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+unlock:
+	if (user_mode(regs))
+		mmap_read_unlock(current->mm);
+
+	return ret;
 }
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
@@ -681,11 +783,6 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 	}
 }
 
-static inline bool is_private_gpa(u64 gpa)
-{
-	return gpa == cc_mkenc(gpa);
-}
-
 /*
  * Handle the kernel #VE.
  *
@@ -723,6 +820,14 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 		insn_len = virt_exception_user(regs, ve);
 	else
 		insn_len = virt_exception_kernel(regs, ve);
+
+	/*
+	 * A special case to return to userspace without increasing regs->ip
+	 * to repeat the instruction once again.
+	 */
+	if (insn_len == -EAGAIN)
+		return true;
+
 	if (insn_len < 0)
 		return false;
 
-- 
2.46.0


