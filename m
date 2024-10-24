Return-Path: <linux-kernel+bounces-379733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747399AE2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36771C21C12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55831C3025;
	Thu, 24 Oct 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cAaCIEIg"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2F176AAD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766829; cv=none; b=OVTWTT5sMVdMB5BWDdvcV4Cct801B3Eb6YZJQzhd/iG0gi82qZWftegLQS2+oqTC4uy6HgNQS4fKIL4016cvBvMB3Rpj6yqQz1HF0iyXtgPQgULJclDZ96WVAp1OcP77JhkSpIMs3sn9qkM9FafazRqiJN2VUlOHdxJEzTag25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766829; c=relaxed/simple;
	bh=J+Ml2vYTBt/Fy6h5aoBXUKaZKw4ZkG3ADLT7XdI9X74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qH32GSuzdGwugXXLHFBvdqUtAo+wjBIc+U3YEwRZELYiirmDWmhISKuYwnA7AqptZjbvVNQxEWymbWyFa6sXOBt9SSjE9bOiqrpLb1zyrE7LWtrKdygIv2oNdh+MiXL1uE1UyZdZy3qCyfIzoWmWEEkAX04ZmzGJdZrvN4GJ0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=cAaCIEIg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso946908a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729766825; x=1730371625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9ybzaQqZA8Pvjk1KH4zw/EHpgyxOggbtBG60Qj3t28=;
        b=cAaCIEIgB/iQaziGaCn3saV7NZgeG7+R8A+IuqC8PvFO0MX8zHzaREcSEinRfBpbz/
         PERjx33Fr2lmjdGnvXblpmwRDdyFD3kigpSy8uLIf+T9A5UA2kyPjT4XmwokCRFOrxtz
         vDOieoi/rIDyKZdMF5g501Nf3ikgok5xqzokA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729766825; x=1730371625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9ybzaQqZA8Pvjk1KH4zw/EHpgyxOggbtBG60Qj3t28=;
        b=o7IZIDd2runfM84YVNQ77wIMX5NOtcv1Pk7nS/nxGbLrCjzwCwYRLft6XmImWoJRK2
         B+1KIcwJr7FaC/je6MwmHR7LXCmdsbaqzI7XYghIsxz1/FygBTbQzW5iQ+kvoQ7sB5sn
         bVETIxd9hU5+4/ARSDzkekOsOwvKtNSnqcjC5Gab4PbkcdJ/9Epkz2v9S2VPUMDuXN1u
         L7PBGK2mFXMUo57J4dw4ZGUMGuaqek/8fhyWjgvDUdWXpq4GbFNNQNp+jbX86t0/2UgI
         WrJy3+GWjL+3XUgilFrgTh/FRl1HHfZYzQbeAmHQk8XwhxiUjAqfjZBVVMpqDQYYBkZh
         +Cfw==
X-Gm-Message-State: AOJu0YwgQUpTjXUHXpgOWAaZCN127dOnqLBVuapUo5y2t6O3WU1JviLG
	3+e8kdkFQGezMPuadu7wTVDkfbQesrLszUdeVEQ6EDSCc73KYOheox6pkI2K81wQi6/Ib2KBBs+
	TiXE=
X-Google-Smtp-Source: AGHT+IGhRRSH+oniiEMk6gBxA1VDr8hXYtyBVOVbECHZq5NiyEASc4rpB50zkmMNgG6T0wMWjBuJiA==
X-Received: by 2002:a05:6402:278c:b0:5c9:709c:247f with SMTP id 4fb4d7f45d1cf-5cb8ac380damr4405184a12.2.1729766825261;
        Thu, 24 Oct 2024 03:47:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:f79d:49dd:b804:3f48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c72866sm5525261a12.95.2024.10.24.03.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:47:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	David Airlie <airlied@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Maxime Ripard <mripard@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Stefan Agner <stefan@agner.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/mxsfb: Remove generic DRM drivers in probe function
Date: Thu, 24 Oct 2024 12:46:49 +0200
Message-ID: <20241024104654.3483125-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use aperture helpers to remove all generic graphics drivers before
loading mxsfb. Makes mxsfb compatible with simpledrm.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index cb5ce4e81fc7..a8d6dffcd02c 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -17,6 +17,7 @@
 #include <linux/property.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_connector.h>
@@ -360,6 +361,15 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free;
 
+	/*
+	 * Remove early framebuffers (ie. simplefb). The framebuffer can be
+	 * located anywhere in RAM
+	 */
+	ret = drm_aperture_remove_framebuffers(&mxsfb_driver);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't kick out existing framebuffers\n");
+
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		goto err_unload;
-- 
2.43.0


