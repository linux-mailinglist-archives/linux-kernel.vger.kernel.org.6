Return-Path: <linux-kernel+bounces-230312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73834917B28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EE41C2458E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337841667F1;
	Wed, 26 Jun 2024 08:41:58 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375015D5DE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391317; cv=none; b=ZzEMMgJOHu1eGPrPTi6eTwJHJU/GX6S+4gGntexblflD0vyH4pKAdlZ1eM5Hq1w8OPqRoR3T53XJC/qVGUclj7YHlNCRhCUleq2Y9iLl4I6WVByN3JIxSRC31SddTKer6xvgCTOfTGDOkKM4Dmx2LcmKIp47L+ztFKb0ftEY9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391317; c=relaxed/simple;
	bh=JAbpCj/RCVldgdIk3yRrqc8Eh1Edg+BwtOO7Sfn3Vyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S22InrIQooEyI0MHghBnDX85neH1Tye3IVwK8krqCfq5U/fwqbJqc4lFCATetT1xHyzZtFSVf0zYXKtcGUb+rK2osKUY+qdZMG7vEILw4/BDPZKmy3DZQXj3I54AdDMtErzHVmvF9p6kdcrbdzRZo1okeXyEqPlHRWwp2EYyRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1dff:b715:1a2c:c3f5])
	by albert.telenet-ops.be with bizsmtp
	id g8hm2C00G0lK4vA068hmGN; Wed, 26 Jun 2024 10:41:47 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sMODm-000OVr-Fx;
	Wed, 26 Jun 2024 10:41:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sMODq-00Aonj-By;
	Wed, 26 Jun 2024 10:41:46 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] drm/panic: Restrict graphical logo handling to built-in
Date: Wed, 26 Jun 2024 10:41:45 +0200
Message-Id: <4009fca99a7c05f617cc9899c6d0a5748415595d.1719391132.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719391132.git.geert+renesas@glider.be>
References: <cover.1719391132.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_DRM_PANIC=y, but CONFIG_DRM=m:

    ld: drivers/gpu/drm/drm_panic.o: in function `drm_panic_setup_logo':
    drivers/gpu/drm/drm_panic.c:99: multiple definition of `init_module'; drivers/gpu/drm/drm_drv.o:drivers/gpu/drm/drm_drv.c:1079: first defined here

Fix this by restricting the graphical logo handling and its
device_initcall() to the built-in case.  Logos are freed during late
kernel initialization, so they are no longer available at module load
time anyway.

Fixes: 294bbd1f2697ff28 ("drm/panic: Add support for drawing a monochrome graphical logo")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406261341.GYsbLpN1-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/drm_panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 67f78b5a76b61e3d..948aed00595eb6dd 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -91,7 +91,7 @@ static const struct drm_panic_line logo_ascii[] = {
 	PANIC_LINE(" \\___)=(___/"),
 };
 
-#ifdef CONFIG_LOGO
+#if defined(CONFIG_LOGO) && !defined(MODULE)
 static const struct linux_logo *logo_mono;
 
 static int drm_panic_setup_logo(void)
-- 
2.34.1


