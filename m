Return-Path: <linux-kernel+bounces-318814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7DC96F3A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7671C24424
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C24E1D1F56;
	Fri,  6 Sep 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHpRe3Io"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71261D1F4C;
	Fri,  6 Sep 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623448; cv=none; b=LPrEyZZQFs5h672gmcleEXISdVIEOpzKc2PeURv57QdzyaOo08EpVXljD7hEWYlG9NXI5rvNNn3svSP5rsqP2RFxes/x0dt0k3LixNylFyKoaKA2vE1+kkRZ9/TLCkxbQXOUvZkerRHFwyvoShxpifYZ5zUN7l+xRmFc1xbex+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623448; c=relaxed/simple;
	bh=M6QG7RSHZyfTN3bb9NVhngy9EM9gc/GYCBRBb0sVdvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2UzYPDb+CfjsfEDBc2dH87PtdR0Xs5/T4mJ7gEkilpcsWH7C0pAG9jpTA1A2Vu01sGxg3UbEeVaZ1wY3rKuL6FNcrFFTVMpvv9gfFE+1P6E1DZ48LLfYPPTVZ0uJcAc5eVmw1R9l0kXRYB0oYgBq+dCre5IEblujkFWO7p3meo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHpRe3Io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516C0C4CEC4;
	Fri,  6 Sep 2024 11:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725623448;
	bh=M6QG7RSHZyfTN3bb9NVhngy9EM9gc/GYCBRBb0sVdvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHpRe3IoTXrlZE9hUf+3MJuXeDUTMClwDSJc8MYLjLnN0HovejYPrbsAtZ2HdMSM/
	 tt+JOUbVWrBcK/j3NxM2jklde+47WOd9OM/DQtzUPHIpl5a+M4mCRpYGKNroYynybp
	 8euNJz4fJklIfEoYEEh+UYUWo7tgxVKm9L0b93UfoI8MmSWyTvx4zf0rYqwNE0/fb+
	 hEZBNTZfJlYEO7Mw1pYbR9a6m2HTgBaClg7VZj+TvgUvufckxiGjBPMzpUlYHi9E7/
	 7uT8LZm2NJ/JCo3A0cXCeCBmy0ovEvhNBqYjA3p9/zQXtxmBt/hZ3rvqk28XURY3sU
	 awtcSiq1G/DXQ==
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
Subject: [PATCH v6 6/6] x86/tdx: Implement MOVS for MMIO
Date: Fri,  6 Sep 2024 13:50:04 +0200
Message-ID: <017887cf42991777c96949ecf81469965113b412.1725622408.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725622408.git.legion@kernel.org>
References: <cover.1724837158.git.legion@kernel.org> <cover.1725622408.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
consists of dividing it into a series of read and write operations,
which in turn will be validated separately.

This implementation is based on the same principle as in SEV. It splits
MOVS into separate read and write operations, which in turn can cause
nested #VEs depending on which of the arguments caused the first #VE.

The difference with the SEV implementation is the execution context. SEV
code is executed in atomic context. Exception handler in TDX is executed
with interrupts enabled. That's why the approach to locking is
different. In TDX, mmap_lock is taken to verify and emulate the
instruction.

Another difference is how the read and write instructions are executed
for MOVS emulation. While in SEV each read/write operation returns to
user space, in TDX these operations are performed from the kernel
context.

It may be possible to achieve more code reuse at this point,
but it would require confirmation from SEV that such a thing wouldn't
break anything.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c          | 83 +++++++++++++++++++++++++++++---
 arch/x86/include/asm/processor.h |  3 ++
 2 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1e391897e34f..7e760f03fa1e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -518,6 +518,60 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
 	return 0;
 }
 
+static int handle_mmio_movs(struct insn *insn, struct pt_regs *regs, int size, struct ve_info *ve)
+{
+	unsigned long ds_base, es_base;
+	unsigned char *src, *dst;
+	unsigned char buffer[8];
+	int off, ret;
+	bool rep;
+
+	/*
+	 * The in-kernel code must use a special API that does not use MOVS.
+	 * If the MOVS instruction is received from in-kernel, then something
+	 * is broken.
+	 */
+	if (WARN_ON_ONCE(!user_mode(regs)))
+		return -EFAULT;
+
+	ds_base = insn_get_seg_base(regs, INAT_SEG_REG_DS);
+	es_base = insn_get_seg_base(regs, INAT_SEG_REG_ES);
+
+	if (ds_base == -1L || es_base == -1L)
+		return -EINVAL;
+
+	current->thread.in_mmio_emul = 1;
+
+	rep = insn_has_rep_prefix(insn);
+
+	do {
+		src = ds_base + (unsigned char *) regs->si;
+		dst = es_base + (unsigned char *) regs->di;
+
+		ret = __get_iomem(src, buffer, size);
+		if (ret)
+			goto out;
+
+		ret = __put_iomem(dst, buffer, size);
+		if (ret)
+			goto out;
+
+		off = (regs->flags & X86_EFLAGS_DF) ? -size : size;
+
+		regs->si += off;
+		regs->di += off;
+
+		if (rep)
+			regs->cx -= 1;
+	} while (rep || regs->cx > 0);
+
+	ret = insn->length;
+out:
+	current->thread.in_mmio_emul = 0;
+
+	return ret;
+}
+
 static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
 			     struct pt_regs *regs, struct ve_info *ve)
 {
@@ -539,9 +593,8 @@ static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int si
 		return insn->length;
 	case INSN_MMIO_MOVS:
 		/*
-		 * MMIO was accessed with an instruction that could not be
-		 * decoded or handled properly. It was likely not using io.h
-		 * helpers or accessed MMIO accidentally.
+		 * MOVS is processed through higher level emulation which breaks
+		 * this instruction into a sequence of reads and writes.
 		 */
 		return -EINVAL;
 	default:
@@ -600,6 +653,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
 	enum insn_mmio_type mmio;
 	struct insn insn = {};
+	int need_validation;
 	unsigned long vaddr;
 	int size, ret;
 
@@ -611,13 +665,27 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
+	if (mmio == INSN_MMIO_MOVS)
+		return handle_mmio_movs(&insn, regs, size, ve);
+
+	need_validation = user_mode(regs);
+
 	if (!user_mode(regs) && !is_kernel_addr(ve->gla)) {
-		WARN_ONCE(1, "Access to userspace address is not supported");
-		return -EINVAL;
+		/*
+		 * Access from kernel to userspace addresses is not allowed
+		 * unless it is a nested exception during MOVS emulation.
+		 */
+		if (!current->thread.in_mmio_emul || !current->mm) {
+			WARN_ONCE(1, "Access to userspace address is not supported");
+			return -EINVAL;
+		}
+
+		need_validation = 1;
+	}
 
 	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
 
-	if (user_mode(regs)) {
+	if (need_validation) {
 		if (mmap_read_lock_killable(current->mm))
 			return -EINTR;
 
@@ -643,7 +711,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	switch (mmio) {
 	case INSN_MMIO_WRITE:
 	case INSN_MMIO_WRITE_IMM:
-	case INSN_MMIO_MOVS:
 		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
 		break;
 	case INSN_MMIO_READ:
@@ -664,7 +731,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 		ret = -EINVAL;
 	}
 unlock:
-	if (user_mode(regs))
+	if (need_validation)
 		mmap_read_unlock(current->mm);
 
 	return ret;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a75a07f4931f..33875a217ed8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -486,6 +486,9 @@ struct thread_struct {
 	unsigned long		iopl_emul;
 
 	unsigned int		iopl_warn:1;
+#ifdef CONFIG_INTEL_TDX_GUEST
+	unsigned int		in_mmio_emul:1;
+#endif
 
 	/*
 	 * Protection Keys Register for Userspace.  Loaded immediately on
-- 
2.46.0


