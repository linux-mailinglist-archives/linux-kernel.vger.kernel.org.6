Return-Path: <linux-kernel+bounces-397550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8539BDD53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767521F22ED5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C9B18FC9F;
	Wed,  6 Nov 2024 02:55:47 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A96383
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861747; cv=none; b=GmZllKx00Ts9ThplkgUJxJhpyWGh4OJPaMuCgEsvIBvDK8dCXWpty9NsiaqSghBy16GSFfRlZdVwzpM9OuaKV7GeTOru+CWwiX6YjBSFG4gA/lqbmrHEWPyiW7rC6T0g80aNxzY05KErhWxqLM73dawVNLKSo7aDQPEDMZU8CAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861747; c=relaxed/simple;
	bh=xcKCbMJ0/Xu6ANz+iEc5O0jIA68TrTRGppkEQEWJYXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bNwTbwwGPnfhXa+5kkVVapsdxOz4IagTNSAG2ENt/3uJIAG4ICOIybYADxCjWJrqYs/YrhIZRFi4kqNVobJSBB7t2tpND78ljbrbd8yCMHgil+MVTIMd5UxlTFdEAu7PuKKYQf/0mN5Oi91+oFzeNzHHZNdH1O20H1bMZjAZaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XjqXm0lcPz2Fbr5;
	Wed,  6 Nov 2024 10:54:00 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id B91CE1A0188;
	Wed,  6 Nov 2024 10:55:40 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 6 Nov
 2024 10:55:40 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <neil.armstrong@linaro.org>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chris.zjh@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH] drm/meson: Avoid use-after-free issues with crtc
Date: Wed, 6 Nov 2024 02:45:48 +0000
Message-ID: <20241106024548.1915611-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100007.china.huawei.com (7.202.181.92)

It's dangerous to call drm_crtc_init_with_planes() whose second
argument is allocated with devm_kzalloc() [1][2].

Use drmm_kzalloc instead to avoid UAF.

[1] https://lore.kernel.org/all/a830685d8b10a00cfe0a86db1ee9fb13@ispras.ru
[2] https://lore.kernel.org/all/2111196.TG1k3f53YQ@avalon

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
 drivers/gpu/drm/meson/meson_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index d70616da8ce2..603022554a48 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -17,6 +17,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include "meson_crtc.h"
 #include "meson_plane.h"
@@ -72,7 +73,6 @@ static void meson_crtc_disable_vblank(struct drm_crtc *crtc)
 static const struct drm_crtc_funcs meson_crtc_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
-	.destroy		= drm_crtc_cleanup,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.reset			= drm_atomic_helper_crtc_reset,
 	.set_config             = drm_atomic_helper_set_config,
@@ -677,14 +677,14 @@ int meson_crtc_create(struct meson_drm *priv)
 	struct drm_crtc *crtc;
 	int ret;
 
-	meson_crtc = devm_kzalloc(priv->drm->dev, sizeof(*meson_crtc),
+	meson_crtc = drmm_kzalloc(priv->drm, sizeof(*meson_crtc),
 				  GFP_KERNEL);
 	if (!meson_crtc)
 		return -ENOMEM;
 
 	meson_crtc->priv = priv;
 	crtc = &meson_crtc->base;
-	ret = drm_crtc_init_with_planes(priv->drm, crtc,
+	ret = drmm_crtc_init_with_planes(priv->drm, crtc,
 					priv->primary_plane, NULL,
 					&meson_crtc_funcs, "meson_crtc");
 	if (ret) {
-- 
2.34.1


