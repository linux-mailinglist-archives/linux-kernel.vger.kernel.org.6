Return-Path: <linux-kernel+bounces-295371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B1959A29
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8D7282B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A851BA285;
	Wed, 21 Aug 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="H4An3j4C"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AC1B78F1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238000; cv=none; b=GxL6kocofAvpUyh6GLc1tDNp0TYk+fD3/9ulxzuYGw0tK0AJM+DLRQ4pv7EwpTgj+aBxBoC2qZxROWAfv1meF3RgSUDwDri54zMUeCbui7nJ1qJ/HhchpJBTsIK7E1JiHXucRQvcL7lz7pbJPsqLwwBMHPR+QRJqd/L9PjOp06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238000; c=relaxed/simple;
	bh=HEhJgnKmGCTfVx3YtNlr94JVj4+kbZWoTHoFbCmLgsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKWNC5duB42FrR/dv8LlJvhQKjZcHUX8B4LTc59YJjDZ361nTvVTlbCpWuY6KnwPl/wh3F/gOCg+jlwn4Cqmw8zhXcmc7Igp5wC1O6x6HmwZkGjWwkOKK64X6HcSE+VYbOiVM181RQh++mLsIT9U8TyxSJZf/cjNrXFDYpHOnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=H4An3j4C; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDC611483DF8;
	Wed, 21 Aug 2024 12:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237996; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+hE4Oaa/+RDBODWq0UJM3XXnYgcGWlBIKzul9txp90I=;
	b=H4An3j4CsF/zMsyyX616M0lmcq0coy9KfP0i1tuxNvh/Z3qtjzQZj4E8+44XU3I4+U8a+R
	JXtT0A/0TVrbPuMyC0RcSC+pYUXX9tNsx1CGkCKslwBH/fkXRl1LGucosKHd/u5aG0cA7j
	grkIE4uQFVAWFkdKAmP5POGgyzMuUFZU1RywA98xK33WEmzh8FP/D5yBA20WureSPre/V4
	pmdaRkH31phg35fxpBCZl5CEu34UV5Y0SZUJK282z2JkVD43gC485p6KzyBhvYYwCxEpJR
	Mf76kaXaYmIq6ZA8Ix2biACBKaMub9I6Ajx6A9S7jlyNNJsQ+wcobMb6/5mV3w==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP OTPC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 08/12] nvmem: microchip-otpc: Add warnings for bad OTPC conditions on probe
Date: Wed, 21 Aug 2024 12:59:39 +0200
Message-Id: <20240821105943.230281-9-ada@thorsis.com>
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

These conditions could affect correct function of the driver.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/nvmem/microchip-otpc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 4630e96243ac..a80535c3d162 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/dev_printk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
@@ -260,6 +261,7 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 	struct nvmem_device *nvmem;
 	struct mchp_otpc *otpc;
 	u32 size;
+	u32 reg;
 	int ret;
 
 	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
@@ -270,6 +272,16 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 	if (IS_ERR(otpc->base))
 		return PTR_ERR(otpc->base);
 
+	reg = readl_relaxed(otpc->base + MCHP_OTPC_WPSR);
+	if (reg)
+		dev_warn(&pdev->dev,
+			 "Write Protection Status Register Bit set: 0x%08x\n", reg);
+
+	reg = readl_relaxed(otpc->base + MCHP_OTPC_ISR);
+	if (reg & MCHP_OTPC_ISR_COERR)
+		dev_warn(&pdev->dev,
+			 "A corruption occurred since the last read of OTPC_ISR.\n");
+
 	otpc->dev = &pdev->dev;
 	ret = mchp_otpc_init_packets_list(otpc, &size);
 	if (ret)
-- 
2.39.2


