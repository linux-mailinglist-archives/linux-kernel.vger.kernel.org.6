Return-Path: <linux-kernel+bounces-212844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60BE90672E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D7B27528
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90013D889;
	Thu, 13 Jun 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QuUhFJxi"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798413D510
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267950; cv=none; b=QQDMA3XxBZ3w2r9h4VbcaWNW8qmoTFMEXrZN5CS9FkNv6BJCfxT20r3x5/2qA92U2jCOP7edgTZ3XmWSpiOecDS4FD/+WH2M4MxMLgEeAFw+MFNKSuHs0Kaaz94CGINC02IYWNgS/6qn1SRSN9DDWMRArNN03m+kYN7P6xiD1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267950; c=relaxed/simple;
	bh=BrFVqZBE6fRw//oH/EQ+Nbno+gHpRutz6ChIj8eDBd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I60db70epxwfRBpiyjSM+31je38m83U2CfOcjKAhDDvcNXgLC/rorojXg0oTUx4B28qRQHvaSl/zpgVQdrSw6n3SgPRKRSTD8L5SsaEKXc4T/2u3SEkrKtdB0ubnsRiVofMjuoVHbS4PndzVmAvFAeudVyihGuvVSLT/AF+n0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QuUhFJxi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8cB8t105268;
	Thu, 13 Jun 2024 03:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718267891;
	bh=hxJaZU3F0uds8Z+Bth/O87cFW5gYslLc+06BhbqZ6Qk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QuUhFJxiE2fL4CQ6l6BkR+eoJyUYTw1QcGA2ccp6/buNVc5xQDz5PvICV7ssWbmUn
	 VTHFWmuAKEudymu0ZhzEy4L4BYInwFXl2+BNLfbQipGMPrugP3bmbW1obU+N15Zu3/
	 uPqgNksBMQ/O5ZSQZ785l4JacZL+8lPjwsA59/aE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8cBlF094238
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:38:11 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:38:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:38:11 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8cAAV079395;
	Thu, 13 Jun 2024 03:38:10 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <sui.jingfeng@linux.dev>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <sam@ravnborg.org>, <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v5 3/3] drm/bridge: sii902x: Add pixel clock check in atomic_check
Date: Thu, 13 Jun 2024 14:08:05 +0530
Message-ID: <20240613083805.439337-4-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613083805.439337-1-j-choudhary@ti.com>
References: <20240613083805.439337-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Check the pixel clock for the mode in atomic_check and ensure that
it is within the range supported by the bridge.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 00a8c469f553..7f91b0db161e 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -496,6 +496,10 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
 				       struct drm_crtc_state *crtc_state,
 				       struct drm_connector_state *conn_state)
 {
+	if (crtc_state->mode.clock < SII902X_MIN_PIXEL_CLOCK_KHZ ||
+	    crtc_state->mode.clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
+		return -EINVAL;
+
 	/*
 	 * There might be flags negotiation supported in future but
 	 * set the bus flags in atomic_check statically for now.
-- 
2.25.1


