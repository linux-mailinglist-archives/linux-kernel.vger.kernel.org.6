Return-Path: <linux-kernel+bounces-379081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E89AD97A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CB81C2127F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8C83A14;
	Thu, 24 Oct 2024 01:56:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC154279;
	Thu, 24 Oct 2024 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734984; cv=none; b=PYvyZthJIGio+U0j/ln7vyuLftXNp6RoB6r6DX8wdNe4ElMjqFrO9+iPJ1/5w8cwf7fsA71OEt+hAC8SO7e4uhJTAtfhnRzgxVRabee493pfgXpdVOEIRUlQ7xt1FRhRZBj0eOIIB8gUfzgvmDKek65F9MuP/sRS8durO3vdJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734984; c=relaxed/simple;
	bh=qLU4ktEs/jHfI/FoWNYf/WyMSJ07wCoMaOwaxHLhpjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o4fUGgXBd50NJjWdvcmxf4wKgC9UdNBPhinIrHyLJLAwnatPHcWPkHshIC0Ken/XuNFdS2MeS09zWpzwlbISeeITqDJmlXG+kpoBcYjlgALPKaKEBYocm/C3v0F5r2CVW3I37YrK4CMwPEOhdVqIcLP1rw4anii3OZyvlrQRKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 23df304e91ab11efa216b1d71e6e1362-20241024
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:eb1bd097-51cc-468a-b6fd-7f37766bd15a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:eaf0a6cccdbafce1ebfd4f0a8a50f78b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 23df304e91ab11efa216b1d71e6e1362-20241024
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 586799034; Thu, 24 Oct 2024 09:56:09 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id B5C42B804841;
	Thu, 24 Oct 2024 09:56:09 +0800 (CST)
X-ns-mid: postfix-6719A939-58800610031
Received: from localhost.localdomain (unknown [172.25.120.42])
	by node2.com.cn (NSMail) with ESMTPA id B62BDB804841;
	Thu, 24 Oct 2024 01:56:08 +0000 (UTC)
From: chen zhang <chenzhang@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	cezary.jackiewicz@gmail.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH] platform/x86: compal-laptop: use sysfs_emit() instead of sprintf()
Date: Thu, 24 Oct 2024 09:56:05 +0800
Message-Id: <20241024015605.15238-1-chenzhang@kylinos.cn>
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
 drivers/platform/x86/compal-laptop.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/=
compal-laptop.c
index 5546fb189491..ba95f342fd59 100644
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
@@ -368,7 +369,7 @@ static const struct rfkill_ops compal_rfkill_ops =3D =
{
 static ssize_t NAME##_show(struct device *dev,				\
 	struct device_attribute *attr, char *buf)			\
 {									\
-	return sprintf(buf, "%d\n", ((ec_read_u8(ADDR) & MASK) !=3D 0));	\
+	return sysfs_emit(buf, "%d\n", ((ec_read_u8(ADDR) & MASK) !=3D 0));	\
 }									\
 static ssize_t NAME##_store(struct device *dev,				\
 	struct device_attribute *attr, const char *buf, size_t count)	\
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
@@ -460,7 +461,7 @@ static ssize_t pwm_store(struct device *dev, struct d=
evice_attribute *attr,
 static ssize_t fan_show(struct device *dev, struct device_attribute *att=
r,
 		char *buf)
 {
-	return sprintf(buf, "%d\n", get_fan_rpm());
+	return sysfs_emit(buf, "%d\n", get_fan_rpm());
 }
=20
=20
@@ -469,12 +470,12 @@ static ssize_t fan_show(struct device *dev, struct =
device_attribute *attr,
 static ssize_t temp_##POSTFIX(struct device *dev,			\
 		struct device_attribute *attr, char *buf)		\
 {									\
-	return sprintf(buf, "%d\n", 1000 * (int)ec_read_s8(ADDRESS));	\
+	return sysfs_emit(buf, "%d\n", 1000 * (int)ec_read_s8(ADDRESS));	\
 }									\
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


