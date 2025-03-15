Return-Path: <linux-kernel+bounces-562557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49241A62C20
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADEE3BE570
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C621F8676;
	Sat, 15 Mar 2025 11:51:00 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD01DC9BE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742039460; cv=none; b=Xcw3MBVV+Fm9pBlD/4kbxWt85qMqJVDzHqW4WMYJnPV73dY0YAIctkFbk0NzjulZrqTKf/JXYcT4tTIlZnDrO2rrv6xrZkEyW1gdF9V3tVgEFu/8bQNvtvxC6EzusxbwU0Cza2MSKQq9Q/j4oWb8rYNsy8AWAqYmbLkc0Kf9TiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742039460; c=relaxed/simple;
	bh=1D6lAFNvZkY/dKLEAUoPgWaSMr8SYuIxR3o+zNOwE4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i6Km/MYQhP557Dp7EyYnbS/aLvoWzDKAFLCXl93tNFym+fGzxP5/KlZrmN3JQfpr28BNGg/znB/t2i3jgkDqApi2zR95FQaXYAwlQbs/cxNJKZGVTmNh/AgIT/SiDA631cFyiF4qkNJxPvdAJ5GOLWjI4VC2QYxeamzuT5R6JM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZFKH05shYzDssM;
	Sat, 15 Mar 2025 19:47:40 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CF331401E9;
	Sat, 15 Mar 2025 19:50:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Mar
 2025 19:50:52 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jani.nikula@linux.intel.com>, <rodrigo.vivi@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <tursulin@ursulin.net>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <tzimmermann@suse.de>,
	<dev@lankhorst.se>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] drm/i915/display: Fix build error without DRM_FBDEV_EMULATION
Date: Sat, 15 Mar 2025 20:01:43 +0800
Message-ID: <20250315120143.2344958-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

In file included from <command-line>:
./drivers/gpu/drm/i915/display/intel_fbdev.h: In function ‘intel_fbdev_framebuffer’:
./drivers/gpu/drm/i915/display/intel_fbdev.h:32:16: error: ‘NULL’ undeclared (first use in this function)
   32 |         return NULL;
      |                ^~~~
./drivers/gpu/drm/i915/display/intel_fbdev.h:1:1: note: ‘NULL’ is defined in header ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?
  +++ |+#include <stddef.h>
    1 | /* SPDX-License-Identifier: MIT */
./drivers/gpu/drm/i915/display/intel_fbdev.h:32:16: note: each undeclared identifier is reported only once for each function it appears in
   32 |         return NULL;
      |                ^~~~

Build fails if CONFIG_DRM_FBDEV_EMULATION is n, add missing header file.

Fixes: 9fa154f40eb6 ("drm/{i915,xe}: Run DRM default client setup")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_fbdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.h b/drivers/gpu/drm/i915/display/intel_fbdev.h
index ca2c8c438f02..89bad3a2b01a 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.h
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.h
@@ -6,6 +6,8 @@
 #ifndef __INTEL_FBDEV_H__
 #define __INTEL_FBDEV_H__
 
+#include <linux/types.h>
+
 struct drm_fb_helper;
 struct drm_fb_helper_surface_size;
 struct drm_i915_private;
-- 
2.34.1


