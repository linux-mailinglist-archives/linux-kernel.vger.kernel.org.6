Return-Path: <linux-kernel+bounces-378788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2A29AD578
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01ACB1C21FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647CB1F471D;
	Wed, 23 Oct 2024 20:29:19 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F31EF0BF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715359; cv=none; b=LyWAycVDkOHC3bmhAWDcNgx0zS/wqA25WmpCRfYVoaIefBhkTUU9wmMNyRLl9pkw5nvCWEmTUOggkUPKvUM5UJSwR7OhB5Lqy9hkdZaku7QC3MiB94Gim9O4JEN7kJjtnvmGjm1KriqmqhoYheZaXQD8knRxV+7lzrZsmLoK08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715359; c=relaxed/simple;
	bh=lnvTO+lk5nagHH4366IGD5Wm+3SSlb1007GJ7NytG7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aX45Tb4V3Pc7Wvm3VBdhFhFgnv2v/7f8Z0PQ0DTZ/R1OMFNAWmr9hE8EcmfSI5DL0xnWYdU04SAjfvY0N/l87R3mW3XQeBsxl8GJ8T8gEoPqzuvzhzhJs7QCCBpHGyslO1t5O/4H5ahV2/AsjEAGqiUnoqf22usImJfeKNrm2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1t3hya-001CNZ-Jh;
	Wed, 23 Oct 2024 20:29:04 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Heiko Schocher <hs@denx.de>,
	Tom Rini <trini@konsulko.com>,
	Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 3/4] i2c: mxc_i2c: Convert to use livetree API for fdt access
Date: Wed, 23 Oct 2024 13:28:54 -0700
Message-Id: <20241023202855.1571188-3-tharvey@gateworks.com>
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

Without this if livetree is enabled (OF_LIVE) the mxc-i2c
driver will fail to support scl-gpios and sda-gpios for
i2c bus recovery.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/i2c/mxc_i2c.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/mxc_i2c.c b/drivers/i2c/mxc_i2c.c
index 2f3cb5908c91..2dfc1c4eab5d 100644
--- a/drivers/i2c/mxc_i2c.c
+++ b/drivers/i2c/mxc_i2c.c
@@ -29,7 +29,6 @@
 #include <watchdog.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
-#include <fdtdec.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -867,8 +866,7 @@ static int mxc_i2c_set_bus_speed(struct udevice *bus, unsigned int speed)
 static int mxc_i2c_probe(struct udevice *bus)
 {
 	struct mxc_i2c_bus *i2c_bus = dev_get_priv(bus);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(bus);
+	ofnode node = dev_ofnode(bus);
 	fdt_addr_t addr;
 	int ret, ret2;
 
@@ -912,17 +910,15 @@ static int mxc_i2c_probe(struct udevice *bus)
 	 * See Documentation/devicetree/bindings/i2c/i2c-imx.txt
 	 * Use gpio to force bus idle when necessary.
 	 */
-	ret = fdt_stringlist_search(fdt, node, "pinctrl-names", "gpio");
+	ret = ofnode_stringlist_search(node, "pinctrl-names", "gpio");
 	if (ret < 0) {
 		debug("i2c bus %d at 0x%2lx, no gpio pinctrl state.\n",
 		      dev_seq(bus), i2c_bus->base);
 	} else {
-		ret = gpio_request_by_name_nodev(offset_to_ofnode(node),
-				"scl-gpios", 0, &i2c_bus->scl_gpio,
-				GPIOD_IS_OUT);
-		ret2 = gpio_request_by_name_nodev(offset_to_ofnode(node),
-				"sda-gpios", 0, &i2c_bus->sda_gpio,
-				GPIOD_IS_OUT);
+		ret = gpio_request_by_name(bus, "scl-gpios", 0, &i2c_bus->scl_gpio,
+					   GPIOD_IS_OUT);
+		ret2 = gpio_request_by_name(bus, "sda-gpios", 0, &i2c_bus->sda_gpio,
+					    GPIOD_IS_OUT);
 		if (!dm_gpio_is_valid(&i2c_bus->sda_gpio) ||
 		    !dm_gpio_is_valid(&i2c_bus->scl_gpio) ||
 		    ret || ret2) {
-- 
2.25.1


