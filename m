Return-Path: <linux-kernel+bounces-384656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798869B2CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E578A1F232F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778D1DA61D;
	Mon, 28 Oct 2024 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kW8m69yn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944FB1D9A59
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111189; cv=none; b=ElNgMwe3QS9XJwaTzKbp3RCs5Oi6JpnUc5cJ5FdzDEpK5BhigMfv5UR/muhac8EWKPcxBX+8tUaYShNYFB3Jjbf2TLeODY0BK94zCsZSc2t0Sy05Etdpjx+iK2ZJ1k5URoRAQmouialw6CCgzqOUMMZ16gb6Ww6NmDJHvkczKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111189; c=relaxed/simple;
	bh=SGAmR4rTXOAGzH5qe9m5L7xwcpV493faJv+dbyO/XxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYTAWrADl2sYMKxVCIOG34BRaSKh4U+nFe+3WXR7Xy2DY+MQ8bQQ2bDkaNdq0UxgI06QMGhAEBSE7mftpLWbZp2WAwGx25jxF/DYQSyrMt5gEQygbcRMeF2s7UaYxKGBFtcVsrUJyuZYXAnJ3aZ+m5BNJKuWYlkXvikUY2TgImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=kW8m69yn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso510225966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730111186; x=1730715986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIDm7KBT1s0AbOc3yV3TQ9ohvs8sUqIvua5HhBI5V8A=;
        b=kW8m69ynIWguR5/Gg9loXvITIGopK9GVYHQv0ZBvk8osT3ntZ92IEVlFj5sBnbv9/M
         QYKUtklWlJuro67pREnNj7py/M0CLFtfywnKh4H6dJcxsAKVXD5+oPdNUUBU/49ddXHb
         MA1Yq1hzzNoLoE5aKMgNeVB4B9frC/gJ537dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111186; x=1730715986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIDm7KBT1s0AbOc3yV3TQ9ohvs8sUqIvua5HhBI5V8A=;
        b=kvxYTf0Ak+7qYhRdHaj7z7LDi3+87ILyzIHx+iY925sP1oo1GJIVtSuYG/4+GDiUPf
         Zp20snNhnT6wttJaccwqnYWQjx8tGVAPQvkEJlqKJqOKWsH4m4rnSW1lCrSv1QsRmQm5
         nHVGfFaFfhDMbzIwVkqwq9K6ld700XWSqKQLN1PE8GlXSZ7rppAEXEfNmL75oKo8O3zJ
         IX9KudHht5/l1pC1eaQHp8Mc1sK8sg/wf1472XffJldiGwDL+4oViz9B52sDO7ZBQo7N
         54A3aWjDpjxCH7mInOSg8cZJ3AuGHHuOEmGCAFzNqCB1xfHeDmfbMdrL15ykdzOD3qvz
         fzBQ==
X-Gm-Message-State: AOJu0Yz1Ia4/wyOrmerGc16BB0xmNYYVIH0NhHf0m02Gb3DHg9O81YUY
	/wQARfw1nXZm7n27/22cZuWFqwZqkjomnvm2Csd7Ep77gvRT18l1aQ64OXYctApW5cWydfb5kf4
	wXvY=
X-Google-Smtp-Source: AGHT+IEA5nCg2j7DVomJoAqNLW+z2Nbv9V6XM3cl17RychbK0FRUPkeqVCDGC4TH9y5e5TfNamZx8g==
X-Received: by 2002:a17:906:da8a:b0:a99:425c:c653 with SMTP id a640c23a62f3a-a9de5ce24f6mr866426966b.22.1730111185881;
        Mon, 28 Oct 2024 03:26:25 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm363613966b.134.2024.10.28.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:26:25 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
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
Subject: [RFC PATCH 10/10] drm/mxsfb: stop controller and drain FIFOs if already initialized
Date: Mon, 28 Oct 2024 11:25:33 +0100
Message-ID: <20241028102559.1451383-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
References: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You can't re-program the controller if it is still running. This may
lead to shifted pictures, so stop the controller and drain its FIFOs
in case it's already properly setup.
This patch is crucial when supporting the simple framebuffer, as the
controller has already been initialized by the bootloader.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/gpu/drm/mxsfb/mxsfb_drv.c |  3 +++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h |  1 +
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 14 +++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index cb5ce4e81fc7..38c94cdc8f6c 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/of.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -221,6 +222,8 @@ static int mxsfb_load(struct drm_device *drm,
 	if (!mxsfb)
 		return -ENOMEM;
 
+	mxsfb->enabled =
+		of_property_read_bool(drm->dev->of_node, "fsl,boot-on");
 	mxsfb->drm = drm;
 	drm->dev_private = mxsfb;
 	mxsfb->devdata = devdata;
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index d160d921b25f..0f9ae4ce450c 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -47,6 +47,7 @@ struct mxsfb_drm_private {
 	struct drm_bridge		*bridge;
 
 	bool				crc_active;
+	bool                            enabled;
 };
 
 static inline struct mxsfb_drm_private *
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index 7ed2516b6de0..d064a2bb65df 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -202,9 +202,11 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 	writel(reg, mxsfb->base + LCDC_CTRL1);
 
 	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_SET);
+
+	mxsfb->enabled = true;
 }
 
-static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
+static void _mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 {
 	u32 reg;
 
@@ -221,6 +223,13 @@ static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 	reg &= ~VDCTRL4_SYNC_SIGNALS_ON;
 	writel(reg, mxsfb->base + LCDC_VDCTRL4);
 
+	mxsfb->enabled = false;
+}
+
+static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
+{
+	_mxsfb_disable_controller(mxsfb);
+
 	clk_disable_unprepare(mxsfb->clk);
 	if (mxsfb->clk_disp_axi)
 		clk_disable_unprepare(mxsfb->clk_disp_axi);
@@ -354,6 +363,9 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
 	u32 bus_format = 0;
 	dma_addr_t dma_addr;
 
+	if (mxsfb->enabled)
+		_mxsfb_disable_controller(mxsfb);
+
 	pm_runtime_get_sync(drm->dev);
 	mxsfb_enable_axi_clk(mxsfb);
 
-- 
2.43.0


