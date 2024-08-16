Return-Path: <linux-kernel+bounces-289758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B5A954B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AB71F23E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA11BF32B;
	Fri, 16 Aug 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRCGExd7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5301BD02A;
	Fri, 16 Aug 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815931; cv=none; b=Hzp+bmjRonNfGal7TeDKJlasUYYbI9DZ+pUksp3InU5ANnLB76aykHwgjTg94vBVd1UmkealftkiT9G3+dev/IEsI1mK9RtUZvrkNS9uZPXfAMwJarHcqlaZnQTvfxIulSO/72W9v4uEKiuNiA0UNFt+Y6CYEPBxCyoCv3EeqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815931; c=relaxed/simple;
	bh=fcginaaNpItD9m5GPZr5oEG2nrqWphw68B7KM4hv6iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjRv60yLOUn3tiEZs8VemCFt/MSF2Z6DYa5j6zP3teTLxfuPzkMZbnYZBhOXOEUH/cSUdGCa3uy3GKtOTKRJagBkxiSCsbs0c6AZmMwFvIaXktNLbU0RGxm9jkQgeuBOu7nzhpaTLfeHAsPajQdMfpNbxvo2TUzPOxcNqRzbj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRCGExd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CFDC4AF0C;
	Fri, 16 Aug 2024 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815931;
	bh=fcginaaNpItD9m5GPZr5oEG2nrqWphw68B7KM4hv6iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRCGExd786doVkNTo3lB7FLWdJCyPnLX7LfT0/8cvAZph91p0ypec1yYTWh22fbai
	 L/bfT76irsv530lO1ocVFjTiEkZVHXwhk1sBDt/i2OC3y3aS+92F7do7im8lhq4NnT
	 Kmp04nynCcIRkOssiR+KhbyR9bAGxRNAWUIRydt3j1dtFZIh8RVqEymBn8I16xys7r
	 XfgReUX1gVbAVW2QDNHr1kvyORNu1T3/NWNf3SZ22cma1fSygepp9WM2CEbqGqjwyF
	 TsM75p0dB0nax2UWTFWyvm+tEG3Mxf/fsdIakkBNLUDtK7lc5b800q2ME4Oba/aJz0
	 c08xRxD+Cl8dA==
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
Subject: [PATCH v3 09/10] x86/tdx: Move MMIO helpers to common library
Date: Fri, 16 Aug 2024 15:43:59 +0200
Message-ID: <5660b8208dc771a6517c40d6448f996efae2768b.1723807851.git.legion@kernel.org>
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

AMD code has helpers that are used to emulate MOVS instructions. To be
able to reuse this code in the MOVS implementation for intel, it is
necessary to move them to a common location.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/sev/core.c  | 135 ++++----------------------------------
 arch/x86/include/asm/io.h |   3 +
 arch/x86/lib/iomem.c      | 125 +++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 121 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0e8e4264464..c154d2587c38 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -365,72 +365,18 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 				   char *dst, char *buf, size_t size)
 {
-	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
-
-	/*
-	 * This function uses __put_user() independent of whether kernel or user
-	 * memory is accessed. This works fine because __put_user() does no
-	 * sanity checks of the pointer being accessed. All that it does is
-	 * to report when the access failed.
-	 *
-	 * Also, this function runs in atomic context, so __put_user() is not
-	 * allowed to sleep. The page-fault handler detects that it is running
-	 * in atomic context and will not try to take mmap_sem and handle the
-	 * fault, so additional pagefault_enable()/disable() calls are not
-	 * needed.
-	 *
-	 * The access can't be done via copy_to_user() here because
-	 * vc_write_mem() must not use string instructions to access unsafe
-	 * memory. The reason is that MOVS is emulated by the #VC handler by
-	 * splitting the move up into a read and a write and taking a nested #VC
-	 * exception on whatever of them is the MMIO access. Using string
-	 * instructions here would cause infinite nesting.
-	 */
-	switch (size) {
-	case 1: {
-		u8 d1;
-		u8 __user *target = (u8 __user *)dst;
-
-		memcpy(&d1, buf, 1);
-		if (__put_user(d1, target))
-			goto fault;
-		break;
-	}
-	case 2: {
-		u16 d2;
-		u16 __user *target = (u16 __user *)dst;
-
-		memcpy(&d2, buf, 2);
-		if (__put_user(d2, target))
-			goto fault;
-		break;
-	}
-	case 4: {
-		u32 d4;
-		u32 __user *target = (u32 __user *)dst;
+	unsigned long error_code;
+	int ret;
 
-		memcpy(&d4, buf, 4);
-		if (__put_user(d4, target))
-			goto fault;
-		break;
-	}
-	case 8: {
-		u64 d8;
-		u64 __user *target = (u64 __user *)dst;
+	ret = __put_iomem(dst, buf, size);
+	if (!ret)
+		return ES_OK;
 
-		memcpy(&d8, buf, 8);
-		if (__put_user(d8, target))
-			goto fault;
-		break;
-	}
-	default:
-		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+	if (ret == -EIO)
 		return ES_UNSUPPORTED;
-	}
 
-	return ES_OK;
+	error_code = X86_PF_PROT | X86_PF_WRITE;
 
-fault:
 	if (user_mode(ctxt->regs))
 		error_code |= X86_PF_USER;
 
@@ -444,71 +390,18 @@ static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 				  char *src, char *buf, size_t size)
 {
-	unsigned long error_code = X86_PF_PROT;
-
-	/*
-	 * This function uses __get_user() independent of whether kernel or user
-	 * memory is accessed. This works fine because __get_user() does no
-	 * sanity checks of the pointer being accessed. All that it does is
-	 * to report when the access failed.
-	 *
-	 * Also, this function runs in atomic context, so __get_user() is not
-	 * allowed to sleep. The page-fault handler detects that it is running
-	 * in atomic context and will not try to take mmap_sem and handle the
-	 * fault, so additional pagefault_enable()/disable() calls are not
-	 * needed.
-	 *
-	 * The access can't be done via copy_from_user() here because
-	 * vc_read_mem() must not use string instructions to access unsafe
-	 * memory. The reason is that MOVS is emulated by the #VC handler by
-	 * splitting the move up into a read and a write and taking a nested #VC
-	 * exception on whatever of them is the MMIO access. Using string
-	 * instructions here would cause infinite nesting.
-	 */
-	switch (size) {
-	case 1: {
-		u8 d1;
-		u8 __user *s = (u8 __user *)src;
-
-		if (__get_user(d1, s))
-			goto fault;
-		memcpy(buf, &d1, 1);
-		break;
-	}
-	case 2: {
-		u16 d2;
-		u16 __user *s = (u16 __user *)src;
+	unsigned long error_code;
+	int ret;
 
-		if (__get_user(d2, s))
-			goto fault;
-		memcpy(buf, &d2, 2);
-		break;
-	}
-	case 4: {
-		u32 d4;
-		u32 __user *s = (u32 __user *)src;
+	ret = __get_iomem(src, buf, size);
+	if (!ret)
+		return ES_OK;
 
-		if (__get_user(d4, s))
-			goto fault;
-		memcpy(buf, &d4, 4);
-		break;
-	}
-	case 8: {
-		u64 d8;
-		u64 __user *s = (u64 __user *)src;
-		if (__get_user(d8, s))
-			goto fault;
-		memcpy(buf, &d8, 8);
-		break;
-	}
-	default:
-		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+	if (ret == -EIO)
 		return ES_UNSUPPORTED;
-	}
 
-	return ES_OK;
+	error_code = X86_PF_PROT;
 
-fault:
 	if (user_mode(ctxt->regs))
 		error_code |= X86_PF_USER;
 
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 1d60427379c9..ac01d53466cb 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -402,4 +402,7 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
 	}
 }
 
+int __get_iomem(char *src, char *buf, size_t size);
+int __put_iomem(char *src, char *buf, size_t size);
+
 #endif /* _ASM_X86_IO_H */
diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index 5eecb45d05d5..23179953eb5a 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/kmsan-checks.h>
+#include <asm/uaccess.h>
 
 #define movs(type,to,from) \
 	asm volatile("movs" type:"=&D" (to), "=&S" (from):"0" (to), "1" (from):"memory")
@@ -124,3 +125,127 @@ void memset_io(volatile void __iomem *a, int b, size_t c)
 	}
 }
 EXPORT_SYMBOL(memset_io);
+
+int __get_iomem(char *src, char *buf, size_t size)
+{
+	/*
+	 * This function uses __get_user() independent of whether kernel or user
+	 * memory is accessed. This works fine because __get_user() does no
+	 * sanity checks of the pointer being accessed. All that it does is
+	 * to report when the access failed.
+	 *
+	 * Also, this function runs in atomic context, so __get_user() is not
+	 * allowed to sleep. The page-fault handler detects that it is running
+	 * in atomic context and will not try to take mmap_sem and handle the
+	 * fault, so additional pagefault_enable()/disable() calls are not
+	 * needed.
+	 *
+	 * The access can't be done via copy_from_user() here because
+	 * mmio_read_mem() must not use string instructions to access unsafe
+	 * memory. The reason is that MOVS is emulated by the #VC handler by
+	 * splitting the move up into a read and a write and taking a nested #VC
+	 * exception on whatever of them is the MMIO access. Using string
+	 * instructions here would cause infinite nesting.
+	 */
+	switch (size) {
+	case 1: {
+		u8 d1, __user *s = (u8 __user *)src;
+
+		if (__get_user(d1, s))
+			return -EFAULT;
+		memcpy(buf, &d1, 1);
+		break;
+	}
+	case 2: {
+		u16 d2, __user *s = (u16 __user *)src;
+
+		if (__get_user(d2, s))
+			return -EFAULT;
+		memcpy(buf, &d2, 2);
+		break;
+	}
+	case 4: {
+		u32 d4, __user *s = (u32 __user *)src;
+
+		if (__get_user(d4, s))
+			return -EFAULT;
+		memcpy(buf, &d4, 4);
+		break;
+	}
+	case 8: {
+		u64 d8, __user *s = (u64 __user *)src;
+
+		if (__get_user(d8, s))
+			return -EFAULT;
+		memcpy(buf, &d8, 8);
+		break;
+	}
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int __put_iomem(char *dst, char *buf, size_t size)
+{
+	/*
+	 * This function uses __put_user() independent of whether kernel or user
+	 * memory is accessed. This works fine because __put_user() does no
+	 * sanity checks of the pointer being accessed. All that it does is
+	 * to report when the access failed.
+	 *
+	 * Also, this function runs in atomic context, so __put_user() is not
+	 * allowed to sleep. The page-fault handler detects that it is running
+	 * in atomic context and will not try to take mmap_sem and handle the
+	 * fault, so additional pagefault_enable()/disable() calls are not
+	 * needed.
+	 *
+	 * The access can't be done via copy_to_user() here because
+	 * put_iomem() must not use string instructions to access unsafe
+	 * memory. The reason is that MOVS is emulated by the #VC handler by
+	 * splitting the move up into a read and a write and taking a nested #VC
+	 * exception on whatever of them is the MMIO access. Using string
+	 * instructions here would cause infinite nesting.
+	 */
+	switch (size) {
+	case 1: {
+		u8 d1, __user *target = (u8 __user *)dst;
+
+		memcpy(&d1, buf, 1);
+		if (__put_user(d1, target))
+			return -EFAULT;
+		break;
+	}
+	case 2: {
+		u16 d2, __user *target = (u16 __user *)dst;
+
+		memcpy(&d2, buf, 2);
+		if (__put_user(d2, target))
+			return -EFAULT;
+		break;
+	}
+	case 4: {
+		u32 d4, __user *target = (u32 __user *)dst;
+
+		memcpy(&d4, buf, 4);
+		if (__put_user(d4, target))
+			return -EFAULT;
+		break;
+	}
+	case 8: {
+		u64 d8, __user *target = (u64 __user *)dst;
+
+		memcpy(&d8, buf, 8);
+		if (__put_user(d8, target))
+			return -EFAULT;
+		break;
+	}
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return -EIO;
+	}
+
+	return 0;
+}
-- 
2.45.2


