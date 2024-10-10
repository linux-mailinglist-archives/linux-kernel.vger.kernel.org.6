Return-Path: <linux-kernel+bounces-358673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E802998245
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5128E1F219C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D11AF4E9;
	Thu, 10 Oct 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n6NBrxOl"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200D33CE8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552762; cv=none; b=MMUsGYVDhopcAeBkSgZEvFgISUpAn0Z72bt/iDlCBokCu4m7HI3Ktpi4azuF3h79fcBuz4oFp2f7QcSe0zqE5XRna25CgQNp2lum51FojQ4PEVLNv65WuuO34yTFbxpLyJnw8ybRQnh2Zr9ecA+Z+CEjf0naAXLgLuK5jmaAIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552762; c=relaxed/simple;
	bh=FUvEZdexLb0egQbluawfFMb4prI6pmJNwKqr+VU6HKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ogqfkXjWAO973+AGHZU3dtmEwiaFz++7N7VT+4pY1KEaQe2D6L9HG6U8qhO7gFeA28Ilr/f36MQqYsbIr87XDWHaxxYeiGBn2Eg10PuvHQ7WIFyas4wAEClejrzYV8CKzXzqZpRnhv9EeeaO85XNpr2YB0/2EyvHWVD0SywXS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n6NBrxOl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728552761; x=1760088761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FUvEZdexLb0egQbluawfFMb4prI6pmJNwKqr+VU6HKk=;
  b=n6NBrxOlrxGlQMqfwfYXNIyz1TAEeJalk4Ecpgp/qyz0/ZnmRKQb0t6+
   7aTRfC0S+KelFrhFW77v0Tkv4Ubwx8Thy/2JmMjjhldHHLGYLGLkN9LS3
   yD6okUahlROOtRwyVzhhsaTobxbo+mULyUu45oRdMKkRloZRqvdiNz0xe
   LKmphDbfw2cTA5Wq2EVGFTd/RjxR32v0o8QqGwQejBCVVxwRo6iy7w6M5
   98h62I7zo77TBi8p+xn9gavd3eliY7WY92uz8A8Mzi529yeQkWvXNWgBp
   KTwW0njfPfWh0hglWIPyCMBD7FYWX8BRCHrSM4SRf8Z/bJX8ipDK5pxE6
   g==;
X-CSE-ConnectionGUID: BI64UNzWQKuKyeV/WF2pRg==
X-CSE-MsgGUID: zJmBcTWPSqOC/FlSmuLgQw==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="32833320"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 02:32:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 02:31:44 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 02:31:39 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH] drm: atmel-hlcdc: bypass LCDC pixel clock divider when using LCDC Generic Clock
Date: Thu, 10 Oct 2024 15:01:32 +0530
Message-ID: <20241010093132.235177-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In sam9x7 SoC where XLCDC IP is used,add support to bypass the LCDC pixel
clock divider when LCDC Generic clock is enabled.Used to match
and drive the panel requested Pixel clock.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 8 +++++++-
 include/linux/mfd/atmel-hlcdc.h                | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0f7ffb3ced20..c54770cecaa8 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -146,13 +146,19 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 
 		if (div_low >= 2 &&
 		    (10 * (prate / div_low - mode_rate) <
-		     (mode_rate - prate / div)))
+		     (mode_rate - prate / div))) {
 			/*
 			 * At least 10 times better when using a higher
 			 * frequency than requested, instead of a lower.
 			 * So, go with that.
 			 */
 			div = div_low;
+		} else {
+			if (crtc->dc->desc->is_xlcdc) {
+				cfg |= ATMEL_XLCDC_CLKBYP;
+				mask |= ATMEL_XLCDC_CLKBYP;
+			}
+		}
 	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
index 80d675a03b39..982f494e6307 100644
--- a/include/linux/mfd/atmel-hlcdc.h
+++ b/include/linux/mfd/atmel-hlcdc.h
@@ -44,6 +44,7 @@
 #define ATMEL_XLCDC_HEO_UPDATE		BIT(3)
 
 #define ATMEL_HLCDC_CLKPOL		BIT(0)
+#define ATMEL_XLCDC_CLKBYP		BIT(1)
 #define ATMEL_HLCDC_CLKSEL		BIT(2)
 #define ATMEL_HLCDC_CLKPWMSEL		BIT(3)
 #define ATMEL_HLCDC_CGDIS(i)		BIT(8 + (i))
-- 
2.25.1


