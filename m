Return-Path: <linux-kernel+bounces-345329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88E98B4CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820E71C2171A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB101BDA89;
	Tue,  1 Oct 2024 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="bZ9O2M5K"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032F1BD028
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765038; cv=none; b=AR8niH6d/s1GVbxWCU/BpObGsAqq5/Till1HltkM2udMo5PEnx/sWOLBA3Tksl/PXXGMU+aV/zxgxfy/d/kdXJvRuLpQMuNOAErp6h4ZFsOTJdkNp90bUH1vNcO087YyGWrPi+YrX5tBq6jbgdyxwmy+pHvWTYSkO4GiHCdCXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765038; c=relaxed/simple;
	bh=qG/T3gNC/pBEkzXLQAnLPyal+m+b8XPcE0IRDPFZAWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMKWsSLu6IpL3lDbASnRPMKU+x5IiZaqUkDnKDUpHIcuXoqx96HvqnJIVfq+5E6MUSrt5786kBBIZNbLdk4RZnAt3sJ3PAaEF+Vv275wkkhwGM+/G/Yt3qOxmUGphPQVOF+/cEqMXgCh3dfnb6McB1AGHfPXT0xICnkvwzKjtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=bZ9O2M5K reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Tdty8wFO9Dc6MKV0yxzEoMBKdeNuIXNkznATBAcpTU=;
  b=bZ9O2M5KB5lR7XAoGPZZaN+Y7+Wm20XthEDNwwSDEHRXw7jIURdHnrZN
   NBEoU+2DdZYErcXFmfIyz0EHjWyba8O6YhUKlGVV195GUPwDmxvF5H0vD
   KUREzePgQrTzJR3XIS/5I9L+FR3J10DZ9Z2JBVnRaWvLoqqHeUfqqylSF
   Lg02g7lPvw3P0qks948BqglNggo0O+IVQqZNXBXqbfvGMAiOymfD3+W9O
   fvphwxD+HGKCBxd0Qj5SO+qRDi2GILa4EeNnQT2BFk6EPsg4s3XfDGT8j
   PUcYG7i/cLahm6QFyjpqPytvkLw/0STldT/67jJX4ATeaBsHO0mR6JjrV
   Q==;
X-CSE-ConnectionGUID: 5yVs8wgQQ+mSVVcc9CBcbg==
X-CSE-MsgGUID: oMi8tN63THWEh9Cweu0i/g==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 01 Oct 2024 14:43:44 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 4916heak044772;
	Tue, 1 Oct 2024 14:43:40 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 14:43:40 +0800
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
Subject: [PATCH v5 04/10] drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
Date: Tue, 1 Oct 2024 14:43:03 +0800
Message-ID: <20241001064305.32180-5-Hermes.Wu@ite.com.tw>
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
	0ACB4DA3C9E7508992408467426A36754C2FFA43E206D5790EDD9C8CC1B7F6212002:8
X-MAIL:mse.ite.com.tw 4916heak044772

From: Hermes Wu <Hermes.wu@ite.com.tw>

A HDCP source device shall support max downstream to 127 devices.
Change definition MAX_HDCP_DOWN_STREAM_COUNT to 127

KSVs shall save for DRM blocked devices check.
This results in struct it6505 growth by ~0.5 KiB.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 9a022c095af4..dde45e9b0f20 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -297,7 +297,7 @@
 #define MAX_LANE_COUNT 4
 #define MAX_LINK_RATE HBR
 #define AUTO_TRAIN_RETRY 3
-#define MAX_HDCP_DOWN_STREAM_COUNT 10
+#define MAX_HDCP_DOWN_STREAM_COUNT 127
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
-- 
2.34.1


