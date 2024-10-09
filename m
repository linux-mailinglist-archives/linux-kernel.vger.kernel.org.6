Return-Path: <linux-kernel+bounces-356796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E39966CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6392D1C237B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F024C18DF9B;
	Wed,  9 Oct 2024 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/pSEdcW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE3188587
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468941; cv=none; b=ZHz/sGWNqWW1VrQV6isPRTbXF1D9caFIbGfXbX1G32j/Q5ZJuH8dgdUT9+zXhpwu5WOQv5FI0N8Lnd9FioBu92nFHBmXoR+XW7akF/u8IEJmj0Fci4+VpHjGUHLhmNXfne8XszbdBT3ZGCD0wBc4xom5aw3qnqEMy5tTbFwrpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468941; c=relaxed/simple;
	bh=V9wccIlaXsGR1f5Ly9FDVT2Mayt6sRpwuKEikkvs45I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPXuVPm+4sRsU0+7ELOJfc2hSIb30VRWjJy0fuly6E4uz91f903/qRpZPSp7J99w0ZpjHY/vTKJ97v8N6+O4AsupvK6706qtmFbQPaE4AAV+UJYs0NrYWt1uQKkhCajJyVJ1IE5cPy+B90YEhA7HCa2x9Zm6vNclEvhLvuizyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/pSEdcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFEFC4CEC5;
	Wed,  9 Oct 2024 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728468939;
	bh=V9wccIlaXsGR1f5Ly9FDVT2Mayt6sRpwuKEikkvs45I=;
	h=From:To:Cc:Subject:Date:From;
	b=c/pSEdcWVDGndbEH2hYtZ76ko8h212nGkIsywwXCMqvRQDlIErvvxmeqc+3Pdyqgf
	 ZPj0H85g9xKp03wbRzTt8986emYCgIgyaW9MPQFhy3ukvkeQagUUFqyWtXaii223be
	 4GXPPOakOoTpGmROfnUjQ5ZXwHDgRA+pb0kTHDEemw5flLdF1OJF94VXxrcf0yq2bL
	 nw/vhQgaCM+yF4WzIC+0ubiW2kkl0gQ8T9JBeLDty6nlhNTJQ/zB/ADG1eHkW5Ur2r
	 wCIUJfGNBYzYGtZ4+T1tdOba32URSsy/t0GTrqG0+ZVk8GAe/iCVAwD6MCvzRKqdBj
	 aJTvQKUoa66FQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] drivers: irqchip: Remove ARM_GIC_V3_ITS_PCI Kconfig leftover
Date: Wed,  9 Oct 2024 12:15:33 +0200
Message-ID: <20241009101533.189093-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GICv3 ITS PCI handling code moved to the MSI parent infrastructure in:

commit b5712bf89b4b ("irqchip/gic-v3-its: Provide MSI parent for
PCI/MSI[-X]")

the code move removed source files that were selected by the
the ARM_GIC_V3_ITS_PCI config option; it now sits unused.

Remove it.

Fixes: b5712bf89b4b ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9ca5a05..d82bcab233a1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -45,13 +45,6 @@ config ARM_GIC_V3_ITS
 	select IRQ_MSI_LIB
 	default ARM_GIC_V3
 
-config ARM_GIC_V3_ITS_PCI
-	bool
-	depends on ARM_GIC_V3_ITS
-	depends on PCI
-	depends on PCI_MSI
-	default ARM_GIC_V3_ITS
-
 config ARM_GIC_V3_ITS_FSL_MC
 	bool
 	depends on ARM_GIC_V3_ITS
-- 
2.47.0


