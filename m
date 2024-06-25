Return-Path: <linux-kernel+bounces-228781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 128089166B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE731F2239B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9814D280;
	Tue, 25 Jun 2024 11:58:01 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C414B96D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316680; cv=none; b=sE1rAPK2FyYCdtuhrLzpQPGXl7BpTNELUoKLgePmpDfQXi+LA3CYkixI3ZDuXBR7geZTmXuZAyjA8HPHyYR5HLr7aUwWPJ0MgOm+60J+HbIhigAbwi2tgVEhPDK1k9Y/r+Y2ybNsz7pjhCk/Tdcppl+n6dCdjxWiItZY5G8wx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316680; c=relaxed/simple;
	bh=qefgQ2G5ufqpvQJb6grWZ8/56m9FStxqeu0exVtC6FY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XPxbPTSNthlXRcsFw7bBf8wLHXBJSUHZQcjsc9A3vNwIiDdCPZkIZD9MDbI+ZdV5qHLrGoIEse35L2GbSJV809MZuH8hzm9DEPHEHf97gMpyy+l9zOP4pJ0DbeJYLZkB2wBvkE5P/3qvtEkACHE5YBM1E08iCd4CCP4DtyZSHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:4e71:737f:f905:c457])
	by michel.telenet-ops.be with bizsmtp
	id fnxq2C0045EKelT06nxqGJ; Tue, 25 Jun 2024 13:57:50 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sM4ny-000Ln0-I8;
	Tue, 25 Jun 2024 13:57:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sM4o1-00AR1V-T1;
	Tue, 25 Jun 2024 13:57:49 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] reset: RESET_IMX8MP_AUDIOMIX should depend on ARCH_MXC
Date: Tue, 25 Jun 2024 13:57:48 +0200
Message-Id: <6d8116a56186fbf468229e823c7c8dfcd9488959.1719316665.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8MP AudioMix reset controller is only present on Freescale i.MX8
SoCs.  Hence add a dependency on ARCH_MXC, to prevent asking the user
about this driver when configuring a kernel without i.MX SoC support.

Fixes: fe125601d17cc1ea ("reset: imx8mp-audiomix: Add AudioMix Block Control reset driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index e59da17ea0b2d620..36cfdb81cd345f94 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -93,6 +93,7 @@ config RESET_IMX7
 
 config RESET_IMX8MP_AUDIOMIX
 	tristate "i.MX8MP AudioMix Reset Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select AUXILIARY_BUS
 	default CLK_IMX8MP
 	help
-- 
2.34.1


