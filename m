Return-Path: <linux-kernel+bounces-345325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F115898B4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63384B23FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33931BC08A;
	Tue,  1 Oct 2024 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="baUsfjoS"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C811BC091
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765035; cv=none; b=Z7Ro6JEXnE+OWqY8qYIMtNXPEFRa0ZwbrkLnQVFRso9OTBUc6syis9mEHfiWtyx4DaiybcOsLYs8JvARXm9fE7ChMRUOK0l6XNW2/Q7RPcOgTiWsAD3ohcBK+SMlhK9kY0ReelqL5vyItKZlMk5JASFtRgd+wAJwzJ1sbD2GuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765035; c=relaxed/simple;
	bh=yHyelO2dgTDygUO4rzfUbgTqQT3I2IirX4N6Ndd9fOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0mY1OfkxJ1KX5+mzjgpvEamluxECrbwU3Lqg6+UUC/2fkxFcUuGL+1hf/kL83jQf4fB7wRCA9NZIzvd9erjky3RvxXdz+HJvLzyF9Lh56EJNOFOCgASzm0frQAW6Wr2eo/1P+PAgJDoEW+GM2DbJEbTwP2/ugAW/tZEGT5lV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=baUsfjoS reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOVdcfLLaejTZ04FW0K7X7k0Gm82vG7j5Ayl+B+1ehY=;
  b=baUsfjoSsdm1QNvlg9NQWx1GpFkOpJexUO/LPuC8W+KYTWtIVTsSlpho
   ab06mSHXUcJxuLqQ/Dw9p23IK3S7G/5B5H3IJlisFEDqybcFa4JEFS7UQ
   V6gCif60ZC64JDe0wz88vC3Tcre0jHCici09+2LuQUetiAGQvinPrQWLe
   erjF4XpmZiBrQvpeoQqYAASrV7fAkLXj/ecgpbTevmjUA2lXeOa8UWtar
   G8AtB3h+2gXorln4ouzsGBrv2br5I1nqr0xRouby4290kC9Eg+Gm6lWtp
   5wBmwM5iVkSQtpRJIf6jeJlpRE1NjB9tpXX9JFsUfkoJB4tLr/HoqBoqS
   Q==;
X-CSE-ConnectionGUID: +vF/qAt9T66AD97+DoROZA==
X-CSE-MsgGUID: u5BF51F4TyGGTcxatoxbxg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 01 Oct 2024 14:43:43 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 4916hcPY044700;
	Tue, 1 Oct 2024 14:43:38 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 14:43:39 +0800
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
Subject: [PATCH v5 02/10] drm/bridge: it6505: improve AUX operation for edid read
Date: Tue, 1 Oct 2024 14:43:01 +0800
Message-ID: <20241001064305.32180-3-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
References: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
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
	5EE9CC8EBCDA3A57CFBF942F8AD10D3A8969DF5140EDD4AB68C12FAE65560A512002:8
X-MAIL:mse.ite.com.tw 4916hcPY044700

From: Hermes Wu <Hermes.wu@ite.com.tw>

The original AUX operation using data registers is limited to 4 bytes.
The AUX operation command CMD_AUX_I2C_EDID_READ uses AUX FIFO and is capable of reading 16 bytes.
This improves the speed of EDID read.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 28a8043229d3..864fab7e388f 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1076,10 +1076,13 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 				      size_t size, enum aux_cmd_reply *reply)
 {
 	int i, ret_size, ret = 0, request_size;
+	int fifo_max_size = (cmd == CMD_AUX_I2C_EDID_READ) ? AUX_FIFO_MAX_SIZE : 4;
 
 	mutex_lock(&it6505->aux_lock);
-	for (i = 0; i < size; i += 4) {
-		request_size = min((int)size - i, 4);
+	i = 0;
+	do {
+		request_size = min_t(int, (int)size - i, fifo_max_size);
+
 		ret_size = it6505_aux_operation(it6505, cmd, address + i,
 						buffer + i, request_size,
 						reply);
@@ -1088,8 +1091,9 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 			goto aux_op_err;
 		}
 
+		i += request_size;
 		ret += ret_size;
-	}
+	} while (i < size);
 
 aux_op_err:
 	mutex_unlock(&it6505->aux_lock);
-- 
2.34.1


