Return-Path: <linux-kernel+bounces-340052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16163986E19
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390AE1C21D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D092518E37A;
	Thu, 26 Sep 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="NZ0/c/C0"
Received: from ironport.ite.com.tw (HC210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31557193072
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336913; cv=none; b=LyLGos/LpOP7wzAhRJLIeezOzr2xkpcjLRMm0Nz0WYE5zJrVqOa4QKuKYIdRdE18lHg0Eel7Kcb9zB1FcIL3gO9F4I6o1odK07s/2/42xsj3hsoEpkcgQBTxXmoiYzbXdFjFqS2/WkaaXVRW8Alfz4hZUH8ebb2qNQ2H6+39hS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336913; c=relaxed/simple;
	bh=jimZXpSFs3oq5CB/bJX7rrt7Tp3/wTmPFhpfAozy6aU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8VixjVkz1k/X336avWQ7O/bTJUx+OOmAxzjcsG7Rcn2MbjtjrAWTO27V/0y9TgJmXngrl9yT/14lNmq0TnnGX3myZYYIYOIC/lMP/yeCZpsaNlN3+vd6P8IkPj2iVL4YHlvViMWteXO2sePf7CcHaj9nB6gECVmPHvvXZgmikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=NZ0/c/C0 reason="key not found in DNS"; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hqfWlB74d2KyBDsvh5rqVMLxH4BblDUiZngMTqszblM=;
  b=NZ0/c/C0iogxmG8Q27mSQonsd2+WVd9nHVlpIDsH1dwo0fomE8KmZPtv
   4xwhn2vYYRXIrgf3ey7fmItfOFk4ZaR7Kd2WnzYzfsfUtKtNtBjy85Dai
   Z3bPf71u968xOiSVADwv7QEChppiQ6XRSX8bNWjxPGbVgupQ5Pq4i2hi2
   qSMok7sMR678CXoFhFOpUNTeFY9GjKA0iERa0cGsgBgPdZ2RzUXa7h0aW
   e9j22ttomrFwMnknIIBbhv5mg2AejwGCgM08Bg+50m5M4ZdQPAGSP93Se
   T12CyYJnvF+OdHMEv2UeQmIGfiX0Hmk8XxmbZs3sqqcaTJSxXdl2XdznW
   Q==;
X-CSE-ConnectionGUID: kcuaWwUWRmSjLcUvuOP6bA==
X-CSE-MsgGUID: 12is0OXSTjunyqdccDc03g==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:48:18 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7mFIw042912;
	Thu, 26 Sep 2024 15:48:15 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:48:14 +0800
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
        Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen
	<allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/11] drm/bridge: it6505: add aux operation for HDCP ksv list read
Date: Thu, 26 Sep 2024 15:47:53 +0800
Message-ID: <20240926074755.22176-4-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
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
	D330B8CCA585850E4F136DAFDD23DD0FA37431D0B4C4FB63A2BCB4BA143484D02002:8
X-MAIL:mse.ite.com.tw 48Q7mFIw042912

From: Hermes Wu <Hermes.wu@ite.com.tw>

Add aux operaction command which supports read DPCD KSV FIFO
with aux fifo.


Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index b451d3c2ac1d..0583abdca75f 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -324,6 +324,9 @@ enum aux_cmd_type {
 	CMD_AUX_NATIVE_READ = 0x0,
 	CMD_AUX_NATIVE_WRITE = 0x5,
 	CMD_AUX_I2C_EDID_READ = 0xB,
+
+	/* KSV list read using AUX native read with FIFO */
+	CMD_AUX_GET_KSV_LIST = 0x10,
 };
 
 enum aux_cmd_reply {
@@ -965,7 +968,8 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 	it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MODE);
 
 aux_op_start:
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	/* HW AUX FIFO supports only EDID and DCPD KSV FIFO aread */
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		/* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE bytes. */
 		size = min_t(size_t, size, AUX_FIFO_MAX_SIZE);
 		/* Enable AUX FIFO read back and clear FIFO */
@@ -1030,7 +1034,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 		goto aux_op_start;
 	}
 
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		for (i = 0; i < size; i++) {
 			ret = it6505_read(it6505, REG_AUX_DATA_FIFO);
 			if (ret < 0)
@@ -1055,7 +1059,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 	ret = i;
 
 aux_op_err:
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		/* clear AUX FIFO */
 		it6505_set_bits(it6505, REG_AUX_CTRL,
 				AUX_EN_FIFO_READ | CLR_EDID_FIFO,
@@ -1079,7 +1083,7 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 
 	mutex_lock(&it6505->aux_lock);
 	for (i = 0; i < size; ) {
-		if (cmd == CMD_AUX_I2C_EDID_READ)
+		if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST)
 			request_size = min_t(int, (int)size - i, AUX_FIFO_MAX_SIZE);
 		else
 			request_size = min_t(int, (int)size - i, 4);
-- 
2.34.1


