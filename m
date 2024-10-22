Return-Path: <linux-kernel+bounces-375480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF59A9681
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FBE1F22FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916C13A256;
	Tue, 22 Oct 2024 03:05:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370F322A;
	Tue, 22 Oct 2024 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566315; cv=none; b=dVE5covuirRvAMOk8lAQTk33pMmfSWwQ1riM6bmnN4lzVVUEl4URymgHwvxk0TUbBBrLSwpCT4S1eEZH6lTpVw1frDCkkwYBC3MTrCqaNgFNxQaC/C7yWhH4L+uzTux+Jnp8SSwyFWxn6tpht5PXqNqsy1feGPhrGgRzWE6i9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566315; c=relaxed/simple;
	bh=m4+eS4V6+vhd8CWUw5Qgl7HndtPj4Htf8LeQ7P4YESw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BcSTXjZdzxoOQrxZ6TgA11IOeN5u0UZXg71V+4/l1Ui4fHyyPeiHw5K8R6FLpqHi1Qp7V6BqEjYkN04NdS2X3tp7ZJdgTezPhddKAV5mKloQNmMGMfHewftWdjMJde8ZdidXxw4c4wFRC/MpCpKmq0q9HoRvODlexxV/6NkJlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6f9fbc04902211efa216b1d71e6e1362-20241022
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:95921cc9-9604-4c6e-83cd-0d37612cbdf2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:0dbe1b5675f64aca33671ce0cd2c9136,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6f9fbc04902211efa216b1d71e6e1362-20241022
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 694247558; Tue, 22 Oct 2024 11:05:04 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 99233B803CA1;
	Tue, 22 Oct 2024 11:05:04 +0800 (CST)
X-ns-mid: postfix-67171660-471993715
Received: from localhost.localdomain (unknown [172.25.120.36])
	by node2.com.cn (NSMail) with ESMTPA id E6C82B803CA1;
	Tue, 22 Oct 2024 03:05:03 +0000 (UTC)
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: stuart.w.hayes@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH v2] platform/x86: dell-dcdbase: Replace snprintf in show  functions with sysfs_emit
Date: Tue, 22 Oct 2024 11:05:00 +0800
Message-Id: <20241022030500.9986-1-zenghongling@kylinos.cn>
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

Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/platform/x86/dell/dcdbas.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/de=
ll/dcdbas.c
index a60e350..c2fef23 100644
--- a/drivers/platform/x86/dell/dcdbas.c
+++ b/drivers/platform/x86/dell/dcdbas.c
@@ -31,6 +31,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/sysfs.h>
=20
 #include "dcdbas.h"
=20
@@ -132,14 +133,14 @@ static ssize_t smi_data_buf_phys_addr_show(struct d=
evice *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	return sprintf(buf, "%x\n", (u32)smi_buf.dma);
+	return sysfs_emit(buf, "%x\n", (u32)smi_buf.dma);
 }
=20
 static ssize_t smi_data_buf_size_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	return sprintf(buf, "%lu\n", smi_buf.size);
+	return sysfs_emit(buf, "%lu\n", smi_buf.size);
 }
=20
 static ssize_t smi_data_buf_size_store(struct device *dev,
@@ -200,7 +201,7 @@ static ssize_t host_control_action_show(struct device=
 *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%u\n", host_control_action);
+	return sysfs_emit(buf, "%u\n", host_control_action);
 }
=20
 static ssize_t host_control_action_store(struct device *dev,
@@ -224,7 +225,7 @@ static ssize_t host_control_smi_type_show(struct devi=
ce *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	return sprintf(buf, "%u\n", host_control_smi_type);
+	return sysfs_emit(buf, "%u\n", host_control_smi_type);
 }
=20
 static ssize_t host_control_smi_type_store(struct device *dev,
@@ -239,7 +240,7 @@ static ssize_t host_control_on_shutdown_show(struct d=
evice *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	return sprintf(buf, "%u\n", host_control_on_shutdown);
+	return sysfs_emit(buf, "%u\n", host_control_on_shutdown);
 }
=20
 static ssize_t host_control_on_shutdown_store(struct device *dev,
--=20
2.1.0


