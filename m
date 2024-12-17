Return-Path: <linux-kernel+bounces-448748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A59F44F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E8B164F23
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310291DA61B;
	Tue, 17 Dec 2024 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q49rcR8q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3E1D5AD9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419939; cv=none; b=Cu3A6j2L98HqqsMeG8Hj/wJGR2qk6YnqYvjyNiRwRATEuBaE9sLxJpnuH4Vc8gNjo/O7sLBWyE6QWd2nxPrViQJXd3dtfsbYhQ+jO8U64iAA94Njy2vlv9LfDBeFEaXgdro1mdD+OPwLnB7SJBi3SFoQ1He/qPsQIaT8efP0ycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419939; c=relaxed/simple;
	bh=L5T8LbxEketIWtOM1IHY40+VcEiXBuxm2FKTjehvk1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VnFfbcDKmZwKFidMKkaPldHS6qT51wlzjk/H9q60CRzaGcWeWXg9ny+Oy20/nNAkKz8AmoHUJ6mt7E1sefe2aN0x6ETJUUBEbhB76EPQXBnjqQRW1b4ft73XQ758SWnE9y4PXusURLTGOjw1J83icGLbed9tS876QHPGGZpLgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q49rcR8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B6EC4CEE1;
	Tue, 17 Dec 2024 07:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734419938;
	bh=L5T8LbxEketIWtOM1IHY40+VcEiXBuxm2FKTjehvk1s=;
	h=From:To:Cc:Subject:Date:From;
	b=Q49rcR8qzY2+ZW2Dn7t0P3mPZD3oxT4iY2ItJtbsdP3NspkKVmlDT3JcmLxlVoP8g
	 u/9lGxq62lxqQ/i33bvjt/FJ3eaYLK0POsz2JbI6tBqITDYcGfY8/olzofCF+A64s9
	 /be9FmrpqHF23paiRiabq9iSqOK5kbm3bk0zXNdhcI7nbzeK9JcsYwhNfZFf3Y+Mia
	 fwgT1cTgHmY+C+HrHInTDetmqdWtRkpXzBiw/X7/E0RrrpK/Yka4GOsh9E4vlB99M4
	 OOQdH6tPwcs/UaNo5psz7futweq8Z/90h31X8cobwULrZwXEvo6ce5vm88MxqKeS6V
	 EC0dXFPRTpDTA==
From: Arnd Bergmann <arnd@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"David E. Box" <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe/vsec: enforce CONFIG_INTEL_VSEC dependency
Date: Tue, 17 Dec 2024 08:18:44 +0100
Message-Id: <20241217071852.2261858-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When INTEL_VSEC is in a loadable module, XE cannot be built-in any more:

x86_64-linux-ld: vmlinux.o: in function `xe_vsec_init':
(.text+0x19861bf): undefined reference to `intel_vsec_register'

This could be enforced using a 'depends on INTEL_VSEC || !INTEL_VSEC'
style dependency to allow building with VSEC completely disabled.
My impression here is that this was not actually intended, and that
continuing to support that combination would lead to more build bugs.

Instead, make it a hard dependency as all other INTEL_VSEC users are,
and remove the inline stub alternative. This leads to a dependency
on CONFIG_X86_PLATFORM_DEVICES, so the 'select' has to be removed
to avoid a circular dependency.

Fixes: 0c45e76fcc62 ("drm/xe/vsec: Support BMG devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/Kconfig | 2 +-
 include/linux/intel_vsec.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 6c5b665d9384..217b51468497 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -2,6 +2,7 @@
 config DRM_XE
 	tristate "Intel Xe Graphics"
 	depends on DRM && PCI && MMU && (m || (y && KUNIT=y))
+	depends on INTEL_VSEC
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
 	# the shmem_readpage() which depends upon tmpfs
@@ -28,7 +29,6 @@ config DRM_XE
 	select INPUT if ACPI
 	select ACPI_VIDEO if X86 && ACPI
 	select ACPI_BUTTON if ACPI
-	select X86_PLATFORM_DEVICES if X86 && ACPI
 	select ACPI_WMI if X86 && ACPI
 	select SYNC_FILE
 	select IOSF_MBI
diff --git a/include/linux/intel_vsec.h b/include/linux/intel_vsec.h
index b94beab64610..f2d55e686476 100644
--- a/include/linux/intel_vsec.h
+++ b/include/linux/intel_vsec.h
@@ -138,13 +138,6 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
 	return container_of(auxdev, struct intel_vsec_device, auxdev);
 }
 
-#if IS_ENABLED(CONFIG_INTEL_VSEC)
 void intel_vsec_register(struct pci_dev *pdev,
 			 struct intel_vsec_platform_info *info);
-#else
-static inline void intel_vsec_register(struct pci_dev *pdev,
-				       struct intel_vsec_platform_info *info)
-{
-}
-#endif
 #endif
-- 
2.39.5


