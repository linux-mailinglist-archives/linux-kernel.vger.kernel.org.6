Return-Path: <linux-kernel+bounces-397943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D129BE2C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21557B20B55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481251DD525;
	Wed,  6 Nov 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RDpTA2h9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF41DC194;
	Wed,  6 Nov 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885801; cv=none; b=Ed/3lU7w03gJu28axBLUE7wLArTNed1dp1QxQxnUg8GQh8ccLgWih6LGJSZy1J13mjvlwuryVz5d4l+6MmlZVoq8Sk9e3ZUFqrrmUz09SqMBDPn2BoZCXTrqN2k3cu3x22lSSbUoVCCFyNLOKZQgjyV2L7BdhKB64sFX7xcEI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885801; c=relaxed/simple;
	bh=to+XTp4IW8kAmb6A0rvJQ9ZF113lclX2U2Y8R7lLOIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cB/Tsff4tgwrTjx4BZckpztqNNhkQbOv1WG3Rj0hSCX/e6rFEyQSngSdWR/PzZQ59+1BjsEDbG24klBZY+V2pmSSeOtE+gofEibeNmrs9sfDHkFOcjSidHoCtugczWRUDs4+yKsQB3TfPlHRTHLfeTdJOsHkAyOs0E9ZJtYiIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RDpTA2h9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730885801; x=1762421801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=to+XTp4IW8kAmb6A0rvJQ9ZF113lclX2U2Y8R7lLOIE=;
  b=RDpTA2h9EytQO9vT9fo2YfnHmA+K8ndps64NXH3vjefH+F4keK2MhPIA
   GcNhAepAMFM+BD9kNB640wgeOI4fIq/JzckpzQuhtQ4Fmo9p7ObtZyuu2
   VG38Fc78yFWIoRnN1rukvJahNk9lpzZY956EuNcqNf8ijsoPcEmlBF/hr
   +Cu6fqKbrSR5fvCAb1cqVwzdiH4BnIKULpO4T0rjsK4Vb2MjnZ92ARJ86
   HGkEyiSpbJINWUApH/kfIeBMkiTx4KBKgRkSzswt/++EgwW7vVf6scKTd
   SsELUcbYkfzhBmFr1wsNvHG4lpf8luADb3Bi2zVP+Og32fs84TaWXTyML
   A==;
X-CSE-ConnectionGUID: GdrssbasS4SjtXCG3mVUjg==
X-CSE-MsgGUID: B81mhcyURqmNrHtP1uP9/Q==
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="33940997"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2024 02:35:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Nov 2024 02:35:20 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Nov 2024 02:35:12 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<dharma.b@microchip.com>, <arnd@arndb.de>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v5 3/4] MAINTAINERS: add SAM9X7 SoC's Microchip's MIPI DSI host wrapper driver
Date: Wed, 6 Nov 2024 15:04:28 +0530
Message-ID: <20241106093429.157131-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106093429.157131-1-manikandan.m@microchip.com>
References: <20241106093429.157131-1-manikandan.m@microchip.com>
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
index f5dc00438ba3..77228b16425a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15272,6 +15272,13 @@ S:	Supported
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


