Return-Path: <linux-kernel+bounces-345335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EBE98B4D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A4B24C8F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B111BD026;
	Tue,  1 Oct 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="DEKWoZnA"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CE1BC9F4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765151; cv=none; b=HyRl0Z07uMc9okcPWtXi3feceN9XAhT/sJH1JhXFLoFCwc+vhoi2x6VuxSRm4Q9P21IlOE/k5L3q3Y99BfJKTaB1dom0gxzhEru7GBSdKvtGK2WZ0FZzjLZxo7+echF4pkt9i8OzEgyyeeJ/YjU3NUNVHa6E9Rhol2KHbKi/Wxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765151; c=relaxed/simple;
	bh=o1IBqOBly8s50Vac7sKBa89NGdZu9Szbeac+sMh0ks4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bjztn4B4Oakw8Zib8avZUQYH0LLpu0BTgktCx6OiUXmJHYEMqKD1zXOhYe6X1RjSAa3Si4IZcOCQe9forTr5MQA86Z7x9ygrWJf8W3ws2E9/8zF65pp9+Bi3sw0NBORHg3XV6BmJGAxxs4qaGqR4ErUL30cb/cjBY6rlcMFkD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=DEKWoZnA reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SBxAVZM4hjuWFx8BkjRgqi+TT3C3vxsca5sdfIHH9/s=;
  b=DEKWoZnA/2W8WDSlKz/shPOFUsnaSHT5h9iXYxI0ZbjZ4+v5Yb+yafFY
   fyzzoAwcXG4pxsjR34D0txf9mduNT+EZEQnze0+dcgMXOcgcnfXyINCsw
   Gwbj9jW6Xk31KAsMC5u9ENNhUPd7MweiZErLN9dCAdRUWNqlAWufWPDcy
   4v10/bFGmpEcO+MVC6jvh2Og3+9ZFXvJrgPA3wgx9iKmlW1mhEDeREF4c
   H4P9YsrGYaCg2BmWz6xED3XDC4Ui1m3RUTnmXFyyVI7fBDk0xyMsfhSPQ
   NzT6QYqWnWLz++ZArbAbeybFB3BUByo4fPRtCfJBuIkPccC7GDfXX52GK
   w==;
X-CSE-ConnectionGUID: qNlcPx7OQKyxQn+9ynMHkQ==
X-CSE-MsgGUID: +V57tsqmRwKPFUAAQd+uNg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 01 Oct 2024 14:45:48 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 4916jfbV046648;
	Tue, 1 Oct 2024 14:45:41 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 14:45:41 +0800
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
Subject: [PATCH v5 09/10] drm/bridge: it6505: fix HDCP CTS KSV list wait timer
Date: Tue, 1 Oct 2024 14:45:23 +0800
Message-ID: <20241001064523.32349-1-Hermes.Wu@ite.com.tw>
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
	2043788C2C56623C7F442A3FD0390C3DE54D1AAFE83ECA4FBB0A59C5DFAD1A602002:8
X-MAIL:mse.ite.com.tw 4916jfbV046648

From: Hermes Wu <Hermes.wu@ite.com.tw>

HDCP must disabled encryption and restart authentication after waiting KSV for 5s.
The original method uses a counter in a waitting loop that may wait much longer than it is supposed to.
Use time_after() for KSV wait timeout.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index da0ac789b8a3..2bf177a55daf 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2095,12 +2095,13 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 	struct it6505 *it6505 = container_of(work, struct it6505,
 					     hdcp_wait_ksv_list);
 	struct device *dev = it6505->dev;
-	unsigned int timeout = 5000;
-	u8 bstatus = 0;
+	u8 bstatus;
 	bool ksv_list_check;
+	/* 1B-04 wait ksv list for 5s */
+	unsigned long timeout = jiffies +
+				msecs_to_jiffies(5000) + 1;
 
-	timeout /= 20;
-	while (timeout > 0) {
+	for (;;) {
 		if (!it6505_get_sink_hpd_status(it6505))
 			return;
 
@@ -2109,13 +2110,12 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 		if (bstatus & DP_BSTATUS_READY)
 			break;
 
-		msleep(20);
-		timeout--;
-	}
+		if (time_after(jiffies, timeout)) {
+			DRM_DEV_DEBUG_DRIVER(dev, "KSV list wait timeout");
+			goto timeout;
+		}
 
-	if (timeout == 0) {
-		DRM_DEV_DEBUG_DRIVER(dev, "timeout and ksv list wait failed");
-		goto timeout;
+		msleep(20);
 	}
 
 	ksv_list_check = it6505_hdcp_part2_ksvlist_check(it6505);
-- 
2.34.1


