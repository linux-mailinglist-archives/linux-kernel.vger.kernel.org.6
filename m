Return-Path: <linux-kernel+bounces-255608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100DD9342DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D11C214C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB6918410A;
	Wed, 17 Jul 2024 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvrBbTiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D6183067
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246393; cv=none; b=oIEYiJPQJriDq3a6QxepRRS2vuDODGqMKhyWrVL/09yMigfqsVZsILY+vsGt6C7uUJUjCzgfCA0gkcLUngDAFBYfPdKxxIMnmbGSvtnGrri2pBFv28g0W0OxFxAtD/31+rDn9yrULS7OfIjSHIm17nDriOQEZ7N2cN8EreRUI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246393; c=relaxed/simple;
	bh=Xa8iIRp/QrL+NXF/NWxhMBa9cqpleNTcaQVEvxD2GyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LuC647ghtxcQlHxdPs26qDwqO/gqShYZVOkh/vgAbsCwJNcH8T545dnEYB9GQMx2ZwCZCIWoiOB6+HTzDVaCW3iMuK+ndplaaVS8r8xfzoMA+9oMUvMKtNwfZPKyXwxWOrUB4LkM306NGi9gG+fH2dGfP+2S+5nzFcb6KbLtid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvrBbTiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570A1C2BD10;
	Wed, 17 Jul 2024 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721246393;
	bh=Xa8iIRp/QrL+NXF/NWxhMBa9cqpleNTcaQVEvxD2GyA=;
	h=From:To:Cc:Subject:Date:From;
	b=YvrBbTiP1ouucMeyf0JXSOhKE31RMt7HFWj9EVD79VwSP3FQcsah6A3telphThdUV
	 HlF5tYHzmWGRCGcjn87HYNRu4Lzkx1Zi33h0QjhSAKs1+NZuFd5pHBOSSZ6Nh6uBwf
	 bgS7OprjUWNY+ikBvI65OeEqlMSIUfRV9MhLt4SHf+hUFVpV/dQ6Pkeu4KreoJ7fs2
	 LCc5BFMbgxr43TZLmvp3LIoJoTicCKD/ESAu2NQDkZSRhnYrRab4OEyzhu2u3K6aoT
	 sz5YCDRN32BOnjk8tOL9MvcHgSuWNqsdRy2sTo8QtInolBinpC5g7aJ/PidYOE5w1k
	 FdFTsT/fW3wiQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sUAoY-00DFCv-Gv;
	Wed, 17 Jul 2024 20:59:50 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Johan Hovold <johan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip/gic-v3-its: Correctly honor the RID remapping
Date: Wed, 17 Jul 2024 20:59:37 +0100
Message-Id: <20240717195937.2240400-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, johan@kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Since 6adb35ff43a16 ("irqchip/gic-v3-its: Provide MSI parent for
PCI/MSI[-X]"), the primary domain a PCI device allocates its interrupts
from is the one that is directly attached to the device itself.

By virtue of being a PCI device, it has no OF node.

This domain is (through more layer than it is worth describing)
passed to its_pci_msi_prepare(), which tries to compute the
full RID that is presented to the ITS by the device. This is ultimately
done by calling pci_msi_domain_get_msi_rid(), passing both the
domain and the PCI device as arguments.

The baked-in assumption is that either the domain that is passed
to pci_msi_domain_get_msi_rid() describes an interrupt controller
with either an OF node or an entry in an ACPI IORT table.
In our case, it is *neither*. This domain is does not represent
anything firmware-based, but just an allocation unit for the device.

As a result, we fail to provide the full RID (which requires inspecting
the msi-map/msi-mask properties in the DT), and stick to the BDF,
which isn't very useful.

Tragedy follows with a litany of devices that randomly die as
they fail to see any MSI (because the RID is wrong) or fail to
get an allocation (because they try to steal LPIs from their
neighbour's pool).

This will happen on any system where a single ITS is shared by
multiple root ports and end-points with overlapping BDF numbers,
and has the topology described in the device-tree.  Simpler DT
topologies will luckily work, and so will ACPI-based systems.

Solve it by pointing pci_msi_domain_get_msi_rid() at the *parent*
domain, which is the ITS, resulting in a correct mapping and a
restored happiness in my personal zoo.

Fixes: 6adb35ff43a16 ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 780e1bc9df549..2f3fc597331ba 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -65,7 +65,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	}
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
+	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);
 
 	/*
 	 * @domain->msi_domain_info->hwsize contains the size of the
-- 
2.39.2


