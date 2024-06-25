Return-Path: <linux-kernel+bounces-228658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6564916501
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65F91C2227D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0D14A08B;
	Tue, 25 Jun 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2AxX31OL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80713DDC6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310262; cv=none; b=a3TyQ3wr80kjGgBCRfoU5N2KrBae1EeicF6RGA4Pc2Oa/uhgUMXerPz/kslxHPilxHKWQbNkJIWPqbuCK7pom7d4jaJqK6xqdrD4jKfKhpMJ5A0Y0MW19oEmzfpoSfeeoyk4cYKYoam3jWfddY+OraLQUbCm6xT5fJFj9eR+E5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310262; c=relaxed/simple;
	bh=MSWdBc8PKBdJ0A0i1o2EiwRYZcdlsnekjW41CeUrTk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uN1c2p1YIa383YWC8ZbkSCaog45clgPdPewgeSEIPF1r2YfGHG5uXMtZNvZuDdyt40/Q1KDN6q++RCnGl49Ay76mc4Bu57e6FYID3/A+P7AaUyIFXpynxoyzf5+yN1eZ991cJEjU961iWbskk8hhic0rUVs6WKE7CZWVtsttrIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2AxX31OL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719310259; x=1750846259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MSWdBc8PKBdJ0A0i1o2EiwRYZcdlsnekjW41CeUrTk4=;
  b=2AxX31OLgB3lS57TajLwFOePGHpiriHuvUKDXulnExDYMTHkxMBhfQEd
   BCQ0HpnAtXBCxH9m3aBmMgRTBFguDylDlqLVrdL1ZlHhNHEWDUFNyCkdJ
   pB802kSd74EtcQt023eRmqjK7H+Q06wGtcPNfa1KXxET2sKVo5YIDed+p
   nAC3A6gU2Zz7J6lXANJg4W2mVToLXsUzYPAKRH4WsjIqfzHypGN0lHxH/
   XUAef1+ciwzqchRw80Z9h9LaHvkKxAp0BnAGzZeW6y2Mwcpoa/Beyr9Yz
   VGI8IlkcabVVPpufwM4gV61Dp1cBYt6fVrawN7PUAuCAKnrbnx1xJgVHk
   w==;
X-CSE-ConnectionGUID: iHJbrbJ5Qxy40j7Wq5Z2LA==
X-CSE-MsgGUID: 6D9jdcc8SOWoH738OpHbtQ==
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="31005830"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 03:10:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 03:10:30 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Jun 2024 03:10:25 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH] drm: atmel-hlcdc: fix static checker warning by initializing the local variable
Date: Tue, 25 Jun 2024 15:40:30 +0530
Message-ID: <20240625101030.373965-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Initialize the local variable used to store the status of LCDC Channel
status register of each layer to fix the static checker warning
reported by smatch

Fixes: aa71584b323a ("drm: atmel-hlcdc: add driver ops to differentiate HLCDC and XLCDC IP")
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4a7ba0918eca..4150c4d0b4f2 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -559,7 +559,7 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
 	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 	struct drm_framebuffer *fb = state->base.fb;
-	u32 sr;
+	u32 sr = 0;
 	int i;
 
 	if (!dc->desc->is_xlcdc)
-- 
2.25.1


