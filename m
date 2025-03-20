Return-Path: <linux-kernel+bounces-570250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63638A6AE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B78165A63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057924C66A;
	Thu, 20 Mar 2025 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTQfTeRS"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883624C062
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496854; cv=none; b=k4t4Sbr1PBvYVBItDQNui9UX6sRBcB7wHOidOP1zupEkM/8LniyVDVh9JK8VYxOc3Nl9uf7bjFhguP6GWBnNapVD9gKpm/kI840NPWhf1lbCu87/ijCPQC+T/aPig1MtFpZfprR3WMXhPgR54pdjcIbtzvkcu0pK4lpk+n5fh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496854; c=relaxed/simple;
	bh=ysvtgpv8Lzoof+7How0DiBM+y+vEotUTIOC5+Z4md5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU0BgX2+f/7vCHwS0FvLpplv1q1XX24lbTqibpohwO8Q25DY2hd0lpo77DxT0iB0RL1HApJ7L6tUJCj1RVjiwEFQgMMA2kkq1hgk6fRHB6GStd6kWMfa/VS/DPKry02N+z/dcHcqwl7VnwIP8dzuCEnD6jgzCN+0fHifUK32vvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTQfTeRS; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85ae4dc67e5so58339539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496851; x=1743101651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmamZMwYgFpi0j7+3VuOLzPrfkXXmhZ2avEG64/SS20=;
        b=MTQfTeRS+/Q1W0wvLLzdrz22NJUiFN8iGORy9jhGbnaYou3vNBIdENgcvxGe3a+wX9
         gGlZBPWolcAq+2Rcc2rB644qpuAsg8+1bdMKABIyy1G/VBkfvU2Lke/3Z04d6scKHXVM
         f1JfioyJaxU35ll6uZnaGMZbefVzQ5np5maCqG5E4wIh6/jcY06LNvrluIaEG911CpCk
         X+aTYX/582QppkQMbSwGLouANJnJClV7XPP7Z9Anc5Ke1GR/0e+Gce9uqlz6lDA/49IL
         H4L0y41okN44r5BV2V05z9+dAojpnkFoG8trOo2rj1RdLRolxndPFKII85qXIEZ+9HNZ
         iXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496851; x=1743101651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmamZMwYgFpi0j7+3VuOLzPrfkXXmhZ2avEG64/SS20=;
        b=i57L+cP9XiGbMOtfJjP2jZp6Q0AkOtR0pI3Mf+YZp+7RFfU5N1F/QQkl6AM1JUJMRA
         ykO8qL8dizqoK0IDxr2m9PcqU7543/qUR9FWIqEK1B93tcVOAzuRisPz6IOh5Qlmd8h6
         N690JSqduYCBbHhcdBrnHDRqE5shXD1uHBnIIgyWmJLpo0+my3L/TCca+6o5fd5ReJ0S
         dmptzjm8SoVJPyZxcwdwkN491USNfbm0BcgfRh3HOrBtrWTTZU61fh5hoa88/54iuwif
         FX2il7r0ef8Cgg5YWeccoSdRkk0ICoeobigcRYgxoCgrHQgq0KNYmyxkoUXnMJvdbnXi
         GF/g==
X-Gm-Message-State: AOJu0YwGGw739lwBX3YBsVuE/VvcS2nIfDhkqN8bErQxonXoqI57PM5f
	J6owkhEQgJtpSC/jvBGp3AiuwnZoyZ4v2CXyRes+HP0Wsaz1kNAjX4npGaaX
X-Gm-Gg: ASbGncvd7EYNg4o4pBNRIlwozaLwX4d8AHdP5BPR8n6RTeFLAntQ1rcC8IMwBuh7lyG
	iIcA9YqMxnHaS8oJ4/nj5bvrZ9Lq4tNU+n1ksAJQ8zifdvyIffBBVl69WpD+qXeEn2HsYMVWfK6
	Q5TvTek0wxw64BLgM7wHNdiEKsRdkci01IlwElrdceh4p9OLmMb//W772S52M4kTYWHqudJontK
	H5qIyaB1noL1uMLwuoKUXUqVlEnhJw1zpaOEO6/ggXQ/Qn31Hi9D/KFZSgX1+1Dij7g24g9kVuo
	XDubezTqPfOhhtHnI1iTsQRIZzP+hNft5F41UkjFm7QIfoI3u7Rqg2+SQm3WA2Pcm3W+f4UGl/t
	3Xg==
X-Google-Smtp-Source: AGHT+IEyrbzWzNkR3QwCwlCn6oXouTTauTHLnXeGSIezaRONhT+4uCAGUm+vEaKPMsebN3xP2W4/iw==
X-Received: by 2002:a05:6602:380a:b0:85b:4185:1f91 with SMTP id ca18e2360f4ac-85e2c8f7201mr53612539f.0.1742496851514;
        Thu, 20 Mar 2025 11:54:11 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 59/59] drm: RFC - make drm_dyndbg_user.o for drm-*_helpers, drivers
Date: Thu, 20 Mar 2025 12:52:37 -0600
Message-ID: <20250320185238.447458-60-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new drm_dyndbg_user.c with a single call to
DYNDBG_CLASSMAP_USE(drm_debug_classes).  This creates a _class_user
record (and a linkage dependency).

If a driver adds this object to its Makefile target, it gets the
record, which authorizes dyndbg to enable the module's class'd
pr_debugs, such as DRMs <category>_dbg() macros.

So Id like to automatically inject this object into drivers.  I tried
subdir-objs-y, but thats not a thing.

In drm/Makefile:

Add object dependency to drm_*_helper-y targets:

  $targ-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += drm_dyndbg_user.o

Attempt a foreach:

  to add $driver-y += ../drm_dyndbg_user.o

this appears to be a train-wreck for impl reasons, but it describes a
want/need reasonably well.  It might not be a good maintainble idea.

Explicitly adding to radeon/Makefile worked:

  $radeon-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += ../drm_dyndbg_user.o

But doing this is just as per-module as just adding the _USE()
explicitly to the main .c file, which is less magical than make-fu.

Also, it appears to cause make && make rebuilds.

and try to link it to helpers and everything

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile          |  9 +++++++++
 drivers/gpu/drm/drm_dyndbg_user.c | 11 +++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_dyndbg_user.c

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 704f94efc804..1adb5a262180 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -74,10 +74,12 @@ drm-y := \
 	drm_vblank_work.o \
 	drm_vma_manager.o \
 	drm_writeback.o
+
 drm-$(CONFIG_DRM_CLIENT) += \
 	drm_client.o \
 	drm_client_event.o \
 	drm_client_modeset.o
+
 drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
 drm-$(CONFIG_COMPAT) += drm_ioc32.o
 drm-$(CONFIG_DRM_PANEL) += drm_panel.o
@@ -111,20 +113,25 @@ obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
 drm_dma_helper-y := drm_gem_dma_helper.o
 drm_dma_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_dma.o
 drm_dma_helper-$(CONFIG_DRM_KMS_HELPER) += drm_fb_dma_helper.o
+drm_dma_helper-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += drm_dyndbg_user.o
 obj-$(CONFIG_DRM_GEM_DMA_HELPER) += drm_dma_helper.o
 
 drm_shmem_helper-y := drm_gem_shmem_helper.o
 drm_shmem_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_shmem.o
+drm_shmem_helper-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += drm_dyndbg_user.o
 obj-$(CONFIG_DRM_GEM_SHMEM_HELPER) += drm_shmem_helper.o
 
 drm_suballoc_helper-y := drm_suballoc.o
+drm_suballoc_helper-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += drm_dyndbg_user.o
 obj-$(CONFIG_DRM_SUBALLOC_HELPER) += drm_suballoc_helper.o
 
 drm_vram_helper-y := drm_gem_vram_helper.o
+drm_vram_helper-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += drm_dyndbg_user.o
 obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o
 
 drm_ttm_helper-y := drm_gem_ttm_helper.o
 drm_ttm_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_ttm.o
+drm_ttm_helper-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += drm_dyndbg_user.o
 obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
 
 #
@@ -149,11 +156,13 @@ drm_kms_helper-y := \
 	drm_simple_kms_helper.o
 drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
 drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
+drm_kms_helper-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += drm_dyndbg_user.o
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 
 #
 # Drivers and the rest
 #
+subdir-obj-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += drm_dyndbg_user.o
 
 obj-y			+= tests/
 
diff --git a/drivers/gpu/drm/drm_dyndbg_user.c b/drivers/gpu/drm/drm_dyndbg_user.c
new file mode 100644
index 000000000000..9e4aa87d4b58
--- /dev/null
+++ b/drivers/gpu/drm/drm_dyndbg_user.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "drm/drm_print.h"
+/*
+ * if DRM_USE_DYNAMIC_DEBBUG:
+ *    DYNDBG_CLASSMAP_USE(drm_debug_classes);
+ *
+ * dyndbg classmaps are opt-in, so modules which call drm:_*_dbg must
+ * link this to authorize dyndbg to change the static-keys underneath.
+ */
+DRM_CLASSMAP_USE(drm_debug_classes);
-- 
2.49.0


