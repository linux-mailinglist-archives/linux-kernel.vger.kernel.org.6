Return-Path: <linux-kernel+bounces-262411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7993C6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29041C222C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A619D8AB;
	Thu, 25 Jul 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ncTdv0N8"
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18F19AD8B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922091; cv=none; b=m7A2YEPlQBbT3KTQOacTQeLRU0vNcIEc7blB9E2bXNJYD00aEWFVKEsXySExFe9Q+GqS/tUCg0STVzSWTU8xNgjvsOP1TrhFnOmIuJ+Wbbd7jbQy8WcAK7h/n/GmlIa/ndx/ILNAE7tInSyjVzLYZ/4ewV/6uABLy66eSSxOjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922091; c=relaxed/simple;
	bh=OJquqfifCbXjO+JCBJqndNpAbD1aU2SfjCvNlyZ9scg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NQzoFMazr8z44zdVgpsSK3XbkAwQKKztyZoUGIstDtmO0LN8PzEr5yP7qNU/pSMtfTIOpCvbQGFU+pGG2fDgtlE3Eoh0Kr3ejhALjG6LwMLDHdmcwPXM3yOsatS77pZ6n/iqTT1citLOYAy7Aqwp93UtF0qlOb7RIf1dJrfwE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ncTdv0N8; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1721922089;
	bh=47vpukREQCXQYNLqmkYhwXvAixh3pHzzXqmJ4kUC5Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=ncTdv0N8+4mdvTXVdbO1UjIY77V7bvW00Hwkglsii0bwQL2X/2eKVHFcoWBiV8BFy
	 Mwe3F3PiwqKUu9CvHeqlTlmqGusVyNV0mN1X1Z6YL7ll88as7Fk6jyqq5tgyBMKcCv
	 M15y1ZOmVzdgXkodTq8YyXE+OFn26htNRCKwDa5GvLwkyldpIlWv8G4EsImfOYKn9w
	 UIDadqjIBuk3nnS/jzIgq09qIW6vYPTUPZCn5MPOlqZccF9KK92pX39Lm9HG7xiiXf
	 1q3nuFGUPNTbDotkEpt/yq27J/UIuZHa5XdG7YNnPVwaipgUqpc/6rDaXrERIFkAd5
	 9dE/H+dhFRMIA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 85694C8017F;
	Thu, 25 Jul 2024 15:41:26 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 25 Jul 2024 23:40:55 +0800
Subject: [PATCH] driver core: Remove unused parameter for
 virtual_device_parent()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-virtual_kobj_fix-v1-1-36335cae4544@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAZyomYC/x2M0QpAMBRAf2XdZyvGWvyKJLaLizZtLCX/bnk8p
 855IKAnDNCwBzxGCuRsgiJjoJfBzsjJJAaRiypXQvJI/ryGvd/cuPYT3VwKVGVdaGUqDSk7PCb
 9L9vufT+TuGjMYgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: G5KaGhgAk5Q0QgoE5Tgc6A2a-qPRn_Xr
X-Proofpoint-GUID: G5KaGhgAk5Q0QgoE5Tgc6A2a-qPRn_Xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_14,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407250108
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Function struct kobject *virtual_device_parent(struct device *dev)
does not use its parameter @dev, and the kobject returned also has
nothing deal with specific device, so remove the unused parameter.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/base.h | 2 +-
 drivers/base/bus.c  | 2 +-
 drivers/base/core.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0b53593372d7..8cf04a557bdb 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -145,7 +145,7 @@ void auxiliary_bus_init(void);
 static inline void auxiliary_bus_init(void) { }
 #endif
 
-struct kobject *virtual_device_parent(struct device *dev);
+struct kobject *virtual_device_parent(void);
 
 int bus_add_device(struct device *dev);
 void bus_probe_device(struct device *dev);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ffea0728b8b2..6562c3a185f0 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1294,7 +1294,7 @@ int subsys_virtual_register(const struct bus_type *subsys,
 {
 	struct kobject *virtual_dir;
 
-	virtual_dir = virtual_device_parent(NULL);
+	virtual_dir = virtual_device_parent();
 	if (!virtual_dir)
 		return -ENOMEM;
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 730cae66607c..ff9c15a6a5c0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3167,7 +3167,7 @@ void device_initialize(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
-struct kobject *virtual_device_parent(struct device *dev)
+struct kobject *virtual_device_parent(void)
 {
 	static struct kobject *virtual_dir = NULL;
 
@@ -3245,7 +3245,7 @@ static struct kobject *get_device_parent(struct device *dev,
 		 * in a "glue" directory to prevent namespace collisions.
 		 */
 		if (parent == NULL)
-			parent_kobj = virtual_device_parent(dev);
+			parent_kobj = virtual_device_parent();
 		else if (parent->class && !dev->class->ns_type) {
 			subsys_put(sp);
 			return &parent->kobj;

---
base-commit: b57d5ffc3ab507d0e19fc8b90b19c76af43fb790
change-id: 20240725-virtual_kobj_fix-52e7391c7d4c

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


