Return-Path: <linux-kernel+bounces-521057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B6A3B367
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9B23AEF91
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B11C5F29;
	Wed, 19 Feb 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="jldIeh9B"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66317A2EE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952712; cv=none; b=S6+y78YSoRVH5SL4oGmV1uAs7hnBTTg7Gpnl8mAgas8rRNggVue/bOeBrL/JmbME5oUKDG5vSloaUZTvjrx1hPGBQyYWRlEuhKYNOTGo9tAhKLXEN7wOLTbl/ulgOfGhDrVXG/oqjdt2uK3FhwcpTnodLAjMd8nWpVP2DfLxM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952712; c=relaxed/simple;
	bh=ORt85hqPPWjc/cKEc1XwNy5zah0r2SWmq0WxehDJxrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AETBOjSmuSQOskZeawnON/HOd8qOX7/3uypkvG/SCguXHlOS1y6ONHDPj9Aahpt4dA8nknE5q001inRlqNzrBah0t/XFhKXduKmpbeKU235TbM9Il5fbstQ1Vl/KwX8VY60eChjQwIIDXUYgpt7wsr8ddrkCDfRXcG+uLCfWur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=jldIeh9B; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0A4CBFB4D;
	Wed, 19 Feb 2025 09:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1739952165; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=+HmpXKPAD9ALBIJIuYji9/wPjq2kkxzldwrjVPCxR28=;
	b=jldIeh9Bo4Rrq9MdnBTo0xAocBcj2Iin0Xgk0Y0oHrMk0TxEMuIpMUqEx5KveF57Mu2dDd
	BhShyOY9RRWjZfADJlz2q1hy0nD47pzrIY6UP0iCUOv+IZpOeyzHYIsSVbxYluytO5bOWx
	Pv7BVrvgptD7w7/IzMQQrIn7VfOd1AeM4CJttcJAlksoLmQ8tMZ0btBS5LHt7izgguMDqG
	DLYVr+niyfO1W6xsXon/otZCHG5V4OtMHkbHO7bk5aNz1JNJbUNPIudRTGuF0KONxkXf3L
	QNkLKT7gqTsKe46eAr0Uo6YAxoRMcvxbFRwiKcHCMe6xx93BnTnwV1PCEF6RIg==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Bo Liu <liubo03@inspur.com>,
	Frank Li <Frank.Li@nxp.com>,
	Joy Zou <joy.zou@nxp.com>,
	Marek Vasut <marex@denx.de>,
	Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH] regulator: pca9450: Remove duplicate code in probe
Date: Wed, 19 Feb 2025 09:01:48 +0100
Message-ID: <20250219080152.11883-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The SD_VSEL GPIO is fetched twice for no reason. Remove the
duplicate code.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Apparently something went wrong when preparing the v3 patch
that got applied to regulator/for-next and is now in linux-next.
---
 drivers/regulator/pca9450-regulator.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 4519e725706cd..8f81d813640d9 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -1100,18 +1100,6 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	/*
-	 * For LDO5 we need to be able to check the status of the SD_VSEL input in
-	 * order to know which control register is used. Most boards connect SD_VSEL
-	 * to the VSELECT signal, so we can use the GPIO that is internally routed
-	 * to this signal (if SION bit is set in IOMUX).
-	 */
-	pca9450->sd_vsel_gpio = gpiod_get_optional(&ldo5->dev, "sd-vsel", GPIOD_IN);
-	if (IS_ERR(pca9450->sd_vsel_gpio)) {
-		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
-		return ret;
-	}
-
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
 		(type == PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
-- 
2.48.1


