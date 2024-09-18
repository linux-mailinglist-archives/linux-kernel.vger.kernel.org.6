Return-Path: <linux-kernel+bounces-332530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE597BAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9675B1C20E63
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9ED18893D;
	Wed, 18 Sep 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YwR5b4Ot"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409917C9BB;
	Wed, 18 Sep 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655543; cv=none; b=M02QQyZdBK9by4G9bKUeL2XvnI8CSu/Gmd1AbbGFRBxGaK9OMxD1kCkKl3xd/Tb/5YKETEqFXpDJibNXs8Gx4xgsJY4TlUtycSkMrLINyQgNAskIfIC70M8/uGo2VhxqKOL39D/Nvb+aH349tWLG23YsptLV9FbB/KBZb3/Gk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655543; c=relaxed/simple;
	bh=aneck0p7nY/G/FoVB3Oq8sKnXIBqstZG0l7fh3E4DHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LR1t0fDex43Eyg6utYkFstG/5RsdbZSe2FL88Sb07SQoytXS8ecw+zdOnKR3y2+W0taGhSGmKh22VBJDU5m96he/fmoX16QnhpdF8SRf3L9vWDFwZINTYfUoFO6D6FCHEpKkcFrD8c8eRsNDsMKX2EIxa4fN5ah5ank6YNMgKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YwR5b4Ot; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726655541; x=1758191541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aneck0p7nY/G/FoVB3Oq8sKnXIBqstZG0l7fh3E4DHM=;
  b=YwR5b4OtIJrsSg5ZqHkVTb26ENSmDHvKcMpg0uDwlUPAIGUwAcqLzsz+
   DvvCllINlW5J1bXCond02lRuZFWFX9qg8NVZrpoPV9HBfOUxNX9UF/a4E
   +xIK0pKsaBTaajdhfwgWZlEVZvMk55E9NF4FgdkriuFLnUflbfgPPmX0K
   VTvz9r5xfmYBPFgtvnN1coe0eY2xm/k/faZu6RE5/DASPOh3svsc6cWkj
   Lj33cHjh1eelEZnWHjng9131GvbDFIar38X2EK5C1E3dIcT6cr+k0q9j8
   K9X/t6jWzfYimKVEpWUo0JVUF/9JoSWE4dECjR6ZOSdKGsNLDJuAO7LCX
   A==;
X-CSE-ConnectionGUID: u1rM2jTbQye/0AWlcIXYhg==
X-CSE-MsgGUID: UiGWGq4+Q5SsZ1s1JENHjA==
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="32558784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2024 03:32:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 18 Sep 2024 03:31:52 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 18 Sep 2024 03:31:45 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>, <arnd@arndb.de>,
	<hari.prasathge@microchip.com>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v4 3/4] MAINTAINERS: add SAM9X7 SoC's Microchip's MIPI DSI host wrapper driver
Date: Wed, 18 Sep 2024 16:01:18 +0530
Message-ID: <20240918103119.385597-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240918103119.385597-1-manikandan.m@microchip.com>
References: <20240918103119.385597-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the Microchip's DSI controller wrapper driver that uses the
Synopsys DesignWare MIPI DSI host controller bridge for the SAM9X7
SoC series to the MAINTAINERS entry.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
changes in v3:
- Drop T: section
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 333ed0718175..10b3a2b99717 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15103,6 +15103,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
 F:	drivers/gpu/drm/bridge/microchip-lvds.c
 
+DRM DRIVER FOR MICROCHIP SAM9X7-COMPATIBLE MIPI DSI HOST CONTROLLER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
+F:	drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c
+
 MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
-- 
2.25.1


