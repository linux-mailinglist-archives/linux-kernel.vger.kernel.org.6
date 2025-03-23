Return-Path: <linux-kernel+bounces-572805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB291A6CEE8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579CB16DD00
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174001DE8B3;
	Sun, 23 Mar 2025 11:30:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED435947
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742729443; cv=none; b=mOG84G7F6Ib3xXFI9ns5adtsOEnlZNSeb5PUI+ryWpXh/gJhV/14jpWXqj+QeFk0EGEatcO93vy6wjk0Cx7dJRdEBJTvWUAvn1nApMTLxlbT57JgkQ9dJBWk2mDk+KbPE5ZVYo5s8YjRTGgniUJz7gTEEKAIo5G5c1KytDD8zIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742729443; c=relaxed/simple;
	bh=KuyIJtGMbRRJPiZrKfhRfs8qQaQEMIdK/JKBlq84QKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IvEysqzbKXL1O7J/yLbbxKG3NRqwfUFUOgKczcMeslc4NHjD3r+dA9cESzqC3nnD3nlhN+hzMRt/eL26wvIQfw5Hmkt0Nizr1XDlWOv+Ahf/juhv8fPglvsEDFVGg17pkKQAahxghFerFPT24vtuB2IiVxRFHXgm3dPdGL44d0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZLDRL73LbzCsHl;
	Sun, 23 Mar 2025 19:26:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A6CE11800FD;
	Sun, 23 Mar 2025 19:30:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 23 Mar
 2025 19:30:32 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <lucas.demarchi@intel.com>, <thomas.hellstrom@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] drm/xe: Fix unmet direct dependencies warning
Date: Sun, 23 Mar 2025 19:41:03 +0800
Message-ID: <20250323114103.1960511-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
  Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
  Selected by [m]:
  - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=m] && DRM_XE [=m] && DRM_XE [=m]=m [=m] && HAS_IOPORT [=y]

DRM_XE_DISPLAY requires FB_IOMEM_HELPERS, but the dependency FB_CORE is
missing, selecting FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION is set as
other drm drivers.

Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION instead of select FB_CORE
---
 drivers/gpu/drm/xe/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 7d7995196702..5c2f459a2925 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -53,7 +53,7 @@ config DRM_XE
 config DRM_XE_DISPLAY
 	bool "Enable display support"
 	depends on DRM_XE && DRM_XE=m && HAS_IOPORT
-	select FB_IOMEM_HELPERS
+	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
 	select I2C
 	select I2C_ALGOBIT
 	default y
-- 
2.34.1


