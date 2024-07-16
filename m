Return-Path: <linux-kernel+bounces-254297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D0F93318B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E92E2846AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920C1AC25A;
	Tue, 16 Jul 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHBwnrU+"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E61AC225;
	Tue, 16 Jul 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156362; cv=none; b=tD1Netc7cQo6jvg8xd+tS16Q1wizLFmdxajcJ9Lypg7LDbZD1L+GpQPhYCnBZvxzRaHUvyTVF8/T7UXoBM56WFQZ5gWdl9lBsjSaXjM0udAhEFN4PdXWY5e5IyArvO4egevzisuGFdb//VKvt4HdXxIcMlPAqbVtUsDfDXEA/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156362; c=relaxed/simple;
	bh=Bnq5BQKfMG5kstkLfy63VtsHV2NPk24N/ajWD1f0Eak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1mxJMhPRabAHHzqXfTLLeFtiC8yGoPE/lOHy+VoRt3sYCEpNlcBYkpq28EMvSve7eI8HEkEX5tzMQSmX6DTCl0HjQbSDWddA3qZGNb8uBTFstsTwwGNwQQ1/dNTZsTOqaWwO0eI0Ilaf32P/EfbxkL1c8obmZn/BfeSyT6sDfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHBwnrU+; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8036ce66134so4816739f.3;
        Tue, 16 Jul 2024 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156360; x=1721761160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MstXp7FK88BMTd8JHXdyfJJm9pHe+R2QRKpv7nuxLhw=;
        b=mHBwnrU+3zcVShXP1EZ2fcYPTimelr7waAicW+i6R8MWvpIgT6NyQZRYT9HW4Zls9Q
         Z8d1rI57HVEuQi9FL6ysri2hDmKoltcHtNuONZBD0JKIMMh8piHOTRp2bKO/DMa+5mYi
         Rk8NBgkLRee49gVx2b1BCbi9fz1IYWa3n4mfUvOAoEi3m46NBOzYOgr3MamzfnprcE0g
         XGBfVyLaLRIkeGu8WujRe8pIiiCmWc00jVoKv3gHnHYZunb7HMYvlXrAvWmEJE3tP1Az
         9T+Hl6a4jGR8ThnEuWdfMnJVL3y51sZ/YqLU/WZs4TEhHCXAGmH50HAgVoEb0ZGzD4dv
         c2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156360; x=1721761160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MstXp7FK88BMTd8JHXdyfJJm9pHe+R2QRKpv7nuxLhw=;
        b=f5VA2S8+N6UOrzuIhYN/IWT7gEp810LkaWnI7njBHTjUa4EbmzOBJAr76hIIBNPNHd
         M69pyqdfBg6YWfoTiWii2/w4J4kl006xR3TioBneo5w0jKysjEasXo9QoCznc2HoOydI
         ALnEP4JXPOZBBlBDuUhps+gcTM30L9fh44fTT+bQivl/r4nw/85eFz2fpdEUJq14UhkE
         iRZx5OfrFZqae0KAauDJMY4zDkPOiUQ5y32zVRKgKmA9Y39FYgXfIox6ernEpgREtfxP
         Xwx+5e+ed8CECUaOhpbnzspTk14TgQesvU4dYZFc9gAJMRvmjKGDjnnf3sK0LDWgYQFa
         VeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGowS1thoF5aNkUwnmagawS/gRS9rYOo++RIwDVmc8q5rBgcyF7kphq8WPsjZRgIc908P0ykzjN2YL4uGdG36zn22Jinyf+2jt
X-Gm-Message-State: AOJu0Yw/MQvnxxmok4rRlWnpzrffAzm1W3x+lr3O3UxzDJi+kIuqlwLF
	h2ZtC8k9bqLrbKZAIF0nZ0KqKpiHWWSLVAf17O6O3czAR31BX+y7ZLujktbM
X-Google-Smtp-Source: AGHT+IGQuunN6rsgX1Y8tE4Gm2pjADPPVTDv3hD9rbQpd59uugz0Y/Tl+qes57urn2HroXprfn28JA==
X-Received: by 2002:a05:6602:2cc5:b0:804:fc36:dd02 with SMTP id ca18e2360f4ac-816c52c09bdmr40756239f.12.1721156359955;
        Tue, 16 Jul 2024 11:59:19 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:19 -0700 (PDT)
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
Subject: [PATCH v9-resend 43/54] drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
Date: Tue, 16 Jul 2024 12:57:55 -0600
Message-ID: <20240716185806.1572048-44-jim.cromie@gmail.com>
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

The gma500 has 126 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 8b64f61ffaf9..5e03ac7ff433 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -39,6 +39,8 @@
 static const struct drm_driver driver;
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * The table below contains a mapping of the PCI vendor ID and the PCI Device ID
  * to the different groups of PowerVR 5-series chip designs
-- 
2.45.2


