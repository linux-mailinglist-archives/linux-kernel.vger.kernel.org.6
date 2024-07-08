Return-Path: <linux-kernel+bounces-243850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E0929BB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7CE28139E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57848BA53;
	Mon,  8 Jul 2024 05:38:54 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611F6FC7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720417133; cv=none; b=tbZCEj49icWfNJP2kTGvFJURDK8Eh0YBZ+egi/MP9JFiAVRX1Fbe1pm3tl1RYpu8kyXpOlqUD7N2WBhjFobfTrBcikgkGuTreebNqqjfW4QPdtzDktFVJ4hNSTT82J7Rsy9b9Vc2LYNjkBHYHP3nv2RYqvjMfUENuADWBH2uhWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720417133; c=relaxed/simple;
	bh=6WmoFW3kX8vRWRIT1OSBOf/H/5xbjkoi1RldU0V74ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coxyWOS/O+yjUOUP/QIp+7gFXuGNvBnJkXuyaAdwpvObrtSPkExh5qDzwe9ACoBZF/fVHemAfuHtT6Uh4pCx81Vgz7Id1fOwnGksxHnYiSy4uKLjHUxOoGITHivkej6b52+oEGSbhP3sEOP3YGIRCoSnS3sBsF+KvI1SLTLnvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BC3F41A09B0;
	Mon,  8 Jul 2024 07:38:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85B8A1A168E;
	Mon,  8 Jul 2024 07:38:44 +0200 (CEST)
Received: from lsv03083.swis.in-blr01.nxp.com (lsv03083.swis.in-blr01.nxp.com [92.120.146.80])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9DF57181D0F9;
	Mon,  8 Jul 2024 13:38:43 +0800 (+08)
From: Bhoomik Gupta <bhoomik.gupta@nxp.com>
To: alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Frank.Li@nxp.com,
	Bhoomik Gupta <bhoomik.gupta@nxp.com>
Subject: [PATCH] i3c: master: Enhance i3c_bus_type visibility for device searching & event monitoring
Date: Mon,  8 Jul 2024 11:08:35 +0530
Message-ID: <20240708053835.3003986-1-bhoomik.gupta@nxp.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Improve the visibility of i3c_bus_type to facilitate searching for
i3c devices attached to the i3c bus. Enable other drivers to use
bus_register_notifier to monitor i3c bus device events.

Signed-off-by: Bhoomik Gupta <bhoomik.gupta@nxp.com>
---
 drivers/i3c/internals.h    | 2 --
 drivers/i3c/master.c       | 1 +
 include/linux/i3c/master.h | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 4d99a3524171..433f6088b7ce 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -10,8 +10,6 @@
 
 #include <linux/i3c/master.h>
 
-extern const struct bus_type i3c_bus_type;
-
 void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3b4d6a8edca3..a211dc4d25bb 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -342,6 +342,7 @@ const struct bus_type i3c_bus_type = {
 	.probe = i3c_device_probe,
 	.remove = i3c_device_remove,
 };
+EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 0ca27dd86956..074f632868d9 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -33,6 +33,7 @@ enum {
 struct i3c_master_controller;
 struct i3c_bus;
 struct i3c_device;
+extern const struct bus_type i3c_bus_type;
 
 /**
  * struct i3c_i2c_dev_desc - Common part of the I3C/I2C device descriptor
-- 
2.45.2


