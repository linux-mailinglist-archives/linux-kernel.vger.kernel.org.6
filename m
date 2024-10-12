Return-Path: <linux-kernel+bounces-362075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172CC99B096
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0421F23042
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D012C552;
	Sat, 12 Oct 2024 04:00:54 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CD85656
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705654; cv=none; b=d2grlUjBkbiLh8ofCf7Sk+0Ip2VAgHh7YdW2s8Q0e4qnn45c8E4QW2fV95kmgbKZAZZryTKQXUp61uWRUiuNr+Qby4dI/OAQPZXwLMqlVi5qzd3OPDLPXVg0CsLn6YyG0C+lRgb2RNImohKpDMqpGirHn/fPp9a89FADdSXG9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705654; c=relaxed/simple;
	bh=CNualBh+6zKfNfBry8KERKoILgyCwRF37DMX+DsK9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3tSIzWLsjddDkYcD6lw+DeR4DMMz4CZUE3QCyoMIwp7LospmpMERed3a6Bkg54ld6B8bdLwjZX1vfRGi+lmkxVFJelOZPHHAt6yKkB/izYybtD3R333yPW3DyYnNsFLMHfA4wEqcnLgoc+BQhWNqh75l6js1g0rNT6d6fkAmxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz3t1728705587t36gh90
X-QQ-Originating-IP: 2FaNmLZVeGG3UdHWFWpVZfwY+GrSvchhrlU49rvVvmU=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 12 Oct 2024 11:59:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 707350123968797831
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 6/7] powerpc/entry: factout irqentry-state
Date: Sat, 12 Oct 2024 11:56:20 +0800
Message-ID: <E6FB8D32FAAFC3BE+20241012035621.1245-8-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20241012035621.1245-3-luming.yu@shingroup.cn>
References: <20241012035621.1245-3-luming.yu@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N4FDxPgVXe+s1c+wgvBYQyvtkSz9EaR/aPZ579CFzI9V2Od2jM6nFLW9
	9tlKJQWNChNK+IUQH3uxJo2qIqW8HMM5XNxkA+Ydgh3PTN5fXQ7E9VhAjGOW6nCY27NyCY/
	TqM65n1+kWwYZ2b0GWCHE5Z1JpNKOgjtNJP4wa8Xj+7drBdoWF5mBE7gge7BtvMWSwoIUVp
	j3m7Oh0bNzY+B/CNepWYT3qNIsIteOyeu8k8vue6Fo5NdmFiTq0jMWgcCZjvPvTFFZyKOIr
	l8HTepxdIKuojjMxfsEsQ/YxSFsawWeMCuBl+llnFDNODnidKNxwSdsSE8ZZ9PZ/PGCjf+P
	u5HAZWpccU7KHb+1lpolqnasuNFUZiD+Jv4f9IMeKtUscT/+kz4aFscqpbSUmd0EwEVdC4D
	mWYB+xYN+4ce9Eo+0vB+uOGBW/v4KnvzFToeuiNz7d0b0cFaA8i3t7mWj+W5CnpIj1N8J50
	AVXnKUlTWA4nNgES+87mULNhsckxj0DAzxMvjsFQ7o/NWnQygfdQYjS36oj8drPSFmu9jHl
	v9nv02BO7yhANG1BD5eVncqM5I9hofiJqF31XMalA7KhR/xcoH7BoiwGlobSQ7uHSATWyP8
	1YaWTUNl9nax+6JiXJOy9JyEiaH47cr3SZUUPc6YPR1V9x8+5GmXhqRs7BG2JnONfPFbfeQ
	jzbIgLS39rbdUxapKosJ+UfyCq9HnYIMBEqeSIZJP3Q7tw6LHEMqv2L983Ln7TVDViDbPkL
	REiAa1+NdaOkk9bz4BdBVB6BazAtvDI9z8GOQrTTNG3cw+6AQ7mJFn3s0EiXEphyUwp0xTG
	t44bghKQL1NWBowQXhAnshA4gaWBn21stYsW/IJkc/Da1TfkM5lWGM/k/ka3v2smbXVRN2E
	E9iWuD99aoC4DsWAKTL1SWYMcbcjnl88NGJ/b6p1z9F2EC3oap5PbJaySFS+fS17kz1UdcF
	XWts/houi6dKdrQ3/E2z03baqywLm4lMMpj7LZgW82Qa3fmpAYH6nz7DGCabFFUtcYVqJh1
	LAdDZGjA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

To have lowlevel paca.h include high level entry-common.h cause
include file dependency mess. Split irqentry-state.h to have
the irqentry_state.h can be included in low level paca.h

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/include/asm/paca.h |  2 ++
 arch/powerpc/kernel/interrupt.c |  2 ++
 include/linux/entry-common.h    | 24 ------------------------
 include/linux/irqentry-state.h  | 28 ++++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/irqentry-state.h

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e667d455ecb4..83ebe8e914b7 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_PPC64
 
 #include <linux/cache.h>
+#include <linux/irqentry-state.h>
 #include <linux/string.h>
 #include <asm/types.h>
 #include <asm/mmu.h>
@@ -282,6 +283,7 @@ struct paca_struct {
 	struct mce_info *mce_info;
 	u8 mce_pending_irq_work;
 #endif /* CONFIG_PPC_BOOK3S_64 */
+	irqentry_state_t irqentry_s;
 } ____cacheline_aligned;
 
 extern void copy_mm_to_paca(struct mm_struct *mm);
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 42af9217136d..8e4cabb0c592 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -311,6 +311,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 	BUG_ON(regs_is_unrecoverable(regs));
 	BUG_ON(arch_irq_disabled_regs(regs));
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
+	local_paca->irqentry_s = irqentry_enter(regs);
 
 	/*
 	 * We don't need to restore AMR on the way back to userspace for KUAP.
@@ -423,6 +424,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	 * AMR value from the check above.
 	 */
 	kuap_kernel_restore(regs, kuap);
+	irqentry_exit(regs, local_paca->irqentry_s);
 
 	return ret;
 }
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85f96ba..6521171469f2 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -352,30 +352,6 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
  */
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
-#ifndef irqentry_state
-/**
- * struct irqentry_state - Opaque object for exception state storage
- * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
- *            exit path has to invoke ct_irq_exit().
- * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
- *           lockdep state is restored correctly on exit from nmi.
- *
- * This opaque object is filled in by the irqentry_*_enter() functions and
- * must be passed back into the corresponding irqentry_*_exit() functions
- * when the exception is complete.
- *
- * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
- * and all members private.  Descriptions of the members are provided to aid in
- * the maintenance of the irqentry_*() functions.
- */
-typedef struct irqentry_state {
-	union {
-		bool	exit_rcu;
-		bool	lockdep;
-	};
-} irqentry_state_t;
-#endif
-
 /**
  * irqentry_enter - Handle state tracking on ordinary interrupt entries
  * @regs:	Pointer to pt_regs of interrupted context
diff --git a/include/linux/irqentry-state.h b/include/linux/irqentry-state.h
new file mode 100644
index 000000000000..d4ddeb1c6ab6
--- /dev/null
+++ b/include/linux/irqentry-state.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_IRQENTRYCOMMON_H
+#define __LINUX_IRQENTRYCOMMON_H
+
+#ifndef irqentry_state
+/**
+ * struct irqentry_state - Opaque object for exception state storage
+ * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
+ *            exit path has to invoke ct_irq_exit().
+ * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
+ *           lockdep state is restored correctly on exit from nmi.
+ *
+ * This opaque object is filled in by the irqentry_*_enter() functions and
+ * must be passed back into the corresponding irqentry_*_exit() functions
+ * when the exception is complete.
+ *
+ * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
+ * and all members private.  Descriptions of the members are provided to aid in
+ * the maintenance of the irqentry_*() functions.
+ */
+typedef struct irqentry_state {
+	union {
+		bool	exit_rcu;
+		bool	lockdep;
+	};
+} irqentry_state_t;
+#endif
+#endif
-- 
2.42.0.windows.2


