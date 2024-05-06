Return-Path: <linux-kernel+bounces-169289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C418BC65E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926962816B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921943AD2;
	Mon,  6 May 2024 04:02:50 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31CD3E462;
	Mon,  6 May 2024 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714968170; cv=none; b=CehsgO690zOLQlJ7rOSYN/9exAZqJj5bEZCtcv45z01Pyi/WqxIBp6rxRZHJS25bUPo8wJRG2SaIzAEGpFEx0IqgIGlAgR0kjdv6XeP/0tlG2jfPEgiFxJMw/WObJKw/UiMQov4qrBul41hBFLBVkyk/OBInIRWxfolsvbOT7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714968170; c=relaxed/simple;
	bh=dOeapYGM7AZZOgO213YqMoqH8Pzv33ynGuTJ7A00DUo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DmLIaB22SPaXHlUO9Q1G0Xyw+bx3IlWrghEZhc8ic5UfUxBkB/veV3IZEOONY4bd6awRLq108kEQtIyDdGCtUu/zlXly1JGOvioYVf+SnsFuja6z9OHP+ZN+oMaN63v8ziRTx/2AkhQjTO04L3rjxHwPz46MAUICxc4bUjywA5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C97271A08CA;
	Mon,  6 May 2024 05:53:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3CD8D1A02E4;
	Mon,  6 May 2024 05:53:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4E127181D0F9;
	Mon,  6 May 2024 11:53:57 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: imx: imx8mp: Add delay after power up
Date: Mon,  6 May 2024 11:35:02 +0800
Message-Id: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

According to comments in drivers/pmdomain/imx/gpcv2.c:

	/* request the ADB400 to power up */
	if (domain->bits.hskreq) {
		regmap_update_bits(domain->regmap, domain->regs->hsk,
				   domain->bits.hskreq, domain->bits.hskreq);

		/*
		 * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
		 *				  (reg_val & domain->bits.hskack), 0,
		 *				  USEC_PER_MSEC);
		 * Technically we need the commented code to wait handshake. But that needs
		 * the BLK-CTL module BUS clk-en bit being set.
		 *
		 * There is a separate BLK-CTL module and we will have such a driver for it,
		 * that driver will set the BUS clk-en bit and handshake will be triggered
		 * automatically there. Just add a delay and suppose the handshake finish
		 * after that.
		 */
	}

The BLK-CTL module needs to add delay to wait for a handshake request finished
before accessing registers, which is just after the enabling of the power domain.

Otherwise there is error:

[    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
[    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
[    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
[    2.181050] Workqueue: events_unbound deferred_probe_work_func
[    2.181064] Call trace:
[...]
[    2.181142]  arm64_serror_panic+0x6c/0x78
[    2.181149]  do_serror+0x3c/0x70
[    2.181157]  el1h_64_error_handler+0x30/0x48
[    2.181164]  el1h_64_error+0x64/0x68
[    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
[    2.181183]  __genpd_runtime_resume+0x30/0x80
[    2.181195]  genpd_runtime_resume+0x110/0x244
[    2.181205]  __rpm_callback+0x48/0x1d8
[    2.181213]  rpm_callback+0x68/0x74
[    2.181224]  rpm_resume+0x468/0x6c0
[    2.181234]  __pm_runtime_resume+0x50/0x94
[    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
[    2.181258]  __driver_probe_device+0x48/0x12c
[    2.181268]  driver_probe_device+0xd8/0x15c
[    2.181278]  __device_attach_driver+0xb8/0x134
[    2.181290]  bus_for_each_drv+0x84/0xe0
[    2.181302]  __device_attach+0x9c/0x188
[    2.181312]  device_initial_probe+0x14/0x20
[    2.181323]  bus_probe_device+0xac/0xb0
[    2.181334]  deferred_probe_work_func+0x88/0xc0
[    2.181344]  process_one_work+0x150/0x290
[    2.181357]  worker_thread+0x2f8/0x408
[    2.181370]  kthread+0x110/0x114
[    2.181381]  ret_from_fork+0x10/0x20
[    2.181391] SMP: stopping secondary CPUs

Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Revewied-by: Peng Fan <peng.fan@nxp.com>
---
changes in v2:
- reduce size of panic log in commit message

 drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b381d6f784c8..ae2c0f254225 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
@@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
 
 static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
 {
+	/*
+	 * According to the drivers/pmdomain/imx/gpcv2.c
+	 * need to wait for handshake request to propagate
+	 */
+	udelay(5);
+
 	clk_imx8mp_audiomix_save_restore(dev, false);
 
 	return 0;
-- 
2.34.1


