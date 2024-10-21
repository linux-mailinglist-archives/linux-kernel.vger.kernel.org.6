Return-Path: <linux-kernel+bounces-374473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0729A6ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE1B1F22526
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937671F9ED0;
	Mon, 21 Oct 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="1HBJy0MW"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D81F8F1B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518160; cv=none; b=kQ6BBhoTd4LMbYyg9ysfzttBIQ1e3/379WlddqXmd8h13Hij1kM6ZtYWqi8TWiDH09uvCsMPwqM5ful8xscrClStokX8MJPgGkqEAgdJcFAhQHEri1GJeWsl/88jv81UqxJCu7faHwCo/7DlvaLOnTLb323BngBpaliWbkQBCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518160; c=relaxed/simple;
	bh=2OvNmKCE+1cUEVZtspsYcVHSe2PwsTglKsSpIw30sCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kalegSDwInl+kj9ZcoJliwLYSV81pCiQ5cujHl/3gx45lb8pYMeb3UmyA45GaBLtxnLFLGhad40vP668JODbYFKMPazpV/nY26FPTyc63tn0c2VEpHB1JSrssPzFrl0iPCisg7PwN1N69Ge0zEV3tZWneGIh+tvFplj6f7tw4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=1HBJy0MW; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XXGhT4w7Sz9sqr;
	Mon, 21 Oct 2024 15:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1729518153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p+Ueqw7K6WBwEq+dB6zx4UE03I/127H/OEWMY7Bd6us=;
	b=1HBJy0MWhCTeRao5h9ySggPP1YHqCwKRWJJp3t1NP8nwkRoGsFXoWVwCX3oW70/FDGnAe8
	KXbn4FFgoq3/axUS7BRaaxQNLeET3MGRX8jSRScyubaL909T6gnkdmuYFSmlqdz3B2e6q+
	hL3J4NEV+1UIgeH5D81zf54lz2uOqi8493PZffxo+reHiPl2SmIZwlxFFJlTUPhnO34ycG
	Gi8WnZ9pKlwZX5hXP/rLoS/KCaFalUyv1KtAUDK3FYPKhdkIzzFgv36GxUVQn+S8VzWp7S
	mXmgJibt1/VcdzNEzQaDJE8FuAu3uid3+MQv8+f8td6b/pEcvsoH+5NWMlUJ/w==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: dri-devel@lists.freedesktop.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: xlnx: zynqmp_dpsub: fix hotplug detection
Date: Mon, 21 Oct 2024 15:41:14 +0200
Message-ID: <20241021134115.216568-1-lists@steffen.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

drm_kms_helper_poll_init needs to be called after zynqmp_dpsub_kms_init.
zynqmp_dpsub_kms_init creates the connector and without it we don't
enable hotplug detection.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index bd1368df7870..311397cee5ca 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -509,12 +509,12 @@ int zynqmp_dpsub_drm_init(struct zynqmp_dpsub *dpsub)
 	if (ret)
 		return ret;
 
-	drm_kms_helper_poll_init(drm);
-
 	ret = zynqmp_dpsub_kms_init(dpsub);
 	if (ret < 0)
 		goto err_poll_fini;
 
+	drm_kms_helper_poll_init(drm);
+
 	/* Reset all components and register the DRM device. */
 	drm_mode_config_reset(drm);
 
-- 
2.47.0


