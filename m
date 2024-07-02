Return-Path: <linux-kernel+bounces-238491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45A4924B47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD8286B33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841E41D5A5A;
	Tue,  2 Jul 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRbFOtza"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66281205E34
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957572; cv=none; b=oCt8VQcNTie2mkdicM86ffzlVgo5thWnGt4CeWk+hdQfbnujIXrEmWSvaGPJ//4+BC41V8wMS0w1YuZ6tGrO26/Na9GfhOWP4b82oIiM4mFVJ34WK+RRQ8fB3stT15wBN721gp45ElMr341svPpRisLl4LGl/hA+2WY2wlNKZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957572; c=relaxed/simple;
	bh=TX38Fwwl2zTMhUpMRgW8omd+SgE7ILpv++5XKavk0hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1zEwHgcWP8r3xinjTd2682wtORAwIMNsFa1EBRiZUT/NqIH6cKW3jhhwBIoAJhyP29Hy+IOax/l4aXrx/Ym+V8w08fp218zrMSnSLtcyhCfPA/WYsfDkG8dbmDa6E0lQDWhuQZMQdOYRp5OE42gl59wHJoxzqnOK9/ORPTCYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRbFOtza; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eb5dd9f994so174442139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957570; x=1720562370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC5iipR2BEVxGSl/++A4yY4qqMQYODae2mcnPNjxpHM=;
        b=NRbFOtzandE38DamL2a5tSKaTIOUIVEIV22AQt9pBTVtHCZf1+0r1X5xSvi+47blp6
         /aI5CWG0ctYF5mSm2hAAbW3KEQHiXM9uuY8L6TdM1eOc1CeTmLZGA0XoRY2ypXm7XG9u
         as5Ssj8/00Ymr+fyKolVfhY0QqUV2+586wi63rz3AclNeL4bZhEJ8LM/ElGaxjUHmxNg
         vrgAdJhyMu4PuktPiby+eortCS64Pj56jjI9QD4MATJ3JiqiXB7pH4Potl7JH9WYihno
         RNyRANLuogJEIUmpkxB+ENOqx6+MTl8aXg5jmDymWnbYbq2gDFGkwvHoCPK5CzZ+Nrma
         FfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957570; x=1720562370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oC5iipR2BEVxGSl/++A4yY4qqMQYODae2mcnPNjxpHM=;
        b=c5bIhxdWE+kNp5bHgIQwKPYwx7h832VVNU1pXAXnx10aJeDPkj52cHLWXdeX6OeTub
         8j5dhvcaAqF/sfHRrtGWBbpyCwUqIaVtociv2CgVymqp1RwbmylPl0UyT7PfE1GjKUCo
         YjPx9lj9ysRDV8ISVCWhMczsxnlOnuVrYbrVmmgEHlazTDjP+DEymHUbsmQPtrJDUKsx
         3dQQ8qbPAHjiXY5lZvVqsrSkgf/+INW36jctYyuvVs4P1H69uxatCfwQg3WdXMTVaB2q
         fvoPT3LhIjnOthe0igO/YsKn4F9qo3Hks7bzeiPpLbOpeS0jwMS/QQ7j/m+wxNFeiqxQ
         xiSg==
X-Gm-Message-State: AOJu0YyA1qHFsKVM5TeOBQUJJHf2gtb43ZedS5FxdAcOPTRbS1ffg9Oz
	QFplutf6ahazE0gVMB/Q7HGLUJsSexEW+p5eBOqWjyo7Dwq//PdQQ0DhUw==
X-Google-Smtp-Source: AGHT+IG3KnjeWk+tAUHTPovE025jwoX/P1iby1t4AUaiPLy6INftMDEvgITc5Zor5sYmFDRxWWvjqA==
X-Received: by 2002:a5d:8408:0:b0:7eb:d640:267 with SMTP id ca18e2360f4ac-7f62ed4df02mr1061790439f.0.1719957570618;
        Tue, 02 Jul 2024 14:59:30 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:30 -0700 (PDT)
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
Subject: [PATCH v9 49/53] drm-dyndbg: add DRM_CLASSMAP_USE to mgag200 driver
Date: Tue,  2 Jul 2024 15:57:56 -0600
Message-ID: <20240702215804.2201271-67-jim.cromie@gmail.com>
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

The mgag200 driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.45.2


