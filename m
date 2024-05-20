Return-Path: <linux-kernel+bounces-183553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0338C9A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BFB2828B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B3222619;
	Mon, 20 May 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="L+2yBEhh"
Received: from msa.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91714320E;
	Mon, 20 May 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198063; cv=none; b=eCSlYo/F3zdV7PvEHsSIMYBqR7RX7Nr6xS7ZfQjGl29J2kVa1AfCI5tJHUf8GKwFEe3yh4aNHTtOcT4HgXt+LdDiPnB7DDS7FQGURDC16wuP3Y6ArvTCpEsiU7tz8pTIgK7Wrk3B/xsQEoKNXPhyrobVwh91HbW8SiDxHWN2ShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198063; c=relaxed/simple;
	bh=nVF0WvM42TTEecOP0ATh7bXHJ+8LpyzwZuXYehCdffM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUXM3of07wCtXoqqEIH7piH1cSdwhYfCKvLewhcvv+Jfdsr9swmkofQ+1MxNsAFaz0z3HPsEfroL03fkV/L/BizJX7hix44OS7M8RxTtxLv+kkafGL92mVuVgBU5uSdnXISotyMhJJpOBNcf56LaP+n6D0Y+KLtHNKG0fZuEKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=L+2yBEhh; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 8zVgsQHohrcIM8zVgsAdfk; Mon, 20 May 2024 11:40:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716198053;
	bh=3kjknBbjqfJQ6eLw8k3gflhIVcgh33eEwLFPSws9YCE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=L+2yBEhhgXi5xu2+LX9rSSwCMEbjT5QHl4m86H69IUBp1fMCGwNDcI+Uk5cNUKJwO
	 B5A0GHGgSK3/XSJWXi1qZ+pCVqUX4832Ujg5925ZFmBOsmXN8l5PNZ6/f1C8YjOFrB
	 ZJ/Q6dJ5aa6zqvnYVCJH/VvJnnclhbgGMuv3uSVpUgE5jX6i3Zah9nfranCk+lXFDM
	 msfF8qGUAEfd6fTYV3OLoDLqRyRf8yiY+n6b62yr4VutEUjhw8Yv6qGqbEmCh+3XOo
	 jLgNLXk+QFwblsvPg6jKAIvZKRFLOS0mjQCjeOkwAtE1hmy2EEhkmaq7zDJpXLCgLb
	 EDrvMFjLxmxlQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 20 May 2024 11:40:53 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm: zynqmp_dpsub: Fix an error handling path in zynqmp_dpsub_probe()
Date: Mon, 20 May 2024 11:40:37 +0200
Message-ID: <974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If zynqmp_dpsub_drm_init() fails, we must undo the previous
drm_bridge_add() call.

Fixes: be3f3042391d ("drm: zynqmp_dpsub: Always register bridge")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index face8d6b2a6f..f5781939de9c 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -269,6 +269,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	return 0;
 
 err_disp:
+	drm_bridge_remove(dpsub->bridge);
 	zynqmp_disp_remove(dpsub);
 err_dp:
 	zynqmp_dp_remove(dpsub);
-- 
2.45.1


