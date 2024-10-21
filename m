Return-Path: <linux-kernel+bounces-373557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02659A58CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8946528295C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9E01CFBC;
	Mon, 21 Oct 2024 02:14:53 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3D9463;
	Mon, 21 Oct 2024 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729476893; cv=none; b=r/TvWtFvsBGl7GFQHihFIZ60nw5TvG84MXjKi1tuvrS9T9Zbmb+12aN+qvn6iHTIU5fBttM8KRy0LhyYxyxTaKIR6Y8bUFcO40iJMaejVQllDuUt4tFEdb+RazTZeIIxY/LEeZ+rVvGjjBvGa8TjZ0IDi3n3rn7Cf8RlrBwGNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729476893; c=relaxed/simple;
	bh=2VjWKIXAWHuHHC7RhYcuwK63hrbTsYS1nxgkeYa92Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/kiZchojB7O4XiLKC929RV8YyfvPhCPUaefWMcJWqgni4Qu9l++kZw7hB9Wl8KLVba95yA90Xo7/v7kOH0w43N2UHZ8YVccVMUNQhe9kRFtKAdXet8sVoUyRUdqfx31HJK9xfljrpOTC/YYa+XJ4sQ4xomSXDd+r41miEs5010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b31e80a8f5211efa216b1d71e6e1362-20241021
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7727c2d3-5d38-4940-9ce9-8409a27534a6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:5dbac00cc02ee61ea71a56b997bc4fcd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3b31e80a8f5211efa216b1d71e6e1362-20241021
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 267218282; Mon, 21 Oct 2024 10:14:41 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 553B2B8075B2;
	Mon, 21 Oct 2024 10:14:41 +0800 (CST)
X-ns-mid: postfix-6715B911-209283303
Received: from localhost.localdomain (unknown [172.25.120.36])
	by node2.com.cn (NSMail) with ESMTPA id 703ECB8075B2;
	Mon, 21 Oct 2024 02:14:40 +0000 (UTC)
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: stuart.w.hayes@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] platform/x86: dell-dcdbase: Replace snprintf in show  functions with sysfs_emit
Date: Mon, 21 Oct 2024 10:14:12 +0800
Message-Id: <20241021021412.5728-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

  show() must not use snprintf() when formatting the value to be
returned to user space

Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/platform/x86/dell/dcdbas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/de=
ll/dcdbas.c
index a60e350..143fd0a 100644
--- a/drivers/platform/x86/dell/dcdbas.c
+++ b/drivers/platform/x86/dell/dcdbas.c
@@ -132,14 +132,14 @@ static ssize_t smi_data_buf_phys_addr_show(struct d=
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
@@ -200,7 +200,7 @@ static ssize_t host_control_action_show(struct device=
 *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sprintf(buf, "%u\n", host_control_action);
+	return sysfs_emit(buf, "%u\n", host_control_action);
 }
=20
 static ssize_t host_control_action_store(struct device *dev,
@@ -224,7 +224,7 @@ static ssize_t host_control_smi_type_show(struct devi=
ce *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	return sprintf(buf, "%u\n", host_control_smi_type);
+	return sysfs_emit(buf, "%u\n", host_control_smi_type);
 }
=20
 static ssize_t host_control_smi_type_store(struct device *dev,
@@ -239,7 +239,7 @@ static ssize_t host_control_on_shutdown_show(struct d=
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


