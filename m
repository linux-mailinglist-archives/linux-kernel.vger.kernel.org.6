Return-Path: <linux-kernel+bounces-443319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF49EED28
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595E1167EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD002210D8;
	Thu, 12 Dec 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0xmnt6r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340A217F46
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018008; cv=none; b=jRJOEyWL4/esnaQUKko3mKeWvhkcQX6p4Fv9RHIR7+MZxwQvZS6+8b+cMVi0ajF+bLiWRW9pwfxGmPyq/fjhI8sGLD8h6X7JfihnlH7VmQatxLb5usklLG3gF6A63axLO80mFYM5hB742rhD+GGVkPPZCyzzwypPGYvcTfMUyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018008; c=relaxed/simple;
	bh=aRKXXlVvbGjmh5A+HdJrSujq5fMFWNfh7Xt/6YwYcF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZvgPwVif+vEIm0WdysO0whrTUJg4y213Jos8wvzIPtdk63daI8NzFvm7vURCyMLucssZTyo7JG8lmeGdOjS+5ilWCDmkTq+vNVjpxjw5fu6HTMSo0L/BC9SbspWOImU1lLkSMvTG5zZ0QEyvIPu1cRqH+OShZfkNU9uvx08UMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0xmnt6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B7CC4CEE2;
	Thu, 12 Dec 2024 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734018007;
	bh=aRKXXlVvbGjmh5A+HdJrSujq5fMFWNfh7Xt/6YwYcF4=;
	h=From:To:Cc:Subject:Date:From;
	b=Q0xmnt6rZpwAtD5n9ViAEkWAC3irVnIX4WZQnUaOO4mlkGExsMYKbsxUo4lghR4VY
	 mlgww7v5IWseQTJXU4Q2SqlKvMJQp4xzA7OpLfkCuYdrt2MO6sGwCesTBu6cOMfeUX
	 qg+hhAbA1ZBJfX/7aqGAu1hph3fi0KNSZSJr/FZ5SpFDKSO/n0zSmAmbDRXpcvxROC
	 FkwK8Ba5c6gY4JID4DKM/kzRRJC1C8aNKk1fPncv8BtQP1FOenLZSVH4ujPn6cTGYE
	 esqwELwPgVoT5V3f2rDUccMdFYybULluoqTekQy291yaEe5txPPBK0ILGFiGiFnSt9
	 ss+m8CTwOwpsg==
From: Arnd Bergmann <arnd@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	John Ogness <john.ogness@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/log: select CONFIG_FONT_SUPPORT
Date: Thu, 12 Dec 2024 16:39:50 +0100
Message-Id: <20241212154003.1313437-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Without fonts, this fails to link:

drivers/gpu/drm/clients/drm_log.o: in function `drm_log_init_client':
drm_log.c:(.text+0x3d4): undefined reference to `get_default_font'

Select this, like the other users do.

Fixes: f7b42442c4ac ("drm/log: Introduce a new boot logger to draw the kmsg on the screen")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/clients/Kconfig | 1 +
 lib/fonts/Kconfig               | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index c18decc90200..7b81fd0f4cae 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -77,6 +77,7 @@ config DRM_CLIENT_LOG
 	select DRM_CLIENT
 	select DRM_CLIENT_SETUP
 	select DRM_DRAW
+	select FONT_SUPPORT
 	help
 	  This enable a drm logger, that will print the kernel messages to the
 	  screen until the userspace is ready to take over.
diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
index 3ac26bdbc3ff..ae59b5b4e225 100644
--- a/lib/fonts/Kconfig
+++ b/lib/fonts/Kconfig
@@ -10,7 +10,7 @@ if FONT_SUPPORT
 
 config FONTS
 	bool "Select compiled-in fonts"
-	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
+	depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC || DRM_CLIENT_LOG
 	help
 	  Say Y here if you would like to use fonts other than the default
 	  your frame buffer console usually use.
-- 
2.39.5


