Return-Path: <linux-kernel+bounces-281483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5894D767
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789A2B20F92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810815FA73;
	Fri,  9 Aug 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uWKfHF9m"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBC168486
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232191; cv=none; b=R3/FefBPBCZoslXxUhiBoQlwxKsr4tMOtExhyZ52a1HxWrxP52RH8W182cEILZi7xw9BZWrJ3haihvNgtS/SkFyK1A1bDFipU0S7l2XIdihK6e/tST8LyvkTDMrmsA02UxFkW3A6I4JvjkTy/ZazMbOaPouDGXMe1p/R9HGK64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232191; c=relaxed/simple;
	bh=gc4avITRlwrSjXO9PlWm5CdygUmC7j5x84yH+8YOlVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8aujuu42YlhD/zz/Tg+U4BKwaTK4BpZE6Cl6zgvgIqhOY4hNiVBekvnGJjWirTrPlLagyBCjPCkzSMc5s33HzFM2+l7Kda62clBEuci0JbIvlRha0XwW4zLvOeqiuLO8+qmxNZCo+4qcHDzbh9fVjeBN0ddUFRCCD29e8Taox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uWKfHF9m; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723232187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikxIScfUv2b8NNW6uDWKv1jhmd4Ojs4CUAXyBEP9cr8=;
	b=uWKfHF9mVEROSGlYuIMLMnFyS6kri9nglPKCWfrbBwWpFSwEM7iYXO4wMBRQcHqbUt/0cR
	UJpVlHY3xm542SqnzkYKUqs54yK+wBiHOdqCOXmBivciW9YX+8tzhFJvsx+oBb7/kt7fRj
	xFCnCUQXZPA/ntcwW2I20Q4BG1f8oWI=
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
Subject: [PATCH v6 4/8] drm: zynqmp_dp: Convert to a hard IRQ
Date: Fri,  9 Aug 2024 15:35:56 -0400
Message-Id: <20240809193600.3360015-5-sean.anderson@linux.dev>
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

Now that all of the sleeping work is done outside of the IRQ, we can
convert it to a hard IRQ. Shared IRQs may be triggered even after
calling disable_irq, so use free_irq instead which removes our callback
altogether.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v6:
- Fix hang upon driver removal

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index cec5711c7026..532e103713b3 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1831,9 +1831,8 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	 * Now that the hardware is initialized and won't generate spurious
 	 * interrupts, request the IRQ.
 	 */
-	ret = devm_request_threaded_irq(dp->dev, dp->irq, NULL,
-					zynqmp_dp_irq_handler, IRQF_ONESHOT,
-					dev_name(dp->dev), dp);
+	ret = devm_request_irq(dp->dev, dp->irq, zynqmp_dp_irq_handler,
+			       IRQF_SHARED, dev_name(dp->dev), dp);
 	if (ret < 0)
 		goto err_phy_exit;
 
@@ -1858,7 +1857,7 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
 	struct zynqmp_dp *dp = dpsub->dp;
 
 	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, ZYNQMP_DP_INT_ALL);
-	disable_irq(dp->irq);
+	devm_free_irq(dp->dev, dp->irq, dp);
 
 	cancel_work_sync(&dp->hpd_irq_work);
 	cancel_work_sync(&dp->hpd_work);
-- 
2.35.1.1320.gc452695387.dirty


