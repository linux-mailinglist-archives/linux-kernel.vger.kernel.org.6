Return-Path: <linux-kernel+bounces-405749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3689C568C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA51F25F33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33823098F;
	Tue, 12 Nov 2024 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="H+Jq5HWj"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D325230983
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410683; cv=none; b=CjtnF/sYbk7RmEk6M77qJyPxmBCayLoesKHRf8NSGRa3nRnty4/jHKUiTOO+oyzpiO1CIE67fsd3FPZwXqx+t3tqu3yv9HybAljyK2YgdWr2lTfCk25tDuevCiZSBUlrOq/gsFTkY6cSA2EgZTDyc8Wyef+KBIoTTXKzD/rM1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410683; c=relaxed/simple;
	bh=rYcfWFa3y1MajmizGspa7163Ze//5DahTlMy0SEO1oM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IatqmHVVLAz65q6N30QaTwIRgPACg7dKRnpR5kJadozVex5CqRCWAY4D0jIoH6wHvPbhte87Sm5xR+5eEb71Uf79zNXr+EXXUUHiQnwqCPgumu3sfjvMyX4hhq++4uElexDptX4XOHjfIVb//IrytsGgomMsAGKg6Q6FDq0dBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=H+Jq5HWj; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC5x7VG011795;
	Tue, 12 Nov 2024 05:12:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=BechRI5emhRZmmd+
	5E4HtPP3rZ9Imf4cpdqemtYm3L8=; b=H+Jq5HWjRHFbQo949ig8xeuKT2jzwfIW
	aGnoZqPmd+/QfawidW31yBky8eCQodueOpYzWbzmFyJhfWejiZ0RJYehE30Nkpdu
	N9yck1rIvRAuapnJYsabqOqT1WPAAyoKWchDqMfwS+XiUtSoabcbNf87wgUXvmbW
	V4/Bax4l/Xdam8RcdvC3ZRJBCuLb7mucycEmE8OhBOUTp2zdtRnt7P5UpUvPQixA
	eePrTjUbuKjKKmMNY5PFhzWeiFtX6bIOc5hJjfAeIHP0wMe0kahh7ZfPsqp27X1v
	6prfhiGyEraJCytydlOCY8a0UT8GEsoL1CYFfUCN0cSceORUga4Pzw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42t51p31xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 05:12:32 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 11:12:30 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 12 Nov 2024 11:12:30 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A2D89820257;
	Tue, 12 Nov 2024 11:12:30 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: cs42l43: Use gpiod_set_raw for GPIO operations
Date: Tue, 12 Nov 2024 11:12:30 +0000
Message-ID: <20241112111230.580086-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UXvKwWe5etRGhwytYFttR-Pn-PQEPYa2
X-Proofpoint-ORIG-GUID: UXvKwWe5etRGhwytYFttR-Pn-PQEPYa2
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
index e5f17fc430e48..60e53b7903d5d 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -982,7 +982,7 @@ static int cs42l43_power_up(struct cs42l43 *cs42l43)
 	/* vdd-p must be on for 50uS before any other supply */
 	usleep_range(CS42L43_VDDP_DELAY_US, 2 * CS42L43_VDDP_DELAY_US);
 
-	gpiod_set_value_cansleep(cs42l43->reset, 1);
+	gpiod_set_raw_value_cansleep(cs42l43->reset, 1);
 
 	ret = regulator_bulk_enable(CS42L43_N_SUPPLIES, cs42l43->core_supplies);
 	if (ret) {
@@ -1003,7 +1003,7 @@ static int cs42l43_power_up(struct cs42l43 *cs42l43)
 err_core_supplies:
 	regulator_bulk_disable(CS42L43_N_SUPPLIES, cs42l43->core_supplies);
 err_reset:
-	gpiod_set_value_cansleep(cs42l43->reset, 0);
+	gpiod_set_raw_value_cansleep(cs42l43->reset, 0);
 	regulator_disable(cs42l43->vdd_p);
 
 	return ret;
@@ -1025,7 +1025,7 @@ static int cs42l43_power_down(struct cs42l43 *cs42l43)
 		return ret;
 	}
 
-	gpiod_set_value_cansleep(cs42l43->reset, 0);
+	gpiod_set_raw_value_cansleep(cs42l43->reset, 0);
 
 	ret = regulator_disable(cs42l43->vdd_p);
 	if (ret) {
@@ -1050,11 +1050,13 @@ int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 
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


