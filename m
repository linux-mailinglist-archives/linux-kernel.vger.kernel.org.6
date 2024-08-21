Return-Path: <linux-kernel+bounces-295375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02192959A31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E04C1C2174C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B311C0DD2;
	Wed, 21 Aug 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="vBc/BFZP"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8CE1BAEC5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238003; cv=none; b=JHb+oXyh58POTsfF4mtLMoVn8sFiLYkqEmyEuhHqVSJ9MooKdlSbbUB3+uAM7B35V9GoLRkXL0wO3jdtHF/Ceux3E5l0r9KAIlIMpb9I9wF0/gmd/2/zyqUuVUKSgdCWXCHusuIiKnkxm7fDK64xRRKWvH6T6gw0YmQNYw9b1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238003; c=relaxed/simple;
	bh=1K56cFtxqRrqKL3dsbtsNJZdC6zpznB5RkaKOagcN9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKO7c6nYBNpHX/8yW3DwaxzmNul7dXMwxmz9XvnH4Xj72z+SmtDQILlWw+cVewkdEbf6EY1IUgpTuzXU/HUjEM+o5ZCu/8180Wo0c+2guwV2Lw5ACAfmBU9j2pC9GqBoXmQm+gh7p+hLu1CS4tW30V5P374pIgnZwp21oyOaMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=vBc/BFZP; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EFAA1483DF2;
	Wed, 21 Aug 2024 12:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237999; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jovbb058QzzCeFDP4Da8Wb3JHly5Xy6YvCLwu8Ic6q4=;
	b=vBc/BFZPkHoTOZP55cWp8jIcwt2YXJwPdq0Zk3/yQHb06gka0w8sOFpxXT3RYBpDw73D7f
	IxKKLjFxrDTticjvnANOv6RIRKzqRqJpaDjZrL2Nq65z4K64/o5Q/azqfms4KPsCnSQECW
	pR6Y4w6MlJKoacR6z9p7hEEhwJulCg+/wDcYCB2Ayg8fehf5DYPGWx0+7GrW6MsQJ6Aw4D
	Zsan9FH9auUf3k/suXz2EDAoMI4G284/YeHGF9u4qiHunWMzDggWfJbCDNXqIIayEIGAoV
	PbWg+pxA5tkvoKw075F2xMN5E35BP8ML+unevBlaleYvWD11N1Z6q+YKkY6qLg==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP OTPC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 11/12] nvmem: microchip-otpc: Enable main RC oscillator clock
Date: Wed, 21 Aug 2024 12:59:42 +0200
Message-Id: <20240821105943.230281-12-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Without enabling that clock, initializing the packet list leads to a
read timeout on the first packet.

According to SAM9X60 datasheet (DS60001579G) section "23.4 Product
Dependencies" the clock must be enabled for reading and writing.

Tested on sam9x60-curiosity board.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/nvmem/microchip-otpc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index a80535c3d162..047ca5ac6407 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/dev_printk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -54,6 +55,7 @@
 struct mchp_otpc {
 	void __iomem *base;
 	struct device *dev;
+	struct clk *clk;
 	struct list_head packets;
 	u32 npackets;
 };
@@ -272,6 +274,15 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 	if (IS_ERR(otpc->base))
 		return PTR_ERR(otpc->base);
 
+	// NOTE: Maybe make this optional, especially if sama7g5 testing
+	// shows the clock is not required there?
+	otpc->clk = devm_clk_get_enabled(&pdev->dev, "main_rc_osc");
+	if (IS_ERR(otpc->clk)) {
+		dev_err(&pdev->dev, "Error (%ld) getting clock!\n",
+			PTR_ERR(otpc->clk));
+		return PTR_ERR(otpc->clk);
+	}
+
 	reg = readl_relaxed(otpc->base + MCHP_OTPC_WPSR);
 	if (reg)
 		dev_warn(&pdev->dev,
-- 
2.39.2


