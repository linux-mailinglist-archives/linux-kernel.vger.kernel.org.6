Return-Path: <linux-kernel+bounces-382109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4CC9B0978
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190841C21A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6A17DFFC;
	Fri, 25 Oct 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O3AiF17q"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65015B97D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872896; cv=none; b=e3cWzAcQrpdGm3eZaZbtpUE67TrJ1JmfHW3y63Bfbs7jjuTELt2K8ApOgXd2eoES+9SZ0hc2Dh3M8rXU79ybrvRk+4eFITXWsQ4L9bbpucweQVw6S41X4G7h+8njSX9EVvHUpDcqmPZTECyGKwa5UXwN8DgRy+ne637kcCIG1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872896; c=relaxed/simple;
	bh=zXNxA16DutWXewQPnZ8VHN2QySLaJsJ0j0Tu8vE6LFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9kaAGToeQJmuTmLvoJNHqiyO6pTNkG87n19NJc5+D3ZUPvOdXyEfjHesmyWOYAoLEyo2nR8GFaoB4jQC5JeiQylQzMDGFOELGK1K8SZGVde9QKWwFFBuHU6E3Wjmnl0qXEI5XoHVdRCddHKF84zyAIyP6dXoiUhdsJ7Lz73SkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=O3AiF17q; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fbbadf83so3072002e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729872892; x=1730477692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GN13PFFztO+RVXylp070AHdpchWjZze0aJo+onIOSo0=;
        b=O3AiF17qhZhZ9SCtywQYffyoeuqo+k/9HBiSuJOw+6O1kMPGWrfP6qEUqbyS/K4p+9
         ftX1pyti9Cb+MKRuuU5vWtZW8RsXx4k9WSKXQp5SA4xJA1IwZFXG8FeFnzQymULexcwt
         DzTd0JypqmlpRUBvrFDd9GER1w8twAiUVenng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872892; x=1730477692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN13PFFztO+RVXylp070AHdpchWjZze0aJo+onIOSo0=;
        b=ebPSy3QSckFM1hr7YXk0zuGVnfB61b+6i1lwdpTThy6NZJ4QO6LEOwq675qxVXI6HJ
         W2cxNT7CPkdhCEKIZ4qBTLFYLd0UsiLav3T3h2PeBhrUMyaOpARgNwJ+b7LOPSQlPIjV
         InrUILOc7X1go4yWxPLlnXTl7GlRdTY6AVCULjpv220JFlOxAUHgON1PDNP57nv6WLkf
         35gMipCk5V/YQiQ154r57EWPHNwHEvY2uZIablTkhHFDAjdvhb+rQWlIc0oKWgfQT1Es
         YGz17uupihYhBn7b64tzo26vrRFd8n25ChBnP37gStBURlIV1VDQEiX570KNsKhBGcjS
         dzww==
X-Gm-Message-State: AOJu0Yw23TMUQTfvA8Fg2ZhAmwKdussLpheuu3KBuVkqVeQErAawPA1W
	rylp446VsjWicFqaYu3y7/Ftz7Ztnk5okNTxGDaQ08tJ/Kd6q1lLS0z4OP8PmPt/jaWZhO284P4
	z+ds=
X-Google-Smtp-Source: AGHT+IG7Ko0ZaVVixb42kGSXnwInD9+MTWs4okp1RbVG6KUd/qf/uSPa2qcn+su4qqA0sbbCFTHNBw==
X-Received: by 2002:a05:6512:3054:b0:535:6992:f2cb with SMTP id 2adb3069b0e04-53b1a36c6f3mr6404231e87.42.1729872892194;
        Fri, 25 Oct 2024 09:14:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.43.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b579613sm51759005e9.38.2024.10.25.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:14:51 -0700 (PDT)
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
Subject: [PATCH v2] drm/mxsfb: Remove generic DRM drivers in probe function
Date: Fri, 25 Oct 2024 18:14:25 +0200
Message-ID: <20241025161435.4114877-1-dario.binacchi@amarulasolutions.com>
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
index cb5ce4e81fc7..d140984923fd 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2008 Embedded Alley Solutions, Inc All Rights Reserved.
  */
 
+#include <linux/aperture.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
@@ -360,6 +361,15 @@ static int mxsfb_probe(struct platform_device *pdev)
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


