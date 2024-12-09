Return-Path: <linux-kernel+bounces-437908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C949E9A56
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9460E16586A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6460223C4D;
	Mon,  9 Dec 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LR7efqY2"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24231F2C5B;
	Mon,  9 Dec 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757527; cv=none; b=QG1NfuIewI01RZ8wdDX+079IDZN8b93FDETD7MfirNpaSAztUTbdAZ4xZsvQSNmszJzfxme+rf1hMCRtPzcVcUK8wLr7xn7rD223qGPYd+U4KNLTGOFDA8qAD5xKx+sJFHcd87CUMdQd1GkHwjI5uQ0eUwkxSwqrZbXIxHJ8H7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757527; c=relaxed/simple;
	bh=6+eH3SLTliNmk9kDqHOkMbkZbG9HOeX8MFLZTyu4Tu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSQK1Lq2jcyPOS0DZtJ37bx5ob3Vk6l29B3Ga4b/BmDJi7fnqnYA04+xAuiXDhTxt4pBlzJy2u1Mx+7RJT2PXfMRO027U1jUvk4H/3x5z+NELGPkIZMkokJsJy4IbNFDMVVdF5xuJ0spt/WfmhGBTL1j57VgMgyGoJrA3u33Ujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LR7efqY2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7A33E1C0013;
	Mon,  9 Dec 2024 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733757517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X8/hBFexYL9f5Jzi2AlRd6tsI8OkRlzCrrLoPJoMzk=;
	b=LR7efqY2t9yBqSZdKpUjICJ7hoozQ0wGe0qiM8C7JgJyqZGcaEDtDr5/i6QpVcRY0OitOF
	9K2y9KlWA7++OfwdEJrvShhtIcd4NqYa7SXbBUHfiEVmb3r80gztGF/9hYvE5zgq9XwWaC
	3cNtBWIVqB9Y8SsEp1Ti6+sxzSj3wHVFVvxUrBGtSA6UDTXnLzo19s0gEcX8s84i0c1xQE
	Dqq3cYy0wo/8Lcjfg/5lZV0muh6eV47O/OioFD9f2D6bjsln1YhwuhNDXQVcTynMUBxpzq
	bg3xKfatSjmwtu10b5V1xE2kkjS29+PUlIUoojcuTrWfwYLn2FUztAfeFAUlEg==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Davis <afd@ti.com>,
	Ayush Singh <ayush@beagleboard.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 5/7] of: overlay: Add export_symbols_name in of_overlay_fdt_apply() parameters
Date: Mon,  9 Dec 2024 16:18:23 +0100
Message-ID: <20241209151830.95723-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209151830.95723-1-herve.codina@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

In order to prepare the introduction of the export symbols node
handling, add a export_symbols_name parameter in of_overlay_fdt_apply().

The export_symbols_name is the name of the export symbols subnode
available in the base node that will be used by the resolver to handle
export symbols resolution.

Having the name of the subnode in parameters instead of the subnode
itself avoid the use of an export symbol node that is not directly
related to the base node.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/misc/lan966x_pci.c    | 3 ++-
 drivers/of/of_kunit_helpers.c | 2 +-
 drivers/of/overlay.c          | 7 ++++++-
 drivers/of/unittest.c         | 4 ++--
 include/linux/of.h            | 6 ++++--
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/lan966x_pci.c b/drivers/misc/lan966x_pci.c
index 9c79b58137e5..f05cb040ec69 100644
--- a/drivers/misc/lan966x_pci.c
+++ b/drivers/misc/lan966x_pci.c
@@ -128,7 +128,8 @@ static int lan966x_pci_load_overlay(struct lan966x_pci *data)
 	u32 dtbo_size = __dtbo_lan966x_pci_end - __dtbo_lan966x_pci_begin;
 	void *dtbo_start = __dtbo_lan966x_pci_begin;
 
-	return of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_id, dev_of_node(data->dev));
+	return of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_id,
+				    dev_of_node(data->dev), NULL);
 }
 
 static void lan966x_pci_unload_overlay(struct lan966x_pci *data)
diff --git a/drivers/of/of_kunit_helpers.c b/drivers/of/of_kunit_helpers.c
index 7b3ed5a382aa..476b43474168 100644
--- a/drivers/of/of_kunit_helpers.c
+++ b/drivers/of/of_kunit_helpers.c
@@ -56,7 +56,7 @@ int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
 		return -ENOMEM;
 
 	ret = of_overlay_fdt_apply(overlay_fdt, overlay_fdt_size,
-				   ovcs_id, NULL);
+				   ovcs_id, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 28aa0a133eea..9bceeed45c9f 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -964,6 +964,10 @@ static int of_overlay_apply(struct overlay_changeset *ovcs,
  * @overlay_fdt_size:	number of bytes in @overlay_fdt
  * @ret_ovcs_id:	pointer for returning created changeset id
  * @base:		pointer for the target node to apply overlay
+ * @export_symbols_name:
+ *			Name of the export symbol subnode of the @base node to
+ *			provide extra symbols. Those extra symbols are used in
+ *			the overlay symbols resolution.
  *
  * Creates and applies an overlay changeset.
  *
@@ -979,7 +983,8 @@ static int of_overlay_apply(struct overlay_changeset *ovcs,
  */
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ret_ovcs_id, const struct device_node *base)
+			 int *ret_ovcs_id, const struct device_node *base,
+			 const char *export_symbols_name)
 {
 	void *new_fdt;
 	void *new_fdt_align;
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e76ac087ea98..f19e15f8b288 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3737,7 +3737,7 @@ static int __init overlay_data_apply(const char *overlay_name, int *ovcs_id)
 		pr_err("no overlay data for %s\n", overlay_name);
 
 	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &info->ovcs_id,
-				   NULL);
+				   NULL, NULL);
 	if (ovcs_id)
 		*ovcs_id = info->ovcs_id;
 	if (ret < 0)
@@ -4077,7 +4077,7 @@ static int testdrv_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	size = info->dtbo_end - info->dtbo_begin;
-	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &ovcs_id, dn);
+	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &ovcs_id, dn, NULL);
 	of_node_put(dn);
 	if (ret)
 		return ret;
diff --git a/include/linux/of.h b/include/linux/of.h
index f921786cb8ac..2ac09b0161fd 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1747,7 +1747,8 @@ struct of_overlay_notify_data {
 #ifdef CONFIG_OF_OVERLAY
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id, const struct device_node *target_base);
+			 int *ovcs_id, const struct device_node *target_base,
+			 const char *export_symbols_name);
 int of_overlay_remove(int *ovcs_id);
 int of_overlay_remove_all(void);
 
@@ -1757,7 +1758,8 @@ int of_overlay_notifier_unregister(struct notifier_block *nb);
 #else
 
 static inline int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-				       int *ovcs_id, const struct device_node *target_base)
+				       int *ovcs_id, const struct device_node *target_base,
+				       const char *export_symbols_name)
 {
 	return -ENOTSUPP;
 }
-- 
2.47.0


