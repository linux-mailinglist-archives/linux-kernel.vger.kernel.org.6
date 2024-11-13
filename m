Return-Path: <linux-kernel+bounces-407325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC989C6BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDAB28195E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE7C1F9414;
	Wed, 13 Nov 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FUXEMt5A"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902C1F8EF3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491387; cv=none; b=XmZSmg1NfgHF444l4BvpfnqKpfXU22XeligOlubJAtx2Ai0nYIlbqt5N97cheLLC/yoh6KTPZGYWwz7UMuSbPQpZ/3Ek9zI6Z9d2ENwSJhlNwvzcGCiPl0Zt4dldOnmkEPzfEw/ti8dxLjvLBFz9KnmIXXxhDBSGWc5vjtQV3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491387; c=relaxed/simple;
	bh=3ypZsUz4tTp5D7oBMBsyNYdL595hWT8C2TIRWapqBF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hugM6mJq4IDLLlnRY1qFg1VNzrc1xp0ihloElNCFzgQfHCN/LK5PGMdykTvTkT2uMnApckCj3XemVSkRKznfJ/uW9g/A2x9d5afsPwjUQwGdLbm4SuU1gXaa/bOyng9jE6zGWiOmUSbX/sx7xosQL5hTGIqkhhN9NZ2D0Tuo3vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FUXEMt5A; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A4328C000D;
	Wed, 13 Nov 2024 09:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731491383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e12TUryYZQDpAftpWISfRSW9eY/LIPfb/YxlEWXq1Ws=;
	b=FUXEMt5AiYsS+gIvemKoLqcLfoQJvjqMiEkKNOc6wHWdbaJd4kP25/BBPEmmPxYV/9DX4h
	TgNcBqfOGP1xEGCujVlbVZh3dRXueMeDx3SflQk/D0BsE6pLwWKRTJa9kjhBce6Q/jMY7K
	1B5u8agXRk4xh7FKsmNQIZ45fkYsE1ODp+Ko6RdsG1vf6eYBKvvHg7G4KOGEZbfxqcSIPG
	ppM7klwgEjGwHVTfSpBeQXAJFqWzR2U1SXg1Em24syT2iQuaKKwoEjPRM/LgyuHseLohDU
	f3QYUHF+6CgKZMedpl2crfU2rXi/g91aRg1nwQFqV7a31S/N09z0USk729sNCQ==
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
Subject: [PATCH v3 2/7] memory: ti-aemif: Create aemif_set_cs_timings()
Date: Wed, 13 Nov 2024 10:49:33 +0100
Message-ID: <20241113094938.44817-3-bastien.curutchet@bootlin.com>
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

Create an aemif_set_cs_timings() function to isolate the setting of a
chip select timing configuration and ease its exportation.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif.c | 64 ++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index eef086c8371b..b1236cc9ce92 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -69,15 +69,15 @@
 #define ACR_SSTROBE_MASK	BIT(31)
 #define ASIZE_16BIT	1
 
-#define CONFIG_MASK	(TA(TA_MAX) | \
-				RHOLD(RHOLD_MAX) | \
-				RSTROBE(RSTROBE_MAX) |	\
-				RSETUP(RSETUP_MAX) | \
-				WHOLD(WHOLD_MAX) | \
-				WSTROBE(WSTROBE_MAX) | \
-				WSETUP(WSETUP_MAX) | \
-				EW(EW_MAX) | SSTROBE(SSTROBE_MAX) | \
-				ASIZE_MAX)
+#define TIMINGS_MASK	(TA(TA_MAX) | \
+			RHOLD(RHOLD_MAX) | \
+			RSTROBE(RSTROBE_MAX) |	\
+			RSETUP(RSETUP_MAX) | \
+			WHOLD(WHOLD_MAX) | \
+			WSTROBE(WSTROBE_MAX) | \
+			WSETUP(WSETUP_MAX))
+
+#define CONFIG_MASK	(EW(EW_MAX) | SSTROBE(SSTROBE_MAX) | ASIZE_MAX)
 
 /**
  * struct aemif_cs_data: structure to hold cs parameters
@@ -178,6 +178,44 @@ static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
 	return 0;
 }
 
+/**
+ * aemif_set_cs_timings - Set the timing configuration of a given chip select.
+ * @aemif: aemif device to configure
+ * @cs: index of the chip select to configure
+ * @timings: timings configuration to set
+ *
+ * @return: 0 on success, else negative errno.
+ */
+static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
+{
+	unsigned int offset;
+	u32 val, set;
+	int ret;
+
+	if (!timings || !aemif)
+		return -EINVAL;
+
+	if (cs > aemif->num_cs)
+		return -EINVAL;
+
+	ret = aemif_check_cs_timings(timings);
+	if (ret)
+		return ret;
+
+	set = TA(timings->ta) | RHOLD(timings->rhold) | RSTROBE(timings->rstrobe) |
+	      RSETUP(timings->rsetup) | WHOLD(timings->whold) |
+	      WSTROBE(timings->wstrobe) | WSETUP(timings->wsetup);
+
+	offset = A1CR_OFFSET + cs * 4;
+
+	val = readl(aemif->base + offset);
+	val &= ~TIMINGS_MASK;
+	val |= set;
+	writel(val, aemif->base + offset);
+
+	return 0;
+}
+
 /**
  * aemif_calc_rate - calculate timing data.
  * @pdev: platform device to calculate for
@@ -244,11 +282,7 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 		return ret;
 	}
 
-	set = TA(timings.ta) |
-		RHOLD(timings.rhold) | RSTROBE(timings.rstrobe) | RSETUP(timings.rsetup) |
-		WHOLD(timings.whold) | WSTROBE(timings.wstrobe) | WSETUP(timings.wsetup);
-
-	set |= (data->asize & ACR_ASIZE_MASK);
+	set = (data->asize & ACR_ASIZE_MASK);
 	if (data->enable_ew)
 		set |= ACR_EW_MASK;
 	if (data->enable_ss)
@@ -259,7 +293,7 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 	val |= set;
 	writel(val, aemif->base + offset);
 
-	return 0;
+	return aemif_set_cs_timings(aemif, data->cs - aemif->cs_offset, &timings);
 }
 
 static inline int aemif_cycles_to_nsec(int val, unsigned long clk_rate)
-- 
2.47.0


