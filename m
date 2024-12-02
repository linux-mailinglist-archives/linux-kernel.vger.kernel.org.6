Return-Path: <linux-kernel+bounces-426967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937EE9DFAB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182E5B212C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3F1F8F09;
	Mon,  2 Dec 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQvEyVmB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185E481A3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733120913; cv=none; b=Oy0e6Vr2PwfkwGOwqtiQaP9DZmqhsgXQ6lBKDT38RGjBZsoBweocDj274GhxN1ahHMMGH976hYVLi3ukQbN+4AmwefaVsxQiOktRRBH+d9IL0wbqPVB+vaazleCYocVFyIv+LWOKESPEAa/ypuGCDHfpniieX4ld3fUqyfC3X1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733120913; c=relaxed/simple;
	bh=L6vPam6TecuC+9PWwxZn42pGAfseG9v3kpLLropKN3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhUETXb/pvYcw0xOlyRQ9kLfb1FUvyK0ZvfqSvDBL5o+MSuq3xvveVM17wBDlwJIk4QqPeE0IndmQb33W2dvIn1yAm/JV5wuzpyLClGb+YqekW8sU+snFV/RYfnZtXYO9H3GHVJeRkp8IQv4JtErIBQLnivNtTWXEk1CFGSrK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gQvEyVmB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215936688aeso4279505ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 22:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733120911; x=1733725711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn0LDqdl1s00AOGHv9alMWMkV5CbY2Y3h7DtmORE+v0=;
        b=gQvEyVmB8Dewea9XCIsStCuBl0PrUC0CKYrG1LRAsQPUMLZxuqyaZTBhw8FDJyw9TK
         /iDN8SiJuQW6FCPD5000D/52xycNNJHoCKl5u9MAvMMe6qJxJ4BAeKZAJdqFw+Nkt7fJ
         HbTtI5twDY1m7ZjbmAAeo7em30l2istIHrq/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733120911; x=1733725711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bn0LDqdl1s00AOGHv9alMWMkV5CbY2Y3h7DtmORE+v0=;
        b=jWSLD9o/bJMUWwWSArQhiACSkcePq6L1Ox0WS1O6J9aITXOfNqEKj6IFDokV74YZkF
         JhyIdLaIogVWEewPfSAGiYG5KnJBqVB4INq/ZKe4hO9gDQGpFg+6wsz1bhvhgSUTlfSQ
         g7mHCMBQPHslrbwYtC1/JICvMNopS9i2bW3sATaMl95Es3Y8rXpYmI3uQP32EEw1nMtJ
         QbuGfZ1mTOP3cA4JmBT/J3rZxgqGzsnFQWs3STW7bVIAZVBjrC1Eqxeuo+sLFR2KG+ig
         iF8DqWldlu2+UD6cYrgwqHmVsrKL+19rb6bteI/BnbnJiBzO7SIDV4/ajhmXW5iq5KhA
         JIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvxY3UVhNg4HfUKOm35Rxba2F37IozWZGPG6z6Un4yTOp1ZMl/ObGnijJFJjBbjMnjo01d9aIp65m6Ah4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhWCVPaLY9+QY8KvwUlu0GbkDeIyDLIgac2LejW+z87YCW/jS
	TdWcmFgcF3H9BG2k34tsILwDSQ4fnTt4oNk3YvU/+adTHCz7n8ZNpC8a8EyeKA==
X-Gm-Gg: ASbGncs08Kc7VG4hQr1lqImLcDQN6t/uz8ud7kquysLlIB/a+xkDzap4nkQBJ2M/WOf
	M30yTioL0/C/revV4CPLXK5163kSKCzcn09Zwn303/9powky9w5gc4+SrLUp6m+dqzeICX8D//k
	Pi1ByKlwilXqV7Ncau2MJ6rLZNzlOMnyShQUinlEuCVQGK35fYef2c/0cDbxCaBeexuKlYD7K1n
	rKdk+1l69wmGTa22hom6WvDDzImVnSmhgqTsjEm/lKbFgFqWw+h6e9LJU212Z1q74ZP
X-Google-Smtp-Source: AGHT+IHrImvV+P3fnp6O9oKMYzWe60hrfjJ4izSDkEkKWNLOabp7zSbgf2dW9C8Dph+qT+k/E/6L3A==
X-Received: by 2002:a17:902:cccb:b0:215:89a0:416f with SMTP id d9443c01a7336-21589a04ec8mr55693695ad.30.1733120911505;
        Sun, 01 Dec 2024 22:28:31 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215361fd5a6sm58878555ad.94.2024.12.01.22.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 22:28:31 -0800 (PST)
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
Subject: [PATCH] remoteproc: mtk_scp: Only populate devices SCP cores
Date: Mon,  2 Dec 2024 14:28:25 +0800
Message-ID: <20241202062826.66619-1-wenst@chromium.org>
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


