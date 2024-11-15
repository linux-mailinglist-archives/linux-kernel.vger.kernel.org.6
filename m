Return-Path: <linux-kernel+bounces-410887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB169CEFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B861F2178B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4D1D4610;
	Fri, 15 Nov 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXFYnPI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A417136E23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684449; cv=none; b=i8F2ld8NcQ7YtIZPH6k1SNNuVSIhTGhjzNYpx9kyaIcGFjYuLkNZsNaqYOmsqGpnWvFkrK52nOfXPsisrHaHCRvmLpr5QyGm5gNxhpMAUjkXk2oMAQRZyQFnoRaSRT3hAGIb8EtrmuVkrICqkxccjVQiDAtDuS+lkNHUZcBr3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684449; c=relaxed/simple;
	bh=InVAmuX7ITlUUswBCI+3uXLXjNaqQWFzo6gGSknDshs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jvDHOAae3avZuQoYaslDYuU5gsZYn20SFhUsgAIAQyLt5yU2ttnYfQEagtKfPDYJidf1b/MC0ewq8QFoOEVAogI5MKuuXlzmru2AAsBRVNzNHAef8IssGb/R6hUowVq3nVjvvT8Ot12+AFVq5VWcqyH5VSo/WhUDyoq1FxwQM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXFYnPI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58C7C4CED2;
	Fri, 15 Nov 2024 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731684447;
	bh=InVAmuX7ITlUUswBCI+3uXLXjNaqQWFzo6gGSknDshs=;
	h=From:To:Cc:Subject:Date:From;
	b=kXFYnPI6I6M2vubKOWgG0JCP7MQYhyQgueCG9T1Xw9k/HBObrYpbv9Ig0lBW8fwFb
	 5AGtW7psVWcdAFsT+HCl7rn8UFjIyM2w1pugigNETWDrCwtpKpUad7InTvDIqEqT3f
	 j+XwHQvbm78yHFnBwNV98NtEjlQBTxyN03K5k7pPgj7dwiz0WC87aTNtDStYMklspd
	 9D0YaP5J9AkvPZSOujby4rVG+1+elm4q/yP/IDN+t+LqyYfAiARO/v+sWihVWjqu/p
	 LuGlQTIjT6tAnlDiYpIv239fVRS5H3IYPWy/OvJ9IIyIOHlQA3KYEi8hBfT+O8RyrC
	 G4OJ1QqnZj/oA==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jani Nikula <jani.nikula@intel.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: rework FB_CORE dependency
Date: Fri, 15 Nov 2024 16:27:10 +0100
Message-Id: <20241115152722.3537630-1-arnd@kernel.org>
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
x86_64-linux-ld: drivers/gpu/drm/drm_fbdev_shmem.o: in function `drm_fbdev_shmem_fb_mmap':
drm_fbdev_shmem.c:(.text+0x34c): undefined reference to `fb_deferred_io_mmap'
x86_64-linux-ld: drivers/gpu/drm/drm_fbdev_shmem.o: in function `drm_fbdev_shmem_defio_imageblit':
drm_fbdev_shmem.c:(.text+0x35f): undefined reference to `sys_imageblit'
x86_64-linux-ld: drivers/gpu/drm/drm_fbdev_shmem.o: in function `drm_fbdev_shmem_defio_copyarea':
drm_fbdev_shmem.c:(.text+0x38b): undefined reference to `sys_copyarea'
x86_64-linux-ld: drivers/gpu/drm/drm_fbdev_shmem.o: in function `drm_fbdev_shmem_defio_fillrect':
drm_fbdev_shmem.c:(.text+0x3b7): undefined reference to `sys_fillrect'
x86_64-linux-ld: drivers/gpu/drm/drm_fbdev_shmem.o: in function `drm_fbdev_shmem_defio_write':
drm_fbdev_shmem.c:(.text+0x3e9): undefined reference to `fb_sys_write'
x86_64-linux-ld: drivers/gpu/drm/drm_fbdev_shmem.o: in function `drm_fbdev_shmem_defio_read':
drm_fbdev_shmem.c:(.text+0x413): undefined reference to `fb_sys_read'
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
drm_fb_helper.c:(.text+0x2c6): undefined reference to `fb_set_suspend'
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
drm_fb_helper.c:(.text+0x2e1): undefined reference to `fb_set_suspend'
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_info':
drm_fb_helper.c:(.text+0x33a): undefined reference to `framebuffer_alloc'
x86_64-linux-ld: drm_fb_helper.c:(.text+0x359): undefined reference to `fb_alloc_cmap'
x86_64-linux-ld: drm_fb_helper.c:(.text+0x368): undefined reference to `framebuffer_release'
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_release_info':
drm_fb_helper.c:(.text+0x3a4): undefined reference to `fb_dealloc_cmap'
x86_64-linux-ld: drm_fb_helper.c:(.text+0x3ab): undefined reference to `framebuffer_release'
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_info':
drm_fb_helper.c:(.text+0x3bb): undefined reference to `unregister_framebuffer'
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
drm_fb_helper.c:(.text+0xb6d): undefined reference to `register_framebuffer'
x86_64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
drm_fb_helper.c:(.text+0x167a): undefined reference to `fb_set_suspend'

Since the code that calls into fb_core is not actually in the client_lib
module but in other helper libraries, move the 'select' again to the
places that actually call into fb_core, in this case DRM_GEM_SHMEM_HELPER
and DRM_KMS_HELPER.

Fixes: dadd28d4142f ("drm/client: Add client-lib module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have only given this light build testing. It seems sensible on the surface,
but there is a chance that there are additional helpers that need the same
'select'. Moving it into CONFIG_DRM itself would be the safer option, but
that seems to defeat the purpose of the client-lib module.
---
 drivers/gpu/drm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index a4a092ee70d9..4f21bff6282a 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -98,6 +98,7 @@ config DRM_KUNIT_TEST
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
+	select FB_CORE if DRM_FBDEV_EMULATION
 	help
 	  CRTC helpers for KMS drivers.
 
@@ -220,7 +221,6 @@ config DRM_CLIENT_LIB
 	tristate
 	depends on DRM
 	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
-	select FB_CORE if DRM_FBDEV_EMULATION
 	help
 	  This option enables the DRM client library and selects all
 	  modules and components according to the enabled clients.
@@ -372,6 +372,7 @@ config DRM_GEM_SHMEM_HELPER
 	tristate
 	depends on DRM && MMU
 	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
+	select FB_CORE if DRM_FBDEV_EMULATION
 	help
 	  Choose this if you need the GEM shmem helper functions
 
-- 
2.39.5


