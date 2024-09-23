Return-Path: <linux-kernel+bounces-335684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C8B97E910
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829A128368C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCC1194A43;
	Mon, 23 Sep 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="VQQIsufD"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A5194AEC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084971; cv=none; b=SyD5kk7sjZwBaeVvzS2yrTCa5Mpu/keM89doYbZn/FflX+vU9vcLpJ+bl6wU1nfwxDKXJSP4WdN3tMkcqAdzSfGcinNZ00NcGLfTa5YQPJjSV13MxfpSq6gmz6mSTrGLiDZ0P59rITf2lU+AaO9C+ztnKyNotp6nVpZF1pGRF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084971; c=relaxed/simple;
	bh=HrHf5lKXxBfWwleBury9QWOagD4///MuoTPyLgstODs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSCgBQWp36Ipz3axg1ETgzZ7+whNhSc8SS42VovJNMxigK4+1bTVlT4biS56GFKLIWwDt+d6Y/EGwJkF9Eh6V/l/uMmRiCOgsF/2IzEe+5qJlsUyZ1s8H6oy4QiEaowKl5aNoviwM65/pAd8+JZOHPh4PtJOIRStdIleFCA8oNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=VQQIsufD reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J95b5sRNsyXM1IQDBXWPB125II8JG3MPC9qqtXz5ZS4=;
  b=VQQIsufDz/Y72bspWYz2Z7O7l6d/Xjf2SlAe06rav0NQMztpBcQRcNBo
   b+1H6Kmz3IPuDvMbVzbGVFwvFiWb98fbwiN5M1P+pLUCpa2j7bORhAB08
   kZBBwUGESHJz1KmbYhNOJZeOIKk0Llt+AOoQk9qYvN/HCrbV7o40xjt2A
   a16Qqc/dq1DBriMS/mKAo6P+xI+baoIv/hbp+pBCCEq3xjazRlJVPWpyu
   5uoxrMyiQNw+uPDFQMbK9gKBo55iKHQ+F8lzvjnd35G8o3hPCJXUzB3wu
   k+7Rl1orJbk1UjVm3lDbOsEavybnODOWD36PH/mYc8bMf7M1Sd61Nbwri
   w==;
X-CSE-ConnectionGUID: dDTE0R7IQy24DE6S+b+3cQ==
X-CSE-MsgGUID: bSSsP4iUTEa6+f0V8XNJfw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Sep 2024 17:49:26 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48N9nL9X009956;
	Mon, 23 Sep 2024 17:49:21 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 17:49:22 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>, Hermes Wu <Hermes.wu@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] drm/bridge: it6505: Add MCCS support
Date: Mon, 23 Sep 2024 17:48:29 +0800
Message-ID: <20240923094826.13471-4-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
References: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPEMAIL1.internal.ite.com.tw (192.168.15.58) To
 TPEMAIL1.internal.ite.com.tw (192.168.15.58)
X-TM-SNTS-SMTP:
	7AD907A668179B66F6455DA4539AD86930ECA0D11160D6878A7B91562EB105102002:8
X-MAIL:mse.ite.com.tw 48N9nL9X009956

From: Hermes Wu <Hermes.wu@ite.com.tw>

Changes in v3:
 -remove non used definition for aux i2x cmd reply

Add Aux-I2C functionality to support MCCS.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 174 +++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 156440c6517e..5aedc5570739 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -125,6 +125,9 @@
 #define REG_AUX_ADR_16_19 0x26
 #define REG_AUX_OUT_DATA0 0x27
 
+#define REG_AUX_I2C_ADR 0x25
+#define REG_AUX_I2C_OP 0x26
+
 #define REG_AUX_CMD_REQ 0x2B
 #define AUX_BUSY BIT(5)
 
@@ -266,6 +269,19 @@
 #define REG_SSC_CTRL1 0x189
 #define REG_SSC_CTRL2 0x18A
 
+#define REG_AUX_USER_CTRL 0x190
+#define EN_USER_AUX BIT(0)
+#define USER_AUX_DONE BIT(1)
+#define AUX_EVENT BIT(4)
+
+#define REG_AUX_USER_DATA_REC 0x191
+#define M_AUX_IN_REC   0xF0
+#define M_AUX_OUT_REC  0x0F
+
+#define REG_AUX_USER_TXB 0x190
+#define REG_AUX_USER_REPLY 0x19A
+#define REG_AUX_USER_RXB(n) (n + 0x19B)
+
 #define RBR DP_LINK_BW_1_62
 #define HBR DP_LINK_BW_2_7
 #define HBR2 DP_LINK_BW_5_4
@@ -301,6 +317,8 @@
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
 #define AUX_FIFO_MAX_SIZE 16
+#define AUX_I2C_MAX_SIZE 4
+#define AUX_I2C_DEFER_RETRY 4
 #define PIXEL_CLK_DELAY 1
 #define PIXEL_CLK_INVERSE 0
 #define ADJUST_PHASE_THRESHOLD 80000
@@ -323,7 +341,12 @@
 enum aux_cmd_type {
 	CMD_AUX_NATIVE_READ = 0x0,
 	CMD_AUX_NATIVE_WRITE = 0x5,
+	CMD_AUX_GI2C_ADR = 0x08,
+	CMD_AUX_GI2C_READ = 0x09,
+	CMD_AUX_GI2C_WRITE = 0x0A,
 	CMD_AUX_I2C_EDID_READ = 0xB,
+	CMD_AUX_I2C_READ = 0x0D,
+	CMD_AUX_I2C_WRITE = 0x0C,
 
 	/* KSV list read using AUX native read with FIFO */
 	CMD_AUX_GET_KSV_LIST = 0x10,
@@ -1106,6 +1129,154 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 	return ret;
 }
 
+static int it6505_aux_i2c_wait(struct it6505 *it6505, u8 *reply)
+{
+	int err = 0;
+	unsigned long timeout;
+	struct device *dev = it6505->dev;
+
+	timeout = jiffies + msecs_to_jiffies(AUX_WAIT_TIMEOUT_MS) + 1;
+
+	do {
+		if (it6505_read(it6505, REG_AUX_USER_CTRL) & AUX_EVENT)
+			break;
+		if (time_after(jiffies, timeout)) {
+			dev_err(dev, "Timed out waiting AUX I2C, BUSY = %X\n",
+				it6505_aux_op_finished(it6505));
+			err = -ETIMEDOUT;
+			goto end_aux_i2c_wait;
+		}
+		usleep_range(300, 800);
+	} while (!it6505_aux_op_finished(it6505));
+
+	if (!reply)
+		goto end_aux_i2c_wait;
+
+	*reply = it6505_read(it6505, REG_AUX_USER_REPLY) >> 4;
+
+	if (*reply == 0)
+		goto end_aux_i2c_wait;
+
+	if ((*reply == DP_AUX_NATIVE_REPLY_DEFER) ||
+	    (*reply == DP_AUX_I2C_REPLY_DEFER))
+		err = -EBUSY;
+	else if ((*reply == DP_AUX_NATIVE_REPLY_NACK) ||
+		 (*reply == DP_AUX_I2C_REPLY_NACK))
+		err = -ENXIO;
+
+end_aux_i2c_wait:
+	it6505_set_bits(it6505, REG_AUX_USER_CTRL, USER_AUX_DONE, USER_AUX_DONE);
+	return err;
+}
+
+static int it6505_aux_i2c_readb(struct it6505 *it6505, u8 *buf, size_t size, u8 *reply)
+{
+	int ret, i;
+	int retry = 0;
+
+	for (retry = 0; retry < AUX_I2C_DEFER_RETRY; retry++) {
+		it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_READ);
+		ret = it6505_aux_i2c_wait(it6505, reply);
+		if ((*reply == DP_AUX_NATIVE_REPLY_DEFER) ||
+		    (*reply == DP_AUX_I2C_REPLY_DEFER))
+			continue;
+		if (ret >= 0)
+			break;
+	}
+
+	for (i = 0; i < size; i++)
+		buf[i] =  (u8)it6505_read(it6505, REG_AUX_USER_RXB(0 + i));
+
+	return size;
+}
+
+static int it6505_aux_i2c_writeb(struct it6505 *it6505, u8 *buf, size_t size, u8 *reply)
+{
+	int i, ret;
+	int retry = 0;
+
+	for (i = 0; i < size; i++)
+		it6505_write(it6505, REG_AUX_OUT_DATA0 + i, buf[i]);
+
+	for (retry = 0; retry < AUX_I2C_DEFER_RETRY; retry++) {
+		it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_WRITE);
+		ret = it6505_aux_i2c_wait(it6505, reply);
+		if ((*reply == DP_AUX_NATIVE_REPLY_DEFER) ||
+		    (*reply == DP_AUX_I2C_REPLY_DEFER))
+			continue;
+		if (ret >= 0)
+			break;
+	}
+	return size;
+}
+
+static ssize_t it6505_aux_i2c_operation(struct it6505 *it6505,
+					struct drm_dp_aux_msg *msg)
+{
+	int ret;
+	ssize_t request_size, data_cnt = 0;
+	u8 *buffer = msg->buffer;
+
+	/* set AUX user mode */
+	it6505_set_bits(it6505, REG_AUX_CTRL,
+			AUX_USER_MODE | AUX_NO_SEGMENT_WR, AUX_USER_MODE);
+	it6505_set_bits(it6505, REG_AUX_USER_CTRL, EN_USER_AUX, EN_USER_AUX);
+	/* clear AUX FIFO */
+	it6505_set_bits(it6505, REG_AUX_CTRL,
+			AUX_EN_FIFO_READ | CLR_EDID_FIFO,
+			AUX_EN_FIFO_READ | CLR_EDID_FIFO);
+
+	it6505_set_bits(it6505, REG_AUX_CTRL,
+			AUX_EN_FIFO_READ | CLR_EDID_FIFO, 0x00);
+
+	it6505_write(it6505, REG_AUX_ADR_0_7, 0x00);
+	it6505_write(it6505, REG_AUX_I2C_ADR, msg->address << 1);
+
+	if (msg->size == 0) {
+		/* IIC Start/STOP dummy write */
+		it6505_write(it6505, REG_AUX_I2C_OP, msg->request);
+		it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_ADR);
+		ret = it6505_aux_i2c_wait(it6505, &msg->reply);
+		goto end_aux_i2c_transfer;
+	}
+
+	/* IIC data transfer */
+	for (data_cnt = 0; data_cnt < msg->size; ) {
+		request_size = min_t(ssize_t, msg->size - data_cnt, AUX_I2C_MAX_SIZE);
+		it6505_write(it6505, REG_AUX_I2C_OP,
+			     msg->request | ((request_size - 1) << 4));
+		if ((msg->request & DP_AUX_I2C_READ) == DP_AUX_I2C_READ)
+			ret = it6505_aux_i2c_readb(it6505, &buffer[data_cnt],
+						   request_size, &msg->reply);
+		else
+			ret = it6505_aux_i2c_writeb(it6505, &buffer[data_cnt],
+						    request_size, &msg->reply);
+
+		if (ret < 0)
+			goto end_aux_i2c_transfer;
+
+		data_cnt += request_size;
+	}
+	ret = data_cnt;
+end_aux_i2c_transfer:
+
+	it6505_set_bits(it6505, REG_AUX_USER_CTRL, EN_USER_AUX, 0);
+	it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, 0);
+	return ret;
+}
+
+static ssize_t it6505_aux_i2c_transfer(struct drm_dp_aux *aux,
+				       struct drm_dp_aux_msg *msg)
+{
+	struct it6505 *it6505 = container_of(aux, struct it6505, aux);
+	int ret;
+
+	mutex_lock(&it6505->aux_lock);
+	ret = it6505_aux_i2c_operation(it6505, msg);
+	mutex_unlock(&it6505->aux_lock);
+	return ret;
+}
+
 static ssize_t it6505_aux_transfer(struct drm_dp_aux *aux,
 				   struct drm_dp_aux_msg *msg)
 {
@@ -1115,9 +1286,8 @@ static ssize_t it6505_aux_transfer(struct drm_dp_aux *aux,
 	int ret;
 	enum aux_cmd_reply reply;
 
-	/* IT6505 doesn't support arbitrary I2C read / write. */
 	if (is_i2c)
-		return -EINVAL;
+		return it6505_aux_i2c_transfer(aux, msg);
 
 	switch (msg->request) {
 	case DP_AUX_NATIVE_READ:
-- 
2.34.1


