Return-Path: <linux-kernel+bounces-403540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A879D9C3700
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31AE1C217A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741602595;
	Mon, 11 Nov 2024 03:23:29 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEB4B5C1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295408; cv=none; b=K95WWpnFUBA7X4bLnNUArifLEOY0uaaJC9BgKBm1dslmSJi+jqyxODvaztM1oZc1dlD4nk3dlyIsmJTdedjLzdiFs7lSPyEDfXrsDD0c8WTeoqud37P7lWambKsWKnCRtuX2bupqvvXUgjregLOePcTbnSpo8o4dju6G+F9KdQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295408; c=relaxed/simple;
	bh=CNualBh+6zKfNfBry8KERKoILgyCwRF37DMX+DsK9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLRQfeRDMEgeB4SUBiO10ara/iAwTDKp94L4ZBQ6PmnbFiVTc0d6OUEDe9rhpr5++ZDtL/DJilnQkGTCkw3Ad7M6r+G1iCvleiP+SqUc632io+4T0yhnnuKEWXdFz5m+7FmC6MK1s0XsKc6Jl2YBkZ9woMc+LbWmC9speBfN2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1731295351t6qawef
X-QQ-Originating-IP: 3DvTUMiag3n5W03IhhOMXVwyOWZkvAivUkk4gy4lMXg=
Received: from HX09040029.powercore.com.cn ( [116.233.136.127])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 11:22:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3514402937707262060
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH v2 6/8] powerpc/entry: factout irqentry-state
Date: Mon, 11 Nov 2024 11:19:36 +0800
Message-ID: <972B4AF8B9EDF3C0+20241111031934.1579-12-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20241111031934.1579-2-luming.yu@shingroup.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NXhskp4g2j/OblqjPJjJGDyCXF/YKwAQdEYX4RUBOiaImmqeuNQH4hk1
	iRJbj3lzLgaJ0AoOx35LttiRGxATkvXU+MV1INxzo0K7KvJ4pKlzZoiUKy7JoAmO3juEuZP
	WtJK4woeoQVw38rbIvGUWy754jy+rF15gg0/E6zfZfF7er5Eeo0rcNxxX90dRvvqJe4RA0F
	pIvqNaiSx7cV2khI67bCj7HS5mK0ye+1YXdPk17jk7wTj9q2LKkP+H1jgDFMX2UvJNroctW
	+RRyABdCoMGbYqCsx1/f2zYD1zbhyaCCdo76yBb3lRQXKupa2ZmDGv8hQU01n3KW01LxSjm
	Sb3fby9UwHUZb6yNRdRuZ5K6t4kcCMXem356Hz8v8Ez9GA02oYyUy1Wz/FTJ5vg+H5U+DSO
	LWGtMQRAcwxwbLB15Z7okouAl3oxWZiBDOZMU8WMCHbbrxg1C+a4BcussEsSzf4KiqLyYvj
	h9cXk1NfRtC1xanYDI+adUUYbGen5ETbVxtQD7E52n6780fB2zHJkhRHwfVbbeEb3an40q/
	He2YCEbt2oNNdFiUGZYfvYTI4rIzc8ny0zmncfQKz33OJOEznldQrbKsIxhN3z+fVYYJ2o/
	N03yozVAfkU04Z/UrfXvNl9n+QxXZ9BnhQm13+iQoLrPIvxXNwqtAKkKSBBduxmFPC94FMn
	63zeQUyS1GjHJF5iQYgXL/Ysfidp4135dhWPVaJiP5IfWFq3K5eIxLXfUNx/Juj8flltgHr
	bVaQd7WY3nfm8FyqF2rhXLRvV9jlR+uZ2YmTYg88DIU+vt+Lvzx3G0aShDN7DNBBsowiGg7
	5VaKTSb7056R6qighozoEH0Ih+lec9e6QX4rh//lnWWs8pVvMnIQkoederirKTUnkixGwO+
	nuK/tdTb1mVGnVOYqJ+2M9kchy+uJKkioz3SXJ4Ijxae/oFstY4Tav+WvWv1jUm4f9yHuVh
	Qyn4TFT8Uw5Jgh1k3FoTYVosmfZLNoemrnzRuBfODXzN19O6j/msOM4insotqTrlpIV2zlF
	9MlylhPX3rn5mveoCA
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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


