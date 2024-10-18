Return-Path: <linux-kernel+bounces-371402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56CA9A3A95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF30287536
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6220101B;
	Fri, 18 Oct 2024 09:56:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC95200CB8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245369; cv=none; b=hf4VwYq2Evwu366350GOwON5j+RoVxDQ9dY/ZOaO+ZMoYXM39jSY/SNakTw21O3ayTdQGiv8ER5b6p4moiz5xKHPnkmJM4VqsSXGhgyzJLIq5VHgu/Rxbu18iO+9rTO1wrcFECS8ySj3/syql1HFB6sLkAFP2LbKiGsh77H6MwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245369; c=relaxed/simple;
	bh=WLOiwswVWoe8YIe3YUxVolWHXnAUMUs2vRbLsIPouCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNcBZHr0hokgwgBszdMsHS05lEuqxI20cvXWGN6EHPKF8zVGiYoCBARehtRxQJordDddbrK8cPyhk+0OkWcOElu3pwkp17SywWdxUyXmx2/netoFqkzetD3f831xgaeBDknM+idDzt3MktUOOxgoVfjfgLuZnfnbBYkGMX5IRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2cf5b5fe8d3711efa216b1d71e6e1362-20241018
X-CID-CACHE: Type:Local,Time:202410181734+08,HitQuantity:3
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d2113a9a-c013-44e0-b2b4-9afe0b14af3e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:a276e182aded7ad3b9423b24e97e2560,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2cf5b5fe8d3711efa216b1d71e6e1362-20241018
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 123531707; Fri, 18 Oct 2024 17:55:58 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id A8FFFB803CA1;
	Fri, 18 Oct 2024 17:55:58 +0800 (CST)
X-ns-mid: postfix-671230AE-622751201
Received: from localhost.localdomain (unknown [172.25.120.42])
	by node2.com.cn (NSMail) with ESMTPA id DB6FBB803CA1;
	Fri, 18 Oct 2024 09:55:56 +0000 (UTC)
From: chen zhang <chenzhang@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	luke@ljones.dev
Cc: linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH] platform/x86: eeepc-laptop: use sysfs_emit() instead of sprintf()
Date: Fri, 18 Oct 2024 17:55:47 +0800
Message-Id: <20241018095547.46006-1-chenzhang@kylinos.cn>
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
 drivers/platform/x86/eeepc-laptop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/e=
eepc-laptop.c
index 03319a80e114..ba36b7bf6dc4 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -285,7 +285,7 @@ static ssize_t show_sys_acpi(struct device *dev, int =
cm, char *buf)
=20
 	if (value < 0)
 		return -EIO;
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
=20
 #define EEEPC_ACPI_SHOW_FUNC(_name, _cm)				\
@@ -361,7 +361,7 @@ static ssize_t cpufv_show(struct device *dev,
=20
 	if (get_cpufv(eeepc, &c))
 		return -ENODEV;
-	return sprintf(buf, "%#x\n", (c.num << 8) | c.cur);
+	return sysfs_emit(buf, "%#x\n", (c.num << 8) | c.cur);
 }
=20
 static ssize_t cpufv_store(struct device *dev,
@@ -393,7 +393,7 @@ static ssize_t cpufv_disabled_show(struct device *dev=
,
 {
 	struct eeepc_laptop *eeepc =3D dev_get_drvdata(dev);
=20
-	return sprintf(buf, "%d\n", eeepc->cpufv_disabled);
+	return sysfs_emit(buf, "%d\n", eeepc->cpufv_disabled);
 }
=20
 static ssize_t cpufv_disabled_store(struct device *dev,
@@ -1025,7 +1025,7 @@ static ssize_t store_sys_hwmon(void (*set)(int), co=
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


