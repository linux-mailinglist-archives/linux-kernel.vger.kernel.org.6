Return-Path: <linux-kernel+bounces-199475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F68D878D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E22B1C21D67
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2E1369A0;
	Mon,  3 Jun 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B73hhSQm"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31C262B6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434080; cv=none; b=OnlGfqxyiDjvlYc/BsF7fH7P+XaQs1I1o98qvYr4p5UloZsaXopPiqA01ou0xVGG/pRk+5gdugjFWCVa4xVPDwePndhjCiOlT8/IM9PcnOHpx9IZ0VfZjeOn8llwfE/v6Wyvr+Olg2DPQAq9FyhaP3I30fo10SmXURfe/mj+6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434080; c=relaxed/simple;
	bh=XRm7qfVoKNCKJc8gWfdzMNwjpxqHgSu1zVUhoH1YdX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8neTBHinBk2WUDc5RdO4f7kWSEF+u55HwqHmCav9x33wAfFT+HVvUuKCW2qqc8vADJueXqgG0nkk8gWMkKPgDA/mnojXkVTxwBGK3563vyPMypCBylMQyzQvk9As//Q0iT6ngX1ZK2v1/aFcCOabbjgzoAr0MlJeYapcLVoqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B73hhSQm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E9141C0004;
	Mon,  3 Jun 2024 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717434076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jmDCtjl47QuoVAqZojA/Ey2uy0oviYRp59KU+NyG2KI=;
	b=B73hhSQmhFwbOtJ/WMQ33Geu0egPkOPK1sZbEU7f4UzzOhrIwlLMNmyUNkfITVbUxLePcV
	wajF1xNkPvZTQhWLzLOEtg15/PqHz2qAlkGdk//tz2Y2QU5JKlAAf/oCKmQOc1Y1rK2B4K
	JQodDFj5b77H8H8fM8inZL6HTkNL9gUCFxFa+BultBdtnobUdCi8kkeHC4tCvjjxs0BLUl
	vdl1Ofig4xBinQi+6twUMZvxrl6IvJhPcJZng5JvDLvvlkB2Qv8J2oVHtW7Kgf+CJTL7wN
	pEj9E1fBEdX5LceJ1BOo293SyA0F1ajl4u5qnGH3nYP5+tL9SWQ0SJBthVcB6w==
From: Thomas Richard <thomas.richard@bootlin.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: m.nirmaladevi@ltts.com,
	bhargav.r@ltts.com,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com,
	thomas.petazzoni@bootlin.com,
	u-kumar1@ti.com,
	Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH] regulator: tps6594-regulator: Fix the number of irqs for TPS65224 and TPS6594
Date: Mon,  3 Jun 2024 19:01:00 +0200
Message-Id: <20240603170100.2394402-1-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

The number of irqs is computed to allocate the right amount of memory for
the irq data. An array of struct tps6594_regulator_irq_data is allocated
one time for all the irqs. Each irq uses one cell of the array.

If the computed number of irqs is not correct, not allocated memory could
be used.

Fix the	values used in the calculation for TPS6594 and TPS65224.

Fixes: 00c826525fba (regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators)
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---

Issue detected with Linux v6.10-rc1 and v6.10-rc2 using a TI J7200 EVM board
during the suspend sequence.

#echo 1 > /sys/power/pm_debug_messages
#echo 1 > /sys/power/pm_print_times
#echo 0 > /sys/module/printk/parameters/console_suspend
#echo 8 > /proc/sys/kernel/printk
#echo deep > /sys/power/mem_sleep
#echo mem > /sys/power/state
[   12.607734] PM: suspend entry (deep)
[   12.612619] Filesystems sync: 0.000 seconds
[   12.618349] Unable to handle kernel paging request at virtual address 000000366b63756a
[   12.626255] Mem abort info:
[   12.629037]   ESR = 0x0000000096000004
[   12.632772]   EC = 0x25: DABT (current EL), IL = 32 bits
[   12.638070]   SET = 0, FnV = 0
[   12.641111]   EA = 0, S1PTW = 0
[   12.644240]   FSC = 0x04: level 0 translation fault
[   12.649103] Data abort info:
[   12.651971]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   12.657441]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   12.662477]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   12.667774] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008844be000
[   12.674198] [000000366b63756a] pgd=0000000000000000, p4d=0000000000000000
[   12.680974] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   12.687225] Modules linked in:
[   12.690271] CPU: 1 PID: 135 Comm: sh Not tainted 6.10.0-rc2-00036-g8de0c9c7e923-dirty #46
[   12.698430] Hardware name: Texas Instruments J7200 EVM (DT)
[   12.703987] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   12.710932] pc : devres_for_each_res+0x64/0xf0
[   12.715370] lr : devres_for_each_res+0x4c/0xf0
[   12.719800] sp : ffff8000840d3a80
[   12.723102] x29: ffff8000840d3a80 x28: ffff800081aeef50 x27: ffff00080038d2bc
[   12.730224] x26: 000000366b637562 x25: ffff80008358a978 x24: ffff8000840d3b68
[   12.737346] x23: ffff800080923924 x22: ffff00080038d2c0 x21: ffff800080923290
[   12.744467] x20: ffff8000809232fc x19: ffff00080038d010 x18: ffff8000840d3af8
[   12.751589] x17: ffff8000833d5c58 x16: 0000000078d6c4df x15: 0000000069b9dda5
[   12.758710] x14: 00000000f75c2086 x13: 00000000a0b1f81f x12: 000000004a81b180
[   12.765831] x11: 00000000e38eab80 x10: 00000000981bbba1 x9 : 00000000d391c60b
[   12.772952] x8 : ffff8000840d3b98 x7 : 0000000000000000 x6 : ffff800081aeeed0
[   12.780073] x5 : ffff8000840d3b68 x4 : 0000000000000000 x3 : 0000000000000001
[   12.787194] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000364b435542
[   12.794315] Call trace:
[   12.796751]  devres_for_each_res+0x64/0xf0
[   12.800837]  dev_cache_fw_image+0x5c/0x1a8
[   12.804921]  dpm_for_each_dev+0x54/0x88
[   12.808749]  fw_pm_notify+0x80/0x108
[   12.812312]  blocking_notifier_call_chain_robust+0x74/0xe4
[   12.817785]  pm_notifier_call_chain_robust+0x28/0x48
[   12.822738]  pm_suspend+0x118/0x270
[   12.826216]  state_store+0x80/0xec
[   12.829607]  kobj_attr_store+0x18/0x2c
[   12.833349]  sysfs_kf_write+0x44/0x54
[   12.837001]  kernfs_fop_write_iter+0x120/0x1ec
[   12.841432]  vfs_write+0x238/0x368
[   12.844823]  ksys_write+0x70/0x104
[   12.848213]  __arm64_sys_write+0x1c/0x28
[   12.852124]  invoke_syscall+0x48/0x118
[   12.855867]  el0_svc_common.constprop.0+0x40/0xe0
[   12.860560]  do_el0_svc+0x1c/0x28
[   12.863865]  el0_svc+0x34/0xdc
[   12.866910]  el0t_64_sync_handler+0x100/0x12c
[   12.871255]  el0t_64_sync+0x190/0x194
[   12.874907] Code: f94004da eb1600df 540000e1 14000018 (f9400740)
[   12.880986] ---[ end trace 0000000000000000 ]---

 drivers/regulator/tps6594-regulator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index 4a859f4c0f83..ac53792e3fed 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -653,18 +653,14 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (tps->chip_id == LP8764) {
-		nr_buck = ARRAY_SIZE(buck_regs);
-		nr_ldo = 0;
-		nr_types = REGS_INT_NB;
-	} else if (tps->chip_id == TPS65224) {
+	if (tps->chip_id == TPS65224) {
 		nr_buck = ARRAY_SIZE(tps65224_buck_regs);
 		nr_ldo = ARRAY_SIZE(tps65224_ldo_regs);
-		nr_types = REGS_INT_NB;
+		nr_types = TPS65224_REGS_INT_NB;
 	} else {
 		nr_buck = ARRAY_SIZE(buck_regs);
-		nr_ldo = ARRAY_SIZE(tps6594_ldo_regs);
-		nr_types = TPS65224_REGS_INT_NB;
+		nr_ldo = (tps->chip_id == LP8764) ? 0 : ARRAY_SIZE(tps6594_ldo_regs);
+		nr_types = REGS_INT_NB;
 	}
 
 	reg_irq_nb = nr_types * (nr_buck + nr_ldo);
-- 
2.39.2


