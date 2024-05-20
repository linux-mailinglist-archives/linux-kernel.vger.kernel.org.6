Return-Path: <linux-kernel+bounces-183543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4617A8C9A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776A41C2140C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7581F94C;
	Mon, 20 May 2024 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oTUzr4Cg"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7B1CAB0;
	Mon, 20 May 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197693; cv=none; b=n+vXu8IyKCuMl7ygIYR6VNNgfsTjRT5g+NnHkDn4yT6ENSLplhb5/4g8e716YvUAib7BD/UFNahUkwc0AJ6CcYz3VELfTks7q8JYRYKI5DcHwexk59Q92gNWFC6VvYgITdKlUZHqCRj1TvrLbsLnm1POQ5IG1c3CY1RJ+NL4CHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197693; c=relaxed/simple;
	bh=+77XyCRDxsBQltBH9jjJSzxn9eZ4P3Vh9uHJPjCD1eY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXMMw/MhpeosV5fcKi/5gTeC1WyJrUdTyVnZEogw3bW5NL3dIdVyVNixt03pFgMZ4/LnZrIUMjaTQggTyvqAVZ0KsaVTVlVbFN0RVwD673Vgn98KIkFANdqGs7blIrJnLFBk/yUaHjkbQL5cWMxK8io4XfkcnPriH/218iUWz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oTUzr4Cg; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 8zPjslTpy8GJA8zPjsKGeh; Mon, 20 May 2024 11:34:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716197683;
	bh=bGqQuOEblhAm3peYnZztYMLeh0ncPzzrHa3zUm2ihUg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oTUzr4CgJ6FLx6ZgfRHMG1ly1+nqheFVnGDh8WEpzjTwnS6lXkT48+ruiXWnaZzLM
	 tB8onbUJyl/Cr/5Ws+TElQS8zZaHT4wJuirCmcDnUNAyDAQTKTXCduuWcBwDs4UEic
	 vaWqvbPozYOxYMNrOby0imhcE/uRcyrUJp13y1Pk1JlnXUx5Re7qmM9FJtew+wqouc
	 5VnuiqU5RGZKWOwtNBuAtQjLLOl1vKSJOyc0d15Pikiaq+sOZl8cxVtIEPw0hrnkDR
	 664iNHRCDMI8Nmnr63+GfbXwGuvwWVQmLGFnxUqrhHehwyvRLId4X17qMFDNz1+8bz
	 ZaYljy5npEpMA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 20 May 2024 11:34:43 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Caleb Connolly <caleb@connolly.tech>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panel: lg-sw43408: Fix an error handling path in sw43408_probe()
Date: Mon, 20 May 2024 11:34:31 +0200
Message-ID: <b8dfafaf1516b33dfc21e9ad27e31fe2a5820a5c.1716197626.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mipi_dsi_attach() fails, we must undo the drm_panel_add() call hidden in
sw43408_add(), as already done in the remove function.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 115f4702d59f..27f2ad788d38 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -286,7 +286,15 @@ static int sw43408_probe(struct mipi_dsi_device *dsi)
 
 	dsi->dsc = &ctx->dsc;
 
-	return mipi_dsi_attach(dsi);
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0)
+		goto err_remove_panel;
+
+	return 0;
+
+err_remove_panel:
+	drm_panel_remove(&ctx->base);
+	return ret;
 }
 
 static void sw43408_remove(struct mipi_dsi_device *dsi)
-- 
2.45.1


