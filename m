Return-Path: <linux-kernel+bounces-199637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F88D8A12
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E7528AE35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA9137C3F;
	Mon,  3 Jun 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lntAfzGi"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2823A0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442713; cv=none; b=hWYQrABmSXKZsBSpEm5AIeECiHrIH98OBZP6MY6t6TsywqkgNC82bDeozjD94xYYXLNKKeKftZyMygDT0hxxFit+ivhG8xTC172DHpmIQYq3tQbBuRxttDnZNbZ44+csltjzf1ATiglimNHRN0HBQICIHlCeH6/tQZJFEGCjugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442713; c=relaxed/simple;
	bh=k7Q39RV/k4W3ar2rZQGujNoiEJGMCkHHKvWYpw2qnjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oxZE8s4S5dQnS9n1d5F6/tRGLyd9Z9ddS00HL4uCejzyVvojnmMjn8xStwF/VS2OEyQOZrihEXUEwZgnhl/jEja4NG+WByjAOrVFPkmkjtc/j5dAhONrKMgGvPGNWkdBKcuNGq8FYzOf+OgcuCuHlCY5XH5aK6NdLYIhagZLBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lntAfzGi; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453JP3NW010511;
	Mon, 3 Jun 2024 14:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717442703;
	bh=ZXsfZWPTOwaqjYCuqVsTH76ZrcLd4yIW97JCMWXnw/0=;
	h=From:To:CC:Subject:Date;
	b=lntAfzGi4W8Ajm8c2RdUmvWa82hR9cEXEmMeWmzhiGn/UkjZ65eho6WstetSxDfp2
	 q5WUWLoa3mXraoelDbG+j0AeCsyhAFqNMMxP3DFm9SYZpsCNFOS/2CTDbaJ9gba80z
	 lvWeDIm4buGOD6u2udR2QITOLO8xFB4HyE6FHtSY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453JP35g128881
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 14:25:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 14:25:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 14:25:03 -0500
Received: from shree-udc0509427.dhcp.ti.com (shree-udc0509427.dhcp.ti.com [128.247.29.227])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453JP3Qk057883;
	Mon, 3 Jun 2024 14:25:03 -0500
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
To: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <m-leonard@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
        <bhargav.r@ltts.com>, <m.nirmaladevi@ltts.com>, <vigneshr@ti.com>,
        Shree
 Ramamoorthy <s-ramamoorthy@ti.com>
Subject: [RESEND][PATCH] Fix nr_types assignment for TPS6594/3 and TPS65224
Date: Mon, 3 Jun 2024 14:25:00 -0500
Message-ID: <20240603192500.645586-1-s-ramamoorthy@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fixes: 00c826525fba ("regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators")

Marked as resend to include the correct Fixes: tag.

TPS6594/3 and TPS65224's nr_types assignment were incorrectly swamped in
probe(), leading to memory underallocation and a NULL pointer error. 
Error detected in and solution tested on J7200 EVM.

Error logs:
[   13.974024] Call trace:
[   13.974025]  _regulator_put.part.0+0x40/0x48
[   13.974028]  regulator_register+0x2b0/0xa00
[   13.974031]  devm_regulator_register+0x58/0xa0
[   13.974035]  tps6594_regulator_probe+0x4e0/0x5f0 [tps6594_regulator]
...
[   13.974178] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
---
 drivers/regulator/tps6594-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index 4a859f4c0f83..b66608ab2546 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -660,11 +660,11 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 	} else if (tps->chip_id == TPS65224) {
 		nr_buck = ARRAY_SIZE(tps65224_buck_regs);
 		nr_ldo = ARRAY_SIZE(tps65224_ldo_regs);
-		nr_types = REGS_INT_NB;
+		nr_types = TPS65224_REGS_INT_NB;
 	} else {
 		nr_buck = ARRAY_SIZE(buck_regs);
 		nr_ldo = ARRAY_SIZE(tps6594_ldo_regs);
-		nr_types = TPS65224_REGS_INT_NB;
+		nr_types = REGS_INT_NB;
 	}
 
 	reg_irq_nb = nr_types * (nr_buck + nr_ldo);
-- 
Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>


