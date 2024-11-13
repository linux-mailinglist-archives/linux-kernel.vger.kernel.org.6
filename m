Return-Path: <linux-kernel+bounces-407329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1F9C6C00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B06D281A75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737001FA244;
	Wed, 13 Nov 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pdPkcgsN"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E861F8F06
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491389; cv=none; b=H2p58CJUrIQDF/rxB5+QBO5xbsVVvGklYEni0+BCNhx4LIk+SkBWzzuakstNdwx5Rf+snatDxhcACEoCeWaayD2Oq7dfc8ZwDuk0F3EqdUnZbH2L+e3rQWFIdMwZDXUzFTOV1iR2YauJ8FV7CZuQ1N3f7BT3NFqbD5nZ+9NQt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491389; c=relaxed/simple;
	bh=jq/HxwUks//QkKP3ZJZNN0GtGvXs1KXTbgyq1k0z2kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExxmiNlQ6QrmW0EgV7yng5jHs9qCVBBzqzLAyRPqO9HO8hxrPFQFYlENj0FC2yn42gtwKnG9l5b/MgoVJP0Axq+zt5akSv2AuBgleBf0dN9YIeNcpv6jKpv3KLtSh97hUN5YoPv+mEWCFiwT9HqxyrvLPSPKjttpsS2CuDatUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pdPkcgsN; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 63B31C0005;
	Wed, 13 Nov 2024 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731491385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONE5RIDa+M5HrCVn5iTpaeEU6VZHpy9NTdUHLDL3hak=;
	b=pdPkcgsNZr9bGMJRCtJGG6Kp9JOneqiNmeOHO3VmnQwisps53nzoczoic5DMXpqBw+a02h
	TVI3z1jLaK56EReo3fgnPg7YN2kgc4wL/W/zRjuOpb427i+FiDpEmdRpH9h2E72co2OGN4
	WtT1uTc4IHf0Xpn8ZsoWsRQBdWq3lmH4q8j7O3kcuJHzVrY3K1tEAsm6ND8nZQ+bBWc0R4
	nFQe6sDNjmxjisT94Dq19Dra0FtCQwiakMODZXcKzNaDzidcK1rXOmFRxvTRfBO3uIEvsK
	0R6sX/vctlZXoK6kMjTAAkGeLBJ54biRThG4GRxZUq8PZd0X7DMKqfXgOwMebA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH v3 6/7] mtd: rawnand: davinci: Add clock resource
Date: Wed, 13 Nov 2024 10:49:37 +0100
Message-ID: <20241113094938.44817-7-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
References: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

NAND controller has a reference clock inherited from the AEMIF
(cf. Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt)
This clock isn't used yet by the driver.

Add a struct clock in the struct davinci_nand_info so it can be used
to compute timings.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 3c0efbdd789e..563045c7ce08 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -10,6 +10,7 @@
  *   Dirk Behme <Dirk.Behme@gmail.com>
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -117,6 +118,8 @@ struct davinci_nand_info {
 	uint32_t		mask_cle;
 
 	uint32_t		core_chipsel;
+
+	struct clk		*clk;
 };
 
 static DEFINE_SPINLOCK(davinci_nand_lock);
@@ -822,6 +825,10 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
+	info->clk = devm_clk_get_enabled(&pdev->dev, "aemif");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed to get clock");
+
 	info->pdev		= pdev;
 	info->base		= base;
 	info->vaddr		= vaddr;
-- 
2.47.0


