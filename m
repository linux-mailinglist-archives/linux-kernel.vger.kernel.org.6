Return-Path: <linux-kernel+bounces-184736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A158CAB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0E52817C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0D6CDC4;
	Tue, 21 May 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f05aP2+M"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC7605CD
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284894; cv=none; b=H7KIgUvbc/wr1awlOjA2AwHIq56o/CChSSoLmOI3yj178gucwMXvFIFWxMh1IwSmBtPcrwKLJiq3xllYWgMSaXHV1gDslwm/VHK/VFU3EEq+gDz/WUGV4Hf9qAK4djndXoW6VsfIp/vD1CecVqUPplKLywyLslYRE3tHQF+vxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284894; c=relaxed/simple;
	bh=vMUsIvJJY9WMiLki2w/dTwhSNZAndJ90fmU01eNF4YA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MSZDsiKYUwBxkH3NzHhPNcGGaqBocaVl40sqEiTlT4PoWPmP65RQD7ijECQ+aSKLHy9dZJNJOPGVeTW38ot+IaJPhcBK9v/ekbrtgSBH6y66wwcmqfofQ8aqfz/loRr6Pq7xOKzdyu0JhOYyKcnles5MRFiGppwIk/56/gOw2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f05aP2+M; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44L9m2Zp045964;
	Tue, 21 May 2024 04:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716284882;
	bh=PUT7bUu3EzT0iI5LQVCpwGce7FMSJEQZw1AeX5Vgo94=;
	h=From:To:CC:Subject:Date;
	b=f05aP2+MeiY1i/YXkBmozrWxxpikCgQeBFhr/tXbQzju9Np5IE9kAZjW84+7zuqDc
	 76aBZSsuyupMum+ZJCBUO4l7xT6o48kzmsZWLzyvEjCmG3hpP/e0ZqJ1Vmqiaai4Ru
	 fhGa7kMf333uBWMffn4XUarxdYot+pzxQR/7EsmU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44L9m2ig052000
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 04:48:02 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 04:48:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 04:48:02 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44L9lwsO074347;
	Tue, 21 May 2024 04:47:59 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <jneanne@baylibre.com>,
        <eblanc@baylibre.com>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH] drivers: regulator: tps6594-regulator: Correct multi-phase configuration
Date: Tue, 21 May 2024 15:17:58 +0530
Message-ID: <20240521094758.2190331-1-n-francis@ti.com>
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

According to the TPS6594 PMIC Manual (linked) 8.3.2.1.4 Multi-Phase BUCK
Regulator Configurations section, the PMIC ignores all the other bucks'
except the primary buck's regulator registers. This is BUCK1 for
configurations BUCK12, BUCK123 and BUCK1234 while it is BUCK3 for
BUCK34. Correct the registers mapped for these configurations
accordingly.

Fixes: f17ccc5deb4d ("regulator: tps6594-regulator: Add driver for TI TPS6594 regulators")
Link: https://www.ti.com/lit/gpn/tps6594-q1
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Boot logs: https://gist.github.com/nehamalcom/94595895a7f28385fb5c1ec6c1abda23

 drivers/regulator/tps6594-regulator.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index b7f0c8779757..5fad61785e72 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -287,30 +287,30 @@ static struct tps6594_regulator_irq_type *tps6594_ldos_irq_types[] = {
 static const struct regulator_desc multi_regs[] = {
 	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK34", "buck34", TPS6594_BUCK_3,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(3),
+			  TPS6594_REG_BUCKX_VOUT_1(2),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(3),
+			  TPS6594_REG_BUCKX_CTRL(2),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 0, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK123", "buck123", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK1234", "buck1234", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 };
-- 
2.34.1


