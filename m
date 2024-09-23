Return-Path: <linux-kernel+bounces-335682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07C97E90C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E210E282D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E7194AE7;
	Mon, 23 Sep 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="FYo4PnPE"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BC41C85
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084955; cv=none; b=anIDzTut+Pd/Yqa/3F1uM3C2FvB3biaozaMIpWzEMp1T2ydGEc0bSSbz8RYVD/RJgu+S7/CiQ9aRshEbL28kjZ7tQNDXL8b4bJ1B/KiAi/s7uk2llmSs1Fp5oEBIIU2adlM6Bag4ZCtX6h62iBOdb74R2n7l71DIa7COzAdbcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084955; c=relaxed/simple;
	bh=bcab8NKHKZ/OgrxhIJmEfaGKndgOMoqcYPFJWmPeyAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEpJNTriXFth4RXsakso/zho0qD/rBlUq0NCaoeuKm/ybKMOkheP8DLouIuojDPyv9EzBcTmgPGwvijQb5kfv+LcYDb/lGQUIviqpeTYlpii7GquVkeIO/xTaOfFkoHjtH+SlG2qyAiubwtxfoKzoKwr1ypKCDZFOiTjqFpPdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=FYo4PnPE reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D4CBwdKSZlEyvTAklHN3JJbjBXdUi11CtZopOAHER8E=;
  b=FYo4PnPEhGc6kczKHRSMIMGv6JwSfMJH86mu0roOYcIguXF7JDZBD8La
   kzDS4XOgEnIkT84YLYjQvf7JeeMecwUDOAL5kny56cgK0Ohf86E808M5V
   3knGrm8wMYz664Y/ltJnrTrtxRBa2oXTmJLF3BwoP/I7fUdfSdtIvRv9H
   dKrC1dobS9dAuc656NOyIGS2fKHiG+3vWMJsHuGOlLMe/5yM3OeifGYE0
   rmnW0dCzdCrKCUoWFlFsRCKUrbBg9QdpB1u3Gjf9dQa6ExZ8Qa8HBCyTH
   ENXwinyNhZEDFyN9AWkUyW8n3PQB9PZK8S8P6Pq6+ED6qSgeBm7FEK9CE
   A==;
X-CSE-ConnectionGUID: 70onGuvJT6GSheoi+7fSEw==
X-CSE-MsgGUID: 6e36F1gWSfeFzG8yo1T6iw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Sep 2024 17:49:10 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48N9n8A7009871;
	Mon, 23 Sep 2024 17:49:08 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 17:49:08 +0800
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
Subject: [PATCH v3 1/3] drm/bridge: it6505: fix AUX read use aux fifo
Date: Mon, 23 Sep 2024 17:48:26 +0800
Message-ID: <20240923094826.13471-2-Hermes.Wu@ite.com.tw>
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
	53760FD41471EB3EF1CF901DB81369D3A0B71CC022F59A8E0F0251D2E05DD05C2002:8
X-MAIL:mse.ite.com.tw 48N9n8A7009871

From: Hermes Wu <Hermes.wu@ite.com.tw>

Changes in v3:
 -New in v3


it6505 AUX FIFO mode only 16 byte.
AUX FIFO mode only supports EDID read and DPCD KSV FIFO area.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 87b8545fccc0..d8b40ad890bf 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -300,7 +300,7 @@
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
-#define AUX_FIFO_MAX_SIZE 32
+#define AUX_FIFO_MAX_SIZE 16
 #define PIXEL_CLK_DELAY 1
 #define PIXEL_CLK_INVERSE 0
 #define ADJUST_PHASE_THRESHOLD 80000
@@ -324,8 +324,13 @@ enum aux_cmd_type {
 	CMD_AUX_NATIVE_READ = 0x0,
 	CMD_AUX_NATIVE_WRITE = 0x5,
 	CMD_AUX_I2C_EDID_READ = 0xB,
+
+	/* KSV list read using AUX native read with FIFO */
+	CMD_AUX_GET_KSV_LIST = 0x10,
 };
 
+#define GET_AUX_CONTROL_CODE(cmd) ((cmd) & 0x0F)
+
 enum aux_cmd_reply {
 	REPLY_ACK,
 	REPLY_NACK,
@@ -965,7 +970,8 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 	it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MODE);
 
 aux_op_start:
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	/* HW AUX FIFO supports only EDID and DCPD KSV FIFO aread */
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		/* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE bytes. */
 		size = min_t(size_t, size, AUX_FIFO_MAX_SIZE);
 		/* Enable AUX FIFO read back and clear FIFO */
@@ -996,7 +1002,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 				  size);
 
 	/* Aux Fire */
-	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
+	it6505_write(it6505, REG_AUX_CMD_REQ, GET_AUX_CONTROL_CODE(cmd));
 
 	ret = it6505_aux_wait(it6505);
 	if (ret < 0)
@@ -1030,7 +1036,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 		goto aux_op_start;
 	}
 
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		for (i = 0; i < size; i++) {
 			ret = it6505_read(it6505, REG_AUX_DATA_FIFO);
 			if (ret < 0)
@@ -1055,7 +1061,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 	ret = i;
 
 aux_op_err:
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		/* clear AUX FIFO */
 		it6505_set_bits(it6505, REG_AUX_CTRL,
 				AUX_EN_FIFO_READ | CLR_EDID_FIFO,
@@ -1078,8 +1084,11 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 	int i, ret_size, ret = 0, request_size;
 
 	mutex_lock(&it6505->aux_lock);
-	for (i = 0; i < size; i += 4) {
-		request_size = min((int)size - i, 4);
+	for (i = 0; i < size; ) {
+		if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST)
+			request_size = min_t(int, (int)size - i, AUX_FIFO_MAX_SIZE);
+		else
+			request_size = min_t(int, (int)size - i, 4);
 		ret_size = it6505_aux_operation(it6505, cmd, address + i,
 						buffer + i, request_size,
 						reply);
@@ -1088,6 +1097,7 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 			goto aux_op_err;
 		}
 
+		i += request_size;
 		ret += ret_size;
 	}
 
@@ -2257,7 +2267,6 @@ static void it6505_link_training_work(struct work_struct *work)
 		it6505->auto_train_retry--;
 		it6505_dump(it6505);
 	}
-
 }
 
 static void it6505_plugged_status_to_codec(struct it6505 *it6505)
-- 
2.34.1


