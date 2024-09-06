Return-Path: <linux-kernel+bounces-319415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF396FC52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA4E28B247
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A861D5885;
	Fri,  6 Sep 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E4G3y5qP"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715F6EB7C;
	Fri,  6 Sep 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652051; cv=none; b=qbe1yhSJpwMFuc6MZRspbyFFrkJf4Fn/5dtPXxcibh2pex6HCRMD4qs7sBsIYUamlan59q967wuFv8b3DiTud+nY7//D28t4YqL9ePbvbqFn5IGh32Ktha9Lfl4EhP8gK4RbBGtn4WwQQ4j1P6RelIS6LuX1vUmTcQ9FG7mY1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652051; c=relaxed/simple;
	bh=XbV4G23yHZQt0Afyfcg56V50a4AMQgZBjj0zuKMcjJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BW0rmppLJZ3u8WugLqCzeGTiX/4j1QaZH+25HnLAs0obkhT/u/pnLf9HfZF5zts3/ntth4Qwk8Wl5ImFIBhfCJPhUgvETDsWMThyrKJOb5FkR3903RGJEsYjqSfheS00Jc/ZyXAh6PirTJOa5zNv3nuJ1PLSZ5r7H2eniORpmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=E4G3y5qP; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id mevBsT9PpGrBemevBsXT6K; Fri, 06 Sep 2024 21:47:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725652040;
	bh=+Da3YG45hYBpjGQbOAK9bnsoiqlIfkN8ZztMmx3F5yk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=E4G3y5qPUbQ0ybAxno9HO49+HCCyR9DDuZR0Q2jV3MWK6exeZ5zoDY7lr0x/UALpT
	 y+vBnTduSgfIhWgYOkzU8ApCFhnR5DZ7iL6jE55pF1x+men2aiCGUnhWJQ0oX8Tgng
	 4q8/TTMBhUj6AsXln/f9GvBsHjaFBLixe+aYDmI/bg/I7WXzvsAPY0fF+BDkh372J0
	 2Eb0KTU8BCVSmRqDst2CYj2b2aNUQ5YWVjcKIRY4XRF2coIKRDGKFQcYE/FQtfMxsW
	 zxXQa0kcUtlEbau6xQDhxqnJis3aLD2sLQDC/jl+plgWAPJhWjNhQB7vBlPECayMKM
	 QVWA17oN+hx1g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Sep 2024 21:47:20 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/ipuv3/parallel: Fix an error handling path in imx_pd_probe()
Date: Fri,  6 Sep 2024 21:47:00 +0200
Message-ID: <1cdd8523443d8850c5531462b30064cb2058924a.1725651992.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If component_add() fails, we need to undo a potential previous
drm_edid_alloc() call.

Add an error handling path and the missing drm_edid_free(), as already done
in the reomve function.

Fixes: 42e08287a318 ("drm/ipuv3/parallel: convert to struct drm_edid")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 91d7808a2d8d..6d51203f7f0f 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -350,7 +350,15 @@ static int imx_pd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, imxpd);
 
-	return component_add(dev, &imx_pd_ops);
+	ret = component_add(dev, &imx_pd_ops);
+	if (ret)
+		goto free_edid;
+
+	return 0;
+
+free_edid:
+	drm_edid_free(imxpd->drm_edid);
+	return ret;
 }
 
 static void imx_pd_remove(struct platform_device *pdev)
-- 
2.46.0


