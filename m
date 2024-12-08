Return-Path: <linux-kernel+bounces-436456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016B69E8613
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E450D1885393
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51A17085C;
	Sun,  8 Dec 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="HuLz2byx"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC121607AC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673171; cv=none; b=l4FXJb5J1zCbua+71V/rDzCxRP7VrlkT4vldsgYRPSpOo/CLiVN3sWthl224dh1tpMoSCASNvGAezFc7QOFbiSW/oQIPO5j7P+qk7zcsDjCMqZxaLgg0WpF5nHM0vQtbSwOHBvYOY0CMm6wn1X19c0suwsRvKUTf+x0YBY/X+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673171; c=relaxed/simple;
	bh=W3XAcV3Mjj3KVk9T8n9IytlKibEylzK1ulVMw68GUA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7D6crHftrXbgERbBfqBCqQCAzISBMKGkH7IegZZO0VtoJ4nKWBcrneaAIg7prZOH1o/DCgfvz0b9/W9ER252LCndddkhQmBUEAhdJbTRlSXF9b3g6ejZHja/eheyWLIR51SI0qzyJLgAuMwlZOf3BxiG9RZhNzSNiUWdUq4OAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=HuLz2byx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so3384932e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733673168; x=1734277968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg2upxs4mtRpSPhYhiU3jXij7s08m89bnWpedFCJNHI=;
        b=HuLz2byxSDwXg7Ngw6/TGXKO3ZQGrdWYyTTAfKt814qaQ59AVddF5sjAJJ/ibUKjqU
         8xa4WrlIMNb1Ce/G6aoZwDFmWJeFU30rmDyaFyR8B009rtLoiCdnYe1tkxtocCbmS5WI
         e6NS/PCRkBAfRvFBAANObn+4Lp/Hvkt0+VHvxuAFMB/fUKV9RICYpaGPCttlkXhslRkv
         zkWL97p2900mVTl9bsNCSx1d40OJccRZqFinJfXqCYRFHeUY4JzWi9FUQDuNSiG+JjXt
         eTsyXnc0GDcCk2F3cKcD2uv8+75sL5CbGcUgmSZF061zV6cJhMQVWt6225xLfjpwfZhQ
         7SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673168; x=1734277968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg2upxs4mtRpSPhYhiU3jXij7s08m89bnWpedFCJNHI=;
        b=taOaQqN1aWyP7PCiU9xh9wrjY1/kkFVL8UABNqWIAtsnWgOD7mzxkGRydk53yft9jK
         jJu2YFWnsx6bS4XDgbyeLk55v0o9X/GteZsurS5O1NkJkmUFxZOulDgoEjYMtKRAqf1w
         YnJK+WZqbFsL3piPaEmtDDVy5mKPeqzWU1U995aT9b1XtxiAfLp2+7g2muVbbmZdfQRc
         bLx8PHWp3UFw5M4EuhHWFwobIxjHxDtzsVI/TGGhSBg8mhKVM4NpbSV3qpkqFLB0Fk7P
         psPewsX0douNEwoklxBqJhfHpg40FofbBFWDH9TVfAMYO3ty9xf/E5cQu94VXgb/VEw2
         IVbA==
X-Forwarded-Encrypted: i=1; AJvYcCXmrCsPrSaUG7hR55I8gMJbygsiCi2mcv+a93DNbmVX0TJS3ytKAFWajuRHQDKmYQqVbI1SOO7mZZOQTZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+zNVnM/g/WagrS3HvcA+YhTv9gn7b7hA3HBx0UrOBGln1Cd0
	+i8oBNm+cqifcam5gURElvovvYDdHQNHBJnqjp/XeZFbRhKUbpO5xCdDvi4Zr4s=
X-Gm-Gg: ASbGncvLsJJPHOpxCyazKyxRj/216fScrGXi0Rf595Oym4Bs7u48prh9cBuLNOAJ9gC
	IYTF/2XpsE8EZApYregSvY6QPTTTNSR3nQ14lII6x0sbymg+C3SZLckIrZV0BdOzLzRQV/AYMbF
	oQxYoW3PZlZ7nwI8tR49Kn7MDrrL/RMXdYE75Dlt5qnYPSxyO/pbODwgCyw205+onxcHF0dyTvG
	AMxj/9TBHed2X5/XubwknXndR6GBfWXQzt4vqVUqEEH4YXxAgQWmBHPt6X73I+j
X-Google-Smtp-Source: AGHT+IFqYHH7wOS5mwp8GRa50qvmO5IVTtwcTYIqm5zeEE/lumQiP2cK0ka70R8JpyU75hFUVIIn4g==
X-Received: by 2002:a05:6512:138a:b0:53f:a8c0:22a7 with SMTP id 2adb3069b0e04-53fa8c023aemr1206069e87.38.1733673167473;
        Sun, 08 Dec 2024 07:52:47 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a1ce70bsm580882e87.66.2024.12.08.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:52:47 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 3/4] net: renesas: rswitch: use generic MPSM operation for mdio C45
Date: Sun,  8 Dec 2024 20:52:35 +0500
Message-Id: <20241208155236.108582-4-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
References: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce rswitch_etha_mpsm_op() that accepts values for MPSM register
fields and executes the transaction.

This avoids some code duptication, and can be used both for C45 and C22.

Convert C45 read and write operations to use that.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 51 +++++++++++++++-----------
 drivers/net/ethernet/renesas/rswitch.h | 17 ++++++---
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 120d56754692..8dc5ddfee01d 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1167,36 +1167,29 @@ static int rswitch_etha_hw_init(struct rswitch_etha *etha, const u8 *mac)
 	return rswitch_etha_change_mode(etha, EAMC_OPC_OPERATION);
 }
 
-static int rswitch_etha_set_access(struct rswitch_etha *etha, bool read,
-				   int phyad, int devad, int regad, int data)
+static int rswitch_etha_mpsm_op(struct rswitch_etha *etha, bool read,
+				unsigned int mmf, unsigned int pda,
+				unsigned int pra, unsigned int pop,
+				unsigned int prd)
 {
-	int pop = read ? MDIO_READ_C45 : MDIO_WRITE_C45;
 	u32 val;
 	int ret;
 
-	if (devad == 0xffffffff)
-		return -ENODEV;
-
-	val = MPSM_PSME | MPSM_MFF_C45;
-	iowrite32((regad << 16) | (devad << 8) | (phyad << 3) | val, etha->addr + MPSM);
+	val = MPSM_PSME |
+	      FIELD_PREP(MPSM_MFF, mmf) |
+	      FIELD_PREP(MPSM_PDA, pda) |
+	      FIELD_PREP(MPSM_PRA, pra) |
+	      FIELD_PREP(MPSM_POP, pop) |
+	      FIELD_PREP(MPSM_PRD, prd);
+	iowrite32(val, etha->addr + MPSM);
 
 	ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
 	if (ret)
 		return ret;
 
 	if (read) {
-		writel((pop << 13) | (devad << 8) | (phyad << 3) | val, etha->addr + MPSM);
-
-		ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
-		if (ret)
-			return ret;
-
-		ret = (ioread32(etha->addr + MPSM) & MPSM_PRD_MASK) >> 16;
-	} else {
-		iowrite32((data << 16) | (pop << 13) | (devad << 8) | (phyad << 3) | val,
-			  etha->addr + MPSM);
-
-		ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
+		val = ioread32(etha->addr + MPSM);
+		ret = FIELD_GET(MPSM_PRD, val);
 	}
 
 	return ret;
@@ -1206,16 +1199,30 @@ static int rswitch_etha_mii_read_c45(struct mii_bus *bus, int addr, int devad,
 				     int regad)
 {
 	struct rswitch_etha *etha = bus->priv;
+	int ret;
 
-	return rswitch_etha_set_access(etha, true, addr, devad, regad, 0);
+	ret = rswitch_etha_mpsm_op(etha, false, MPSM_MMF_C45, addr, devad,
+				   MPSM_POP_ADDRESS, regad);
+	if (ret)
+		return ret;
+
+	return rswitch_etha_mpsm_op(etha, true, MPSM_MMF_C45, addr, devad,
+				    MPSM_POP_READ_C45, 0);
 }
 
 static int rswitch_etha_mii_write_c45(struct mii_bus *bus, int addr, int devad,
 				      int regad, u16 val)
 {
 	struct rswitch_etha *etha = bus->priv;
+	int ret;
+
+	ret = rswitch_etha_mpsm_op(etha, false, MPSM_MMF_C45, addr, devad,
+				   MPSM_POP_ADDRESS, regad);
+	if (ret)
+		return ret;
 
-	return rswitch_etha_set_access(etha, false, addr, devad, regad, val);
+	return rswitch_etha_mpsm_op(etha, false, MPSM_MMF_C45, addr, devad,
+				    MPSM_POP_WRITE, val);
 }
 
 /* Call of_node_put(port) after done */
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 303883369b94..9ac55b4f5b14 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -732,13 +732,18 @@ enum rswitch_etha_mode {
 #define MPIC_LSC_1G		(2 << MPIC_LSC_SHIFT)
 #define MPIC_LSC_2_5G		(3 << MPIC_LSC_SHIFT)
 
-#define MDIO_READ_C45		0x03
-#define MDIO_WRITE_C45		0x01
-
 #define MPSM_PSME		BIT(0)
-#define MPSM_MFF_C45		BIT(2)
-#define MPSM_PRD_SHIFT		16
-#define MPSM_PRD_MASK		GENMASK(31, MPSM_PRD_SHIFT)
+#define MPSM_MFF		BIT(2)
+#define MPSM_MMF_C22		0
+#define MPSM_MMF_C45		1
+#define MPSM_PDA		GENMASK(7, 3)
+#define MPSM_PRA		GENMASK(12, 8)
+#define MPSM_POP		GENMASK(14, 13)
+#define MPSM_POP_ADDRESS	0
+#define MPSM_POP_WRITE		1
+#define MPSM_POP_READ_C22	2
+#define MPSM_POP_READ_C45	3
+#define MPSM_PRD		GENMASK(31, 16)
 
 /* Completion flags */
 #define MMIS1_PAACS             BIT(2) /* Address */
-- 
2.39.5


