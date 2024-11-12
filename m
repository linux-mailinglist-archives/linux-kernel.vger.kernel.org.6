Return-Path: <linux-kernel+bounces-406192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7449C5BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D7A1F2266F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35727200CBB;
	Tue, 12 Nov 2024 15:32:04 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A4200CAE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425523; cv=none; b=ELm7+sqquOAuVDwqVntmqW8xNPnzj6unpqjQrGxOyt2WJnmeynk9GW++LDwA1z1Ck0+n6pY2XST8xJUYpvlTfMSCs4G56ngse9aRXm5qyZvnbPW1O+N4osOtn95F75QZYUmwsIjg7UAFPGOIppVwUTT3SdJmFoWJd77EGnETigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425523; c=relaxed/simple;
	bh=sUSTuIQIW789A2tb1aSl/UA/TlHAgRyRw7CCm63mBQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPL1sB/XTYiUy1c+xlnHMhhfZuzJ7cSPhG3fGK0N64+HmP+8AggxJCSXFJ46rLttU7qZul76AyvjzICrSYAvqfGnFFboYTqq3yZXoYJjeTlX569xkGXpS8ovWY7Ik1toSEipXqLaiqhVluh0gnmd49hpaF5y111CzMY9Jy1D61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:78de:3cf6:79c5:d375])
	by michel.telenet-ops.be with cmsmtp
	id brXt2D0074mJWgD06rXtvh; Tue, 12 Nov 2024 16:31:53 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tAsrb-006q6y-Tb;
	Tue, 12 Nov 2024 16:31:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tAsrx-001fBf-BE;
	Tue, 12 Nov 2024 16:31:53 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Inochi Amaoto <inochiama@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: THEAD_C901_ACLINT_SSWI should depend on ARCH_THEAD
Date: Tue, 12 Nov 2024 16:31:51 +0100
Message-Id: <1097d054ed4c67f714679de1253e45a034e647a0.1731425416.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T-HEAD ACLINT S-mode IPI Interrupt Controller is only present on
T-HEAD SoCs.  Hence add a dependency on ARCH_THEAD, to prevent asking
the user about this driver when configuring a kernel without T-HEAD SoC
support.

Fixes: 25caea955cc95050 ("irqchip: Add T-HEAD C900 ACLINT SSWI driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 28c19bde55206847..3f4cfcbecc5a4041 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -617,6 +617,7 @@ config THEAD_C900_ACLINT_SSWI
 	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
 	depends on RISCV
 	depends on SMP
+	depends on ARCH_THEAD || COMPILE_TEST
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_IPI_MUX
 	help
-- 
2.34.1


