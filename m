Return-Path: <linux-kernel+bounces-447245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68E9F2F96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934D7169AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B32046B2;
	Mon, 16 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="myKGpY3u"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5B20458B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348785; cv=none; b=G3Q0CXVAHW1peeLdeYrq4Cmw00MzTi8ccGDpfGFwwGw/FkktsRskb2AeY54Kknvw5+kPn/2GFLG5cMR9xHagQg58e5hhsgoq7YAEtWrVR4gvGIf7j40xYiFo6xiUt7a7U7YDQNA36jkVe3nIpAyPTHKv5t6Isp6XXzuKSjhISWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348785; c=relaxed/simple;
	bh=CcDBWMFWLtSDmVrkWX7ndeD+K4Cfvo9MPzDfwHVQP6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXGw9m+IZH8YWh5XVj6v9GIJ6DxAnqWEw1DIMPnUnotGQBdTyDI5n63FLMTgqwxY6189F8I4DZJSb2kfAXj+CcnR23rPevl3oSJsmkOMhdUg5nQmzbas9IG9Uq/qh5LOk7Dp0ENeEIgXKWWiL7WuYEUbyMLCXm+rgdnjh1QO+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=myKGpY3u; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348782;
	bh=CcDBWMFWLtSDmVrkWX7ndeD+K4Cfvo9MPzDfwHVQP6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=myKGpY3uWk6mwmbD2RvdisauS0ytwt05mIhLyKQcE1VG7wh/xYWLoEr0YYP2vsSvW
	 D4PIIqYUs0bRIlZzV3Ea3YKF4lLEEYqqb4zYUNjHq0MV2KwNaNXw5lfJagNObcfoI+
	 StpUSP1/JX9+gLr3dSwB1yKOWc8H1wTNkKpdd+20=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:32:59 +0100
Subject: [PATCH 4/9] misc: c2port: Calculate bin_attribute size through
 group callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-4-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=1494;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CcDBWMFWLtSDmVrkWX7ndeD+K4Cfvo9MPzDfwHVQP6g=;
 b=V3cSwsQHSCtQbrD0jp5/nVa8t1w9RANvtZ0CKl4QibCNmCl3FskR+zYeGXktanFJ1i5WvyyI4
 ov9YBDN+vVKBxcdOP0J8TnBHLO2TcmINCzJwbVmkUQGjVAvJb8LSslR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Modifying the size of the global bin_attribute instance can be racy.
Instead use the new .bin_size callback to do so safely.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/c2port/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index 2bb1dd2511f9dd178b8c06baa460bb609f7f8fd7..5d6767b484c998b44a3c90c177d12028db1ea1af 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -874,9 +874,22 @@ static struct bin_attribute *c2port_bin_attrs[] = {
 	NULL,
 };
 
+static size_t c2port_bin_attr_size(struct kobject *kobj,
+				   const struct bin_attribute *attr,
+				   int i)
+{
+	struct c2port_device *c2dev = dev_get_drvdata(kobj_to_dev(kobj));
+
+	if (attr == &bin_attr_flash_data)
+		return c2dev->ops->blocks_num * c2dev->ops->block_size;
+
+	return attr->size;
+}
+
 static const struct attribute_group c2port_group = {
 	.attrs = c2port_attrs,
 	.bin_attrs = c2port_bin_attrs,
+	.bin_size = c2port_bin_attr_size,
 };
 
 static const struct attribute_group *c2port_groups[] = {
@@ -913,8 +926,6 @@ struct c2port_device *c2port_device_register(char *name,
 		goto error_idr_alloc;
 	c2dev->id = ret;
 
-	bin_attr_flash_data.size = ops->blocks_num * ops->block_size;
-
 	c2dev->dev = device_create(c2port_class, NULL, 0, c2dev,
 				   "c2port%d", c2dev->id);
 	if (IS_ERR(c2dev->dev)) {

-- 
2.47.1


