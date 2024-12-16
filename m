Return-Path: <linux-kernel+bounces-447251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4CF9F2F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA47A1882F90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48BA206287;
	Mon, 16 Dec 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SfkGxAQc"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F99205ABC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348789; cv=none; b=Cc3S9a+LNOG8sEOzkhz7oiPGKp6r0jEpsvRnOTlN6SAGILQTT8kOSvmFQAnvC/PGjSSOfzoe/CevkaIOmZpfeLNB9LwXUjpVtmPDitkPqJ4jdkd85jlDgT4BJdivw+JtbAxVVrPaqg/L7B6hbUKTVwfpT+tcsklYcIYxE8HS/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348789; c=relaxed/simple;
	bh=8m1RQ3DhfA9f6hdRy+DqOXn1T98rVvXAkNUHHyC1n88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxzTSLmTwKyk8ds2jbU8FbWiCQnn+jEEGpM4/4SczCocVgxEn1iEyIY1cs0y+hwQrYQpOiE73hiliTRZeGk5ORuk0LsGVuSKuk7YVQ1sVvf5MsJNV90tJaLpBxrh8ogCof3HV1UYBkXkyrQ27yPucqq4APANTFI2+5K42lJwBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SfkGxAQc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348782;
	bh=8m1RQ3DhfA9f6hdRy+DqOXn1T98rVvXAkNUHHyC1n88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SfkGxAQc9gPviIOEmy4LRe1MEdM+uibGvmTgCiGkHbfX969bE+uuzDsv7wi2aVMMr
	 DRsuS81JPJO9/FhetrzfPoLM4SyqfjJCWgcRhNLYM4/fMv66PMmqt5rZdoW3UYqwPa
	 AZty3dWGEvw2A1Szvx96eaaIHcdip8YJCBTUxud4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:33:00 +0100
Subject: [PATCH 5/9] misc: c2port: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-5-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=2244;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8m1RQ3DhfA9f6hdRy+DqOXn1T98rVvXAkNUHHyC1n88=;
 b=BcUHlLFzhkKMOTNksv+oFkNkaEG/oNFfc71yOk0a4fCYqm91WEtMRhVsrdt1ABPa80jDGdlEw
 4U8JXjI4XnYCQDnpOJtBeyWF1JDi8sdGib54AvjHTZ0dDI4bMwgX+rx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/c2port/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index 5d6767b484c998b44a3c90c177d12028db1ea1af..eb780e635352f3a815e8d400d71c04b47507cd4b 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -714,7 +714,7 @@ static ssize_t __c2port_read_flash_data(struct c2port_device *dev,
 }
 
 static ssize_t c2port_read_flash_data(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
+				const struct bin_attribute *attr,
 				char *buffer, loff_t offset, size_t count)
 {
 	struct c2port_device *c2dev = dev_get_drvdata(kobj_to_dev(kobj));
@@ -829,7 +829,7 @@ static ssize_t __c2port_write_flash_data(struct c2port_device *dev,
 }
 
 static ssize_t c2port_write_flash_data(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
+				const struct bin_attribute *attr,
 				char *buffer, loff_t offset, size_t count)
 {
 	struct c2port_device *c2dev = dev_get_drvdata(kobj_to_dev(kobj));
@@ -849,8 +849,8 @@ static ssize_t c2port_write_flash_data(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 /* size is computed at run-time */
-static BIN_ATTR(flash_data, 0644, c2port_read_flash_data,
-		c2port_write_flash_data, 0);
+static const BIN_ATTR(flash_data, 0644, c2port_read_flash_data,
+		      c2port_write_flash_data, 0);
 
 /*
  * Class attributes
@@ -869,7 +869,7 @@ static struct attribute *c2port_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *c2port_bin_attrs[] = {
+static const struct bin_attribute *const c2port_bin_attrs[] = {
 	&bin_attr_flash_data,
 	NULL,
 };
@@ -888,7 +888,7 @@ static size_t c2port_bin_attr_size(struct kobject *kobj,
 
 static const struct attribute_group c2port_group = {
 	.attrs = c2port_attrs,
-	.bin_attrs = c2port_bin_attrs,
+	.bin_attrs_new = c2port_bin_attrs,
 	.bin_size = c2port_bin_attr_size,
 };
 

-- 
2.47.1


