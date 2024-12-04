Return-Path: <linux-kernel+bounces-430892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5839E36E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DC32859E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339631B21B9;
	Wed,  4 Dec 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k7RU2M2a"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86121AF0A1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305411; cv=none; b=uFb4wjG9KY3xVNPoxcd0bAsX9JeSJHB8IYPNi2fzfw4Za/ukfGaCcOd+4ODhpakxajE41JHaBDQU00App+sH7reWbyF6af6BKym7oQefgYlcmdWwgF2TItQhnzAteJfYP0tHmVZDfJUBRdYZbEbabyM1WglScNuuJVFQXnMJKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305411; c=relaxed/simple;
	bh=FuIs2nZmk94nSFen7jMoWMn9dSSOLg8+Y2ZXltecJsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5gOuCJr8+zuoB1J5DFQJN/r0oG/CLz2gFzJJEmaatSd9LQlM4n1T8UKvGLqL86e5hBg5c3FHs/mouFQrFT2kpJe7LzZraSFUaWn+1uQvfTs21Mn97xiKvEKdlw7VTGc5TrZIPHoBb0fsh/rX/nCpJNnRlWtJMSr9kmuG6ETnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k7RU2M2a; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDDC560012;
	Wed,  4 Dec 2024 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733305408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfK2554wMfYphGMsRYSv3huQZ+56kT14PfwFMk8+S5M=;
	b=k7RU2M2avmDkzpzAQZcQPVA9bpnzUDtCpZ2RorT3jiRrbwJh7KZ2iITbW1OmktsO4vTFNt
	+vpI2R2RrUuHqud7GU/3XXzdsBnS+FcyQoYzcDU/Zdcf4+Q/AJ9Htns5Lir+zMF+dtvfiF
	KP5hwM+cQWo3j2RnO4wzk360EwRzh1YDYkr4bIwnRtxStUFb4YM6rMj2I/ne+UrguuTro+
	vRrDCjaF8Dv8gictgs6+h3Q4FgXIpkmTyN7bliUolDaZRaMKCz2PVfZLvf709V4KyvQnMA
	W5nKTWB7smQXmUcQIx/mysNVqBXZLhxQRLuNCjfRXp1roDJllIW1Ar7jMPEPmQ==
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
Subject: [PATCH v5 8/9] mtd: rawnand: davinci: Add clock resource
Date: Wed,  4 Dec 2024 10:43:18 +0100
Message-ID: <20241204094319.1050826-9-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
References: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
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
index 1f8354acfb50..4fb5c2623f5a 100644
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


