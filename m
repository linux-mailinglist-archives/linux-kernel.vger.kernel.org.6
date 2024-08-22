Return-Path: <linux-kernel+bounces-297485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C795B91C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D5B28672C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A401CC178;
	Thu, 22 Aug 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TRUGfsK8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE41CB329;
	Thu, 22 Aug 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338543; cv=none; b=tJRTinUyyzxNvzs+LIBfAj+QM2AbRdu/k6iifksYfIqF/OEES+qveGTP43OmuAQmXjxPEznJqJdrr+SOl5/DEt+fbme2mu5M9K1aEvzVuW6vaGSH1CaAntff5x6n6PHb+NhqlYsBECsP+3K3iP1wf/JQcCYfKkewqX6Kr5CSwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338543; c=relaxed/simple;
	bh=zH6rG0oJh5l6WZBwxmOV4UVRzizh6K6xQrAqQ2aysDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eY7WYLF4HysQtAYKKTGhxu36jXP1ttHi381/FdJBlN30Iy5UFc2fSJgSc8rNcY2w0dm3cefipUZqHya8pKWZ5oEpGvq3SaOAhxwCnyMl1RVe/ntRIC6x3OtCQMdsr3JAvgOh3C2OwFXUIpD96ThOKTio1XGH2kzmfgosIxX+7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TRUGfsK8; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEJ365019841;
	Thu, 22 Aug 2024 09:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=4+Sz9yjJhiRIV11e
	yx/ilwSbY3eKJY/WxVIPtCZbYpg=; b=TRUGfsK8l2U4Z1V6EIPnwFS/QUMi8fO+
	Y5dgkkN5ybQPiFFEc2KSf7lsqeaX6V2lCQ9T6j9asX/Xu04DunyIdGbVebPFC4/S
	SIydPge9CQxT0YtiJzN3txkvge/XOzmzaVnUBiYGTP8beg9dr64+Z89l8Qnv870G
	kn7ZWh/XTeiKosNfO9IsqfdH2a+/5bdcwBQAdSEO01jbSXUVIvm/k9Tzuy74Yvfq
	uEoN9yH5uPQ/qgjDzo98NgPKs3gbNfyaFL0weT94kdadOLNzSc/553qZ7Wt2cBPX
	TsaCE976JDANJsGTUIfCqtTIGi0Dba07NZhfat9XnTnLiekGUFrz8A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 412r9hwwcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 09:55:37 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 Aug
 2024 15:55:36 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 22 Aug 2024 15:55:35 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DF524820244;
	Thu, 22 Aug 2024 14:55:35 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Make struct regmap_config const
Date: Thu, 22 Aug 2024 15:55:35 +0100
Message-ID: <20240822145535.336407-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 571aD0sItkqQmmXif9ZBrqs6H-E-lUC0
X-Proofpoint-ORIG-GUID: 571aD0sItkqQmmXif9ZBrqs6H-E-lUC0
X-Proofpoint-Spam-Reason: safe

It's now possible to declare instances of struct regmap_config as
const data.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           | 6 +++---
 sound/soc/codecs/cs35l56-shared.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index a51acefa785f..94e8185c4795 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -282,9 +282,9 @@ static inline bool cs35l56_is_otp_register(unsigned int reg)
 	return (reg >> 16) == 3;
 }
 
-extern struct regmap_config cs35l56_regmap_i2c;
-extern struct regmap_config cs35l56_regmap_spi;
-extern struct regmap_config cs35l56_regmap_sdw;
+extern const struct regmap_config cs35l56_regmap_i2c;
+extern const struct regmap_config cs35l56_regmap_spi;
+extern const struct regmap_config cs35l56_regmap_sdw;
 
 extern const struct cirrus_amp_cal_controls cs35l56_calibration_controls;
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index bd74fef33d49..ae286ba3be1d 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -925,7 +925,7 @@ const unsigned int cs35l56_tx_input_values[] = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_tx_input_values, SND_SOC_CS35L56_SHARED);
 
-struct regmap_config cs35l56_regmap_i2c = {
+const struct regmap_config cs35l56_regmap_i2c = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
@@ -941,7 +941,7 @@ struct regmap_config cs35l56_regmap_i2c = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_regmap_i2c, SND_SOC_CS35L56_SHARED);
 
-struct regmap_config cs35l56_regmap_spi = {
+const struct regmap_config cs35l56_regmap_spi = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.pad_bits = 16,
@@ -958,7 +958,7 @@ struct regmap_config cs35l56_regmap_spi = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_regmap_spi, SND_SOC_CS35L56_SHARED);
 
-struct regmap_config cs35l56_regmap_sdw = {
+const struct regmap_config cs35l56_regmap_sdw = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.39.2


