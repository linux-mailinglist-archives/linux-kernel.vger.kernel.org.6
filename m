Return-Path: <linux-kernel+bounces-521980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B6A3C487
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB32F3ACB32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D31FF5F4;
	Wed, 19 Feb 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i1L8Bhiq"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5841FDE05
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981285; cv=none; b=Jp+1kvOA+9xhQbdGBYNuPuRFyqEkC/cflxqn4UFlIYO6VCRXgcKZ+pARZPZ32DXiZw7vIgCfoKdAuPG08XxKFUXBNALY7cu6fSDxN7XwOlIejvHA3MZhjk7Q2DHP89kS/zv2LiRU10uChI8/vi5Qa9S3pKup8iMbWmcc5BoLQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981285; c=relaxed/simple;
	bh=wc4sN7qLZm+el405nRxJo5bxZYh7t6HvJ1R0u+zhzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVa901hu702xSAH3sd10P6nTqgIcMAjMx/68ovrk3a8yhxm0XjUm+FIxazTjTV4ZOI0UsCQ39Yum+Y+yl0D/ppoaqE+1VzNztGega8oM9rEuUsd8zkO1RDthoXj9QGtTjoB+hFBNODXCKWJXx400CXCZ12tr5zNW9XgIImNbznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i1L8Bhiq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so3170243a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981279; x=1740586079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlGt4wExiEL/CIXJbDF0itACKrrgHmIFMrYFUtPey+c=;
        b=i1L8BhiqCbPhgjhqI4Fs0WESgBOn7qro6AnnWert3MTOoZLsj7G3+Mjl1knNKEPU3F
         RyFtGuzwiVsEN0wzECKvdfNoHo4OmYtVY6vBmyEbw2yut+r0f6BuBXFpq6454LhdYMH1
         uVvamrLBEtJ/qIN+mQOtNgbYOaax7IyYSTfioADdnREZ8/5bqw3oZ3HttptNOzcaFU+Q
         yVgK0sgn4AW/9vVfarjUZkz8NPpmbTol5zMuryl7d7MRWVzi23tWpj/ZRm5QuGi5GfZq
         +VGi/mNNMz/Tw2kT+RPv3fu2B/5FQoZGomXomz7B4ckg3xVgpNmZNB+XBoS9QTQhjdof
         FHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981279; x=1740586079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlGt4wExiEL/CIXJbDF0itACKrrgHmIFMrYFUtPey+c=;
        b=Cv+dluOvaPrH9C+06ZjJvh5u5MyHqWsRvtsigwByCKDdJ32H+qHFBPiH4NeKH2Yiq2
         Ruai9KGgXoCx9TBB0YAdTj2VWvQAbggTMzmOAC2GoCl3y2JXFermEtbkvo5TYAosQ0OA
         RiOzaUoPjjPSsXw4b0mst9FTiCP++UNwVINTj09Q3eE8jXt+wrEyF/Kuw8bmZaUfJB7Q
         ABP9kt3/yjnMt44lERnG4qJFAJ2EzhOtPdNfJPv0dBH6Drw52r96O36gp+8TGzmq+sky
         enoBnrrJbYC1Skl/kdyItW+SwketC4bkCJFs1lVmgSzaG3AoBvxBKDz8kju3U/h3iRpc
         T+pg==
X-Forwarded-Encrypted: i=1; AJvYcCXDjbDVeTut4iC/AfHVRvBYzHRA71Fz5a0qYtbrPJ141PPPt3WIbKPkKN6aJqEFjwfp0eo6yBhKH3c7wB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsoNTAebqNUIfUIfl61eXmEeXrGlnDaPooMXkrj05B5j7/eyv
	yGc8toKkm2RE9v6Xu6hfOapKEJ4qN6tqknpFcbhyI7nFSkZrmOO3hggRzv2LLEs=
X-Gm-Gg: ASbGnctpPi88PRzscxt+e8QJ1vAL+B87A77+fU152D0iIC/qvuvK0lvCaxVXspS0h+O
	jielZVSpQOeb+Tt6I9e+bc74B9RhhYOwMHikDKY2042t/FXp+9YmAKNzjs8QXM9I15rUsZl47XT
	cZn6e/9Lnn3ONdu+guiX6yxQxdN8PiFlWPao3Ndy+sUUws2Cs5L1saOL1rsxJLhMc4WNV+rtBLX
	Qf8dOtu4DkY6wk3n3NVi2K+XY2eDmNaALBzB89lNhKOLZxlceIqOdOPn2OA0uwUKG+GBizLXTEI
	CMI78BznSarmbwzMmaRrDRCrgV79mlZeYbe0rQNqTzn1
X-Google-Smtp-Source: AGHT+IF44ZngvmvLQTa6/DYd9mBS4nelIO/FTgR44hs+O/p7Fl0s8INvjP10jVJEICLAlDgjE/nKmg==
X-Received: by 2002:a17:907:6d09:b0:ab7:cb84:ecd6 with SMTP id a640c23a62f3a-abb70e0d0ecmr1908734066b.56.1739981279398;
        Wed, 19 Feb 2025 08:07:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc0d0b882sm327791066b.109.2025.02.19.08.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:07:59 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro@bp.renesas.com,
	robh@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 1/5] phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
Date: Wed, 19 Feb 2025 18:07:44 +0200
Message-ID: <20250219160749.1750797-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

It has been observed on the Renesas RZ/G3S SoC that unbinding and binding
the PHY driver leads to role autodetection failures. This issue occurs when
PHY 3 is the first initialized PHY. PHY 3 does not have an interrupt
associated with the USB2_INT_ENABLE register (as
rcar_gen3_int_enable[3] = 0). As a result, rcar_gen3_init_otg() is called
to initialize OTG without enabling PHY interrupts.

To resolve this, add rcar_gen3_is_any_otg_rphy_initialized() and call it in
role_store(), role_show(), and rcar_gen3_init_otg(). At the same time,
rcar_gen3_init_otg() is only called when initialization for a PHY with
interrupt bits is in progress. As a result, the
struct rcar_gen3_phy::otg_initialized is no longer needed.

Fixes: 549b6b55b005 ("phy: renesas: rcar-gen3-usb2: enable/disable independent irqs")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 33 ++++++++++--------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 775f4f973a6c..46afba2fe0dc 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -107,7 +107,6 @@ struct rcar_gen3_phy {
 	struct rcar_gen3_chan *ch;
 	u32 int_enable_bits;
 	bool initialized;
-	bool otg_initialized;
 	bool powered;
 };
 
@@ -320,16 +319,15 @@ static bool rcar_gen3_is_any_rphy_initialized(struct rcar_gen3_chan *ch)
 	return false;
 }
 
-static bool rcar_gen3_needs_init_otg(struct rcar_gen3_chan *ch)
+static bool rcar_gen3_is_any_otg_rphy_initialized(struct rcar_gen3_chan *ch)
 {
-	int i;
-
-	for (i = 0; i < NUM_OF_PHYS; i++) {
-		if (ch->rphys[i].otg_initialized)
-			return false;
+	for (enum rcar_gen3_phy_index i = PHY_INDEX_BOTH_HC; i <= PHY_INDEX_EHCI;
+	     i++) {
+		if (ch->rphys[i].initialized)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static bool rcar_gen3_are_all_rphys_power_off(struct rcar_gen3_chan *ch)
@@ -351,7 +349,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	if (sysfs_streq(buf, "host"))
@@ -389,7 +387,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -402,6 +400,9 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
+	if (!ch->is_otg_channel || rcar_gen3_is_any_otg_rphy_initialized(ch))
+		return;
+
 	/* Should not use functions of read-modify-write a register */
 	val = readl(usb2_base + USB2_LINECTRL1);
 	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
@@ -465,12 +466,9 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
 	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 
-	/* Initialize otg part */
-	if (channel->is_otg_channel) {
-		if (rcar_gen3_needs_init_otg(channel))
-			rcar_gen3_init_otg(channel);
-		rphy->otg_initialized = true;
-	}
+	/* Initialize otg part (only if we initialize a PHY with IRQs). */
+	if (rphy->int_enable_bits)
+		rcar_gen3_init_otg(channel);
 
 	rphy->initialized = true;
 
@@ -486,9 +484,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 
 	rphy->initialized = false;
 
-	if (channel->is_otg_channel)
-		rphy->otg_initialized = false;
-
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val &= ~rphy->int_enable_bits;
 	if (!rcar_gen3_is_any_rphy_initialized(channel))
-- 
2.43.0


