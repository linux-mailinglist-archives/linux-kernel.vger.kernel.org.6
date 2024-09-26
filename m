Return-Path: <linux-kernel+bounces-340051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493C986E18
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE3F283B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2DF19AD56;
	Thu, 26 Sep 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="JLwBQPLn"
Received: from ironport.ite.com.tw (HC210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E3192B6E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336912; cv=none; b=K30yDc/tVFdTerGA8hKkuha6izD4wG5eBJ4cjc3HOndA0ONAJdvY+8SRYqHVKhZu/ftxnhvyfKfFFrGFlYMsB/N5HxvpYMl2ql+f5FSk9RnQDemJ5izVgADsGwapeF3Io5P6E2cUizUlO18wwtd+BG32V/jluDtEahzAn8f9Qx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336912; c=relaxed/simple;
	bh=kJ5+knP0ObG4s2Q2HBaUOK+ELIOZErFL7axBHk35rNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Va1w2SW00wgm3hEzOIbl/4aVVJBhn2+3VHIlIVUQPtxwJ6EKe+iQXoWrnZt15rPvl7eCs3UWBwOUPcu9P6xGn7jFyT16wr7B/L5JTAMNov5R384i5uwD+LGXlqtjFpqY8in4kte+R122N765yN1Ff9bu09zAhxyXTF49W80/860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=JLwBQPLn reason="key not found in DNS"; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNkH/s8qpW5E02FCg3VGS4CSNm0HyAesFRq6kHlLN/8=;
  b=JLwBQPLnc0sIdAyCfHhHNwel1rPPXtJJ1nIpojo1Vs4ivTSjCn8r/a8P
   on67bEeCqAKTv7Xrq9exTNFHQK0Kkx4S1puFNG8d9hJPVKZTsrs1GQeMy
   LBWqqHDmyyCX4WyDYc3m8HGUj+Tv7Yi6GyNTVVN4Hd7LBVIwlMI51884m
   qtTptmeO+kcCa2xY0q35XZanpJ1RnxXdFPF9DI0EeSa43oOQ8g/FnD5Df
   TtXd++lTD3XDJxTZ/OcrfEyvAiyOFpdwNnc19xGDi2HwB3fb5uCSIWJvz
   KjRszuphaIrBFjAxScXZ6M8iy2Wud+jaNR9g9ltzO/SdmVAiKemG6eBig
   A==;
X-CSE-ConnectionGUID: OpN1oIcwTUyGD1ppPDhr/g==
X-CSE-MsgGUID: Yp/w1hoIS8iVdZcOyumrUA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:48:17 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7mDSX042911;
	Thu, 26 Sep 2024 15:48:13 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:48:13 +0800
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
        Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/11] drm/bridge: it6505: fix aux operation for edid read
Date: Thu, 26 Sep 2024 15:47:52 +0800
Message-ID: <20240926074755.22176-3-Hermes.Wu@ite.com.tw>
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
	E99080911418C56DF22DDB100D7294E86E782C6E84D879CFEF356C8A8AAD8B572002:8
X-MAIL:mse.ite.com.tw 48Q7mDSX042911

From: Hermes Wu <Hermes.wu@ite.com.tw>

The EDID read operation can reach the maximum size of the AUX FIFO buffer.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 28a8043229d3..b451d3c2ac1d 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1078,8 +1078,11 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 	int i, ret_size, ret = 0, request_size;
 
 	mutex_lock(&it6505->aux_lock);
-	for (i = 0; i < size; i += 4) {
-		request_size = min((int)size - i, 4);
+	for (i = 0; i < size; ) {
+		if (cmd == CMD_AUX_I2C_EDID_READ)
+			request_size = min_t(int, (int)size - i, AUX_FIFO_MAX_SIZE);
+		else
+			request_size = min_t(int, (int)size - i, 4);
 		ret_size = it6505_aux_operation(it6505, cmd, address + i,
 						buffer + i, request_size,
 						reply);
@@ -1088,6 +1091,7 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 			goto aux_op_err;
 		}
 
+		i += request_size;
 		ret += ret_size;
 	}
 
-- 
2.34.1


