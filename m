Return-Path: <linux-kernel+bounces-254302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91EB933195
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6531F26605
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA781ACE63;
	Tue, 16 Jul 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLlKfEbf"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2001ACA18;
	Tue, 16 Jul 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156369; cv=none; b=SasxKbgVl/Gzr7xT4TWD5imEts6GA57/e9AD5IJMFpKWFwpclLNGRgmyH3nZ/4dMP7haQSf6L4aeeO1J1nbB0uvdmoaSMbKyv4nYX5PhIsoH7IlD/L/13Rp7y7bKY53UB6DAthTDIPTnE0+TkeUU642nmyVA0ZwNZEPsmuzECQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156369; c=relaxed/simple;
	bh=TX38Fwwl2zTMhUpMRgW8omd+SgE7ILpv++5XKavk0hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7W1wSWDE8ydhzgFSBePTYqgjIQglvF8DKDgevaa0+oocTwmIN9/0wGejB+p1dSAuDDHa8x0Za8lRzHVSw+3gCOmZyLJj3EMv/+g3HEOTGl657T00F9MaKVD38H0iG/PAoSqYUL4X0DXXFsDz2H66in4wbaUHsGtO8TmN0eLd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLlKfEbf; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-80a2939265cso6231739f.3;
        Tue, 16 Jul 2024 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156367; x=1721761167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC5iipR2BEVxGSl/++A4yY4qqMQYODae2mcnPNjxpHM=;
        b=MLlKfEbff2SiTZIiWl/PMtPqbtfAkwDwvPGkkeAfH9vdZwoCjHLVUovYz6YJ6oWH1T
         pTfJUWj6Txw306cd0gr9FQTUoEoOhUgTdQOzVm6V5RMIg6RVDllMvEJjzulijTTCpF01
         TvCadX9BPHGuvCAhgWqTZVz/lAi0rYSHdtO9jEaYC0mD5mrHfH9tmOIGCNU9agoIVnkD
         lecNzE1HUrJzpxvMTdjrOFOGRVWLfEvcfVYhKOugOJ6eZq9KjgANbTmUcX4hs4lCnqje
         HfeWrFF580LDkZ879NEtCFHfMIwHeVRhlDCCDL/IEa0KoeK70l1m/JxijRe3x+cnzRYR
         ySWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156367; x=1721761167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oC5iipR2BEVxGSl/++A4yY4qqMQYODae2mcnPNjxpHM=;
        b=OzJyxsobZLItnAPbsup1U4GKmiJJ6YDP8r7HhECOnRHGmyVer5U46nUdms7BZwi4r7
         8VdbugrrzWZXqkBGduC2+KJV0sCvE5Dd8lQeWfAFBTQF+K/N1QQLXP81DybC0EI07zB0
         MWzdfHmUHMN6MVUFTcumF734T/YWp6JEPAudN3K2vp8SAypix8QXo6UlUyyeH1J7ZnDr
         KQ/++NbVIY+Ti/EGxpF+O1nKgQ0FUPOr4ujds2MTQ+a1x0HD3KKq9WbIUH+ZNGRu/M7u
         y0gqSrylg1xUU0eaWk6s5yD1wygtYF/Upn5wtzUb0cLwSmriUWLl8XlGcu6myNGxvGwJ
         8RIw==
X-Forwarded-Encrypted: i=1; AJvYcCX9fMxX5SSi1IXA5irmLuuV3WDXLEHl3j6rc/UeaJws2Ubo1uAaX5gdUuyW9iuD7XyGuYRD6FoILE/5xCR7U4qDyQ2EYyuajeN0
X-Gm-Message-State: AOJu0Yz0kNz2xCkjfp0ohIJL8FslsdcaEz5hgRdzgqoSben5UvwdwCSQ
	AWup2QLpxpNwygGBRIz2uvhoIl8/TaF7gprvmdWOrKoQIpAoddolgsiRElrF
X-Google-Smtp-Source: AGHT+IGMFr+WRvPUWShhESRsbZEGA/7YjF6pB7FvYBPrtixRbfhiQCet+WIVbY4uyS0xlTwYTUKheQ==
X-Received: by 2002:a6b:e60a:0:b0:814:65dd:8cdf with SMTP id ca18e2360f4ac-816c39b7267mr38223039f.10.1721156366976;
        Tue, 16 Jul 2024 11:59:26 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:26 -0700 (PDT)
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
Subject: [PATCH v9-resend 48/54] drm-dyndbg: add DRM_CLASSMAP_USE to mgag200 driver
Date: Tue, 16 Jul 2024 12:58:00 -0600
Message-ID: <20240716185806.1572048-49-jim.cromie@gmail.com>
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


