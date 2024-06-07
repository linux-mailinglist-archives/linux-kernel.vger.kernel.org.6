Return-Path: <linux-kernel+bounces-205397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D798FFB01
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7411C24B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C31153801;
	Fri,  7 Jun 2024 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GYH3V81h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077D54F95;
	Fri,  7 Jun 2024 04:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735381; cv=none; b=AlO28D2bTK9elmeHEb2xyx1Mvdg5GFccTqVUTj2j3JuCDE+6pn5fjwFkayW98ArH22wb7+B/JsTkVg9cc5icPmZGI2YBwJuMNpgF20xtUV3D8Nr2Sf3oHJTBKBIdDIL7BX3EeMkW94RVfAoqQXHSr5bdsEoc6Chhat2FHPKlCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735381; c=relaxed/simple;
	bh=pNUxac7WBBa5GJmEUwsKRB77EpLo8JqAszXrhv55Uvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Rbb3bBoFsAeMiOBJNFQ2eS2yPDpKpihPKPcPBR+cSz05zSK4pb4H2F4WPbzA1lqdTdjk+Sb+leBJO7VIuvnmGOoZxOe6DCnOWHNNSch5ChEuQbBNmgoHVUBC3dc4oiJLqF9LeEkqFzVbe9rtxBV1RGF798OrMYwlAQx7MkJ8Wlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GYH3V81h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456Gvxql014221;
	Fri, 7 Jun 2024 04:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FuEr7AqmGZGaG9Bghx1n3s
	wVH7lblxY2zj36NTx1+qU=; b=GYH3V81hpx29VxBdtzSBbG4QIl63XrTGtCAY1i
	rFzMfhAZdXQtyoARcKV/yoGMn81oIfitvihaZxQVzk6DaZFYFCybaO+HwfmxwvOn
	Ni76I7EmVQkIJiH7M0ujC3k0LVPfBFB6ZoOaU2/YKvMgIxRgG4zvesRc1ibpeV06
	FVV7FBoyp5Br1YZZZlj2Lh/FJaB7mlb1/Y1uZ+YkVupHKAfvt4dJQLUdkdqofxIo
	maGBncnfNNSpmhRfGDEwS/VBKk3W8eXOjCDQ/UHagRD983Yfzhl1gzXJeivUmG1c
	x4RMKqZpZ+YXWw4RWfJFzN0bc6PFsWcHAP44WrHjYMwj16lQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjvxybu42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:42:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4574gnMO023740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 04:42:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 21:42:49 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 6 Jun 2024 21:42:46 -0700
Subject: [PATCH] drm/tests: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-md-drivers-gpu-drm-tests-v1-1-228ca6213969@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMWPYmYC/x3MQQqDMBCF4avIrDuQhhq0VyldJGbUgSaVmSiCe
 PfG7t63eP8BSsKk8GwOENpY+Zsr7rcGhtnniZBjNVhjH8YZhyliFN5IFKdlrTthIS2KfWxjcGN
 vu9BBvS9CI+//9OtdHbwSBvF5mK/gh/O6Y/JaSOA8f9T+rlyJAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V5nlhLuJgvERasvFMLdXiY47bRtdTvbq
X-Proofpoint-GUID: V5nlhLuJgvERasvFMLdXiY47bRtdTvbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070032

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_kunit_helpers.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_buddy_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_cmdline_parser_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_connector_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_damage_helper_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_dp_mst_helper_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_exec_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_format_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_framebuffer_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_gem_shmem_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_managed_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_mm_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_modes_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_plane_helper_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_probe_helper_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_rect_test.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Most, but not all, of these descriptions came from header comments at
the beginning of the .c files, but some of them I "invented". Let me
know if you want any modifications.
---
 drivers/gpu/drm/tests/drm_buddy_test.c          | 1 +
 drivers/gpu/drm/tests/drm_cmdline_parser_test.c | 1 +
 drivers/gpu/drm/tests/drm_connector_test.c      | 1 +
 drivers/gpu/drm/tests/drm_damage_helper_test.c  | 1 +
 drivers/gpu/drm/tests/drm_dp_mst_helper_test.c  | 1 +
 drivers/gpu/drm/tests/drm_exec_test.c           | 1 +
 drivers/gpu/drm/tests/drm_format_test.c         | 1 +
 drivers/gpu/drm/tests/drm_framebuffer_test.c    | 1 +
 drivers/gpu/drm/tests/drm_gem_shmem_test.c      | 1 +
 drivers/gpu/drm/tests/drm_kunit_helpers.c       | 1 +
 drivers/gpu/drm/tests/drm_managed_test.c        | 1 +
 drivers/gpu/drm/tests/drm_mm_test.c             | 1 +
 drivers/gpu/drm/tests/drm_modes_test.c          | 1 +
 drivers/gpu/drm/tests/drm_plane_helper_test.c   | 1 +
 drivers/gpu/drm/tests/drm_probe_helper_test.c   | 1 +
 drivers/gpu/drm/tests/drm_rect_test.c           | 1 +
 16 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index dd8fb9f8341a..9662c949d0e3 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -774,4 +774,5 @@ static struct kunit_suite drm_buddy_test_suite = {
 kunit_test_suite(drm_buddy_test_suite);
 
 MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Kunit test for drm_buddy functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_cmdline_parser_test.c b/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
index 88f7f518ffb3..6f1457bd21d9 100644
--- a/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
+++ b/drivers/gpu/drm/tests/drm_cmdline_parser_test.c
@@ -1056,4 +1056,5 @@ static struct kunit_suite drm_cmdline_parser_test_suite = {
 kunit_test_suite(drm_cmdline_parser_test_suite);
 
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@bootlin.com>");
+MODULE_DESCRIPTION("Kunit test for drm_cmdline_parser functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 44f82ed2a958..0bd158987360 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -241,4 +241,5 @@ kunit_test_suites(
 );
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
+MODULE_DESCRIPTION("Kunit test for drm_modes functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index 115034fc3421..0df2e1a54b0d 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -636,4 +636,5 @@ static struct kunit_suite drm_damage_helper_test_suite = {
 
 kunit_test_suite(drm_damage_helper_test_suite);
 
+MODULE_DESCRIPTION("Test case for drm_damage_helper functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
index d916e548fcb1..89cd9e4f4d32 100644
--- a/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
@@ -588,4 +588,5 @@ static struct kunit_suite drm_dp_mst_helper_test_suite = {
 
 kunit_test_suite(drm_dp_mst_helper_test_suite);
 
+MODULE_DESCRIPTION("Test cases for the DRM DP MST helpers");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/tests/drm_exec_test.c
index 81f928a429ba..d6c4dd1194a0 100644
--- a/drivers/gpu/drm/tests/drm_exec_test.c
+++ b/drivers/gpu/drm/tests/drm_exec_test.c
@@ -210,4 +210,5 @@ static struct kunit_suite drm_exec_test_suite = {
 kunit_test_suite(drm_exec_test_suite);
 
 MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("Kunit test for drm_exec functions");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/tests/drm_format_test.c b/drivers/gpu/drm/tests/drm_format_test.c
index ec6996ce819a..22e2371fd66a 100644
--- a/drivers/gpu/drm/tests/drm_format_test.c
+++ b/drivers/gpu/drm/tests/drm_format_test.c
@@ -356,4 +356,5 @@ static struct kunit_suite drm_format_test_suite = {
 
 kunit_test_suite(drm_format_test_suite);
 
+MODULE_DESCRIPTION("Test cases for the drm_format functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_framebuffer_test.c b/drivers/gpu/drm/tests/drm_framebuffer_test.c
index f759d9f3b76e..06f03b78c9c4 100644
--- a/drivers/gpu/drm/tests/drm_framebuffer_test.c
+++ b/drivers/gpu/drm/tests/drm_framebuffer_test.c
@@ -379,4 +379,5 @@ static struct kunit_suite drm_framebuffer_test_suite = {
 
 kunit_test_suite(drm_framebuffer_test_suite);
 
+MODULE_DESCRIPTION("Test cases for the drm_framebuffer functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 91202e40cde9..c3758faa1b83 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -380,4 +380,5 @@ static struct kunit_suite drm_gem_shmem_suite = {
 
 kunit_test_suite(drm_gem_shmem_suite);
 
+MODULE_DESCRIPTION("KUnit test suite for GEM objects backed by shmem buffers");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index d5317d13d3fc..aa62719dab0e 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -312,4 +312,5 @@ drm_kunit_helper_create_crtc(struct kunit *test,
 EXPORT_SYMBOL_GPL(drm_kunit_helper_create_crtc);
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
+MODULE_DESCRIPTION("KUnit test suite helper functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_managed_test.c b/drivers/gpu/drm/tests/drm_managed_test.c
index 76eb273c9b36..d40c7ef7f9e1 100644
--- a/drivers/gpu/drm/tests/drm_managed_test.c
+++ b/drivers/gpu/drm/tests/drm_managed_test.c
@@ -113,4 +113,5 @@ static struct kunit_suite drm_managed_test_suite = {
 kunit_test_suite(drm_managed_test_suite);
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
+MODULE_DESCRIPTION("KUnit DRM managed test suite");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index 8497d9990b96..6174d0929020 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -356,4 +356,5 @@ static struct kunit_suite drm_mm_test_suite = {
 kunit_test_suite(drm_mm_test_suite);
 
 MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Test cases for the drm_mm range manager");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_modes_test.c b/drivers/gpu/drm/tests/drm_modes_test.c
index 1e9f63fbfead..7029f7a2eb4d 100644
--- a/drivers/gpu/drm/tests/drm_modes_test.c
+++ b/drivers/gpu/drm/tests/drm_modes_test.c
@@ -147,4 +147,5 @@ static struct kunit_suite drm_modes_analog_tv_test_suite = {
 kunit_test_suite(drm_modes_analog_tv_test_suite);
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
+MODULE_DESCRIPTION("Kunit test for drm_modes functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_plane_helper_test.c b/drivers/gpu/drm/tests/drm_plane_helper_test.c
index 0f392146b233..7e975a3f4a71 100644
--- a/drivers/gpu/drm/tests/drm_plane_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_plane_helper_test.c
@@ -315,4 +315,5 @@ static struct kunit_suite drm_plane_helper_test_suite = {
 
 kunit_test_suite(drm_plane_helper_test_suite);
 
+MODULE_DESCRIPTION("Test cases for the drm_plane_helper functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/drm/tests/drm_probe_helper_test.c
index 1a2044070a6c..bc09ff38aca1 100644
--- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
@@ -207,4 +207,5 @@ static struct kunit_suite drm_test_connector_helper_tv_get_modes_suite = {
 kunit_test_suite(drm_test_connector_helper_tv_get_modes_suite);
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
+MODULE_DESCRIPTION("Kunit test for drm_probe_helper functions");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 76332cd2ead8..17e1f34b7610 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -526,4 +526,5 @@ static struct kunit_suite drm_rect_test_suite = {
 
 kunit_test_suite(drm_rect_test_suite);
 
+MODULE_DESCRIPTION("Test cases for the drm_rect functions");
 MODULE_LICENSE("GPL");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240606-md-drivers-gpu-drm-tests-9d5db6f928b8


