Return-Path: <linux-kernel+bounces-570230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBC0A6AE02
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AB5987CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7C236453;
	Thu, 20 Mar 2025 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj/VfH+9"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BAB2356C0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496831; cv=none; b=mNd6BtDDcvNYk24l8DEYHT1mUk9GJLw2ByvE/U+iPCMtp2tNnfALauYAOcCd6zElBrtWVeZdG+QhuTIfYfshXXs/VKTTXLQ1yepiOpAt3jj0JViGonTXm7xHnuCDCAMWQq9Y1+bH4TDpjZOHs9aAy8LxjdEn15gZLKIpIr9LbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496831; c=relaxed/simple;
	bh=Iw6X7X1o8Q4OWKo6KS8Z9OyO79bsg4GTyZnnR/3pYmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubXD6tq/cWkGxpcx+xmAEPvjwj2vumRcLBVmJn6Q9JA7OJAD+UTfUlo6C6Aq9oJpHgVcXKbc/lSy6HDuyo48aJoXFllyR7gqNoYHDsla+JjTBKP7rXck3Q2Qw8wnnDEHeCoxtQIne/XsWS1SiG6qvvU2oJ2yN6KRiJQAS8URLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj/VfH+9; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso31257639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496828; x=1743101628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7K7xRXZftnouPQnYRpMXoKCruxhJlULif2fXsuJr/A=;
        b=Bj/VfH+9bH/BJKXL16jb+FXohPw5wPxaZTzLEooCHxDPxqLUAhMGDLviAbFMfmWUkF
         NwYONLQWj3ZGrNd2Kp7xeX/Q9fD0fNEckstH4Zfj6eAkZfKvOtzktAxjF8h5D0w7XbNl
         9VcBjzuelZrhoFBGZbqcoeX4/hg9LvqWy4mAQLW9/SmykOXGGAWH8HDDHtp8Np6FXLex
         HWAv87MxN2GHciEeluby5hzRM5uzDM2KQ3/jz6YIc+BrBYIHNXSQhmvH6Y6PLeZlX3uY
         y8olYeyWIp0KMYJlzXWVqXKhJlV9W/O8IAJil+TY3uoWnDNbJileT2S4bvZ0Q477sfqC
         qZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496828; x=1743101628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7K7xRXZftnouPQnYRpMXoKCruxhJlULif2fXsuJr/A=;
        b=HfCSrGXcDjh+sEoA3eF1YoKRco9e7TmViJwoHMean7iTyk2JofYJUvWhrwD7OPjATV
         pdrsTg8maHq42TkXaRivPZki2clVOQS7iOXvONkvIlaR4b7adSELzxzc0EaJhr68cPcC
         gxuCDqYjlU0lD8eBRfohDKt4enWZNErubbeDFPagj3WJK45eH23cX941ujmkzc9+Z2iI
         c7RGUkLMTkU/Fwud4kVVcntFVjKOHXXmPuElldsNWMnaDnUEpoES6+z/RixpnyiVl8aH
         hVrsNfREmWln6NS0ocixZRIPhNJycfu3BEkmQ7gTfcht+b+Aeege87y9yWkAX+v0dHG4
         gIVw==
X-Gm-Message-State: AOJu0Yw9MPwMrnk12nYObb6LlNF3sFrN5GJUwH/Q+RKm7oz3eKCPfspn
	1bw0r6q2iovEgHuRfxVV8xl7NMk3pA8DmmlmKwyFTeAYYR+HJXSvOUidBVzJ
X-Gm-Gg: ASbGncurtva8hf3s9afqQTNjQ7yxYoxhRxmwIe2wygWhpdphd9xLFJY8lBMNjG3UayN
	lPGWeE7TKpuguOBUCB2v0HBcxBQxrM0A02YPNWSBlDnT4gnq1/0QDfwnDYzYmMGPE6RDkUVHMAW
	+FTvl5LnilQinLp1JJOLC9a78zUSUbGlRn0tJeJzwhzrFm+AvaB1lZ2RchzUPiGGG6Eb041MQ6t
	UqFillh+qFnAOKTtagOl6UwzBte/KEIQ5a3pgDVlLh7cuhjCGaCFFyPgrdzkZxrL1sTBwPBMC6w
	uSOvmRTT4cTxr5m9vkqWDpMGepv/7r8okh7d1psLsymYN8KH+D5WV+umvn4LVIuv/6Ac6mmoaXe
	RPQ==
X-Google-Smtp-Source: AGHT+IFH7Hg90LlweLnnOLq0HO0JR4tzWTyeAt9Zt7MPpyA0RDON+RgSb3+P8+rQoDbSr9vz+Nlgpw==
X-Received: by 2002:a05:6602:3896:b0:85e:1ee9:1c18 with SMTP id ca18e2360f4ac-85e2cb1dda1mr39264939f.9.1742496828643;
        Thu, 20 Mar 2025 11:53:48 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:48 -0700 (PDT)
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
Subject: [PATCH v2 39/59] drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
Date: Thu, 20 Mar 2025 12:52:17 -0600
Message-ID: <20250320185238.447458-40-jim.cromie@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c0ddbe7d6f0b..e1367f66c4d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -234,17 +234,7 @@ int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
 
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
2.49.0


