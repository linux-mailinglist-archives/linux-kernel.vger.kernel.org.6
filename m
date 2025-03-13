Return-Path: <linux-kernel+bounces-559903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10E5A5FADE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A71172266
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7748272928;
	Thu, 13 Mar 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zx8Dqiqc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWv9qeBV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB727128E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881664; cv=none; b=DcvpxnpRXQWt4Gm0OVjV2vpeCO0l+THm7Qx3Df8rbn/fhi891RCD4nhCH2U1Q1QE1elh0U8URpBWlpBEN1B4l9vOePuPqBzU8wM8QiN+DPdD9iJRtwrEsUC2cQZgUr5Y7E5V/p6VyTYsoOcyst52TcVySeEM4GxBBKqREpaTRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881664; c=relaxed/simple;
	bh=q158st3AWDgD/QhYClYB6SP10BGBl5wM2Bb+FoyFB2M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=etYxjbi5bR/cF2QniaIXIVNdOzEKWiNxQFt8t88eOIppvoliXPDLdCE2ibSVkJn5+0Inf/pGRg8t87pbh5e9Jnd/B5QvyJSHkHqpNBkr2t7GjMjw4bnY5TKLYFKCy26CwMSigvRpwz5YDjjK7cRwAdOSCbQRuftZwmuwH/3FTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zx8Dqiqc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWv9qeBV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.925818202@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KBXZnQRPuFL7uTOxRhZqNx5wL5xMvufibFWX03o4FLk=;
	b=zx8DqiqcioO1e+18H7tT+/zTCbVC+MS63q1K8aXl8EZLYTYZvPAQC7TvRV1aO/dPm3lhmT
	KwXnxwAgQZ/VzcUvlfgBh2eguSG3/7T8tUnXZ8oG8zLo8G8L9DMltSe4TOsArCmnF9MYUC
	8SXENnJcv4/DT6aXLacwY0M7Df5H5rlw/EXJ/Wpcfy386lV4onIRumub76ZV8IWiNbtGwL
	GnSX1NF2XZvvd6EzfzWhRJpQRIHpKMOCvmMI7q01DdO9jjCKwb6gIAIu3D62FasH096woy
	H1H+bR5/lhKrcvL7nvjt9pGCtD2KkQvzXjsjL/PEb2Ne43xI43LlhEMvf9Gp1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KBXZnQRPuFL7uTOxRhZqNx5wL5xMvufibFWX03o4FLk=;
	b=VWv9qeBV7+ZQWqfKjeviaIgDGw+RTJzyKJssbrOKVcb2Rifg9vMWjo87uratpZrL5/w3E/
	DLNZtKVgXpAMV9Bg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 45/46] genirq/manage: Rework irq_set_irqchip_state()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:01:00 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   53 +++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2703,39 +2703,26 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state)
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool val)
 {
-	struct irq_desc *desc;
-	struct irq_data *data;
-	struct irq_chip *chip;
-	unsigned long flags;
-	int err = -EINVAL;
-
-	desc = irq_get_desc_buslock(irq, &flags, 0);
-	if (!desc)
-		return err;
-
-	data = irq_desc_get_irq_data(desc);
-
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (WARN_ON_ONCE(!chip)) {
-			err = -ENODEV;
-			goto out_unlock;
-		}
-		if (chip->irq_set_irqchip_state)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
-
-	if (data)
-		err = chip->irq_set_irqchip_state(data, which, val);
-
-out_unlock:
-	irq_put_desc_busunlock(desc, flags);
-	return err;
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
+		struct irq_chip *chip;
+
+		do {
+			chip = irq_data_get_irq_chip(data);
+
+			if (WARN_ON_ONCE(!chip))
+				return -ENODEV;
+
+			if (chip->irq_set_irqchip_state)
+				break;
+
+			data = irqd_get_parent_data(data);
+		} while (data);
+
+		if (data)
+			return chip->irq_set_irqchip_state(data, which, val);
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_irqchip_state);
 


