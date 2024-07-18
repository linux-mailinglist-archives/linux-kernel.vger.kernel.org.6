Return-Path: <linux-kernel+bounces-255915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEDF93469E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80538283840
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF00E2C1A2;
	Thu, 18 Jul 2024 03:09:10 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC318EBF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721272150; cv=none; b=tTJ04GqL7dgzmeNd/1CCFDdTvC7ehv07SfxoZS65x5+sUOkpKkhibQvpOmDnU8AQuD7M3i08esv03s3xkeF0+Znp46otXK6KZMfnBpdbXURoUPjsnga7+Gjpr5J2nGzxi0bqI3ayAix1T8d3CLklzNEdlWHU+99j6NGWUdDzh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721272150; c=relaxed/simple;
	bh=Wn/ugSasIZn1Rz+OIXPHCRFZ7J1x+uFKA3RglbYqnt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UQZ0XVPLPH1KfUvyRRm9C6qAUpPKqQn0u91+G+vUo/uHqgcPQQeucFb1SwfhMrcaZ0oc8r5PZ0mIwaRZhgZWeERLc4IAd+ED9LWJSGSoV9JciGPIaw9Ostf9IJmYiSlfshwINxehgFjDVif6pJsgTsoqlYqDClrV82Syxm19S6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 18 Jul
 2024 11:03:52 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 18 Jul 2024 11:03:52 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <tzimmermann@suse.de>, <jfalempe@redhat.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<airlied@redhat.com>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/ast: Fix black screen after resume
Date: Thu, 18 Jul 2024 11:03:52 +0800
Message-ID: <20240718030352.654155-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Suspend will disable pcie device. Thus, resume should do full hw
initialization again.
Add some APIs to ast_drm_thaw() before ast_post_gpu() to fix the issue.

Fixes: 5b71707dd13 ("drm/ast: Enable and unlock device access early during init")
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index f8c49ba68e78..45a9c7bf49c8 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -391,6 +391,11 @@ static int ast_drm_freeze(struct drm_device *dev)
 
 static int ast_drm_thaw(struct drm_device *dev)
 {
+	struct ast_device *ast = to_ast_device(dev);
+
+	ast_enable_vga(ioregs);
+	ast_open_key(ioregs);
+	ast_enable_mmio(dev, ioregs);
 	ast_post_gpu(dev);
 
 	return drm_mode_config_helper_resume(dev);

base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
prerequisite-patch-id: a03a33902f33bcc38091e2cdce9d79f630464c30
prerequisite-patch-id: 505779a1e2094f2ee2f2a55ad44aac5cd1d5342f
-- 
2.25.1


