Return-Path: <linux-kernel+bounces-257763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9788937E97
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 03:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7292428248A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4013E5664;
	Sat, 20 Jul 2024 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="oQ3a+FHP"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACC137E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721438532; cv=none; b=PGVvcSGZv8yqcTqgm5/7BbiX6lVBSg9IIHEC7wRs8MsHxiulaSTlRmYV2CVb/0aEn8BBv1i5yovN+I/KXCrTx3XYmyG7P2ZvRVMA1SHk8SU0wGSkVbfYOOqZT9x4wD9J49bMnC1sMhNBC/TcZKWD5iwusK2Iubil1p7ui2KoTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721438532; c=relaxed/simple;
	bh=YHQDDYKuBcQ7+X3lxF3PI1Ued4PJZSuyv3j9QbOSzI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D/VvaDNcFJtkIXYbV/AGjuzQOpz+qqNEgJ+bJwE/jy1JFrnvvzIOg1FckfFKfqnfLXYBgOY22HAE3HTCFYTY9l2s1ZpNIawKese1Dyulo9sGPui+QWgJbyYl7PpkXCjF8RQZQ7vODwckVw2iF+b8mmiH2mSq5tHV+cwojefxG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=oQ3a+FHP; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1721438530;
	bh=xXwBdoWuI3koAQ4M9ql/X01OP7VjiuRi/F4K5Ba2O9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=oQ3a+FHPqiYD+QDz3jeGthZLwsV8zYX/UBliBQu2prY0qY/vxivU0StM0yAasoO+S
	 k46Dxy0ATceZJD471jLgH+f7dT4RtAwL8IcbwAhawhLDjABkhyKsY2lT1mZG0+zk7e
	 /g5Ubk/o97+cmLjgoB646miWijz3qan3ys9kpa5UOde6bfo2R/SvB6+cXSxhRKUsJF
	 Ct1c7jSGroYmHTAKzaobdUkIr8GCwjibAyUW0+Kk5kbtu+7K/KkafDEFLoVEzMQTDg
	 i9fRLyYlxSD6bqoC97EFPJ2sXJ9ZhkqhkaSe57Yh03tgUxsnEsjlYTVzYuPo6Hd8FS
	 VFrMmvHptnywQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 423CB4A031F;
	Sat, 20 Jul 2024 01:22:05 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 20 Jul 2024 09:21:50 +0800
Subject: [PATCH] driver core: Simplify driver API
 device_find_child_by_name() implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-simplify_drv_api-v1-1-07c5e028cccf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC0Rm2YC/x3MTQqAIBBA4avErBPMjKyrRIjYWAP9iIIU4d2Tl
 t/ivRciBsIIY/VCwESRrrOgqSuwmzlXZLQUg+BC8l5wFunwO7lHLyFp44nxTrnBtZ2SVkDJfEB
 H97+c5pw/zGEAomIAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: Jak1FMCNKNkykAnm9NMxwTJO5gzDfanY
X-Proofpoint-ORIG-GUID: Jak1FMCNKNkykAnm9NMxwTJO5gzDfanY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_11,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407200009
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify device_find_child_by_name() implementation by using present
driver APIs device_find_child() and device_match_name().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c    | 15 +++------------
 include/linux/device.h |  4 ++++
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 730cae66607c..22ab4b8a2bcd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4089,18 +4089,9 @@ EXPORT_SYMBOL_GPL(device_find_child);
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name)
 {
-	struct klist_iter i;
-	struct device *child;
-
-	if (!parent)
-		return NULL;
-
-	klist_iter_init(&parent->p->klist_children, &i);
-	while ((child = next_device(&i)))
-		if (sysfs_streq(dev_name(child), name) && get_device(child))
-			break;
-	klist_iter_exit(&i);
-	return child;
+	/* TODO: remove type cast after const device_find_child() prototype */
+	return device_find_child(parent, (void *)name,
+				 (int (*)(struct device *, void *))device_match_name);
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 34eb20f5966f..685ffd2dc867 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -47,6 +47,9 @@ struct dev_pin_info;
 struct dev_iommu;
 struct msi_device_data;
 
+/* TODO: unify device match() parameter of driver APIs to this signature */
+typedef int (*device_match_t)(struct device *dev, const void *data);
+
 /**
  * struct subsys_interface - interfaces to device functions
  * @name:       name of the device function
@@ -1073,6 +1076,7 @@ int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse(struct device *dev, void *data,
 				  int (*fn)(struct device *dev, void *data));
+/* TODO: change type of @data to const void * and @match to device_match_t */
 struct device *device_find_child(struct device *dev, void *data,
 				 int (*match)(struct device *dev, void *data));
 struct device *device_find_child_by_name(struct device *parent,

---
base-commit: b57d5ffc3ab507d0e19fc8b90b19c76af43fb790
change-id: 20240720-simplify_drv_api-058f9f3584c2

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


