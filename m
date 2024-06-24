Return-Path: <linux-kernel+bounces-227039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FEC91478B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF90A1C23533
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B78A1369B6;
	Mon, 24 Jun 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O48isUFY"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A84D8AD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225110; cv=none; b=DiJ/8KHBSf4I2UCXPt5Vk8e17PQHHHiANNfUeMGnVBBPxoC+aA2Y7iwxDznljp7DdhFOcgz4r4ajl0q9V690uU4i/3sjnJRMiy0NfQbpV5VD70Om9/Bp1WX8V5I3mHfA2LR732aZrJyVrtO2KZzkVH20y05O/6TBYaq60iZUM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225110; c=relaxed/simple;
	bh=eCJNHKpOFyvKm0QEDNLeKYcgJDFGN4EGDIDzjHn6FlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t+MumpqiOvbbn55qu5wAQ/gUIHC/Znq/W1gYTk3M2koFuwCaLhgVy7FUgx1FTEAwN1HAKA4chlrqPW3B3lPovojEoIEfRmZHrCGKZ1gBLXMrKc/syfIIaQ9eJs4lXJeWivg1z75YzuJYU2iAI7TI6cfwV7Lz4xmYY7DUDhZgy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O48isUFY; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso2423929e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719225107; x=1719829907; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y79rUxm3lgbaqaUYltDlAHQT1o1yNbGd4AJC95vHYik=;
        b=O48isUFYYrODYAJk9BAyvFONu4DmHAh2chG31Q2n7UG2p/AMnAEabrHQmQoH7JNn0U
         qcUVi5fdBSMduvW/g6+WG976ZGxqcGOij4aK56NE8RjhmcjIUuMr5+Te1sNudUI1syjr
         s0C688Kucr2wMtQ52bjHLa8PnWIMaVCpSSfkgws8VPwdmRamqhzeIebuxJkYEItsyooo
         U7ww7kdNu5eWgI7z5HlG65b6TMLHO0kQ1cqrDd4fs8xMS9FiyvOdqLQXugiiPEGyrKGh
         nKC4KsQbDQCycAkR4eWJPG9dmdOl1eWpZ5IcISn8PdJk2YqfOaTzk2v2HcXawoGrNbjo
         ClLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719225107; x=1719829907;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y79rUxm3lgbaqaUYltDlAHQT1o1yNbGd4AJC95vHYik=;
        b=b3UPOg3DJIts9LgcMlypbr67vhJCwh+p7Z4tCWZL54VFh50tRF2xL7O0e811kAQqmA
         TI5XZ6E1FGtlfxS4K/GKTTimuXaa+iBInt3PR5+DwMKrtrqcrTvvR9FBNGcOWFCMc6pO
         6fS20p3OHVDFDM0GB0sPh98NTtrHtvUpRGmrfy6U7l5Lbv6xUjh7l21szKnBH4MpZiHn
         Xu7KHiXkPKe7Gf3CsRgYds062fuaAvG9KCn2kBXPmYG34tiXa5ovMtrLL9hYDuluwBxu
         EGJLGnPc8zO14iyW+ZTW0DDenpSsea37Vh1KxQjga5kIJ3yG424ZkHVlJ8+49hr7N4ZU
         TFsw==
X-Forwarded-Encrypted: i=1; AJvYcCXo/TvspzozahZRj2E6T1sw+jPPqBx0Myc3zzoeMPbc6PPVxlTUlIR9inOUgH5XSp5TuWUftln72hh46SvDLg1iNzTCsgb/jtPNtRK/
X-Gm-Message-State: AOJu0YxcSsL27zYKJ/xnbmw+NM6fn+y2QVu8U5okns3LEBDvg8g+U7R9
	o55O//WbfsUO+HJPrRgzVpD+QCLf4g0cDipJK8tLKkLbONTZKdRpXfhve+RJa4k=
X-Google-Smtp-Source: AGHT+IGQ8/4ij15CkMhnOaWlVH+mAJ1XYx0sN2OLk0VHtmIAIuWQqIv+pbQOI4C4fD5y7Z7z3JFAOw==
X-Received: by 2002:a05:6512:138e:b0:52c:e08c:a0dc with SMTP id 2adb3069b0e04-52ce185f753mr2722847e87.51.1719225107235;
        Mon, 24 Jun 2024 03:31:47 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b46ecsm953874e87.10.2024.06.24.03.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 03:31:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 13:31:46 +0300
Subject: [PATCH] drm/lcdif: switch to DRM_BRIDGE_ATTACH_NO_CONNECTOR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-mxc-lcdif-bridge-attach-v1-1-37e8c5d5d934@linaro.org>
X-B4-Tracking: v=1; b=H4sIABFLeWYC/x2MWwqAIBAArxL73YJZ2OMq0Yfpmgu90IhAunvS5
 zDMJIgUmCIMRYJAN0c+9gxVWYDxel8I2WYGKWQjlGxwewyuxrLDObDNXl+XNh6VqFXXiXaWrod
 cn4EcP/95nN73A0Xa3slpAAAA
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=eCJNHKpOFyvKm0QEDNLeKYcgJDFGN4EGDIDzjHn6FlM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1qlt9Ar59KYH7VRt3+sPjXB/Fev0SbNiiz7/1tLfh+y4
 Z14d3JaJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmolDP/r+g47nFmZ9R22/5
 efi9nXuhhTE82Suct/H5aV5J9oMrpbZ7L7Waes+VrWm2tc15L9m9AncYm8PiVHtsVBXLjiTN3WE
 lHnctvr2BX0f+9R69+eeKW9UZRKyfaqsxz37umtKgdfCFxaKe+cX5C3Ly0l8mSjyZciVaSlhVWV
 zN5Nj2F2nHQs6I7X/5we3MsobNQW1X7I83GSV6pIvwfmVr27dlGuMdRwazhu+Pvu2r+bXI8kpjI
 cen9qTndWkzN0S4MW3/ZTmpYp3d9X9Ts93q47wvJ1uKOSj95vyuuPZJzsYQg1ivGnmNRbr3pVfd
 Y+LY2nzepa339YqjPd1M+3jzv8o2rO65sYglaLXs8Z/5AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Existing in-kernel device trees use LCDIF with the dsim + adv7533, dsim
+ tc358762 or with ldb + panel_bridge. All these combinations support
using DRM_BRIDGE_ATTACH_NO_CONNECTOR for bridge attachment.

Change lcdif driver to use this flag when attaching the bridge and
create drm_bridge_connector afterwards.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Note: compile-tested only.
---
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index 0f895b8a99d6..1d5508449995 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -16,6 +16,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fbdev_dma.h>
@@ -48,6 +49,7 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 {
 	struct device *dev = lcdif->drm->dev;
 	struct device_node *ep;
+	struct drm_connector *connector;
 	struct drm_bridge *bridge;
 	int ret;
 
@@ -96,13 +98,23 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 			return ret;
 		}
 
-		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
+		ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
 			of_node_put(ep);
 			return dev_err_probe(dev, ret,
 					     "Failed to attach bridge for endpoint%u\n",
 					     of_ep.id);
 		}
+
+		connector = drm_bridge_connector_init(lcdif->drm, encoder);
+		if (IS_ERR(connector)) {
+			ret = PTR_ERR(connector);
+			of_node_put(ep);
+
+			return dev_err_probe(dev, ret,
+					     "Failed to create bridge connector for endpoint%u\n",
+					     of_ep.id);
+		}
 	}
 
 	return 0;

---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240624-mxc-lcdif-bridge-attach-60368807b2f9

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


