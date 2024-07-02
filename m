Return-Path: <linux-kernel+bounces-238489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ECA924B45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2316C1C2169C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA4210195;
	Tue,  2 Jul 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuHDkr59"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2F1D51AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957570; cv=none; b=loAfR3bgb2X/2qNxddQYDYdkHC+f9MkhWXselmA+1PlyAdr4cg6nXUu7aGUbIEbLApZI/Mki3niSlT1tInzwdxSH2o0xiU5VP6bnGnfDJ/CrgnLvBTlZyMkuus8oltStvGERaW9o2O69y0WZ7T89auZ/AjUmgg9kaW5GvKaFJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957570; c=relaxed/simple;
	bh=TX38Fwwl2zTMhUpMRgW8omd+SgE7ILpv++5XKavk0hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzT8JiBqtrsnnnesT2BbzBtxvS8xVQ0w7YDdF4ZNmCVvEZq0HQ4xJZqNh2sdNkosETDXdZzE66ynAQ5iTNFca28bUxdgr+BMk6G8vVfNLNI6Bjk33bS+mMoANZjP43yGP6G9rilZoAAsD03dnbX0+w9CUYCIWfBrhhtgeXJ8Jho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuHDkr59; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eeea388a8eso185119439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957568; x=1720562368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC5iipR2BEVxGSl/++A4yY4qqMQYODae2mcnPNjxpHM=;
        b=ZuHDkr59LSlehCFgSsSuaI+ZGOBsIQrf5990PVpQhyx3NILnt2RzFUeBWcQ7f1TJf3
         iBI20jk0wlJVKFg7ekesQ+sflp1mdm0XKv/OUtRwXiGfu3mqIERvy4yjskZndqPkxqIb
         E7G28a44VTIjNHBfyehTC9+/6eCNDDFOAhawy+PlumdfYDenezqDf23XQjgIUPvMRy9e
         2/2g+i0KocG5+SVVg0DIm/glAf6n42Zzk0jRshb8+GQ6K/Fwar+egVwT2HY7DempD6qW
         jv+AoGg2W0+BXdX4wIOnXQizqiqS9IxxM9fG1rAuRNjTXV7/2YG9oTwTCgGHnGZalOaR
         lx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957568; x=1720562368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oC5iipR2BEVxGSl/++A4yY4qqMQYODae2mcnPNjxpHM=;
        b=I5ZGmdxNZ7ey0BRnt9CV0Pg/Nsq8zGarjzyMwIAySgAVWC5bR2xRw1ODNBFrmIzdeF
         Y/tp2r9g9G4/rnp6dqySTSt6uuVND+t5+9A3fuSt9H1AP1biIb3Pm8o6K3MJCqLk2B4Q
         kpe68cjUfywJ+iWAbKbAQx7a7qL4LTXEN43EQ4lPNVcS0lPOAJtcf85Gw1iD18V/eoHB
         fRv6h1sS9mKnZgOsd2X7fMcBv0OaDyWQ0T+gqidIjA5ZpXf14Qq/0rCViLcOlQPK+hKJ
         /PXfgyv1s74eAutyH/omHbvgHDfL5DafJ8C62RtVdpmtrlcROwPTZJudYvLf/cWh9iTS
         yEFQ==
X-Gm-Message-State: AOJu0YzncDAf37jEen4X7l8fwtigRDqN8gkCIAdW8UXOghxU5qw6kx+M
	Nv63OXAI7m8TLYHaJmrdwmEYOFBzNk0BE3P1Y4qXQ/LA90JvpYPD
X-Google-Smtp-Source: AGHT+IGxhTOcr4ji5IFiskQTbP7XplIk6SNXi5lLsntoYpdRCPZ1vof9lF5GiOngaUP5FSepVU/KWA==
X-Received: by 2002:a6b:5113:0:b0:7f4:861a:5e5f with SMTP id ca18e2360f4ac-7f62eea3032mr999757239f.20.1719957568654;
        Tue, 02 Jul 2024 14:59:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:28 -0700 (PDT)
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
Subject: [PATCH v9 48/52] drm-dyndbg: add DRM_CLASSMAP_USE to mgag200 driver
Date: Tue,  2 Jul 2024 15:57:54 -0600
Message-ID: <20240702215804.2201271-65-jim.cromie@gmail.com>
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


