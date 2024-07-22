Return-Path: <linux-kernel+bounces-258753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A74938C64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B37E1F2295E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5C16FF30;
	Mon, 22 Jul 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="JaS7HPB4"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A016EC13
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641435; cv=none; b=KFdAyEzN63OdKvGo0gQmsnFQD89M0gc5a8eu5ToU5aMJ42TgZnodUfDHqSouhXFWSsRE6d9eWCZ6Btd0LUyVGYRgZoEA1BV1OXF7gsPHCknypHLwZbkYIsE5lqkN/AoNg+YWh15C1phLBf65xXcmF3VE8GHSFwxzbvzENEMeIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641435; c=relaxed/simple;
	bh=j+26YT+s2R1JHU4KrZw0Mbr2esOXJjuYIhfVdzOJL+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igezAqlc1Oa7T8P79TUxVtNMv606iIfmlHrsLB4Osaabv+62ZGX5hewaaaUsqufiGLqRY7aRFKzZ7bLh7UJBmfWvXPT4Dje8KvZOTFvf2TneBQTqhW/82BSgbr10gqSvkXbdmV9XKO7e1L8IGZLeH5bFSJyCE/0B1GW/ZDfJhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=JaS7HPB4; arc=none smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 1EAB080B7B4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641429;
	bh=j+26YT+s2R1JHU4KrZw0Mbr2esOXJjuYIhfVdzOJL+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JaS7HPB4df8cA2Wmkgpg32Ba99mmjroGEXdpXdyxQrwIBe4bC/SBKiZ4OvQiap5dI
	 x9YfcTmWdBBPwak65JrsJz72UrlO30XTMtNuKV74yRCKuR+qPIkA04NLVSyR6iovy+
	 hoNqaGTaYZ/zIIMhrfIkuSJkOzWZEa4BMmF4WwG4=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id E2E9E80B826; Mon, 22 Jul 2024 11:43:48 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 5483380B938; Mon, 22 Jul
 2024 11:43:48 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id F32D940317; Mon, 22 Jul
 2024 11:43:47 +0200 (CEST)
X-Secumail-id: <aea1.669e29d4.5182a.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Jules Maselbas <jmaselbas@zdiv.net>,
 Marius Gligor <mgligor@kalrayinc.com>
Subject: [RFC PATCH v3 29/37] kvx: Add some library functions
Date: Mon, 22 Jul 2024 11:41:40 +0200
Message-ID: <20240722094226.21602-30-ysionneau@kalrayinc.com>
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

Add some library functions for kvx, including: delay, memset,
memcpy, strlen, clear_page, copy_page, raw_copy_from/to_user,
asm_clear_user and libgcc functions.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: no changes

V2 -> V3:
- Add code to remove dependency on libgcc (lib/div.c)
- simplify memset assembly code: remove special handling of memset '\0'
- typos
- use SYM_FUNC_{START/END} instead of ENTRY/ENDPROC
---
 arch/kvx/include/asm/string.h |  20 ++++
 arch/kvx/lib/clear_page.S     |  40 +++++++
 arch/kvx/lib/copy_page.S      |  90 ++++++++++++++
 arch/kvx/lib/delay.c          |  40 +++++++
 arch/kvx/lib/div.c            | 198 +++++++++++++++++++++++++++++++
 arch/kvx/lib/libgcc.h         |  25 ++++
 arch/kvx/lib/memcpy.c         |  72 ++++++++++++
 arch/kvx/lib/memset.S         | 216 ++++++++++++++++++++++++++++++++++
 arch/kvx/lib/strlen.S         | 122 +++++++++++++++++++
 arch/kvx/lib/usercopy.S       |  90 ++++++++++++++
 10 files changed, 913 insertions(+)
 create mode 100644 arch/kvx/include/asm/string.h
 create mode 100644 arch/kvx/lib/clear_page.S
 create mode 100644 arch/kvx/lib/copy_page.S
 create mode 100644 arch/kvx/lib/delay.c
 create mode 100644 arch/kvx/lib/div.c
 create mode 100644 arch/kvx/lib/libgcc.h
 create mode 100644 arch/kvx/lib/memcpy.c
 create mode 100644 arch/kvx/lib/memset.S
 create mode 100644 arch/kvx/lib/strlen.S
 create mode 100644 arch/kvx/lib/usercopy.S

diff --git a/arch/kvx/include/asm/string.h b/arch/kvx/include/asm/string.h
new file mode 100644
index 0000000000000..677c1393a5cdb
--- /dev/null
+++ b/arch/kvx/include/asm/string.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Jules Maselbas
+ */
+
+#ifndef _ASM_KVX_STRING_H
+#define _ASM_KVX_STRING_H
+
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *s, int c, size_t n);
+
+#define __HAVE_ARCH_MEMCPY
+extern void *memcpy(void *dest, const void *src, size_t n);
+
+#define __HAVE_ARCH_STRLEN
+extern size_t strlen(const char *s);
+
+#endif	/* _ASM_KVX_STRING_H */
diff --git a/arch/kvx/lib/clear_page.S b/arch/kvx/lib/clear_page.S
new file mode 100644
index 0000000000000..8c97b2ae84bb3
--- /dev/null
+++ b/arch/kvx/lib/clear_page.S
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Marius Gligor
+ *            Clement Leger
+ */
+
+#include <linux/linkage.h>
+#include <linux/export.h>
+#include <linux/const.h>
+
+#include <asm/cache.h>
+#include <asm/page.h>
+
+#define CLEAR_PAGE_LOOP_COUNT	(PAGE_SIZE / 32)
+
+/*
+ * Clear page @dest.
+ *
+ * Parameters:
+ *	r0 - dest page
+ */
+SYM_FUNC_START(clear_page)
+	make $r1 = CLEAR_PAGE_LOOP_COUNT
+	;;
+	make $r4 = 0
+	make $r5 = 0
+	make $r6 = 0
+	make $r7 = 0
+	;;
+
+	loopdo $r1, clear_page_done
+		;;
+		so 0[$r0] = $r4r5r6r7
+		addd $r0 = $r0, 32
+		;;
+	clear_page_done:
+	ret
+	;;
+SYM_FUNC_END(clear_page)
diff --git a/arch/kvx/lib/copy_page.S b/arch/kvx/lib/copy_page.S
new file mode 100644
index 0000000000000..8bffc56ef9752
--- /dev/null
+++ b/arch/kvx/lib/copy_page.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/linkage.h>
+#include <linux/const.h>
+
+#include <asm/page.h>
+
+/* We have 8 load/store octuple (32 bytes) per hardware loop */
+#define COPY_SIZE_PER_LOOP	(32 * 8)
+#define COPY_PAGE_LOOP_COUNT	(PAGE_SIZE / COPY_SIZE_PER_LOOP)
+
+/*
+ * Copy a page from src to dest (both are page aligned)
+ * In order to recover from smem latency, unroll the loop to trigger multiple
+ * onfly loads and avoid waiting too much for them to return.
+ * We use 8 * 32 load even though we could use more (up to 10 loads) to simplify
+ * the handling using a single hardware loop
+ *
+ * Parameters:
+ *	r0 - dest
+ *	r1 - src
+ */
+SYM_FUNC_START(copy_page)
+	make $r2 = COPY_PAGE_LOOP_COUNT
+	make $r3 = 0
+	;;
+	loopdo $r2, copy_page_done
+		;;
+		/*
+		 * Load 8 * 32 bytes using uncached access to avoid hitting
+		 * the cache
+		 */
+		lo.xs $r32r33r34r35 = $r3[$r1]
+		/* Copy current copy index for store */
+		copyd $r2 = $r3
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r36r37r38r39 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r40r41r42r43 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r44r45r46r47 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r48r49r50r51 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r52r53r54r55 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r56r57r58r59 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r60r61r62r63 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		/* And then store all of them */
+		so.xs $r2[$r0] = $r32r33r34r35
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r36r37r38r39
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r40r41r42r43
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r44r45r46r47
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r48r49r50r51
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r52r53r54r55
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r56r57r58r59
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r60r61r62r63
+		;;
+	copy_page_done:
+	ret
+	;;
+SYM_FUNC_END(copy_page)
diff --git a/arch/kvx/lib/delay.c b/arch/kvx/lib/delay.c
new file mode 100644
index 0000000000000..96e59114b47dd
--- /dev/null
+++ b/arch/kvx/lib/delay.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/export.h>
+#include <linux/delay.h>
+
+#include <asm/param.h>
+#include <asm/timex.h>
+
+void __delay(unsigned long loops)
+{
+	cycles_t target_cycle = get_cycles() + loops;
+
+	while (get_cycles() < target_cycle)
+		;
+}
+EXPORT_SYMBOL(__delay);
+
+inline void __const_udelay(unsigned long xloops)
+{
+	u64 loops = (u64)xloops * (u64)loops_per_jiffy * HZ;
+
+	__delay(loops >> 32);
+}
+EXPORT_SYMBOL(__const_udelay);
+
+void __udelay(unsigned long usecs)
+{
+	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+}
+EXPORT_SYMBOL(__udelay);
+
+void __ndelay(unsigned long nsecs)
+{
+	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+}
+EXPORT_SYMBOL(__ndelay);
diff --git a/arch/kvx/lib/div.c b/arch/kvx/lib/div.c
new file mode 100644
index 0000000000000..1e107732e1a23
--- /dev/null
+++ b/arch/kvx/lib/div.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Benoit Dinechin
+ */
+#include <linux/types.h>
+#include "libgcc.h"
+
+static inline uint64x4_t uint64x2_divmod(uint64x2_t a, uint64x2_t b)
+{
+	float64x2_t double1 = 1.0 - (float64x2_t){};
+	int64x2_t bbig = (int64x2_t)b < 0;
+	int64x2_t bin01 = (uint64x2_t)b <= 1;
+	int64x2_t special = bbig | bin01;
+	// uint64x2_t q = bbig ? a >= b : a;
+	uint64x2_t q = __builtin_kvx_selectdp(-(a >= b), a, bbig, ".nez");
+	// uint64x2_t r = bbig ? a - (b&-q) : 0;
+	uint64x2_t r = __builtin_kvx_selectdp(a - (b & -q), 0 - (uint64x2_t){}, bbig, ".nez");
+	float64x2_t doublea = __builtin_kvx_floatudp(a, 0, ".rn.s");
+	float64x2_t doubleb = __builtin_kvx_floatudp(b, 0, ".rn.s");
+	float floatb_0 = __builtin_kvx_fnarrowdw(doubleb[0], ".rn.s");
+	float floatb_1 = __builtin_kvx_fnarrowdw(doubleb[1], ".rn.s");
+	float floatrec_0 = __builtin_kvx_frecw(floatb_0, ".rn.s");
+	float floatrec_1 = __builtin_kvx_frecw(floatb_1, ".rn.s");
+
+	if (__builtin_kvx_anydp(b, ".eqz"))
+		goto div0;
+
+	float64x2_t doublerec = {__builtin_kvx_fwidenwd(floatrec_0, ".s"),
+				 __builtin_kvx_fwidenwd(floatrec_1, ".s")};
+	float64x2_t doubleq0 = __builtin_kvx_fmuldp(doublea, doublerec, ".rn.s");
+	uint64x2_t q0 = __builtin_kvx_fixedudp(doubleq0, 0, ".rn.s");
+	int64x2_t a1 = (int64x2_t)(a - q0 * b);
+	float64x2_t alpha = __builtin_kvx_ffmsdp(doubleb, doublerec, double1, ".rn.s");
+	float64x2_t beta = __builtin_kvx_ffmadp(alpha, doublerec, doublerec, ".rn.s");
+	float64x2_t doublea1 = __builtin_kvx_floatdp(a1, 0, ".rn.s");
+	float64x2_t gamma = __builtin_kvx_fmuldp(beta, doublea1, ".rn.s");
+	int64x2_t q1 = __builtin_kvx_fixeddp(gamma, 0, ".rn.s");
+	int64x2_t rem = a1 - q1 * b;
+	uint64x2_t quo = q0 + q1;
+	uint64x2_t cond = (uint64x2_t)(rem >> 63);
+
+	// q = !special ? quo + cond : q;
+	q = __builtin_kvx_selectdp(quo + cond, q, special, ".eqz");
+	// r = !special ? rem + (b & cond) : r;
+	r = __builtin_kvx_selectdp(rem + (b & cond), r, special, ".eqz");
+	return __builtin_kvx_cat256(q, r);
+
+div0:
+	__builtin_trap();
+}
+
+static inline uint32x4_t uint32x2_divmod(uint32x2_t a, uint32x2_t b)
+{
+	int i;
+
+	uint64x2_t acc = __builtin_kvx_widenwdp(a, ".z");
+	uint64x2_t src = __builtin_kvx_widenwdp(b, ".z") << (32 - 1);
+	uint64x2_t wb = __builtin_kvx_widenwdp(b, ".z");
+	uint32x2_t q, r;
+
+	if (__builtin_kvx_anywp(b, ".eqz"))
+		goto div0;
+	// As `src == b << (32 -1)` adding src yields `src == b << 32`.
+	src += src & (wb > acc);
+
+	for (i = 0; i < 32; i++)
+		acc = __builtin_kvx_stsudp(src, acc);
+
+	q = __builtin_kvx_narrowdwp(acc, "");
+	r = __builtin_kvx_narrowdwp(acc >> 32, "");
+	return __builtin_kvx_cat128(q, r);
+div0:
+	__builtin_trap();
+}
+
+
+int32x2_t __divv2si3(int32x2_t a, int32x2_t b)
+{
+	uint32x2_t absa = __builtin_kvx_abswp(a, "");
+	uint32x2_t absb = __builtin_kvx_abswp(b, "");
+	uint32x4_t divmod = uint32x2_divmod(absa, absb);
+	int32x2_t result = __builtin_kvx_low64(divmod);
+
+	return __builtin_kvx_selectwp(-result, result, a ^ b, ".ltz");
+}
+
+
+uint64x2_t __udivv2di3(uint64x2_t a, uint64x2_t b)
+{
+	uint64x4_t divmod = uint64x2_divmod(a, b);
+
+	return __builtin_kvx_low128(divmod);
+}
+
+uint64x2_t __umodv2di3(uint64x2_t a, uint64x2_t b)
+{
+	uint64x4_t divmod = uint64x2_divmod(a, b);
+
+	return __builtin_kvx_high128(divmod);
+}
+
+int64x2_t __modv2di3(int64x2_t a, int64x2_t b)
+{
+	uint64x2_t absa = __builtin_kvx_absdp(a, "");
+	uint64x2_t absb = __builtin_kvx_absdp(b, "");
+	uint64x4_t divmod = uint64x2_divmod(absa, absb);
+	int64x2_t result = __builtin_kvx_high128(divmod);
+
+	return __builtin_kvx_selectdp(-result, result, a, ".ltz");
+}
+
+uint64_t __udivdi3(uint64_t a, uint64_t b)
+{
+	uint64x2_t udivv2di3 = __udivv2di3(a - (uint64x2_t){}, b - (uint64x2_t){});
+
+	return (uint64_t)udivv2di3[1];
+}
+
+static inline uint64x2_t uint64_divmod(uint64_t a, uint64_t b)
+{
+	double double1 = 1.0;
+	int64_t bbig = (int64_t)b < 0;
+	int64_t bin01 = (uint64_t)b <= 1;
+	int64_t special = bbig | bin01;
+	// uint64_t q = bbig ? a >= b : a;
+	uint64_t q = __builtin_kvx_selectd(a >= b, a, bbig, ".dnez");
+	// uint64_t r = bbig ? a - (b&-q) : 0;
+	uint64_t r = __builtin_kvx_selectd(a - (b & -q), 0, bbig, ".dnez");
+	double doublea = __builtin_kvx_floatud(a, 0,  ".rn.s");
+	double doubleb = __builtin_kvx_floatud(b, 0, ".rn.s");
+	float floatb = __builtin_kvx_fnarrowdw(doubleb, ".rn.s");
+	float floatrec = __builtin_kvx_frecw(floatb, ".rn.s");
+
+	if (b == 0)
+		goto div0;
+
+	double doublerec = __builtin_kvx_fwidenwd(floatrec, ".s");
+	double doubleq0 = __builtin_kvx_fmuld(doublea, doublerec, ".rn.s");
+	uint64_t q0 = __builtin_kvx_fixedud(doubleq0, 0, ".rn.s");
+	int64_t a1 = a - q0 * b;
+	double alpha = __builtin_kvx_ffmsd(doubleb, doublerec, double1, ".rn.s");
+	double beta = __builtin_kvx_ffmad(alpha, doublerec, doublerec, ".rn.s");
+	double doublea1 = __builtin_kvx_floatd(a1, 0, ".rn.s");
+	double gamma = __builtin_kvx_fmuld(beta, doublea1, ".rn.s");
+	int64_t q1 = __builtin_kvx_fixedd(gamma, 0, ".rn.s");
+	int64_t rem = a1 - q1 * b;
+	uint64_t quo = q0 + q1;
+	uint64_t cond = rem >> 63;
+
+	// q = !special ? quo + cond : q;
+	q = __builtin_kvx_selectd(quo + cond, q, special, ".deqz");
+	// r = !special ? rem + (b & cond) : r;
+	r = __builtin_kvx_selectd(rem + (b & cond), r, special, ".deqz");
+
+	return (uint64x2_t){q, r};
+
+div0:
+	__builtin_trap();
+}
+
+
+int64_t __divdi3(int64_t a, int64_t b)
+{
+	uint64_t absa = __builtin_kvx_absd(a, "");
+	uint64_t absb = __builtin_kvx_absd(b, "");
+	uint64x2_t divmod = uint64_divmod(absa, absb);
+
+	if ((a ^ b) < 0)
+		divmod[0] = -divmod[0];
+
+	return divmod[0];
+}
+
+
+uint64_t __umoddi3(uint64_t a, uint64_t b)
+{
+	uint64x2_t umodv2di3 = __umodv2di3(a - (uint64x2_t){}, b - (uint64x2_t){});
+
+	return (uint64_t)umodv2di3[1];
+}
+
+int64_t __moddi3(int64_t a, int64_t b)
+{
+	int64x2_t modv2di3 = __modv2di3(a - (int64x2_t){}, b - (int64x2_t){});
+
+	return (int64_t)modv2di3[1];
+}
+
+int64x2_t __divv2di3(int64x2_t a, int64x2_t b)
+{
+	uint64x2_t absa = __builtin_kvx_absdp(a, "");
+	uint64x2_t absb = __builtin_kvx_absdp(b, "");
+	uint64x4_t divmod = uint64x2_divmod(absa, absb);
+	int64x2_t result = __builtin_kvx_low128(divmod);
+
+	return __builtin_kvx_selectdp(-result, result, a ^ b, ".ltz");
+}
diff --git a/arch/kvx/lib/libgcc.h b/arch/kvx/lib/libgcc.h
new file mode 100644
index 0000000000000..cbbe33762ecc4
--- /dev/null
+++ b/arch/kvx/lib/libgcc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Benoit Dinechin
+ */
+
+typedef uint32_t uint32x2_t __attribute((vector_size(2 * sizeof(uint32_t))));
+typedef uint32_t uint32x4_t __attribute((vector_size(4 * sizeof(uint32_t))));
+typedef int32_t int32x2_t __attribute((vector_size(2 * sizeof(int32_t))));
+typedef int64_t int64x2_t __attribute((vector_size(2 * sizeof(int64_t))));
+typedef uint64_t uint64x2_t __attribute((vector_size(2 * sizeof(uint64_t))));
+typedef uint64_t uint64x4_t __attribute((vector_size(4 * sizeof(uint64_t))));
+
+typedef double float64_t;
+typedef float64_t float64x2_t __attribute((vector_size(2 * sizeof(float64_t))));
+
+int32x2_t __divv2si3(int32x2_t a, int32x2_t b);
+uint64x2_t __udivv2di3(uint64x2_t a, uint64x2_t b);
+uint64x2_t __umodv2di3(uint64x2_t a, uint64x2_t b);
+int64x2_t __modv2di3(int64x2_t a, int64x2_t b);
+uint64_t __udivdi3(uint64_t a, uint64_t b);
+int64_t __divdi3(int64_t a, int64_t b);
+uint64_t __umoddi3(uint64_t a, uint64_t b);
+int64_t __moddi3(int64_t a, int64_t b);
+int64x2_t __divv2di3(int64x2_t a, int64x2_t b);
diff --git a/arch/kvx/lib/memcpy.c b/arch/kvx/lib/memcpy.c
new file mode 100644
index 0000000000000..17343537a4346
--- /dev/null
+++ b/arch/kvx/lib/memcpy.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#include <linux/export.h>
+#include <linux/types.h>
+
+#include <asm/string.h>
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+	__uint128_t *tmp128_d = dest;
+	const __uint128_t *tmp128_s = src;
+	uint64_t *tmp64_d;
+	const uint64_t *tmp64_s;
+	uint32_t *tmp32_d;
+	const uint32_t *tmp32_s;
+	uint16_t *tmp16_d;
+	const uint16_t *tmp16_s;
+	uint8_t *tmp8_d;
+	const uint8_t *tmp8_s;
+
+	while (n >= 16) {
+		*tmp128_d = *tmp128_s;
+		tmp128_d++;
+		tmp128_s++;
+		n -= 16;
+	}
+
+	tmp64_d = (uint64_t *) tmp128_d;
+	tmp64_s = (uint64_t *) tmp128_s;
+	while (n >= 8) {
+		*tmp64_d = *tmp64_s;
+		tmp64_d++;
+		tmp64_s++;
+		n -= 8;
+	}
+
+	tmp32_d = (uint32_t *) tmp64_d;
+	tmp32_s = (uint32_t *) tmp64_s;
+	while (n >= 4) {
+		*tmp32_d = *tmp32_s;
+		tmp32_d++;
+		tmp32_s++;
+		n -= 4;
+	}
+
+	tmp16_d = (uint16_t *) tmp32_d;
+	tmp16_s = (uint16_t *) tmp32_s;
+	while (n >= 2) {
+		*tmp16_d = *tmp16_s;
+		tmp16_d++;
+		tmp16_s++;
+		n -= 2;
+	}
+
+	tmp8_d = (uint8_t *) tmp16_d;
+	tmp8_s = (uint8_t *) tmp16_s;
+	while (n >= 1) {
+		*tmp8_d = *tmp8_s;
+		tmp8_d++;
+		tmp8_s++;
+		n--;
+	}
+
+	return dest;
+}
+EXPORT_SYMBOL(memcpy);
+
diff --git a/arch/kvx/lib/memset.S b/arch/kvx/lib/memset.S
new file mode 100644
index 0000000000000..bd2eec89ae1a3
--- /dev/null
+++ b/arch/kvx/lib/memset.S
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Marius Gligor
+ *            Jules Maselbas
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/cache.h>
+
+#define REPLICATE_BYTE_MASK	0x0101010101010101
+#define MIN_SIZE_FOR_ALIGN	128
+
+/*
+ * Optimized memset for kvx architecture
+ *
+ * In order to optimize memset on kvx, we can use various things:
+ * - conditional store which avoids branch penalty
+ * - store half/word/double/quad/octuple to store up to 32 bytes at a time
+ * - hardware loop for steady cases.
+ *
+ * First, we start by checking if the size is below a minimum size. If so, we
+ * skip the alignment part. The kvx architecture supports misalignment and the
+ * penalty for doing unaligned accesses is lower than trying to do realigning.
+ * So for small sizes, we don't even bother to realign.
+ * The sbmm8 instruction is used to replicate the pattern on all bytes of a
+ * register in one call.
+ * Once alignment has been reached, we can use the hardware loop in order to
+ * optimize throughput. Care must be taken to align hardware loops on at least
+ * 8 bytes for better performances.
+ * Once the main loop has been done, we finish the copy by checking length to do
+ * the necessary calls to store remaining bytes.
+ *
+ * Pseudo code:
+ *
+ * int memset(void *dest, char pattern, long length)
+ * {
+ * 	long dest_align = -((long) dest);
+ * 	long copy;
+ * 	long orig_dest = dest;
+ *
+ * 	uint64_t pattern = sbmm8(pattern, 0x0101010101010101);
+ * 	uint128_t pattern128 = pattern << 64 | pattern;
+ * 	uint256_t pattern128 = pattern128 << 128 | pattern128;
+ *
+ * 	// Keep only low bits
+ * 	dest_align &= 0x1F;
+ * 	length -= dest_align;
+ *
+ * 	// Byte align
+ * 	copy = align & (1 << 0);
+ * 	if (copy)
+ * 		*((u8 *) dest) = pattern;
+ * 	dest += copy;
+ * 	// Half align
+ * 	copy = align & (1 << 1);
+ * 	if (copy)
+ * 		*((u16 *) dest) = pattern;
+ * 	dest += copy;
+ * 	// Word align
+ * 	copy = align & (1 << 2);
+ * 	if (copy)
+ * 		*((u32 *) dest) = pattern;
+ * 	dest += copy;
+ * 	// Double align
+ * 	copy = align & (1 << 3);
+ * 	if (copy)
+ * 		*((u64 *) dest) = pattern;
+ * 	dest += copy;
+ * 	// Quad align
+ * 	copy = align & (1 << 4);
+ * 	if (copy)
+ * 		*((u128 *) dest) = pattern128;
+ * 	dest += copy;
+ *
+ * 	// We are now aligned on 256 bits
+ * 	loop_octuple_count = size >> 5;
+ * 	for (i = 0; i < loop_octuple_count; i++) {
+ * 		*((u256 *) dest) = pattern256;
+ * 		dest += 32;
+ * 	}
+ *
+ * 	if (length == 0)
+ * 		return orig_dest;
+ *
+ * 	// Copy remaining part
+ * 	remain = length & (1 << 4);
+ * 	if (copy)
+ * 		*((u128 *) dest) = pattern128;
+ * 	dest += remain;
+ * 	remain = length & (1 << 3);
+ * 	if (copy)
+ * 		*((u64 *) dest) = pattern;
+ * 	dest += remain;
+ * 	remain = length & (1 << 2);
+ * 	if (copy)
+ * 		*((u32 *) dest) = pattern;
+ * 	dest += remain;
+ * 	remain = length & (1 << 1);
+ * 	if (copy)
+ * 		*((u16 *) dest) = pattern;
+ * 	dest += remain;
+ * 	remain = length & (1 << 0);
+ * 	if (copy)
+ * 		*((u8 *) dest) = pattern;
+ * 	dest += remain;
+ *
+ * 	return orig_dest;
+ * }
+ */
+
+.text
+.align 16
+SYM_FUNC_START(memset):
+	/* Preserve return value */
+	copyd $r3 = $r0
+	/* Replicate the first pattern byte on all bytes */
+	sbmm8 $r32 = $r1, REPLICATE_BYTE_MASK
+	/* Check if length < MIN_SIZE_FOR_ALIGN */
+	compd.geu $r7 = $r2, MIN_SIZE_FOR_ALIGN
+	/* Invert address to compute size to copy to be aligned on 32 bytes */
+	negd $r5 = $r0
+	;;
+	/* Copy second part of pattern for sq */
+	copyd $r33 = $r32
+	/* Compute the size that will be copied to align on 32 bytes boundary */
+	andw $r5 = $r5, 0x1F
+	;;
+	/*
+	 * If size < MIN_SIZE_FOR_ALIGN bits, directly go to so, it will be done
+	 * unaligned but that is still better that what we can do with sb
+	 */
+	cb.deqz $r7? .Laligned_32
+	;;
+	/* If we are already aligned on 32 bytes, jump to main "so" loop */
+	cb.deqz $r5? .Laligned_32
+	/* Remove unaligned part from length */
+	sbfd $r2 = $r5, $r2
+	/* Check if we need to copy 1 byte */
+	andw $r4 = $r5, (1 << 0)
+	;;
+	/* If we are not aligned, store byte */
+	sb.dnez $r4? [$r0] = $r32
+	addd $r0 = $r0, $r4
+	/* Check if we need to copy 2 bytes */
+	andw $r4 = $r5, (1 << 1)
+	;;
+	sh.dnez $r4? [$r0] = $r32
+	addd $r0 = $r0, $r4
+	/* Check if we need to copy 4 bytes */
+	andw $r4 = $r5, (1 << 2)
+	;;
+	sw.dnez $r4? [$r0] = $r32
+	addd $r0 = $r0, $r4
+	/* Check if we need to copy 8 bytes */
+	andw $r4 = $r5, (1 << 3)
+	;;
+	sd.dnez $r4? [$r0] = $r32
+	addd $r0 = $r0, $r4
+	/* Check if we need to copy 16 bytes */
+	andw $r4 = $r5, (1 << 4)
+	;;
+	sq.dnez $r4? [$r0] = $r32r33
+	addd $r0 = $r0, $r4
+	;;
+.Laligned_32:
+	/* Prepare amount of data for 32 bytes store */
+	srld $r10 = $r2, 5
+	;;
+	copyq $r34r35 = $r32, $r33
+	/* Remaining bytes for 16 bytes store */
+	andw $r8 = $r2, (1 << 4)
+	make $r11 = 32
+	/* Check if there are enough data for 32 bytes store */
+	cb.deqz $r10? .Laligned_32_done
+	;;
+	loopdo $r10, .Laligned_32_done
+		;;
+		so 0[$r0] = $r32r33r34r35
+		addd $r0 = $r0, $r11
+		;;
+.Laligned_32_done:
+	/*
+	 * Now that we have handled every aligned bytes using 'so', we can
+	 * handled the remainder of length using store by decrementing size
+	 * We also exploit the fact we are aligned to simply check remaining
+	 * size */
+	sq.dnez $r8? [$r0] = $r32r33
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 8 bytes store */
+	andw $r8 = $r2, (1 << 3)
+	cb.deqz $r2? .Lmemset_done
+	;;
+	sd.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 4 bytes store */
+	andw $r8 = $r2, (1 << 2)
+	;;
+	sw.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 2 bytes store */
+	andw $r8 = $r2, (1 << 1)
+	;;
+	sh.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	;;
+	sb.odd $r2? [$r0] = $r32
+	;;
+.Lmemset_done:
+	/* Restore original value */
+	copyd $r0 = $r3
+	ret
+	;;
+SYM_FUNC_END(memset)
diff --git a/arch/kvx/lib/strlen.S b/arch/kvx/lib/strlen.S
new file mode 100644
index 0000000000000..c4bffb56cfa64
--- /dev/null
+++ b/arch/kvx/lib/strlen.S
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Jules Maselbas
+ */
+#include <linux/linkage.h>
+#include <linux/export.h>
+
+/*
+ *	kvx optimized strlen
+ *
+ *	This implementation of strlen only does aligned memory accesses.
+ *	Since we don't know the total length the idea is to do double word
+ *	load and stop on the first null byte found. As it's always safe to
+ *	read more up to a lower 8-bytes boundary.
+ *
+ *	This implementation of strlen uses a trick to detect if a double
+ *	word contains a null byte [1]:
+ *
+ *	> #define haszero(v) (((v) - 0x01010101UL) & ~(v) & 0x80808080UL)
+ *	> The sub-expression (v - 0x01010101UL), evaluates to a high bit set
+ *	> in any byte whenever the corresponding byte in v is zero or greater
+ *	> than 0x80. The sub-expression ~v & 0x80808080UL evaluates to high
+ *	> bits set in bytes where the byte of v doesn't have its high bit set
+ *	> (so the byte was less than 0x80). Finally, by ANDing these two sub-
+ *	> expressions the result is the high bits set where the bytes in v
+ *	> were zero, since the high bits set due to a value greater than 0x80
+ *	> in the first sub-expression are masked off by the second.
+ *
+ *	[1] http://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
+ *
+ *	A second trick is used to get the exact number of characters before
+ *	the first null byte in a double word:
+ *
+ *		clz(sbmmt(zero, 0x0102040810204080))
+ *
+ *	This trick uses the haszero result which maps null byte to 0x80 and
+ *	others value to 0x00. The idea is to count the number of consecutive
+ *	null byte in the double word (counting from less significant byte
+ *	to most significant byte). To do so, using the bit matrix transpose
+ *	will "pack" all high bit (0x80) to the most significant byte (MSB).
+ *	It is not possible to count the trailing zeros in this MSB, however
+ *	if a byte swap is done before the bit matrix transpose we still have
+ *	all the information in the MSB but now we can count the leading zeros.
+ *	The instruction sbmmt with the matrix 0x0102040810204080 does exactly
+ *	what we need a byte swap followed by a bit transpose.
+ *
+ *	A last trick is used to handle the first double word misalignment.
+ *	This is done by masking off the N lower bytes (excess read) with N
+ *	between 0 and 7. The mask is applied on haszero results and will
+ *	force the N lower bytes to be considered not null.
+ *
+ *	This is a C implementation of the algorithm described above:
+ *
+ *	size_t strlen(char *s) {
+ *		uint64_t *p    = (uint64_t *)((uintptr_t)s) & ~0x7;
+ *		uint64_t rem   = ((uintptr_t)s) % 8;
+ *		uint64_t low   = -0x0101010101010101;
+ *		uint64_t high  =  0x8080808080808080;
+ *		uint64_t dword, zero;
+ *		uint64_t msk, len;
+ *
+ *		dword = *p++;
+ *		zero  = (dword + low) & ~dword & high;
+ *		msk   = 0xffffffffffffffff << (rem * 8);
+ *		zero &= msk;
+ *
+ *		while (!zero) {
+ *			dword = *p++;
+ *			zero  = (dword + low) & ~dword & high;
+ *		}
+ *
+ *		zero = __builtin_kvx_sbmmt8(zero, 0x0102040810204080);
+ *		len = ((void *)p - (void *)s) - 8;
+ *		len += __builtin_kvx_clzd(zero);
+ *
+ *		return len;
+ *	}
+ */
+
+.text
+.align 16
+SYM_FUNC_START(strlen)
+	andd  $r1 = $r0, ~0x7
+	andd  $r2 = $r0,  0x7
+	make $r10 = -0x0101010101010101
+	make $r11 =  0x8080808080808080
+	;;
+	ld $r4 = 0[$r1]
+	sllw $r2 = $r2, 3
+	make $r3 = 0xffffffffffffffff
+	;;
+	slld $r2 = $r3, $r2
+	addd $r5 = $r4, $r10
+	andnd $r6 = $r4, $r11
+	;;
+	andd $r6 = $r6, $r2
+	make $r3 = 0
+	;;
+.loop:
+	andd $r4 = $r5, $r6
+	addd $r1 = $r1, 0x8
+	;;
+	cb.dnez $r4? .end
+	ld.deqz $r4? $r4 = [$r1]
+	;;
+	addd $r5 = $r4, $r10
+	andnd $r6 = $r4, $r11
+	goto .loop
+	;;
+.end:
+	addd $r1 = $r1, -0x8
+	sbmmt8 $r4 = $r4, 0x0102040810204080
+	;;
+	clzd $r4 = $r4
+	sbfd $r1 = $r0, $r1
+	;;
+	addd $r0 = $r4, $r1
+	ret
+	;;
+SYM_FUNC_END(strlen)
+EXPORT_SYMBOL(strlen)
diff --git a/arch/kvx/lib/usercopy.S b/arch/kvx/lib/usercopy.S
new file mode 100644
index 0000000000000..950df1e88479d
--- /dev/null
+++ b/arch/kvx/lib/usercopy.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+#include <linux/linkage.h>
+
+/**
+ * Copy from/to a user buffer
+ * r0 = to buffer
+ * r1 = from buffer
+ * r2 = size to copy
+ * This function can trapped when hitting a non-mapped page.
+ * It will trigger a trap NOMAPPING and the trap handler will interpret
+ * it and check if instruction pointer is inside __ex_table.
+ * The next step are described later !
+ */
+.text
+SYM_FUNC_START(raw_copy_from_user)
+SYM_FUNC_START(raw_copy_to_user)
+	/**
+	 * naive implementation byte per byte
+	 */
+	make $r33 = 0x0;
+	/* If size == 0, exit directly */
+	cb.deqz $r2? copy_exit
+	;;
+	loopdo $r2, copy_exit
+		;;
+0:		lbz $r34 = $r33[$r1]
+		;;
+1:		sb $r33[$r0] = $r34
+		addd $r33 = $r33, 1 /* Ptr increment */
+		addd $r2 = $r2, -1 /* Remaining bytes to copy */
+		;;
+	copy_exit:
+	copyd $r0 = $r2
+	ret
+	;;
+SYM_FUNC_END(raw_copy_to_user)
+SYM_FUNC_END(raw_copy_from_user)
+
+/**
+ * Exception table
+ * each entry correspond to the following:
+ * .dword trapping_addr, restore_addr
+ *
+ * On trap, the handler will try to locate if $spc is matching a
+ * trapping address in the exception table. If so, the restore addr
+ * will  be put in the return address of the trap handler, allowing
+ * to properly finish the copy and return only the bytes copied/cleared
+ */
+.pushsection __ex_table,"a"
+.balign 8
+.dword 0b, copy_exit
+.dword 1b, copy_exit
+.popsection
+
+/**
+ * Clear a user buffer
+ * r0 = buffer to clear
+ * r1 = size to clear
+ */
+.text
+SYM_FUNC_START(asm_clear_user)
+	/**
+	 * naive implementation byte per byte
+	 */
+	make $r33 = 0x0;
+	make $r34 = 0x0;
+	/* If size == 0, exit directly */
+	cb.deqz $r1? clear_exit
+	;;
+	loopdo $r1, clear_exit
+		;;
+40:		sb $r33[$r0] = $r34
+		addd $r33 = $r33, 1 /* Ptr increment */
+		addd $r1 = $r1, -1 /* Remaining bytes to copy */
+		;;
+	clear_exit:
+	copyd $r0 = $r1
+	ret
+	;;
+SYM_FUNC_END(asm_clear_user)
+
+.pushsection __ex_table,"a"
+.balign 8
+.dword 40b, clear_exit
+.popsection
+
-- 
2.45.2






