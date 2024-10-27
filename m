Return-Path: <linux-kernel+bounces-383552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D989B1D34
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176E01F2169C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445B513AA3F;
	Sun, 27 Oct 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZWwo/Us"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE328399
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730024545; cv=none; b=DpyFnCOZxI9u8rhp6kgV5XM7SWvVHBfHErzSJ+L7zQ7AR1XxfvDbxTIvegCL+KYUuVEoEDFLx7mCosLJFQH2mw3RDeYVEj4c46UQ5jAQ7yc6pFxQeZbQFi8Qv32E9x4PNenidJIizGyWdLMJa0CO2JvW5bNTu+2Pi3QRqss/VBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730024545; c=relaxed/simple;
	bh=0k3MEtE9BF8rhv6xudb8XxGPOormm9MhLswXlpEWSUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+DV8hWCFyndlteDzxUcI9lS8WNGdLmZQdb3MdSbZB2tJdbWkmYuCfs33kqW0JcRV0EbrYzuh9aSqnQE6dwI/oY4erWyyBQiIw5zwlKyGj6ChQG8tR2I7UIkf2XbRbVDPLEGIPDjOAo4F5c5dWiZhrD6oVAWvvCLuXF4vDFOgt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZWwo/Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46316C4CEC3;
	Sun, 27 Oct 2024 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730024545;
	bh=0k3MEtE9BF8rhv6xudb8XxGPOormm9MhLswXlpEWSUo=;
	h=From:To:Cc:Subject:Date:From;
	b=MZWwo/UsB+fGmGC8cUmGUFUAuYqzccLyCvXjDbUNtRQSVCiP5ot0TpxiU9pKo9III
	 bCeJutiffoylbY/x5N1tVK18HjblSsE18Fa+4aomsBf+sMK0aMBDEV4SyTSgGFrSeb
	 zwN5L4o1UADnSYHKHjRO6xWUOgPoEtRqK0TbHpayYoXngzeAFlue62PDJTXFDqgjiY
	 WbRMslifzOKyjgxtIOyRpWIttZmVJXfL9jD78TxCiPHnZHWU51hGDFgs5g1zk+0awc
	 H++UBvYzKPGWibPylvLFCChOxLOGEUH1kdodS5uwQSGmr6QpVPZuARaKQKtKtdgoHe
	 4NRS0AzPqJ2IQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1t50Pf-007I7d-3j;
	Sun, 27 Oct 2024 10:22:23 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v4: Correctly deal with set_affinity on lazily-mapped VPEs
Date: Sun, 27 Oct 2024 10:22:20 +0000
Message-Id: <20241027102220.1858558-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Zenghui points out that a recent change to the way set_affinity is
handled for VPEs has the potential to return an error if the VPE
hasn't been mapped yet (because the guest hasn't emited a MAPTI
command yet), affecting GICv4.0 implementations that rely on the
ITSList feature.

Fix this by making the set_affinity succeed in this case, and
return early, without trying to touch the HW.

Fixes: 1442ee0011983 ("irqchip/gic-v4: Don't allow a VMOVP on a dying VPE")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/aab45cd3-e5ca-58cf-e081-e32a17f5b4e7@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ab597e74ba08e..52f625e07658c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3810,8 +3810,18 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * Check if we're racing against a VPE being destroyed, for
 	 * which we don't want to allow a VMOVP.
 	 */
-	if (!atomic_read(&vpe->vmapp_count))
-		return -EINVAL;
+	if (!atomic_read(&vpe->vmapp_count)) {
+		if (gic_requires_eager_mapping())
+			return -EINVAL;
+
+		/*
+		 * If we lazily map the VPEs, this isn't an error and
+		 * we can exit cleanly.
+		 */
+		cpu = cpumask_first(mask_val);
+		irq_data_update_effective_affinity(d, cpumask_of(cpu));
+		return IRQ_SET_MASK_OK_DONE;
+	}
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
-- 
2.39.2


