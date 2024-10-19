Return-Path: <linux-kernel+bounces-372644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7879A4B65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 07:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E35284446
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69561D7E4A;
	Sat, 19 Oct 2024 05:49:44 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8F1CCB38;
	Sat, 19 Oct 2024 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729316984; cv=none; b=MmxoPzbWvCjZCoTXbWgXe1TI69yvh67W/7M3AZZgk3ai4M73u7aKuBYbrJB8qIC/URC840mNCAwKold7UqqxVbEizDYGyZGdWplgYFj2BXXwo/t2j9e050+f4hYhvXgJq9hmXtU517qWibMDZKQ5G8Rg2RO/o1U+18vzmDYYucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729316984; c=relaxed/simple;
	bh=TCKXp0xWd7Dw8fzDGKPOb6h9rRm7MKlq/hTgggma5u0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qw0z0YNqpC9xXmsIM8/nIz+3N69fauFRbxqqtaTtb7eE7+cJiSvUNHQp+CL44D/a030NBf5poVNvzARtvdwRl+4Zm2843IoVq/rrLeE8OgD1ssRpDQr1hfdSrslAZHfDA7QrQdyUcBAgooLeIh0ZX8MGk9NYjn+yXqPTpCXC36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 34fcc0f28ddd11efa216b1d71e6e1362-20241019
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:de6f9663-81ef-429f-988c-9599fad8717b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:7a1d34aa99857860102f200b9195634e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 34fcc0f28ddd11efa216b1d71e6e1362-20241019
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1327347778; Sat, 19 Oct 2024 13:44:28 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 9A965B80758A;
	Sat, 19 Oct 2024 13:44:28 +0800 (CST)
X-ns-mid: postfix-6713473C-4885442
Received: from localhost.localdomain (unknown [172.25.120.36])
	by node2.com.cn (NSMail) with ESMTPA id 434BDB80758A;
	Sat, 19 Oct 2024 05:44:27 +0000 (UTC)
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: cascardo@holoscopio.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH v1] platform/x86: classmate-laptop: Replace snprintf in show functions with sysfs_emit
Date: Sat, 19 Oct 2024 13:44:26 +0800
Message-Id: <20241019054426.8182-1-zenghongling@kylinos.cn>
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
 drivers/platform/x86/classmate-laptop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x=
86/classmate-laptop.c
index cb6fce6..14c238f 100644
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
2.1.0


