Return-Path: <linux-kernel+bounces-257178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF1937647
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5421C21E18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2284052;
	Fri, 19 Jul 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqPDRjLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63C2576F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383189; cv=none; b=tCJZAeIlJ3ab2NZbbrBy9/tZQMYp0bmzEs30svCGbEXjc4xZFYv2w/PTj7/GumC9X+WqeLEH62R65mU7NUXBnmWnkxq2gFrBQe6ZE4yqETYb21ZPTR9zEdPLXH8BczdeOMxxdGAf3jMGgXo6nwLFHcDl6RB6x3V2xcZrnG+djio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383189; c=relaxed/simple;
	bh=TUdgSg3QBebjxaujxPZAKNFcg3Ix1nF0LzW3aXVc0M4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z4GiJDOBfXsRLwD/oq2P9yMjnj6m5FdE5cHpEpMzTDynvN+BTabpyymF+9Lh7SKF1pAV3G0fK7DOWz6oY8OXBjAfZ8gds1gGTdtyxjxv6tw7/ZF0vVJEO4qUoEOHaxu5Kpvu8OlqmLIUjBx42XGLY3kGug3IsBVDd/dSn9J6mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqPDRjLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4542C32782;
	Fri, 19 Jul 2024 09:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721383188;
	bh=TUdgSg3QBebjxaujxPZAKNFcg3Ix1nF0LzW3aXVc0M4=;
	h=From:To:Cc:Subject:Date:From;
	b=XqPDRjLywdWgl9pdXaTwVN0aaDpTXqSg8yra0WAAtz4x5o5zzmiZKVCIp+0y+gIDZ
	 3ZUAKXF3H1CLBlsKplYrQ7DTCB2KuAicmafwds67KsHaguYKiNYHDq35Nf6WuY5t+r
	 ZGfIIiHw3u73EAPiP8bqUiJO0WlSrohhRbgkQwpWTYUfzRVNTSxNvAYfPV660owk7h
	 D/eIm6DruVumgQHPkIVHeuL+5GrU1dbErJgiv+0HCB3TEBEchhbD7p3IqPuSOxHG8e
	 hKLjwEm10acQtz1nCN9AVq4Ko8v5cKch8f7VcujpIFslMruCi5/GtapqL9nEBBsTqL
	 oy8bXfNpEmpcw==
From: Arnd Bergmann <arnd@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Tony Lindgren <tony@atomide.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/omap: add CONFIG_MMU dependency
Date: Fri, 19 Jul 2024 11:59:31 +0200
Message-Id: <20240719095942.3841009-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing with CONFIG_MMU disabled causes a link error in omapdrm:

arm-linux-gnueabi-ld: drivers/gpu/drm/omapdrm/omap_gem.o: in function `omap_gem_fault_2d':
omap_gem.c:(.text+0x36e): undefined reference to `vmf_insert_mixed'
arm-linux-gnueabi-ld: drivers/gpu/drm/omapdrm/omap_gem.o: in function `omap_gem_fault':
omap_gem.c:(.text+0x74a): undefined reference to `vmf_insert_mixed'

Avoid this by adding a Kconfig dependency.

Fixes: dc6fcaaba5a5 ("drm/omap: Allow build with COMPILE_TEST=y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/omapdrm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/Kconfig b/drivers/gpu/drm/omapdrm/Kconfig
index 3f7139e211d2..64e440a2649b 100644
--- a/drivers/gpu/drm/omapdrm/Kconfig
+++ b/drivers/gpu/drm/omapdrm/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_OMAP
 	tristate "OMAP DRM"
+	depends on MMU
 	depends on DRM && OF
 	depends on ARCH_OMAP2PLUS || (COMPILE_TEST && PAGE_SIZE_LESS_THAN_64KB)
 	select DRM_KMS_HELPER
-- 
2.39.2


