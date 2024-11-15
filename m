Return-Path: <linux-kernel+bounces-410997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8D9CF16B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6274D29551E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8551CEAD6;
	Fri, 15 Nov 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQUYRmpn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF01E4A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687809; cv=none; b=l6rdk2VRmL1F9aMpi6QDKiOBadTMnZO2HlK2c6UWpsgCk++VDfmSO/KniKxWiUnQ/S7+rfpq3YuZKn2ktbLoS3F3+Tpl8+C/lAe71dpiNIHJKEaLqIKeRqLgoXA1eAkCndW/PtXw+ZxYEY1R8EDYf98cYGbPr1YRXxYfTKdsKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687809; c=relaxed/simple;
	bh=17c2BctoatZCGP+sdz3tAGm/ndqqwG8Ri12IIiba7I0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BlLhZ8E1phiCNwQN9zQpjtI1iT6laLNF+rrelrmEu2eGYpSzMGEmGpZcO/rsHphw2ks3N5hbaFzkYWFFQmAGYRnYljpBpBID0Iay0F/H3DXdTxXG3BgjMAGXAwLG6CuY2f9kzcNN/mBfuIUh6/zLtMPJCNqcS+4So2R14x+xbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQUYRmpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F10C4CECF;
	Fri, 15 Nov 2024 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731687808;
	bh=17c2BctoatZCGP+sdz3tAGm/ndqqwG8Ri12IIiba7I0=;
	h=From:To:Cc:Subject:Date:From;
	b=cQUYRmpnxftDsI7zRrVikCiERAoyp0k7BNogOtUbU37ZJX/C7M2+lkVArUzi/A6xx
	 MGrGhHkv2+dlRBl7Jha6+VUsZaQMa17fz34YKTY4VNPLKIzzC1w75ItHJt5crbvqHn
	 Fi97xBOw93OzGcR4bkwW/FoQrxMkpIpehXx9jc9u/bX7XGWPbqfNq2FkWOFXg4Be3F
	 eFjy2BogsyiBuzudTb6fKRtlL9RPJHREOvQIbBXqtcz9jYj5G33D9TJ1o+ODvHy8bz
	 zp5qeJhssACEdKh++VBgVNaWez+8VFXRHYO2JOMlHaiHqyaH2OKBMJlI1tLDOibjz/
	 MItBoNmEt7TNw==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jani Nikula <jani.nikula@intel.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drm: rework FB_CORE dependency
Date: Fri, 15 Nov 2024 17:23:10 +0100
Message-Id: <20241115162323.3555229-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'select FB_CORE' statement moved from CONFIG_DRM to DRM_CLIENT_LIB,
but there are now configurations that have code calling into fb_core
as built-in even though the client_lib itself is a loadable module:

x86_64-linux-ld: drivers/gpu/drm/drm_fbdev_shmem.o: in function `drm_fbdev_shmem_driver_fbdev_probe':
drm_fbdev_shmem.c:(.text+0x1fc): undefined reference to `fb_deferred_io_init'
x86_64-linux-ld: drivers/gpu/drm/drm_fbdev_shmem.o: in function `drm_fbdev_shmem_fb_destroy':
drm_fbdev_shmem.c:(.text+0x2e1): undefined reference to `fb_deferred_io_cleanup'
...
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
drm_fb_helper.c:(.text+0x2c6): undefined reference to `fb_set_suspend'
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
drm_fb_helper.c:(.text+0x2e1): undefined reference to `fb_set_suspend'

In addition to DRM_CLIENT_LIB, the 'select' needs to be at least in
two more parts, DRM_KMS_HELPER and DRM_GEM_SHMEM_HELPER, so add those
here.

Fixes: dadd28d4142f ("drm/client: Add client-lib module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: keep the select in DRM_CLIENT_LIB, keep alphabetic sorting
---
 drivers/gpu/drm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index a4a092ee70d9..410bd6d78408 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -98,6 +98,7 @@ config DRM_KUNIT_TEST
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
+	select FB_CORE if DRM_FBDEV_EMULATION
 	help
 	  CRTC helpers for KMS drivers.
 
@@ -371,6 +372,7 @@ config DRM_GEM_DMA_HELPER
 config DRM_GEM_SHMEM_HELPER
 	tristate
 	depends on DRM && MMU
+	select FB_CORE if DRM_FBDEV_EMULATION
 	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  Choose this if you need the GEM shmem helper functions
-- 
2.39.5


