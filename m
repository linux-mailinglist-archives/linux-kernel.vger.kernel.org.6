Return-Path: <linux-kernel+bounces-375873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A565F9A9C25
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE22B1C2198B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486E161310;
	Tue, 22 Oct 2024 08:15:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990C154449;
	Tue, 22 Oct 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584909; cv=none; b=C49uk3bAzKSAlXhYW0nnDC1RaI766jdO9wdyZluocc2cpLJ8I1FmS78qOsE0359c9a+K2FVxOoacZo6RSrDCkpHVgDjOOSYRQsK6KwUHE2eIzZLqB0iXJ1bespKX5xWi3Vnk3Ftojc1Iwtys4hD9sGVgv5+NzbD1SgvCG/TxMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584909; c=relaxed/simple;
	bh=U/NWSJgaG/brbJend3A20v2opbdbYHUDm1HqwMQNmf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dWRc2mzKzyetSPN+DKDL8ggoTk3Rmah1d/uBpfruX5IDBUGXS4d6+325z5jNqVUFVB9hj0Id19bSFZiX7vR8XoCdHuIHiESW+8es1KrTaDZwmj9xPQ9yAMgUArIHNxP28QpUCV/9+c+lfT5LX/xMXmgHxk+HYQjUxSGmrt4t0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b8b30d62904d11efa216b1d71e6e1362-20241022
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7729fda8-c9bb-4a49-896e-2ac0cd3266e4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:7003421bac135d5387b6f2f01a2421f5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b8b30d62904d11efa216b1d71e6e1362-20241022
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1439359024; Tue, 22 Oct 2024 16:14:55 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 8C17916002085;
	Tue, 22 Oct 2024 16:14:55 +0800 (CST)
X-ns-mid: postfix-67175EFF-4220401986
Received: from localhost.localdomain (unknown [172.25.120.86])
	by node4.com.cn (NSMail) with ESMTPA id BE0C616002085;
	Tue, 22 Oct 2024 08:14:54 +0000 (UTC)
From: Ai Chao <aichao@kylinos.cn>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] hwmon: (it87) Add support for IT8625E
Date: Tue, 22 Oct 2024 16:14:53 +0800
Message-Id: <20241022081453.75253-1-aichao@kylinos.cn>
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
 drivers/hwmon/it87.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index e233aafa8856..fac7b10d51bc 100644
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
@@ -163,6 +164,7 @@ static inline void superio_exit(int ioreg, bool noexi=
t)
 #define IT8623E_DEVID 0x8623
 #define IT8628E_DEVID 0x8628
 #define IT87952E_DEVID 0x8695
+#define IT8625E_DEVID 0x8625
=20
 /* Logical device 4 (Environmental Monitor) registers */
 #define IT87_ACT_REG	0x30
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


