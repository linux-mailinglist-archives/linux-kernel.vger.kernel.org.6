Return-Path: <linux-kernel+bounces-433654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F4C9E5B41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FB6282978
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5DF21D595;
	Thu,  5 Dec 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qjnPLyqN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872718B483
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415879; cv=none; b=VGD8ee/ilTltvPgmU6OLzA7+JNIEzlRy+JiXzOd4p+CiTAbAOZ/WInA8+399EgOk+wLvirnIXC4JFmnz1KzvEi7zOs01Fnu3flthwtW+T7+nGlK0VWqb9sR0xJsCaX6BOGqbIwo3OxkSxiygK16a7L5puLOlO/BCtFGpb7hmqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415879; c=relaxed/simple;
	bh=dNZEbm7bSlhbjJGLhWJD1Ps63pwrMUfHSEN/U6Xa5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6s6S3Y/mIABz5L5iXJFgO0t5U3pgv9awvGwlT7Zqh0M0zOtWSBsBnMhSNvocRO6SeBCzXgF2DQg99gwX9NV/PwkFIQ30JE4xACQHyFBjoROfxWJjITQ+SaN87F5dFm0d2I06TFgf/Qml7pvh/YgZn4wU7ICZvP47LbmBnbUIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qjnPLyqN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso1148622a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733415875; x=1734020675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+EB++J/yowUMrD7IvepBqWDVig6KUMpfQ1WpjD4ens=;
        b=qjnPLyqNg52SD3W0rQJuBZ9Gs8Isf9PbFhqdBTTSDWPsYA+2GlBjEt+3jFJi0uI/il
         Ra7Iz6dnC7MVAqd+ccwQUOqzFYVLUl9AfqlTdS0RQanDrRhYsp+WMdhUzmn/wFMVlFBO
         BpmtfLtI6TRS7+D0IxOyJukPGW8y02b1vfo3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733415875; x=1734020675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+EB++J/yowUMrD7IvepBqWDVig6KUMpfQ1WpjD4ens=;
        b=eefQE3PBvbCtT5ZziB5dfg4e6P9vkti/epBC+ivJ/CPuDrNkEfS2akGZG7ov3diBS7
         wUkMm7dxu2xFxrBeNW1RqBhBfdVljrTuOU9LA4ay49mCGBbMIvyChgowtdlEoBV3x3XB
         GmO0Z5asjVsPWKsqx0sUPeZSKsm6mkACf//ExhZrzGHpI5OPFP2xOTJ50JpsYjqB5Mzs
         rt+PfRUIz1BD+7CPPzH94iv18jwrwOXGbXzp6et5uaIfp9gR5sILKRS0Nh0VtJQ/OXuu
         m3DPJliEuE68qnOZ+fT79eWNzD8XyXrH+hibWTNjShC0vmO4E05VwRuszgQ43hqD1Jlf
         Augg==
X-Gm-Message-State: AOJu0Ywx+iSS83+sk/lYvDMiqu27y9+UfmgbOC/0i4M/yNCwH8xt6YZz
	Q6UP4u24JY1rA6RAPPzuxxLLy7VNsi1bq+v/jOfuNruNsXKMRS14/rwqjyPNpVHdrwJ+Gqcw3PD
	V
X-Gm-Gg: ASbGncvdVMYhoiEyAJCe+3Pn42bALjK8GYamaAuBG3xGuliC2z7Ig/PlxW+j6906rf4
	zXoWsRpoYq2kd88dpzkEyzbTsSLGA69tQk8DEVkAq4c2mCZrkiZHKe/KBz2RUOkuKwPYcA+ESx3
	1+gtoDMN7qys7I+jxHN8nM0oDP2w+6764jyWM/3/mXBeMZNN1afN2VVIvAM109QOV1J8c7pWkPn
	Of/oKQ+UlvzXbCPscXeb5q8pASpwMMdiKOqyhGLX9gNaK+2dnl58Dx/K3LSRciKm4m2+3zsZXs5
	XNGuqNh10zpqi9tkxa4y+xcEXooKxeD4ErcdEVbY76lobw==
X-Google-Smtp-Source: AGHT+IGADqZ1DS4WW7fjZME67XfYyJ9/Ms38VwzFpIjDiSj4wLXET1zw9ysNdFxbGcj293rTqfarbw==
X-Received: by 2002:a17:906:9c0f:b0:aa6:24a2:697b with SMTP id a640c23a62f3a-aa624a27056mr315906766b.27.1733415875558;
        Thu, 05 Dec 2024 08:24:35 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dee6sm112286566b.32.2024.12.05.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:24:35 -0800 (PST)
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
Subject: [RESEND PATCH v2] drm/mxsfb: Remove generic DRM drivers in probe function
Date: Thu,  5 Dec 2024 17:24:23 +0100
Message-ID: <20241205162432.1803869-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Use aperture_remove_all_conflicting_devices() instead of
  drm_aperture_remove_framebuffers().

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 6b95e4eb3e4e..10da8b54f4c6 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2008 Embedded Alley Solutions, Inc All Rights Reserved.
  */
 
+#include <linux/aperture.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
@@ -362,6 +363,15 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free;
 
+	/*
+	 * Remove early framebuffers (ie. simplefb). The framebuffer can be
+	 * located anywhere in RAM
+	 */
+	ret = aperture_remove_all_conflicting_devices(mxsfb_driver.name);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't kick out existing framebuffers\n");
+
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		goto err_unload;
-- 
2.43.0


