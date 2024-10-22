Return-Path: <linux-kernel+bounces-375477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B9B9A9672
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A7AB2280E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A6139579;
	Tue, 22 Oct 2024 02:58:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D084D34;
	Tue, 22 Oct 2024 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565914; cv=none; b=TPFg6ygRRITCL3AivN+89KujB1oDUQL4ld8fkwdLY9L2iFRCW58pCL5YtAi6Kb2ebR2SzKx1dmESBF5MAn0znSI22PCfgTD5AkJkJvdnuQqECFlPGTw4E1ZkN4Kwn387eBMgyx8+Ojv4558Ju/EdIbEqTPyMmBc5g1mef8MnTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565914; c=relaxed/simple;
	bh=jtBug8ONzyE+kgGa52pv+JdSpoMjZthiSSGGuBkAA1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MI13+B0Xd1c1nomifstp4E+GLOzlV9xuWCZY9QUYk8nQUWCMdy/yJT+9OBUkM3dtOpD76/c43s33JtZT6rAzlE50K5jAfz9itzT+Rfnf/Ob9DYWsJ6yhwBHsvWEZKJuTBS6hZ52hdJ1jexGibfX9VQgSAaH6x9g/dYc7dUrwmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c11631e6902011efa216b1d71e6e1362-20241022
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:0c6b36cb-c30b-4b21-ae72-df23d343b5a7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:b1f2c70976c0514a32db13af13aaec06,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c11631e6902011efa216b1d71e6e1362-20241022
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 50847325; Tue, 22 Oct 2024 10:53:02 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 49AF8B803C9E;
	Tue, 22 Oct 2024 10:53:02 +0800 (CST)
X-ns-mid: postfix-6717138E-155168618
Received: from localhost.localdomain (unknown [172.25.120.36])
	by node2.com.cn (NSMail) with ESMTPA id EDCBBB803C9E;
	Tue, 22 Oct 2024 02:53:00 +0000 (UTC)
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: cascardo@holoscopio.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH v2] platform/x86: classmate-laptop: Replace snprintf in show functions with sysfs_emit
Date: Tue, 22 Oct 2024 10:52:59 +0800
Message-Id: <20241022025259.9255-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

show() must not use snprintf() when formatting the value to be
returned to user space.

Signed-off-by: Hongling Zeng<zenghongling@kylinos.cn>
---
 drivers/platform/x86/classmate-laptop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x=
86/classmate-laptop.c
index cb6fce6..6b1b8e4 100644
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
2.1.0


