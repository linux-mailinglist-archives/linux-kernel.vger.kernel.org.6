Return-Path: <linux-kernel+bounces-340062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071BF986E39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D5A1F266D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E01A4E7C;
	Thu, 26 Sep 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="TO1TNtER"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD46192B95
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337053; cv=none; b=LUizR79rFd3ZPw2D95rTroA8oykBwTnZULuwIukXQ2ld3+v5NijE+OgEGflPy9Jm5OD9tybzQ0nnKy88OmcX9Mlue7Vrnl7uiof5NWjrvxlG9JUrHk5De079aYcO92ymjog5z/EwodPLaFke2nycrqxHs32Gd/lZ/MEiXc50g9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337053; c=relaxed/simple;
	bh=x3e7NC8nVDuwWF2fUZ0KPuoKP5HJlsCLbHnYxnvZVA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4TPdleT8wQ80vP0Xy5LR8NMtjE4KJ2XuRgiHpXvx4tp+PxuMHzoQJSOQAC0dkrw0V/iIGahAxxk4TX4lE7dTkUE8JsNoFLuIvbBERh/QNnZfPWZw22YdGuPLSJPJfYcuKIAYKWOzowit+bNFrgycZ4yfbrvoXMqPJEQrj1B454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=TO1TNtER reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/ao++Yp0+3fQr8zQsya4C9EhmMYQgHyfnmiUjSwEcg=;
  b=TO1TNtERBcFmcNDIv3JFx7PllK1EftvpQbCh1KyknslKgY8TQwR31z3F
   4ZZnOX38002hETZaebstecXDRnxAN41Ml1haSqh/JqOaYveByJw+s5NVU
   53Rq6Jik4N9mwXRzJuenM0hMfBUVJIu7rg8KRO48ybTDrDxiIOH98skr0
   aF/DWSUrlWp3IsASWedcGDt6QHSBVXHkC1KDC5STsmwm04HdbKDRbw9f2
   h/VRuFq6Xgo1eRtmP8hLqFHqaXoohAGEy2jPcM8IPxREmkZUVpdOxwgZv
   AzALlccyGwWjSxK6edImxDp5S6niNfLR2HpJJza3QWWATZn2hOpXqGqnq
   Q==;
X-CSE-ConnectionGUID: m9GEeuY1SJCJOAcv2y08QA==
X-CSE-MsgGUID: TpHQ18T8Q4CkR5fLpHd27w==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:50:43 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7odxq044818;
	Thu, 26 Sep 2024 15:50:39 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:50:39 +0800
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
        Hermes Wu <hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Allen
 Chen <allen.chen@ite.com.tw>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/11] drm/bridge: it6505: fix HDCP KSV list did not read correctly.
Date: Thu, 26 Sep 2024 15:50:17 +0800
Message-ID: <20240926075018.22328-4-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
References: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
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
	56B4DD55DEE620601EDE7E589AD9E060D9FD9743076137378FEF4F84D86182ED2002:8
X-MAIL:mse.ite.com.tw 48Q7odxq044818

From: Hermes Wu <Hermes.wu@ite.com.tw>

When running the HDCP CTS test on UNIGRAF DPR-100.
KSV list must be read from DPCD with 5 byte boundary.

The original aux operation using AUX_NATIVE_READ can not read back the
KSV list correctly.
Change to CMD_AUX_GET_KSV_LIST operaction.


Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 46 +++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 82986f28f653..143d58ed1b0e 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
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
+	err =  it6505_get_ksvlist(it6505, sha1_input, down_stream_count * 5);
+	if (err < 0)
+		return err;
 
-	for (i = 0; i < down_stream_count; i++) {
-		err = it6505_get_dpcd(it6505, DP_AUX_HDCP_KSV_FIFO +
-				      (i % 3) * DRM_HDCP_KSV_LEN,
-				      sha1_input + msg_count,
-				      DRM_HDCP_KSV_LEN);
-
-		if (err < 0)
-			return err;
-
-		msg_count += 5;
-	}
+	msg_count += down_stream_count * 5;
 
 	it6505->hdcp_down_stream_count = down_stream_count;
 	sha1_input[msg_count++] = binfo[0];
-- 
2.34.1


