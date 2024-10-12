Return-Path: <linux-kernel+bounces-362079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBA99B09B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A991C21EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B613B280;
	Sat, 12 Oct 2024 04:01:03 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E8126C09
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705663; cv=none; b=I18ut88t5N0OqH9febO5BaYWKZPswfiVkOEUgcy0//KJAz7HcjR8wbwHv+eD7rOrwtJlWrTt8ICf9alYx1ml7kbnPn3WFAjMndc/ePJVslex1UZW1+tWX6TMDlW9umpJsL7VDGOULvjLtxYcELGlv2Prunbi1NceCeZsm1/o1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705663; c=relaxed/simple;
	bh=5Yqtd0zpcPEfI0UEVC8ExUgkB7Y7yInW28amVXFiDds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exETtuoybkuuHKidlRnAi3r/lvJJqqqXX5cTH9Wl1BmMhm1WXUoyw9Q4GFT3HDV+t4+xU8Dgbrkg6cv6H0bFfZustzxaTDNrCu9MkZYFr5tINkzlguxW76tYbzQElKcwhQOQnbo5wwIHKOWqABua28wG+we9VO6XbnVfOLbAqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz3t1728705590tix6yq9
X-QQ-Originating-IP: 7dovD3jhNT7oLVB7Pph9jMXcYEGF/4SIvx2PoU5BIfk=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 12 Oct 2024 11:59:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6310943489994141295
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 7/7] powerpc/entry: fix 32bit compile issue for common entry
Date: Sat, 12 Oct 2024 11:56:21 +0800
Message-ID: <837E79EAF5C5A04B+20241012035621.1245-9-luming.yu@shingroup.cn>
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
X-QQ-XMAILINFO: MO/I+lLomKsDqFHgzhl8CdB6J2fVDe+gm2ma9vRErAsYkMJnYqOvT4wj
	EFBxhV44Swsj9sIO/9Fh4mPA22/onMta5QMWWaT/rrpcOspj7dDHz3GFTOCLX0B4IJOItvk
	SacsQgxZc/RnQxHUAQzV/rDYvCdM7qaG1DSRIYgWR6LjZyXl1sGhreQQwnJvO/HZqVGoGLh
	1OxNlLaq4eyvmYuT5s5SeGfqXB9ZqBBm5T8qoI6UJaWchf2Og0fNrKNPc6O61EUrGtBmrc9
	cZzvk9Bde75Tke4uyZDvgrZR+L9hx/zAIil2QmQq6PHkmDFT8YgCH9SUSFjRUKt+iHOh55F
	a1/ROWlXZ/r1wFOe+EtDQWn86fesqFWAOthTaEk/UppApLqwMclNsdtOowYpVwMUaPkvpCT
	xWHmNRhHOiJpljY4oI5knvgB5PoxYfads3/sTPfYtpV0x6bdVs51YSRSax3+4QE8ckIGGeU
	nge1YsQYvn4igKW1lbeY9gtaWSfFxlL5he3LPZjWhzwMBPcqFqSnztzXJ9jKe0NS2RqZnpX
	U8/3RFI6DjGtvoKvrHrsdx/bBWeO688fi0CNnYf4JdqXEHiKm7QjglDXj/pobc9R1F1GsVx
	CG72bvmpqM1vXvzhLDDhchwmnrQ1Zl81ae/oclwrH0056L3Ik1Y3X6MHnyMsck1n3A38GIf
	gDhf4YQ+GJ0bT8E+xZeyBN3xZrQqfkiibCFX5EQUZP1Uvxg6psvZWvuH73hclStJ3XaH87g
	yJ17FiFRdRRiXOTJbGHHKYxgV9qfb53ZFv2X3txY+3kmFOZEQ+i1a6q/RtjpaC2wWf7zhJ5
	AjeaRghohpFjVZmB3J+GNsPMyk9ypP+nNn/UrFy5+4FI+EPUEM5MRBkn/faQ9Z1fNgnLNTe
	28jZn9h8ukF0J1vXCiyOJsI9Vf7+zUfgDunQipGuZFK7uC3SsiGWO/9At377yxDJJ8wQ1ZL
	SLY8lPFxQ2PgvN1PIpZxouN2Ky2bsoVUKFbE=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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


