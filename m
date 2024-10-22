Return-Path: <linux-kernel+bounces-375975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8729A9E10
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B651C22ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A9E194AFE;
	Tue, 22 Oct 2024 09:13:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DC126BEF;
	Tue, 22 Oct 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588414; cv=none; b=F/oow2kx5+n7scaYCY07exwnrO6mFNMBbFe+gVe6GBDwzDOjNrV8mpkf8zksMg6E6f4ihElAChJ1Pw58Ov75+0GHxaZmmkkF2Uzfmsj0rA3dq3FYGJMGVp5ZD7md5AA2nFDLRCq/MiD8ueiWGZnIg/IZpww9727SX6gdLV2uRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588414; c=relaxed/simple;
	bh=uQcyeGfEjADvn9CvG8A/aNb4Gl2ZXTR8CoS9QNJrcws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d8/P908FL76NupAvbNeKjWdaenGt5bJ+B4wh7EU3iAou+sdi/nIJq3R+FtP0p3O9vmadF1ZP6aPrj8vpU5DKywUcyG4Bj3hejBfi0y8wqRM8cafyIwkFgWNHmBPr3433NXLv4hRNN/U6rmyjH2SLkBVm1wlGn2LiX8EzkGu2fZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e2d43bfe905511efa216b1d71e6e1362-20241022
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b04e0f17-d009-490e-a540-7c357ec1aeba,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:4510cec1fe48b4281143ad123859e318,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e2d43bfe905511efa216b1d71e6e1362-20241022
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 48288663; Tue, 22 Oct 2024 17:13:22 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 396041600208F;
	Tue, 22 Oct 2024 17:13:22 +0800 (CST)
X-ns-mid: postfix-67176CB1-7483232368
Received: from localhost.localdomain (unknown [172.25.120.86])
	by node4.com.cn (NSMail) with ESMTPA id 5EA671600208F;
	Tue, 22 Oct 2024 09:13:21 +0000 (UTC)
From: Ai Chao <aichao@kylinos.cn>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v2] hwmon: (it87) Add support for IT8625E
Date: Tue, 22 Oct 2024 17:13:19 +0800
Message-Id: <20241022091319.82503-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for IT8625E on Centerm P410.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
change for v2
 - Move IT8625E_DEVID after IT8623E_DEVID
---
 drivers/hwmon/it87.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index e233aafa8856..4aeb09f3bfdf 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -15,6 +15,7 @@
  *            IT8620E  Super I/O chip w/LPC interface
  *            IT8622E  Super I/O chip w/LPC interface
  *            IT8623E  Super I/O chip w/LPC interface
+ *            IT8625E  Super I/O chip w/LPC interface
  *            IT8628E  Super I/O chip w/LPC interface
  *            IT8705F  Super I/O chip w/LPC interface
  *            IT8712F  Super I/O chip w/LPC interface
@@ -161,6 +162,7 @@ static inline void superio_exit(int ioreg, bool noexi=
t)
 #define IT8620E_DEVID 0x8620
 #define IT8622E_DEVID 0x8622
 #define IT8623E_DEVID 0x8623
+#define IT8625E_DEVID 0x8625
 #define IT8628E_DEVID 0x8628
 #define IT87952E_DEVID 0x8695
=20
@@ -2782,6 +2784,7 @@ static int __init it87_find(int sioaddr, unsigned s=
hort *address,
 	case IT8622E_DEVID:
 		sio_data->type =3D it8622;
 		break;
+	case IT8625E_DEVID:
 	case IT8628E_DEVID:
 		sio_data->type =3D it8628;
 		break;
--=20
2.25.1


