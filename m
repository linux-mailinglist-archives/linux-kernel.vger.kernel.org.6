Return-Path: <linux-kernel+bounces-369236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528ED9A1AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768621C20F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB14192D9E;
	Thu, 17 Oct 2024 06:32:16 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1960770FE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146736; cv=none; b=XXiaJoiYp49b4qyuefhC697/pJHumo37hOGY5UQV/tLLD0dEZeRnPhHuNdMbhfcKVGJfY2VSfM8Fj3JUZffBLRe+n/zK7HYztoidcESWjv3ArVPizRC+P8lVf6O03zrOReLQ7ojBb0Sq2q74ljqOEnV6dpI5bHKRVOMJyVSBRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146736; c=relaxed/simple;
	bh=UltIMtbRajHyqbkzlgyOpJEiBobJAoVqcdsYtEHomeA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac2IczzwnwodsPv9kkDe2vxPXyp6wJNoGEd/Zp4E88uXm3dERT674Hm2RGNpXQu05z6A5gz4yZ2b/lUKUlLomZUSVL8r0b16M6yGiDPvBbZfPJ6ErLuP+GStYVNgEpK510stAGPn6XrdH0lBU52sE1fqizXgE7e+IT7qvtuB1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XTdJF154vz1SCpc;
	Thu, 17 Oct 2024 14:30:53 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0136A1404D8;
	Thu, 17 Oct 2024 14:32:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 14:32:08 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<christian.koenig@amd.com>, <ray.huang@amd.com>,
	<dmitry.baryshkov@linaro.org>, <dave.stevenson@raspberrypi.com>,
	<quic_jjohnson@quicinc.com>, <mcanal@igalia.com>, <ruanjinjie@huawei.com>,
	<davidgow@google.com>, <skhan@linuxfoundation.org>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] drm/connector: hdmi: Fix memory leak in drm_display_mode_from_cea_vic()
Date: Thu, 17 Oct 2024 14:31:23 +0800
Message-ID: <20241017063125.3080347-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017063125.3080347-1-ruanjinjie@huawei.com>
References: <20241017063125.3080347-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

modprobe drm_connector_test and then rmmod drm_connector_test,
the following memory leak occurs.

The `mode` allocated in drm_mode_duplicate() called by
drm_display_mode_from_cea_vic() is not freed, which cause the memory leak:

	unreferenced object 0xffffff80cb0ee400 (size 128):
	  comm "kunit_try_catch", pid 1948, jiffies 4294950339
	  hex dump (first 32 bytes):
	    14 44 02 00 80 07 d8 07 04 08 98 08 00 00 38 04  .D............8.
	    3c 04 41 04 65 04 00 00 05 00 00 00 00 00 00 00  <.A.e...........
	  backtrace (crc 90e9585c):
	    [<00000000ec42e3d7>] kmemleak_alloc+0x34/0x40
	    [<00000000d0ef055a>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<00000000c2062161>] drm_mode_duplicate+0x44/0x19c
	    [<00000000f96c74aa>] drm_display_mode_from_cea_vic+0x88/0x98
	    [<00000000d8f2c8b4>] 0xffffffdc982a4868
	    [<000000005d164dbc>] kunit_try_run_case+0x13c/0x3ac
	    [<000000006fb23398>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<000000006ea56ca0>] kthread+0x2e8/0x374
	    [<000000000676063f>] ret_from_fork+0x10/0x20
	......

Free `mode` by using drm_kunit_display_mode_from_cea_vic()
to fix it.

Cc: stable@vger.kernel.org
Fixes: abb6f74973e2 ("drm/tests: Add HDMI TDMS character rate tests")
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Update the commit message.
- Add Acked-by.
v2:
- Fix it with new introduced helper instead of drm_mode_destroy().
- Update the commit message.
---
 drivers/gpu/drm/tests/drm_connector_test.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 15e36a8db685..6bba97d0be88 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -996,7 +996,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb(struct kunit *test)
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1017,7 +1017,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_10bpc(struct kunit *test)
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1038,7 +1038,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_10bpc_vic_1(struct kunit *t
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	rate = drm_hdmi_compute_mode_clock(mode, 10, HDMI_COLORSPACE_RGB);
@@ -1056,7 +1056,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_12bpc(struct kunit *test)
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1077,7 +1077,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_12bpc_vic_1(struct kunit *t
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	rate = drm_hdmi_compute_mode_clock(mode, 12, HDMI_COLORSPACE_RGB);
@@ -1095,7 +1095,7 @@ static void drm_test_drm_hdmi_compute_mode_clock_rgb_double(struct kunit *test)
 	unsigned long long rate;
 	struct drm_device *drm = &priv->drm;
 
-	mode = drm_display_mode_from_cea_vic(drm, 6);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 6);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_TRUE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1118,7 +1118,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv420_valid(struct kunit
 	unsigned long long rate;
 	unsigned int vic = *(unsigned int *)test->param_value;
 
-	mode = drm_display_mode_from_cea_vic(drm, vic);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, vic);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1155,7 +1155,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv420_10_bpc(struct kuni
 		drm_hdmi_compute_mode_clock_yuv420_vic_valid_tests[0];
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, vic);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, vic);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1180,7 +1180,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv420_12_bpc(struct kuni
 		drm_hdmi_compute_mode_clock_yuv420_vic_valid_tests[0];
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, vic);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, vic);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1203,7 +1203,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv422_8_bpc(struct kunit
 	struct drm_device *drm = &priv->drm;
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1225,7 +1225,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv422_10_bpc(struct kuni
 	struct drm_device *drm = &priv->drm;
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1247,7 +1247,7 @@ static void drm_test_connector_hdmi_compute_mode_clock_yuv422_12_bpc(struct kuni
 	struct drm_device *drm = &priv->drm;
 	unsigned long long rate;
 
-	mode = drm_display_mode_from_cea_vic(drm, 16);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_ASSERT_FALSE(test, mode->flags & DRM_MODE_FLAG_DBLCLK);
-- 
2.34.1


