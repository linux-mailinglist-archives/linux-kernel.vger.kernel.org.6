Return-Path: <linux-kernel+bounces-238496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5CF924B4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF8EB21A96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF241D6938;
	Tue,  2 Jul 2024 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwZkUPbj"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FD2101A8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957578; cv=none; b=fZM4l+ANOdApLET3aSivmRyp5F1KQD1cygrc/bnDfFoKAqDU3NNc78QpjbboT6fH0mk/KxRwbrepKooefeiwZoqkrnhWiNDH9ScCGVP55ChHxgkLiom8UfDh2JWR+Z2RQHQBh8uYh6gXLT5K7cTYOHzq9P0wiMClyF3ElUjzG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957578; c=relaxed/simple;
	bh=ZdgkYt8StKCj0Myc4WWZURkgaMtctnUiCw+YT1im5Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZEbckaW8xrtXW+rYDp4HymTZ89h/OyMkkmZ3emlw2/kO0tLbA3p+tBRWev5enruCnBdVVRfbu7VeNOIlAVK584wFw0iaW6RNUbiKAnaVdVrqzbGvix1OMkrzJO8nvTwun23LVfIJ0HGr6vA3E7cq9L+Xab8HDgOab2CybN+uVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwZkUPbj; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eb895539e3so191297139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957576; x=1720562376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JTbEivvcQUwAcXrAriYcuJGP77J1qAidh1sZIrKRVg=;
        b=jwZkUPbjtTXhZaiTt9SIxRtQ+ILP2KSSOMCThEIQilcng5ffQmKqMdman9rQnQMUMz
         DcG636n9XiFiDK+3qgEPG2LqMXnrrT3XEuqKBuBC0FSxCBOME0wmhwmBIH6h2JGw1hmS
         1rlGOzRyP4RDIrQR9BVKw8q7rX0GWcr0izMW+k2bLNfeDI/eiFLujwKhWQp+9gH2Qg2d
         BglbzT+G0Fa9NzkwKOI6dJIj0GOHH2O9XErAb5jIcAu/GCr0hJhxQ4Y8Ja2INcWjvrIA
         XIHB9ChlhSvZfS2IHQGPkF7FfqejSOtMw/mtb05y+oeuueLKJJRs7qL82fhLFhEkEZOc
         3D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957576; x=1720562376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JTbEivvcQUwAcXrAriYcuJGP77J1qAidh1sZIrKRVg=;
        b=w91Y5lLk8ZjWeqgGz84aStOusWd/xVZlqtLrHxK+kowYNme4GN4ABSHgWW3H0EyRQQ
         Y2kpYgrMejm9l8xcEHcJIUqz/Nk18Jh0j+695cPdWQcdqsY10qppOxKohWU5YzuGL9Km
         28NoIyVgESpGraB4man5FON76MpqoTgA2juNCbgA8LSv+px9fyOzQ0ae+FdiBm0McmlF
         2KFWy2tvbEV9vEDqNI8DWsDRVyjZT5MOZamLXxAnUGbryDEF0hqhUaxlLhDc2m7OJvYM
         DCEUbnSt4cc8DD8mUlQc0uqaHgJSEBnX5UTmKWy4vZsHPIcTTxAnOlCit0nhxuQNTXbH
         yv3A==
X-Gm-Message-State: AOJu0YwyfhsMHBjNHiQ8tOCcYKtobdcCgTeQcgwqlM2+lId2HSk8Yjj/
	zuhkF3ok9FRP9FadhexgYz3fSAvZ+Unv4v968lr+6UpmISy6Bw+XxPZLlQ==
X-Google-Smtp-Source: AGHT+IGZ5ru0Gbzul6gBrJZ696v99JPj2evs0BxHq6ZuGzyQecQi/AACVhwVexMDvP0Uufc1BvrHMA==
X-Received: by 2002:a5e:c60c:0:b0:7f6:5143:34ba with SMTP id ca18e2360f4ac-7f65143367cmr343431839f.16.1719957576037;
        Tue, 02 Jul 2024 14:59:36 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:35 -0700 (PDT)
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
Subject: [PATCH v9 51/53] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
Date: Tue,  2 Jul 2024 15:58:01 -0600
Message-ID: <20240702215804.2201271-72-jim.cromie@gmail.com>
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


