Return-Path: <linux-kernel+bounces-363345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1099C112
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416AC1F23512
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB4614A4C7;
	Mon, 14 Oct 2024 07:17:32 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2114037F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890252; cv=none; b=UBmck1k6rZWdpMgmMbQRm8X8Oa7SOM1Nko1NnzBYa3IGJOQaxznkCArnWUahUByIzbQ8c1Rj0LoXBpmSk/Qf7Asta9lYvCj7nXIFd1CbM4suHckkUeRiG4ymlKlh7ua/KcG6eMrYbT6UABocpaZDiqFsONAlHiwp6YiovHYGtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890252; c=relaxed/simple;
	bh=7+kRsHJnedBhWXaLBoo06UFTAcAmo0cCbMaUGhIRK7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlD3WBTJzydguQvwl9BGgavRFSmVFofKuJTWwzFhLFO9Uj43x9fbfztlgm7OS1bYEc4JC9F7Q2hI3Xf7h37U2QN0GSomG+AkHR6OqSCw5/fUhQAQPe/+lR+RDcN8UjxY/XJLl/xqyGpgdMhL4mCTZnyfEYW6L/lNn1ecL1YGWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XRpS005R8z1j9rw;
	Mon, 14 Oct 2024 15:16:16 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 48ADD1A016C;
	Mon, 14 Oct 2024 15:17:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 15:17:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<christian.koenig@amd.com>, <ray.huang@amd.com>,
	<dmitry.baryshkov@linaro.org>, <dave.stevenson@raspberrypi.com>,
	<mcanal@igalia.com>, <quic_jjohnson@quicinc.com>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 3/3] drm/tests: hdmi: Fix memory leaks in drm_display_mode_from_cea_vic()
Date: Mon, 14 Oct 2024 15:16:32 +0800
Message-ID: <20241014071632.989108-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014071632.989108-1-ruanjinjie@huawei.com>
References: <20241014071632.989108-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

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

Free `mode` by calling drm_mode_destroy() to fix it.

Cc: stable@vger.kernel.org
Fixes: 4af70f19e559 ("drm/tests: Add RGB Quantization tests")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 34ee95d41f29..70b91e8c8219 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -466,6 +466,8 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
 	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_limited_range);
+
+	drm_mode_destroy(drm, mode);
 }
 
 /*
@@ -582,6 +584,8 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 			DRM_HDMI_BROADCAST_RGB_FULL);
 
 	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_limited_range);
+
+	drm_mode_destroy(drm, mode);
 }
 
 /*
@@ -698,6 +702,8 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 			DRM_HDMI_BROADCAST_RGB_LIMITED);
 
 	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.is_limited_range);
+
+	drm_mode_destroy(drm, mode);
 }
 
 /*
@@ -1286,6 +1292,8 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 8);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+
+	drm_mode_destroy(drm, mode);
 }
 
 /*
-- 
2.34.1


