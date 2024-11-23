Return-Path: <linux-kernel+bounces-418990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA25D9D681F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 09:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B87AB21FA0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8DA17084F;
	Sat, 23 Nov 2024 08:04:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2A4A0A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732349072; cv=none; b=TqhaVKjvvrKZES9VTQ8xRMcyfEr4gOjlkxbYtntxQGWVOY4sSRbgDYDEHTUP/QqVHGlPZdZFHIvfbf8agLtS+pHaPjAo/7K2418dl/wF38/R/+ErYZSJA58coLpZiOelN7/jyeNv2VYfEts8i8ikpMwHZJvM5DBuLzNBE0f+z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732349072; c=relaxed/simple;
	bh=ug66vYpQ4s3Mp02qYiw8DI9y31v7jMd/hF5JuhjCg64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlAs4+gn+cTmo00NbM2gtKfah53Wuzca5uISeAWIK89zkTO9TYCpa6jlQ6RvcliQi1Bkjcbijg3TOOBgNl1XvZp6HHG294gLMeetIbu3OkhlY7HCBKbptp3xwcNTSwjZdVVPAY0DJ4nO8zmMoyEDHF3ChV2oSGG+pm+/UR37wUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 87cfae98a97111efa216b1d71e6e1362-20241123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:3ee12d97-c8cf-47e3-bac6-362eab512517,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:4fbf664eb47ed900e069e2862e5b0a08,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 87cfae98a97111efa216b1d71e6e1362-20241123
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1657895154; Sat, 23 Nov 2024 16:04:14 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7EDFBE0080FF;
	Sat, 23 Nov 2024 16:04:14 +0800 (CST)
X-ns-mid: postfix-67418C7E-2195251
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id C6E61E0080FF;
	Sat, 23 Nov 2024 16:04:13 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: krzk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH] w1: core: use sysfs_emit() instead of sprintf()
Date: Sat, 23 Nov 2024 16:04:11 +0800
Message-ID: <20241123080411.1255531-1-zhangheng@kylinos.cn>
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
 drivers/w1/slaves/w1_ds28e17.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e1=
7.c
index 52261b54d842..34861ae3609b 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -583,7 +583,7 @@ static ssize_t speed_show(struct device *dev, struct =
device_attribute *attr,
 		return result;
=20
 	/* Return current speed value. */
-	return sprintf(buf, "%d\n", result);
+	sysfs_emit(buf, "%d\n", result);
 }
=20
 static ssize_t speed_store(struct device *dev, struct device_attribute *=
attr,
@@ -633,7 +633,7 @@ static ssize_t stretch_show(struct device *dev, struc=
t device_attribute *attr,
 	struct w1_f19_data *data =3D sl->family_data;
=20
 	/* Return current stretch value. */
-	return sprintf(buf, "%d\n", data->stretch);
+	sysfs_emit(buf, "%d\n", data->stretch);
 }
=20
 static ssize_t stretch_store(struct device *dev, struct device_attribute=
 *attr,
--=20
2.45.2


