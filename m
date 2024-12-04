Return-Path: <linux-kernel+bounces-431378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD8D9E3C92
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1488163C70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7011FBEBF;
	Wed,  4 Dec 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iocfXi3I"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7571F8AC4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322013; cv=none; b=BxuM+DuTbvuPsAKF99DPfqP1lobIxekV6i3vXWhTotRUeTcci3zI7yxYyt9DrGjcVyVknixyQhCcnkcJsDv2K5QubCADyiqES3o9MnqpUdko97Xj2/id3eII0YmHi615s/s+qmi6NEbfDsDSQKYk0S9QB3miNapxyGUXajPTtag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322013; c=relaxed/simple;
	bh=PdzN3Dh/ibgi1YnB8NJstOK1zIHw2+a8hUG3YJsMoC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibUCCUGXBeKDK6Rdh9/uXkI9kzA6GiIKL1ID/WIpEotdouU3uu8P1+Mc6xN7IikI4adJqL7hidLXBrWwT1lf6TKV3yzja6UD9mDc57SxxTuChBu8MCnVFWRCE9n3H/kKpSffnIKp8SWSpEqATOJ76iNS2C+UhCnaZDo2RhhcBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iocfXi3I; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733322011; x=1764858011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5mJN0xDsc3RBo9kCI5VpP+8GDP08z7fNPcgv7+CVrqU=;
  b=iocfXi3ItbcYlxNY0+ZO5WmtcdJbS6pJFM1g04OBNBlXSiewrTMeI0SW
   s5NKtb+yq71m7Jzk4oS9mP8SRMZxuixHIwt/rUEltoMr+K1qM22hMmh67
   PsMI+MObNTefeXZSnHPBgV/OzERiSJfURHWqYplJ5rTu532h/7SYzcSTZ
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,207,1728950400"; 
   d="scan'208";a="252220900"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 14:20:05 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:35215]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.253:2525] with esmtp (Farcaster)
 id 4f701277-230b-4dbe-9bbd-a2fd4c729600; Wed, 4 Dec 2024 14:20:04 +0000 (UTC)
X-Farcaster-Flow-ID: 4f701277-230b-4dbe-9bbd-a2fd4c729600
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Dec 2024 14:20:04 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Dec 2024 14:20:04 +0000
Received: from email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 4 Dec 2024 14:20:04 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com (Postfix) with ESMTP id E07CC4056B;
	Wed,  4 Dec 2024 14:20:03 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id A058A7595; Wed,  4 Dec 2024 14:20:03 +0000 (UTC)
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <maddy@linux.ibm.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <farbere@amazon.com>,
	<hbathini@linux.ibm.com>, <sourabhjain@linux.ibm.com>,
	<adityag@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<takakura@valinux.co.jp>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH v6 2/2] kexec: Prevent redundant IRQ masking by checking state before shutdown
Date: Wed, 4 Dec 2024 14:20:03 +0000
Message-ID: <20241204142003.32859-3-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241204142003.32859-1-farbere@amazon.com>
References: <20241204142003.32859-1-farbere@amazon.com>
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

Replace calls to irq_mask() and irq_disable() hooks with a simplified call
to irq_shutdown(), and check if the interrupt is started (irqd_is_started)
before calling the shutdown.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V5 -> V6: No changes.

 kernel/irq/kexec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/kexec.c b/kernel/irq/kexec.c
index 0f9548c1708d..1a3deffe6b5b 100644
--- a/kernel/irq/kexec.c
+++ b/kernel/irq/kexec.c
@@ -17,7 +17,7 @@ void machine_kexec_mask_interrupts(void)
 		int check_eoi = 1;
 
 		chip = irq_desc_get_chip(desc);
-		if (!chip)
+		if (!chip || !irqd_is_started(&desc->irq_data))
 			continue;
 
 		if (IS_ENABLED(CONFIG_GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD)) {
@@ -31,10 +31,6 @@ void machine_kexec_mask_interrupts(void)
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


