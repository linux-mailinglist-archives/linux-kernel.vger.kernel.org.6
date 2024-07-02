Return-Path: <linux-kernel+bounces-238486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABE9924B42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C05D289DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C36520FAA7;
	Tue,  2 Jul 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehcn//tR"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E101D4332
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957567; cv=none; b=ZYYXLUsvAcHkWEHkazn2Z7Ne5XxchKvgvgbsZFiwHHxgszuOeZcNj5Y9DnHDPLpLpJhh7fT0wccLOJtu1VZK7FFg/0omROFHb8rXDPxeI5IrtG94kL/GM8oB9JwT/cO85mLDywHCIHJYeXSMxdlkiaWOcPFdGNjketrQiwHUvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957567; c=relaxed/simple;
	bh=Rk/f5dbxo8g7dEtgimss5pObm3l8F//bmBLgPo4cdzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOwkXwhcW7kchECVUNlJvFf36AR2U9kduCb/0m+G8Uby2O3QP/6sTTrRVWXxSC3Xqt1gk88D3wq4TSZZojj7aPmkNw97LoeyEmBZNrrgsJvpSVNQuKf+hnVixfXcY3TZFTIYtU1ICUOZ44j+9XAz8SIipM+HBN63vUbcZNo3Fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehcn//tR; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f3cc78afb6so165132139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957565; x=1720562365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEobEBAhQNxO/3OZFKP2IkCx5XlfGH8UelPAprxIIQY=;
        b=Ehcn//tRN9xwDizRRXoBVFyKl4+0aDWz8p0aQsVsXci2vQnX8XTcKC9O270EEm4BVA
         adhGuF8DI11PJCvYNpWOj/9+Vi2KAuQVW/za2j955o866HKCeauqDwxzyelebNI23DpK
         3jWjI8VvW1KYabf+e+scernG25SCrKkhC0Ni7weQapfxiYiNbR5GI3Gqf6p/OK4GWKrI
         jqTKZ2Dxow8YcNQCEHefYzhWvlbG7JcvUufMK1PtrdtQvhTuJhAB00ijS4V7YL9g3BV2
         cBsdMRBMIKDpIC7o5FJLdRbJBz7C7Hi6ogvGr0xkzqciEy7LwHMjjb3HIWo9VQMvSdIV
         VgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957565; x=1720562365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEobEBAhQNxO/3OZFKP2IkCx5XlfGH8UelPAprxIIQY=;
        b=xJjkhRWVyO/vB6Eayf01iBhLbRg7wtERR7FMqxNmto7b/gLreXat0iAt5JxqWqfcH6
         MYWuxgQiWeYh3ig0qNjJhjRb+c+GC6BqT+Qe58lwBv56zl4Ti0nLW1p71pSUPh30mKDc
         LmGvm3ilM5b2uGVtUvwX6q2vixYH9M4va016LHnND+987xWfsUaTlWn4lRa0+4GaA1Xp
         xVdPiMZnmWecG9UrNhMcuBczbfaQ49EreV3XiVjslWX69yQiS+zQhMdOJZo3VBNap2Jy
         S73NGbFCL2omribWKBfd0B6hbv7PjUkcOc+qVZ2GuyGApXkpaEWv4qCCImm1PHUOao6J
         JfLw==
X-Gm-Message-State: AOJu0YxY65Z3G3sF25zZh71iuhvw7XVQoF75F0Gl9zZQjdpJw1Crq0ZU
	VZ9kg24I8BndLHK3wkUDtO/cDDiOH+E8VyqytqeXOY2ivork+aRr
X-Google-Smtp-Source: AGHT+IFcOC83OBkwA2hxGjvMqaxztbP+AvzQjxD0yqNmEddDILLw49t8Koh55fzABZc6BNNbXU+pEw==
X-Received: by 2002:a05:6602:1305:b0:7f6:5694:d874 with SMTP id ca18e2360f4ac-7f65694d913mr239273439f.20.1719957565593;
        Tue, 02 Jul 2024 14:59:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:24 -0700 (PDT)
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
Subject: [PATCH v9 46/53] drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx driver
Date: Tue,  2 Jul 2024 15:57:51 -0600
Message-ID: <20240702215804.2201271-62-jim.cromie@gmail.com>
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

The vmwgfx driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
 1 file changed, 2 insertions(+)

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
2.45.2


