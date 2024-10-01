Return-Path: <linux-kernel+bounces-345331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32E98B4CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE27F1C23707
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB01BE22D;
	Tue,  1 Oct 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="K/qGHo5w"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A21BC093
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765046; cv=none; b=o0uQYg/v6QO+e71nY8mdE8IdWN2c8kUUH9mEOBDlDZi1Ui2WramycBnwYsgXJ3TMmHxhuKxMlerD1EijFzzR5iUMFlLnHvpVOA/hXZk1nQxpcGuyDdJpi9RH2UgS0Fg4GmHo35OV1LmoOjRRNbtw25V/Ro7byNB97jbxOlIwsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765046; c=relaxed/simple;
	bh=8FOsjFx198mYhozMREs2WOjwW2cS+7HyZO1NtyouZKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pucMVW1VtY/VAknJXlfcX+XGmv016mPwKWmeHC5p4oSURF1YheHcSvPTCe3tbL5/fN3jHgxStN0DE38cu0HLtjV3eohVBy2lh8ygX/CNZfyAJ354BMBQaddsvUtVB+xitWiutXj2odH747+8HqobgEsRfEUoZsh2c1wW9fqaVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=K/qGHo5w reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V2EdAEdzD3btVMe5/mlhadiRzTY7Sw5Ay+EzkVgZfxs=;
  b=K/qGHo5wbTSMH8G3yhQaLELGicM9JTHGqVYTpfwxSI/N7/wnU9iCEdWQ
   46uN0uFq4kCHWKHr+7XyWJftdqUuYEhiUufKdbEz3ejLbjRtsfiwXgQWm
   GOsW1d7Qh4UgkdczGCSgFlvL//VP600x6RNo+XndKyY7AwxOrfC+nCtWC
   8eUJE3uvOwIKE0l4OMcGzfdiKVOLYLd3ApLyL+KKMyq37fH7RJDUQiP2Z
   rXYWATJeV2Lpzbv0eyWuH2gUtX4vkOS3kX7ec4CZNb90tZ7ojb3xu5Cfi
   fADNuOcj8x1eT8S3YwRjAu7VY/X2XduydJUKkO+moL1NSDKjlr+qtYXBO
   w==;
X-CSE-ConnectionGUID: DXOcWWKgSWGRW8kOhdXN2Q==
X-CSE-MsgGUID: pyb7IjSpQua4afrArpupAw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 01 Oct 2024 14:44:04 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 4916i0E4045178;
	Tue, 1 Oct 2024 14:44:00 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 14:44:00 +0800
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
Subject: [PATCH v5 07/10] drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
Date: Tue, 1 Oct 2024 14:43:44 +0800
Message-ID: <20241001064346.32269-3-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001064346.32269-1-Hermes.Wu@ite.com.tw>
References: <20241001064346.32269-1-Hermes.Wu@ite.com.tw>
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
	23111BB153A59CFC8CAAC7C8B54136552EB947208091D84FDD590E8ED43017E22002:8
X-MAIL:mse.ite.com.tw 4916i0E4045178

From: Hermes Wu <Hermes.wu@ite.com.tw>

When running the HDCP CTS test with UNIGRAF DPR-100.
KSV list must be read from DP_AUX_HDCP_KSV_FIFO in an AUX request, and can not separate with multiple read requests.

The AUX operation command "CMD_AUX_GET_KSV_LIST" reads the KSV list with AUX FIFO and is able to read DP_AUX_HDCP_KSV_FIFO in an AUX request.

Add it6505_get_ksvlist() which uses CMD_AUX_GET_KSV_LIST operation to read the KSV list.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 48 +++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 319351bc2c9d..7ab0da7fd9d7 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1188,6 +1188,37 @@ static int it6505_get_edid_block(void *data, u8 *buf, unsigned int block,
 	return 0;
 }
 
+static int it6505_get_ksvlist(struct it6505 *it6505, u8 *buf, size_t len)
+{
+	struct device *dev = it6505->dev;
+	enum aux_cmd_reply reply;
+	int request_size, ret;
+	int i = 0;
+
+	do {
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
+	} while (i < len);
+
+	DRM_DEV_DEBUG_DRIVER(dev, "ksv read cnt = %d down_stream_cnt=%d ", i, i / 5);
+
+	for (i = 0 ; i < len; i += 5) {
+		DRM_DEV_DEBUG_DRIVER(dev, "ksv[%d] = %02X%02X%02X%02X%02X",
+				     i / 5, buf[i], buf[i + 1], buf[i + 2], buf[i + 3], buf[i + 4]);
+	}
+
+	return len;
+}
+
 static void it6505_variable_config(struct it6505 *it6505)
 {
 	it6505->link_rate_bw_code = HBR;
@@ -1969,7 +2000,7 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
 {
 	struct device *dev = it6505->dev;
 	u8 binfo[2];
-	int down_stream_count, i, err, msg_count = 0;
+	int down_stream_count, err, msg_count = 0;
 
 	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_BINFO, binfo,
 			      ARRAY_SIZE(binfo));
@@ -1994,18 +2025,11 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
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


