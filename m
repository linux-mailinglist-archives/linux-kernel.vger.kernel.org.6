Return-Path: <linux-kernel+bounces-274719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA82947BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8581F235D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EAB38DCD;
	Mon,  5 Aug 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X05JRkL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A13839C;
	Mon,  5 Aug 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864616; cv=none; b=a1Ka9eSBwE3r6KRsBgRtiYaZ/xpz5PgxzUH0MP1fFh9mRe8Wgme7YYwHZkAEtO9p7EeFsKSbXqU8suwqMUVpKiYg/OosGs1VDAcNnyoQEp54I4ppbyHtOe5CRjQfGLt/eM/IbtZJjaQ8fw+5STKNiIChCIIqbveVSxl9skoqgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864616; c=relaxed/simple;
	bh=tIpUybnkJuGkBeyrchLw+HZ0a/pK0EwFFjPScR16f0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFz3pnVs84Xz5OWkoxizoyTYwre4dv0g2VI61Uu7IzhUMo9h9JX8WMe4szlpuJ9AH5LgeNSLUdkXFu9I7pWC+vzInYtMHVRBSZTOTqZcB0KIPdlFeXWK/+msr8yKpm5g5URgpja+kh4QjZl1ujIoqliG++rIHQ7xQdUUfW58dVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X05JRkL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9944DC4AF0D;
	Mon,  5 Aug 2024 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722864616;
	bh=tIpUybnkJuGkBeyrchLw+HZ0a/pK0EwFFjPScR16f0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X05JRkL0rAlViLJ5vLqPs8j8QO+Uz7dB8IGqvXba9phKElaQ7gviC/CLF5/cM6q1f
	 uuywgKLFsiJu6ONjNmlu5q9FbYCiSl7b21UNPhWynv7jKy7ebH6pcgbTVd8vaow6F9
	 uLNV8htPz70DL9FwsCWx1N+Uw1xNXXJl8NzQ4w04m4w7HiTHeNf/gDnth0oway7Mi4
	 NBmm2txaViCJsZ5SrVnGRRe0s2sznUw7OyWcB2wwm1WoxkG4bxGBU9wimUrzGflvMS
	 Ft+QW0M35le5ZnPk4sEZ2Ie+uxuBD9vx55cy9XFXpZyWNikpaj+FxAMT42JSuORYYK
	 t/YMlwd9/ME2w==
From: "Alexey Gladkov (Intel)" <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v2 1/5] x86/tdx: Split MMIO read and write operations
Date: Mon,  5 Aug 2024 15:29:42 +0200
Message-ID: <0b5f95e9c7639ddb6e4cbd99b3904e6538e91371.1722862355.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722862355.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org> <cover.1722862355.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To implement MMIO in userspace, additional memory checks need to be
implemented. To avoid overly complicating the handle_mmio() function
and to separate checks from actions, it would be better to split this
function into two separate functions to handle read and write
operations.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 136 ++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 53 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..af0b6c1cacf7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -405,14 +405,91 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 			       EPT_WRITE, addr, val);
 }
 
+static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
+			     struct pt_regs *regs, struct ve_info *ve)
+{
+	unsigned long *reg, val;
+
+	switch (mmio) {
+	case INSN_MMIO_WRITE:
+		reg = insn_get_modrm_reg_ptr(insn, regs);
+		if (!reg)
+			return -EINVAL;
+		memcpy(&val, reg, size);
+		if (!mmio_write(size, ve->gpa, val))
+			return -EIO;
+		return insn->length;
+	case INSN_MMIO_WRITE_IMM:
+		val = insn->immediate.value;
+		if (!mmio_write(size, ve->gpa, val))
+			return -EIO;
+		return insn->length;
+	case INSN_MMIO_MOVS:
+		/*
+		 * MMIO was accessed with an instruction that could not be
+		 * decoded or handled properly. It was likely not using io.h
+		 * helpers or accessed MMIO accidentally.
+		 */
+		return -EINVAL;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return insn->length;
+}
+
+static int handle_mmio_read(struct insn *insn, enum insn_mmio_type mmio, int size,
+			    struct pt_regs *regs, struct ve_info *ve)
+{
+	unsigned long *reg, val;
+	int extend_size;
+	u8 extend_val;
+
+	reg = insn_get_modrm_reg_ptr(insn, regs);
+	if (!reg)
+		return -EINVAL;
+
+	if (!mmio_read(size, ve->gpa, &val))
+		return -EIO;
+
+	extend_val = 0;
+
+	switch (mmio) {
+	case INSN_MMIO_READ:
+		/* Zero-extend for 32-bit operation */
+		extend_size = size == 4 ? sizeof(*reg) : 0;
+		break;
+	case INSN_MMIO_READ_ZERO_EXTEND:
+		/* Zero extend based on operand size */
+		extend_size = insn->opnd_bytes;
+		break;
+	case INSN_MMIO_READ_SIGN_EXTEND:
+		/* Sign extend based on operand size */
+		extend_size = insn->opnd_bytes;
+		if (size == 1 && val & BIT(7))
+			extend_val = 0xFF;
+		else if (size > 1 && val & BIT(15))
+			extend_val = 0xFF;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	if (extend_size)
+		memset(reg, extend_val, extend_size);
+	memcpy(reg, &val, size);
+	return insn->length;
+}
+
 static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
-	unsigned long *reg, val, vaddr;
 	char buffer[MAX_INSN_SIZE];
 	enum insn_mmio_type mmio;
 	struct insn insn = {};
-	int size, extend_size;
-	u8 extend_val = 0;
+	unsigned long vaddr;
+	int size;
 
 	/* Only in-kernel MMIO is supported */
 	if (WARN_ON_ONCE(user_mode(regs)))
@@ -428,12 +505,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
-	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
-		reg = insn_get_modrm_reg_ptr(&insn, regs);
-		if (!reg)
-			return -EINVAL;
-	}
-
 	/*
 	 * Reject EPT violation #VEs that split pages.
 	 *
@@ -447,24 +518,15 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE)
 		return -EFAULT;
 
-	/* Handle writes first */
 	switch (mmio) {
 	case INSN_MMIO_WRITE:
-		memcpy(&val, reg, size);
-		if (!mmio_write(size, ve->gpa, val))
-			return -EIO;
-		return insn.length;
 	case INSN_MMIO_WRITE_IMM:
-		val = insn.immediate.value;
-		if (!mmio_write(size, ve->gpa, val))
-			return -EIO;
-		return insn.length;
+	case INSN_MMIO_MOVS:
+		return handle_mmio_write(&insn, mmio, size, regs, ve);
 	case INSN_MMIO_READ:
 	case INSN_MMIO_READ_ZERO_EXTEND:
 	case INSN_MMIO_READ_SIGN_EXTEND:
-		/* Reads are handled below */
-		break;
-	case INSN_MMIO_MOVS:
+		return handle_mmio_read(&insn, mmio, size, regs, ve);
 	case INSN_MMIO_DECODE_FAILED:
 		/*
 		 * MMIO was accessed with an instruction that could not be
@@ -476,38 +538,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 		WARN_ONCE(1, "Unknown insn_decode_mmio() decode value?");
 		return -EINVAL;
 	}
-
-	/* Handle reads */
-	if (!mmio_read(size, ve->gpa, &val))
-		return -EIO;
-
-	switch (mmio) {
-	case INSN_MMIO_READ:
-		/* Zero-extend for 32-bit operation */
-		extend_size = size == 4 ? sizeof(*reg) : 0;
-		break;
-	case INSN_MMIO_READ_ZERO_EXTEND:
-		/* Zero extend based on operand size */
-		extend_size = insn.opnd_bytes;
-		break;
-	case INSN_MMIO_READ_SIGN_EXTEND:
-		/* Sign extend based on operand size */
-		extend_size = insn.opnd_bytes;
-		if (size == 1 && val & BIT(7))
-			extend_val = 0xFF;
-		else if (size > 1 && val & BIT(15))
-			extend_val = 0xFF;
-		break;
-	default:
-		/* All other cases has to be covered with the first switch() */
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-
-	if (extend_size)
-		memset(reg, extend_val, extend_size);
-	memcpy(reg, &val, size);
-	return insn.length;
 }
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
-- 
2.45.2


