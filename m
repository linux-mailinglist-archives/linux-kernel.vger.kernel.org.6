Return-Path: <linux-kernel+bounces-378789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D59AD579
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AAF1F2471A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1A1F4721;
	Wed, 23 Oct 2024 20:29:19 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9901EF0A3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715359; cv=none; b=n2xLXzV8fFCXxfWIjUXFV/oXblk3TyP23mFDwQNHGqX9rFF7QVCNCsisM+xOZpI7Kj5lhOFIWWaFhwEcwX0kaTY6lf6JeA1grt9NnRzmFDx2O4QIQSK4qvwAJaPcfQ+Hb5i9swfXNJ7Et5qj0vcTsvR32O99gYUpSb1XrX30yQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715359; c=relaxed/simple;
	bh=++7ucayefcdJ74l/fBbuIGKNd8eBOOS7ucxSd7C0dKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XezhV3eWmANLBlcmbo1gZU78b2e3ZMigkyTAq+BuSaU+bx6kaVpc54GRcGfFxuOZs3k+C9DPYtZlqjpMOKzu16CtJ4RvxMbaeq69BJoZ62LnpPiMC8RpWgoro/vZmeeIH9+LQmw5MJ5MK9PYd0RsUwi6PdKcdlcE9gd86HpMOhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1t3hya-001CNZ-09;
	Wed, 23 Oct 2024 20:29:04 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Heiko Schocher <hs@denx.de>,
	Tom Rini <trini@konsulko.com>,
	Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/4] imx: power-domain: Convert to use livetree API for fdt access
Date: Wed, 23 Oct 2024 13:28:53 -0700
Message-Id: <20241023202855.1571188-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023202855.1571188-1-tharvey@gateworks.com>
References: <20241023202855.1571188-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to using livetree API functions.

Without this if livetree is enabled (OF_LIVE) the imx8m-power-domain
driver will (silently) fail to probe its children leaving you with
no power domain support causing issues with certain devices.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/power/domain/imx8m-power-domain.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index 8b6870c86463..c22fbe60675e 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -456,25 +456,22 @@ static int imx8m_power_domain_of_xlate(struct power_domain *power_domain,
 
 static int imx8m_power_domain_bind(struct udevice *dev)
 {
-	int offset;
+	ofnode subnode;
 	const char *name;
 	int ret = 0;
 
-	offset = dev_of_offset(dev);
-	for (offset = fdt_first_subnode(gd->fdt_blob, offset); offset > 0;
-	     offset = fdt_next_subnode(gd->fdt_blob, offset)) {
+	ofnode_for_each_subnode(subnode, dev_ofnode(dev)) {
 		/* Bind the subnode to this driver */
-		name = fdt_get_name(gd->fdt_blob, offset, NULL);
+		name = ofnode_get_name(subnode);
 
 		/* Descend into 'pgc' subnode */
 		if (!strstr(name, "power-domain")) {
-			offset = fdt_first_subnode(gd->fdt_blob, offset);
-			name = fdt_get_name(gd->fdt_blob, offset, NULL);
+			subnode = ofnode_first_subnode(subnode);
+			name = ofnode_get_name(subnode);
 		}
-
 		ret = device_bind_with_driver_data(dev, dev->driver, name,
 						   dev->driver_data,
-						   offset_to_ofnode(offset),
+						   subnode,
 						   NULL);
 
 		if (ret == -ENODEV)
@@ -514,8 +511,7 @@ static int imx8m_power_domain_of_to_plat(struct udevice *dev)
 	struct imx_pgc_domain_data *domain_data =
 		(struct imx_pgc_domain_data *)dev_get_driver_data(dev);
 
-	pdata->resource_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					    "reg", -1);
+	pdata->resource_id = ofnode_read_u32_default(dev_ofnode(dev), "reg", -1);
 	pdata->domain = &domain_data->domains[pdata->resource_id];
 	pdata->regs = domain_data->pgc_regs;
 	pdata->base = dev_read_addr_ptr(dev->parent);
-- 
2.25.1


