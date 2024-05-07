Return-Path: <linux-kernel+bounces-171258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E88BE1F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4820B26471
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526215CD55;
	Tue,  7 May 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KGFMB14a"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BE15B158;
	Tue,  7 May 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084545; cv=none; b=fTjsv0HxlDH8SH2F5L++SKjHoF1ojnd6VRav4iLpBqd7evvk+Lyv9enU8cKC6JJmndU5g2JKQAuTLfNxph2tTq5xqJXW+8gM0ZbrhLQbmG3exs/8fNCdgeEG0+NI8BpN7rn8sXmWJ8c/IlWHXa046xEdrEm/9McPGg/VxPZ6nJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084545; c=relaxed/simple;
	bh=fEMi6P7N4bVTaBaianKMOQ7QKgt11GP+KU+95KU7uZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNTP2a2c2HnQWoyBJDXvnIDYXZdWG0akvEZSItaFpsDh7RzKLCwAscZxC/QtiuFKS3Fvvs8wuWGY9xEYILPg68ep7Itk1anMwbUpHBSOZF7eykfmrnEoUbeMw+awuNt1r+vMr6IWtBabw5f2k+chs4dkgX4UsSVf2TW0KeEUG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KGFMB14a; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 447CMCEY090978;
	Tue, 7 May 2024 07:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715084532;
	bh=ukmd+IAHRmXUMzadAfPwIJvTLf63VTyB1DG1jtJodEE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KGFMB14aB9GQllMSWopeRdw0eubxbw776IYgKHmmhGq+Z7hTG4my/TRaaQYXuhNNH
	 6EdmtNxWHtul5IV7B4ZIUfjlsyqOr7VDS864JnccxtD2Tc2TVXwPJE5QWhORAzbEXK
	 wh092fHe3VLPTn0IMdnRFBWbSKWl4SxEeZkXDl/U=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 447CMCbn049977
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 07:22:12 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 07:22:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 07:22:11 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 447CLwDP038074;
	Tue, 7 May 2024 07:22:07 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 2/5] drivers: regulator: tps6287x: Unify compatible
Date: Tue, 7 May 2024 17:51:55 +0530
Message-ID: <20240507122158.3739291-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507122158.3739291-1-n-francis@ti.com>
References: <20240507122158.3739291-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TPS62870/1/2/3 devices have different output currents (6A/9A/12A/15A) of
the TPS6287x family. The I2C addresses are the same between them. Since
the dt-binding now only recognizes ti,tps6287x for the same reason;
modify the driver compatible to reflect the same.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/regulator/tps6287x-regulator.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index 9b7c3d77789e..6dc8511bdd3e 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -154,20 +154,14 @@ static int tps6287x_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id tps6287x_dt_ids[] = {
-	{ .compatible = "ti,tps62870", },
-	{ .compatible = "ti,tps62871", },
-	{ .compatible = "ti,tps62872", },
-	{ .compatible = "ti,tps62873", },
+	{ .compatible = "ti,tps6287x", },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(of, tps6287x_dt_ids);
 
 static const struct i2c_device_id tps6287x_i2c_id[] = {
-	{ "tps62870", 0 },
-	{ "tps62871", 0 },
-	{ "tps62872", 0 },
-	{ "tps62873", 0 },
+	{ "tps6287x", 0 },
 	{},
 };
 
-- 
2.34.1


