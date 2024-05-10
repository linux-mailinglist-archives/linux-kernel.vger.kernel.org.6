Return-Path: <linux-kernel+bounces-175326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E598C1E15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF799282AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A41607B9;
	Fri, 10 May 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeDkS+MA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qifx2WUO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A312155354
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322535; cv=none; b=f7wROwoSREuviuvXveA0XiaKJXGzwvYOd3Klgu/my7oGGcqW1CUBOP9dxkCevLME7iGHL5bmnyqaz1rmjF5Z8FPU7j+uXFWnYuDqWi8hxgIdB+2VIyA47D1oWW9QMTzPezHzYZklJPrrSZYEabJ4Xi9AdjNJFpMcta9KNT1Wvos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322535; c=relaxed/simple;
	bh=iFBRIunLr5FaLPK0cnjjauLqwMdrLWAyqeUoZfL3CGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jr5RV4XAoMz9flWN+90X67JfyUPdLcR/ghelB5QDhIzvQqzABrrVwzEA8eUljsSRbzsEZpG0qmxNgNZVBFAs4tpSTscyLrdQnbOlkMtQJ9h5kjAiH7rvuJJLbr9+40Th17xD4qbIiFJKd0lT7g1fwg2bRqSG/Ub3Vs2piP5OZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeDkS+MA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qifx2WUO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWsN9bO3jB/lWfoYhOeMN5QCJhLSpnjL/e1CFXcgkFc=;
	b=YeDkS+MAiZHerM1m6HstkCIZ/MvU3HL3aeD4du/wwgYWeF4OzoZsFqYelfTKmU7kIeONSz
	LsOuHChlYmZvXgc8eajqeT8Ytjt2t0+fnS3T6VjUAdN/jqWXBkW3ueKsYiVMz5yHTyzJMN
	BfTPHgNFZo6Arqb8jnW7sOepDcQXUEp1Iiyf/kJl8hcCwSLYxQn2bkaWQLK+JnoQQJs0Vf
	yG9iV4QJj5ujfhKMbDfyt6uED//pCe4lKcU2YwYdGE9SBKHqezUeVb5Zec4ikJjPm+S9r4
	Wmh71b8m6qiJz8vuNcCab9zgJwTm3cY4HUfAxeh7onwz4Y8I4rdyO77cDFp+fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWsN9bO3jB/lWfoYhOeMN5QCJhLSpnjL/e1CFXcgkFc=;
	b=qifx2WUO5dCFrOMeAhxuDRTwUnmqnwHwLebBadT4MnZQ+O9ajcO4VceJNqhIGjwz9TF2oN
	rwE21Hk+YUoiNlCw==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/7] riscv: replace va_kernel_pa_offset with va_kernel_data_pa_offset on XIP
Date: Fri, 10 May 2024 08:28:40 +0200
Message-Id: <133e7cd43a67abfed96bc246ae5f8a870edde684.1715286093.git.namcao@linutronix.de>
In-Reply-To: <cover.1715286093.git.namcao@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XIP kernel, the name "va_kernel_pa_offset" is misleading: unlike
"normal" kernel, it is not the virtual-physical address offset of kernel
mapping, it is the offset of kernel mapping's first virtual address to
first physical address in DRAM, which is not meaningful because the
kernel's first physical address is not in DRAM.

For XIP kernel, there are 2 different offsets because the read-only part of
the kernel resides in ROM while the rest is in RAM. The offset to ROM is in
kernel_map.va_kernel_xip_pa_offset, while the offset to RAM is not stored
anywhere: it is calculated on-the-fly.

Remove this confusing "va_kernel_pa_offset" and add
"va_kernel_data_pa_offset" as its replacement. This new variable is the
offset of virtual mapping of the kernel's data portion to the corresponding
physical addresses.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/include/asm/page.h | 25 +++++++++++++++++++------
 arch/riscv/mm/init.c          |  4 +++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 115ac98b8d72..14d0de928f9b 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -112,11 +112,13 @@ struct kernel_mapping {
 	/* Offset between linear mapping virtual address and kernel load address */
 	unsigned long va_pa_offset;
 	/* Offset between kernel mapping virtual address and kernel load address */
-	unsigned long va_kernel_pa_offset;
-	unsigned long va_kernel_xip_pa_offset;
 #ifdef CONFIG_XIP_KERNEL
+	unsigned long va_kernel_xip_pa_offset;
+	unsigned long va_kernel_data_pa_offset;
 	uintptr_t xiprom;
 	uintptr_t xiprom_sz;
+#else
+	unsigned long va_kernel_pa_offset;
 #endif
 };
 
@@ -134,12 +136,18 @@ extern phys_addr_t phys_ram_base;
 #else
 void *linear_mapping_pa_to_va(unsigned long x);
 #endif
+
+#ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_pa_to_va(y)	({					\
 	unsigned long _y = (unsigned long)(y);					\
-	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
+	(_y < phys_ram_base) ?							\
 		(void *)(_y + kernel_map.va_kernel_xip_pa_offset) :		\
-		(void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
+		(void *)(_y + kernel_map.va_kernel_data_pa_offset);		\
 	})
+#else
+#define kernel_mapping_pa_to_va(y) (void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset)
+#endif
+
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
 #ifndef CONFIG_DEBUG_VIRTUAL
@@ -147,12 +155,17 @@ void *linear_mapping_pa_to_va(unsigned long x);
 #else
 phys_addr_t linear_mapping_va_to_pa(unsigned long x);
 #endif
+
+#ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = (unsigned long)(y);					\
-	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
+	(_y < kernel_map.virt_addr + XIP_OFFSET) ?				\
 		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
-		(_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);		\
+		(_y - kernel_map.va_kernel_data_pa_offset);			\
 	})
+#else
+#define kernel_mapping_va_to_pa(y) ((unsigned long)(y) - kernel_map.va_kernel_pa_offset)
+#endif
 
 #define __va_to_pa_nodebug(x)	({						\
 	unsigned long _x = x;							\
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5e3ec076ab95..9846c6924509 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1089,10 +1089,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
 	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
+	kernel_map.va_kernel_data_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr
+						+ (uintptr_t)&_sdata - (uintptr_t)&_start;
 #else
 	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 	kernel_map.phys_addr = (uintptr_t)(&_start);
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
+	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
@@ -1114,7 +1117,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 */
 	kernel_map.va_pa_offset = IS_ENABLED(CONFIG_64BIT) ?
 				0UL : PAGE_OFFSET - kernel_map.phys_addr;
-	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 
 	/*
 	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
-- 
2.39.2


