Return-Path: <linux-kernel+bounces-335530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA497E700
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88752810E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14CA47772;
	Mon, 23 Sep 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="D7kmXpfS"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9976F1B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078241; cv=none; b=a+q55NNQi0itqsUknXzK1iNsQeWPChW4NmeFoA3+F8xQhV5M1I8TRClzQ+QW0c2HPQFVhXHtN4rrCOZvM4E+6K+UhqOwSsUB9bzWgzWGfxVHvVuCoh3VTUJxkClgsRRsTC3UoOfmnLDAimG6eRp4nlrguuj8aD8tz6aPguJNGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078241; c=relaxed/simple;
	bh=NxEbUk7Uzo2n0iw38GrUtE/c0w3d73+GEG6AeeLsL04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paI0b9DZPihdRiyrzAQeiRq3uw3HLaf0WClN3EN5z0Uiy0RW4H0lxV/3KO58Y5p28LWXCKs0jpcELLutTeaRJVEo4BZ4PyMR8QKKNCz6qtwGge9bPMGzCrgly0Xbn/KzvZsppVMw+2RDpA1z0YccudGnn+pBPweuU5C2a7GhId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=D7kmXpfS; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XBw8l6zfSz9smr;
	Mon, 23 Sep 2024 09:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1727077704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bdfSuHfCrlx1wGjfrH9+twPjEUAgZch4w9adGVm82oY=;
	b=D7kmXpfSvAQJkUPYM8fyZbQJa8g6pOf/z5DXlJjNLbi2ebZWbDwaW2WOeRCcoBi3ykoTUo
	iG4k2PHk/OC8h0lqV1fth93Nx024PjWBuUvxi1fPhNSiB92TQ6054jRsEbFBnZam6gFRIU
	NDmJS2yiOefOqtjSDrKq3D/1vWto4Qe1sduRZAIcdMExaCeN5D8rtYhQub4P5Gp5aRgtR8
	N1ssqgbpVsIMO1yrcidpV9R82vjqdADEcMqFCKVZQcpKdAxeL2EQf+JaSDxCkXVXFi+RzQ
	F10CPZHTmJGrXigu5aIi8tx7ppQNhWvZsdTkgOa6Vj1TNtax145KcTvSw7+Adg==
From: lists@steffen.cc
To: dri-devel@lists.freedesktop.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Steffen Dirkwinkel <lists@steffen.cc>,
	Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: xlnx: zynqmp_dpsub: also call drm_helper_hpd_irq_event
Date: Mon, 23 Sep 2024 09:48:03 +0200
Message-ID: <20240923074803.10306-1-lists@steffen.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XBw8l6zfSz9smr

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

With hpd going through the bridge as of commit eb2d64bfcc17
("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
we don't get hotplug events in userspace on zynqmp hardware.
Also sending hotplug events with drm_helper_hpd_irq_event works.

Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 1846c4971fd8..cb823540a412 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -17,6 +17,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
+#include <drm/drm_probe_helper.h>
 
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -1614,6 +1615,9 @@ static void zynqmp_dp_hpd_work_func(struct work_struct *work)
 					    hpd_work.work);
 	enum drm_connector_status status;
 
+	if (dp->bridge.dev)
+		drm_helper_hpd_irq_event(dp->bridge.dev);
+
 	status = zynqmp_dp_bridge_detect(&dp->bridge);
 	drm_bridge_hpd_notify(&dp->bridge, status);
 }
-- 
2.46.1


