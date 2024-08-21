Return-Path: <linux-kernel+bounces-295666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E94959FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A0A1F2461E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2201B3B35;
	Wed, 21 Aug 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX+iGplY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC31B3B2A;
	Wed, 21 Aug 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250372; cv=none; b=LaCiMXNjVk9S1BxGboM8qe29Ss+9bAC1ky2CFLq41HKedV2xmnnNRhMjHQPiwETL4v342cxTJRY0q5knPB89nI6rd961QZCl2MdmheUByEgTC7y2jHdU7X3nZUfvyILijLMrC3keFQf02G6PLn9sWkEeg/TNxNCFdORT1KhToBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250372; c=relaxed/simple;
	bh=sqVXi89tYI0s7IoD92jonGg926UqsYeyDX6OHzOQkVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIC1diRywrRJSG0oIhzdot+N0QHEoZQT2D30zFSnqMScDq5OK9f6WNXFkGm1emxNjgi5zGpnfY8S+PqikeG3BlezhtNJn4YRvo+Qj/QdTtad9oS9x81h6O6GgJp7fuOgDrNYiFdN1GTGpqFOwTobHmPBCoHjkX1RNxbPHKX34Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX+iGplY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7113EC32781;
	Wed, 21 Aug 2024 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724250372;
	bh=sqVXi89tYI0s7IoD92jonGg926UqsYeyDX6OHzOQkVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rX+iGplYwaRwPZ3u5hFLSpySpuM7etMXZeMR0dg9CqRY4P3PkUlYmmomke28wJF5X
	 TTDlR+7andARIC6sKyvg4yCFiXPL/IYsLTYRyKAogE/ewRFnFP8HxVnfWFapkyhbeG
	 +gvc6VwEqlM3WjBncVN+Q/qOKlRpbdBjVoXWIjLm8eZ6COuTYS4djJ0uCXUBOxVuss
	 5Q6eJkbuzvtNflfCPdAvNNPQnB3mCCurL5sccdoTeyZCMxJNb3O7J6v+lTN0ZfV7hh
	 tgfyQUUWUaik0eJheuU3Wa+il8fKmT5JrLAzf85lDUswYWlhDt5LZeh2dg8XzfPxx/
	 CXj0iaUX0nFnQ==
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
Subject: [PATCH v4 6/6] x86/tdx: Implement movs for MMIO
Date: Wed, 21 Aug 2024 16:24:38 +0200
Message-ID: <9320e721e609e55a020d3eb98f48fc856371c561.1724248680.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724248680.git.legion@kernel.org>
References: <cover.1723807851.git.legion@kernel.org> <cover.1724248680.git.legion@kernel.org>
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

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c          | 84 +++++++++++++++++++++++++++++---
 arch/x86/include/asm/processor.h |  4 ++
 2 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 65f65015238a..d4bec84de034 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -518,6 +518,62 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
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
+	rep = insn_has_rep_prefix(insn);
+
+	do {
+		src = ds_base + (unsigned char *) regs->si;
+		dst = es_base + (unsigned char *) regs->di;
+
+		current->thread.mmio_emul = (unsigned long) src;
+
+		ret = __get_iomem(src, buffer, size);
+		if (ret)
+			goto out;
+
+		current->thread.mmio_emul = (unsigned long) dst;
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
+	current->thread.mmio_emul = 0;
+
+	return ret;
+}
+
 static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
 			     struct pt_regs *regs, struct ve_info *ve)
 {
@@ -539,9 +595,8 @@ static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int si
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
@@ -600,6 +655,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
 	enum insn_mmio_type mmio;
 	struct insn insn = {};
+	int need_validation;
 	unsigned long vaddr;
 	int size, ret;
 
@@ -611,14 +667,27 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
+		if (current->thread.mmio_emul != ve->gla || !current->mm) {
+			WARN_ONCE(1, "Access to userspace address is not supported");
+			return -EINVAL;
+		}
+
+		need_validation = 1;
 	}
 
 	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
 
-	if (user_mode(regs)) {
+	if (need_validation) {
 		if (mmap_read_lock_killable(current->mm))
 			return -EINTR;
 
@@ -644,7 +713,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	switch (mmio) {
 	case INSN_MMIO_WRITE:
 	case INSN_MMIO_WRITE_IMM:
-	case INSN_MMIO_MOVS:
 		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
 		break;
 	case INSN_MMIO_READ:
@@ -665,7 +733,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 		ret = -EINVAL;
 	}
 unlock:
-	if (user_mode(regs))
+	if (need_validation)
 		mmap_read_unlock(current->mm);
 
 	return ret;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a75a07f4931f..45136b1b02cc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -503,6 +503,10 @@ struct thread_struct {
 	struct thread_shstk	shstk;
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+	unsigned long		mmio_emul;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
-- 
2.45.2


