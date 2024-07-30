Return-Path: <linux-kernel+bounces-267969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2506941EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DFB1C22FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6DD1A76CA;
	Tue, 30 Jul 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH/hiiO4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A91A76C6;
	Tue, 30 Jul 2024 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360980; cv=none; b=s8HhATrQjDll7CiJ0Gu/0c+RfA8FnLrtmOc4enAsXJpCwcjRdvvdQ33yXH2ygt0stxUU6Ixbc4mM+L5Tde/MlN+RBbvrSHH12gxeoLWlgi/L+hrBoRhV3gXq6bg/cdmqFFr46t2uxnJGGbqkp6vgub+It/jpmCT96+nqyESI5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360980; c=relaxed/simple;
	bh=nsTmQqkOfAU54MF4OMcnqCdNe15ILGkA4eZtUW7kCI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcSUXC7VZjaGZxnRRHv9YK59gfN9Bfk2eOQva5y4oiT6IqNo7wKNRET1rL4iRX6+sYtboHLqqqEPMt6PLDIeZDDzCC3TEtw1Aex8Pjki5LXKTy5P+aR9M35Q0BR9RTQO1+sYAMx+eiFmVeqCTG/GOrmGPDImKYOAnztSbbUSndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH/hiiO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713C9C4AF0C;
	Tue, 30 Jul 2024 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722360980;
	bh=nsTmQqkOfAU54MF4OMcnqCdNe15ILGkA4eZtUW7kCI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TH/hiiO4tYA2amyWAf5O0Q+DvMniy6D6MWkoKreDEkjdh1sSguD1Sst88WUDL28An
	 e6miNWpDDLGFE336pa8MbMfH5u0iQo/VikXno2q0r25GZfA0vEDMi7S1vFqlOcK1x6
	 6rDGxuzapWuClznqUQe3bI06Qi7mYFnJlutn8tXmv9AEeOv1zO4yzxjM3aJoU63G7z
	 jyoPMM9gY/n1K+xEkxJ5KWmGm/fI6v1zU+YGdS4VTVXkRF20tTFAbBQ+t6DdyOQXrl
	 /mHTIm4VytlYr3b1Fldf3mqi4aRSONl5nzvTm1pqAijR+9eZf1xUpDfpxg3dEbgyk7
	 lUjJqT2G6h7Fg==
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
Subject: [PATCH v1 1/4] x86/tdx: Split MMIO read and write operations
Date: Tue, 30 Jul 2024 19:35:56 +0200
Message-ID: <ff7cc8b32ae3829892d0dd5dcd3245d1db2684c0.1722356794.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722356794.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To implement MMIO in userspace, additional memory checks need to be
implemented. To avoid overly complicating the handle_mmio() function
and to separate checks from actions, it will be split into two separate
functions for handling read and write operations.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 135 ++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 53 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..41b047a08071 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -405,14 +405,90 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 			       EPT_WRITE, addr, val);
 }
 
+static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
+		struct pt_regs *regs, struct ve_info *ve)
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
+		struct pt_regs *regs, struct ve_info *ve)
+{
+	unsigned long *reg, val;
+	int extend_size;
+	u8 extend_val = 0;
+
+	reg = insn_get_modrm_reg_ptr(insn, regs);
+	if (!reg)
+		return -EINVAL;
+
+	/* Handle reads */
+	if (!mmio_read(size, ve->gpa, &val))
+		return -EIO;
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
+	unsigned long vaddr;
 	char buffer[MAX_INSN_SIZE];
 	enum insn_mmio_type mmio;
 	struct insn insn = {};
-	int size, extend_size;
-	u8 extend_val = 0;
+	int size;
 
 	/* Only in-kernel MMIO is supported */
 	if (WARN_ON_ONCE(user_mode(regs)))
@@ -428,12 +504,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
@@ -447,24 +517,15 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
@@ -476,38 +537,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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


