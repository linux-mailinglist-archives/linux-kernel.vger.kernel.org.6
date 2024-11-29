Return-Path: <linux-kernel+bounces-425498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB99DC2E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2ECEB22C73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495D3199FDC;
	Fri, 29 Nov 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PK0R5/eN"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158D14F135
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879891; cv=none; b=XMXo9Se1oZFpmYii6lhYGoUBwtWBwpJ93u8n4kgcbJvHNSF+r318eXm+H8alg/7sw/VEA/yMvDNUkYMNUXLDJsZEurFUUHkxzATzSB4RWlYX4RTBtshclxkVAXEIuTPwcyP7FZuBiKIvnNCcRrNejLk5rgqhRpQB0nW8oBr9SjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879891; c=relaxed/simple;
	bh=LH43IMs8+IzsYoH0K8Ng3fEXw/Dr3hltCEK8aPh+h2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiyWJkdVigRbsU4et44GdlW3WFhs3OQL9ukQAjW09eizXTQ08o4hqGuiZmit1lhHZUEmASSaggkdodTywJkc2DymnRzeE9NZ7HDVg2ZIVB6uA6fZDiLUOZlalImIIg+A8yP8VeL5aE4DYG2NpOh9APpbOLD1Mu7PpORmX6ZX4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PK0R5/eN; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732879890; x=1764415890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQrL1OtsTiXc9Hq9fX5cV3W/k3LNRCf3HtQc1MKst1Y=;
  b=PK0R5/eNqGw+14k0qq98PMjTrLI3Lqqf+7h1lDIO224r9I/meJqwCaiI
   SpTJApsP1913FlPrHvESjphciOXFFFnp3Q+fgYKhjaL8+C+lyFPs91GgL
   Isu7n6gslDYI8iRtHyoHlswZdfZnMd/uhJwC4SIIlfSPRasUIQcapktVi
   I=;
X-IronPort-AV: E=Sophos;i="6.12,195,1728950400"; 
   d="scan'208";a="389280919"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 11:31:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:57300]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.94:2525] with esmtp (Farcaster)
 id 5fa620f3-0a6b-40a3-89f9-515fdc3e0055; Fri, 29 Nov 2024 11:31:23 +0000 (UTC)
X-Farcaster-Flow-ID: 5fa620f3-0a6b-40a3-89f9-515fdc3e0055
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 11:31:21 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 11:31:20 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 29 Nov 2024 11:31:20 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTP id A53FE40382;
	Fri, 29 Nov 2024 11:31:19 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 3C7319E9D; Fri, 29 Nov 2024 11:31:19 +0000 (UTC)
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <maddy@linux.ibm.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<ebiederm@xmission.com>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<farbere@amazon.com>, <hbathini@linux.ibm.com>, <sourabhjain@linux.ibm.com>,
	<adityag@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<takakura@valinux.co.jp>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH v4 2/2] kexec: Prevent redundant IRQ masking by checking state before shutdown
Date: Fri, 29 Nov 2024 11:31:19 +0000
Message-ID: <20241129113119.26669-3-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241129113119.26669-1-farbere@amazon.com>
References: <20241129113119.26669-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

During machine kexec, the function machine_kexec_mask_interrupts() is
responsible for disabling or masking all interrupts. While the irq_disable
hook ensures that an already-disabled IRQ is not disabled again, the
current implementation unconditionally invokes the irq_mask() function for
every interrupt descriptor, even when the interrupt is already masked.

A specific issue was observed in the crash kernel flow after unbinding a
device (prior to kexec) that used a GPIO as an IRQ source. The warning was
triggered by the gpiochip_disable_irq() function, which attempted to clear
the FLAG_IRQ_IS_ENABLED flag when FLAG_USED_AS_IRQ was not set:

```
void gpiochip_disable_irq(struct gpio_chip *gc, unsigned int offset)
{
	struct gpio_desc *desc = gpiochip_get_desc(gc, offset);

	if (!IS_ERR(desc) &&
	    !WARN_ON(!test_bit(FLAG_USED_AS_IRQ, &desc->flags)))
		clear_bit(FLAG_IRQ_IS_ENABLED, &desc->flags);
}
```

This issue surfaced after commit a8173820f441 ("gpio: gpiolib: Allow GPIO
IRQs to lazy disable") introduced lazy disablement for GPIO IRQs. It
replaced disable/enable hooks with mask/unmask hooks. Unlike the disable
hook, the mask hook doesn't handle already-masked IRQs.

When a GPIO-IRQ driver is unbound, the IRQ is released, triggering
__irq_disable() and irq_state_set_masked(). A subsequent call to
machine_kexec_mask_interrupts() re-invokes chip->irq_mask(). This results
in a call chain, including gpiochip_irq_mask() and gpiochip_disable_irq().
Since FLAG_USED_AS_IRQ was cleared earlier, a warning occurs.

This patch addresses the issue by:
 - Replacing the calls to irq_mask() and irq_disable() hooks with a
   simplified call to irq_shutdown().
 - Checking if the interrupt is started (irqd_is_started) before calling
   the shutdown.

As part of this change, the irq_shutdown() declaration was moved from
kernel/irq/internals.h to include/linux/irq.h to make it accessible
outside the kernel/irq/ directory, as the former can only be included
within that directory.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3: Add missing <linux/irq.h> include.

 include/linux/irq.h    | 3 +++
 kernel/irq/internals.h | 1 -
 kernel/kexec_core.c    | 9 +++------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index fa711f80957b..48a3df728c47 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -694,6 +694,9 @@ extern int irq_chip_request_resources_parent(struct irq_data *data);
 extern void irq_chip_release_resources_parent(struct irq_data *data);
 #endif
 
+/* Shut down the interrupt */
+extern void irq_shutdown(struct irq_desc *desc);
+
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret);
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fe0272cd84a5..1f9287b1ccb7 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -88,7 +88,6 @@ extern int irq_activate(struct irq_desc *desc);
 extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
-extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 777191458544..09c8e9814cd2 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -41,6 +41,7 @@
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
 #include <linux/irqdesc.h>
+#include <linux/irq.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1084,7 +1085,7 @@ void machine_kexec_mask_interrupts(void)
 		int check_eoi = 1;
 
 		chip = irq_desc_get_chip(desc);
-		if (!chip)
+		if (!chip || !irqd_is_started(&desc->irq_data))
 			continue;
 
 		if (IS_ENABLED(CONFIG_ARM64)) {
@@ -1098,10 +1099,6 @@ void machine_kexec_mask_interrupts(void)
 		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
+		irq_shutdown(desc);
 	}
 }
-- 
2.40.1


