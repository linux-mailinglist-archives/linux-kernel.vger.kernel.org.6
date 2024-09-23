Return-Path: <linux-kernel+bounces-335683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C1A97E90F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505EE2835DB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475B194A54;
	Mon, 23 Sep 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="K0yILHBp"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985341C85
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084969; cv=none; b=iRApzFEUx9u8Q9lB5eE1R6XXvPZDPDvb7LnHHSOmeL8qMk4OOMuy/jyWbCOTnQWxSBfhjtfjUrJRl0MT28aLSxEKRQFAfgokFQcO7SUKGkTibQv4Yl4xaXIt1YvyHDf+2TwSFJyRvnUzn5mUgqn7NnaeLD0dVPFis1U1Cez62IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084969; c=relaxed/simple;
	bh=vmu/j1lyqw+/aRlpZV9exmrA3pWwIPzKl1G1ZUnZDag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5zGqc1YLp/ZvezQvn3i10zmHfgdU0T5g3hBahxWvg1LNiltPwwOIVOQQ+Fa1VZSdXYO3Lwb9VUeQZ/9BAtn4AMg459tpXNc/WbpqL6HwfKXLkC35diU/M1U7pjbsSLsolGYG0vm2bCG7pHcY207qcBtmyi1k0Bo1IGj9y47PMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=K0yILHBp reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RATeZcdFKN1/hsUzenRtVdn+M6rdLZzfPxAuIj/QuYk=;
  b=K0yILHBpH8+nT8AVeGZfkGR8JS2o2ydD7hpnxpOOQdKHnRjfN0m1+pHI
   BWOmJdL6a9EkfjDf/28ShcuHCeEvBcRCjlhcctcLx+/EdVoCoBMuE6ofl
   xXjGi9RUw+znhKtrHSGS58JDzIgSkOJrP1s1TWGfH7D/xp1jADQI2ux0e
   Dhl0r6yArwVME0XW87fBc8Aa3TbrO0P8qVZUI23XkthmRJa43ApDVyRdB
   Tzd64Tt4oJynw+pJtCvj3WAXsggtWejSm1rzz/Wk0Un5t88ZHEmC3BD7K
   bChiV8oBn2IzkVZz7uDUNWS02S3XtG+nmvLlPUxXjrCTuetWYiy3kIlZd
   g==;
X-CSE-ConnectionGUID: gAleM/sNRDi1xotAuOEMig==
X-CSE-MsgGUID: g6px+bleQxCReJRYWdPkVw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Sep 2024 17:49:25 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48N9nJ0T009955;
	Mon, 23 Sep 2024 17:49:19 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 17:49:20 +0800
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
Subject: [PATCH v3 2/3] drm/bridge: it6505: HDCP CTS fail on repeater items
Date: Mon, 23 Sep 2024 17:48:28 +0800
Message-ID: <20240923094826.13471-3-Hermes.Wu@ite.com.tw>
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
	98851776D81618FFAC035B6B70C395311032E33BF9685BB2FA81F938C3975CA72002:8
X-MAIL:mse.ite.com.tw 48N9nJ0T009955

From: Hermes Wu <Hermes.wu@ite.com.tw>

Changes in v3:
 -add detials about fail item and changes.


Fix HDCP CTS fail items on UNIGRAF DRP-100

DUT must Support 127 devices.
DUT must check BSTATUS when recive CP_IRQ.
DUT must enable encription when R0' is ready.
DUT must retry V' check 3 times.
it6505 must read DRP-100 KSV FIFO by FIFO mode.
it6505 should restart HDCP within 5s if KSV not ready.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 112 ++++++++++++++++++----------
 1 file changed, 74 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index d8b40ad890bf..156440c6517e 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -296,7 +296,7 @@
 #define MAX_LANE_COUNT 4
 #define MAX_LINK_RATE HBR
 #define AUTO_TRAIN_RETRY 3
-#define MAX_HDCP_DOWN_STREAM_COUNT 10
+#define MAX_HDCP_DOWN_STREAM_COUNT 127
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
@@ -1188,6 +1188,35 @@ static int it6505_get_edid_block(void *data, u8 *buf, unsigned int block,
 	return 0;
 }
 
+static int it6505_get_ksvlist(struct it6505 *it6505, u8 *buf, size_t len)
+{
+	int i, request_size, ret;
+	struct device *dev = it6505->dev;
+	enum aux_cmd_reply reply;
+
+	for (i = 0; i < len; ) {
+		request_size = min_t(int, (int)len - i, 15);
+
+		ret = it6505_aux_do_transfer(it6505, CMD_AUX_GET_KSV_LIST,
+					     DP_AUX_HDCP_KSV_FIFO,
+					     buf + i, request_size, &reply);
+
+		DRM_DEV_DEBUG_DRIVER(dev, "request_size = %d, ret =%d", request_size, ret);
+		if (ret < 0)
+			return ret;
+
+		i += request_size;
+	}
+
+	DRM_DEV_DEBUG_DRIVER(dev, "ksv read cnt = %d down_stream_cnt=%d ", i, i / 5);
+
+	for (i = 0 ; i < len; i += 5)
+		DRM_DEV_DEBUG_DRIVER(dev, "ksv[%d] = %02X%02X%02X%02X%02X",
+				     i / 5, buf[i], buf[i + 1], buf[i + 2], buf[i + 3], buf[i + 4]);
+
+	return len;
+}
+
 static void it6505_variable_config(struct it6505 *it6505)
 {
 	it6505->link_rate_bw_code = HBR;
@@ -1969,7 +1998,7 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
 {
 	struct device *dev = it6505->dev;
 	u8 binfo[2];
-	int down_stream_count, i, err, msg_count = 0;
+	int down_stream_count, err, msg_count = 0;
 
 	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_BINFO, binfo,
 			      ARRAY_SIZE(binfo));
@@ -1994,18 +2023,11 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
 			down_stream_count);
 		return 0;
 	}
-
-	for (i = 0; i < down_stream_count; i++) {
-		err = it6505_get_dpcd(it6505, DP_AUX_HDCP_KSV_FIFO +
-				      (i % 3) * DRM_HDCP_KSV_LEN,
-				      sha1_input + msg_count,
-				      DRM_HDCP_KSV_LEN);
-
+	err =  it6505_get_ksvlist(it6505, sha1_input, down_stream_count * 5);
 		if (err < 0)
 			return err;
 
-		msg_count += 5;
-	}
+	msg_count += down_stream_count * 5;
 
 	it6505->hdcp_down_stream_count = down_stream_count;
 	sha1_input[msg_count++] = binfo[0];
@@ -2033,7 +2055,7 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
 {
 	struct device *dev = it6505->dev;
 	u8 av[5][4], bv[5][4];
-	int i, err;
+	int i, err, retry;
 
 	i = it6505_setup_sha1_input(it6505, it6505->sha1_input);
 	if (i <= 0) {
@@ -2042,22 +2064,28 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
 	}
 
 	it6505_sha1_digest(it6505, it6505->sha1_input, i, (u8 *)av);
+	/*1B-05 V' must retry 3 times */
+	for (retry = 0; retry < 3; retry++) {
+		err = it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
+				      sizeof(bv));
+
+		if (err < 0) {
+			dev_err(dev, "Read V' value Fail %d", retry);
+			continue;
+		}
 
-	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
-			      sizeof(bv));
+		for (i = 0; i < 5; i++) {
+			if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
+			    av[i][1] != av[i][2] || bv[i][0] != av[i][3])
+				break;
 
-	if (err < 0) {
-		dev_err(dev, "Read V' value Fail");
-		return false;
+			DRM_DEV_DEBUG_DRIVER(dev, "V' all match!! %d, %d", retry, i);
+			return true;
+		}
 	}
 
-	for (i = 0; i < 5; i++)
-		if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
-		    bv[i][1] != av[i][2] || bv[i][0] != av[i][3])
-			return false;
-
-	DRM_DEV_DEBUG_DRIVER(dev, "V' all match!!");
-	return true;
+	DRM_DEV_DEBUG_DRIVER(dev, "V' NOT match!! %d", retry);
+	return false;
 }
 
 static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
@@ -2065,7 +2093,8 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 	struct it6505 *it6505 = container_of(work, struct it6505,
 					     hdcp_wait_ksv_list);
 	struct device *dev = it6505->dev;
-	unsigned int timeout = 5000;
+	/* 1B-04 fail, wait to long to Stop encription(5s->2s). */
+	unsigned int timeout = 2000;
 	u8 bstatus = 0;
 	bool ksv_list_check;
 
@@ -2085,21 +2114,18 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 
 	if (timeout == 0) {
 		DRM_DEV_DEBUG_DRIVER(dev, "timeout and ksv list wait failed");
-		goto timeout;
+		goto hdcp_ksvlist_fail;
 	}
 
 	ksv_list_check = it6505_hdcp_part2_ksvlist_check(it6505);
 	DRM_DEV_DEBUG_DRIVER(dev, "ksv list ready, ksv list check %s",
 			     ksv_list_check ? "pass" : "fail");
-	if (ksv_list_check) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER,
-				HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
+
+	if (ksv_list_check)
 		return;
-	}
-timeout:
-	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
-			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL,
-			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL);
+
+hdcp_ksvlist_fail:
+	it6505_start_hdcp(it6505);
 }
 
 static void it6505_hdcp_work(struct work_struct *work)
@@ -2321,14 +2347,20 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 	DRM_DEV_DEBUG_DRIVER(dev, "dp_irq_vector = 0x%02x", dp_irq_vector);
 
 	if (dp_irq_vector & DP_CP_IRQ) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
-				HDCP_TRIGGER_CPIRQ);
-
 		bstatus = it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS);
 		if (bstatus < 0)
 			return bstatus;
 
 		DRM_DEV_DEBUG_DRIVER(dev, "Bstatus = 0x%02x", bstatus);
+
+		/*1B-02 ignore when bstatus is 0 */
+		if (bstatus & DP_BSTATUS_R0_PRIME_READY &&
+		    it6505->hdcp_status == HDCP_AUTH_GOING)
+			it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
+					HDCP_TRIGGER_CPIRQ);
+		else if (bstatus & (DP_BSTATUS_REAUTH_REQ | DP_BSTATUS_LINK_FAILURE) &&
+			 it6505->hdcp_status == HDCP_AUTH_DONE)
+			it6505_start_hdcp(it6505);
 	}
 
 	ret = drm_dp_dpcd_read_link_status(&it6505->aux, link_status);
@@ -2465,7 +2497,11 @@ static void it6505_irq_hdcp_ksv_check(struct it6505 *it6505)
 {
 	struct device *dev = it6505->dev;
 
-	DRM_DEV_DEBUG_DRIVER(dev, "HDCP event Interrupt");
+	DRM_DEV_DEBUG_DRIVER(dev, "HDCP repeater R0 event Interrupt");
+	/* 1B01 HDCP encription should start when R0 is ready*/
+	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
+			HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
+
 	schedule_work(&it6505->hdcp_wait_ksv_list);
 }
 
-- 
2.34.1


