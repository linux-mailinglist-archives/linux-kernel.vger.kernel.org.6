Return-Path: <linux-kernel+bounces-201600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D68FC093
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7931F258FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD46244C9E;
	Wed,  5 Jun 2024 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KKTL7hdI"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76922E62C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547090; cv=none; b=MMFx4bYdm8nqiOcuqiUSNU5BNj9BnzKNCMCQVmMoD5AEQLwyAI87zkkPkyB4juGVGIoUl2xB1ca/YwRRsbkV+my/hk5YInIHa8Y+ScWEFqwZwHEXQYbnSFM0BDGDINlAlCsN5fSsp+2++Z4xydh119JzK6/5wanSJayT8F8upkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547090; c=relaxed/simple;
	bh=vhPzviMn/rgVDu1u39BrxfVEMMEmR6rzDMtKb/Q2+t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ8wbix7Cky+4mOrtTXhhWFSyYFZEQ3xF4TQbyDNuSgwoanjvtg5I7q0fILeSWgFmBxWddsI3fkSZmnoMDQr2EOb59RormKF3MmHn1ymGuv7R08GTpJJ2txq6YN4Zpe5aqT+wAu2dmHgDNKMY/rbv5bkvwQFmf7tCvxPpfd2xEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KKTL7hdI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c4f3e0e3d2so1431902a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547088; x=1718151888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msnwFK/XkOnU7RbguwwCWHAg9Wx/3x8graQzx6Y6iJo=;
        b=KKTL7hdIGbHSJ7F3AI04zkcuF/O9mYCAWHDPHZ70FlbsqQdIOHIXn3cCIwRqHrLwr0
         8UcIx2fg7xw6TPAI8XMtom2Yj7+voJDTw0QBCCAYjkY3UgR7SwZjsU28lVPPOM16f8Bx
         jq4zEejRKbX9Q2bjjZ+IgLCAYSXy60rsLF8qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547088; x=1718151888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msnwFK/XkOnU7RbguwwCWHAg9Wx/3x8graQzx6Y6iJo=;
        b=dch4EGprvdNfPrsxqrT3rcIht9P8pvbSvdB06yNyfoltfi+IIec5n9xgNa2KhIbMXW
         QaKAqFdITo8rc1OxSCwCEeygZp6Dalyi4eiqW9FijIQPYR1wM/pXRk+viXuLkeoXJtKh
         OjQHxbxY5LP2VkTHvHMjkXlyG2XyFxXNf9XlDoGXxqMM3t4/86P4qXQmZoHO2RErTey4
         GL+718Yc12PaHvI4f8DbrJ2nbGTUwZpv/zoiYBafOIseYWNEpdySgyb3/C3x6cIgWfWL
         z0uVtfHlp5mXf9SGK6vYQtXe47dqyVYNMUd8HVATra+nU2ZCpxLT0ftF48liZfei1JCu
         BEqg==
X-Forwarded-Encrypted: i=1; AJvYcCXrZ1TZwajQkdU31+MWqwyx9dvbLD6WfTukXwOgA3n4b5cpOFrzbiw0yblkWuwz4JfeP92D/YXQDPcRLhPY+BfhGcu6GySi0x6h4PTT
X-Gm-Message-State: AOJu0YzXtWCsJ3jT+Z6VjTHHhDSdbFsaYPLxH1dczZ7hK9wLj24cFvmm
	aEVGQKjIG9Eifpgr0dGu3CWvWoCVcFi70BWFEHdEv1GYpeJnI7JQT/hG1ew1EVnkCjtRiHuTzlU
	=
X-Google-Smtp-Source: AGHT+IFbuMMubq5nzPSGHbnA/7JCHbN1RIJ5658MiA6y66RGqchQoA/HmoffnqBh5Mo5cI2sbFTEzA==
X-Received: by 2002:a05:6a20:1590:b0:1af:d153:b76a with SMTP id adf61e73a8af0-1b2b6f68b99mr1497594637.18.1717547088161;
        Tue, 04 Jun 2024 17:24:48 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:47 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Marco Franchi <marco.franchi@nxp.com>,
	Fabio Estevam <festevam@denx.de>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/24] drm/panel: seiko-43wvf1g: Don't call disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:23:02 -0700
Message-ID: <20240604172305.v3.16.Ief712fb6720cb98bdf9ec8644362d028b6554f9b@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240605002401.2848541-1-dianders@chromium.org>
References: <20240605002401.2848541-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

A grep through mainline for compatible strings used by this driver
indicates that it is used by IMX boards. As far as I can tell, all IMX
boards are now correctly calling drm_atomic_helper_shutdown() so we
can remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Marco Franchi <marco.franchi@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: imx@lists.linux.dev
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 98480904126c..8a3fe531c641 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -243,14 +243,6 @@ static void seiko_panel_remove(struct platform_device *pdev)
 	struct seiko_panel *panel = platform_get_drvdata(pdev);
 
 	drm_panel_remove(&panel->base);
-	drm_panel_disable(&panel->base);
-}
-
-static void seiko_panel_shutdown(struct platform_device *pdev)
-{
-	struct seiko_panel *panel = platform_get_drvdata(pdev);
-
-	drm_panel_disable(&panel->base);
 }
 
 static const struct display_timing seiko_43wvf1g_timing = {
@@ -306,7 +298,6 @@ static struct platform_driver seiko_panel_platform_driver = {
 	},
 	.probe = seiko_panel_platform_probe,
 	.remove_new = seiko_panel_remove,
-	.shutdown = seiko_panel_shutdown,
 };
 module_platform_driver(seiko_panel_platform_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


