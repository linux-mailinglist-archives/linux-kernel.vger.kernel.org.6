Return-Path: <linux-kernel+bounces-440855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A249E9EC57A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0E9285C52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857751C5F0C;
	Wed, 11 Dec 2024 07:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hTKEFzxR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589591C54B9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733901615; cv=none; b=h/d55uL7xAgTAhf08nx6VTzS1dOcCXq0ZDjhj808hTuzww2GicsKnrJiHiCiIDuoBJAYQA6UmwBO/xYNcjcVmglJbQaIDUGvHF+ImnPI7vZLOx2AP2oWx4C2i38lFur4nyj58HO6PBPPUz62TmGTmdneXUlpJKf7orhIoA89B+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733901615; c=relaxed/simple;
	bh=Q9qWU0tUxE9edYJc5FMZlnQo7oDzX1C1W1TOLELsPas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMH355W+sIWJvWq4qkQK+hke80ORH6WFe5Zpz2+GbuKfndwBFrQbgWCArn/ImeIm6tm1lgmeEh3ViUhRPIvbj4ZOl4eAW+490maXK/DET7s4tyDPAQUcENkRnhrsq6M9V9/qtne/oxwDYNi1vySDaBSjsWq++8t25Sme5Iz7Htc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hTKEFzxR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so3690295ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733901613; x=1734506413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cb20aQBdVO9cyiblKIOeV0cEljjD8IS2jrvpmrNd1k=;
        b=hTKEFzxRoBTckS6HFP4E79LyebXVb1SJXHtVrjcxkytHiQDgIDVQxnkiMNrRiC9/K5
         Mu4/aJVpTMZuOntoBY8qTPQA2k/G3YJ73/rD/CDdyuQI4ALsuCgZu1sBUklnn8i2aYxR
         3OpL4yllWy1ggCXUpWC4oofvDSVqu03Yk8Igk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733901613; x=1734506413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cb20aQBdVO9cyiblKIOeV0cEljjD8IS2jrvpmrNd1k=;
        b=Wkayv3R4rCnNkwAuX/snGT2lNFKiqshfugyZ0Rvs6aGaBtoGyE+FmT6bOLlRF2387d
         Y7xoUUOhCemskfdv6j7DqE0JQ7boXhmDOGphAfjec5bqMBizm7MgFQzjTtpxb0VvFtrk
         t0eZXHSvsd7VMx9oD5/FpDYq3xrn4o/3IVxdgGM9g6KH0MC0FyN97VVB2hxqH7KdnTdR
         ESKt+7uuayBCMycudOl460+7GEgfXkTt/JYAcoXYoAy7KDnSKY4eVjFwPQeBBaPKhlGI
         R0AuIfv2cErGYLILPZrsqP4wXcxNY6AC0Ep28nGUBHD/nLEIgyjw8VdHP/aTmz3EOsqB
         EPYw==
X-Forwarded-Encrypted: i=1; AJvYcCWNjBV8O+Xgmkm+eAHHF+MSajMI1FAQQvLFHIq2SokqloX6HGDtblMZygtD7Z+NAwxIj93TROXN6anQzIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRsmnIrKISEbrPnVZaav4Rv9RA51OXZSL9ckqmucYNHs3CzDg
	JIQlCDD28dC6dA9oSTDtIGPGnlAGoNq8DpfSjLuSDqin2oL3MEaqR4X6/S8AlA==
X-Gm-Gg: ASbGncvV9FjZ5OCcyt3USTMIR0qP+r328YTdOkn5FoevBSqF+/A6u+67jIwpc6j9wnF
	rk9AWSl3ALJmP+cOtcaiJimVuP4LTw2rYC8IF8NNVckPROkJuyYIq2t1vl20qkoHqMjL9Nme0Fb
	dXR0GkNaa2g8yHw1XXSgaOUsjaktO1pubcvZ6NRTOcg5THB4KxHvBl64RKaI5bCzgM2Hs+jac4E
	CJdEfYn5uHKpUcORRkdPtvpz3peRLWNaL4mJ+x4JmswVbpS1oqNng6gSFEw3me59M8Fnjp6
X-Google-Smtp-Source: AGHT+IFb/j40l8RyXKKBP91IUhP6PaUxTTbrpQWP3pPlzKpxqE854bcUMGQOoZq9SqoelV4WQPakhQ==
X-Received: by 2002:a17:903:230f:b0:215:b1e3:c051 with SMTP id d9443c01a7336-21779e450e3mr25924325ad.11.1733901613656;
        Tue, 10 Dec 2024 23:20:13 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4dfb:c0ae:6c93:d01e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e41e52sm100214925ad.3.2024.12.10.23.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 23:20:13 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v2] remoteproc: mtk_scp: Only populate devices for SCP cores
Date: Wed, 11 Dec 2024 15:20:07 +0800
Message-ID: <20241211072009.120511-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multi-core SCP support was added, the driver was made to populate
platform devices for all the sub-nodes. This ended up adding platform
devices for the rpmsg sub-nodes as well, which never actually get used,
since rpmsg devices are registered through the rpmsg interface.

Limit of_platform_populate() to just populating the SCP cores with a
compatible string match list.

Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
Cc: Tinghan Shen <tinghan.shen@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Fix commit subject: populate devices *for* SCP cores
---
 drivers/remoteproc/mtk_scp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 0f4a7065d0bd..8206a1766481 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1326,6 +1326,11 @@ static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_clus
 	return ret;
 }
 
+static const struct of_device_id scp_core_match[] = {
+	{ .compatible = "mediatek,scp-core" },
+	{}
+};
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1357,13 +1362,15 @@ static int scp_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
 	mutex_init(&scp_cluster->cluster_lock);
 
-	ret = devm_of_platform_populate(dev);
+	ret = of_platform_populate(dev_of_node(dev), scp_core_match, NULL, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
 
 	ret = scp_cluster_init(pdev, scp_cluster);
-	if (ret)
+	if (ret) {
+		of_platform_depopulate(dev);
 		return ret;
+	}
 
 	return 0;
 }
@@ -1379,6 +1386,7 @@ static void scp_remove(struct platform_device *pdev)
 		rproc_del(scp->rproc);
 		scp_free(scp);
 	}
+	of_platform_depopulate(&pdev->dev);
 	mutex_destroy(&scp_cluster->cluster_lock);
 }
 
-- 
2.47.0.338.g60cca15819-goog


