Return-Path: <linux-kernel+bounces-546985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CFA50174
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE477A7326
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495524BBE1;
	Wed,  5 Mar 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dmf+kJ1B"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26421883F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183776; cv=none; b=Etdf9SxZP843J2oAGsvz2J54+EL2rAWdt4JbS/MepHdn2xzc1wjlaEw9k76SrXtrLXrxbAENgIj46+2hG0QOW1Rs4WKVTLlWlM5IwfUe7YOEw+7TqSN0t0qSr6IeumHfYN4oUPM8icNIXSGj8qd3bHWKukLs+UHepqVQC/oEFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183776; c=relaxed/simple;
	bh=FvXY0J6HFmz+F4kGGhdiUtByaCV/93S7mXHV8f989j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2ROjpQbMRkUqRBwO8Y+x0sa5eUV3RDXn1yVaVBRB7TDO03IpuIO909KKIyzS42fXCbnru3F5d23KzdI4U6Cp/WiADIsGORp4YYsAFTEn3mPfBxQvtXnvZa/EZKjGxH6k1Ba1WWWXFZtRprvfYhKJiR4eCMVpGxQNf0pWmwZBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=dmf+kJ1B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bcbdf79cdso13343135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741183773; x=1741788573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jC9QV0bJcgZgqHHH3SUMbf/vptPD4PQ0vRL1kkv5HIw=;
        b=dmf+kJ1BMTAdKht3zuzbTLPXVuu0r25DkVDwLI0chvLzRUE1FSR5UdWrAH52yawyqG
         8ycHT09GFAFyTbDrCrGS/8bd2nrfziSoqG0bMo2UONhKwtQz4tsRuq6mdmtNHRY/FWCt
         gdHGS5VxjVijcpF2rqX9AUqcdWCHwh/KJV4Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741183773; x=1741788573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jC9QV0bJcgZgqHHH3SUMbf/vptPD4PQ0vRL1kkv5HIw=;
        b=vVUnTMK5sEW9Nnvs9KtE/mztgh1ANsngaPM0d21CX7ue+Cht4IsJCRSp75RG6SbsU8
         8Wmf8kNCcuIptT9P6WfE4hlaHIjVmIAxZpIY8KGkzBCCl/Qnqf3MKo+rKdg+03z03p6q
         ZzkXBKMMx/bRqVpwnp4whUXGsB2oP7RqpIp/WZjgtxKNQvVcy62zyeVC04Sg7EiSalOf
         XxO1pKrBNPOQO7MLdNUTp8szuXLCoY4t3DnVRLOFSH/XENosV7y91GjFdpL3xvzlAS9q
         asNqJck+sYAB3oQC4gUQyh11q2PH4TzRiHMddFi24NcZ8DAL8OWOC4jzF89VUK+HScBs
         iYag==
X-Gm-Message-State: AOJu0YyhUJdd4T0z7PVN0LxFDJ/ww7keSoBa6ln3Q1fL5pvl9vh9K11O
	mko1DwWMplWXWSq0cZAVU7whjUCbd4BMrHZfWhkGuOVV7RT+OZKekGk4b46DYYwbnL9AibMVsxg
	q
X-Gm-Gg: ASbGncueAyleTLLw4dGkW7FuTRr7UyS0Q/8hUON2AZCYYzqQtQpfsaU9XfZ4wlhkD11
	iEjdhWq0rZ8BJA9jtQqklm25nrGG1r2wE2yytlKMq2Le2TDbOxXuvkH72hbrW4I2tnVoJW7seJJ
	gTNP2TqE2DkNmZfu5N80A8Z95/ZliAufVvx7vmBVxnJtu1RMySULrAyu86mpR8Pnj1f+X0Qj5Y6
	AXmS8E/pFiiseA0dd7GcvsqP87UgIZLS/2UaR9H57isHOh6LyCD9Geu0Fi5jkZpizVx/vo+sWDZ
	eRHSdN6YuuEUC1Qrnlo4OwFIFoyCvkJzOuBk06U6i6gv9V2y+mEq2wovX49wj/g/jbIf17+BDay
	8G/c4
X-Google-Smtp-Source: AGHT+IHdccH4w20LAtL5Tnt1zvD+qT2oMJLO3EagpAUtyRarROFNC3ETwO4Ig2JSfhHI6IHFm6KeuA==
X-Received: by 2002:a05:6000:1546:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3911f7bb461mr2279778f8f.42.1741183772882;
        Wed, 05 Mar 2025 06:09:32 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:334:5d7f:7a52:9e84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4847e62sm21374802f8f.67.2025.03.05.06.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:09:32 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v3] drm/mxsfb: Remove generic DRM drivers in probe function
Date: Wed,  5 Mar 2025 15:09:16 +0100
Message-ID: <20250305140929.174398-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

---

Changes in v3:
- Add 'Reviewed-by' of  Thomas Zimmermann

Changes in v2:
- Use aperture_remove_all_conflicting_devices() instead of
  drm_aperture_remove_framebuffers().

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 59020862cf65..e5eb644b54ae 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2008 Embedded Alley Solutions, Inc All Rights Reserved.
  */
 
+#include <linux/aperture.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
@@ -361,6 +362,15 @@ static int mxsfb_probe(struct platform_device *pdev)
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


