Return-Path: <linux-kernel+bounces-377195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D69ABB18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFAD1F24515
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358D374D1;
	Wed, 23 Oct 2024 01:42:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443C33991;
	Wed, 23 Oct 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647742; cv=none; b=pqE+j6aQ83DTyKnDdusFCy8Nfchmio8GZLPQWiF5BXau5qg7mqD+61XjfOosDWzjy2k/EQCYIeGDtpWQvZU55Rll/B/aJ/OSqs44Glo6xSQ2RmvQXU6xfglrtcSuEJN/UbvjDX+fPeGr5RVyV2dClLETaDNGTSekoeutEykCozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647742; c=relaxed/simple;
	bh=mnTSyIJx7Z8qgxaEwj2ggIwPfuTzZAkql7fbhie0Do0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdBsm1uCUBUwvWodykJKHJ6P6rHfPpds20g+dATuI/pprmOZKE8oN9O0m8qkLjGVDyoRMTIHdHJPvPJXb5EVwRNkJu57xdWgcLYD5KHDBiAQzYO/D9rX/oD8dQsKkoKJUvawChtvIlS29vY4xKmzXv5RewsDugWlGyGM6EEUanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0383e2b690e011efa216b1d71e6e1362-20241023
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:0d99ba52-3139-4233-b091-d9b6c104b120,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:fdcf2d84430f4a67032aa1c2f09d9a7b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0383e2b690e011efa216b1d71e6e1362-20241023
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1753809140; Wed, 23 Oct 2024 09:42:07 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 8E996B801E43;
	Wed, 23 Oct 2024 09:42:07 +0800 (CST)
X-ns-mid: postfix-6718546C-977914385
Received: from localhost.localdomain (unknown [172.25.120.42])
	by node2.com.cn (NSMail) with ESMTPA id 3A3D5B801E43;
	Wed, 23 Oct 2024 01:42:03 +0000 (UTC)
From: chen zhang <chenzhang@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	cascardo@holoscopio.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH v2] platform/x86: classmate-laptop: use sysfs_emit() instead of sprintf()
Date: Wed, 23 Oct 2024 09:42:01 +0800
Message-Id: <20241023014201.16359-1-chenzhang@kylinos.cn>
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
v2: add #include <linux/sysfs.h>
---
 drivers/platform/x86/classmate-laptop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x=
86/classmate-laptop.c
index cb6fce655e35..6b1b8e444e24 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -12,6 +12,7 @@
 #include <linux/backlight.h>
 #include <linux/input.h>
 #include <linux/rfkill.h>
+#include <linux/sysfs.h>
=20
 struct cmpc_accel {
 	int sensitivity;
@@ -208,7 +209,7 @@ static ssize_t cmpc_accel_sensitivity_show_v4(struct =
device *dev,
 	inputdev =3D dev_get_drvdata(&acpi->dev);
 	accel =3D dev_get_drvdata(&inputdev->dev);
=20
-	return sprintf(buf, "%d\n", accel->sensitivity);
+	return sysfs_emit(buf, "%d\n", accel->sensitivity);
 }
=20
 static ssize_t cmpc_accel_sensitivity_store_v4(struct device *dev,
@@ -257,7 +258,7 @@ static ssize_t cmpc_accel_g_select_show_v4(struct dev=
ice *dev,
 	inputdev =3D dev_get_drvdata(&acpi->dev);
 	accel =3D dev_get_drvdata(&inputdev->dev);
=20
-	return sprintf(buf, "%d\n", accel->g_select);
+	return sysfs_emit(buf, "%d\n", accel->g_select);
 }
=20
 static ssize_t cmpc_accel_g_select_store_v4(struct device *dev,
@@ -550,7 +551,7 @@ static ssize_t cmpc_accel_sensitivity_show(struct dev=
ice *dev,
 	inputdev =3D dev_get_drvdata(&acpi->dev);
 	accel =3D dev_get_drvdata(&inputdev->dev);
=20
-	return sprintf(buf, "%d\n", accel->sensitivity);
+	return sysfs_emit(buf, "%d\n", accel->sensitivity);
 }
=20
 static ssize_t cmpc_accel_sensitivity_store(struct device *dev,
--=20
2.25.1


