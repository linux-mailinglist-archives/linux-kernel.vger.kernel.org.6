Return-Path: <linux-kernel+bounces-238484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C019924B40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEEB1C21951
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093871D4328;
	Tue,  2 Jul 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+bFa4Ek"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44E1D3096
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957565; cv=none; b=ruZUQXFoizy9to1G3V4gB1Ca6DmtvoxR+nBt3sYuhML3gqTEFmDwUrAA5+CIWu2ZdogDeMmW5wTWfkCgg34HgVEq5FjX67RUXAvovQQ3UWvzBgDj6Oow17oCcqRWRX1LiAvm7fAkQ5xKzm72QJpApJk50yyfICmD5XhywW+PIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957565; c=relaxed/simple;
	bh=Rk/f5dbxo8g7dEtgimss5pObm3l8F//bmBLgPo4cdzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVOLRml/Jm5WUrMSN229ayHW2UXb4EqTdmLswl+yxXaE0R49aQO/VZsNn1+npgnlEOc9W2S8Rz/pICpYaGMGm29yeRpNSMbSXZdww1mzR9/RWIyzonhHJ6EMRj8P1drfrVdRgb5GPJH1Ya2r1S9DnH6DZGUSuN4WVo8Ogc5fN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+bFa4Ek; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3d2d441e4so148787339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957563; x=1720562363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEobEBAhQNxO/3OZFKP2IkCx5XlfGH8UelPAprxIIQY=;
        b=c+bFa4Eknxk7j//Pt///dniyJGiu1ddkvesSIF0eK0pGZq3I07h13kQyP9L+PVm+R0
         ww1ByY4lJVgosGQwnpntB62ogXLrEGyejoQlf7zRqUclBtirgE5ooyNiqA1P3OB12Dnv
         G2JsRJe9SZte+IaeI1DeW37VkW1m7cZjOSiBfnT9altp/SIBz0Q2ihfVmAiNHBwvm8j6
         Y8piz8/YaONWvBBgrsoCL15lxLEt0YSzwv7kARWNG4X1vTwAzPkDq8vrGnzcqHd/6cjv
         /90k6Gp02hNVXo6zQZ0pLSwSrvxP5ZFQCtOVxn9tKqbL+uBznR7/KZ3EB35Pob82G37H
         6DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957563; x=1720562363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEobEBAhQNxO/3OZFKP2IkCx5XlfGH8UelPAprxIIQY=;
        b=aspse8rErv59V0KajAvUWR5yKrZZ6kdrOoSRPWsKiWGjUohp97H8Iu8MDpe0ufQy36
         RHVWTkeFwjnxNBY65+7f1FyZt8a3DQvoqkpOxZhe+IDVhsYp4lNd4+U7mM0LgfEplyFi
         ir9cHOmmitVrf/lGsb33k83ZAt/BXFzwL28QPvBA3Hn2AG9Ny3E58AMvLN148VUna3p1
         WBydZT4xd5ECqsCujeo3jW5FYGir+9KfnnwX99ffhLpL1GqfmLXEzPEQOv2EGSUyGSF6
         4eY9HIL0BYL7lkm87OhAYeTd4HotOlUxQSX4zKTVyF3rTv3r+XMumlyQamejMr7dPDe6
         bUZQ==
X-Gm-Message-State: AOJu0YyqqvbFLR2MnfF2FZDig0LjaEyxi2XNzQKXqBhnyzXA6XZarbCS
	ADIHsJkljuRHRyISL/QzJlktdXlIWl01SZeOq2EFb6e5ZJwIC/yc
X-Google-Smtp-Source: AGHT+IEXFuB8CgCOnXQJuoSrwTgJZdvIHg9MnoO0JAh6apXbcdNr+8WN+3OWZHzErKCmZl0N7gDJwQ==
X-Received: by 2002:a6b:7f02:0:b0:7f6:1b9f:8939 with SMTP id ca18e2360f4ac-7f62ee0c85bmr999438639f.7.1719957563268;
        Tue, 02 Jul 2024 14:59:23 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:22 -0700 (PDT)
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
Subject: [PATCH v9 45/52] drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx driver
Date: Tue,  2 Jul 2024 15:57:49 -0600
Message-ID: <20240702215804.2201271-60-jim.cromie@gmail.com>
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


