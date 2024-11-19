Return-Path: <linux-kernel+bounces-414654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31C9D2BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73682835DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0B1D3566;
	Tue, 19 Nov 2024 16:45:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74D1D3181
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034704; cv=none; b=YCv0D8m8U7UwA4V29y0VFEDzgo9xGNrh5Oy8/FUS09HmkXXyfpOrXfkBRo9awXCKyJSrowb8S/NgYD3EI8PWUzBUW3S3UaOtCKpllJEP6qA8oqLNcOhlNTRBiaoFbA35r+XGLFQowl+XTUndHATI+BHbM6YfiG2I8s9kloMX2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034704; c=relaxed/simple;
	bh=8XLhrcnezAFPLIrtN24W8/IJV0NoFaAQs1Ko2SQA+08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eeHoCxdNxhFxpKZpNHLAnkuJOVoy8z8cs5bJ5dbNUu3Xr+D0qyk5bvwZqaBFty1jGjXoI7NBpIMVDPpoxkgHWFr+TKVnE923LCq8+6uPGYn9NMaUKL5tFIPoLIuvj4vq7oB0AinB+1vRR20T8z+1+iasGdFw2ixjMWcNRXWmoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48A5B20E3;
	Tue, 19 Nov 2024 08:45:31 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E5153F66E;
	Tue, 19 Nov 2024 08:44:59 -0800 (PST)
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH] drm/panthor: Fix compilation failure on panthor_fw.c
Date: Tue, 19 Nov 2024 16:44:55 +0000
Message-ID: <20241119164455.572771-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 498893bd596e ("drm/panthor: Simplify FW fast reset path") forgot
to copy the definition of glb_iface when it move one line of code.

Fixes: Commit 498893bd596e ("drm/panthor: Simplify FW fast reset path")
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4bc52b1b1a286..c807b6ce71bd4 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1133,6 +1133,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
 		 * This is not needed on a slow reset because FW sections are
 		 * re-initialized.
 		 */
+		struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
 
 		ret = panthor_fw_start(ptdev);
-- 
2.47.0


