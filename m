Return-Path: <linux-kernel+bounces-181413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0C8C7B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F45B21229
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60915D5CA;
	Thu, 16 May 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffW58sF5"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA80157A5B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881518; cv=none; b=ng35Lpr4pmpA7+zQ09V72N8wGBq6YyDBXxKdLgkDoqSRcqrebWWSaFMpixftDQrb/U/DiHMy4VOb4AJqSCTMtAYIOM1pX9MZL+OubLxMwclhFfNgko/uxoiT0EQitieku0PDxNMPsq2NgpIaHHIxPR7qhu5GCeKWpKlI6fqFk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881518; c=relaxed/simple;
	bh=IDW+XAqzMf2JCNQNrwCf4kX29FMhjfrpqeWwIrdLGXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lir6PDukoDbInN99JOSeVs+eFGUMNEfFikFm27VBJswk6mWiGduvWkwbFnvDK+umpzthzgHZi19dVwBtg4TgAZUzVkYWblKzOoMky728SYZQ5ElXpGNu5A2L5MDm1uoqcBvtQ3XGPTHMmYgm3j5VHWpsQa96OnT0X/YofYK3xps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffW58sF5; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7dad81110cfso63558039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881515; x=1716486315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFPdE+F/gD/56eOR4FxQzgtphE4VEmnkP/G8x8J3yzs=;
        b=ffW58sF5bH3pR/yElTjFcLkA1Q7GTgBhbZgEjGZywS4+Bb87uExvmyzhiGWn6dg8rm
         MiMuR8H4nxkiSD/7biMMkelbltPaOwoU2Nj9VtU5LgrHWGCqnk4/N6Xxf/QUNK/E4dIW
         VaNst4KKUGVKT+KLc9x401rcLgzWo4cOlsBWsbXqs+VFHryPOmbXYLcH3jh+IeJK3t3l
         ETuQ33c78GWwJ6d3ll1mp3TPbMou9jfO+7NKT3Gnas3Qz++1GcAM62FsDu/PhBpFU3CJ
         HnOllbA4WbzDDp55tS6YiCWT8rHFC2LFl/I6jykzAT37jTzo+TaD9H7M7MC9OTdV7yko
         74HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881515; x=1716486315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFPdE+F/gD/56eOR4FxQzgtphE4VEmnkP/G8x8J3yzs=;
        b=ropVBblINczPoS1ZKaEMk+AS+2q+dTML3Y9NGnDz3tgBJELg28LC7SQ8j2mTAvc1jb
         bLJiuFdAmIr+MYgUZSlgsponFJSJ/cBai1t5hyKps6LwX89wQuUX7/l1lijIlHuTHrgY
         zuLks1vlhLNvqFsKuUs8FKz/dWWvltDpE6sf1927rsAKZaWxgeR/miGMUg7CeJyxmX+i
         MMHFO2MHPP7GIOR7Gc9aTwTzAB0T6FJKZfrkc3nS6jvTGOP2pv15DAlFVCKO28vWk//V
         MPGHVaFKlMVy98eWibExrNV7lGIgBXFGqyeRBjSjg9733QiL5wGxdZoGnSD0AT20asTq
         8Xgg==
X-Forwarded-Encrypted: i=1; AJvYcCUGDPCr0IJWv8qA4W3s0gSzNqIYZAhDfrAHPrxiglHmRRyByG+47iMBLgRz+Z0jhS3yTdX05wThX10uL5knB1gaAlrIaCXdUQ295Xgn
X-Gm-Message-State: AOJu0Yyb5uia2LOanBwpbfWaBr4uqZmZGwCnflp93Uzt0KcSuRs0JD0M
	EAU7sWrUarBfeSpRv5vjm7N6R9Xyh8GZrotALnFG34HXRjV0lArO
X-Google-Smtp-Source: AGHT+IHhwjPcza3cjyisMDtn6nSQ17rVOTRJT6FgHoSbsSj7BNYjtNHxIZaN5zg722Q4Ov58DRyqwQ==
X-Received: by 2002:a05:6e02:218a:b0:368:efa4:bdf8 with SMTP id e9e14a558f8ab-36cc14c0c98mr242198095ab.21.1715881515664;
        Thu, 16 May 2024 10:45:15 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 31/33] drm-drivers: DRM_CLASSMAP_USE in 2nd batch of drivers, helpers
Date: Thu, 16 May 2024 11:43:55 -0600
Message-ID: <20240516174357.26755-32-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DRM_CLASSMAP_USE declaration to 2nd batch of helpers and *_drv.c
files.  For drivers, add the decl just above the module's PARAMs,
since it identifies the "inherited" drm.debug param.

Note: with CONFIG_DRM_USE_DYNAMIC_DEBUG=y, a module not also declaring
DRM_CLASSMAP_USE will have its class'd prdbgs stuck in the initial
(disabled, but for DEBUG) state.

The stuck sites are evident in /proc/dynamic_debug/control as:

   class:_UNKNOWN_ _id:N		# control's last column

rather than a proper "enumeration":

   class:DRM_UT_CORE

TLDR: This set of updates was found by choosing M for all DRM-config
items I found (not allmodconfig), building & modprobing them, and
grepping "class unknown," control.  There may yet be others.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 ++
 drivers/gpu/drm/gud/gud_drv.c          | 2 ++
 drivers/gpu/drm/mgag200/mgag200_drv.c  | 2 ++
 drivers/gpu/drm/qxl/qxl_drv.c          | 2 ++
 drivers/gpu/drm/radeon/radeon_drv.c    | 2 ++
 drivers/gpu/drm/udl/udl_main.c         | 2 ++
 drivers/gpu/drm/vkms/vkms_drv.c        | 2 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c    | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e435f986cd13..066d906e3199 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -23,6 +23,8 @@
 #include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_IMPORT_NS(DMA_BUF);
 
 /**
diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 9d7bf8ee45f1..5b555045fce4 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -31,6 +31,8 @@
 
 #include "gud_internal.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /* Only used internally */
 static const struct drm_format_info gud_drm_format_r1 = {
 	.format = GUD_DRM_FORMAT_R1,
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 573dbe256aa8..88c5e24cc894 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -25,6 +25,8 @@ static int mgag200_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 int mgag200_init_pci_options(struct pci_dev *pdev, u32 option, u32 option2)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index beee5563031a..1971bfa8a8a6 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -65,6 +65,8 @@ module_param_named(modeset, qxl_modeset, int, 0400);
 MODULE_PARM_DESC(num_heads, "Number of virtual crtcs to expose (default 4)");
 module_param_named(num_heads, qxl_num_crtc, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct drm_driver qxl_driver;
 static struct pci_driver qxl_pci_driver;
 
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..d22308328c76 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -247,6 +247,8 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 3ebe2ce55dfd..ba57c14454e5 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -19,6 +19,8 @@
 
 #define NR_USB_REQUEST_CHANNEL 0x12
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
 #define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index dd0af086e7fa..086797c4b82b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -39,6 +39,8 @@
 
 static struct vkms_config *default_config;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 58fb40c93100..c159f4d186a3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -275,6 +275,8 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
 module_param_named(restrict_iommu, vmw_restrict_iommu, int, 0600);
 MODULE_PARM_DESC(force_coherent, "Force coherent TTM pages");
-- 
2.45.0


