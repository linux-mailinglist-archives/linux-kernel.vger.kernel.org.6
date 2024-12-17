Return-Path: <linux-kernel+bounces-448371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD779F3F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C717A18847F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2541537A8;
	Tue, 17 Dec 2024 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dKwmBmRW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0E13DBB1;
	Tue, 17 Dec 2024 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396224; cv=none; b=rbfsnrNP21bFLiga12zxpRw2XCaT+Cu1LIBfDIkP7wc3VnoV/NP/AXQCyfaQ87XguLPj29g+brg4IOxIt5synWtasDy2S9F49RrrGlK1L+Qdmvuupx3b4/02j1b6ejZNdrirpMqZiFeUEYEApI59guMommHgrp2ZRe1wOe857Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396224; c=relaxed/simple;
	bh=H9Hz3OL2stn6blXsSKb6fwop+x0lLIgsxCuNFiSuYgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kHa77xAKAdSAAvNFMFQiPbzpX9RV7pEraRUI5cgg3qjGBUdkQXbxTBc0pZHWCwp5q/siBjEi2xc2NX+D/VT2F6wNB/Tzfo+QvSPP+vfQZHLUpptbulbVkC31lizLLTTW4L4LJd+RXkwA5ndG6GLHuDtglk/hqWYbUzmE3E/X8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dKwmBmRW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMriRb007420;
	Tue, 17 Dec 2024 00:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yIh/Fq9AIwoar0TggucAwZhvKQhyWmJL0PUKVL/B4PA=; b=dKwmBmRWaSTpnu8V
	fu3R3D0C/b4E5uDphr5d2EgZPE3YntBas9wKNtjS1j+/6OKu6dbVNBjJ7kLmsQOb
	LadVizPq1C5n1zLTbfQHPVl2E4P2JKpDlJ72dkgbw5r2JjvqGdTUPeKbm4K8vhb1
	6G7JwpF0fC7NxxyIml4kK+IOTPQYydbE80Wupb9Cx2oaMzaZJp7PoXqwl4cHRCMq
	draliEtCQcLJ12SX5z1uKuIrzsugISvVvH9OPycpd4Eu4iuT+u9w+oVPQxDFkSsy
	F+A+g6gKv+OZ9hfM1pQmzF4Qm+9qU7BIT/xol252pIZRZlq5EEsXiFwKjk9B8cgi
	rT9bhw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jwda062c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 00:43:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH0hQRh018354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 00:43:26 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 16:43:25 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Mon, 16 Dec 2024 16:43:13 -0800
Subject: [PATCH v4 02/25] drm/tests: Add test for drm_crtc_in_clone_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241216-concurrent-wb-v4-2-fe220297a7f0@quicinc.com>
References: <20241216-concurrent-wb-v4-0-fe220297a7f0@quicinc.com>
In-Reply-To: <20241216-concurrent-wb-v4-0-fe220297a7f0@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <quic_abhinavk@quicinc.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simona Vetter <simona@ffwll.ch>,
        Simona Vetter <simona.vetter@ffwll.ch>
CC: <quic_ebharadw@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        "Jessica
 Zhang" <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734396205; l=3128;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=H9Hz3OL2stn6blXsSKb6fwop+x0lLIgsxCuNFiSuYgk=;
 b=/GHC24oZe4q58nuhuwdaVIlJYBU6a3eZf8y5vQn0CUeW1rprymXMVzq0Ch1JHYtuNNBtJR1Hv
 0oJgzzjI0GYC6si6tZIQs/vjVkEyuGbQckOcqvCOzYwkDCoyMQJuzL7
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _xOJOu_pX48vkAsE5TAGQK0ByEVCMTK1
X-Proofpoint-ORIG-GUID: _xOJOu_pX48vkAsE5TAGQK0ByEVCMTK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170004

Add kunit test to validate drm_crtc_in_clone_mode() helper

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/tests/drm_atomic_state_test.c | 62 ++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_state_test.c b/drivers/gpu/drm/tests/drm_atomic_state_test.c
index be1f780249450ead7fbfd19ea98c96b442a94478..79bc5a9aedbf77aaf4b369a5fe62b6344e6859cf 100644
--- a/drivers/gpu/drm/tests/drm_atomic_state_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_state_test.c
@@ -17,6 +17,12 @@
 
 #define DRM_TEST_CONN_0 BIT(0)
 
+struct drm_clone_mode_test {
+	const char *name;
+	u32 encoder_mask;
+	int expected_result;
+};
+
 static const struct drm_display_mode drm_atomic_test_mode = {
 	DRM_MODE("1024x768", 0, 65000, 1024, 1048,
 		 1184, 1344, 0, 768, 771, 777, 806, 0,
@@ -227,17 +233,71 @@ static void drm_test_check_connector_changed_modeset(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, modeset_counter, initial_modeset_count + 1);
 }
 
+/*
+ * Test that the drm_crtc_in_clone_mode() helper can detect if a given CRTC
+ * state is in clone mode
+ */
+static void drm_test_check_in_clone_mode(struct kunit *test)
+{
+	bool ret;
+	const struct drm_clone_mode_test *param = test->param_value;
+	struct drm_crtc_state *crtc_state;
+
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	crtc_state->encoder_mask = param->encoder_mask;
+
+	ret = drm_crtc_in_clone_mode(crtc_state);
+
+	KUNIT_ASSERT_EQ(test, ret, param->expected_result);
+}
+
+static void drm_check_in_clone_mode_desc(const struct drm_clone_mode_test *t,
+				      char *desc)
+{
+	sprintf(desc, "%s", t->name);
+}
+
+static const struct drm_clone_mode_test drm_clone_mode_tests[] = {
+	{
+		.name = "in_clone_mode",
+		.encoder_mask = DRM_TEST_ENC_0 | DRM_TEST_ENC_1,
+		.expected_result = true,
+	},
+	{
+		.name = "not_in_clone_mode",
+		.encoder_mask = DRM_TEST_ENC_0,
+		.expected_result = false,
+	},
+};
+
+KUNIT_ARRAY_PARAM(drm_check_in_clone_mode, drm_clone_mode_tests,
+		  drm_check_in_clone_mode_desc);
+
 static struct kunit_case drm_test_check_modeset_test[] = {
 	KUNIT_CASE(drm_test_check_connector_changed_modeset),
 	{}
 };
 
+static struct kunit_case drm_in_clone_mode_check_test[] = {
+	KUNIT_CASE_PARAM(drm_test_check_in_clone_mode,
+			 drm_check_in_clone_mode_gen_params),
+	{}
+};
+
 static struct kunit_suite drm_test_check_modeset_test_suite = {
 	.name = "drm_validate_modeset",
 	.test_cases = drm_test_check_modeset_test,
 };
 
-kunit_test_suite(drm_test_check_modeset_test_suite);
+static struct kunit_suite drm_in_clone_mode_check_test_suite = {
+	.name = "drm_validate_clone_mode",
+	.test_cases = drm_in_clone_mode_check_test,
+};
+
+kunit_test_suites(&drm_in_clone_mode_check_test_suite,
+		  &drm_test_check_modeset_test_suite);
 
 MODULE_AUTHOR("Jessica Zhang <quic_jesszhan@quicinc.com");
 MODULE_DESCRIPTION("Test cases for the drm_atomic_helper functions");

-- 
2.34.1


