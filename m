Return-Path: <linux-kernel+bounces-247155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4492CBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200DA1F23067
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A97683CC8;
	Wed, 10 Jul 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="De3peI2c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2E82D9A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596860; cv=none; b=aTeot1kZa24+DYgi6VGLkqizmF7+GibuhbZaFiZ19hULv3QUqirn3JizU9p11FPshY5mfWjGpnVLhxE0Sb1NGsmWyI95P8YhoSkZQPoPKejgwlmIGpOT3j790ySjs3Y8ezpAa17oqcdFdM5/r/zO79vlrZ0E9OTusQESjc5CuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596860; c=relaxed/simple;
	bh=y2RBXzpMCsokUrPr3LFtArnvH9uzbPQI9Q11ocJOi4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBTOxbii9VudX7QrTlaFstUSVUApEs6zahBsCALlQoJFFrGkKF3u0ay2Xj1PG0PAxQ9jD8iUcnPUdnJz52TUQu+YRKvSWBjEi4eYLdDWceKdYCSn6MQFZKhWEmVuZLx3+rIx5lDloEyS+rJxF9Vkxe65jzbnxaC0VUvTzkvBfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=De3peI2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC801C32781;
	Wed, 10 Jul 2024 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720596860;
	bh=y2RBXzpMCsokUrPr3LFtArnvH9uzbPQI9Q11ocJOi4A=;
	h=From:To:Cc:Subject:Date:From;
	b=De3peI2cvXgBuiLY0oTROaIq4QMo/HqMXwE8UbpfHnOScuTDp2YoRrcHppuG42wXu
	 5VMtGHRQuNE6nZ70mpBYoEi048OnU802ecwejmUgyxp0xEWSlZ5Bv490Yr2tE7mjS8
	 e0WRuMlS8byVE4jxE9ft74K0tvV2SL2DZ0hUa9Bk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] zorro: make match function take a const pointer
Date: Wed, 10 Jul 2024 09:34:14 +0200
Message-ID: <20240710073413.495541-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=gregkh@linuxfoundation.org; h=from:subject; bh=y2RBXzpMCsokUrPr3LFtArnvH9uzbPQI9Q11ocJOi4A=; b=owGbwMvMwCRo6H6F97bub03G02pJDGl9lqW71t9LVPn0c/oX4aCfRxZe3H6NZ1PeOqH6/WzHU r71hS8N64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJJK1jWNDT7Mv+x2L384Z9 cv4LpylqVgRnz2SYZzFde4K96KSWLTZcpRfZmRcsX1TBAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In commit d69d80484598 ("driver core: have match() callback in struct bus_type
take a const *"), the match callback for busses was changed to take a const
pointer to struct device_driver.  Unfortunatly I missed fixing up the zorro
code, and was only noticed after-the-fact by the kernel test robot.  Resolve
this issue by properly changing the zorro_bus_match() function.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: d69d80484598 ("driver core: have match() callback in struct bus_type take a const *")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/zorro/zorro-driver.c | 4 ++--
 include/linux/zorro.h        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index f49d19977e82..e7d3af1a223f 100644
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
diff --git a/include/linux/zorro.h b/include/linux/zorro.h
index db7416ed6057..f36c8d39553d 100644
--- a/include/linux/zorro.h
+++ b/include/linux/zorro.h
@@ -52,7 +52,7 @@ struct zorro_driver {
     struct device_driver driver;
 };
 
-#define	to_zorro_driver(drv)	container_of(drv, struct zorro_driver, driver)
+#define	to_zorro_driver(drv)	container_of_const(drv, struct zorro_driver, driver)
 
 
 #define zorro_for_each_dev(dev)	\
-- 
2.45.2


