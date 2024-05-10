Return-Path: <linux-kernel+bounces-175391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45B8C1ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498401F21BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C595315F3EE;
	Fri, 10 May 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGziLwX/"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461891F171
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325301; cv=none; b=UVbnY5djobUF/aRDyZHbpBGuhmdzDp2KR0N09wxmPapRnDR5PgEkkDFVC81NtqS4l4S8i+WHPQ46RJvv22yw/dm4wI2Y6bja59BYKHw4XkidMYhGULxmLcbMtmxwnWp1dQXj6oLIHBManzCdh6q/STmKvxjtD2QCzAf8DIuSPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325301; c=relaxed/simple;
	bh=RLWutmpFg7NwnncRkkWuTv0XDGWX/OwDTTXFc1qh27w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBctm+B1KbuwLRzWzKGgF2cdIqq3yu1X2FP/huTh5A2gzmZj3fDx8r+NY8EBPHf5HN5V6Px67P8hODW1vXxDPKgnt1bqRTB2GbLjH78OOVgtjMMATvqO2OT/xrRhzUER7dHM0CXvEXZ6TSkY0615IPdMtQfjxIv6EhI0wHzbTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGziLwX/; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23f0d4353abso1106445fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715325298; x=1715930098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+hTb9Uz5fZ3Gvx3REvMog4ReTfehsa0bk9kBNaBktU=;
        b=kGziLwX/5/4EP0SQnaLH31VI2SvlgaDH0m5Utlj+ORT7trL8SL9FX8MDzccdbo7SbY
         hdwFL/zEBJCYLKpbb7xi0B9sor3agW5QTOTEwOLe4tVjryTg3vMjbyv/IHJYKPcl76wW
         DnTde7c6ZT8nzQPYCw8RODL/RrFaoJ2jQ0E4Q0HapU0U35N83S5ZBWeN4DivZ4Nz4Igg
         NUwebQZ9K3ahjcnvCyVS1cyOp3wyBaikY4yO6V2X78McxztoNSgnb5Ts9Ey2dnwcN4PW
         qQG++mk3bTptwYUBLcAqWJz+jwUygtZWEUOQ3jNhD+uaVxcLYIstAXYeca7MNoP2HVzb
         khtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715325298; x=1715930098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+hTb9Uz5fZ3Gvx3REvMog4ReTfehsa0bk9kBNaBktU=;
        b=Ct7CcLyF4Ad9VbbTIK/UGQbudtXGix4+cRSyhtN2QcPWPHgs5ltncA42dwlu20+u/U
         wXL/ZojFEHPxuFcSc7hHnUq793ICeUIFWC6r5zWGEfPVDU1QgXAsonQZHNvpfYk0kUp8
         CzuFs4hCGZ2HWbYondRN8DUu5pBmpbGyaIvHfcntMX5pKbfRpx8nPKpkYp2KHptS2eF2
         9F55m+RogNd31TTCymaUQU/0owrm+fQghJMRQDlVAAJX9u4P0E8lmGDf0NdRS8WkG2Tf
         q/QV11p21pjSSJuac7klmcGQwV4TkhCWTtBe9fcxVx/qSzSUGAX7QzuLcthwK+UjSIDb
         HQOw==
X-Forwarded-Encrypted: i=1; AJvYcCWEOlSIFsQeb+i4Qdk3NsSO1WSI69z7IMH0ZqK2+dREjHKX2oVUsUZtzmJuSW3pum0tumveIniPbb282f/gF9SseRYwSpYuDasfuKe+
X-Gm-Message-State: AOJu0YzCoQ0DRKyG051PIgzMp1SkMXsrv8ZvU6eI06Lb55ff5I/rWnao
	Cd9xaxLb+Nhtb1Gr84rC9caOOw8Zf8Y0qYFn83pD/IfZsmkxqsgn
X-Google-Smtp-Source: AGHT+IF8XPSpK6Os7Q7kiJB52aBjvbTi/5q1bBhvs1QvP8iY0Js/aA0xNgUw8sbfdd1nCXUC6IC09Q==
X-Received: by 2002:a05:6870:17a4:b0:23c:2d6e:96c0 with SMTP id 586e51a60fabf-24172e03f4dmr2100262fac.39.1715325298244;
        Fri, 10 May 2024 00:14:58 -0700 (PDT)
Received: from kousik.local ([2405:201:c01a:90f4:8de5:a651:7145:5260])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a37sm2344475b3a.161.2024.05.10.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:14:57 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 2/3] soc: ti: knav_qmss_queue: do device_node auto cleanup
Date: Fri, 10 May 2024 12:43:23 +0530
Message-ID: <20240510071432.62913-3-five231003@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.8.ge326e52010
In-Reply-To: <20240510071432.62913-1-five231003@gmail.com>
References: <20240510071432.62913-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scope based cleanup, instead of manual of_node_put() calls, which
automatically free()s "struct device_node".

Doing the cleanup this way has the advantage of reducing the chance of
memory leaks in case we need to read from new OF nodes in the future
when we probe.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 06fb5505c22c..237946312080 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1755,7 +1755,6 @@ MODULE_DEVICE_TABLE(of, keystone_qmss_of_match);
 static int knav_queue_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *qmgrs, *queue_pools, *regions, *pdsps;
 	struct device *dev = &pdev->dev;
 	u32 temp[2];
 	int ret;
@@ -1799,19 +1798,20 @@ static int knav_queue_probe(struct platform_device *pdev)
 	kdev->num_queues = temp[1];
 
 	/* Initialize queue managers using device tree configuration */
-	qmgrs =  of_get_child_by_name(node, "qmgrs");
+	struct device_node *qmgrs __free(device_node) =
+			of_get_child_by_name(node, "qmgrs");
 	if (!qmgrs) {
 		dev_err(dev, "queue manager info not specified\n");
 		ret = -ENODEV;
 		goto err;
 	}
 	ret = knav_queue_init_qmgrs(kdev, qmgrs);
-	of_node_put(qmgrs);
 	if (ret)
 		goto err;
 
 	/* get pdsp configuration values from device tree */
-	pdsps =  of_get_child_by_name(node, "pdsps");
+	struct device_node *pdsps __free(device_node) =
+			of_get_child_by_name(node, "pdsps");
 	if (pdsps) {
 		ret = knav_queue_init_pdsps(kdev, pdsps);
 		if (ret)
@@ -1821,17 +1821,16 @@ static int knav_queue_probe(struct platform_device *pdev)
 		if (ret)
 			goto err;
 	}
-	of_node_put(pdsps);
 
 	/* get usable queue range values from device tree */
-	queue_pools = of_get_child_by_name(node, "queue-pools");
+	struct device_node *queue_pools __free(device_node) =
+			of_get_child_by_name(node, "queue-pools");
 	if (!queue_pools) {
 		dev_err(dev, "queue-pools not specified\n");
 		ret = -ENODEV;
 		goto err;
 	}
 	ret = knav_setup_queue_pools(kdev, queue_pools);
-	of_node_put(queue_pools);
 	if (ret)
 		goto err;
 
@@ -1853,14 +1852,14 @@ static int knav_queue_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	regions = of_get_child_by_name(node, "descriptor-regions");
+	struct device_node *regions __free(device_node) =
+			of_get_child_by_name(node, "descriptor-regions");
 	if (!regions) {
 		dev_err(dev, "descriptor-regions not specified\n");
 		ret = -ENODEV;
 		goto err;
 	}
 	ret = knav_queue_setup_regions(kdev, regions);
-	of_node_put(regions);
 	if (ret)
 		goto err;
 
-- 
2.45.0.rc1.8.ge326e52010


