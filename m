Return-Path: <linux-kernel+bounces-199482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897248D879A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4386E280C21
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B923136E2A;
	Mon,  3 Jun 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WrMvdP8A"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9FF135A6F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434337; cv=none; b=fKV62ZWhqlRR5HODLBANJHAVXUrngpH45M2yGL2sEbh+CTDNI4fGuzxgDDpYpbYE24um24HqQ1fTC54y2LBF33qWC+Lv7Gb6qJnnj8+uU/eyUAPrQu8Q1JkfzAU7N1BF3nMIjZs0m2cTk8uZk8/zZDhiy9lKBZLAnWapQa8JE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434337; c=relaxed/simple;
	bh=jAih5F90EVVgJcWXk40LnZSRKdJAkb6zUSgJE8ry8Xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hie4du1Ld5xU36J7pzDqCV2QgkSLdE2dZ8NHuvIl+3L3vu6hkjupFox8fN41SN89j/yc1uhRYx0omxb+iMF64aSRh+UTRwArA91GVW3RF+v8RqeRtD6ofw6a1B01FQSJEYh4aCtOKzlbxVCAqGHncx+H+46DN9gbNUDMyOhdY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WrMvdP8A; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453H5Tco110827;
	Mon, 3 Jun 2024 12:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717434329;
	bh=8V5Xf3/VR+kQfLyRU2laXgJnvd1caoydMEx26Tdx9TQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WrMvdP8Af8rfYjhlMGvKKbvxs1DxRHGMbFvaaHCKASaJYWat2pJ9PIlYpw3fNahqX
	 caf5L4VwcBlBj+9RzWjpTXSSmyxvMkNwlhit4Ttaq/vCHxPc/zmVI6pyHRELcKcruI
	 /qC4kV+WKF47ODiEUqdfHeRG73ID2iYR6f3QkgKY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453H5TJ3039134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 12:05:29 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 12:05:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 12:05:29 -0500
Received: from shree-udc0509427.dhcp.ti.com (shree-udc0509427.dhcp.ti.com [128.247.29.227])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453H5Snp103813;
	Mon, 3 Jun 2024 12:05:29 -0500
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
To: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <m-leonard@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
        <bhargav.r@ltts.com>, <m.nirmaladevi@ltts.com>, <vigneshr@ti.com>,
        Shree
 Ramamoorthy <s-ramamoorthy@ti.com>
Subject: [PATCH v1 1/1] Correct nr_types assignment for TPS6594/3 and TPS65224
Date: Mon, 3 Jun 2024 12:05:24 -0500
Message-ID: <20240603170524.643010-2-s-ramamoorthy@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603170524.643010-1-s-ramamoorthy@ti.com>
References: <20240603170524.643010-1-s-ramamoorthy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Swap nr_types assignment for TPS6594/3 and TPS65224.
Issue detected with v6.10-rc1 and tested using a TI J7200 EVM board.

Log:
[   13.974024] Call trace:
[   13.974025]  _regulator_put.part.0+0x40/0x48
[   13.974028]  regulator_register+0x2b0/0xa00
[   13.974031]  devm_regulator_register+0x58/0xa0
[   13.974035]  tps6594_regulator_probe+0x4e0/0x5f0 [tps6594_regulator]
...
[   13.974178] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004

Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
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

