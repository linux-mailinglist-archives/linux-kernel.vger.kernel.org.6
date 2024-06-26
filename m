Return-Path: <linux-kernel+bounces-230311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA883917B27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96524281DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40EF161935;
	Wed, 26 Jun 2024 08:41:57 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9D15F316
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391317; cv=none; b=jrdUnvSFaUVQvXzBvMv0ltK86ShYwqMomxVQX2vHs6EuBDI0fS1ZYGa3zbNDZWBCpklTP9hmn7AHTGhCN1kKqL91jdvQpUBzZjbKUwumwLNUo+J3ygReyY+VSYk7B4MAuhmAINTYD7ulxzMMXzobr92mo4cSir9L2RmAhtYN3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391317; c=relaxed/simple;
	bh=vGvpvDkTEKPSeCsnGYZN5jSHNJXDkF8Oj7//DH35elU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCDNQSjIDUUze04uR8HrP8cUTu8Fjh4M2yP16FxqfDJHYtAMMAVZnK3+ToTXEHsqI/iTUOt+A4J9BNIZA8gmJx0UuX9sQ0uLl1yZ5/cftZ8DQrKs4wlXdyAqc9ibG9LUbU7THbVrFip819lxkDEhOnwOFgd4bASH65OJduZtc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1dff:b715:1a2c:c3f5])
	by laurent.telenet-ops.be with bizsmtp
	id g8hm2C00K0lK4vA018hmnr; Wed, 26 Jun 2024 10:41:47 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sMODm-000OVn-F9;
	Wed, 26 Jun 2024 10:41:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sMODq-00Aong-AJ;
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
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] drm/panic: Do not select DRM_KMS_HELPER
Date: Wed, 26 Jun 2024 10:41:44 +0200
Message-Id: <60155f8c939ed286e324a7c12a1daa69fe49fcf6.1719391132.git.geert+renesas@glider.be>
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

DRM core code cannot call into DRM helper code, as this would lead to
circular references in the modular case.  Hence drop the selection of
DRM_KMS_HELPER.  It was unused anyway, as v10 switched from using
the DRM format helpers to its own color format conversion, cfr. commit
9544309775c334c9 ("drm/panic: Add support for color format
conversion")).

Remove the unneeded include of <drm/drm_format_helper.h>.

Fixes: bf9fb17c6672868d ("drm/panic: Add a drm panic handler")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/Kconfig     | 1 -
 drivers/gpu/drm/drm_panic.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index b903a2c0b5e8f95c..ce9bf2b6e9d332d4 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -108,7 +108,6 @@ config DRM_KMS_HELPER
 config DRM_PANIC
 	bool "Display a user-friendly message when a kernel panic occurs"
 	depends on DRM && !(FRAMEBUFFER_CONSOLE && VT_CONSOLE)
-	select DRM_KMS_HELPER
 	select FONT_SUPPORT
 	help
 	  Enable a drm panic handler, which will display a user-friendly message
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 8d2eded1fd19ff6c..67f78b5a76b61e3d 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -20,7 +20,6 @@
 #include <linux/types.h>
 
 #include <drm/drm_drv.h>
-#include <drm/drm_format_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper_vtables.h>
-- 
2.34.1


