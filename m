Return-Path: <linux-kernel+bounces-418166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E19D5DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB0D2811BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF841DEFC0;
	Fri, 22 Nov 2024 11:20:00 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A055C29;
	Fri, 22 Nov 2024 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274399; cv=none; b=lFD++TKHSk28NcBV+r6Wx4WYa4a2zEIUSwIMhlLk3OTZJS6Gnz4LlWm7Rmdr+mC+XFfTuDhWxbiaIidyt3+ECa5/8uWw3WYrTwzyFvzNrcVCDp3oimHsq3IcyRdopdQjEB4Ua9TGjBZU7iJD9fDBWX464Qcr9o3eBCf98dc9FlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274399; c=relaxed/simple;
	bh=DkTxg95VblgAot6ZNEDGTHGBHGn1h0iJNL0oEfb5Uzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtqYIi8XmIiKiV/AmyRwVt66PkxLFGCoqtSM4RHcMRyUfymz+FvQoksFzTa7ktbJXpfk3N8zMHsUQCRl8pMAZyFnzpAUk+fmETY6wC3vasS08nFiWQL7HL3C3oH3Imfhjmp/bnGVSP/5JeBKUvnPwjqVowjtQW8jwnW5RQ7mXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ad2a44b8a8c311efa216b1d71e6e1362-20241122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ae42c0b0-a9e7-4546-bd73-4a82017c8aad,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:51dafe351e7844d8121b696a02b87639,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ad2a44b8a8c311efa216b1d71e6e1362-20241122
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 387115066; Fri, 22 Nov 2024 19:19:44 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B1F5CE0080FF;
	Fri, 22 Nov 2024 19:19:44 +0800 (CST)
X-ns-mid: postfix-674068D0-48800530
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0C68DE0080FF;
	Fri, 22 Nov 2024 19:19:41 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	erick.archer@outlook.com,
	kees@kernel.org,
	geert@linux-m68k.org,
	jirislaby@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH] tty: rfcomm: use sysfs_emit() instead of sprintf()
Date: Fri, 22 Nov 2024 19:19:39 +0800
Message-ID: <20241122111939.3799277-1-zhangheng@kylinos.cn>
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
 net/bluetooth/rfcomm/tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index af80d599c337..21a5b5535ebc 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -201,14 +201,14 @@ static ssize_t address_show(struct device *tty_dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev =3D dev_get_drvdata(tty_dev);
-	return sprintf(buf, "%pMR\n", &dev->dst);
+	return sysfs_emit(buf, "%pMR\n", &dev->dst);
 }
=20
 static ssize_t channel_show(struct device *tty_dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev =3D dev_get_drvdata(tty_dev);
-	return sprintf(buf, "%d\n", dev->channel);
+	return sysfs_emit(buf, "%d\n", dev->channel);
 }
=20
 static DEVICE_ATTR_RO(address);
--=20
2.45.2


