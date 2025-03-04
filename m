Return-Path: <linux-kernel+bounces-544332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A555FA4E030
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF69189CF5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D5204C13;
	Tue,  4 Mar 2025 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="T4eM8wzB"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70617583;
	Tue,  4 Mar 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097134; cv=none; b=oFlm7g6dtCJSf2p5tVcvL6tT4kAPG6jILtWyHdQ1cT8brUinB8CbvHLOMB9NesrI1uNXBDT2laRf80fR5zdNiOm/ZzuPLUhM84WDnud6Jgh9yv6eFTb6nlflk5fayyGPdKWs/2x5qgxjidTLDycnNjErKptx7CS6nFJEBL0f9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097134; c=relaxed/simple;
	bh=sD+FYTGd/Iv4+waBDe9Jou1vTCSFrK2mIssv1CG87Ss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FVWKVxi1VOyYA7oEW540mRhSoqoILpNQtNwN7Yre83T3HcYvO0bf3AkC6mGu16V8gWys3kpZfToRMMpmnFt9BxjKOmnqwrgFepTSvW9kfwFg2pI/SjTPguHzjJQBA1Xkf2V4Cfa1J7ROIxE2cfzH8Mmba5+aEklVsxDJ0DwMQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=T4eM8wzB; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HMv003809;
	Tue, 4 Mar 2025 08:05:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=CxPdc0sVJcuHoGRz
	dZ4jUkHGsDiwd7A69fQatlUcZik=; b=T4eM8wzB5WGjHpLzd58fPnCg8ntTC8Hz
	+NDwZLzAO9N2tQeFZ/2OE7D5Qyj+FrFd3UKCkx1Dsz2aQAU279wTrHIGr6qeMc4a
	tQI4AHNql1pxz7Z9ev1DCC+3J0rJtuRY9uQ+UYL3emFb56Y0ApKHMIgf89xIAQ8c
	86laynMINhBSzW/ynF/TMmnoA2Dt1miW+RTPzI1v9sh7NGk4nVXTYn6Kn1GYRUMo
	gH9WZ856CCZ8fk1TOB+F6MzhkE9SkDO+BBSTrXVsf3gj48VRsOewNgVQQdDq2ERu
	0x2gmMebj5so8F0capVqBCW8pF8qn3pjEDfu0/J0LhP+GPu8GfVNag==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:24 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:05 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B0ECE820248;
	Tue,  4 Mar 2025 14:05:05 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Maciej Strozek
	<mstrozek@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l43: Add jack delay debounce after suspend
Date: Tue, 4 Mar 2025 14:05:04 +0000
Message-ID: <20250304140504.139245-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rFo4_YHenBWq8uUbFWNY_UqT7QQE5HKN
X-Proofpoint-ORIG-GUID: rFo4_YHenBWq8uUbFWNY_UqT7QQE5HKN
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708a6 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=JvfFBMRiBjqy9hV9PBMA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Hardware reports jack absent after reset/suspension regardless of jack
state, so introduce an additional delay only in suspension case to allow
proper detection to take place after a short delay.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l43-jack.c | 13 ++++++++++---
 sound/soc/codecs/cs42l43.c      | 15 ++++++++++++++-
 sound/soc/codecs/cs42l43.h      |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index d9ab003e166b..ac19a572fe70 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -167,7 +167,7 @@ int cs42l43_set_jack(struct snd_soc_component *component,
 		autocontrol |= 0x3 << CS42L43_JACKDET_MODE_SHIFT;

 	ret = cs42l43_find_index(priv, "cirrus,tip-fall-db-ms", 500,
-				 NULL, cs42l43_accdet_db_ms,
+				 &priv->tip_fall_db_ms, cs42l43_accdet_db_ms,
 				 ARRAY_SIZE(cs42l43_accdet_db_ms));
 	if (ret < 0)
 		goto error;
@@ -175,7 +175,7 @@ int cs42l43_set_jack(struct snd_soc_component *component,
 	tip_deb |= ret << CS42L43_TIPSENSE_FALLING_DB_TIME_SHIFT;

 	ret = cs42l43_find_index(priv, "cirrus,tip-rise-db-ms", 500,
-				 NULL, cs42l43_accdet_db_ms,
+				 &priv->tip_rise_db_ms, cs42l43_accdet_db_ms,
 				 ARRAY_SIZE(cs42l43_accdet_db_ms));
 	if (ret < 0)
 		goto error;
@@ -764,6 +764,8 @@ void cs42l43_tip_sense_work(struct work_struct *work)
 error:
 	mutex_unlock(&priv->jack_lock);

+	priv->suspend_jack_debounce = false;
+
 	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 }
@@ -771,14 +773,19 @@ void cs42l43_tip_sense_work(struct work_struct *work)
 irqreturn_t cs42l43_tip_sense(int irq, void *data)
 {
 	struct cs42l43_codec *priv = data;
+	unsigned int db_delay = priv->tip_debounce_ms;

 	cancel_delayed_work(&priv->bias_sense_timeout);
 	cancel_delayed_work(&priv->tip_sense_work);
 	cancel_delayed_work(&priv->button_press_work);
 	cancel_work(&priv->button_release_work);

+	// Ensure delay after suspend is long enough to avoid false detection
+	if (priv->suspend_jack_debounce)
+		db_delay += priv->tip_fall_db_ms + priv->tip_rise_db_ms;
+
 	queue_delayed_work(system_long_wq, &priv->tip_sense_work,
-			   msecs_to_jiffies(priv->tip_debounce_ms));
+			   msecs_to_jiffies(db_delay));

 	return IRQ_HANDLED;
 }
diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index d2a2daefc2ec..4257dbefe9dd 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2402,9 +2402,22 @@ static int cs42l43_codec_runtime_resume(struct device *dev)
 	return 0;
 }

+static int cs42l43_codec_runtime_force_suspend(struct device *dev)
+{
+	struct cs42l43_codec *priv = dev_get_drvdata(dev);
+
+	dev_dbg(priv->dev, "Runtime suspend\n");
+
+	priv->suspend_jack_debounce = true;
+
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
 static const struct dev_pm_ops cs42l43_codec_pm_ops = {
 	RUNTIME_PM_OPS(NULL, cs42l43_codec_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_codec_runtime_force_suspend, pm_runtime_force_resume)
 };

 static const struct platform_device_id cs42l43_codec_id_table[] = {
diff --git a/sound/soc/codecs/cs42l43.h b/sound/soc/codecs/cs42l43.h
index 9c144e129535..1cd9d8a71c43 100644
--- a/sound/soc/codecs/cs42l43.h
+++ b/sound/soc/codecs/cs42l43.h
@@ -78,6 +78,8 @@ struct cs42l43_codec {

 	bool use_ring_sense;
 	unsigned int tip_debounce_ms;
+	unsigned int tip_fall_db_ms;
+	unsigned int tip_rise_db_ms;
 	unsigned int bias_low;
 	unsigned int bias_sense_ua;
 	unsigned int bias_ramp_ms;
@@ -95,6 +97,7 @@ struct cs42l43_codec {
 	bool button_detect_running;
 	bool jack_present;
 	int jack_override;
+	bool suspend_jack_debounce;

 	struct work_struct hp_ilimit_work;
 	struct delayed_work hp_ilimit_clear_work;
--
2.34.1


