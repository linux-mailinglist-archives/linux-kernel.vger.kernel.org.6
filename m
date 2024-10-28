Return-Path: <linux-kernel+bounces-384008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702D9B232B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0345280F99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A4170A0C;
	Mon, 28 Oct 2024 02:50:14 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822C2C697;
	Mon, 28 Oct 2024 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083814; cv=none; b=usCsIeHZlcE6IBSldZlmzQUkuNewoKygdnkNGW1AVapdSmtCq+1DISLhvChF3b4VANlHaTbFtY2Oi9p57h7l5nxjiDN1AsR9J5fSNuVF4LQGr94DeEA5+tKhmlcGvgZeF8o5cNRZ/DdfqIYy/XyyuiSObm8jK7rMn3oNRHSuG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083814; c=relaxed/simple;
	bh=UjDBB4Wt5tVDBn1zajBMyq1ntJMJRqo9P5hvopI7ne4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jgGPR7bj7tgq4FvP2fERuwSZh/DIzxEiz7xw5X3RrO8eHHRKwqE55IJ4sXTvco+P0EDdsno/lto0937aeSLqasmITU4ZMn+iAGppfsvyVYCzl392NKr3Go7oXpFOwVexfGdBL7eNC83ASCVIOXXTak1/sgfKCOAS9myZfUriDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4ec9193a94d711efa216b1d71e6e1362-20241028
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c55078aa-98ef-4098-85f8-61e02592658d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:909cc0e8163af0319e6881c70b756443,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4ec9193a94d711efa216b1d71e6e1362-20241028
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 342577670; Mon, 28 Oct 2024 10:49:53 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 154E7B8075B2;
	Mon, 28 Oct 2024 10:49:53 +0800 (CST)
X-ns-mid: postfix-671EFBD0-941727456
Received: from localhost.localdomain (unknown [172.25.120.42])
	by node2.com.cn (NSMail) with ESMTPA id EEA52B8075B2;
	Mon, 28 Oct 2024 02:49:51 +0000 (UTC)
From: chen zhang <chenzhang@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	cezary.jackiewicz@gmail.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH v2] platform/x86: compal-laptop: use sysfs_emit() instead of sprintf()
Date: Mon, 28 Oct 2024 10:49:49 +0800
Message-Id: <20241028024949.24746-1-chenzhang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
v2: The macro line continuation backslashes should be aligned.
---
 drivers/platform/x86/compal-laptop.c | 33 ++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/=
compal-laptop.c
index 5546fb189491..33e2ab2b71d1 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -67,6 +67,7 @@
 #include <linux/rfkill.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/sysfs.h>
 #include <linux/power_supply.h>
 #include <linux/fb.h>
 #include <acpi/video.h>
@@ -364,12 +365,12 @@ static const struct rfkill_ops compal_rfkill_ops =3D=
 {
=20
=20
 /* Wake_up interface */
-#define SIMPLE_MASKED_STORE_SHOW(NAME, ADDR, MASK)			\
-static ssize_t NAME##_show(struct device *dev,				\
-	struct device_attribute *attr, char *buf)			\
-{									\
-	return sprintf(buf, "%d\n", ((ec_read_u8(ADDR) & MASK) !=3D 0));	\
-}									\
+#define SIMPLE_MASKED_STORE_SHOW(NAME, ADDR, MASK)				\
+static ssize_t NAME##_show(struct device *dev,					\
+	struct device_attribute *attr, char *buf)				\
+{										\
+	return sysfs_emit(buf, "%d\n", ((ec_read_u8(ADDR) & MASK) !=3D 0));	\
+}										\
 static ssize_t NAME##_store(struct device *dev,				\
 	struct device_attribute *attr, const char *buf, size_t count)	\
 {									\
@@ -393,7 +394,7 @@ static ssize_t pwm_enable_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct compal_data *data =3D dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", data->pwm_enable);
+	return sysfs_emit(buf, "%d\n", data->pwm_enable);
 }
=20
 static ssize_t pwm_enable_store(struct device *dev,
@@ -432,7 +433,7 @@ static ssize_t pwm_show(struct device *dev, struct de=
vice_attribute *attr,
 		char *buf)
 {
 	struct compal_data *data =3D dev_get_drvdata(dev);
-	return sprintf(buf, "%hhu\n", data->curr_pwm);
+	return sysfs_emit(buf, "%hhu\n", data->curr_pwm);
 }
=20
 static ssize_t pwm_store(struct device *dev, struct device_attribute *at=
tr,
@@ -460,21 +461,21 @@ static ssize_t pwm_store(struct device *dev, struct=
 device_attribute *attr,
 static ssize_t fan_show(struct device *dev, struct device_attribute *att=
r,
 		char *buf)
 {
-	return sprintf(buf, "%d\n", get_fan_rpm());
+	return sysfs_emit(buf, "%d\n", get_fan_rpm());
 }
=20
=20
 /* Temperature interface */
-#define TEMPERATURE_SHOW_TEMP_AND_LABEL(POSTFIX, ADDRESS, LABEL)	\
-static ssize_t temp_##POSTFIX(struct device *dev,			\
-		struct device_attribute *attr, char *buf)		\
-{									\
-	return sprintf(buf, "%d\n", 1000 * (int)ec_read_s8(ADDRESS));	\
-}									\
+#define TEMPERATURE_SHOW_TEMP_AND_LABEL(POSTFIX, ADDRESS, LABEL)		\
+static ssize_t temp_##POSTFIX(struct device *dev,				\
+		struct device_attribute *attr, char *buf)			\
+{										\
+	return sysfs_emit(buf, "%d\n", 1000 * (int)ec_read_s8(ADDRESS));	\
+}										\
 static ssize_t label_##POSTFIX(struct device *dev,			\
 		struct device_attribute *attr, char *buf)		\
 {									\
-	return sprintf(buf, "%s\n", LABEL);				\
+	return sysfs_emit(buf, "%s\n", LABEL);				\
 }
=20
 /* Labels as in service guide */
--=20
2.25.1


