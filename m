Return-Path: <linux-kernel+bounces-228159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022AB915BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD47C2832D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EAB175BF;
	Tue, 25 Jun 2024 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UxTtfnd/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B817991;
	Tue, 25 Jun 2024 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278666; cv=none; b=J1miNblHC52i3S7vizjcLIHczBPsgpMpZZf01CiFodXE0d670Ricvh+gsRwn6O56nWRwHnPJ6WbDCLpc8/AW11tor8YgPN3Dfm/jOmOTNbUrJfuocjgrSFXKRLlDMpO+E9hWWMxBC1/GoW37xqNyQXITrLK8S0/0InvHhpPlVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278666; c=relaxed/simple;
	bh=bHBPzBRtvAVUbkldjhKAsKghjk4hqz6alx7ENX6jpho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nBXY/KaIhpEJvOcbg2Ay5kF9MRJSEe0EJFUaaicvKHcyG/XbZQkFMyN4DAN7gnsvjPuQ1+LjTESHFM8YGYB+K38ptRCgFNm5xBohpgscOE87QzwlxY98WyNyb+aHH2PeBQVj+RLnR+WzMZtPes4KGkFhmHKREsvZ9LGDprHkNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UxTtfnd/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OKPawb020252;
	Tue, 25 Jun 2024 01:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TGgQiO3DHhSPQrnbxpOMnq
	EvqzOYsn3YIaLa20v34S4=; b=UxTtfnd/D7aMmQE79aL9pHv5eXam6+9+zexeOw
	XEe6DxpHF6d3CXSY5wN9qvjODSaAfBG8sTTQv4jPx9IyRNcy4NZhv6wMuty6vkFD
	PpON+ufYBIH5uVlJeBnGJ+goL4GyTKc6iO/8CiDTgRpubFMyDX8oKzlSfL3aGPwt
	jHfimUMp6J4vQl2ul59UQibUwOlKcgW8DjRZ49vG//Jf6pFtCJqIhaB39/M5Z7RN
	udQf2kCumaM0jCp0wG6AS8zvVtzqAzRqkXbak7+HK1UEgF0D6hAHj2ZyhvScWATV
	PuIp2VRrOTcdFsq1z1A93lVn8MUYa0HWsVTljfmwXKpf+ERg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6yn17v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 01:24:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P1O9Tv020112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 01:24:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 18:24:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 24 Jun 2024 18:24:07 -0700
Subject: [PATCH v2] drm/ttm/tests: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240624-md-drivers-gpu-drm-ttm-tests-v2-1-76bb765e19c9@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADYcemYC/42OQQ6CMBBFr0K6dgwUxODKexgWtB1gEluwUxoM4
 e4WTuBikv8W//3ZBKMnZPHINuExEtPkEshLJvTYuQGBTGIhc1nldd6ANWA8RfQMw7ykbCGEdMi
 Bob+ruuyrGlWpRVLMHntaT/2rTaw6RlC+c3o8pG9yywoO1wC244D+6IzEYfLf86NYHM0/x2MBB
 ZimKmRpmpuq9POzkCanr3qyot33/QeDClwc7gAAAA==
To: Christian Koenig <christian.koenig@amd.com>,
        Huang Rui
	<ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q5M6Zy3UVhSSizd71Wwtrs0Vof4sAJWx
X-Proofpoint-ORIG-GUID: Q5M6Zy3UVhSSizd71Wwtrs0Vof4sAJWx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_22,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250009

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/ttm/tests/ttm_device_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/ttm/tests/ttm_pool_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/ttm/tests/ttm_resource_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/ttm/tests/ttm_tt_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/ttm/tests/ttm_bo_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/ttm/tests/ttm_mock_manager.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Rebased on top of linux-next/master to resolve conflict with commit
  "drm/ttm/tests: Correct modules' licenses" as well as add descriptions
  for two new modules recently added.
- Link to v1: https://lore.kernel.org/r/20240609-md-drivers-gpu-drm-ttm-tests-v1-1-d94123d95b4c@quicinc.com
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c          | 1 +
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c | 1 +
 drivers/gpu/drm/ttm/tests/ttm_device_test.c      | 1 +
 drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c    | 1 +
 drivers/gpu/drm/ttm/tests/ttm_mock_manager.c     | 1 +
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c        | 1 +
 drivers/gpu/drm/ttm/tests/ttm_resource_test.c    | 1 +
 drivers/gpu/drm/ttm/tests/ttm_tt_test.c          | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index 407c31b21872..d1b32303d051 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -633,4 +633,5 @@ static struct kunit_suite ttm_bo_test_suite = {
 
 kunit_test_suites(&ttm_bo_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for ttm_bo APIs");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
index bc8281c03420..1adf18481ea0 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -1221,4 +1221,5 @@ static struct kunit_suite ttm_bo_validate_test_suite = {
 
 kunit_test_suites(&ttm_bo_validate_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for ttm_bo APIs");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/ttm/tests/ttm_device_test.c b/drivers/gpu/drm/ttm/tests/ttm_device_test.c
index 0f235a834ede..1621903818e5 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_device_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_device_test.c
@@ -209,4 +209,5 @@ static struct kunit_suite ttm_device_test_suite = {
 
 kunit_test_suites(&ttm_device_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for ttm_device APIs");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
index 70f40814b26a..b91c13f46225 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
@@ -301,4 +301,5 @@ void ttm_test_devices_fini(struct kunit *test)
 }
 EXPORT_SYMBOL_GPL(ttm_test_devices_fini);
 
+MODULE_DESCRIPTION("TTM KUnit test helper functions");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/ttm/tests/ttm_mock_manager.c b/drivers/gpu/drm/ttm/tests/ttm_mock_manager.c
index 7f34fecd3fef..f6d1c8a2845d 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_mock_manager.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_mock_manager.c
@@ -230,4 +230,5 @@ void ttm_bad_manager_fini(struct ttm_device *bdev, uint32_t mem_type)
 }
 EXPORT_SYMBOL_GPL(ttm_bad_manager_fini);
 
+MODULE_DESCRIPTION("KUnit tests for ttm with mock resource managers");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
index 5d4dc5b1c6d7..8ade53371f72 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
@@ -433,4 +433,5 @@ static struct kunit_suite ttm_pool_test_suite = {
 
 kunit_test_suites(&ttm_pool_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for ttm_pool APIs");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/ttm/tests/ttm_resource_test.c b/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
index 77be0942ab62..9c2f13e53162 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_resource_test.c
@@ -332,4 +332,5 @@ static struct kunit_suite ttm_resource_test_suite = {
 
 kunit_test_suites(&ttm_resource_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for ttm_resource and ttm_sys_man APIs");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
index a8c76dbd6913..61ec6f580b62 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
@@ -398,4 +398,5 @@ static struct kunit_suite ttm_tt_test_suite = {
 
 kunit_test_suites(&ttm_tt_test_suite);
 
+MODULE_DESCRIPTION("KUnit tests for ttm_tt APIs");
 MODULE_LICENSE("GPL and additional rights");

---
base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
change-id: 20240609-md-drivers-gpu-drm-ttm-tests-f7b63f46eb3c


