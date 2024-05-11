Return-Path: <linux-kernel+bounces-176608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871218C3224
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4CA1F213BE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D67556772;
	Sat, 11 May 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B0oG7SBz"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC31E526
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715441500; cv=none; b=qjBCNAhCKlqqt0apdtYkEK4On4Wf2+n7PR8UdZU43P+tpZtxfR39ccZQGbM+EgDDAr5+wHkfeu04C+HUHv+d1O3B/w15aXZvbSXQj6XkNxrzvlT+ew0AjJuBOq+ejq3pDkZdR+QC0DW9oabzGe3GFnUU6yzlNzur/Ks/hN63qDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715441500; c=relaxed/simple;
	bh=IX7XsOyOVzCtA2UY/f7d1R1xikEA08HJCbxKjGBTF5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM9TOzIuNzeNqnI5ZqewJOuUNNRr+OK76hiIZdtOzNCLBSkFn+Dxf0s72UYXjEznbCzDhd1AXsZJVLVpoE4dusDAkcrV5gafCBUziOtoAb6l0SvjPfUnqysJrjyFLI9vLZplrclrk+LU20nRviuIPAlio5/o6Gc0ptugJrxINMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B0oG7SBz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44BFUsiL014460;
	Sat, 11 May 2024 10:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715441454;
	bh=rTTLXewRMxGRuVDb1qnoAQIUWX9dew+c+9tpW5wzk78=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=B0oG7SBz+v35Te5KAiaNyOQiFGuJp9B1yIpJOIoXaCwdWj1vEUPjYk5iGdUiSGfcM
	 Wcvs6amqo66AvQgNRPyP3lIRFApNpngx+UIrEmopyFfVGFC4O5+Gh1S3n9nSdOGVhe
	 UfLy7Iie+Qez+ao+PBcMOGnLpUByuq64R6BryiHI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44BFUsOk032982
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 11 May 2024 10:30:54 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 11
 May 2024 10:30:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 11 May 2024 10:30:54 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44BFUr1f043147;
	Sat, 11 May 2024 10:30:54 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
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
        Maxime Ripard <mripard@kernel.org>, Jyri
 Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Thierry
 Reding <treding@nvidia.com>,
        Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
        Boris Brezillon
	<boris.brezillon@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary
	<j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>
Subject: [PATCH 1/7] drm/tidss: Add CRTC mode_fixup
Date: Sat, 11 May 2024 21:00:45 +0530
Message-ID: <20240511153051.1355825-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511153051.1355825-1-a-bhatia1@ti.com>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for mode_fixup for the tidss CRTC.

Some bridges like the cdns-dsi consume the crtc_* timing parameters for
programming the blanking values. Allow for the normal timing parameters
to get copied to crtc_* timing params.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_crtc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 94f8e3178df5..797ef53d9ad2 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -309,12 +309,23 @@ enum drm_mode_status tidss_crtc_mode_valid(struct drm_crtc *crtc,
 	return dispc_vp_mode_valid(tidss->dispc, tcrtc->hw_videoport, mode);
 }
 
+static
+bool tidss_crtc_mode_fixup(struct drm_crtc *crtc,
+			   const struct drm_display_mode *mode,
+			   struct drm_display_mode *adjusted_mode)
+{
+	drm_mode_set_crtcinfo(adjusted_mode, 0);
+
+	return true;
+}
+
 static const struct drm_crtc_helper_funcs tidss_crtc_helper_funcs = {
 	.atomic_check = tidss_crtc_atomic_check,
 	.atomic_flush = tidss_crtc_atomic_flush,
 	.atomic_enable = tidss_crtc_atomic_enable,
 	.atomic_disable = tidss_crtc_atomic_disable,
 
+	.mode_fixup = tidss_crtc_mode_fixup,
 	.mode_valid = tidss_crtc_mode_valid,
 };
 
-- 
2.34.1


