Return-Path: <linux-kernel+bounces-304809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42F96252E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8EC1F23B27
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7016CD10;
	Wed, 28 Aug 2024 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3szZVRP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4516CD06;
	Wed, 28 Aug 2024 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841925; cv=none; b=AyW5mcC/aWdICSV27bYS9gi+AHV44GX7ct3BO0u52HjUWtnFHLFFI/774u1yRJWzvFBjSjmjzNFA596NxBwICSUuXTLIkkxXa33ganxcblqyVMt6yot7ibf50/j8I+18tXi08usQNQQ8bWBHfec07UnR3L4KesLEliw+HRjq/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841925; c=relaxed/simple;
	bh=QV1Z93W2+8xoMJGuG1yOU8quXhLb8WRPZDnbB3GADtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufmqK4B71yxJ/aDqeiZMSxD+URBXgfOBSkoSNZ+/2YaPVu+BXcorvqzfjxQ0hTW7pw2qyWyI65FPp2CBVRGzBKc0Vfd6n62ipxIssZw3N7+7tysu3phG/JNwga9UI6op+zYVFU3fLJ4k8KNqlBGTUv/8ufJ9euztUudWLqZnlcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3szZVRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DD7C98ECC;
	Wed, 28 Aug 2024 10:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724841925;
	bh=QV1Z93W2+8xoMJGuG1yOU8quXhLb8WRPZDnbB3GADtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3szZVRP/94FuuRGvYAHC9ZAllXww7qDnCNG4tyBavlOiUXq7K4HbwSA6sNrQhdfM
	 VJno5crC23u7dViUcWsj8BjkWIy2cce8vVDscp1Y0m4u/251QIrxaNrsAxvEnvlNzH
	 vxVEM2vmToZjars5gOgP97wx6kh+XLFIPFvV92Wld+d+7Lp5LusMDuc3uDqt1i7Aab
	 J1YZr7Xi0cByM/wfSdHLa5DClyQaIHg+4VlyL3nCLu6Tg/mZowtKnLEI1YNl7Dd7zX
	 AXeoi7yT8YYMLIb2y1RiWcicxgYC5soIPUHblYKWboGtVNt42+gR8uYjnrlDt5cS/M
	 fKFUPuL5p565A==
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
Subject: [PATCH v5 5/6] x86/tdx: Move MMIO helpers to common library
Date: Wed, 28 Aug 2024 12:44:35 +0200
Message-ID: <eb504a5beac7440d5d99a33ac8051837b31dc687.1724837158.git.legion@kernel.org>
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

AMD code has helpers that are used to emulate MOVS instructions. To be
able to reuse this code in the MOVS implementation for intel, it is
necessary to move them to a common location.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/sev/core.c  | 139 ++++++--------------------------------
 arch/x86/include/asm/io.h |   3 +
 arch/x86/lib/iomem.c      | 115 +++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 117 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 082d61d85dfc..07e9a6f15fba 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -369,72 +369,24 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 				   char *dst, char *buf, size_t size)
 {
-	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
+	unsigned long error_code;
+	int ret;
 
 	/*
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
+	 * This function runs in atomic context, so __put_iomem() is not allowed
+	 * to sleep. The page-fault handler detects that it is running in atomic
+	 * context and will not try to take mmap_lock and handle the fault, so
+	 * additional pagefault_enable()/disable() calls are not needed.
 	 */
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
-
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
 
@@ -448,71 +400,24 @@ static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 				  char *src, char *buf, size_t size)
 {
-	unsigned long error_code = X86_PF_PROT;
+	unsigned long error_code;
+	int ret;
 
 	/*
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
+	 * This function runs in atomic context, so __get_iomem() is not allowed
+	 * to sleep. The page-fault handler detects that it is running in atomic
+	 * context and will not try to take mmap_lock and handle the fault, so
+	 * additional pagefault_enable()/disable() calls are not needed.
 	 */
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
-
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
index 5eecb45d05d5..3ab146edddea 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/kmsan-checks.h>
+#include <asm/uaccess.h>
 
 #define movs(type,to,from) \
 	asm volatile("movs" type:"=&D" (to), "=&S" (from):"0" (to), "1" (from):"memory")
@@ -124,3 +125,117 @@ void memset_io(volatile void __iomem *a, int b, size_t c)
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
+	 * The access can't be done via copy_from_user() here because
+	 * __get_iomem() must not use string instructions to access unsafe
+	 * memory. The reason is that MOVS is emulated by the exception handler
+	 * for SEV and TDX by splitting the move up into a read and a write
+	 * opetations and taking a nested exception on whatever of them is the
+	 * MMIO access. Using string instructions here would cause infinite
+	 * nesting.
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
+	 * The access can't be done via copy_to_user() here because
+	 * __put_iomem() must not use string instructions to access unsafe
+	 * memory. The reason is that MOVS is emulated by the exception handler
+	 * for SEV and TDX by splitting the move up into a read and a write
+	 * opetations and taking a nested exception on whatever of them is the
+	 * MMIO access. Using string instructions here would cause infinite
+	 * nesting.
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
2.46.0


