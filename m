Return-Path: <linux-kernel+bounces-570247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF83A6AE18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150203B296C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805C24BC17;
	Thu, 20 Mar 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbVzAjGk"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B724A066
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496850; cv=none; b=bbwPaj4zz+h/dA+8OS/cBghKxHAteOMhofSfA/IKqGMlstmhq9Jlrp/nq48v8nE3Ai6+aetaecjqyPUSpuztDo3flApjLKiYFZ33HOsHOjzdRDPCgZqkoZ5B68UNxZMUCyF8XTnYqamkSLrONjeJCJFe8Ng/Tz+Nu6FX8KOUcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496850; c=relaxed/simple;
	bh=jtmuGtEYcaPHI+wbnujDHwf0zLuAr7ob6sebW7yeKAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOe1JFBBc5kfD0DsTvzAH0eeTbNE818pNauauzDSnu/p008UCgwdaeBKUuSV6m7YJ0yAivCRmgCVecybyG/x8qum/SSUdOCPsDZNs0cwhnYOby2/QLhTi8Tis3mOB39ZCik+JWfrVD8pmgF24XgxM8ZHL89nT+QQltXok5E6nbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbVzAjGk; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85ae131983eso125399439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496848; x=1743101648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1ua5S//H69kDLjZ/ereYDRSGWaurp/ZUyrfcdHp8ig=;
        b=HbVzAjGk7zx4+zTws2JuiEHfkJ974OI4ZcKAKpkjGtai2gLbTgslMpSpuPvqMev8Op
         vLUWJVCP81HGkb7GDnmLmcd6HQWVk35C3ezTbBg+Bt1DiDclmNNOZXir6WcWIrKPDhQA
         VKySi2Az4ju9mxi/ZWHlEk8UNdSYBMSvbj+/df33ogSwkWSDTv1hQW5oke0DkjUc257m
         Bj27nukjZ1LwzwCjEUq/N3WlBam84LrDvVrGQDglihtwOxtSEQ2SSvcEdzs0k6tsmCDE
         HV4Thw9sUaPO9lbHa1R7KZyEdjPW5FssYL6ntr+HGwac8g0YNoq1o3o6q/OlM6BduJBT
         UL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496848; x=1743101648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1ua5S//H69kDLjZ/ereYDRSGWaurp/ZUyrfcdHp8ig=;
        b=rwsr/BFLmTqP6Ta5/sEDa3L90I0OESwvBpU+tQJUEKRGo6OkWL2Zm5PC/F8+sRjUyV
         4ZA7pe0Ry1o3ZMPmo9uiFqTXLbr4dowqMBzv//w/T1up0T/odS9uhYyYe7vWX33vHgnU
         6P9SZrTOuf+TLHbpY9vLw9XVgME6ozFMoh6E5fzXub9dfXZcGAfrDpGRp2iF/lelWAxb
         yCIaOyf0P5kfxGTCc+O+fHIdzjf+OkYk2IPe3qccX8gOuMo+egJyPmupWKS1tsjney8S
         Q85KJOv/x33VRc0YaVIrVxHsqrnLS7sQmptfAIeBmAuvbydUBE0RhK2m+TeB/AP7j0mG
         Ybyg==
X-Gm-Message-State: AOJu0YwOwbIOoGkNibqWgu3scXroDwdvvzPlVN8kBDIT1vZRCeBz0eva
	mcspZyKOfANOOa3rgpFlMFo3bHGURgkCMlmq0PH1etLVD50WTZrFmXJsNa1B
X-Gm-Gg: ASbGncuhR5WVqqcrEX46gnCezs1dwviurP6Vgk0fCu8+oQsprKiRZUjGo0aqgS/K6rk
	uVUpJYfrMgxAe92v0mH2LwGTKTyKUNBicWiX6HwcDtBPHEknGIOTBcWdOIxXJKHl/ADlx7wsIYU
	IDXe/W+GI8w+REqofamoF9PTQVVFSJJ8DOIt/10O+iIuiIQnxhgHl8Cdu7PFhrz/8HidFFn4DLj
	n+FVz6n5MsCMmbi87UNpw3ZdXSLb72Q4z1xp1sBuHVkt08gP1bRhZA6ecdEok8lXcm2KCfHa9km
	AqCnIZDMAsHUBT9F5B4weV2oqHzyW1aGFAZdn7tRkLCvecKuOA5ETsSf+krsOKWKUSrC8tdPd/X
	3pA==
X-Google-Smtp-Source: AGHT+IF1BVm3oe17yrUphtZQXL8NOfypQ6M9iJgJRk9AIUUygDykxaFcqniPfeAk5RCxls2FZZiEnQ==
X-Received: by 2002:a05:6602:3997:b0:85a:ec03:b124 with SMTP id ca18e2360f4ac-85e2ca64293mr50159939f.4.1742496848117;
        Thu, 20 Mar 2025 11:54:08 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:07 -0700 (PDT)
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
Subject: [PATCH v2 56/59] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
Date: Thu, 20 Mar 2025 12:52:34 -0600
Message-ID: <20250320185238.447458-57-jim.cromie@gmail.com>
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

The qxl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 417061ae59eb..c18577a3153d 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -66,6 +66,8 @@ module_param_named(modeset, qxl_modeset, int, 0400);
 MODULE_PARM_DESC(num_heads, "Number of virtual crtcs to expose (default 4)");
 module_param_named(num_heads, qxl_num_crtc, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct drm_driver qxl_driver;
 static struct pci_driver qxl_pci_driver;
 
-- 
2.49.0


