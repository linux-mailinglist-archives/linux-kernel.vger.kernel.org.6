Return-Path: <linux-kernel+bounces-441373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA839ECD61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B58216980F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FEC237FE4;
	Wed, 11 Dec 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jEIpsvKA"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DE232373
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924169; cv=none; b=T04YtjRvvx7J9yniVUUbiFB35J0BsJ/9iDoNeZHoOnPpWTMawItBsqIJxYtOf8nq6cxnsDEwnpDA90inZyS3hlofQLjkZiezsj41pliogflldnHddW9dyCM99ilxfb+mESP5JV6i+UPQxHI3UOst+DQHjHVvKuNmnbybH0uYp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924169; c=relaxed/simple;
	bh=a/pk9P9MXP/B+InfwR7X0rVvqzmIRGeIc4K77vEhDvw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O65r1Z/e6Actrqr6CHtGamkaGA3PAZ7keqQdv9kYLQMw3N126IFfWV4rKWm81Hijblk/oZJH0+lkCs33m/pIZZqbf6TmdmtfRmda3i/GGzwepwhQn/f3Vb7A8Qc95xEbRnVBrIRVGMfGGodG2ovVqWgVbu0xukv9TXjfcE4gSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jEIpsvKA; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB70bTH029297;
	Wed, 11 Dec 2024 07:36:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=md/dShEHaO2tkYvC
	90MzQhmmQ2T49m01zRwOk6WIcNY=; b=jEIpsvKAVpicJnByBwdYgOmj7VFMy89G
	BKs+6t7ZGTswdM4z4opvZCBQDuwWZ2f0oeCjQaLXTof5p4dsg7hYFVdruCLHfvaW
	1ScUrsdq2qxCfUAItCDIfPyA9haXuc6+jdsTAE8cJm0JKmjJqOSWwxOTf4mAfLs0
	SuJpNQPF/gL5PMqw+MEj1E/AdF8L5LOW7EFISCdXk6bz39RtcujrUFbD7LbxT13B
	l8fbjjhXoa3Sj4UoZSclNUFf/SnAXMCbrIPcRULetesdMbts+jy0IGsft/RDjcc8
	Ap0MQSTYL+EqIuICAJztRGZNpnv0eAqg06/yblCTH3cDjKuXGvjrLQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43cmn251s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 07:36:01 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Wed, 11 Dec
 2024 13:35:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Wed, 11 Dec 2024 13:35:59 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0670B82254D;
	Wed, 11 Dec 2024 13:35:59 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] regmap: regmap_multi_reg_read(): make register list const
Date: Wed, 11 Dec 2024 13:35:58 +0000
Message-ID: <20241211133558.884669-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6hylRUZnP48Ib-jkrcFBbyedazw69SJF
X-Proofpoint-ORIG-GUID: 6hylRUZnP48Ib-jkrcFBbyedazw69SJF
X-Proofpoint-Spam-Reason: safe

Mark the list of registers passed into regmap_multi_reg_read() as a
pointer to const. This allows the caller to define the register list
as const data.

This requires making the same change to _regmap_bulk_read(), which is
called by regmap_multi_reg_read().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 4 ++--
 include/linux/regmap.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ff37701b6d6c..f2843f814675 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -3115,7 +3115,7 @@ int regmap_fields_read(struct regmap_field *field, unsigned int id,
 EXPORT_SYMBOL_GPL(regmap_fields_read);
 
 static int _regmap_bulk_read(struct regmap *map, unsigned int reg,
-			     unsigned int *regs, void *val, size_t val_count)
+			     const unsigned int *regs, void *val, size_t val_count)
 {
 	u32 *u32 = val;
 	u16 *u16 = val;
@@ -3209,7 +3209,7 @@ EXPORT_SYMBOL_GPL(regmap_bulk_read);
  * A value of zero will be returned on success, a negative errno will
  * be returned in error cases.
  */
-int regmap_multi_reg_read(struct regmap *map, unsigned int *regs, void *val,
+int regmap_multi_reg_read(struct regmap *map, const unsigned int *regs, void *val,
 			  size_t val_count)
 {
 	if (val_count == 0)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index fd41baccbf3e..3871c74f7677 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1244,7 +1244,7 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 		      void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
-int regmap_multi_reg_read(struct regmap *map, unsigned int *reg, void *val,
+int regmap_multi_reg_read(struct regmap *map, const unsigned int *reg, void *val,
 			  size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 			    unsigned int mask, unsigned int val,
-- 
2.39.5


