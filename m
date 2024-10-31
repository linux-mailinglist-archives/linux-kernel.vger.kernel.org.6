Return-Path: <linux-kernel+bounces-389898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D19B729F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F33B23B29
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743513D882;
	Thu, 31 Oct 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="E4uEujSC"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ECC139D03
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342672; cv=none; b=nSYdcaD8nAaP2XOiUgJsZQVbjrSj3htVc+Zhbzu0/+JWbUa+CxeU6u95Pj8mQ+w7/Zb602zHpDspWTolUB1F8FtJXrEhUxPKo6Ky6q8G8cGs7HMjhJzSo402MAivMhw1bA02tKDsgE/SBJY36Cu8sgQuPtpLXIy0gX3iINIU9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342672; c=relaxed/simple;
	bh=wfZdoH/QydBYPcdVBp6TI9VQV3Jcoh8nKlLLAo4iroo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u51ZlBF/g6U48NkdRB1cgrJKomCEy3NpB5CW+Cn71Z9SaUzwuZm8AexSqHhUFisFJ5Mca/ycKVLlF2yIQuBLuhip9xiLLns9ENzrJ1o3h+R8WYzfTMgj3+x4+mYHIm4O3nRYJclt96Dff19etM6KfnZHfhmwiG9G+3MdvsaE5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=E4uEujSC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342667;
	bh=wfZdoH/QydBYPcdVBp6TI9VQV3Jcoh8nKlLLAo4iroo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E4uEujSCLXP4wbKL92QN9A5/RC1j+e2SA0TzeJrDMNjg63jpdBsEWfdtr0H4uqHCx
	 xiFfpO/TKD8wXappxrvb2g+1m7cAereBdtvhEDB4cyEZxhuXxs7R6Ly58pCKhOHOQm
	 7iaYfRWm9b+7XhNWa+IOX/bHPzJjPaADqdse3JYE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:57 +0000
Subject: [PATCH RFC 08/10] sysfs: implement all BIN_ATTR_* macros in terms
 of __BIN_ATTR()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-8-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=2547;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wfZdoH/QydBYPcdVBp6TI9VQV3Jcoh8nKlLLAo4iroo=;
 b=7UCQtPZz/Vkgghxa8nmPrNqUyDomktlI3X1MKF63GdEAw5RWiUPjdKJ21Czsz/Q0qRhzO56vq
 0lQuvRDBx4OAcH+FpWChL1qtmVvQiHI1fZMIeEhxK/SjKk+nFdeYI4i
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The preparations for the upcoming constification of struct bin_attribute
requires some logic in the structure definition macros.
To avoid duplication of that logic in multiple macros, reimplement all
other macros in terms of __BIN_ATTR().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 8344c0198c61cc44995c38d46d926360e7a88873..5ece63c83ba5829b6eb0f115bdea12a1412ae039 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -331,17 +331,11 @@ struct bin_attribute {
 	.size	= _size,						\
 }
 
-#define __BIN_ATTR_RO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
-	.read	= _name##_read,						\
-	.size	= _size,						\
-}
+#define __BIN_ATTR_RO(_name, _size)					\
+	__BIN_ATTR(_name, 0444, _name##_read, NULL, _size)
 
-#define __BIN_ATTR_WO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
-	.write	= _name##_write,					\
-	.size	= _size,						\
-}
+#define __BIN_ATTR_WO(_name, _size)					\
+	__BIN_ATTR(_name, 0200, NULL, _name##_write, _size)
 
 #define __BIN_ATTR_RW(_name, _size)					\
 	__BIN_ATTR(_name, 0644, _name##_read, _name##_write, _size)
@@ -362,11 +356,8 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
 
 
-#define __BIN_ATTR_ADMIN_RO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0400 },		\
-	.read	= _name##_read,						\
-	.size	= _size,						\
-}
+#define __BIN_ATTR_ADMIN_RO(_name, _size)				\
+	__BIN_ATTR(_name, 0400, _name##_read, NULL, _size)
 
 #define __BIN_ATTR_ADMIN_RW(_name, _size)					\
 	__BIN_ATTR(_name, 0600, _name##_read, _name##_write, _size)
@@ -377,10 +368,8 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RO(_name, _size)
 #define BIN_ATTR_ADMIN_RW(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RW(_name, _size)
 
-#define __BIN_ATTR_SIMPLE_RO(_name, _mode) {				\
-	.attr	= { .name = __stringify(_name), .mode = _mode },	\
-	.read	= sysfs_bin_attr_simple_read,				\
-}
+#define __BIN_ATTR_SIMPLE_RO(_name, _mode)				\
+	__BIN_ATTR(_name, _mode, sysfs_bin_attr_simple_read, NULL, 0)
 
 #define BIN_ATTR_SIMPLE_RO(_name)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_SIMPLE_RO(_name, 0444)

-- 
2.47.0


