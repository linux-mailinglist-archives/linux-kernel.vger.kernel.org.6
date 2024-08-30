Return-Path: <linux-kernel+bounces-308470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB3965D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E730280C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F90175D29;
	Fri, 30 Aug 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Gv1wHL/D"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2149625;
	Fri, 30 Aug 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011175; cv=none; b=hsZJpn25YZak9qmmUBVvjEuQYlR9H0VVegqeb1jUUHWiROjxFWpal0ru5g6YMi9QiG2ta9wefpvMmKJzFQeYKrjOc9OQ0O5V7Gqkq/zNnFsDkAThlLve498Xxh6O2aUP79x2kaOzCsCpHx+a/cfAgYnniEakKAot8nx0Qy2Da+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011175; c=relaxed/simple;
	bh=f2u18U78PGc6vCLjwSxdZlzpzyLhmRleTuFw0CDjKSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bpdOMubQ5X301cyuX/xb/zckViZG3an6CeskRbiEXSqaSv4RtufuQ98AgXsjhQJW0/9H4WhUyoCTQtVrnDrydYtRxA1dKQEWDHT9alBKCrCD04NAHSJfZ7ZsSehE+NOsI/zxfF9SsIKSBUo4XfOfif3W1/DK5sjDyl6RIh38pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Gv1wHL/D; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725011169;
	bh=f2u18U78PGc6vCLjwSxdZlzpzyLhmRleTuFw0CDjKSo=;
	h=From:Date:Subject:To:Cc:From;
	b=Gv1wHL/DYorIvqIofEcjqy5UMbyvU+wFcvn0/aUdOjo1Oz0zVX4KaNsfKlAlEGpvv
	 jPUneDRnpv3MvpCvBI+NFIhm1DfPkIGmgSoPnoWw/mJxKaj4uWIrnUDTZWdP7DAcv4
	 dfXuGaimarSeCtc8IpvAcjEj3i/Vb1g6MHjneSHo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 30 Aug 2024 11:45:57 +0200
Subject: [PATCH] fbdev: Introduce devm_register_framebuffer()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240830-fbdev-devm_register_framebuffer-v1-1-6d4186519c68@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANSU0WYC/x2NwQqDMBAFf0X2bCBRsdpfkSKJvrV7iJaNlYL47
 w0e5jCXmZMSVJDoWZykOCTJtmZxZUHT268LjMzZqbJVY7vaGg4zDpOJo2KRtENHVh8RvsxQ0zY
 P9JOzdeg95cpHwfK7D8Pruv4uF5RhcQAAAA==
To: Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 intel-gfx@lists.freedesktop.org, 
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
 "Saarinen, Jani" <jani.saarinen@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725011169; l=3061;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=f2u18U78PGc6vCLjwSxdZlzpzyLhmRleTuFw0CDjKSo=;
 b=Mz1jJr3pHf9RMWLe6E/G+EHhq5gmfD2w28fH7mzcTv9RaLymYk6C8XPHHMAV96BTAWmMNkwPS
 gjySbQr5RlCB+7Xco6NBHo1jsoIUjMZ884OBXGoj8Ms2QKgTPED8k1F
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Introduce a device-managed variant of register_framebuffer() which
automatically unregisters the framebuffer on device destruction.
This can simplify the error handling and resource management in drivers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This is a fixed resend of [0], which was broken.
Thanks to Bert [1], and Chaitanya Kumar [2]
for reporting the issue.

[0] https://lore.kernel.org/lkml/20240827-efifb-sysfs-v1-3-c9cc3e052180@weissschuh.net/
[1] https://lore.kernel.org/lkml/20240829224124.2978-1-spasswolf@web.de/
[2] https://lore.kernel.org/lkml/SJ1PR11MB612925C1C533C09F8F62F7CBB9972@SJ1PR11MB6129.namprd11.prod.outlook.com/

Helge, I didn't document the function devm_unregister_framebuffer() as
it is only an internal helper and will ever only used by one user,
similar to other helpers in fbmem.c.
---
 drivers/video/fbdev/core/fbmem.c | 30 ++++++++++++++++++++++++++++++
 include/linux/fb.h               |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 4c4ad0a86a50..3c568cff2913 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -544,6 +544,36 @@ unregister_framebuffer(struct fb_info *fb_info)
 }
 EXPORT_SYMBOL(unregister_framebuffer);
 
+static void devm_unregister_framebuffer(void *data)
+{
+	struct fb_info *info = data;
+
+	unregister_framebuffer(info);
+}
+
+/**
+ *	devm_register_framebuffer - resource-managed frame buffer device registration
+ *	@dev: device the framebuffer belongs to
+ *	@fb_info: frame buffer info structure
+ *
+ *	Registers a frame buffer device @fb_info to device @dev.
+ *
+ *	Returns negative errno on error, or zero for success.
+ *
+ */
+int
+devm_register_framebuffer(struct device *dev, struct fb_info *fb_info)
+{
+	int ret;
+
+	ret = register_framebuffer(fb_info);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_unregister_framebuffer, fb_info);
+}
+EXPORT_SYMBOL(devm_register_framebuffer);
+
 /**
  *	fb_set_suspend - low level driver signals suspend
  *	@info: framebuffer affected
diff --git a/include/linux/fb.h b/include/linux/fb.h
index db7d97b10964..abf6643ebcaf 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -601,6 +601,7 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 /* fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern void unregister_framebuffer(struct fb_info *fb_info);
+extern int devm_register_framebuffer(struct device *dev, struct fb_info *fb_info);
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
 extern void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx,
 				u32 height, u32 shift_high, u32 shift_low, u32 mod);

---
base-commit: 20371ba120635d9ab7fc7670497105af8f33eb08
change-id: 20240830-fbdev-devm_register_framebuffer-647e9c103b9a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


