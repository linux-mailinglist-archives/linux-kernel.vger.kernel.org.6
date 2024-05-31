Return-Path: <linux-kernel+bounces-196301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1738D59F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD52AB2422B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77FB7CF18;
	Fri, 31 May 2024 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="efucmoGh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB525466C;
	Fri, 31 May 2024 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717134141; cv=none; b=qMBd7BvpCRDVSToI/qxteaoJO+7ZD0mM0jfsYzGg6uiZ6SBZSrXY2rlzTmHoQhT13PXs4Tsgu7q4uEDMLwsaaT2B0ehsj1K/pVbKLek7mUnS3UK3z+79PXQsvx38OWE4o5Psko4sziPVTVFHvuic8DoJyfzQP87mmIf4DYB0ki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717134141; c=relaxed/simple;
	bh=ML2MhW+L7lVLfePJYBEvvzgZ4Cl3ix1cvI3QJXjWTBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=X4YFSMyCnuOFC9kkbuaapvA34GGrdNWPGynk0bbVX5TT6JActAURnpKuQguJyJWqITaR03adfwq3ieBZnBSpTWtg7eJ7iM0ewUtp0Ak50uVrNhCngY26LbmmgMfw7yoGCgvhCEGKiylFZ1bTP3hxF1V4VGn/+2XP0ELu6z/1JB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=efucmoGh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UHSloI016293;
	Fri, 31 May 2024 05:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MN5gk3vdALuv6YjELNspNu
	NzCjR59jP1yU/ovxO+/zw=; b=efucmoGhsjqQRNR1s5jGCLcTFRpuCF8bbFIGuX
	qL64j/vGBZUoMilNMhAjAr4XhWI1DUou3LY+7TLgRnmdrg3jG7tWxvMUiis5Aod3
	W8nJD6Xu5EcXgTbcLeVlTtFqZlw3RHe5T5FbFFcYPkphIqT6G1g06W3nmkv6J/lb
	bcA46R/2RSQl9veJI00IX56rUARK/HEwl7d19XWu970/n/3+bVs2tnkYhMItloDC
	cLH8ASExuEe0UmrQmQXsI3cWXou3NsKLjNlCQumpvqGpnw+db3zY5o/f9shTyuVB
	A4pjqVGYnO9znaEb9gt6T8BGekH7vETlvT/NrK+Cq8M01dfQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2n5wgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:42:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V5g9tw008840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:42:09 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 22:42:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 22:42:09 -0700
Subject: [PATCH] regmap: kunit: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-regmap-kunit-v1-1-976c0f616751@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADBjWWYC/x3MQQ6CQAxA0auQrm0yjGKCVzEuClOh0amkBUJCu
 Lujy7f4fwdnE3a4VTsYr+Ly0YL6VEE/kg6MkoohhngJzTlgTmg8ZJrwtajMSFyna4ipbbmBUk3
 GT9n+x/ujuCNn7Iy0H3+ft+iyYSaf2eA4vnt1aPCAAAAA
To: Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1T-fbM7o4U258Bc5rLc3c47WjPbz4qSd
X-Proofpoint-ORIG-GUID: 1T-fbM7o4U258Bc5rLc3c47WjPbz4qSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310042

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-kunit.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/base/regmap/regmap-kunit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index be32cd4e84da..e9b102ef57e2 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1958,4 +1958,5 @@ static struct kunit_suite regmap_test_suite = {
 };
 kunit_test_suite(regmap_test_suite);
 
+MODULE_DESCRIPTION("Regmap KUnit tests");
 MODULE_LICENSE("GPL v2");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-regmap-kunit-ae1d602d99e5


