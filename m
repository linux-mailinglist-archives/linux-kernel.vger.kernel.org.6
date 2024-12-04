Return-Path: <linux-kernel+bounces-430889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF809E36ED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FF9B2E255
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6721B2183;
	Wed,  4 Dec 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o8wYqnOH"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29001AA78E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305409; cv=none; b=dJskFE52xXh4kpclt7wPROo62eC9WJMZVQ2A3fm1Hkj7fCH5BA+TfjUHlNBy0aiQtib305fdSuA6C0wLybSCH7pCAT3Q9hEWasrq+hDtS12dt7cp+hkNsVaSNCzYGx71bFaSz9lFB4AMSWfGcJAa9KmZ/YMcdMIp4fuBG0hoJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305409; c=relaxed/simple;
	bh=k/sTWHD6MrxmBTSDhbLEQLDBKe7SNAl+sJ+HWfjzVBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx/vvoniaXhguWDaZC18R9FYR4qLWV27sMDiZsY8wJj5aqZV7pAExJ1ntTr3Fa8NKejUioz7tS1Swa20GiNlHbPTQP5HmFrVVVjqTzRoLIOmofojLUgzNVe7y0yUI46IbubnnMAeaV+66djX4pn+xXFBxBCklSNnvnTn5+zx7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o8wYqnOH; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F6316000F;
	Wed,  4 Dec 2024 09:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733305406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26W5J7+Yyb1PTn8lfArcBq6GxlFwHGn4b3VkCGyRsbM=;
	b=o8wYqnOH1DMfcCzoQOQFdUQC1JNXWi4guIs74lBGant0SC9/Nllk+mNSuaFXdwTSvIV8ws
	4jmn4pS37WqPnJ5t1XNhHelo7RvAbG8JdPpNwIo3WJa7ycXdSGGXz0YyuSmZ/AT+9cJns5
	podr21V+Zlm3FCIcMvCBsN2QdddVxK79INTsIBZCXvZTjx8XxgnGVqNDnxY7NZOMbuxQEV
	Dl6Ae65kbkDoKXQekAeZHtexkUaki2gDilNeVhK/4zhMDQyYrioA3XWOFnIWaF0QnKVRvm
	ANinmKKNWiAda90pG/RcIugeUk8wnYGA+AmWjo9NGhJJnHxk4kQfBSAI9qqs6g==
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
Subject: [PATCH v5 5/9] memory: ti-aemif: Create aemif_set_cs_timings()
Date: Wed,  4 Dec 2024 10:43:15 +0100
Message-ID: <20241204094319.1050826-6-bastien.curutchet@bootlin.com>
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

Create an aemif_set_cs_timings() function to isolate the setting of a
chip select timing configuration and ease its exportation.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/ti-aemif.c | 65 +++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index ec770a2668e7..83fb308a831b 100644
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
  * struct aemif_cs_timings: structure to hold CS timings
@@ -165,6 +165,44 @@ static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
 	return 0;
 }
 
+/**
+ * aemif_set_cs_timings() - Set the timing configuration of a given chip select.
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
@@ -213,12 +251,7 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 
 	offset = A1CR_OFFSET + (data->cs - aemif->cs_offset) * 4;
 
-	set = TA(data->timings.ta) |
-		RHOLD(data->timings.rhold) | RSTROBE(data->timings.rstrobe) |
-		RSETUP(data->timings.rsetup) | WHOLD(data->timings.whold) |
-		WSTROBE(data->timings.wstrobe) | WSETUP(data->timings.wsetup);
-
-	set |= (data->asize & ACR_ASIZE_MASK);
+	set = (data->asize & ACR_ASIZE_MASK);
 	if (data->enable_ew)
 		set |= ACR_EW_MASK;
 	if (data->enable_ss)
@@ -229,7 +262,7 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 	val |= set;
 	writel(val, aemif->base + offset);
 
-	return 0;
+	return aemif_set_cs_timings(aemif, data->cs - aemif->cs_offset, &data->timings);
 }
 
 /**
-- 
2.47.0


