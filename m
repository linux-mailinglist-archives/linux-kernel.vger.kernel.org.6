Return-Path: <linux-kernel+bounces-369238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3B9A1AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB95A1F2392E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3C1B2189;
	Thu, 17 Oct 2024 06:32:24 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836E199225
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146743; cv=none; b=FMYz4DH6qnYz/52MroOe66w01qDjoqGab1I8R8LRaaVf4ZGc88k3OjCtoFkpmsRpnjxzOhFjGXB0gsPgg9Z3O3GQ6aIpRL1fCcgPf3UPOqXWSAglDs3TGdsvJi5LSOGmTaRVzg5BliY/ELt2wSLR1mnRAJlIbbcFUmcB9OL/Cpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146743; c=relaxed/simple;
	bh=d1k/Uibkv+Qb/y+aFd16WXpfhb1FGOdE+3/mACZ2x2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZO7egKptENCfERWe7sQDfdQ5ocEkzK/9yKLK8T3BZpV3Z9qwsdHmunZ4fPEQ6FX9xi1APFuXwGrbcULNAj3FtK743FvH36CWClrQDPb/DOzL/iiWQYlqAkX4/GsjterXIBW1/G97WCP7WPr3sDUXdY2+KpyViloT1b/JtdW+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XTdDp05hvz1HL0F;
	Thu, 17 Oct 2024 14:27:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C1A81A016C;
	Thu, 17 Oct 2024 14:32:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 14:32:07 +0800
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
Subject: [PATCH v3 1/4] drm/tests: helpers: Add helper for drm_display_mode_from_cea_vic()
Date: Thu, 17 Oct 2024 14:31:22 +0800
Message-ID: <20241017063125.3080347-2-ruanjinjie@huawei.com>
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

As Maxime suggested, add a new helper
drm_kunit_display_mode_from_cea_vic(), it can replace the direct call
of drm_display_mode_from_cea_vic(), and it will help solving
the `mode` memory leaks.

Acked-by: Maxime Ripard <mripard@kernel.org>
Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
- Drop the "helper" in the helper name.
- Add Acked-by.
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 40 +++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           |  4 +++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index aa62719dab0e..565172990044 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -3,6 +3,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
@@ -311,6 +312,45 @@ drm_kunit_helper_create_crtc(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_create_crtc);
 
+static void kunit_action_drm_mode_destroy(void *ptr)
+{
+	struct drm_display_mode *mode = ptr;
+
+	drm_mode_destroy(NULL, mode);
+}
+
+/**
+ * drm_kunit_display_mode_from_cea_vic() - return a mode for CEA VIC
+					   for a KUnit test
+ * @test: The test context object
+ * @dev: DRM device
+ * @video_code: CEA VIC of the mode
+ *
+ * Creates a new mode matching the specified CEA VIC for a KUnit test.
+ *
+ * Resources will be cleaned up automatically.
+ *
+ * Returns: A new drm_display_mode on success or NULL on failure
+ */
+struct drm_display_mode *
+drm_kunit_display_mode_from_cea_vic(struct kunit *test, struct drm_device *dev,
+				    u8 video_code)
+{
+	struct drm_display_mode *mode;
+	int ret;
+
+	mode = drm_display_mode_from_cea_vic(dev, video_code);
+
+	ret = kunit_add_action_or_reset(test,
+					kunit_action_drm_mode_destroy,
+					mode);
+	if (ret)
+		return NULL;
+
+	return mode;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_display_mode_from_cea_vic);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_DESCRIPTION("KUnit test suite helper functions");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index e7cc17ee4934..afdd46ef04f7 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -120,4 +120,8 @@ drm_kunit_helper_create_crtc(struct kunit *test,
 			     const struct drm_crtc_funcs *funcs,
 			     const struct drm_crtc_helper_funcs *helper_funcs);
 
+struct drm_display_mode *
+drm_kunit_display_mode_from_cea_vic(struct kunit *test, struct drm_device *dev,
+				    u8 video_code);
+
 #endif // DRM_KUNIT_HELPERS_H_
-- 
2.34.1


