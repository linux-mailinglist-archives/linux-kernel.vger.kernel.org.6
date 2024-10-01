Return-Path: <linux-kernel+bounces-345336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425E98B4D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C5A284912
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7371BD4EA;
	Tue,  1 Oct 2024 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="s4Hq3do0"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD951BC9ED
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765171; cv=none; b=rPP8DHyEPkMheydnCHMphNHen853jT9MvSwmEU9gNWI3tLpvsdO0uBlQSVfWJezphGJ0VsV+5BTw6+i2//Qfm/v4DDhmBNWxuHRJ2cxH2Tjjbwj+qu7y6tcAXdid14PL43Y2UINGGGWXdFDS6wTv9mdxlLxbQ9tz/7Cl1QIXki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765171; c=relaxed/simple;
	bh=xcRQyfKUct/Ov0Y4a9OyZWg//Uiqim8C3F3OWddY0nc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YwxGq2DsTYQtJIacnjW1X6mUrNwcs2/GuKN3lV3z2ulG1Q9GWnbhnuKg/RqX3lIp4M3+D+gkF2LtfZtgrBFdXp2X3eXC4Dh8Ln1xFZUSvo0jNs56348YnpcZ05HUkEz+CXVdN8viFgEqU/zTnJeM/at17MGx1N7gPyfw+HMvG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=s4Hq3do0 reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LYSSknictoJDzfwwPKe2Pp93SMdw41mKET43ooz35xI=;
  b=s4Hq3do05kT7L56moixk9I8LqfjOy4oDsZ3gTiBKHNWFU/x26rptyY4J
   5YxqiV3lXIeDbMJQa4xn40l0rayfMNQc8BtA30G0iI7v5DeAzSENikJmq
   f7VmjNIPJnmZDwejPGONM2CVWidtXuNGrJoyXZtkesbuMtLf+IEpxqpQ2
   SqYAvyN9TUCrjf1/JIQtqRop3e30ysCwF3ovpDAHl4Jkkfx//yXchtcJi
   qoGNM4E7iHOy4lD00w/Qa3lKu4q4GCjPisjw/E9BrDy68TqGGLQZOx4EJ
   mlVzpo8HfRFMmY3ZRbtvJnvWQbbF70vg5EKji6yUxiqd+rxtlHSpmO46P
   A==;
X-CSE-ConnectionGUID: FyR+wkCASk+j+yxrulDPUg==
X-CSE-MsgGUID: 10XTAVq1Rwi+g0/fsRUYDg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 01 Oct 2024 14:46:08 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 4916k28I047306;
	Tue, 1 Oct 2024 14:46:02 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 14:46:02 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>,
        Hermes Wu <Hermes.wu@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 10/10] drm/bridge: it6505: add I2C functionality on AUX
Date: Tue, 1 Oct 2024 14:45:50 +0800
Message-ID: <20241001064550.32375-1-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
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
	4B4BDAE825F12EFA93E249E9EE5BA2BD0EA27F1F5CEE081FA7230B293851381F2002:8
X-MAIL:mse.ite.com.tw 4916k28I047306

From: Hermes Wu <Hermes.wu@ite.com.tw>

DisplayPort AUX protocol supports I2C transport which is capable of reading EDID or supports MCCS.

In drm_dp_helper, drm_dp_i2c_xfer() packs I2C requests into a sequence of AUX requests.
it6505_aux_i2c_operation() is implemented to match drm_dp_i2c_xfer() behavior.
it6505_aux_i2c_transfer() adds I2C functionality for  it6505_aux_transfer().

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 177 +++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 2bf177a55daf..f03923bff3d9 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -267,6 +267,18 @@
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
+#define REG_AUX_USER_RXB(n) (n + 0x19B)
+
 #define RBR DP_LINK_BW_1_62
 #define HBR DP_LINK_BW_2_7
 #define HBR2 DP_LINK_BW_5_4
@@ -302,6 +314,8 @@
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
 #define AUX_FIFO_MAX_SIZE 16
+#define AUX_I2C_MAX_SIZE 4
+#define AUX_I2C_DEFER_RETRY 4
 #define PIXEL_CLK_DELAY 1
 #define PIXEL_CLK_INVERSE 0
 #define ADJUST_PHASE_THRESHOLD 80000
@@ -324,7 +338,12 @@
 enum aux_cmd_type {
 	CMD_AUX_NATIVE_READ = 0x0,
 	CMD_AUX_NATIVE_WRITE = 0x5,
+	CMD_AUX_GI2C_ADR = 0x08,
+	CMD_AUX_GI2C_READ = 0x09,
+	CMD_AUX_GI2C_WRITE = 0x0A,
 	CMD_AUX_I2C_EDID_READ = 0xB,
+	CMD_AUX_I2C_READ = 0x0D,
+	CMD_AUX_I2C_WRITE = 0x0C,
 
 	/* KSV read with AUX FIFO extend from CMD_AUX_NATIVE_READ*/
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
+		ret = it6505_aux_i2c_wait(it6505, &msg->reply);
+		goto end_aux_i2c_transfer;
+	}
+
+	/* IIC data transfer */
+	data_cnt = 0;
+	do {
+		request_size = min_t(ssize_t, msg->size - data_cnt, AUX_I2C_MAX_SIZE);
+		it6505_write(it6505, REG_AUX_ADR_16_19,
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
+	} while (data_cnt < msg->size);
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


