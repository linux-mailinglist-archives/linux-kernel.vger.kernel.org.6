Return-Path: <linux-kernel+bounces-289760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEF6954B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098EA1F23C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38A71C0DD3;
	Fri, 16 Aug 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPZFAyUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F11BF33E;
	Fri, 16 Aug 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815936; cv=none; b=uZjGFMmyGrojV2ami7OQGElaRB8XRD9pc6kSz0FfWKvz7ImvANFciXRMhDnoZTsGSLdEVf0cWCEZGHLrZXDomBOGEpW/ijSkyZbtyMMdVyo75cjYAw5ClXRiAABnK9E3etM8IDhWI6H1+WmEDdctmKUisUuaorOjoq1D5vFkeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815936; c=relaxed/simple;
	bh=J6D/pX0gxICYDzXbUUkRtLzUc3rT8YgO+JQ+TyXNZvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0/bZswOePV+63crapqke3yeUNOvFsaXu/uLdguzjbqX6eEYf4msCK+C7IOFD5tFu2EiCopQhG3r+1F6vHj9Cb4vtXvQDNkhVL85ursWctkxy2e1xQVEnhvXEwtaVdz1tEYO5K2z1yWb501CRyYNhEf6J4SBEyakMRS4t+f5F6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPZFAyUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F05C4AF09;
	Fri, 16 Aug 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815935;
	bh=J6D/pX0gxICYDzXbUUkRtLzUc3rT8YgO+JQ+TyXNZvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPZFAyUxEjZommVT54ebufc5IxjHNrx7IuukX/2g02Rc6m0m5mvVVC0ju6Msabq10
	 snnjgvJnzr5sMgRv5ZZBOB62Ac4tdQaA28G9queScqPqlzdDYQNjfKeLSsiMe1HWFj
	 eU2xbmVPoiQiwsArSIKXLWWYnbxzV1W4qxQFZ5w9788iLnZT+ddf/3zHmfMJjz5w40
	 jbnJqu8SLuCnIYiNv2UWiddc26yea8k5Xqlh1kTBUjUY3FjjZxEQMObooty9p/Yzml
	 M0g+nO5dsJFIlsOkAl2UT6sS2PIS/nAvMkfilJKUQSvuWZZhwr8+5NNX6JB56iVL4d
	 aSsbwRNfBIXbg==
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
Subject: [PATCH v3 10/10] x86/tdx: Implement movs for MMIO
Date: Fri, 16 Aug 2024 15:44:00 +0200
Message-ID: <c0da571123affb0f5865501fda03d7c59b175985.1723807851.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723807851.git.legion@kernel.org>
References: <cover.1722862355.git.legion@kernel.org> <cover.1723807851.git.legion@kernel.org>
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
 arch/x86/coco/tdx/tdx.c          | 76 +++++++++++++++++++++++++++++---
 arch/x86/include/asm/processor.h |  4 ++
 2 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 94541ee724db..d7d762bf53dc 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -512,6 +512,62 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
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
@@ -533,9 +589,8 @@ static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int si
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
@@ -597,7 +652,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	unsigned long vaddr;
 	int size, ret;
 
-
 	ret = decode_insn_struct(&insn, regs);
 	if (ret)
 		return ret;
@@ -606,9 +660,18 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
+	if (mmio == INSN_MMIO_MOVS)
+		return handle_mmio_movs(&insn, regs, size, ve);
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
 	}
 
 	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
@@ -639,7 +702,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	switch (mmio) {
 	case INSN_MMIO_WRITE:
 	case INSN_MMIO_WRITE_IMM:
-	case INSN_MMIO_MOVS:
 		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
 		break;
 	case INSN_MMIO_READ:
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


