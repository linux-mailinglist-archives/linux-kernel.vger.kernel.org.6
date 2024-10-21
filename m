Return-Path: <linux-kernel+bounces-373532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC49A587A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C78B20DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56EB67A;
	Mon, 21 Oct 2024 01:17:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1461C27
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729473461; cv=none; b=owT7avS0KERIQ0ZJfKMa6r7iWVShmn4N1B6CP664U3YR3OixPxctgxxMmxw+rxsMfXwaKVrJUypOZwIvo7mhXqAlySW3djGUxoocqiH6lQBubwp/Rc5TD43OB1eNi+fpGofWH/DPfaaqah9yuyRFM3b2++UHvCIMInNSnilCf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729473461; c=relaxed/simple;
	bh=5CcACS49hDXCkLO1qZ0CjdJgdUlMHlKFZ5c3ApVPW3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LMRWwO/QLg8FAPw7UOj+ZK4XvnH+NQ2vo3OwzoBQ+68TQfruDPj3wjOThE9z9r1a/gZ2bYMD/nD2kDC8rt6nghc3/KIfyMhi5b3vyy4oHyqgO1dmG8SECYzwDa1liTCdSxnqkaZV5NsUmBhL+TckFxrBzsUExG5ElqjG+ouge/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 39dccacc8f4a11efa216b1d71e6e1362-20241021
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:e60d0836-56e9-445c-84ee-345377496f2a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:37eb8528babbb630d6c02e2c687f8550,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 39dccacc8f4a11efa216b1d71e6e1362-20241021
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 455357184; Mon, 21 Oct 2024 09:17:23 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 226A4B8075B2;
	Mon, 21 Oct 2024 09:17:23 +0800 (CST)
X-ns-mid: postfix-6715ABA2-997432120
Received: from localhost.localdomain (unknown [172.25.120.42])
	by node2.com.cn (NSMail) with ESMTPA id EF116B8075B2;
	Mon, 21 Oct 2024 01:17:21 +0000 (UTC)
From: chen zhang <chenzhang@kylinos.cn>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	cascardo@holoscopio.com
Cc: linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH] platform/x86: classmate-laptop: use sysfs_emit() instead of sprintf()
Date: Mon, 21 Oct 2024 09:17:17 +0800
Message-Id: <20241021011717.6742-1-chenzhang@kylinos.cn>
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
 drivers/platform/x86/classmate-laptop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x=
86/classmate-laptop.c
index cb6fce655e35..14c238faca85 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -208,7 +208,7 @@ static ssize_t cmpc_accel_sensitivity_show_v4(struct =
device *dev,
 	inputdev =3D dev_get_drvdata(&acpi->dev);
 	accel =3D dev_get_drvdata(&inputdev->dev);
=20
-	return sprintf(buf, "%d\n", accel->sensitivity);
+	return sysfs_emit(buf, "%d\n", accel->sensitivity);
 }
=20
 static ssize_t cmpc_accel_sensitivity_store_v4(struct device *dev,
@@ -257,7 +257,7 @@ static ssize_t cmpc_accel_g_select_show_v4(struct dev=
ice *dev,
 	inputdev =3D dev_get_drvdata(&acpi->dev);
 	accel =3D dev_get_drvdata(&inputdev->dev);
=20
-	return sprintf(buf, "%d\n", accel->g_select);
+	return sysfs_emit(buf, "%d\n", accel->g_select);
 }
=20
 static ssize_t cmpc_accel_g_select_store_v4(struct device *dev,
@@ -550,7 +550,7 @@ static ssize_t cmpc_accel_sensitivity_show(struct dev=
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


