Return-Path: <linux-kernel+bounces-575130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E8CA6EDDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622B2168C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC0F254B09;
	Tue, 25 Mar 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g7goroyq"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA741D7E37
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899008; cv=none; b=VSXSmxiLO3IX6YhN1U2u6mrczHHVO4rEq6PXTWLi4jXpvtme+wKLclp0RRmf0PhsN0ZYKrf4s3RqoflFZhB59JeJv6WZ+e8UboGX72LPuUbwdjPXxQb1VMhIqjzIii5e7o9e6tkCpgQihlwWo2xEQcgts1mTtw63a4/N9qlc0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899008; c=relaxed/simple;
	bh=U9X3tzPT7BQe+BlJQO2hC0MSCjvawwWLAxcaRfrpyys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CJpjai2sQs9B4RuRnJsPshtBXkyX5VKh1m6SdP0yhUT7pX3D9IcKzBO1d7+j69+DwBvmM0V5iAHYRLuoffZwkssXXyVoDB8YJec9rDK/85d8HNdNuaIeVv/Ta5Du9EsGK6ZIvXuS30CwNc/qU8zNvS9WqlDOhh7QgO1xEwBqSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g7goroyq; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52PAaLob1212930
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 25 Mar 2025 05:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742898981;
	bh=QZzVl2bgbkhshmlS+4PPDIcVCBo3+7gB4Z4ciwuH+U0=;
	h=From:To:CC:Subject:Date;
	b=g7goroyq828zgwWjNqWnHDv5XOlqdYxtCTpcgxhIs9pEU41E8xwsgeIdZ41c3U6GG
	 ANvr6Ax+M+YSBBjUedYrNsV77LCSnx90yKJYolVSRe+nA5UIeqOAbn1nXnmlYm4D8U
	 ikvzjvheU0v2cNrStsU834cm7rQG2uepwMVhM1Zs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52PAaLY7064974;
	Tue, 25 Mar 2025 05:36:21 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Mar 2025 05:36:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Mar 2025 05:36:21 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.197])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52PAaGDo036326;
	Tue, 25 Mar 2025 05:36:17 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <baojun.xu@ti.com>,
        <Baojun.Xu@fpt.com>, <robinchen@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Support dsp firmware Alpha and Beta seaies
Date: Tue, 25 Mar 2025 18:36:12 +0800
Message-ID: <20250325103612.2021-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For calibration data, basic version firmware does not contain any
calibration addresses, it depends on calibration tool to convey the
addresses to the driver. Since Alpha and Beta firmware, all the
calibration addresses are saved into the firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Add updating calibration addresses code into tas2781_apply_calib in
   case of Alpha and Beta firmware.
---
 sound/pci/hda/tas2781_hda_i2c.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 50c5e5f26589..cb3d683013d9 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -558,28 +558,38 @@ static int tas2563_save_calibration(struct tasdevice_priv *tas_priv)
 
 static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 {
-	static const unsigned char page_array[CALIB_MAX] = {
-		0x17, 0x18, 0x18, 0x13, 0x18,
+	struct calidata *cali_data = &tas_priv->cali_data;
+	struct cali_reg *r = &cali_data->cali_reg_array;
+	unsigned int cali_reg[CALIB_MAX] = {
+		TASDEVICE_REG(0, 0x17, 0x74),
+		TASDEVICE_REG(0, 0x18, 0x0c),
+		TASDEVICE_REG(0, 0x18, 0x14),
+		TASDEVICE_REG(0, 0x13, 0x70),
+		TASDEVICE_REG(0, 0x18, 0x7c),
 	};
-	static const unsigned char rgno_array[CALIB_MAX] = {
-		0x74, 0x0c, 0x14, 0x70, 0x7c,
-	};
-	int offset = 0;
 	int i, j, rc;
+	int oft = 0;
 	__be32 data;
 
+	if (tas_priv->dspbin_typ != TASDEV_BASIC) {
+		cali_reg[0] = r->r0_reg;
+		cali_reg[1] = r->invr0_reg;
+		cali_reg[2] = r->r0_low_reg;
+		cali_reg[3] = r->pow_reg;
+		cali_reg[4] = r->tlimit_reg;
+	}
+
 	for (i = 0; i < tas_priv->ndev; i++) {
 		for (j = 0; j < CALIB_MAX; j++) {
 			data = cpu_to_be32(
-				*(uint32_t *)&tas_priv->cali_data.data[offset]);
+				*(uint32_t *)&tas_priv->cali_data.data[oft]);
 			rc = tasdevice_dev_bulk_write(tas_priv, i,
-				TASDEVICE_REG(0, page_array[j], rgno_array[j]),
-				(unsigned char *)&data, 4);
+				cali_reg[j], (unsigned char *)&data, 4);
 			if (rc < 0)
 				dev_err(tas_priv->dev,
 					"chn %d calib %d bulk_wr err = %d\n",
 					i, j, rc);
-			offset += 4;
+			oft += 4;
 		}
 	}
 }
-- 
2.34.1


