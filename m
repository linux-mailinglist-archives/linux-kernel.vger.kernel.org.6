Return-Path: <linux-kernel+bounces-212842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1931C90672C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F001F21648
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8F140E5B;
	Thu, 13 Jun 2024 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KTAYPLxW"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C956140391
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267932; cv=none; b=f1DlHM5QKwtJq8otB8gUK/PmFfbI6kTFWO07TDzOKXeCkz8Jwjn8M17ZI+JSWPUmcHRAFN1Scila+DIKQurEVGZbDPsJSs5evaWPd7kXOp0qhWO6c5CQtni2twW86twRe+URd9mlxCu6rOpAEXKWdelFgdS0rvhpiYCF+bxEFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267932; c=relaxed/simple;
	bh=MWNouuqSZvXZjJDbEM92fUobJMR1CVQGZ+VNuoHMRjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqeRTn2jjyWUBnGHflPMuApROmfggHdl/jh7zO+l+5BIssAUXYbmxST+p4XaiBwG9LysosYndPAJokDl175oAWdxiIWfVWNpJK5U/3H/sdqifWTd0vVA/BN6UMtC1/EyWXARRrteAo2f6zkzxic13M9elX5EWHWUhNbRH7ALVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KTAYPLxW; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8c9oS013085;
	Thu, 13 Jun 2024 03:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718267889;
	bh=rnfhvDvJw5BDb0tI21qEyro5d0f4cvwu1uctUDeRUpc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KTAYPLxWLKkYWkwONUUxW3pMU9WhDSsscu7nOS6HFs5iZ/o1CudEngNXvmMiZ5QsI
	 XbagrNcU+LQhsTMQ0sFEn4iFW5n7rZ2Gbw+3515qhWbQNWVV12Jj4c+N5Hr4fdzZQV
	 sPCTx7amKyAAFrqQg8TBIP1Xcy6TbTtv1eqYEfQs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8c99d094221
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:38:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:38:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:38:09 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8c8hb079355;
	Thu, 13 Jun 2024 03:38:09 -0500
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
Subject: [PATCH v5 2/3] drm/bridge: sii902x: Support atomic bridge APIs
Date: Thu, 13 Jun 2024 14:08:04 +0530
Message-ID: <20240613083805.439337-3-j-choudhary@ti.com>
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

Change exisitig enable() and disable() bridge hooks to their atomic
counterparts as the former hooks are deprecated.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 6a6055a4ccf9..00a8c469f553 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -322,7 +322,8 @@ static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs =
 	.get_modes = sii902x_get_modes,
 };
 
-static void sii902x_bridge_disable(struct drm_bridge *bridge)
+static void sii902x_bridge_atomic_disable(struct drm_bridge *bridge,
+					  struct drm_bridge_state *old_bridge_state)
 {
 	struct sii902x *sii902x = bridge_to_sii902x(bridge);
 
@@ -335,7 +336,8 @@ static void sii902x_bridge_disable(struct drm_bridge *bridge)
 	mutex_unlock(&sii902x->mutex);
 }
 
-static void sii902x_bridge_enable(struct drm_bridge *bridge)
+static void sii902x_bridge_atomic_enable(struct drm_bridge *bridge,
+					 struct drm_bridge_state *old_bridge_state)
 {
 	struct sii902x *sii902x = bridge_to_sii902x(bridge);
 
@@ -520,8 +522,8 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.attach = sii902x_bridge_attach,
 	.mode_set = sii902x_bridge_mode_set,
-	.disable = sii902x_bridge_disable,
-	.enable = sii902x_bridge_enable,
+	.atomic_disable = sii902x_bridge_atomic_disable,
+	.atomic_enable = sii902x_bridge_atomic_enable,
 	.detect = sii902x_bridge_detect,
 	.edid_read = sii902x_bridge_edid_read,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
-- 
2.25.1


