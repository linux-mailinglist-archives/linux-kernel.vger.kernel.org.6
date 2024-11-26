Return-Path: <linux-kernel+bounces-421871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB089D913E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1426B16596F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF538DD6;
	Tue, 26 Nov 2024 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZDzWao3D"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25A7E782
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732597516; cv=none; b=kYHJ2TeTREQcRO/TtT9Nu0Xfzwghbc9unIWpM3dAUMLsSIld+ESg6MrZ+zDuqWxgonf5qEkAhHD3xbkgpRUq/q13k/XjuOvxfZhchziwXx9NhHmj3F30oVdLRpktZGOW5rklthpFmseufEUZADo0/mH6OfPKlZho8hZILuV7hWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732597516; c=relaxed/simple;
	bh=IiSFc0R4Xh5pU/gNwoujyHnOvgCuFatGOwBvHmELiY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Svh2EErbrYr8EzjpaaqOjNZEOq1oe/Fj/tovJh1du7fsfs3E30BM88hb5Tg1ieeQlLADYG0ABP4ky5c3QE30go8O9PCeFEfUojEVPtmPSicg2YEvfqfuVVjYWJBsuWOzr4bYw6U+SyQgLccIQrHpknoZ3Hs2pPEiNu7yn4YYabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZDzWao3D; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732597514; x=1764133514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c7R+vWL53xvofYvfpDqK5DRpBmVSfvfqf+hQEMqLgFI=;
  b=ZDzWao3DxeARiNMrGBhtoV9efHBqM/xR1bxET4BxFwLBpozOP+8HjuMW
   GZuK0gnE1MqK6VZ1OwFwKPyuWJze7HoYNMNQqbo7nEmECq8BSRoX3QdER
   xs/KKNBt593J+IH+xobZFbSbpqrq2L2qbH1X4Lqe73rTq4llhbWgN2xZs
   0=;
X-IronPort-AV: E=Sophos;i="6.12,184,1728950400"; 
   d="scan'208";a="451326400"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:05:11 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:19913]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.13:2525] with esmtp (Farcaster)
 id 6618a5e3-144f-4fe0-b3c3-0bb52f1575eb; Tue, 26 Nov 2024 05:05:10 +0000 (UTC)
X-Farcaster-Flow-ID: 6618a5e3-144f-4fe0-b3c3-0bb52f1575eb
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 26 Nov 2024 05:05:10 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 26 Nov 2024 05:05:10 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 26 Nov 2024 05:05:10 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id 8C296A00CB;
	Tue, 26 Nov 2024 05:05:09 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 221E53412; Tue, 26 Nov 2024 05:05:09 +0000 (UTC)
From: Eliav Farber <farbere@amazon.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <farbere@amazon.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH] arm64: kexec: Check if IRQ is already masked before masking
Date: Tue, 26 Nov 2024 05:05:09 +0000
Message-ID: <20241126050509.4426-1-farbere@amazon.com>
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
responsible for masking all interrupts. However, the current
implementation unconditionally calls the irq_mask() function for each
interrupt descriptor, even if the interrupt is already masked.

This commit adds a check to verify if the interrupt is not already
masked before calling the irq_mask() function. This change avoids
redundant masking operations and potential issues that might arise from
attempting to mask an already masked interrupt.

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

This issue began after commit a8173820f441 ("gpio: gpiolib: Allow GPIO
IRQs to lazy disable"), which replaced IRQ disable/enable hooks with
mask/unmask hooks in some cases. The irq_disable hook was protected
against disabling an already disabled IRQ, but the irq_mask hook in
machine_kexec_mask_interrupts() was not.

When a driver that uses a GPIO-irq is unbound, the corresponding IRQ is
released, invoking __irq_disable() and irq_state_set_masked().
Subsequently, machine_kexec_mask_interrupts() attempts to call the
chip->irq_mask() function again. This invokes gpiochip_irq_mask() and
gpiochip_disable_irq(), and since FLAG_USED_AS_IRQ has already been
cleared, this results in a warning being printed.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 arch/arm64/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 82e2203d86a3..6f56ec676844 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -230,7 +230,7 @@ static void machine_kexec_mask_interrupts(void)
 		    chip->irq_eoi)
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
+		if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
 			chip->irq_mask(&desc->irq_data);
 
 		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-- 
2.40.1


