Return-Path: <linux-kernel+bounces-191976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD918D16C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07361C22B38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0F13E025;
	Tue, 28 May 2024 08:59:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ECD13DDAF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886777; cv=none; b=GHggiLDKvnPUpApavrpdPuXk6FttejKKPWk5i5tVKYG5LH06fXRwlXPGh8+Hajhoy/WcptrV6YiI/LeaiQVDxPolBhInnC+JXyuJGypSob011CiBbOGbKjmuhlacGt6v+nmtOmEHqwo3BCV8lWaH9KsuZCC8irNVpGOlUZ4/0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886777; c=relaxed/simple;
	bh=S+o4aLK78wtQcuI0d97yTz0YWcTl2O3nju7PM5aqXuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GO4N8eqDWfkYLiHp2iRiaehWDU0zIis+vzsxJDXmP3RV+RFb9n02HM5kGFp4AkZxCkVyQzj/UyfAZwVH3q+MT4T/Ki/NvgP0jHXMXFUTmGZql6aWjelZrZxyyEnSP9wfA4cdH5YhK2sbxodRTSglTaxcGN6RomXpq5TUsJk1ndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VpRHg66lLzckDb;
	Tue, 28 May 2024 16:58:07 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 328B1180AA5;
	Tue, 28 May 2024 16:59:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 16:59:26 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, Robin Murphy
	<robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
	<glider@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Aneesh
 Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Tong Tiangen
	<tongtiangen@huawei.com>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH v12 5/6] arm64: introduce copy_mc_to_kernel() implementation
Date: Tue, 28 May 2024 16:59:14 +0800
Message-ID: <20240528085915.1955987-6-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528085915.1955987-1-tongtiangen@huawei.com>
References: <20240528085915.1955987-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)

The copy_mc_to_kernel() helper is memory copy implementation that handles
source exceptions. It can be used in memory copy scenarios that tolerate
hardware memory errors(e.g: pmem_read/dax_copy_to_iter).

Currnently, only x86 and ppc suuport this helper, after arm64 support
ARCH_HAS_COPY_MC , we introduce copy_mc_to_kernel() implementation.

Also add memcpy_mc() for memory copy that handles source exceptions.
Because there is no GPR is available for saving "bytes not copied" in
memcpy(), the mempcy_mc() is referenced to the implementation of
copy_from_user().

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/string.h  |  5 +++
 arch/arm64/include/asm/uaccess.h | 18 ++++++++
 arch/arm64/lib/Makefile          |  2 +-
 arch/arm64/lib/memcpy_mc.S       | 73 ++++++++++++++++++++++++++++++++
 mm/kasan/shadow.c                | 12 ++++++
 5 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/memcpy_mc.S

diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index 3a3264ff47b9..23eca4fb24fa 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -35,6 +35,10 @@ extern void *memchr(const void *, int, __kernel_size_t);
 extern void *memcpy(void *, const void *, __kernel_size_t);
 extern void *__memcpy(void *, const void *, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMCPY_MC
+extern int memcpy_mc(void *, const void *, __kernel_size_t);
+extern int __memcpy_mc(void *, const void *, __kernel_size_t);
+
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *, const void *, __kernel_size_t);
 extern void *__memmove(void *, const void *, __kernel_size_t);
@@ -57,6 +61,7 @@ void memcpy_flushcache(void *dst, const void *src, size_t cnt);
  */
 
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
+#define memcpy_mc(dst, src, len) __memcpy_mc(dst, src, len)
 #define memmove(dst, src, len) __memmove(dst, src, len)
 #define memset(s, c, n) __memset(s, c, n)
 
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 14be5000c5a0..07c1aeaeb094 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -425,4 +425,22 @@ static inline size_t probe_subpage_writeable(const char __user *uaddr,
 
 #endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+/**
+ * copy_mc_to_kernel - memory copy that handles source exceptions
+ *
+ * @to:		destination address
+ * @from:	source address
+ * @size:	number of bytes to copy
+ *
+ * Return 0 for success, or bytes not copied.
+ */
+static inline unsigned long __must_check
+copy_mc_to_kernel(void *to, const void *from, unsigned long size)
+{
+	return memcpy_mc(to, from, size);
+}
+#define copy_mc_to_kernel copy_mc_to_kernel
+#endif
+
 #endif /* __ASM_UACCESS_H */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 65ec3d24d32d..0d2fc251fbae 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -13,7 +13,7 @@ endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
-lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc_page.o
+lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc_page.o memcpy_mc.o
 
 obj-$(CONFIG_CRC32) += crc32.o
 
diff --git a/arch/arm64/lib/memcpy_mc.S b/arch/arm64/lib/memcpy_mc.S
new file mode 100644
index 000000000000..1798090eba06
--- /dev/null
+++ b/arch/arm64/lib/memcpy_mc.S
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2013 ARM Ltd.
+ * Copyright (C) 2013 Linaro.
+ *
+ * This code is based on glibc cortex strings work originally authored by Linaro
+ * be found @
+ *
+ * http://bazaar.launchpad.net/~linaro-toolchain-dev/cortex-strings/trunk/
+ * files/head:/src/aarch64/
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/cache.h>
+#include <asm/asm-uaccess.h>
+
+/*
+ * Copy a buffer from src to dest (alignment handled by the hardware)
+ *
+ * Parameters:
+ *	x0 - dest
+ *	x1 - src
+ *	x2 - n
+ * Returns:
+ *	x0 - dest
+ */
+	.macro ldrb1 reg, ptr, val
+	KERNEL_ME_SAFE(9997f, ldrb  \reg, [\ptr], \val)
+	.endm
+
+	.macro strb1 reg, ptr, val
+	strb \reg, [\ptr], \val
+	.endm
+
+	.macro ldrh1 reg, ptr, val
+	KERNEL_ME_SAFE(9997f, ldrh  \reg, [\ptr], \val)
+	.endm
+
+	.macro strh1 reg, ptr, val
+	strh \reg, [\ptr], \val
+	.endm
+
+	.macro ldr1 reg, ptr, val
+	KERNEL_ME_SAFE(9997f, ldr \reg, [\ptr], \val)
+	.endm
+
+	.macro str1 reg, ptr, val
+	str \reg, [\ptr], \val
+	.endm
+
+	.macro ldp1 reg1, reg2, ptr, val
+	KERNEL_ME_SAFE(9997f, ldp \reg1, \reg2, [\ptr], \val)
+	.endm
+
+	.macro stp1 reg1, reg2, ptr, val
+	stp \reg1, \reg2, [\ptr], \val
+	.endm
+
+end	.req	x5
+SYM_FUNC_START(__memcpy_mc)
+	add	end, x0, x2
+#include "copy_template.S"
+	mov	x0, #0				// Nothing to copy
+	ret
+
+	// Exception fixups
+9997:	sub	x0, end, dst			// bytes not copied
+	ret
+SYM_FUNC_END(__memcpy_mc)
+EXPORT_SYMBOL(__memcpy_mc)
+SYM_FUNC_ALIAS_WEAK(memcpy_mc, __memcpy_mc)
+EXPORT_SYMBOL(memcpy_mc)
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d6210ca48dda..e23632391eac 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -79,6 +79,18 @@ void *memcpy(void *dest, const void *src, size_t len)
 }
 #endif
 
+#ifdef __HAVE_ARCH_MEMCPY_MC
+#undef memcpy_mc
+int memcpy_mc(void *dest, const void *src, size_t len)
+{
+	if (!kasan_check_range(src, len, false, _RET_IP_) ||
+	    !kasan_check_range(dest, len, true, _RET_IP_))
+		return (int)len;
+
+	return __memcpy_mc(dest, src, len);
+}
+#endif
+
 void *__asan_memset(void *addr, int c, ssize_t len)
 {
 	if (!kasan_check_range(addr, len, true, _RET_IP_))
-- 
2.25.1


