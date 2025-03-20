Return-Path: <linux-kernel+bounces-570234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E5A6AE06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CAA4A2B18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293C23A9AA;
	Thu, 20 Mar 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMmvUFzn"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BB22A4ED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496835; cv=none; b=BUA55RGg1+kYL6vQFRoVJ31JZeeqNZ67M0N7vElF1SC9piuITOo6gOmH+55mgP4+NUZysXPx/dNcIL5iuSV+XFkOKE5CnfQIIN6JI7nrayRsheJ/0gGQBFP9oRnKovN5VDFu3CwLuijFSr+RY+EkodG2tI6/d0xdW8X9STE5+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496835; c=relaxed/simple;
	bh=Sjq+8vveQ+GMspa86ZhuQnE/poHCKuBjtOobvctgQIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3H1V+Hj5+liDd1ivasrENGD7HyhLtutb6aRIUxCctl61o9Astxtf4AkGXQwr1TCpFwFFAG3pfKOdaXVvlsDUO7dITY5Ju036r7sC2eaGmRfjmXN20JcIPhg94JwysdVL8z/EjRa9yz3MdEMt1WlGha9oAL1nw68vxbhZiT6cnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMmvUFzn; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso13782739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496833; x=1743101633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH1+tp+xqUGCykXZdLvGRvCsZKn18R+wsUvu6RBydR0=;
        b=QMmvUFznZuRr+34DKOOjxR9xUQQMZqRA+mY64Rzv1wJNCZ9hFMpvC4K+yWBmf4q5xb
         1HTccyxDfBOGMiuvx6R75dO+rWme8h6tQnInaXKeIN6XciSvXwf20dFHRQfI5kHMM2aI
         6fgu8VYr/qrCCzgVslLGyhsTCMYLib/m6Ahy0gejMMO/dVI238nKcnfOWevdsUV6ikX0
         RD88dZfNs7BcFD5ikEf0gvHIyC9g0H+WD/vXOwn2dVnXFA900Y7CdDWZ0uZ/syJukLNI
         0oAazv1j3swnUhOfJFy/bha3xvHNIht5GIFCtUr7nH0BXMb9Sj+6UN2rpWjgffKx5VJk
         yvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496833; x=1743101633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PH1+tp+xqUGCykXZdLvGRvCsZKn18R+wsUvu6RBydR0=;
        b=nu6a/uiwnL6yhdE2kRm39QMYliRnETfpVAzxbhKk9W3djAoQ8HkGHKMAclStmBEooO
         g8wXlxk1uAMM96VwPEfcQfyL+HLA9wU1Y/sti0MQCkStUHqERI5Hu3/maVPlnCo3fXwS
         RNjvh26QhywSryfuHOtZlXyY8uhtzXQZ4ofJGoQWfI3/xeAmiuuDs/oCf9uHwDoBz0Oh
         e+HhzbDfdRorHd+YRe9Az/oYYm/F5NUB1+TZhdvp8btrIWo7lSOYRlSyzwq14h/CPNwJ
         GgDgsWPLP4SrEohRZsy/dnB8BXx0y2WYSQ7ai4oXDK2o6gWLdaPbmn2hJua4Lk/QmVAm
         ft0g==
X-Gm-Message-State: AOJu0YyIA3c9z9K7dfCtOO1yehvkjNO3pywQddusoZCbbkR+DnwHeij7
	JqrgoKMQwd+cyElQ63Jbd9ZTawASkrlkB4Hx3/omRXN5JJ6vwX4gTUZ/UZq9
X-Gm-Gg: ASbGncsx15tm+qNxyDUm/k7BFe92k2gLqvogMZmFauHyDV7OQRn0V1M0BnHO9H8NeTX
	HykLsq7Trru57SG8utCX2aqQJwR+z5cE2f7dx4uZoRs6pVMFjARBonoN+eHq3pyZwmP6Bbn4BLm
	+uBKTjT6fXhYvFzqHP25j1nNiGN53xarF62/EMGShXlXM/KQJXNO986zOet77oJVQOzadS/eG0E
	6Bx7TgwtgZ6StsAXPSOKzVZv7pS+//t6BxKIFGZHuRQp8vz/0CoPciQTubwEDOTip13w0AREQI+
	oFUNgt7SZdXPx5qeQCBeVGimIB7W5PTweNvQB1UV8SLYZJn1PUfsp2AdCLiuBoJY9XFhWo1R6Uq
	ydQ==
X-Google-Smtp-Source: AGHT+IERrpcV67cSumqUx8Ys7+zY1a9PbB2qOVJ7aGj8lv1MneNGgrFe8EVAoLmayS6rXv/6VpfxtA==
X-Received: by 2002:a05:6602:4142:b0:85b:3407:c8c with SMTP id ca18e2360f4ac-85e2cb0f65emr41157539f.11.1742496832935;
        Thu, 20 Mar 2025 11:53:52 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:52 -0700 (PDT)
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
Subject: [PATCH v2 43/59] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
Date: Thu, 20 Mar 2025 12:52:21 -0600
Message-ID: <20250320185238.447458-44-jim.cromie@gmail.com>
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

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5664c4c71faf..bdecd27efabf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -74,17 +74,7 @@
 #include "nouveau_uvmm.h"
 #include "nouveau_sched.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 MODULE_PARM_DESC(config, "option string to pass to driver core");
 static char *nouveau_config;
-- 
2.49.0


