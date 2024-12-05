Return-Path: <linux-kernel+bounces-433172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A799E54BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85266162D07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF8214A75;
	Thu,  5 Dec 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MeBDCDWy"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869C191F94
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399910; cv=none; b=JFZi4iKPINFIFDRlmhzxuhDtoPnXEgD1qqB2ApDEiG+3tzc8yVmKMghCAu4lRTT/J4dg7qga5Hw0WCWavzbpz+PYYVWJO1p/BlaBz7h5QmJG8BfoMA5XdU4bjNoq1bfT4jtLhpv/xPQIXBVHXSWqsSFrfg63Hi3npe/UXKImq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399910; c=relaxed/simple;
	bh=/AmEQYrRRuLa1gTXogXEiifLAxlKDNIQJdaMFmq3WeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fww+KrRUULQ+/jYNtXxikyxFy0JuAf3o1kiGbT14XDzXRTt4UuIPTHaZQi9TJFGfBw3cIz4AhIf6aGqbDubkQqvLfb1Q9ydrBFatCZMQi6MYHF0BF9ZsLUCTjM7wFY8NSrUniGafedH4EMrS+VeAPJm5L5jWrjaxqVkWtdrojxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MeBDCDWy; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B570HfX016009;
	Thu, 5 Dec 2024 05:58:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=KkJ4rwPdOb+nRofZEOYwczHMRVxPIcgNMZOyi0r3vQs=; b=
	MeBDCDWyWcdTGXIijDnv03I4AoCXA9gSSyOrTFxr2WIbAdsjePW9+Es2hhsxNRW+
	VMgnjbszWpvob2h9lX8Xhe6XtRYBX+MX8VeY7AxJ30W8qEhgJHeHMjm7SD2zgq4G
	awU3r7El+dlJucs7wrGtYddJmIkh2HI3hiFCqfY8e+baVygmBliJtFF2WMfBT52f
	M9+lvVRXqtELf3laKmIyhjcjekfkZgqnXiU7fRA6wFMgnnK6UcMVVUyky3xh/vQ3
	5zCF2SeRiZTKa96ed84s4ffXgy7xrFqybEh19sZbhCrbhnLFztiVEvw/8E4/6v0a
	e6xCeCgGfudgZkoHpo/VVA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4381022c8a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 05:58:25 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 5 Dec
 2024 11:58:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 5 Dec 2024 11:58:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C668782024D;
	Thu,  5 Dec 2024 11:58:22 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 4/4] mfd: cs42l43: Use devres for remove as well
Date: Thu, 5 Dec 2024 11:58:22 +0000
Message-ID: <20241205115822.2371719-4-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: V2WN4q8_u7KtD6zuPVKTMM6GNpXeIE0N
X-Proofpoint-ORIG-GUID: V2WN4q8_u7KtD6zuPVKTMM6GNpXeIE0N
X-Proofpoint-Spam-Reason: safe

Currently the device is powered down in the remove callback, however
all other clean up is done through devres. The problem here is the
MFD children are cleaned up through devres. As this happens after
the remove callback has run, this leads to the incorrect ordering
where the child remove functions run after the device has been powered
down. Put the power down into devres as well such that everything runs
in the expected order.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43-i2c.c |  8 --------
 drivers/mfd/cs42l43-sdw.c | 10 ----------
 drivers/mfd/cs42l43.c     | 21 +++++++++++++--------
 drivers/mfd/cs42l43.h     |  1 -
 4 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/cs42l43-i2c.c b/drivers/mfd/cs42l43-i2c.c
index c9e4ea76149a..1e6422cdf012 100644
--- a/drivers/mfd/cs42l43-i2c.c
+++ b/drivers/mfd/cs42l43-i2c.c
@@ -56,13 +56,6 @@ static int cs42l43_i2c_probe(struct i2c_client *i2c)
 	return cs42l43_dev_probe(cs42l43);
 }
 
-static void cs42l43_i2c_remove(struct i2c_client *i2c)
-{
-	struct cs42l43 *cs42l43 = dev_get_drvdata(&i2c->dev);
-
-	cs42l43_dev_remove(cs42l43);
-}
-
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id cs42l43_of_match[] = {
 	{ .compatible = "cirrus,cs42l43", },
@@ -88,7 +81,6 @@ static struct i2c_driver cs42l43_i2c_driver = {
 	},
 
 	.probe		= cs42l43_i2c_probe,
-	.remove		= cs42l43_i2c_remove,
 };
 module_i2c_driver(cs42l43_i2c_driver);
 
diff --git a/drivers/mfd/cs42l43-sdw.c b/drivers/mfd/cs42l43-sdw.c
index 65f7b1d78248..6af8465b2099 100644
--- a/drivers/mfd/cs42l43-sdw.c
+++ b/drivers/mfd/cs42l43-sdw.c
@@ -187,15 +187,6 @@ static int cs42l43_sdw_probe(struct sdw_slave *sdw, const struct sdw_device_id *
 	return cs42l43_dev_probe(cs42l43);
 }
 
-static int cs42l43_sdw_remove(struct sdw_slave *sdw)
-{
-	struct cs42l43 *cs42l43 = dev_get_drvdata(&sdw->dev);
-
-	cs42l43_dev_remove(cs42l43);
-
-	return 0;
-}
-
 static const struct sdw_device_id cs42l43_sdw_id[] = {
 	SDW_SLAVE_ENTRY(0x01FA, 0x4243, 0),
 	{}
@@ -209,7 +200,6 @@ static struct sdw_driver cs42l43_sdw_driver = {
 	},
 
 	.probe		= cs42l43_sdw_probe,
-	.remove		= cs42l43_sdw_remove,
 	.id_table	= cs42l43_sdw_id,
 	.ops		= &cs42l43_sdw_ops,
 };
diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 9572c7fd419a..beb63c4efd21 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1038,6 +1038,15 @@ static int cs42l43_power_down(struct cs42l43 *cs42l43)
 	return 0;
 }
 
+static void cs42l43_dev_remove(void *data)
+{
+	struct cs42l43 *cs42l43 = data;
+
+	cancel_work_sync(&cs42l43->boot_work);
+
+	cs42l43_power_down(cs42l43);
+}
+
 int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 {
 	int i, ret;
@@ -1084,6 +1093,10 @@ int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(cs42l43->dev, cs42l43_dev_remove, cs42l43);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_autosuspend_delay(cs42l43->dev, CS42L43_AUTOSUSPEND_TIME_MS);
 	pm_runtime_use_autosuspend(cs42l43->dev);
 	pm_runtime_set_active(cs42l43->dev);
@@ -1102,14 +1115,6 @@ int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 }
 EXPORT_SYMBOL_NS_GPL(cs42l43_dev_probe, MFD_CS42L43);
 
-void cs42l43_dev_remove(struct cs42l43 *cs42l43)
-{
-	cancel_work_sync(&cs42l43->boot_work);
-
-	cs42l43_power_down(cs42l43);
-}
-EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
-
 static int cs42l43_suspend(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
diff --git a/drivers/mfd/cs42l43.h b/drivers/mfd/cs42l43.h
index 8d1b1b0f5a47..f3da783930f5 100644
--- a/drivers/mfd/cs42l43.h
+++ b/drivers/mfd/cs42l43.h
@@ -25,6 +25,5 @@ bool cs42l43_precious_register(struct device *dev, unsigned int reg);
 bool cs42l43_volatile_register(struct device *dev, unsigned int reg);
 
 int cs42l43_dev_probe(struct cs42l43 *cs42l43);
-void cs42l43_dev_remove(struct cs42l43 *cs42l43);
 
 #endif /* CS42L43_CORE_INT_H */
-- 
2.39.5


