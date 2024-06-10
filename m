Return-Path: <linux-kernel+bounces-207578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE790190D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 02:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A557BB21DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE71879;
	Mon, 10 Jun 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oYZSO66C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6C15A8;
	Mon, 10 Jun 2024 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717980025; cv=none; b=N2zkFj5VBL4z1jymDx8RNAYVxp37Mie4+NYKzeEpDoRnad/JHO+HdotFZS7YNaEaSsKh/dqiDdPrrMGliYI1R6XgJ0VG9qOptBj6YIZ/H9lO9XPHXWYrUDuTKhEJ1srBm0bAB30h+BZMRHMMm5rNgNcrUGifdhpuysQzy6LrDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717980025; c=relaxed/simple;
	bh=9LJE33I5juA5koYN0L+tufMCyKJP9NsUR9IoSfddvUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OHAN0XpUm+fgGZr90f437oPzih0SxrueWUVN7xZTfTPtEAkekmLAX9DQLFspvsOGbJ9wFTSD/CnKTDZmikIj7uHqbCZ9XOTcvl+q9r0XaysIHvGWpSjZy7rY/GAY1b8UPayU7DVe0Ohfp+pD55h1uewQXm0TXjzrndHAglX4Zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oYZSO66C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459Mb2Gq009439;
	Mon, 10 Jun 2024 00:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=maKTFxxbQAZZJo15rJe6h9
	yOwq9aW+cO8mUo+GdSkEo=; b=oYZSO66C8vpt/7joAmySjgyzDbL7SVWEbIMCxl
	SgYkXLd/oqJ5pMZyhB57GGx379rRTkl4LucfhTfI7Oeuim9wqfg7mZ3JvIzt3Cj2
	O5f+U3rbjcujv2Q5NGF6cp7z8oIkNv6c6YLHr++fYy4H7KHb7sJgnaUV1bolNbWx
	3bmCfWSnlhNbXzHn1QaxhA38Uz55FM3J+N5NkzpePvxBfrvMbPpdrS34jS4QFyND
	jaZ3zX6a4Y34lwXhn5a5gsAFutpahN+b5gC4TJM7UGaf/KDChzT09mLnNirnw6yT
	V1+w07LWgfzj4y/5dy5iJWZFHQ1FFYusLD4hFNQzP0ZyYleA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymemgjbtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 00:40:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A0eHnV002168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 00:40:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Jun 2024
 17:40:17 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 9 Jun 2024 17:40:17 -0700
Subject: [PATCH] spmi: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHBLZmYC/x3MwQqDMAyA4VeRnBdo6ya4Vxk7pDbTgO0kcSKI7
 75ux+/w/wcYq7DBvTlAeROTd6nwlwaGicrIKKkaggtX17kec8KksrEa2pIFb558G4lC6zzUalF
 +yf4/Pp7VkYwxKpVh+n1mKZ8dM9nKCuf5BfF8N0aAAAAA
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd
	<sboyd@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j775rbG1PHprvhqWiHGkOVT3D4F-aCmn
X-Proofpoint-ORIG-GUID: j775rbG1PHprvhqWiHGkOVT3D4F-aCmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_18,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406100002

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/spmi-pmic-arb.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/spmi/hisi-spmi-controller.c | 1 +
 drivers/spmi/spmi-pmic-arb.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index fa068b34b040..3cafdf22c909 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -344,6 +344,7 @@ static void __exit spmi_controller_exit(void)
 }
 module_exit(spmi_controller_exit);
 
+MODULE_DESCRIPTION("Hisilicon 3670 SPMI Controller driver");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION("1.0");
 MODULE_ALIAS("platform:spmi_controller");
diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 791cdc160c51..f240fcc5a4e1 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1891,5 +1891,6 @@ static struct platform_driver spmi_pmic_arb_driver = {
 };
 module_platform_driver(spmi_pmic_arb_driver);
 
+MODULE_DESCRIPTION("Qualcomm MSM SPMI Controller (PMIC Arbiter) driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:spmi_pmic_arb");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240609-md-drivers-spmi-51a13baa2301


