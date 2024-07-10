Return-Path: <linux-kernel+bounces-247172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159192CC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0DB1F2392A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F8E84A4C;
	Wed, 10 Jul 2024 07:45:10 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E16127B57
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597509; cv=none; b=HhnthULR0Ry6n9kCTRK0a7fB5EsxVJ5G5ih++EJKWN0DtYbxQS1q2ZURN3Xzana6MukoarhohalM1idU/E2JeiYIOFEwm1W7ZtYjjM4o6U5fM1iNFC83eII4wmNJdAUjGyn0Kp7JN7uRBnfI+oEqLxix8ryHoYggOipg1XLXYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597509; c=relaxed/simple;
	bh=zZ+NA0qfCAtmAC+O34LSOZeDkGekqWFN7dPmblIarT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EHZz/MS9O5Cmgt2C4zkjDScK3+Va78ItthedCWRgOQKYqDZjryQrsW57joF+5T+ZJFsmVNvy/cwEChaGL/SKC03A8w3HfVI0L4U+D3YyZ8kfsKxTgYK9MdS+u8DX7pFgHDHerOJ+w57EY4qIWJd+O031/buJfSiXw7woVqdtErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2340:18a1:4138:37d2])
	by laurent.telenet-ops.be with bizsmtp
	id ljl02C0064znMfS01jl0n8; Wed, 10 Jul 2024 09:45:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRS0M-001b1N-EW;
	Wed, 10 Jul 2024 09:45:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRS0a-00Bv7s-0m;
	Wed, 10 Jul 2024 09:45:00 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] zorro: Have zorro_bus_match() callback take a const *
Date: Wed, 10 Jul 2024 09:45:00 +0200
Message-Id: <20240710074500.2841193-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drivers/zorro/zorro-driver.c:157:12: error: initialization of ‘int (*)(struct device *, const struct device_driver *)’ from incompatible pointer type ‘int (*)(struct device *, struct device_driver *)’ [-Werror=incompatible-pointer-types]
  157 |  .match  = zorro_bus_match,
      |            ^~~~~~~~~~~~~~~
drivers/zorro/zorro-driver.c:157:12: note: (near initialization for ‘zorro_bus_type.match’)

Reported-by: noreply@ellerman.id.au
Fixes: d69d804845985c29 ("driver core: have match() callback in struct bus_type take a const *")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/zorro/zorro-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index f49d19977e82a718..e7d3af1a223f9abf 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -118,10 +118,10 @@ EXPORT_SYMBOL(zorro_unregister_driver);
      *  supported, and 0 if there is no match.
      */
 
-static int zorro_bus_match(struct device *dev, struct device_driver *drv)
+static int zorro_bus_match(struct device *dev, const struct device_driver *drv)
 {
 	struct zorro_dev *z = to_zorro_dev(dev);
-	struct zorro_driver *zorro_drv = to_zorro_driver(drv);
+	const struct zorro_driver *zorro_drv = to_zorro_driver(drv);
 	const struct zorro_device_id *ids = zorro_drv->id_table;
 
 	if (!ids)
-- 
2.34.1


