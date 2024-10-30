Return-Path: <linux-kernel+bounces-388500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA0D9B606F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F431C21470
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B421E47D7;
	Wed, 30 Oct 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JtuhmXyJ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC51E4101
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285250; cv=none; b=UuieOhLo1OWoHgK/Zqb76fNrx55BMShmm5YBDg3MraJuDJyaMDX+IMhSNkoMXRIgBnwMd9OV0C0MU8gyrmvovjPUp22v3o6eqX98cMhq+39I0tOmvqoe5bqi5LPD6ohnhqC8z+BZ0pktvWNYlwp/8fkFcBPwLqgijdsIHliXnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285250; c=relaxed/simple;
	bh=sbU5xQXF6E4XX9ncnkbKHW3kofSO0YDXfKRl90EyR54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtbNvFYzl3wk8rSrNNt2F5uixIZRHzWr4eAJEi/csiRmKdgGsNTT5Ijc9yWyD9dlPP379MMnu/fzvoFDo4fcYf6PDJszwPu6rP5z+qYq26VQDeDr4PWrYhkxxHH71CYbJK6KjV23DhnP/GXqdKldx7Mdfzz+mtTSgkGhW4FNG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JtuhmXyJ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2BB72C000B;
	Wed, 30 Oct 2024 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730285246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUlUDpq8VP1OTa7j0y4mtc+eoVWsoIOVcCnsrw8rmJ8=;
	b=JtuhmXyJ48hFUcuMsvNP2kwUzG5k13sa3FfxMhrI5KIE0hzyiBWs9JLxOxn6moV/hOcgFl
	P5OwYt1HV5VdRAlNwYSthC7tTOXO/HdSr/DYcSgbLZyJxRmk4F6FqXlCqQk10GHlneYNRu
	JIOb7uW9iEnKWZ9smETw4LPVH30Zh9yNGLyDUYGUsPdebM+W83vwA/ALihBxfoF/LsneDR
	gp4IvmCTYlIOIGdIs1ZJ+KzPr8W5qnlFfDfXv1kkeyJcfXhy8iQ6ig/zN8Norv6aHBPMDn
	Hvkdn77siMNviFlOn4eoWhLQ/IHaTz6ZFZagTCqfn1ZOtF5M5/yWwrchRqo78g==
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
Subject: [PATCH 4/5] mtd: rawnand: davinci: Add clock resource
Date: Wed, 30 Oct 2024 11:47:16 +0100
Message-ID: <20241030104717.88688-5-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
References: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

NAND controller has a reference clock but the driver doesn't use it.

Add a struct clock in the struct davinci_nand_info so it can be used
to compute timings.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 3c0efbdd789e..11dc30c29957 100644
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
@@ -822,6 +825,12 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
+	info->clk = devm_clk_get(&pdev->dev, "aemif");
+	if (IS_ERR(info->clk)) {
+		dev_err(&pdev->dev, "failed to get clock %ld", PTR_ERR(info->clk));
+		return PTR_ERR(info->clk);
+	}
+
 	info->pdev		= pdev;
 	info->base		= base;
 	info->vaddr		= vaddr;
-- 
2.47.0


