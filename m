Return-Path: <linux-kernel+bounces-256127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D41934970
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991BC1F229B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86FE770FD;
	Thu, 18 Jul 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPQKVilW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD136B17
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289494; cv=none; b=gVX9BWtlofSW/o/3efqlX03w3HoU364EE/iimAYCHue0J7iHrTnp7xtznyXaPHl/NfGkJtIlY+WVRrnC1xFyxbS0Qupgdpy5UBumYByJfpzoOIHRzEX8EpQjAHrWZh5cZVUgos04Pcl7Ovg1RipNfZNvPOg8q3m0cuhAX6yBpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289494; c=relaxed/simple;
	bh=5Cr0TJvimg84EMVSwZmi3ZpTnXbIinN5xh5boa364W8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nSvVvrIrhjs3EZ7Sp5yoC5jhkEAIIVBzVDX4fAxSpGiAm0pPUPB4XLG3sbBsuYgIcPigrgfHz4HF3g06q+pT/t4WHZA8hkUAmurZnI/LFMuiY8nXQ1uLhZoet+FvYJMUeZp2noh6IdafuRcY++DTjfoLeUHD3GPC8hS64Dq07EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPQKVilW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705B7C116B1;
	Thu, 18 Jul 2024 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721289493;
	bh=5Cr0TJvimg84EMVSwZmi3ZpTnXbIinN5xh5boa364W8=;
	h=From:To:Cc:Subject:Date:From;
	b=cPQKVilWWtIzpovXuqpfr0IGoziiRoRgIwXm2j14m49y+rRmCamZj2kT62viT0QK/
	 jvBvM+0kbfY8KncCQZsDGjJsBsXNfYD7eSeB6dPQFUMbKSk2a9EP4qpa+kVLjfPVcq
	 VblTVkLubw6tvPwRWWOBdnluZ3zepxI4QsxVU7Cv2yfTm9im1kv55gX9VTE8Uo1+UQ
	 r3pPFnJyrXi7CX0BdEPOmCwwo/Jsq05xETsHZyEqDLnlDyAS8r0UJCOE2evZFhXlNi
	 oCGUiDhuVlIVOx4DFyZJHjkQL8beYOpzFC2YJgRiDof4xaPvlu+ga1JOZiQzH939Px
	 FpJhRBo78/Bqg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sUM1i-00DNHo-WE;
	Thu, 18 Jul 2024 08:58:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip/gic-v3-its: Correctly fish out the DID for platform MSI
Date: Thu, 18 Jul 2024 08:58:04 +0100
Message-Id: <20240718075804.2245733-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Similarly to what we do for PCI where msi-map/msi-mask are used
to compute the full RID (aka DID in ITS speak), we use msi-parent
as the discovery mechanism, since there is no way a device can
generally express its ID.

However, since we switched to a per-device MSI domain model,
the domain passed to its_pmsi_prepare() is the wrong one, and
points to the device's instead of the ITS'. Bad.

Use the parent domain instead, which is the ITS domain.

Fixes: 80b63cc1cc146 ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 2f3fc597331ba..e150365fbe892 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -134,7 +134,7 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	int ret;
 
 	if (dev->of_node)
-		ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
+		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
 	else
 		ret = iort_pmsi_get_dev_id(dev, &dev_id);
 	if (ret)
-- 
2.39.2


