Return-Path: <linux-kernel+bounces-388062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C489B5A02
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA251F24925
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F11991DA;
	Wed, 30 Oct 2024 02:35:50 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31215197531
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730255749; cv=none; b=KpL7Jhf13bgzJR7s4LhgNuZr3x7ZP7M1dK3fBd333s472y2OPBjnYNe9tvMtLm8SO1HV55ttIyJuALbBvMEC3pkcywoSx35p4LdhTqbu2CBmsqSMpcfBZytCoB2HXpwYT6zc/e5f6h+f23SNKzAo88zFxNbW5MmZIYtNLNIptuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730255749; c=relaxed/simple;
	bh=azXntv+UyVFnf1m8MaiGbtyNsBRlg6UhTczO4U4Ra4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnqCXvRHpzeecBzZZoJUen36/hxnsUTVHf3iIB8jnRTjqFNovoK4Cms+eY38CCAMRVkZYEEt/9YElq95wevfMkA8J8EeSZYIJmwXcts9pJIzG7OxnmAcX/MkRtuJbSlzJcZfCHpLCIeLJZSEmABl21P7ITTlkifMEfybgh/jumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XdWMc71fmz1HLp5;
	Wed, 30 Oct 2024 10:31:08 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 23EFD180043;
	Wed, 30 Oct 2024 10:35:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Oct
 2024 10:35:36 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<dmitry.baryshkov@linaro.org>, <dave.stevenson@raspberrypi.com>,
	<quic_jjohnson@quicinc.com>, <mcanal@igalia.com>,
	<skhan@linuxfoundation.org>, <davidgow@google.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 3/3] drm/tests: hdmi: Fix memory leaks in drm_display_mode_from_cea_vic()
Date: Wed, 30 Oct 2024 10:35:04 +0800
Message-ID: <20241030023504.530425-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030023504.530425-1-ruanjinjie@huawei.com>
References: <20241030023504.530425-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

modprobe drm_hdmi_state_helper_test and then rmmod it, the following
memory leak occurs.

The `mode` allocated in drm_mode_duplicate() called by
drm_display_mode_from_cea_vic() is not freed, which cause the memory leak:

	unreferenced object 0xffffff80ccd18100 (size 128):
	  comm "kunit_try_catch", pid 1851, jiffies 4295059695
	  hex dump (first 32 bytes):
	    57 62 00 00 80 02 90 02 f0 02 20 03 00 00 e0 01  Wb........ .....
	    ea 01 ec 01 0d 02 00 00 0a 00 00 00 00 00 00 00  ................
	  backtrace (crc c2f1aa95):
	    [<000000000f10b11b>] kmemleak_alloc+0x34/0x40
	    [<000000001cd4cf73>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<00000000f1f3cffa>] drm_mode_duplicate+0x44/0x19c
	    [<000000008cbeef13>] drm_display_mode_from_cea_vic+0x88/0x98
	    [<0000000019daaacf>] 0xffffffedc11ae69c
	    [<000000000aad0f85>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000a9210bac>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<000000000a0b2e9e>] kthread+0x2e8/0x374
	    [<00000000bd668858>] ret_from_fork+0x10/0x20
	......

Free `mode` by using drm_kunit_display_mode_from_cea_vic()
to fix it.

Cc: stable@vger.kernel.org
Fixes: 4af70f19e559 ("drm/tests: Add RGB Quantization tests")
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
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 34ee95d41f29..294773342e71 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -441,7 +441,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	drm = &priv->drm;
@@ -555,7 +555,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	drm = &priv->drm;
@@ -671,7 +671,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	drm = &priv->drm;
@@ -1263,7 +1263,7 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	mode = drm_display_mode_from_cea_vic(drm, 1);
+	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	/*
-- 
2.34.1


