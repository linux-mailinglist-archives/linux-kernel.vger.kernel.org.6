Return-Path: <linux-kernel+bounces-377188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19969ABB06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36B3284F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609329422;
	Wed, 23 Oct 2024 01:30:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38C1804E;
	Wed, 23 Oct 2024 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647036; cv=none; b=jj7GdHzCFPxhSk6GSW1MsPByTCQj/pnMYftodRu68Hiw41Wj7ryTe1dcdIuJZJaRS/SLqCUn5jR47iVkoIJOE/F/MnAbntG8pldT1C9fbyopr+7BrCXEkoYjjcizXTvrJOcDLPT9td2LKMlzFMSyNkGoYDf/2I0LKc4+HYo10Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647036; c=relaxed/simple;
	bh=6F0/kW5iDHAABeRS65zbRBcRQo1wnYoeTOx2mCqUwN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoRG+Mldogr1BK4gYH1Fxccs1Rt5pa6uUQkCYq9KYZNuNptI2JZpA06GUvbSRIWIgUC8KnmzJi7S+qdj9Q5neTm0cJbR9T8nPQqYLxtXhrxk3COp5ADoCtJbU9ayeABowNc1WgUefJCLs+EYutX3i1q7fHq0Wqhq1+NO9PRBpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 350dba0290de11efa216b1d71e6e1362-20241023
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ffd64744-868e-4835-adb4-345b044cc37a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:fb4235fc8eb438f3b9e33a35987cca17,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 350dba0290de11efa216b1d71e6e1362-20241023
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1341631161; Wed, 23 Oct 2024 09:29:11 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id B1C12B801E43;
	Wed, 23 Oct 2024 09:29:11 +0800 (CST)
X-ns-mid: postfix-67185167-5818374313
Received: from localhost.localdomain (unknown [172.25.120.42])
	by node2.com.cn (NSMail) with ESMTPA id 71C53B801E43;
	Wed, 23 Oct 2024 01:29:10 +0000 (UTC)
From: chen zhang <chenzhang@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	luke@ljones.dev
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH v2] platform/x86: eeepc-laptop: use sysfs_emit() instead of sprintf()
Date: Wed, 23 Oct 2024 09:29:05 +0800
Message-Id: <20241023012905.15551-1-chenzhang@kylinos.cn>
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
 drivers/platform/x86/eeepc-laptop.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/e=
eepc-laptop.c
index 03319a80e114..f52fbc4924d4 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -25,6 +25,7 @@
 #include <linux/rfkill.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/sysfs.h>
 #include <linux/leds.h>
 #include <linux/dmi.h>
 #include <acpi/video.h>
@@ -285,7 +286,7 @@ static ssize_t show_sys_acpi(struct device *dev, int =
cm, char *buf)
=20
 	if (value < 0)
 		return -EIO;
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
=20
 #define EEEPC_ACPI_SHOW_FUNC(_name, _cm)				\
@@ -361,7 +362,7 @@ static ssize_t cpufv_show(struct device *dev,
=20
 	if (get_cpufv(eeepc, &c))
 		return -ENODEV;
-	return sprintf(buf, "%#x\n", (c.num << 8) | c.cur);
+	return sysfs_emit(buf, "%#x\n", (c.num << 8) | c.cur);
 }
=20
 static ssize_t cpufv_store(struct device *dev,
@@ -393,7 +394,7 @@ static ssize_t cpufv_disabled_show(struct device *dev=
,
 {
 	struct eeepc_laptop *eeepc =3D dev_get_drvdata(dev);
=20
-	return sprintf(buf, "%d\n", eeepc->cpufv_disabled);
+	return sysfs_emit(buf, "%d\n", eeepc->cpufv_disabled);
 }
=20
 static ssize_t cpufv_disabled_store(struct device *dev,
@@ -1025,7 +1026,7 @@ static ssize_t store_sys_hwmon(void (*set)(int), co=
nst char *buf, size_t count)
=20
 static ssize_t show_sys_hwmon(int (*get)(void), char *buf)
 {
-	return sprintf(buf, "%d\n", get());
+	return sysfs_emit(buf, "%d\n", get());
 }
=20
 #define EEEPC_SENSOR_SHOW_FUNC(_name, _get)				\
--=20
2.25.1


