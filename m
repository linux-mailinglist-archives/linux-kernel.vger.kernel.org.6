Return-Path: <linux-kernel+bounces-559883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD2A5FAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3C217CD22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7A26F46D;
	Thu, 13 Mar 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sz6QxyFY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRQqvmSa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13E26F453
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881631; cv=none; b=ukpC6Q0i/qGb109kGXthVYtjproTNj/ViPKZ74a8mTySoWED1uXG3o3NQBGbxFhkOKLDyRcSHCpnj79JLFN7Zgyo3j/oheChW43Xaj3u884xGDYb90vYXch7Ula/gvLIg+wPHgfaUOCMIHuph9tcepptgy9IaLLnTNGBAAgSmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881631; c=relaxed/simple;
	bh=dASglU6e2axvZ+0kMhEfTbhou/R1GYih/vYta8iaaHI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iTw2zm7MMBnlXGXz+qwH5ihcfuf4ZQs3fMQOfvCAZ4aRMOET4mnVCv2k7iU8GCYY7QB/x+yxxRYC+ZDXXuabJlrQ4XOd0pN3+8zn7ZkjRxzfBM+KOsp86+mHW1TAG9GcoWbuSVX2Hw/qCETPrQxOGtKJNPA1/+doedvPlh+KZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sz6QxyFY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VRQqvmSa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.660408159@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GyK0EH593FcjVwcKJ9EWWXsONVn3zLtDfRm+tTScKdE=;
	b=Sz6QxyFYdzf9mql5W+nvqH1Jh7Oi02aZnwYWv3rJXaSf5RrCvZv7eLTPoyRfkliNjjvv2y
	8MJgHMnX7cgSP+ORmanMIKBHFwFQf3EHT9qNC/9J/Jqi7Co0KjBtypkzJS0+5irJ6fWx9u
	kIHXZvy3Pycqi+O5/ESrvLRLXpK33ClpkvOuI/eGBNm0KuvanM5YjljmLMCz7LKgv7gIIb
	/jwFNU1XqvmozVaeeH1GTIGHCW1fOXJjUP12Rg6UCx7Mfv/KyVq+81nLgeRbW7hiN5cBeb
	asBFB0HxpwzgSk6cOHgHAL3vNmwGZGspw9S4g8EPtYYMFxM5Pp699iltxR61zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GyK0EH593FcjVwcKJ9EWWXsONVn3zLtDfRm+tTScKdE=;
	b=VRQqvmSaa4tbMqCJhYfIFkJnFF2/ZY22NVu+JKz3gMeV5G4gSwT/BG4hLaEN3E9SpK87CA
	zlU2dw03PB8kqxDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 26/46] genirq/chip: Rework irq_set_chip_data()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:27 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -115,22 +115,19 @@ int irq_set_msi_desc(unsigned int irq, s
 }
 
 /**
- *	irq_set_chip_data - set irq chip data for an irq
- *	@irq:	Interrupt number
- *	@data:	Pointer to chip specific data
+ * irq_set_chip_data - set irq chip data for an irq
+ * @irq:	Interrupt number
+ * @data:	Pointer to chip specific data
  *
- *	Set the hardware irq chip data for an irq
+ * Set the hardware irq chip data for an irq
  */
 int irq_set_chip_data(unsigned int irq, void *data)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-
-	if (!desc)
-		return -EINVAL;
-	desc->irq_data.chip_data = data;
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		scoped_irqdesc->irq_data.chip_data = data;
+		return 0;
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL(irq_set_chip_data);
 


