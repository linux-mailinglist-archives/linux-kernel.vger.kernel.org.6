Return-Path: <linux-kernel+bounces-238471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CC924B33
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B1D1F24EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1111C5A38;
	Tue,  2 Jul 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I90IZucg"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171211C2DF6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957550; cv=none; b=cIPZGNcSmNnYyN/SV/4BgUpVa598LTtbLtqr0PpdAmCoXgtFsQK91P4HXddjV94XgQtxa8/noQRjGf5cvGcX5uBb09xCyg805ueFrG67MDLcHkGmuZ4scIt5aCYgs9tpiQkuky9yYo6uLnCKTB5YzRUE1aipJaZMb5FwVMD1f+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957550; c=relaxed/simple;
	bh=BACRdEKE/EdGzYnQC1ja1K39qZMWUunTQiDC4kIMOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAlUOW0goovDIfcDvMjToYzSrY/2sq7a10gS2K7MirmLo18x0Y9AddzSIvVm8tmJVAQfvf26Bj56/cephIqmB0BxJxRlVbJ086jnWCUY7EKQmiWRsuKrurKpSIv77BkdjGvRAHTTzPe/Avhz2jkxODaLfFyPcOhMdp+PMcyj15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I90IZucg; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f63db7a69cso142354439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957548; x=1720562348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5Ysg7vbItKfqIGM0QbE+cddDiZC+jdjQozEcgbAHb0=;
        b=I90IZucgT2dfZRGI6NzcVJ2Fm8V0ZgDhURVBvGv2WAoxuJxtqm5TdBhFRaQA2MMe6j
         wR+ZstRwllJ0Y9DGMN1xot3cbU/GZxQsyLv5bxn2aEcjV+8psq+MM1ftp+sBmERYW6xh
         ULg558y8LuueGSFDAAswjCRRY8Xnn35n/3QkKdALy2rjp44JfiRlx2M3U7FRjoGOQeal
         YnJcX5TDjitPuUiyvbkNVZvHxo2dsXpK79iFqEZsuL1JlrE0mKl6Q/exCAusBS7pV1d5
         pHhm1YQYhJqqj9bUX5BFh6dO4Fo+c5jPYiEqbrRg2q15G5hXi53r/IJ5qjI/n3JOrI5q
         ZnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957548; x=1720562348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5Ysg7vbItKfqIGM0QbE+cddDiZC+jdjQozEcgbAHb0=;
        b=TrF0NO4RmFJcXCdcl96sl6np7jB6iFeDGoPf/fGjNAGcGwbENVYxJjY9csagIsHYHj
         FOeIvYS0z1yPhBnKHEEzPYyTaErbANWoTRaW4X9D5FLfLJZuaIu+5U6/aWhNVQJrc45N
         gdeIGFat4bIHLXrEvUOJImmsboNTtwiLGHWdWSaqIIee91SR/p4mfvhkqW7SLC6jN+de
         VDLc7+uUPnQdW64NRzHn1BnCCqIwPqA6Au4zc83XLbpq57EzL0mELFqoxsJL4jl6Th7B
         S+VHAUNCBN9cWcKw9Ub+agoeROgWUdeXpDoCCWZe5dqJErlj1zu2bZcA5mMTy6Vr/76d
         Juug==
X-Gm-Message-State: AOJu0Yxoi6VZqJ67MSpvAyD65jsjZn1UXN6aSsrDDeN0XFVBWapm9bjs
	2ACcK4R8fHPBzeH/YMFcV7bylE8bc0M8ti6l6mmqy2S0CKjED9kc
X-Google-Smtp-Source: AGHT+IH8RzFKMibwRzTDXrCwMOD3IZhdcfxbN1Z946i9yurhqf82jrI7DF+TQJhSdQTj+9beODn4AQ==
X-Received: by 2002:a5e:de4c:0:b0:7f6:20dd:7117 with SMTP id ca18e2360f4ac-7f62ed4675fmr1103968039f.0.1719957548243;
        Tue, 02 Jul 2024 14:59:08 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:07 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 39/52] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
Date: Tue,  2 Jul 2024 15:57:36 -0600
Message-ID: <20240702215804.2201271-47-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu has 10 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 9539aa28937f..bb3a3e042264 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -44,6 +44,8 @@ static const struct drm_driver driver;
 
 static int virtio_gpu_modeset = -1;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, virtio_gpu_modeset, int, 0400);
 
-- 
2.45.2


