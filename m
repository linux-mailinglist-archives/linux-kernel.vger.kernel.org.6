Return-Path: <linux-kernel+bounces-179199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329E8C5CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3699D1C216CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2AE181D17;
	Tue, 14 May 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r/SkoH0r"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438A181BA3
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722775; cv=none; b=n9iw6SE2DRj7+7F5No5yFgQa5kbCnRzo+e1gx7un42c7P8jGIrUNHnNIKfArDxtD854oJwitckyXL/aX2AKHmIfEOz1zaHFA7qe/eX889imSnM5AInhf7r81IlJnNLuST1w7TIm+cVj0xJ/BHU6JQLeDE4d5EjGN9Y+NGoiAV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722775; c=relaxed/simple;
	bh=zWLtlAGCK4IGSNUM/n/Z8G3A2WXEvTGsOyco0+kE7DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TaUdL8S+7HBk1UsTh2bG9TAJW6N/UHOgeizLyK9EDtfeIsf8m5Al4GGKuEWsslK29Xf2rMCPzxchmXeXS3ySzdGyigN2j2oEln9/2M7up15qXxuZOPyhj0N4umkIKilftd1vCCwV/74fQBthio+xGgnzoqfarJC5nbSgeWtTZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r/SkoH0r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKtEGm025737;
	Tue, 14 May 2024 21:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=x7pWOfCWK1R/iOvFYMyRCieamnXkuL2K1vcfY/HPR24=;
 b=r/SkoH0rAVg/puarz0D0GeTdQAodvWKNy0iIu2IkZYEykPY8I/2aSf/KFVRKh2x7XNI3
 yhKtY0dDNpuIm+zYg0b049OtMN5qY4CmZ/xvJ7OBHjLyb+cPbDKeP7Es7yaRlXzoPLUI
 LtXWYxpCA06g/dd4D4c/mMIGwgBuPZ/EAqErwEVQhDKsDo3GVpmc5Xu5CuxA9WGvtAGd
 +I39ID5+YoZTxjPjS3bxpWx55xNRANQ/JFZFD9+rpjJ7d565AH9DC0u30y7Lywkq/82D
 II7sdx7mv2yyViwbBALfVhVGPsHl1/OJoRKkVzrZqJRppkx09iOsO4NoNCqCyCHLZ2tc KA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4bg40pdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:39:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKFGCR006079;
	Tue, 14 May 2024 21:39:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2nq2qc1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:39:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44ELdLTg5833376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:39:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 696EF5806A;
	Tue, 14 May 2024 21:39:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B1835804B;
	Tue, 14 May 2024 21:39:21 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 21:39:20 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: eajames@linux.ibm.com, linux-kernel@vger.kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au
Subject: [PATCH v5 1/3] fsi: occ: Get device number from FSI minor number API
Date: Tue, 14 May 2024 16:39:18 -0500
Message-Id: <20240514213920.159357-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514213920.159357-1-eajames@linux.ibm.com>
References: <20240514213920.159357-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZFwtK_me6UeM6_e1-hSQc4pmodyW8HZP
X-Proofpoint-ORIG-GUID: ZFwtK_me6UeM6_e1-hSQc4pmodyW8HZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_13,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405140156

Remove the IDA indexing for OCC devices and instead use the FSI
minor number API. This will make the OCC numbering consistent
with other FSI engines and make the "reg" device tree property
unnecessary.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 47 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index da35ca9e84a6e..2023355b39805 100644
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
@@ -651,24 +653,6 @@ static int occ_probe(struct platform_device *pdev)
 	 */
 	occ->sequence_number = (u8)((jiffies % 0xff) + 1);
 	mutex_init(&occ->occ_lock);
-
-	if (dev->of_node) {
-		rc = of_property_read_u32(dev->of_node, "reg", &reg);
-		if (!rc) {
-			/* make sure we don't have a duplicate from dts */
-			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
-						  GFP_KERNEL);
-			if (occ->idx < 0)
-				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-							  GFP_KERNEL);
-		} else {
-			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-						  GFP_KERNEL);
-		}
-	} else {
-		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
-	}
-
 	platform_set_drvdata(pdev, occ);
 
 	snprintf(occ->name, sizeof(occ->name), "occ%d", occ->idx);
@@ -680,7 +664,7 @@ static int occ_probe(struct platform_device *pdev)
 	rc = misc_register(&occ->mdev);
 	if (rc) {
 		dev_err(dev, "failed to register miscdevice: %d\n", rc);
-		ida_simple_remove(&occ_ida, occ->idx);
+		fsi_free_minor(occ->devt);
 		kvfree(occ->buffer);
 		return rc;
 	}
@@ -719,7 +703,7 @@ static int occ_remove(struct platform_device *pdev)
 	else
 		device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
 
-	ida_simple_remove(&occ_ida, occ->idx);
+	fsi_free_minor(occ->devt);
 
 	return 0;
 }
@@ -746,20 +730,7 @@ static struct platform_driver occ_driver = {
 	.remove = occ_remove,
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
2.39.3


