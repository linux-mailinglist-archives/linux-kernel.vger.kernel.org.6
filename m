Return-Path: <linux-kernel+bounces-333626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CE797CB90
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206751C23AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237419994B;
	Thu, 19 Sep 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="j0YoRPa8"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A641EF1D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726759273; cv=none; b=CRcI+JJ56FQ7TPdOzmpu5/1qZeyyV40pkYc++hy+ieO0GJchq45sbVwyDFWReSi91+E3ij4EUf1/QpnHrcWW6JlrnSJgS+t/UGjbNbtxb7eH2dofLdKknnCIeZqePaAHCnYwHZRETmHX/nOWbkczt39IZgTi9xVpJXz8eWFjs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726759273; c=relaxed/simple;
	bh=ba2TAi2tR0SuQFs7sr43Bx+L6d2cJFSg4rHFf0Q/4DU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nifEpvZ7SCX44Wxt/k9IRnv0Wg2vOXV+kfSGgzVAftqQ6HpMQRp++3o0jRpiDc3cizF3mWgS9qFvGeNIaouqv30xl/Rqc9pZi7jHMafXb4LNlx7LRhuckhvJfR0npkoU3ndukrTENcYFBbWLQCM9QQ5JHo970L/hTaYES/N/y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=j0YoRPa8; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JEPQHB023219;
	Thu, 19 Sep 2024 10:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=baelYAyAIIoXLLAW
	vPDu8R5un3ZAOjFgdb44s4mMjx8=; b=j0YoRPa8011hGxzhRx0CLDYtFeNYNrka
	Xx7CofxzE91mIHpl6r+jfRpyQYqaGN4jCvGozFYo37NR3rXU4wPyfZ4Egl1z9k3w
	2qY8IqKS2K3gFsetwCoax3S7ErR2JfsqVT+2PswMqp2MqsMaf192mEnqSaXXrmcE
	W0q32om6T7l/6rA6kc3s+8UBJEayhdVQDk52atXz4fHzr/SJPOcxcffrejzdnML0
	uVSTPMOjLIDRi3NM6uKbjgRwYSdYGEY3qKd2/heOiSUDHIYblDmgF2cjDKWGkjME
	AB/xByMCwa9/+KfUCzGRisDbpdrElySJgYIuip6jQV8AF6ZDMl8VCA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 41n7vy6bjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 10:17:07 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Sep
 2024 16:17:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 19 Sep 2024 16:17:05 +0100
Received: from ausswws06.ad.cirrus.com (ausswws06.ad.cirrus.com [141.131.145.166])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 216D2820248;
	Thu, 19 Sep 2024 15:17:04 +0000 (UTC)
From: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Ricardo Rivera-Matos
	<rriveram@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l45: Corrects cs35l45_get_clk_freq_id function data type
Date: Thu, 19 Sep 2024 15:16:52 +0000
Message-ID: <20240919151654.197337-1-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Z4Iae62f-M4zJT7xEVGP1D4UYNnxK-yC
X-Proofpoint-GUID: Z4Iae62f-M4zJT7xEVGP1D4UYNnxK-yC
X-Proofpoint-Spam-Reason: safe

Changes cs35l45_get_clk_freq_id() function data type from unsigned int
to int. This function is returns a positive index value if successful
or a negative error code if unsuccessful.

Functionally there should be no difference as long as the unsigned int
return is interpreted as an int, however it should be corrected for
readability.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45-tables.c | 2 +-
 sound/soc/codecs/cs35l45.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l45-tables.c b/sound/soc/codecs/cs35l45-tables.c
index e1cebb9e4dc6..405dab137b3b 100644
--- a/sound/soc/codecs/cs35l45-tables.c
+++ b/sound/soc/codecs/cs35l45-tables.c
@@ -315,7 +315,7 @@ static const struct {
 	{ 0x3B, 24576000 },
 };
 
-unsigned int cs35l45_get_clk_freq_id(unsigned int freq)
+int cs35l45_get_clk_freq_id(unsigned int freq)
 {
 	int i;
 
diff --git a/sound/soc/codecs/cs35l45.h b/sound/soc/codecs/cs35l45.h
index e2ebcf58d7e0..7a790d2acac7 100644
--- a/sound/soc/codecs/cs35l45.h
+++ b/sound/soc/codecs/cs35l45.h
@@ -507,7 +507,7 @@ extern const struct dev_pm_ops cs35l45_pm_ops;
 extern const struct regmap_config cs35l45_i2c_regmap;
 extern const struct regmap_config cs35l45_spi_regmap;
 int cs35l45_apply_patch(struct cs35l45_private *cs35l45);
-unsigned int cs35l45_get_clk_freq_id(unsigned int freq);
+int cs35l45_get_clk_freq_id(unsigned int freq);
 int cs35l45_probe(struct cs35l45_private *cs35l45);
 void cs35l45_remove(struct cs35l45_private *cs35l45);
 
-- 
2.43.0


