Return-Path: <linux-kernel+bounces-274773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B0D947C88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48286B21B95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597A13C66A;
	Mon,  5 Aug 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EY1cPy+8"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A213AA36;
	Mon,  5 Aug 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866928; cv=none; b=ZHzxHQL9qDqZKpuFFKFAzIHqSRKmldw8inZCt4y78OYp24RN5FeQiWr/LkIrCiPan2fpJb4gZ1kPp1Mgdt4AJ1spl0LPWXgikvgd16GJXA840jJG9T6eCx2ki/G960UhGANihe5VC30k1PZVBNawPJY6SeyLdMiLCFDuqUq7qQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866928; c=relaxed/simple;
	bh=3XDOoBApCAGlDBSUQ/sssCkZjwHNUxmgYDcy/DjrxVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uxUQJWJCS2YPwcyxgoQRs71qkdo2daemHoK7CJq5IhGiVPY0xxJ6BXa1v2kWTYofH7DhsImmZoj8mkd5cKmdWCLax19bHwsV2AWNSwWj/8e/CH9027pt4ePz0uKpn7OQmYK3DSgqTHD4rDtgi+K1HwjmY1x4P8YcRvBxmbIq/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EY1cPy+8; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4755WG4w021667;
	Mon, 5 Aug 2024 09:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=0LiVHQUoQpbmKSVh
	TQZjFLh3wJkOnEZu3YG/U0vC4YE=; b=EY1cPy+8jx/uP/2HjVekt6U4/pW+fTcp
	MNdrMpF6diD+U6b1Sltk/IB6v8GUeHnSkM8xFL0741X2NDpBgRraLbk216zkqJKd
	047YbGh8XfdGus1Dtq/MlW4Ny1+ze4cBklpBlcj2L42kry3Zd376Gcr0TUurfvBA
	P78RAaenOLCRB4vMEheve81rHvdab/Ezw0Rso/5U7Pghp6qB9uuxOGl1JHk2wWhu
	VliqwwET1tmh7E4yc/O4ksLkzanYHcEZwtya8SF+eU2aVWxtT4iNg+I3pjcOK127
	Qj40VwExrvb2yHAqoODriu6RHgZzCCK7Tqv2FBQkZMJ0EpghiGxoIA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40shxx1vcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 09:08:43 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 15:08:41 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 5 Aug 2024 15:08:41 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5DF45820244;
	Mon,  5 Aug 2024 14:08:41 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Handle OTP read latency over SoundWire
Date: Mon, 5 Aug 2024 15:08:39 +0100
Message-ID: <20240805140839.26042-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IM7KC8jdvoqxcKRwwqvSQO_YHmI_PQDd
X-Proofpoint-ORIG-GUID: IM7KC8jdvoqxcKRwwqvSQO_YHmI_PQDd
X-Proofpoint-Spam-Reason: safe

Use the late-read buffer in the CS35L56 SoundWire interface to
read OTP memory.

The OTP memory has a longer access latency than chip registers
and cannot guarantee to return the data value in the SoundWire
control response if the bus clock is >4.8 MHz. The Cirrus
SoundWire peripheral IP exposes the bridge-to-bus read buffer
and status bits. For a read from OTP the bridge status bits are
polled to wait for the OTP data to be loaded into the read buffer
and the data is then read from there.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e1830f66f6c6 ("ASoC: cs35l56: Add helper functions for amp calibration")
---
 include/sound/cs35l56.h        |  5 +++
 sound/soc/codecs/cs35l56-sdw.c | 77 ++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index a6aa112e5741..a51acefa785f 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -277,6 +277,11 @@ static inline int cs35l56_force_sync_asp1_registers_from_cache(struct cs35l56_ba
 	return 0;
 }
 
+static inline bool cs35l56_is_otp_register(unsigned int reg)
+{
+	return (reg >> 16) == 3;
+}
+
 extern struct regmap_config cs35l56_regmap_i2c;
 extern struct regmap_config cs35l56_regmap_spi;
 extern struct regmap_config cs35l56_regmap_sdw;
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index fc03bb7ecae1..7c9a17fe2195 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -23,6 +23,79 @@
 /* Register addresses are offset when sent over SoundWire */
 #define CS35L56_SDW_ADDR_OFFSET		0x8000
 
+/* Cirrus bus bridge registers */
+#define CS35L56_SDW_MEM_ACCESS_STATUS	0xd0
+#define CS35L56_SDW_MEM_READ_DATA	0xd8
+
+#define CS35L56_SDW_LAST_LATE		BIT(3)
+#define CS35L56_SDW_CMD_IN_PROGRESS	BIT(2)
+#define CS35L56_SDW_RDATA_RDY		BIT(0)
+
+#define CS35L56_LATE_READ_POLL_US	10
+#define CS35L56_LATE_READ_TIMEOUT_US	1000
+
+static int cs35l56_sdw_poll_mem_status(struct sdw_slave *peripheral,
+				       unsigned int mask,
+				       unsigned int match)
+{
+	int ret, val;
+
+	ret = read_poll_timeout(sdw_read_no_pm, val,
+				(val < 0) || ((val & mask) == match),
+				CS35L56_LATE_READ_POLL_US, CS35L56_LATE_READ_TIMEOUT_US,
+				false, peripheral, CS35L56_SDW_MEM_ACCESS_STATUS);
+	if (ret < 0)
+		return ret;
+
+	if (val < 0)
+		return val;
+
+	return 0;
+}
+
+static int cs35l56_sdw_slow_read(struct sdw_slave *peripheral, unsigned int reg,
+				 u8 *buf, size_t val_size)
+{
+	int ret, i;
+
+	reg += CS35L56_SDW_ADDR_OFFSET;
+
+	for (i = 0; i < val_size; i += sizeof(u32)) {
+		/* Poll for bus bridge idle */
+		ret = cs35l56_sdw_poll_mem_status(peripheral,
+						  CS35L56_SDW_CMD_IN_PROGRESS,
+						  0);
+		if (ret < 0) {
+			dev_err(&peripheral->dev, "!CMD_IN_PROGRESS fail: %d\n", ret);
+			return ret;
+		}
+
+		/* Reading LSByte triggers read of register to holding buffer */
+		sdw_read_no_pm(peripheral, reg + i);
+
+		/* Wait for data available */
+		ret = cs35l56_sdw_poll_mem_status(peripheral,
+						  CS35L56_SDW_RDATA_RDY,
+						  CS35L56_SDW_RDATA_RDY);
+		if (ret < 0) {
+			dev_err(&peripheral->dev, "RDATA_RDY fail: %d\n", ret);
+			return ret;
+		}
+
+		/* Read data from buffer */
+		ret = sdw_nread_no_pm(peripheral, CS35L56_SDW_MEM_READ_DATA,
+				      sizeof(u32), &buf[i]);
+		if (ret) {
+			dev_err(&peripheral->dev, "Late read @%#x failed: %d\n", reg + i, ret);
+			return ret;
+		}
+
+		swab32s((u32 *)&buf[i]);
+	}
+
+	return 0;
+}
+
 static int cs35l56_sdw_read_one(struct sdw_slave *peripheral, unsigned int reg, void *buf)
 {
 	int ret;
@@ -48,6 +121,10 @@ static int cs35l56_sdw_read(void *context, const void *reg_buf,
 	int ret;
 
 	reg = le32_to_cpu(*(const __le32 *)reg_buf);
+
+	if (cs35l56_is_otp_register(reg))
+		return cs35l56_sdw_slow_read(peripheral, reg, buf8, val_size);
+
 	reg += CS35L56_SDW_ADDR_OFFSET;
 
 	if (val_size == 4)
-- 
2.39.2


