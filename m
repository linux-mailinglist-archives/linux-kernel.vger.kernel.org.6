Return-Path: <linux-kernel+bounces-570231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C3DA6AE04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EA7987FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3252237194;
	Thu, 20 Mar 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mljS7HPb"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968C235BF9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496832; cv=none; b=Kr3uncDLWMA0qBAUg4w/XIJAI/GCfPOwHKR+ZnLoCTTvtEPnMx7pdD62wwQ4K4Nd1H0opENoviKXXlixRV7AEZyZHYeHsRQ45o8MWTXjk+i72dLLGqQjsUGEbszpcCPbgppRw2LG2DV68RGdnU47m4OTLW2uwf21Sn67oAsKKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496832; c=relaxed/simple;
	bh=f6e5pgnhcCDXnL0kFMpoyoVtZuv6mQ9PZJZDclqFcKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8oVpUCMGkbguaxyl2Yxg0Zxh0pQTqLNqCTEloq31Suitw9iEnd4H7ucOpZTcNLgbISuEWUAoQ5hNwL7n5HnLrG08/C0f8El2VkJfNayu78hhPQmrc+JZLslBSRAdrcGVDQ++9/UhMC2EpUazyG3D4TdGL28oG7anyCvklnwtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mljS7HPb; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85db3475637so76883639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496830; x=1743101630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1gVL5lJAtRX3Sj7ZSt43epD+xZQUqg7ig8oqq/1rgA=;
        b=mljS7HPb27NPOvV9aR1dO3rKPK8eXFcoP2STV2VLUfdt8PY7pcSKn2+s7fhiRtksyJ
         /Msuj5im7SVGULdHU2BP4v2KeXMDPHKzvKk9zWHXzF+bSIegYurgPjemH4+QG2rVP5vq
         nfSzXc0DRSe+IakHHg0TOykkor/snvlqIlofyS5JFhvZKotDglrY7a3FrjNvlS7igFOb
         hVXPtt4NtvPHBnHSrSB+hm0eD7uUYYAwHDGnRBJDPvfD2P6bXhTfwbQRXe+PdTgABptI
         jzPxKYATuv/X6RAEPGMqZzWqkfd+YZvmlbwv2r6GaqmAB7/IA1LhvxC6ElM3C+CZYhbs
         ieJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496830; x=1743101630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1gVL5lJAtRX3Sj7ZSt43epD+xZQUqg7ig8oqq/1rgA=;
        b=Rhpm7A7XpO5Nsm4W8jrH3taVwAmL3saEPe3NzP9pueWGqSTpJ2is4HZ9n6ALV3Ynwi
         QmyT2vdABFnqcBx9/+8rf0a5TNSNPil6pWNwrKS+wjmfL7SHEN86X3CkpOKVndDTFCcx
         BYQRta4vR4jaXx+XWmqSa2Lb+qfsarRvgxyMoV7m9AY59GFjWG20Z7Y4jJB5r1aON2wq
         7l5u03gDayaSBBMCf2mnGlr05L9XWGQb6Rf1N9K4Ry9pLDLkJxzIS6Qh/oxu05FzGldz
         MJRjvDgG/2wIDc80WlMsUXlF9Lq0ac6JFOSzimJmSTZ1Qac8lT8DbZeFlRPAjqCspq4d
         hsLA==
X-Gm-Message-State: AOJu0YxFQH1QXeASDh19fGRzI9psjGRPRH7q4r51bp5Xyn1b57lX004G
	WsppGcpVeOi+/oMQJCs3LucQMr/xY1zj//tRIqqSCGdivSwYzD87rgJ6IljD
X-Gm-Gg: ASbGnctIpjhxy93Iyg2xTiGljgWZZaXqp25Aar6XVipg5+1U4EIaKaaE89VBIVguE2L
	yyN3KgyGVtFQ0TnQeeanZHU8JsoCD/kEY0fTvmvDq69dxo24lUPowQrZbt6OTNLVlZ+ZVj5E9/n
	gl7H/d6OsFXb4oIE8heRGuSojPp2IDI6RZIZwoqW4hAcyhDKqURhs6M+TGynXY8GrcYy8MGqIuB
	gRYP18elI2l6ppJ8xtOvS6oQiw1/B3By+Ys3G0gQ2vuJp2+nHu7PpcsN5UtuxA/pIm0wDGM5qVO
	4Wum6MeY1GRdQu70vfjrQ6R2O3vYYidFmV7Tbi1GRKWejJubPFna+IN27U65JGoGJv2wh+red0t
	PiQ==
X-Google-Smtp-Source: AGHT+IE1Zxq7CiZjQgYwsnaWE10QdCmVkXBUfaT6ifKAFgRdb5GHq8Wsf3mZdsiEyRGMPQIP52/JEA==
X-Received: by 2002:a05:6602:3991:b0:85b:5869:b5f with SMTP id ca18e2360f4ac-85e2beed32fmr86356739f.5.1742496829800;
        Thu, 20 Mar 2025 11:53:49 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:49 -0700 (PDT)
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
Subject: [PATCH v2 40/59] drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
Date: Thu, 20 Mar 2025 12:52:18 -0600
Message-ID: <20250320185238.447458-41-jim.cromie@gmail.com>
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
 drivers/gpu/drm/i915/i915_params.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 37746dd619fd..2dc0e2c06e09 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -29,17 +29,7 @@
 #include "i915_params.h"
 #include "i915_drv.h"
 
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
 
 #define i915_param_named(name, T, perm, desc) \
 	module_param_named(name, i915_modparams.name, T, perm); \
-- 
2.49.0


