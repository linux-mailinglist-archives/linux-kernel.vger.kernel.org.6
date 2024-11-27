Return-Path: <linux-kernel+bounces-423635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93AE9DAAB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2A1167988
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2794A1FF7D5;
	Wed, 27 Nov 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AiXDhR15"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05FB1FF7D0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720962; cv=none; b=PNscuFgoK3PBAMwGRLJZMIekO8PPJmjqAqD0yB4xL4l3RPdFxg57tHr56dzh1wRijWtv/KFqsJPCAINBOFTMXyNIL9zaRkw98wzHZXeBpLY35p4G0mWToC+jJx1LgzXhY+DEwcUciHIb8HY3ZB1vzZP/2/R+1OD+rIONf5y47Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720962; c=relaxed/simple;
	bh=JsYSS23pwy7GCttWRgJgj5vdkf5cH6fz9tVKGQnnE6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MQ/7PbK0xn2l5BJkxiB5RXbgLo7LLT/50kiK+ZPtk+n5L0Bgf+Wg35J3mQr+65sDUpm6g9PryICc+EyTI0R/4y0DQ37NPSKdZ1ml65a0JZBC8hmbHGDSek7fP+G8ofPTc2hKu/wnDpGXaX0hkCUiilVsubV0UNPoM0IpwggLmr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AiXDhR15; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732720960; x=1764256960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NvBWtev1slrWXhkVcMmhNUJ2tEXO/H0E7EXWBQ0mv08=;
  b=AiXDhR15zqi8EQySWNZl/3c4N9s+RFuR0x0S7+JqvP0EOmqsR2v7pwOO
   LgB1PnZq66UqcThcTDTud1zDbTAGuiDssLRv3VPu8gT3/q/MJgNW6FGEN
   FUdxxzcf14T/RgBvK1+Mc48NQRgXGge8PEk3wdMl1PrfG44RwghI6Jm9A
   c=;
X-IronPort-AV: E=Sophos;i="6.12,189,1728950400"; 
   d="scan'208";a="148444442"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 15:22:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:4762]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.101:2525] with esmtp (Farcaster)
 id 090d255a-bd4e-4b8c-9604-9659de410a04; Wed, 27 Nov 2024 15:22:38 +0000 (UTC)
X-Farcaster-Flow-ID: 090d255a-bd4e-4b8c-9604-9659de410a04
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 15:22:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 15:22:37 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 27 Nov 2024 15:22:37 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTP id C4BC640610;
	Wed, 27 Nov 2024 15:22:36 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 7AFF345B; Wed, 27 Nov 2024 15:22:36 +0000 (UTC)
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <maddy@linux.ibm.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <farbere@amazon.com>,
	<hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <takakura@valinux.co.jp>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH v2] arm64: kexec: Check if IRQ is already masked before masking
Date: Wed, 27 Nov 2024 15:22:36 +0000
Message-ID: <20241127152236.26122-1-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

During machine kexec, the function machine_kexec_mask_interrupts() is
responsible for disabling or masking all interrupts. While the
irq_disable hook ensures that an already-disabled IRQ is not disabled
again, the current implementation unconditionally invokes the irq_mask()
function for every interrupt descriptor, even when the interrupt is
already masked.

A specific issue was observed in the crash kernel flow after unbinding a
device (prior to kexec) that used a GPIO as an IRQ source. The warning
was triggered by the gpiochip_disable_irq() function, which attempted to
clear the FLAG_IRQ_IS_ENABLED flag when FLAG_USED_AS_IRQ was not set:

```
void gpiochip_disable_irq(struct gpio_chip *gc, unsigned int offset)
{
	struct gpio_desc *desc = gpiochip_get_desc(gc, offset);

	if (!IS_ERR(desc) &&
	    !WARN_ON(!test_bit(FLAG_USED_AS_IRQ, &desc->flags)))
		clear_bit(FLAG_IRQ_IS_ENABLED, &desc->flags);
}
```

The issue emerged after commit a8173820f441 ("gpio: gpiolib: Allow GPIO
IRQs to lazy disable"), which introduced lazy disablement for GPIO IRQs
by replacing disable/enable hooks with mask/unmask hooks in some cases.
While irq_disable guarded against redundant operations, the unguarded
irq_mask in machine_kexec_mask_interrupts() led to warnings when invoked
on already-masked IRQs.

When a GPIO-IRQ-using driver is unbound, the IRQ is released, invoking
__irq_disable() and irq_state_set_masked(). A subsequent call to
machine_kexec_mask_interrupts() reinvoked chip->irq_mask(), leading to a
call chain that included gpiochip_irq_mask() and gpiochip_disable_irq().
Because FLAG_USED_AS_IRQ was cleared earlier, a warning was printed.

This patch replaces the direct invocation of the irq_mask() and
irq_disable() hooks with simplified code that leverages the
irq_disable() kernel infrastructure. This higher-level function checks
the interrupt's state to prevent redundant operations. Additionally, the
IRQ_DISABLE_UNLAZY status flag is set to ensure that, for interrupt
chips lacking an irq_disable callback, the disable operation is handled
using the lazy approach.

As part of this change, the irq_disable() declaration was moved from
kernel/irq/internals.h to include/linux/irq.h to make it accessible
outside the kernel/irq/ directory, as the former can only be included
within that directory.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V1 -> V2:
- Implement an alternative solution by utilizing the kernel's
  irq_disable() infrastructure.
- Apply the fix to additional architectures, including ARM, PowerPC,
  and RISC-V.
---
 arch/arm/kernel/machine_kexec.c   | 7 ++-----
 arch/arm64/kernel/machine_kexec.c | 7 ++-----
 arch/powerpc/kexec/core.c         | 7 ++-----
 arch/riscv/kernel/machine_kexec.c | 7 ++-----
 include/linux/irq.h               | 2 ++
 kernel/irq/internals.h            | 1 -
 6 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 80ceb5bd2680..54d0bd1bd449 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -142,11 +142,8 @@ static void machine_kexec_mask_interrupts(void)
 		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
+		irq_set_status_flags(i, IRQ_DISABLE_UNLAZY);
+		irq_disable(desc);
 	}
 }
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 82e2203d86a3..9b48d952df3e 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -230,11 +230,8 @@ static void machine_kexec_mask_interrupts(void)
 		    chip->irq_eoi)
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
+		irq_set_status_flags(i, IRQ_DISABLE_UNLAZY);
+		irq_disable(desc);
 	}
 }
 
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index b8333a49ea5d..3489e50f5017 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -36,11 +36,8 @@ void machine_kexec_mask_interrupts(void) {
 		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
+		irq_set_status_flags(i, IRQ_DISABLE_UNLAZY);
+		irq_disable(desc);
 	}
 }
 
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 3c830a6f7ef4..a9df80e0602c 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -129,11 +129,8 @@ static void machine_kexec_mask_interrupts(void)
 		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
+		irq_set_status_flags(i, IRQ_DISABLE_UNLAZY);
+		irq_disable(desc);
 	}
 }
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index fa711f80957b..176a7f671409 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -600,6 +600,8 @@ enum {
 
 #define IRQ_DEFAULT_INIT_FLAGS	ARCH_IRQ_INIT_FLAGS
 
+extern void irq_disable(struct irq_desc *desc);
+
 struct irqaction;
 extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
 extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fe0272cd84a5..d9104d2b26b4 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -91,7 +91,6 @@ extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
-extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
 extern void mask_irq(struct irq_desc *desc);
-- 
2.40.1


