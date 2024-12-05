Return-Path: <linux-kernel+bounces-433174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B99E54BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC94282982
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692D214A62;
	Thu,  5 Dec 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HtYm+u6O"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A932191F94
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399916; cv=none; b=X96fczV0BtQsrXYfoOyI+0nd7cjNIwjn8Y+J1YJJBNqAWrfqDEMGCzSEw7RHF80bbtE69l7z0EBRepiLk73pnSdW2PSmuyyVJl0LxK9NaW+OtAdmVOo8MMOofMX9Lvw3TBODMdR9/B3t/gSKEIW2zeOkquS8X3PGvaoQuUkWZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399916; c=relaxed/simple;
	bh=i4zVvJpEomHXRqOZi9AAuiGwA+iS5ufm1jDfkkTyH/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iW3muK72/C0IuJQ8WUI9mu4zXc5Rh7ofyHSa7lsFNrd9rweCxleCddWA1yWEfWOlZ8auN3PByWtpXbksQceQcPyPlUe+pMAASxSuSgiLzIU4jWz0Bhpiq2RzQ4X1t/0yVh6U4vb7dNded03b+3UujgVleWSxu3qzES9p+er8JdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HtYm+u6O; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B54s2Gi025157;
	Thu, 5 Dec 2024 05:58:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zPDLLeiVnyPbWEwk8LJA4B8xfjU9WGyPKWtfNPzBD04=; b=
	HtYm+u6OVBiuQb4R+5G941RMhQVcznnEzY6x+0gDQw77cLsb1uJGtXRa/M/NR6Ha
	Aqd076BYbQdBPNv0GMr3hC9ASkHbxq/B11Xahl0rQNsFZXo6NthDa4w4b2EllWFx
	K7g2F62YEXD302KPHecXcXbDrxmDnjBYft06SOJy9jEA6u1i9Kr5C4lAoIawI623
	CTY7OkarXaWYSMnJW7kZuE+O5n46wUeXfqcCUc8gYs4JlZTRmD9xcDHJQhlbgNEi
	+CUW641TIHlXz1vFpYZXb5tuxAKlM77tHmgpyLvoLuioFE4vLpmROmybrvX5gm6j
	NAQqrhbAICiHBWTLldP0RQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43ap2b9qeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 05:58:24 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 5 Dec
 2024 11:58:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 5 Dec 2024 11:58:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AC8B882024B;
	Thu,  5 Dec 2024 11:58:22 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH RESEND 2/4] mfd: cs42l43: Use gpiod_set_raw for GPIO operations
Date: Thu, 5 Dec 2024 11:58:20 +0000
Message-ID: <20241205115822.2371719-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205115822.2371719-1-ckeepax@opensource.cirrus.com>
References: <20241205115822.2371719-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9YcquYRURS7K3RD8Pwp-g6UM1p3YaXdb
X-Proofpoint-ORIG-GUID: 9YcquYRURS7K3RD8Pwp-g6UM1p3YaXdb
X-Proofpoint-Spam-Reason: safe

The GPIO framework supports specifying if a GPIO is active low or
high and will invert accordingly. Whilst specifying this is part of
the normal GPIO definition flow on device tree systems, it is a DSD
extension under ACPI, that Windows doesn't really use. This means most
ACPI systems do not set the polarity of the pin.

The current cs42l43 driver assumes it is setting the level of the line
directly, which is actually the case on all current systems and likely
most future ones. However if the part was used in a device tree system
or an ACPI system that actually used the DSD extensions this would get
inverted, causing the driver to fail probe. As the driver always knows
the polarity of its own reset line, use the raw set API making the
intention to set the level directly clear and to avoid any such future
issues.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 11a1b7f1e121..167d4060b230 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -984,7 +984,7 @@ static int cs42l43_power_up(struct cs42l43 *cs42l43)
 	/* vdd-p must be on for 50uS before any other supply */
 	usleep_range(CS42L43_VDDP_DELAY_US, 2 * CS42L43_VDDP_DELAY_US);
 
-	gpiod_set_value_cansleep(cs42l43->reset, 1);
+	gpiod_set_raw_value_cansleep(cs42l43->reset, 1);
 
 	ret = regulator_bulk_enable(CS42L43_N_SUPPLIES, cs42l43->core_supplies);
 	if (ret) {
@@ -1005,7 +1005,7 @@ static int cs42l43_power_up(struct cs42l43 *cs42l43)
 err_core_supplies:
 	regulator_bulk_disable(CS42L43_N_SUPPLIES, cs42l43->core_supplies);
 err_reset:
-	gpiod_set_value_cansleep(cs42l43->reset, 0);
+	gpiod_set_raw_value_cansleep(cs42l43->reset, 0);
 	regulator_disable(cs42l43->vdd_p);
 
 	return ret;
@@ -1027,7 +1027,7 @@ static int cs42l43_power_down(struct cs42l43 *cs42l43)
 		return ret;
 	}
 
-	gpiod_set_value_cansleep(cs42l43->reset, 0);
+	gpiod_set_raw_value_cansleep(cs42l43->reset, 0);
 
 	ret = regulator_disable(cs42l43->vdd_p);
 	if (ret) {
@@ -1052,11 +1052,13 @@ int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 
 	regcache_cache_only(cs42l43->regmap, true);
 
-	cs42l43->reset = devm_gpiod_get_optional(cs42l43->dev, "reset", GPIOD_OUT_LOW);
+	cs42l43->reset = devm_gpiod_get_optional(cs42l43->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(cs42l43->reset))
 		return dev_err_probe(cs42l43->dev, PTR_ERR(cs42l43->reset),
 				     "Failed to get reset\n");
 
+	gpiod_set_raw_value_cansleep(cs42l43->reset, 0);
+
 	cs42l43->vdd_p = devm_regulator_get(cs42l43->dev, "vdd-p");
 	if (IS_ERR(cs42l43->vdd_p))
 		return dev_err_probe(cs42l43->dev, PTR_ERR(cs42l43->vdd_p),
-- 
2.39.5


