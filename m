Return-Path: <linux-kernel+bounces-210330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147A1904264
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4731C24EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148656B72;
	Tue, 11 Jun 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NLR0mZwh"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5254720
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126907; cv=none; b=EfEmz4JmIIZh4XFnKiL4YsCGTxVnTtYBE3LBsB+SLRAigFsTYMvZuESsDbmhful8gVU+rYmBMsNOxgt7WW2QWwOFVRn74/2Nw9T9qARCa6H37vcY/dSxDn22SL9g32V0dC3DaURos0HWZdsrHHXTveMrLEgOJRdwgkbRWKsrPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126907; c=relaxed/simple;
	bh=hmHXhTW2hnniL/AdiijPauoavnDxcJ2SRKK4L6njdtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0XFCgPrpCP7sY1A+z0rNIkDbgFZqz8Efw473hfCF4b4p4yEtEKDKuA9ErmUAKcIm+tAZbO2z/XlY2h8I0BjH+edmNUDSn+zOae9YXtY4lnMBbEfESoViws/NKDuJo7Q/ArSj+CeGukG7cXpzKBqR837zeb1IrQt6joBxdyg1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NLR0mZwh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f6c7cdec83so47789455ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718126905; x=1718731705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek9nYHCEplYURM/7b1b2h5qMkLqR/eL+WowxP0vSWY4=;
        b=NLR0mZwh5ooLD2lFRgSkLWIzUbYqg0Dmrn0snKPARrl7s1L5RxpMOtD/meVMOoDAoW
         eLMnPNQYSFcKnx/sSa0rWItk/fYrwbjBbOT2b107EGftlDrirMxZwBvlXNuSa/czaV3N
         hM3u2HkRtTO+oHU01LiJumkDjwxSU1+1vOTRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126905; x=1718731705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ek9nYHCEplYURM/7b1b2h5qMkLqR/eL+WowxP0vSWY4=;
        b=vPXKZqmejDjl3pJ2Vm5QNo1ldGld2qxiAQRPF02PLJ3PeL2arnrZGQx7Yj0YHRlnIa
         DN59nBvcgPFOORbRiP9EedUqpwy6CRQUjYksSLpDAFSs8nS4umSEHdk05z3PgH+CY8gp
         tnT1fLAD1ah9HBohqdN3XFEYx/Vy5/DyMFFXvjHW8HId8ZIkhuuI7HaalqrbZUPNGd1N
         SyxJ1dxnU9f6MKFHT//2/xtwYvWkbLJFKi2pkqBAXxgtQvOEQQqcraS9HCZS2L59Dvu/
         11ac+eaNirUeoVUVNkXwwYB0YBxsJXIUtHnLAkgXejJiHfjkRyCxXuM1N51sjjOZZEPH
         h9mg==
X-Forwarded-Encrypted: i=1; AJvYcCW6+7p5+z+XmQrheDk2KTiuBHBHVucPuYQrZhcpqSPTMW18Os09qnRhALzi5cPKqkiqJDRFn1smySgGUsw2+b0ymKqbJrPoMxB/XbSC
X-Gm-Message-State: AOJu0Yw9ySn27nQh24ffazUBk+4PSoK3WGeaPDAkyvP+Rz/c0HcuXB5s
	We7iF0ao+OBZipuhql2QNVps3m/ffsTugqPpBLsjtYcSWSn2M88FuKwOC3nadg==
X-Google-Smtp-Source: AGHT+IFJ4n9j/I8+bwf5nby7cNuNSwpvL75gc72i3EraZAd14f2XpX1hujkn20i8r/RxoP3yzvg2rg==
X-Received: by 2002:a17:903:244d:b0:1f7:eb9:947e with SMTP id d9443c01a7336-1f70eb99809mr68387405ad.63.1718126904826;
        Tue, 11 Jun 2024 10:28:24 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f410:2f13:37e2:37d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6e7858544sm75714375ad.75.2024.06.11.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:28:24 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Fei Shao <fshao@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time
Date: Tue, 11 Jun 2024 10:27:44 -0700
Message-ID: <20240611102744.v2.1.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

This driver users the component model and shutdown happens in the base
driver. The "drvdata" for this driver will always be valid if
shutdown() is called and as of commit 2a073968289d
("drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a
noop") we don't need to confirm that "drm" is non-NULL.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
v1 of this patch was part of a series [1]. It got tested and reviewed
but never landed. Reposting separately in the hopes that Mediatek DRM
folks will land it. If, instead, Mediatek DRM folks want to Ack it I'm
happy to land through drm-misc.

I noticed that this was missing when I failed to add "mediatek" to my
patch series IDing which DRM modeset drivers did this properly [2].
Assuming my patch lands, that means that Mediatek devices will start
getting more warnings printed.

[1] https://lore.kernel.org/r/20230901164111.RFT.5.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid
[2] https://lore.kernel.org/r/20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid

Changes in v2:
- Removed NULL check since it's not needed since 6.7
- Rebased on ToT.

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b5f605751b0a..de811e2265da 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -952,6 +952,13 @@ static void mtk_drm_remove(struct platform_device *pdev)
 		of_node_put(private->comp_node[i]);
 }
 
+static void mtk_drm_shutdown(struct platform_device *pdev)
+{
+	struct mtk_drm_private *private = platform_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(private->drm);
+}
+
 static int mtk_drm_sys_prepare(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
@@ -983,6 +990,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops = {
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove_new = mtk_drm_remove,
+	.shutdown = mtk_drm_shutdown,
 	.driver	= {
 		.name	= "mediatek-drm",
 		.pm     = &mtk_drm_pm_ops,
-- 
2.45.2.505.gda0bf45e8d-goog


