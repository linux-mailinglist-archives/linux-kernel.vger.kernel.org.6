Return-Path: <linux-kernel+bounces-254304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A738933199
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD63B20B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453431ACE97;
	Tue, 16 Jul 2024 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOBbYkWb"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409E1ACE62;
	Tue, 16 Jul 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156371; cv=none; b=pE2fcQJYozfIopGY7KTPDww8vp4Z6bIxRaIW9mDa/YvWJDxjJS7kQFEGLtAINj/48kXck4ljgVrPYX1cY2ehKBHqrCpvUV2bjmSp6+J8ksHCfibGh4XdxxoxjMFJVVZtk5Gb79QYou2gwGiZ0o3fCJNdJ1u/4pofOLGtCxmrbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156371; c=relaxed/simple;
	bh=ZdgkYt8StKCj0Myc4WWZURkgaMtctnUiCw+YT1im5Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5wpFZDBuWWZR8h0g85nMGxP+gvWG8rrlv9O6I2C9LQEYpDXCZc0pgtxKZueD02M06QkYL1I/RzFaIP9xtrDjdccOAFr5F18AU4XXxJYmPt8Vw/EQfpGPcvEhzUenb81Ac8zHfVvQuLbIPs3xO9DXKK6Azouwa+qYv0SV+Jx67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOBbYkWb; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7fedb09357aso5242639f.2;
        Tue, 16 Jul 2024 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156369; x=1721761169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JTbEivvcQUwAcXrAriYcuJGP77J1qAidh1sZIrKRVg=;
        b=VOBbYkWbvk1zhGeI26BmQMyZIbWRR6Nb5fTHcQpTr7vLfbHj5yWZwEuLgTzh5UNqN6
         foiuAGOxr5DKok5OoZ63hC2CgRBWHr6dBJ9mBfudZIWmym5x1/IKKb6+ITA+cAaq9pce
         HTocU58RDCpn8Paytf504l7cCaTpDmlJ9DYHfpOZDqwBLtuu8ExeRvzIIr1mywd3w7gH
         2bT109F+RlV+uTfc5p4GD9FNLJs+0cnuf10LvRrRVcq3bI8EaCJlQmfF27wBm+SYmwDg
         EMq7rnz4xBag90MmAPDWZjkgWe2KNHjcox2OJzBySxoJanJ1x86EwXjgTPX3e1KGneen
         FHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156369; x=1721761169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JTbEivvcQUwAcXrAriYcuJGP77J1qAidh1sZIrKRVg=;
        b=B6yYA4oiDTOuhe+zMeg4id7c89m35QkXbVFNoAite5N/jHlm1u975DZOonhVufZ/M+
         +i57tT7ZgPoWdRSKnnEiMJ3XrSGtMg3KtyVHcV7O9FXHG7Y4X8wEJACrc7c72IPx+Bgc
         m0Hl9EndddPoft8wGizRSiSq6RsRXmxO6vmEX/SLBDjLmmTco1NgXGD4nvLwBFfSey+C
         zw6t6dsI/zuz9tUS8EHvuWldXTinXznSP1KYw/e9/s6/TvhiwKhDxVejizWeCMByxIDU
         c2wXjt8uVI98z1Ud1ZdTJXei4UOyYiTjTfzwx6hjXq7LFkH7ZCCgUS+9MaFpovsN4efO
         EpWA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ttm6uvzQHKOBTyQuqqwYjx14fRgj0HgBNsJU/X0RnqMtO9eUo6z+abB996BETHVQzliL6fi2p35q6/Rh6ycFJPMmpqaL8q6n
X-Gm-Message-State: AOJu0Yyve6gRmIqzI0nU8371k5OpWT2C4J3E6mn2Xij8oSmbQ9NWsVzX
	XP7icSDjN4p+lH80K2VdVrGsI6hQP5SW45Rc5I2vGjcn+T9tDVFSeyZkdjO9
X-Google-Smtp-Source: AGHT+IGARWh4QxiG+Icc635bMvQOuQFO/eTfpUh5U7VRGb1JDZZ9GA0bt8iTtTyAJOTCk1Gv5ICnMQ==
X-Received: by 2002:a05:6602:6d0e:b0:80f:81f5:b496 with SMTP id ca18e2360f4ac-816c4a16988mr40830239f.14.1721156369258;
        Tue, 16 Jul 2024 11:59:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 50/54] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
Date: Tue, 16 Jul 2024 12:58:02 -0600
Message-ID: <20240716185806.1572048-51-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qxl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 ++
 1 file changed, 2 insertions(+)

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
 
-- 
2.45.2


