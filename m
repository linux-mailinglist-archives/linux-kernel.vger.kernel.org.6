Return-Path: <linux-kernel+bounces-195173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB58D487D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AA1285E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62FC6F31F;
	Thu, 30 May 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="toq1mGqa"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973046F313
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061394; cv=none; b=JfKrejBPjCE9eIFfbPhxpw031SQhOhDXP7OtIfuS/r/UpZYjCQH3PjFL1j/0N98178H88Vu/oVIzkncDL3RXBY7GlJ9GWe3a1Bs5a0KrYdTHEe3aEx7o9/46ceuDe48I3uBUs0gNdgd+C+0BaZ2f6xUnlQaKlh5B61PxvVX2xSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061394; c=relaxed/simple;
	bh=XC3g5s7BdSw9Onxd51Rn/n+oLH1sFYaKH2/WyNbNBZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfUwzMY+4P2VcnJ4WiW/oyunw97bwxGhY/HW4T2HaLndj1xMs5laVo+qWbfebhRND0DzhNI9+bkXFhl/EDnEX2beXhuqwdhNrK6Ym60FLqGDs39UH7SMaRZ7Jeh9yBUHbmahYS1gKD5mHY/8+1ccFDQAKVMNqgO9VC0TidaSpig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=toq1mGqa; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U9TYX1054140;
	Thu, 30 May 2024 04:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717061374;
	bh=grJPsPNsAdWtmQ7kNsLFKUPmiUo05eQ0akmBVIgMMXA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=toq1mGqatqqf8wW2SVuumEWK/J/KN4pnfCy2uJ/Ac+97X0RPLqhcEoAF/JN/yBKO1
	 /mlPUoXr9PMF0K+ZpRvQB2ESEgfFhHW6rPcuuRZVQHjIpgwmPEE4fZnzoQhfvA02CM
	 RTNIQQCx9mKr6J9PW3XUz0PB4f3CM7isJYjYcmds=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U9TYbK124245
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 04:29:34 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 04:29:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 04:29:34 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U9TXSx074224;
	Thu, 30 May 2024 04:29:34 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <mripard@kernel.org>, <sam@ravnborg.org>, <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v4 2/2] drm/bridge: Add pixel clock check in atomic_check
Date: Thu, 30 May 2024 14:59:30 +0530
Message-ID: <20240530092930.434026-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240530092930.434026-1-j-choudhary@ti.com>
References: <20240530092930.434026-1-j-choudhary@ti.com>
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
 drivers/gpu/drm/bridge/sii902x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 6a6055a4ccf9..1bf2f14a772d 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -494,6 +494,12 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
 				       struct drm_crtc_state *crtc_state,
 				       struct drm_connector_state *conn_state)
 {
+	if (crtc_state->mode.clock < SII902X_MIN_PIXEL_CLOCK_KHZ)
+		return MODE_CLOCK_LOW;
+
+	if (crtc_state->mode.clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
+		return MODE_CLOCK_HIGH;
+
 	/*
 	 * There might be flags negotiation supported in future but
 	 * set the bus flags in atomic_check statically for now.
-- 
2.25.1


