Return-Path: <linux-kernel+bounces-397851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02109BE164
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13B0B21BF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0AE1D54D1;
	Wed,  6 Nov 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ck6Y+Zlw"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B891D90A1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883321; cv=none; b=sEYkZ0RZ0tZ4l5xUzQpMpoxzs6hFUfM80mhnBsc2livjkzv71DRscG1EwkX4y3QIQjgcKWIUel46zEDYMv53XAJpU/yL4+tkHprZNTL2wG9XmebV179pdz+/yBLzUv6bwI3oHVrKHp7zfDDwjTX4hcsG2htITZ1Swr9DdT6kXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883321; c=relaxed/simple;
	bh=jq/HxwUks//QkKP3ZJZNN0GtGvXs1KXTbgyq1k0z2kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCEUWEesf2zSQ5maD1c+kK1p5wqpVix8BWj7h22MUorBQ09gfGNBWTL2l8dkdfkutO/oug9czsIjApPRogh/GvEbQDUPuT56A3zWSiNRaMK6PNtDXu8w09Hy2cIyDbhWVshIyDdZt9iPx/YyIdOUJlbw1WovUI8oBce6RX+iHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ck6Y+Zlw; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 798181C000B;
	Wed,  6 Nov 2024 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONE5RIDa+M5HrCVn5iTpaeEU6VZHpy9NTdUHLDL3hak=;
	b=ck6Y+Zlw/AlY7e/Yr2LL6isIQVn9cSua0Dpk3NWwZPCSTn6A+f93jkfzgu9Oa9tu0JyWZ2
	8GRk+NX98DyLdS/D35+tjG0DgISGywDFKi4JS4BCOPE7S5gq43Qq3gLwB0pDFgHueP/1qP
	VO54cKwHpddjrrWP+BlAbK645vfpvn1xWvG/cWFhD2CU2FElzE8KsTUWnbswE5VCCcRG2M
	AoavttgMtHPyhLMlof7K7LuKu0wd0v/pnlRSIoiWFJ8KM4v9IHmmDDQLyBQj4J8giQ3GJm
	D0+rbQ0Jy+6mp9uMM3h0/wvApZX2td/7U7/AzTR6R+xxImFkrsTzW/b9DObDwQ==
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
Subject: [PATCH v2 5/6] mtd: rawnand: davinci: Add clock resource
Date: Wed,  6 Nov 2024 09:55:06 +0100
Message-ID: <20241106085507.76425-6-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
References: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
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


