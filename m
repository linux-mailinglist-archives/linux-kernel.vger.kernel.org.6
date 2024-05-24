Return-Path: <linux-kernel+bounces-188550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD978CE34C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BACF1F22A87
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B44F84FB7;
	Fri, 24 May 2024 09:25:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FA29422
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542758; cv=none; b=ol4Rv8Cvz8fXrvPDA6K3pIG98RrsyR57QfFkk0oTWC24k3IJb7PAjPO47vPJoMJxPMUhKc3CV14kKvcQmGgJNfm4kvpd3OVYRz1aMJR5UGxs/yXqYSLhkXR+V70P8qNOKRRfcXQ0tW8qK4Rxmxi8klQwgcdJpgZZ0cOgKsOFx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542758; c=relaxed/simple;
	bh=yn0UIRDXb/4FFzQvGAAS9y46o7z9CqbIGH2x0hW+WCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dJzXcTTpRePejV9gU1WQrKW6nNuyqQWDJfKxt1dQKr2/1d3+OwVxlBCuQJLEqJYyw5G9zXKzARLRghGNC9dn2cyGQzHWVtSVZR7yFvdOq1bWXF77/XhOilfOHKQblpNjbjauVyFJYQj8NVqIuUeZKLVfKUnbIEOLMxgyeMQVjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1sARBB-0007SY-J8; Fri, 24 May 2024 11:25:37 +0200
From: =?UTF-8?q?Sven=20P=C3=BCschel?= <s.pueschel@pengutronix.de>
To: hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Michael Tretter <m.tretter@pengutronix.de>,
	=?UTF-8?q?Sven=20P=C3=BCschel?= <s.pueschel@pengutronix.de>
Subject: [PATCH] drm/rockchip: Set DMA max segment size
Date: Fri, 24 May 2024 11:23:59 +0200
Message-Id: <20240524092400.2019587-1-s.pueschel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Michael Tretter <m.tretter@pengutronix.de>

There is no reason to limit the DMA max segment size for the Rockchip
VOP and VOP2. Set it to the maximum.

This prevents the following warning when DMA API debugging is enabled
with CONFIG_DMA_API_DEBUG_SG=y:

	DMA-API: rockchip-drm display-subsystem: mapping sg segment longer than device claims to support [len=208896] [max=65536]

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index ab55d7132550..0f93efd1a8fa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -67,6 +67,8 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 		}
 	}
 
+	dma_set_max_seg_size(drm_dev->dev, UINT_MAX);
+
 	ret = iommu_attach_device(private->domain, dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Failed to attach iommu device\n");

base-commit: 39bc27bd688066a63e56f7f64ad34fae03fbe3b8
-- 
2.39.2


