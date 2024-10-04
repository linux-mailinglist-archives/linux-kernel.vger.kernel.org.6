Return-Path: <linux-kernel+bounces-351423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C79910E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9671F22EEF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45411ADFF7;
	Fri,  4 Oct 2024 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssunGc54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133B231C8B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075059; cv=none; b=Fs2QrxZO+o4rH0LqNjKo+n+FOMbKzbdxuWUVFrYZqP96ERbQ/AOmWZCCeoHu7vqJ0vq9UuZrNR9fbB7/PUERWuogLWHfBVe/cfZHDhbNGcGwUCvcs8vcdnl6ONYMvC63ePHnvTaAQ88tpcpTXXvhTpn3sEqjFGLcVUcdeR7fDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075059; c=relaxed/simple;
	bh=UBMO/CJwcVxp6gwu2q8OsQBUbBql585BseXSfGZoxWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a40Dce5PCXysPomFkfIJ8uQ3rjLtsmL+Tq0te2PvspPOPNP7NzCehLBzAut6iVuK7Ke5UWeg2j/XR7308f89RDg/2R7gVJOwIa1gdr84LnvtLs/D57gNQydC207z/3MqrDEiJUgXkXfLiga9Zoj6ddQLpStfmVs4v0vZqwWX/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssunGc54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0C9C4CEC6;
	Fri,  4 Oct 2024 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728075058;
	bh=UBMO/CJwcVxp6gwu2q8OsQBUbBql585BseXSfGZoxWw=;
	h=From:To:Cc:Subject:Date:From;
	b=ssunGc54RTKxmty38LstRzYO8SrL34yq9GlQOuRgtYnO7KdBDinrJnzM/tbp0jnSN
	 ddbAnDU3WkrPUmp6iTiXKUmNEpEz7OxqOOhca0MYvDN3Qs+E5v4dohk2xKJFUWkRPp
	 +UaL7ablghfMXdKy0C0OyB7hhUI2cL6ixFosdyRB+heZrXM7XV5N1ri8x/u16/cnGv
	 ga2p40GiZ1O2KT5zEVJFBTmj/4u5HIQc3Sj6m9SzvxnrUTf7B+c+kGI+EqQ9JM6nIW
	 ZhXYQLbR4ru3ayRVARUAFbz/mZVfccprOS2oB9sy0bI/B/EUG6neIwf/k6Q71TQPff
	 zmDnK75+uLDoA==
From: Arnd Bergmann <arnd@kernel.org>
To: Zack Rusin <zack.rusin@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Martin Krastev <martin.krastev@broadcom.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vmwgfx: allow building with CONFIG_HAS_IOPORT disabled
Date: Fri,  4 Oct 2024 20:50:34 +0000
Message-Id: <20241004205053.1068629-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The older version of the vmwgfx driver requires port I/O in order to work:

In file included from arch/arm64/include/asm/io.h:298,
                 from drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:28:
drivers/gpu/drm/vmwgfx/vmwgfx_drv.h: In function 'vmw_read':
include/asm-generic/io.h:626:15: error: call to '_outl' declared with attribute error: outl() requires CONFIG_HAS_IOPORT
  626 | #define _outl _outl
include/asm-generic/io.h:663:14: note: in expansion of macro '_outl'
  663 | #define outl _outl
      |              ^~~~~
drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:692:17: note: in expansion of macro 'outl'
  692 |                 outl(offset, dev_priv->io_start + SVGA_INDEX_PORT);
      |                 ^~~~

Change the version check to hardcode the v3 version and remove the PCI
ID for v2 in configurations that only support v3.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 2825dd3149ed..dfb4b2ba23c6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -262,7 +262,9 @@ static const struct drm_ioctl_desc vmw_ioctls[] = {
 };
 
 static const struct pci_device_id vmw_pci_id_list[] = {
+#ifdef CONFIG_HAS_IOPORT
 	{ PCI_DEVICE(PCI_VENDOR_ID_VMWARE, VMWGFX_PCI_ID_SVGA2) },
+#endif
 	{ PCI_DEVICE(PCI_VENDOR_ID_VMWARE, VMWGFX_PCI_ID_SVGA3) },
 	{ }
 };
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 3f4719b3c268..a2fda4d43b4e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -655,8 +655,11 @@ static inline struct vmw_fpriv *vmw_fpriv(struct drm_file *file_priv)
 /*
  * SVGA v3 has mmio register access and lacks fifo cmds
  */
-static inline bool vmw_is_svga_v3(const struct vmw_private *dev)
+static __always_inline bool vmw_is_svga_v3(const struct vmw_private *dev)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return true;
+
 	return dev->pci_id == VMWGFX_PCI_ID_SVGA3;
 }
 
-- 
2.39.2


