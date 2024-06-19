Return-Path: <linux-kernel+bounces-220743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A590E685
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D98B221BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCE97E761;
	Wed, 19 Jun 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rPx8xbJD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20D57CAC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788081; cv=none; b=lUn1jnt2PQ2Pi1mNY9uqN1krDvhrwipVZ3iXRHH5GPzoi9uW9AC0mIR6C2QnqhKUWUWYrm3GoojJBit+1FwmIU33FeC5eD8MOsVtl6z1IgFA2GjhsQCVouF/HTqdh+spY417Ix3WnUtvSD/VKU40o+yK9tPQanTdk5ojgldjOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788081; c=relaxed/simple;
	bh=DZhGeqFehRS7W14jzlLqUVoPGWyetiJb3GGjiXiR5Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DfcuKS1X5MK8bofAX9jpu8yahjVjiz/wAIZxlm8FiWDkLTx0w5tAh9/DfVY7lzAOGhYxXv2lCxMTgPoEQavppNAx9vaTfT8lOyDS7sY2XIvo3aicqyM6hVs8lawyganmt5CsWkxMLr14GuXFBeBbU5zUmaoXsFH3UIxeNLiUTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rPx8xbJD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-144-210.elisa-laajakaista.fi [91.158.144.210])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4568CF89;
	Wed, 19 Jun 2024 11:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718788058;
	bh=DZhGeqFehRS7W14jzlLqUVoPGWyetiJb3GGjiXiR5Lk=;
	h=From:Date:Subject:To:Cc:From;
	b=rPx8xbJDyJDluUsi6i9lTa7Qd6dpYjHVR8QfHr7eVmnfLB3ShOUdiohhsOj7jcC3S
	 DSMFr6YPFL7ypQIKrDD1QQHXvHIlNUm0FHfulLbM8ke57rmil3bPIEjC7cd05WDggz
	 T87G01MGfjre9z0A8PII51hr8nZGrQPyaO2ugcWg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 19 Jun 2024 12:07:48 +0300
Subject: [PATCH] drm/mipi-dsi: Fix devm unregister & detach
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-dsi-devres-fix-v1-1-a5c59310a52e@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAOOfcmYC/x2MQQqAMAwEvyI5G6jFSvUr4kFN1FxUGiiC9O8Gj
 7PDzgvKSVhhqF5InEXlOg2auoL1mM+dUcgYvPOt65oeSQWJc2LFTR6MFEIMfjE5g53uxDb/wXE
 q5QMzc/lGYAAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5011;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=croLJFrL+09XNJbTz1h3x2gBIcPMTrAYTd1stVs7jVw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmcp/oCFOuu7JqH7XsYqGpp9gqBMcwfBrQ2ohRp
 WyyIJwwe6CJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZnKf6AAKCRD6PaqMvJYe
 9QT6D/0WdVkJhk/x2oO6mP/eZCws9uZ8Y88WiZ0T9HO0/LvpRfhaXqZNiXapc/YuVK5n98EfeWA
 I9jI755sMky+4GUgA+bwbVd0IZHtCdVw+4s/SEKRC6frNiZX5VRO9k0KNVg70jFndI6guWF/Tk3
 80p/2HXWgAsBIASd/95eJ9PEhE5bPe+Lxk5+P0ddPaY1of5BZ9Wyld6Vcqcgae2y+K+R0q0sd1g
 47SlkldRSB/PLM/b9HcUpw+MZI5+ZBLlm8kbylJt1oyG/tbOX91x+Z7dEytIuGueVZRiGZVKlMm
 mg8jhMMy13tOufld8s7akHBsg+7t1SltPCPaU2kMg8Pj4Rqyyyq/5ZsdpNz6g1b3xHg81Os3go7
 4eJCvOPvm2UrfNwdFnZ1whs93shs4gFNB4LYC4xkg0uaPlALAj3Jn35k81Yq1lUVsc51ADvOnfK
 0vovjRWnwGd89nLSAuOG0pu5ZFad40nCYoosHHMfa8dju36PiPxrrh4Sx7SvTvHqzGI1oJjwhRO
 GEimYIIEnAE79/ZKkOGNGIc3I13c0X1jKYkTN2uiXudVUlx0JmJlOa275wj/gaJ5t56vff6JQSc
 PclpmGi3ulhp121fSZ4lYPfQGFlinktq01/2/BH/ojW61mST/sWLVVMrCrPDNMCXDJNQ2APR63y
 QhEYdg+fWkc1RAg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

When a bridge driver uses devm_mipi_dsi_device_register_full() or
devm_mipi_dsi_attach(), the resource management is moved to devres,
which releases the resource automatically when the bridge driver is
unbound.

However, if the DSI host goes away first, the host unregistration code
will automatically detach and unregister any DSI peripherals, without
notifying the devres about it. So when the bridge driver later is
unbound, the resources are released a second time, leading to crash.

Fix this by recording the device that was used when calling the above
mentioned functions into the struct mipi_dsi_device, and when the
unregister or detach is called, remove the devres action if needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 44 ++++++++++++++++++++++++++++++++----------
 include/drm/drm_mipi_dsi.h     |  6 ++++++
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 795001bb7ff1..a78c4b6cae70 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -237,13 +237,15 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 }
 EXPORT_SYMBOL(mipi_dsi_device_register_full);
 
+static void mipi_dsi_do_device_unregister(struct mipi_dsi_device *dsi, bool devres);
+
 /**
  * mipi_dsi_device_unregister - unregister MIPI DSI device
  * @dsi: DSI peripheral device
  */
 void mipi_dsi_device_unregister(struct mipi_dsi_device *dsi)
 {
-	device_unregister(&dsi->dev);
+	mipi_dsi_do_device_unregister(dsi, false);
 }
 EXPORT_SYMBOL(mipi_dsi_device_unregister);
 
@@ -251,7 +253,15 @@ static void devm_mipi_dsi_device_unregister(void *arg)
 {
 	struct mipi_dsi_device *dsi = arg;
 
-	mipi_dsi_device_unregister(dsi);
+	mipi_dsi_do_device_unregister(dsi, true);
+}
+
+static void mipi_dsi_do_device_unregister(struct mipi_dsi_device *dsi, bool devres)
+{
+	if (!devres && dsi->devres_register_dev)
+		devm_remove_action(dsi->devres_register_dev, devm_mipi_dsi_device_unregister, dsi);
+
+	device_unregister(&dsi->dev);
 }
 
 /**
@@ -289,6 +299,8 @@ devm_mipi_dsi_device_register_full(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	dsi->devres_register_dev = dev;
+
 	return dsi;
 }
 EXPORT_SYMBOL_GPL(devm_mipi_dsi_device_register_full);
@@ -386,17 +398,35 @@ int mipi_dsi_attach(struct mipi_dsi_device *dsi)
 }
 EXPORT_SYMBOL(mipi_dsi_attach);
 
+static int mipi_dsi_do_detach(struct mipi_dsi_device *dsi, bool devres);
+
 /**
  * mipi_dsi_detach - detach a DSI device from its DSI host
  * @dsi: DSI peripheral
  */
 int mipi_dsi_detach(struct mipi_dsi_device *dsi)
+{
+	return mipi_dsi_do_detach(dsi, false);
+}
+EXPORT_SYMBOL(mipi_dsi_detach);
+
+static void devm_mipi_dsi_detach(void *arg)
+{
+	struct mipi_dsi_device *dsi = arg;
+
+	mipi_dsi_do_detach(dsi, true);
+}
+
+static int mipi_dsi_do_detach(struct mipi_dsi_device *dsi, bool devres)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
 
 	if (WARN_ON(!dsi->attached))
 		return -EINVAL;
 
+	if (!devres && dsi->devres_attach_dev)
+		devm_remove_action(dsi->devres_attach_dev, devm_mipi_dsi_detach, dsi);
+
 	if (!ops || !ops->detach)
 		return -ENOSYS;
 
@@ -404,14 +434,6 @@ int mipi_dsi_detach(struct mipi_dsi_device *dsi)
 
 	return ops->detach(dsi->host, dsi);
 }
-EXPORT_SYMBOL(mipi_dsi_detach);
-
-static void devm_mipi_dsi_detach(void *arg)
-{
-	struct mipi_dsi_device *dsi = arg;
-
-	mipi_dsi_detach(dsi);
-}
 
 /**
  * devm_mipi_dsi_attach - Attach a MIPI-DSI device to its DSI Host
@@ -437,6 +459,8 @@ int devm_mipi_dsi_attach(struct device *dev,
 	if (ret)
 		return ret;
 
+	dsi->devres_attach_dev = dev;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 82b1cc434ea3..f68aee6813db 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -181,6 +181,9 @@ struct mipi_dsi_device_info {
  * be set to the real limits of the hardware, zero is only accepted for
  * legacy drivers
  * @dsc: panel/bridge DSC pps payload to be sent
+ * devres_register_dev: device that was used with
+ *			devm_mipi_dsi_device_register_full() or NULL
+ * devres_attach_dev: device that was used with devm_mipi_dsi_attach() or NULL
  */
 struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
@@ -195,6 +198,9 @@ struct mipi_dsi_device {
 	unsigned long hs_rate;
 	unsigned long lp_rate;
 	struct drm_dsc_config *dsc;
+
+	struct device *devres_register_dev;
+	struct device *devres_attach_dev;
 };
 
 #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240619-dsi-devres-fix-8d55852b406a

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


