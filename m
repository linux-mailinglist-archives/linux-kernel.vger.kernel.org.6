Return-Path: <linux-kernel+bounces-258731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C10A938C33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D79A1F21A30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65DF16CD08;
	Mon, 22 Jul 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="NNNCICN3"
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286016C437
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641413; cv=none; b=UFTQIEmnVzpUSTYTS4bP+G42e9tajHjlhvXCpLUdPtnl7inVraDloj2XBV5mG8bi8A+ilAXDuTB1xhnOFfQr6Bvl179wDp8rkF6X7DismNfyP9ojzktfQJvKGlZK7MGG3FWklvKqT7Pq02GFYzyBXFF0s3DNAowsWwhiEZ1RWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641413; c=relaxed/simple;
	bh=vkX5nIOXjOU9j4Zc1+nAzhkQ0/XwM13wZIigMwVtpGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y148jiNeNgOD6N1eHKO1mRehp8P5Bw9hE4rK7rc2Kmbu/1ByAIHRSRzObKqRZfgxFo7uEissd5keVV0LApJ0HvF8Xdu5eQwRyq9nwPo/axDrBEPglutsKj3URoHQZOIpe9QsUJwPn+1wzq2c4gRjsfwtR+ZD2cLvZHUvwywDdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=NNNCICN3; arc=none smtp.client-ip=85.31.212.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 3455F349A6A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641409;
	bh=vkX5nIOXjOU9j4Zc1+nAzhkQ0/XwM13wZIigMwVtpGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NNNCICN3xQtR7dUKpVH8lCafasVC//wZI8NLynVJS9ckkhwl8eqd/yEti0WAHosYu
	 7t/DlyZj+POp+rbZIvrfNYbH2FST4Mdr6WvUEJ7wYhGMApeJwKyCCta7rXOEqIQ8Ez
	 ywhBXo8pUVmalaKoXts/yaXYyOk4Fz0Wp8FVrSyo=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 06E7A349619 for
 <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:29 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 6E8C73499E1; Mon, 22 Jul
 2024 11:43:28 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 344EE40317; Mon, 22 Jul
 2024 11:43:28 +0200 (CEST)
X-Secumail-id: <4d12.669e29c0.6cc06.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Vincent Chardon
 <vincent.chardon@elsys-design.com>
Subject: [RFC PATCH v3 16/37] kvx: Add other common headers
Date: Mon, 22 Jul 2024 11:41:27 +0200
Message-ID: <20240722094226.21602-17-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add some other common headers for basic kvx support.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: remove __rm_firmware_regs_start declaration.
---
 arch/kvx/include/asm/asm-prototypes.h   | 14 ++++++++
 arch/kvx/include/asm/clocksource.h      | 17 +++++++++
 arch/kvx/include/asm/linkage.h          | 13 +++++++
 arch/kvx/include/asm/pci.h              | 36 +++++++++++++++++++
 arch/kvx/include/asm/sections.h         | 17 +++++++++
 arch/kvx/include/asm/spinlock.h         | 16 +++++++++
 arch/kvx/include/asm/spinlock_types.h   | 17 +++++++++
 arch/kvx/include/asm/stackprotector.h   | 47 +++++++++++++++++++++++++
 arch/kvx/include/asm/timex.h            | 20 +++++++++++
 arch/kvx/include/asm/types.h            | 12 +++++++
 arch/kvx/include/uapi/asm/bitsperlong.h | 14 ++++++++
 arch/kvx/include/uapi/asm/byteorder.h   | 12 +++++++
 tools/include/uapi/asm/bitsperlong.h    |  2 ++
 13 files changed, 237 insertions(+)
 create mode 100644 arch/kvx/include/asm/asm-prototypes.h
 create mode 100644 arch/kvx/include/asm/clocksource.h
 create mode 100644 arch/kvx/include/asm/linkage.h
 create mode 100644 arch/kvx/include/asm/pci.h
 create mode 100644 arch/kvx/include/asm/sections.h
 create mode 100644 arch/kvx/include/asm/spinlock.h
 create mode 100644 arch/kvx/include/asm/spinlock_types.h
 create mode 100644 arch/kvx/include/asm/stackprotector.h
 create mode 100644 arch/kvx/include/asm/timex.h
 create mode 100644 arch/kvx/include/asm/types.h
 create mode 100644 arch/kvx/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/kvx/include/uapi/asm/byteorder.h

diff --git a/arch/kvx/include/asm/asm-prototypes.h b/arch/kvx/include/asm/asm-prototypes.h
new file mode 100644
index 0000000000000..af032508e30cf
--- /dev/null
+++ b/arch/kvx/include/asm/asm-prototypes.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_ASM_PROTOTYPES_H
+#define _ASM_KVX_ASM_PROTOTYPES_H
+
+#include <asm/string.h>
+
+#include <asm-generic/asm-prototypes.h>
+
+#endif /* _ASM_KVX_ASM_PROTOTYPES_H */
diff --git a/arch/kvx/include/asm/clocksource.h b/arch/kvx/include/asm/clocksource.h
new file mode 100644
index 0000000000000..4df7c66ffbb53
--- /dev/null
+++ b/arch/kvx/include/asm/clocksource.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_CLOCKSOURCE_H
+#define _ASM_KVX_CLOCKSOURCE_H
+
+#include <linux/compiler.h>
+
+struct arch_clocksource_data {
+	void __iomem *regs;
+};
+
+#endif /* _ASM_KVX_CLOCKSOURCE_H */
diff --git a/arch/kvx/include/asm/linkage.h b/arch/kvx/include/asm/linkage.h
new file mode 100644
index 0000000000000..84e1cacf67c21
--- /dev/null
+++ b/arch/kvx/include/asm/linkage.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ */
+
+#ifndef __ASM_KVX_LINKAGE_H
+#define __ASM_KVX_LINKAGE_H
+
+#define __ALIGN		.align 4
+#define __ALIGN_STR	".align 4"
+
+#endif
diff --git a/arch/kvx/include/asm/pci.h b/arch/kvx/include/asm/pci.h
new file mode 100644
index 0000000000000..d5bbaaf041b53
--- /dev/null
+++ b/arch/kvx/include/asm/pci.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Vincent Chardon
+ *            Clement Leger
+ */
+
+#ifndef __ASM_KVX_PCI_H_
+#define __ASM_KVX_PCI_H_
+
+#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/of_gpio.h>
+
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
+#define HAVE_PCI_MMAP			1
+
+extern int isa_dma_bridge_buggy;
+
+/* Can be used to override the logic in pci_scan_bus for skipping
+ * already-configured bus numbers - to be used for buggy BIOSes
+ * or architectures with incomplete PCI setup by the loader.
+ */
+#define pcibios_assign_all_busses()	0
+
+#define PCIBIOS_MIN_IO          0UL
+#define PCIBIOS_MIN_MEM         0UL
+
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+		return pci_domain_nr(bus);
+}
+#endif /*  CONFIG_PCI_DOMAINS */
+
+#endif /* _ASM_KVX_PCI_H */
diff --git a/arch/kvx/include/asm/sections.h b/arch/kvx/include/asm/sections.h
new file mode 100644
index 0000000000000..60e63fc530802
--- /dev/null
+++ b/arch/kvx/include/asm/sections.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SECTIONS_H
+#define _ASM_KVX_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+extern char __rodata_start[], __rodata_end[];
+extern char __initdata_start[], __initdata_end[];
+extern char __inittext_start[], __inittext_end[];
+extern char __exception_start[], __exception_end[];
+
+#endif
diff --git a/arch/kvx/include/asm/spinlock.h b/arch/kvx/include/asm/spinlock.h
new file mode 100644
index 0000000000000..ed32fdba1e19d
--- /dev/null
+++ b/arch/kvx/include/asm/spinlock.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SPINLOCK_H
+#define _ASM_KVX_SPINLOCK_H
+
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+/* See include/linux/spinlock.h */
+#define smp_mb__after_spinlock()	smp_mb()
+
+#endif
diff --git a/arch/kvx/include/asm/spinlock_types.h b/arch/kvx/include/asm/spinlock_types.h
new file mode 100644
index 0000000000000..929a7df16ef39
--- /dev/null
+++ b/arch/kvx/include/asm/spinlock_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SPINLOCK_TYPES_H
+#define _ASM_KVX_SPINLOCK_TYPES_H
+
+#if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
+# error "please don't include this file directly"
+#endif
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+
+#endif /* _ASM_KVX_SPINLOCK_TYPES_H */
diff --git a/arch/kvx/include/asm/stackprotector.h b/arch/kvx/include/asm/stackprotector.h
new file mode 100644
index 0000000000000..2c190bbb5efc8
--- /dev/null
+++ b/arch/kvx/include/asm/stackprotector.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * derived from arch/mips/include/asm/stackprotector.h
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+/*
+ * GCC stack protector support.
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function.  The pattern is called stack canary
+ * and gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard" on KVX.  This unfortunately means that on SMP
+ * we cannot have a different canary value per task.
+ */
+
+#ifndef __ASM_STACKPROTECTOR_H
+#define __ASM_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/kvx/include/asm/timex.h b/arch/kvx/include/asm/timex.h
new file mode 100644
index 0000000000000..51e346faa887f
--- /dev/null
+++ b/arch/kvx/include/asm/timex.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_TIMEX_H
+#define _ASM_KVX_TIMEX_H
+
+#define get_cycles get_cycles
+
+#include <asm/sfr.h>
+#include <asm-generic/timex.h>
+
+static inline cycles_t get_cycles(void)
+{
+	return kvx_sfr_get(PM0);
+}
+
+#endif	/* _ASM_KVX_TIMEX_H */
diff --git a/arch/kvx/include/asm/types.h b/arch/kvx/include/asm/types.h
new file mode 100644
index 0000000000000..1e6c024ee8923
--- /dev/null
+++ b/arch/kvx/include/asm/types.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_TYPES_H
+#define _ASM_KVX_TYPES_H
+
+#include <asm-generic/int-ll64.h>
+
+#endif	/* _ASM_KVX_TYPES_H */
diff --git a/arch/kvx/include/uapi/asm/bitsperlong.h b/arch/kvx/include/uapi/asm/bitsperlong.h
new file mode 100644
index 0000000000000..02a91596d5670
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _UAPI_ASM_KVX_BITSPERLONG_H
+#define _UAPI_ASM_KVX_BITSPERLONG_H
+
+#define __BITS_PER_LONG 64
+
+#include <asm-generic/bitsperlong.h>
+
+#endif /* _UAPI_ASM_KVX_BITSPERLONG_H */
diff --git a/arch/kvx/include/uapi/asm/byteorder.h b/arch/kvx/include/uapi/asm/byteorder.h
new file mode 100644
index 0000000000000..b7d827daec737
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/byteorder.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BYTEORDER_H
+#define _ASM_KVX_BYTEORDER_H
+
+#include <linux/byteorder/little_endian.h>
+
+#endif	/* _ASM_KVX_BYTEORDER_H */
diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
index c65267afc3415..aada3dfc4d61f 100644
--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -13,6 +13,8 @@
 #include "../../../arch/ia64/include/uapi/asm/bitsperlong.h"
 #elif defined(__alpha__)
 #include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
+#elif defined(__kvx__)
+#include "../../../arch/kvx/include/uapi/asm/bitsperlong.h"
 #else
 #include <asm-generic/bitsperlong.h>
 #endif
-- 
2.45.2






