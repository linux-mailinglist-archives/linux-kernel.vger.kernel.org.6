Return-Path: <linux-kernel+bounces-566279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A1FA675C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1A47A8DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC56920DD6D;
	Tue, 18 Mar 2025 14:01:08 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B720CCF2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306468; cv=none; b=SNFCekmGNVYITJGCZ2Rxn8QsDzp/datdKkvFzDQ5512CClaMAjc8UcCjr9u0SQIkNG2h/FqzPyG4c+5XtJYR8k0irEeJHkwbrKDOmjwmuwRRPZc/5Pn+rGvFJE/1z0H6FdFFaf2ktWZiN4GsOVUyKRwlaCSuLjGYYfJJ6x+LJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306468; c=relaxed/simple;
	bh=+rO3h7RmTZrCkQ0UAf9gVNtQeiNBm56cpLZJi7tBF+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7PnjjSCmQvefOWfUwgrtrpBc7TVWCjcIkkZDfZHreZCdCzhsD/u5Ro3J+vXx+6SnSpXdquaT3pqW+qhgXzJw+QJQPseAzZ16zDMGsDTo9f058xk25WGgkL+xKS9rkKYf4bVeIBpC3dexBLsXQB6Ti84eAkkqJB5eoGqMxlzrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2568:e3d1:1e11:17f3])
	by andre.telenet-ops.be with cmsmtp
	id SE0w2E0041Mz0fJ01E0wiC; Tue, 18 Mar 2025 15:00:58 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tuXUb-0000000EecT-0QtP;
	Tue, 18 Mar 2025 15:00:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tuXV2-0000000AM1k-0BAE;
	Tue, 18 Mar 2025 15:00:56 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: dwc: PCIE_AMD_MDB should depend on ARM64
Date: Tue, 18 Mar 2025 15:00:54 +0100
Message-ID: <eaef1dea7edcf146aa377d5e5c5c85a76ff56bae.1742306383.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMD MDB Versal2 PCIe controller is only present on AMD Versal2
ARM64-based SoCs.  Hence add a dependency on ARM64, to prevent asking
the user about this driver when configuring a kernel for a different
architecture than ARM64.

Fixes: e229f853f5b277a5 ("PCI: amd-mdb: Add AMD MDB Root Port driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be replaced by ARCH_VERSAL, if/when it ever appears for real.
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 39b1a89cb6b7ee80..48f1e3c7825b55e0 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -39,6 +39,7 @@ config PCIE_AL
 
 config PCIE_AMD_MDB
 	bool "AMD MDB Versal2 PCIe controller"
+	depends on ARM64 || COMPILE_TEST
 	depends on OF || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
-- 
2.43.0


