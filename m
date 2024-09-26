Return-Path: <linux-kernel+bounces-340067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3768986E40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD7E1C24DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319CE1A3BD8;
	Thu, 26 Sep 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="qMa568xh"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C21A3BA9
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337118; cv=none; b=sn+nLeUd7WhlNAi+DEuSGCBSV4waXRjV5kCPjbCejkfFPtRvgaxgCD0xuXbrQ12DIuVbU+nH/3eVVddJNa4T6+Va3bKsP7fW2OaqZG/joUjHK2ob+SpoIMv/QqVnVHrp8VqYnbFPOe4KzpcboT6H9KspJD7uJHkHoV94w9/EGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337118; c=relaxed/simple;
	bh=obXP87Vnv+V/11ifRnyFayImfojj2giNCa6lWMQUMJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFjCDbiQNYY/RhyToN9VKtlXiZFYm6e6gftNmXF0HktqAw8BFxTKfCSGI+pb5fVmxd5TQsEYb/Pq/of+cKmofLHazUp5/TqzPZUWzJxTznJaJRK3+ZLNv1YOMqv2m7XP+zCV3YxV+l31Mu5U5xa2NAajrn0xOAZ3tQlfEIv0pnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=qMa568xh reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VQfTwvkp0mFLo1ynhN8FPICXctvCBB4Zz0ztlO9KQC8=;
  b=qMa568xh7ubTaH1bmpwJWBJO6KZzdx6ljtLUYmgC6xxoLeDFbV0BfH1O
   KehVIAcO8f/Kjece7k0x8efi5w4SSSH1uvnpYMTvpzGTSpSMrz3H0e9RR
   HP635e8eGBHZorkMzKIo2oNKxBS1qhKuWdlXMg8KlXZ9jk9xVYNCD81jB
   IBH1qDOkU18UVV0uKbSh4+Y5DmfZz8+vnU5k+17omCXi4cdVutAtBa5mr
   Z93LXKyGcHMJ0NbPjXTkoEDbSvb4rviKrLVRVJ5ILjYwGE4d2ho2wHTIk
   Czt6QGkyCbAgFCN7km4kbNgL+O9MqD6JpDf34c0ut82l88cQhRXT8bvRy
   g==;
X-CSE-ConnectionGUID: bY56xvkyQ7qWq0mOakwiIg==
X-CSE-MsgGUID: 4SY1B6hTRnGX9/ZtWQq7vw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:51:53 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7pnXQ046832;
	Thu, 26 Sep 2024 15:51:49 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:51:50 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: hermes wu <Hermes.wu@ite.com.tw>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
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
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Allen Chen
	<allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
        "open list:DRM
 DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 11/11] drm/bridge: it6505: Add aux i2c functionality
Date: Thu, 26 Sep 2024 15:51:34 +0800
Message-ID: <20240926075134.22394-2-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926075134.22394-1-Hermes.Wu@ite.com.tw>
References: <20240926075134.22394-1-Hermes.Wu@ite.com.tw>
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
	68212C2942757DA82E36FA68BA6F93906F1C1EC17AC85C70E7C72A95EFD9B8652002:8
X-MAIL:mse.ite.com.tw 48Q7pnXQ046832

From: Hermes Wu <Hermes.wu@ite.com.tw>

Add aux-i2c operaction in order to support the MCCS function.


Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 177 +++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 22d9bec3faea..95a156ff4790 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -266,6 +266,18 @@
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
+#define REG_AUX_USER_REPLY 0x19A
+#define REG_AUX_USER_RXB(n) ((n) + 0x19B)
+
 #define RBR DP_LINK_BW_1_62
 #define HBR DP_LINK_BW_2_7
 #define HBR2 DP_LINK_BW_5_4
@@ -301,6 +313,8 @@
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
 #define AUX_FIFO_MAX_SIZE 16
+#define AUX_I2C_MAX_SIZE 4
+#define AUX_I2C_DEFER_RETRY 4
 #define PIXEL_CLK_DELAY 1
 #define PIXEL_CLK_INVERSE 0
 #define ADJUST_PHASE_THRESHOLD 80000
@@ -323,7 +337,12 @@
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
@@ -1106,6 +1125,161 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 	return ret;
 }
 
+static bool it6505_aux_i2c_reply_defer(u8 reply)
+{
+	if (reply == DP_AUX_NATIVE_REPLY_DEFER || reply == DP_AUX_I2C_REPLY_DEFER)
+		return true;
+	return false;
+}
+
+static bool it6505_aux_i2c_reply_nack(u8 reply)
+{
+	if (reply == DP_AUX_NATIVE_REPLY_NACK || reply == DP_AUX_I2C_REPLY_NACK)
+		return true;
+	return false;
+}
+
+static int it6505_aux_i2c_wait(struct it6505 *it6505, u8 *reply)
+{
+	int err;
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
+	*reply = it6505_read(it6505, REG_AUX_USER_REPLY) >> 4;
+
+	if (*reply == 0)
+		goto end_aux_i2c_wait;
+
+	if (it6505_aux_i2c_reply_defer(*reply))
+		err = -EBUSY;
+	else if (it6505_aux_i2c_reply_nack(*reply))
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
+	int retry;
+
+	for (retry = 0; retry < AUX_I2C_DEFER_RETRY; retry++) {
+		it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_READ);
+
+		ret = it6505_aux_i2c_wait(it6505, reply);
+		if (it6505_aux_i2c_reply_defer(*reply))
+			continue;
+		if (ret >= 0)
+			break;
+	}
+
+	for (i = 0; i < size; i++)
+		buf[i] = it6505_read(it6505, REG_AUX_USER_RXB(0 + i));
+
+	return size;
+}
+
+static int it6505_aux_i2c_writeb(struct it6505 *it6505, u8 *buf, size_t size, u8 *reply)
+{
+	int i, ret;
+	int retry;
+
+	for (i = 0; i < size; i++)
+		it6505_write(it6505, REG_AUX_OUT_DATA0 + i, buf[i]);
+
+	for (retry = 0; retry < AUX_I2C_DEFER_RETRY; retry++) {
+		it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_WRITE);
+
+		ret = it6505_aux_i2c_wait(it6505, reply);
+		if (it6505_aux_i2c_reply_defer(*reply))
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
+	it6505_write(it6505, REG_AUX_ADR_8_15, msg->address << 1);
+
+	if (msg->size == 0) {
+		/* IIC Start/STOP dummy write */
+		it6505_write(it6505, REG_AUX_ADR_16_19, msg->request);
+		it6505_write(it6505, REG_AUX_CMD_REQ, CMD_AUX_GI2C_ADR);
+
+		ret = it6505_aux_i2c_wait(it6505, &msg->reply);
+		goto end_aux_i2c_transfer;
+	}
+
+	/* IIC data transfer */
+	for (data_cnt = 0; data_cnt < msg->size; ) {
+		request_size = min_t(ssize_t, msg->size - data_cnt, AUX_I2C_MAX_SIZE);
+		it6505_write(it6505, REG_AUX_ADR_16_19,
+			     msg->request | ((request_size - 1) << 4));
+		if ((msg->request & DP_AUX_I2C_READ) == DP_AUX_I2C_READ)
+			ret = it6505_aux_i2c_readb(it6505, &buffer[data_cnt],
+						   equest_size, &msg->reply);
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
+
+	guard(mutex)(&it6505->aux_lock);
+	return it6505_aux_i2c_operation(it6505, msg);
+}
+
 static ssize_t it6505_aux_transfer(struct drm_dp_aux *aux,
 				   struct drm_dp_aux_msg *msg)
 {
@@ -1115,9 +1289,8 @@ static ssize_t it6505_aux_transfer(struct drm_dp_aux *aux,
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


