Return-Path: <linux-kernel+bounces-397722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5E9BDF8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC091F21EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BAC1D0BA3;
	Wed,  6 Nov 2024 07:39:57 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A91514CC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878797; cv=none; b=MGL5FgV0bT2Aski0N06as/VPwegLVjB/4f1v6AWGBnRaQwRCUXZUg+jnap9FLUtKJ6FwXT9XdlR5Plies14OzaA7GXlKa/eNBn1pxZnBe0OfybNmN0xMXCpW2UCdDg1YwMxhL7xHF0QzY5RpZpFIcidx+7f53XXIxYYquhn/Zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878797; c=relaxed/simple;
	bh=WFTZZe83my0HVfbGmWJaeaWKAX1cqfRiclYP1RdKTMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mt7PV+HAo9zDU03mC/kYQsmxUwjzVMM0Ru8Rfx/wVUeFhLC/Yqbkz0rrmsaB53UvUEtJA/74cxtipuzGQpqCAGbrqul6wYYR2FlQYU5icgJ9I8EfHZq9kehPv/3p7KLCsB8wdgQPVg6EGAEEXtOZYvK0Nj82OJ5DT/F1SIHwSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a7524d69c1211efa216b1d71e6e1362-20241106
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:acf78c2d-8473-499b-9954-9f3e4a6c78f8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:22f915138838171f3c8e3aac12197496,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4a7524d69c1211efa216b1d71e6e1362-20241106
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 406494892; Wed, 06 Nov 2024 15:39:44 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3E840E000E82;
	Wed,  6 Nov 2024 15:39:44 +0800 (CST)
X-ns-mid: postfix-672B1D40-7018570
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id D0F9DE000E82;
	Wed,  6 Nov 2024 15:39:41 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: jk@ozlabs.org,
	joel@jms.id.au,
	alistair@popple.id.au,
	eajames@linux.ibm.com
Cc: linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH] fsi: core: use sysfs_emit() instead of sprintf()
Date: Wed,  6 Nov 2024 15:39:37 +0800
Message-ID: <20241106073937.2219081-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
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

Signed-off-by: zhangheng <zhangheng@kylinos.cn>
---
 drivers/fsi/fsi-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index e2e1e9df6115..2fdc866345ab 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -784,7 +784,7 @@ static ssize_t slave_send_echo_show(struct device *de=
v,
 {
 	struct fsi_slave *slave =3D to_fsi_slave(dev);
=20
-	return sprintf(buf, "%u\n", slave->t_send_delay);
+	return sysfs_emit(buf, "%u\n", slave->t_send_delay);
 }
=20
 static ssize_t slave_send_echo_store(struct device *dev,
@@ -828,7 +828,7 @@ static ssize_t chip_id_show(struct device *dev,
 {
 	struct fsi_slave *slave =3D to_fsi_slave(dev);
=20
-	return sprintf(buf, "%d\n", slave->chip_id);
+	return sysfs_emit(buf, "%d\n", slave->chip_id);
 }
=20
 static DEVICE_ATTR_RO(chip_id);
@@ -839,7 +839,7 @@ static ssize_t cfam_id_show(struct device *dev,
 {
 	struct fsi_slave *slave =3D to_fsi_slave(dev);
=20
-	return sprintf(buf, "0x%x\n", slave->cfam_id);
+	return sysfs_emit(buf, "0x%x\n", slave->cfam_id);
 }
=20
 static DEVICE_ATTR_RO(cfam_id);
--=20
2.45.2


