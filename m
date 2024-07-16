Return-Path: <linux-kernel+bounces-254286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB8933175
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7082820B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D111AA37C;
	Tue, 16 Jul 2024 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr/H8O0c"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8351AA346;
	Tue, 16 Jul 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156348; cv=none; b=i4j5CE2mvmJNprvYJicKZYaL7JNRVARWARqG12O8X3igRWo1FvxxP6kz47UjgKVaE5zv/MRe+Z2phah5IW5Nm9VXbQ0KRt0EJVqKebT4gZqUfhOXEMOLrCXVDDgk44yp4PFoZckYNydsJ/Kaoj4pXm3mxYDCV608U4NsMOulRP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156348; c=relaxed/simple;
	bh=a3i5ykbtpUblqWtNGFzaAe8Bc7wDaK61y9Dw8nUw3n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxBz76eaVv9sT5ilI1eMWIDojxYVEuKj2S3iWvLbLHmzEvkNV34ZegstXvsy/oylFZZOJgeRTGjzJ1/LJGQcZb6/1qMHqliiFP6h9uIZS39UtuaOCpsyl7rpaj0x248uvWWdXArQsmETuIMbGDrgvwCfVBgNqxn01PEwiilpRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr/H8O0c; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7fb93b2e2a3so4689839f.1;
        Tue, 16 Jul 2024 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156346; x=1721761146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA7EEvNcqBzVLrMMb21MWcD/ne6Fagi31tYXyTCW1gg=;
        b=lr/H8O0c2s+pm0t/w/L3PRU9HO/HWtBWiSbzhVke1xiKjDsworUp6y6RwblXMEYQaJ
         MTCV782zb5iqDcna8r9VbcBqOYbY5DJfch5ZOjCy8S8SCxl6wfsy0+vvHzardl7tOUmX
         rl1ut7g37lOedc02NhAJCAtEfQrBJQka7GJdwDHo/pQqu0cuJjTeDA6siv+5uR88pytP
         3sSNsbyCMRI4rralRJLvOfZC01MVc0OWd6fAH2v5Fl9nmH1JUDG4mY+LrzcebB3Ioy+S
         NLnjvoMOdnU8L80sIs8JNxOkdXkLnZnQXaH1K40Rn/Br2wmxCl0Nf5N8yDchTPH9cAwk
         jpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156346; x=1721761146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA7EEvNcqBzVLrMMb21MWcD/ne6Fagi31tYXyTCW1gg=;
        b=CR0hR051+m4n9oimv4bCixMXWacKnKbNhr7IYCWSX4TSqBoR0DI+mS5fiLGeu9zS9r
         nXIN9SHBJefuCUpD8Va+pcQh5GYdhY/2mEy6uHWOdU/PnxNztOC18CsDaMsesI7bqCSG
         s0gwsGOIFia+aHN5oRlzSd+qKJdlbR9vomezTA0k0jECZ+4ExcdceTCyV2mSEoTYgzE+
         Yfe6aV0RJI0GMQGsmpXvyUYxxvh6J7zmX3maUUYYyHXDkacOcSYA2MKmypYoXgNhcBYz
         FgvABQooyCjBVpgQP4/S4EShPy1dc5jcLtik0gXfRTSa3/V7ecF6y1j3289xwuuR29yU
         HN9A==
X-Forwarded-Encrypted: i=1; AJvYcCVYOhcs+FeSHVID+464aHWkHySOCvo9tQsgBQLBfOrZD6OMsRtnIkWac/CjBmrkAcD0ppGZNIz0UGDx+OdjumTFftYf8zABiehU
X-Gm-Message-State: AOJu0YzjYhxC0iimzzlxM/+IXsV62UhmD5GPVNmPh5G1pNwqqcPEYJ2j
	T6O8PWi7ZTJjLH9flzQMkbH+5NSCXAIp+HeZH32F1SftF5H1au4J/eEmBu5a
X-Google-Smtp-Source: AGHT+IEhC47yLHdZQK/ojVAnON7EakJJDxnjzB59bSxRuEzqdArkdfVAg42BfhkcRtZiTR0u/zHvDA==
X-Received: by 2002:a05:6602:15d3:b0:806:f495:3b34 with SMTP id ca18e2360f4ac-816c2a1fbfamr43897839f.2.1721156346283;
        Tue, 16 Jul 2024 11:59:06 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:05 -0700 (PDT)
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
Subject: [PATCH v9-resend 32/54] drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
Date: Tue, 16 Jul 2024 12:57:44 -0600
Message-ID: <20240716185806.1572048-33-jim.cromie@gmail.com>
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

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ea14f1c8f430..83763d37566d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -217,17 +217,7 @@ int amdgpu_damage_clips = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
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
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
-- 
2.45.2


