Return-Path: <linux-kernel+bounces-425041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876E19DBCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1CAB21DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2521C3F13;
	Thu, 28 Nov 2024 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kj3tTnG+"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096E1C1F37
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732824643; cv=none; b=U3GXTsNqDtQxLNkd9orHLb5Ae8L9M706ba6JV+NO1vhKVfUvvs4uJbJjlZDhgUkWxJ64VVV2CQj7AgvGBmbYexIPOH18OloD1+tFLyO96DzFwd9SRXYMFKz4Vkc9/ZZojTc+HLnWFfKkcC3OzzU4fi+sggTNFBu18NBYec4fzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732824643; c=relaxed/simple;
	bh=wd7sHuGqD71XU3EqKfVudmyiNj/L85zfthfw5eOF9hI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxOl7a9qH+LcFRNFW4q2+b07v63pCFVPlmI9FcpdJt7l988mbh0drPdZ8hqTtOhTM9mRqWkpeUuAsmNnMjFkc6nl34h99Ih8x4H3Sv4VA1/qOxHtc3dlMvZBMxZjlCnvGbxRrViykA8KsWh228mx2RjgRTiSJjoK7KAAXP7DMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kj3tTnG+; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732824641; x=1764360641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pAFdRwFKfNDF1JqGR+n1qcumP19pBTl1wsynLPrMwbI=;
  b=kj3tTnG+Boa2ahx9ob+204des1kHZtbiUMj6BT70e0SNpUCZkj/xsFWw
   1NDdxIXPVofNCYhn3GG7T33YILUEz8pFnxJjwZFwO3ijKyqTco6FTTUle
   iVcWfSGORj1whGpoLPUfXmTbNntKgw5JlFYqWKPf8npe4ir+2oTqjarXc
   8=;
X-IronPort-AV: E=Sophos;i="6.12,193,1728950400"; 
   d="scan'208";a="389147585"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 20:10:33 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:6662]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.206:2525] with esmtp (Farcaster)
 id 535754cd-d852-4ac9-99b0-bacfdd30cbc2; Thu, 28 Nov 2024 20:10:32 +0000 (UTC)
X-Farcaster-Flow-ID: 535754cd-d852-4ac9-99b0-bacfdd30cbc2
Received: from EX19D018EUC003.ant.amazon.com (10.252.51.231) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 20:10:29 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D018EUC003.ant.amazon.com (10.252.51.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 28 Nov 2024 20:10:28 +0000
Received: from email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com
 (10.124.125.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 28 Nov 2024 20:10:28 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com (Postfix) with ESMTP id ADDF8C01D2;
	Thu, 28 Nov 2024 20:10:27 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 46D0F78EA; Thu, 28 Nov 2024 20:10:27 +0000 (UTC)
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
Subject: [PATCH v3 2/2] kexec: Prevent redundant IRQ masking by checking state before shutdown
Date: Thu, 28 Nov 2024 20:10:27 +0000
Message-ID: <20241128201027.10396-3-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241128201027.10396-1-farbere@amazon.com>
References: <20241128201027.10396-1-farbere@amazon.com>
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
V2 -> V3:
 - Check if IRQ is started using irqd_is_started().
 - Use irq_shutdown() instead of irq_disable().

 include/linux/irq.h    | 3 +++
 kernel/irq/internals.h | 1 -
 kernel/kexec_core.c    | 8 ++------
 3 files changed, 5 insertions(+), 7 deletions(-)

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
index 6e1e420946e0..928b4387502b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1083,7 +1083,7 @@ void machine_kexec_mask_interrupts(void)
 		int check_eoi = 1;
 
 		chip = irq_desc_get_chip(desc);
-		if (!chip)
+		if (!chip || !irqd_is_started(&desc->irq_data))
 			continue;
 
 		if (IS_ENABLED(CONFIG_ARM64)) {
@@ -1097,10 +1097,6 @@ void machine_kexec_mask_interrupts(void)
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


