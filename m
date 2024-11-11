Return-Path: <linux-kernel+bounces-403541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DF9C3701
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837AA2829B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA213AD20;
	Mon, 11 Nov 2024 03:23:41 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4ED1465BA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295421; cv=none; b=neYeu3WUEzGAfQ/4G7pBQHx9nnQDDn8/uoT7cBsb+dv/XnXyOQEFh+Q/l9LdEKqtCmZTBTGYcVvadQgm/OuyRG/KCeI4vLaCprSjq2fpjHfbiRfdJFuhI0BBb/aoGu/Vg2L8M+P9pAPMjoZbTvgFPWGguL/2B1VwKuZQLvcFr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295421; c=relaxed/simple;
	bh=5Yqtd0zpcPEfI0UEVC8ExUgkB7Y7yInW28amVXFiDds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWRgjWAC7DyBZFrbJM9evOz38JqD2ZZjqwEr1DMN65298ZSyOut3Pk4GVPqnfuwwsqIM6gM8+pe7c50HiwknfHOHckjCv8UQRLiFhzWe7gQnxqTJhF/BWnvXUlFggafYc+OWKxGskk+W97MgZKfD/fO2VyUAN4iDpkxk+IxkLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1731295371t6qpfl3
X-QQ-Originating-IP: hEaHh3itLNXjtnk8YnvUAaD7phrY2EbCwovJpNgObzk=
Received: from HX09040029.powercore.com.cn ( [116.233.136.127])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 11:22:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7169842749842943046
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH v2 7/8] powerpc/entry: fix 32bit compile issue for common entry
Date: Mon, 11 Nov 2024 11:19:38 +0800
Message-ID: <713F5D03CD2B8708+20241111031934.1579-14-luming.yu@shingroup.cn>
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
X-QQ-XMAILINFO: NWT6b+CD3I3QSY2wyTlQb0OaM02OWqrZCgE4/OKz3sXVaSuuC5kX3PsM
	Vl46hmNLEKGjGtk+BDwoxOA+YqB0JgFb2VC2aSgr2OtxRGUAFoImlm5ibehmiQaUIPy69ey
	G+LHUcb/8kirGrsjzJCTd9wo4Ks8Ha98l60ClAhYzFtqM19Poi7fGtWQVsrSIHqKpYWp4Fw
	p9H1PBVHYp10AtQ2ykxIDZKCBJFO1nv9Cqy63Pqh9Y9+pGcle+ybe757ilJJb2zJkAm/glD
	jVTsW6CnnBOSfeGsl6JZLeSZ12czXBH8g7oepQOYh5BMQERCuqAwHAAvFTBcUY4AXTsLS75
	aRRkEJLPty3I//KQblm/ooAKKPI73Hb6s994NpIDEMcJ1KYVmdsEecE7gDk6aPIcP9sYsmq
	LcJC8nDsHvuJn9sJNOyljthkbiz5q+0qxyC1+oDAkEKPasUYMXNaueGCOtW4k7MdIWvtEDS
	D9s21Jb8j2cKfoAZ6eXdbMsijg1+YZ37Sy8pMhPTe6oao+4xQ1H7FNfzNMvpRuwdtK8/pLe
	5TxlYcCiLMc8pXTCZ3lhwZ6pbTN2GcSngL4yueelRWoGwr0OlGWs5s3iSsP+hkLCAXGJy4+
	goh+7C2+PViYEkF67lQrw2Ar0zBgr1gHX9Fuh5LKhQXpr0WDVp9zGxRuaMfGERHAasIoGZj
	X62uliWiDJQWv4BJIA5zM/PKrMQfk9H99K0K24f1sohByi9a5IF5Mhiyr3SjSI8f3y/5fcj
	Yb7QOU484FGg9KV/G0AE2WM0Rl46jyM941K0ELYlPH3WlZK5LvRwyX84zZrAQTd71UvmCef
	OhALr/t63ULjKcE5gZ9meFJ9SrqNnKKAICW8PuNBZ+saSYEi6v33C+H4nt+A0DMSxZqQ7r8
	UivOjJrhsRangoSyz4Iyohmiy2/HqBS58wuuX7nfpTWYsm3GHqMSKg+WRpBxDAfPmFtMS8C
	b9BBpZY1+ES7RWKVtNCf162k97zxq/vnJM0XCiMPwyFpNUopDvNNpWAQq
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

fix irqentry in 32bit code path and hw_irq helpers.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/include/asm/hw_irq.h | 6 ++++++
 arch/powerpc/kernel/interrupt.c   | 4 ++++
 include/linux/entry-common.h      | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index a3d591784c95..99104f95e1d7 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -469,6 +469,12 @@ static inline bool arch_irqs_disabled(void)
 	return arch_irqs_disabled_flags(arch_local_save_flags());
 }
 
+/*for common entry*/
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
+{
+	return arch_irqs_disabled();
+}
+
 #define hard_irq_disable()		arch_local_irq_disable()
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 8e4cabb0c592..31167700f894 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -311,7 +311,9 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 	BUG_ON(regs_is_unrecoverable(regs));
 	BUG_ON(arch_irq_disabled_regs(regs));
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
+#ifdef CONFIG_PPC64
 	local_paca->irqentry_s = irqentry_enter(regs);
+#endif
 
 	/*
 	 * We don't need to restore AMR on the way back to userspace for KUAP.
@@ -424,7 +426,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	 * AMR value from the check above.
 	 */
 	kuap_kernel_restore(regs, kuap);
+#ifdef CONFIG_PPC64
 	irqentry_exit(regs, local_paca->irqentry_s);
+#endif
 
 	return ret;
 }
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 6521171469f2..b68eada65a8a 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -8,6 +8,7 @@
 #include <linux/seccomp.h>
 #include <linux/sched.h>
 
+#include <linux/irqentry-state.h>
 #include <asm/entry-common.h>
 
 /*
-- 
2.42.0.windows.2


