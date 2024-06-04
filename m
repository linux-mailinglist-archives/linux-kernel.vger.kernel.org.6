Return-Path: <linux-kernel+bounces-199968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2348FA84F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AA81F24E43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441A12BF30;
	Tue,  4 Jun 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="GeCo7aEQ"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2606748E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717468489; cv=none; b=jrL5CX516bLLg5/t1a9PfliZ8LuacfR7WqrQmDcJSehKc6DSTRV27XhVy8eZUmA75/U0IEXdwSc9KSITOv81FDFY4l6BMsztNSjXKXDKwbeCD/BKy5cGiLi+oFxabKLbdNpEjKwyjAYXAuNNUizY5lpe5c9OP6yYAZFF70YzIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717468489; c=relaxed/simple;
	bh=EpJwlD2h3adGfeCbQchhxLhcjWAtcTed5L8RgNwp3lY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qlaB/ridq/w7PiOhbAFL66ZtjXmY0FKhZ2ttY1bzDhc//8kkxnOhTSIISKr0upPtIpUjbClhWxNWz1xQaAMmntprIWI32vDFUdg5XDK3c1+9ClZBO0fjHSS8zH7xBEG3UaROn2XiQ0ql9a3py6VjSst7ysLjVXKNdX0UHGrU42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=GeCo7aEQ reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ongMRIDR9OJ67FPX959hIpLFcH5SoR5ACjgPGkxuvD4=;
  b=GeCo7aEQ1VpT4jZAxcyOm1qtfTcaSRkOQb3oIQ6N4/RitTv91zl3v7p2
   3FGdDznDNM1EOv6ggm/o8P58uuUH9jM+0iaQaA4pqsQAeTxDsHgMyo4LU
   2rUzIQFszOSoJDTiExz0AFmd0n/dXA2fIa/lEMNmExebDLunacE2/LRGU
   epMgXb3CfMHRTKKI7mpB79qXpCnBAinbf5cw0dF7mES09w7oLBoMNEjJl
   I3+aujMj8ewG3WBTU0kH3UdyUXpy9/MFAmMFCwraWpRWSGXqD9+5GBmcu
   hGdwL27XEWvVES0OW17plPTFjXprC8+z7Dm/BGAGac0o+HaACJg6NEiLU
   g==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 04 Jun 2024 10:33:34 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 4542XTSn057581;
	Tue, 4 Jun 2024 10:33:29 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 10:33:28 +0800
From: kuro <kuro.chung@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>,
        Kenneth Haung
	<kenneth.hung@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
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
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Kuro Chung <kuro.chung@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>
Subject: [PATCH v1] drm/bridge: it6505: update usleep_range for RC circuit charge time
Date: Tue, 4 Jun 2024 10:44:05 +0800
Message-ID: <20240604024405.1122488-1-kuro.chung@ite.com.tw>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	A32F6B6386882D419C459589941F989605B411FE5A98B4AC4E9B5DC4CAEDA3DC2002:8
X-MAIL:mse.ite.com.tw 4542XTSn057581

From: Kuro Chung <kuro.chung@ite.com.tw>

The spec of timing between IVDD/OVDD and SYSRTEN is 10ms, but SYSRSTN RC
circuit need at least 25ms for rising time, update for match spec

Signed-off-by: Kuro Chung <kuro.chung@ite.com.tw>
Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index cd1b5057ddfb4..1e1c06fdf2064 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2615,7 +2615,7 @@ static int it6505_poweron(struct it6505 *it6505)
 		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
 		usleep_range(1000, 2000);
 		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
-		usleep_range(10000, 20000);
+		usleep_range(25000, 35000);
 	}
 
 	it6505->powered = true;
-- 
2.25.1


