Return-Path: <linux-kernel+bounces-331969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A354497B37D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AF51C20D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98EF194124;
	Tue, 17 Sep 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LstmdZ7h"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F21925A5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593429; cv=none; b=YMezZ+lC4iL4fYakkG2zOR1RIBAa+e9Sv5GgXAZloaqCkredeGxpeQRZVEcS0tkkL+a1xgIEzIDmvN01bBSWlTcwPfjAflexLLQK+LPCCwL2mzah0E3kv6/tgLt2VuwOCmcRX5DwuN0E+pWQK/5Wxon+kjae4sMOLKTGRg0BBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593429; c=relaxed/simple;
	bh=+yJC/p6XNwewOkXIWJWuYKfwRHsUv8ia1k7GVdBmPaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRecA9yOdGWU9YvPbVHYQNt5vOkEbWZjnqgps9aTGALyYumkkN24s7hE9z6bFJ3U4jmIvQGXfIykk85az0ycwjibhwQ0fwcjr9SO+ycaslgdEl0kwJ9u3yeGtixFYZbJ44325EXrB9m6lKabBwtZA/5a/OC884bvSps5AYo/WNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LstmdZ7h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HA55GU031215;
	Tue, 17 Sep 2024 17:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=7UOjM9K8xNlhd
	u9GjXxWAossWVeWr/0FC+3SauZ3KMg=; b=LstmdZ7hKQzE0BDuNWHYa+BgQnxWa
	VjyeT4IMapTogyWp6ZMemlq5nhOZQqoc7neGuPo38YfihoZgBSsE4Ux9S6wArnl2
	tBaeCxwm++00KvQZ++/Z14y5O+fcqIX/gDYtC4KZTz+lvJC1Xz0qOR3EsOtbdzsu
	ovMHPk6Y19PAjLe2SQR4GkeV4sovntCkK5IwdA8+9FlTNY7Axv3LAWMdENP7q5k6
	Lvjl7cTiuLW9051mt5ThsWt7xlr3EhYQMZ7FQS9cXSjKovfKdgYu5mWoiSPiH0XC
	wxF02jafW2ZV06R3SugSp7UVx9+EOoyizYYozI/A7fIuo6CVPmOpssYWQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnrxu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HH3YhA001819;
	Tue, 17 Sep 2024 17:16:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nqh3p4mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGoG352756762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86E5958057;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A0FF5805D;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 12/15] fsi: occ: Get device number from FSI minor number API
Date: Tue, 17 Sep 2024 12:16:44 -0500
Message-ID: <20240917171647.1403910-13-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917171647.1403910-1-eajames@linux.ibm.com>
References: <20240917171647.1403910-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s773dODt-BaGlUrBsUJc_gph7jvhBMIa
X-Proofpoint-GUID: s773dODt-BaGlUrBsUJc_gph7jvhBMIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170122

Remove the IDA indexing for OCC devices and instead use the FSI
minor number API. This will make the OCC numbering consistent
with other FSI engines and make the "reg" device tree property
unnecessary.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 48 ++++++++++---------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index f58b158d097c..11e090da0590 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -4,9 +4,9 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/fsi.h>
 #include <linux/fsi-sbefifo.h>
 #include <linux/gfp.h>
-#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -44,6 +44,7 @@ struct occ {
 	struct device *sbefifo;
 	char name[32];
 	int idx;
+	dev_t devt;
 	bool platform_hwmon;
 	u8 sequence_number;
 	void *buffer;
@@ -75,8 +76,6 @@ struct occ_client {
 
 #define to_client(x)	container_of((x), struct occ_client, xfr)
 
-static DEFINE_IDA(occ_ida);
-
 static int occ_open(struct inode *inode, struct file *file)
 {
 	struct occ_client *client = kzalloc(sizeof(*client), GFP_KERNEL);
@@ -622,7 +621,6 @@ static int occ_unregister_of_child(struct device *dev, void *data)
 static int occ_probe(struct platform_device *pdev)
 {
 	int rc;
-	u32 reg;
 	char child_name[32];
 	struct occ *occ;
 	struct platform_device *hwmon_dev = NULL;
@@ -637,6 +635,10 @@ static int occ_probe(struct platform_device *pdev)
 	if (!occ)
 		return -ENOMEM;
 
+	rc = fsi_get_new_minor(to_fsi_dev(dev->parent), fsi_dev_occ, &occ->devt, &occ->idx);
+	if (rc)
+		return rc;
+
 	/* SBE words are always four bytes */
 	occ->buffer = kvmalloc(OCC_MAX_RESP_WORDS * 4, GFP_KERNEL);
 	if (!occ->buffer)
@@ -651,23 +653,6 @@ static int occ_probe(struct platform_device *pdev)
 	 */
 	occ->sequence_number = (u8)((jiffies % 0xff) + 1);
 	mutex_init(&occ->occ_lock);
-
-	if (dev->of_node) {
-		rc = of_property_read_u32(dev->of_node, "reg", &reg);
-		if (!rc) {
-			/* make sure we don't have a duplicate from dts */
-			occ->idx = ida_alloc_range(&occ_ida, reg, reg,
-						   GFP_KERNEL);
-			if (occ->idx < 0)
-				occ->idx = ida_alloc_min(&occ_ida, 1,
-							 GFP_KERNEL);
-		} else {
-			occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
-		}
-	} else {
-		occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
-	}
-
 	platform_set_drvdata(pdev, occ);
 
 	snprintf(occ->name, sizeof(occ->name), "occ%d", occ->idx);
@@ -679,7 +664,7 @@ static int occ_probe(struct platform_device *pdev)
 	rc = misc_register(&occ->mdev);
 	if (rc) {
 		dev_err(dev, "failed to register miscdevice: %d\n", rc);
-		ida_free(&occ_ida, occ->idx);
+		fsi_free_minor(occ->devt);
 		kvfree(occ->buffer);
 		return rc;
 	}
@@ -718,7 +703,9 @@ static void occ_remove(struct platform_device *pdev)
 	else
 		device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
 
-	ida_free(&occ_ida, occ->idx);
+	fsi_free_minor(occ->devt);
+
+	return 0;
 }
 
 static const struct of_device_id occ_match[] = {
@@ -743,20 +730,7 @@ static struct platform_driver occ_driver = {
 	.remove_new = occ_remove,
 };
 
-static int occ_init(void)
-{
-	return platform_driver_register(&occ_driver);
-}
-
-static void occ_exit(void)
-{
-	platform_driver_unregister(&occ_driver);
-
-	ida_destroy(&occ_ida);
-}
-
-module_init(occ_init);
-module_exit(occ_exit);
+module_platform_driver(occ_driver);
 
 MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
 MODULE_DESCRIPTION("BMC P9 OCC driver");
-- 
2.43.0


