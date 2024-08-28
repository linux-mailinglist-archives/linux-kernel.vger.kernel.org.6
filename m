Return-Path: <linux-kernel+bounces-304805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5966A962529
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1A0B21691
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45E16CD37;
	Wed, 28 Aug 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In7AvG43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B2167D95;
	Wed, 28 Aug 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841908; cv=none; b=Hw+yMf+g7K56PPhcrwD6NpDeE9OhIvZQFw1j35TRVw6aApSlVfPP55/nOQMcdbB7W6xVDX+u8FSzKFaCHudr4Dc6V5oS7FQDC0Pj69Mjdimi4uzPkrRHZqQ7pxY3s5nyIwirb3ouTW7JQoQK1U5N4QkwtY1xnSq5UsucYsmnFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841908; c=relaxed/simple;
	bh=lGqzYFKhjQzMKhi6mjeaNT2NO+HW3iWEXmn/huP+McA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISGD0+JwV6qqxBldcRxYu2udRID3EmxbNi7e3rCBJyQxpWVKrKSTYMSMlOg2GrH+3whYkm7CFh6ZSITO3rMFfdlo9TtTcd+OevLZ+LuqmSwwcj6plWxRG+9M5JqTNanS+wK2HcLk7lyP8H04MrZtCnBe9QtknlJcs1Q5RRImiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In7AvG43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90CBC98ECC;
	Wed, 28 Aug 2024 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724841907;
	bh=lGqzYFKhjQzMKhi6mjeaNT2NO+HW3iWEXmn/huP+McA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=In7AvG43n+9Ef9Bc0kPAjTIcjktYzeaYMR0C4sTnO+2bLEJRCtic3ZL4449oMFhRE
	 Sp3kecRHxh9mSDwhH7FqN/+DtTuvFvyRNIbAaXd/N5zeqCj9Oed7yFnnNffx/bVtap
	 7WyEWA98dcUtBd33NizunPNfMdI2wOU7hF7d0YRINK3FxeA4FjfFlg5DVRBu/wDVsc
	 qRq1Nf/TzjD+Vip8DCwm+lc/jyFws9T72Ym2Nt96wpfV0tTfKEffxC7GjA5wAkC+eO
	 F/l6cy8y88kj0w680IxFafcM9XRLEsbwpHzEjoXDwba6YMec8LEGazxsQVFFFA3DEX
	 X7jDUYn99L92A==
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
Subject: [PATCH v5 1/6] x86/tdx: Split MMIO read and write operations
Date: Wed, 28 Aug 2024 12:44:31 +0200
Message-ID: <ce298d53bac2cc028c62a34e07f990ce0dd2f488.1724837158.git.legion@kernel.org>
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

To implement MMIO in userspace, additional memory checks need to be
implemented. To avoid overly complicating the handle_mmio() function
and to separate checks from actions, it would be better to split this
function into two separate functions to handle read and write
operations.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
2.46.0


