Return-Path: <linux-kernel+bounces-281480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD194D764
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A3CB212B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70F16132E;
	Fri,  9 Aug 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qlghef/t"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63315F303
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232187; cv=none; b=r+oqZGUqaTqJVoFSQa6abRC6vxWCK/gNvLyeMubuaNNFv0a/wqqVXcYkFplUuKfFHU+IDChFKymsGOyUAclFiz1U3AbSh2hzAYED8nqmbIini+c0v8SAkM00NM+G5dRi58nfmi9X3Fl+ARrgsyxzTrWXAT39nm3VFIj5Gctpy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232187; c=relaxed/simple;
	bh=LAeMWAPS7iDhVHc+K6GXs/juHcJ5BmLOJVWCWGPDs+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTyQRr2wE5eE+xZ7ov2ewJ7d5xvBLy8sp6slhQTvbazIW5Jm8+n5QCMnvU1cXZpW+DM79anpwyCDK0m32vetLiWcQoDVkwdFwfxzdomGTrvVw9YOGeEiH7jOduZvPqr2J3fXTDqQZHHRPj73/al1KPI6MD5eylq8SeiCLFe2ULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qlghef/t; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723232181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jzac6s167f/EibwxsfpMGlvZd8RAd5X1jF/kZBreWa0=;
	b=qlghef/ttCZexKig9Jch5lSW2xzc7BANS7o9DC1GOHOq2kxjB71oEFiEt0WkpXzg/M7aBT
	PPzsOlK9tE+2thach6XanfFKFbREhHDTS//1b5Qs3OE1nPurVT23GxbwYm0ZEBrkTRl19R
	bczk3ly0v1y2D5tdvhKaTtoIcwr/tGE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v6 1/8] drm: zynqmp_kms: Unplug DRM device before removal
Date: Fri,  9 Aug 2024 15:35:53 -0400
Message-Id: <20240809193600.3360015-2-sean.anderson@linux.dev>
In-Reply-To: <20240809193600.3360015-1-sean.anderson@linux.dev>
References: <20240809193600.3360015-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Prevent userspace accesses to the DRM device from causing
use-after-frees by unplugging the device before we remove it. This
causes any further userspace accesses to result in an error without
further calls into this driver's internals.

Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
Closes: https://lore.kernel.org/dri-devel/4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev/
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
Thanks to Maxime for pointing out the correct function to use here.

Changes in v6:
- New

 drivers/gpu/drm/xlnx/zynqmp_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index bd1368df7870..4556af2faa0f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -536,7 +536,7 @@ void zynqmp_dpsub_drm_cleanup(struct zynqmp_dpsub *dpsub)
 {
 	struct drm_device *drm = &dpsub->drm->dev;
 
-	drm_dev_unregister(drm);
+	drm_dev_unplug(drm);
 	drm_atomic_helper_shutdown(drm);
 	drm_encoder_cleanup(&dpsub->drm->encoder);
 	drm_kms_helper_poll_fini(drm);
-- 
2.35.1.1320.gc452695387.dirty


