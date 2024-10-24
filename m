Return-Path: <linux-kernel+bounces-379722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373519AE2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC46B22709
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7561C4A0E;
	Thu, 24 Oct 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M8PJTnYU"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB111C2334
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766147; cv=none; b=FgNlqyjz6D5IhfEt/bHGhv0g/Xv4DpipxWQZ2wF0Q+lzL1AKC7ewq3HYu6gl7ImSxGcqvkUY0uAedr0rZC4bOiY8mls5WRX8PAnxvl4bdF865eCP1Pepf/sK7RIknH4oBC2HuElzrGybHAzCYrF35xAK4X2JMs3BaEIvMj947gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766147; c=relaxed/simple;
	bh=XkI+Pc7w60k8OQH0O7omuaUb38zv0zNaiQvi7wOn+CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcViZAimQI2yM9WGaymjPUm7Sl0f5paCngeZrvc+6JZPDxTdyRPjLJDNmMGFbHYUBrDnXtcYYJG7QXlanw5DXPjjVNTD44uO6PTyZg2ybnmHehh6qA+EP6ZAWzIOpDlU72fEI9kK+bb7+gXoMsGmJ1RzBJCY3YY0n852FO94zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=M8PJTnYU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso91510966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729766143; x=1730370943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9pUdYv82xqt7Xgtl7+4X7WHgZzcjvtNIADtHzAjrXQ=;
        b=M8PJTnYUhX2pFccTICY2lOP7YmGeIlJjBVu9FU0jkdbZWf0fHyg5TgRKzkYyLsB97l
         10hHAc2Y5oYARP1GvGIn6x7fOoFbZk2xQBKNf501cGynJqBkHTI4xOpDh+ch6TP4vZXy
         hTJR/l4Wr1cSb+EPsbuEG5MgiuObZxLDe5U2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729766143; x=1730370943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9pUdYv82xqt7Xgtl7+4X7WHgZzcjvtNIADtHzAjrXQ=;
        b=BYo6e9ixJSbkpE/l1C2kag3WrUcHmhWUoJwpQMDL/bFFGh3gfSF370L8VpV+ZwQ3ww
         w4/VNul9dwlmcMQswMjejHkNDLYaLNVP+9GBNSgfM8FGSfa5OvGSrTUsn5f6uIUtUoVh
         oYNpWkN0dLxu4bsLTT1cQRJGSoghkQISakMjB6BjqZCcXnVwbwe9oqSNREEOohP855Oz
         XOsjAt2UtwV6KlHdqBGham5S6wDVrc+5cEoCJlyiWI/ereA8jOoCosOkWvGehGSTuxwz
         AM64Q0KaplMo1o+p6W6WptwSCkv/xZ6rdLiOd/VhmSJl+dYiwch0IPRwfXn/FauiLBzh
         xI+w==
X-Gm-Message-State: AOJu0YzmjgSeSBjxjxu9iYe6T7gsCUhOzFqnKTqCp4xtN17phY5z4Kf/
	qMuRfytmZaAmaI+a0RLeXaILwGPxtvlwdkk8LhD854Mi4HPDfg+HmcUVCuI+l4aRnD027X8rtft
	Zwww=
X-Google-Smtp-Source: AGHT+IHfb3oc/tXlxpxsflSckSQeMBrns/+C2m2gpMY+5B92QOH21Ab4FKnncfZAer2tZKtes4/KtA==
X-Received: by 2002:a17:907:3e1c:b0:a9a:835b:fc8e with SMTP id a640c23a62f3a-a9ad286b976mr132409566b.54.1729766143356;
        Thu, 24 Oct 2024 03:35:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:f79d:49dd:b804:3f48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559f15sm598592866b.133.2024.10.24.03.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:35:43 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] pmdomain: imx: gpcv2: replace dev_err() with dev_err_probe()
Date: Thu, 24 Oct 2024 12:35:36 +0200
Message-ID: <20241024103540.3482216-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch standardizes the probe() code by replacing the two occurrences
of dev_err() with dev_err_probe(). Indeed, dev_err_probe() was used in all
other error paths of the probe() function.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/pmdomain/imx/gpcv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 963d61c5af6d..6e6ecbf2e152 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1356,7 +1356,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
-		dev_err(domain->dev, "Failed to init power domain\n");
+		dev_err_probe(domain->dev, ret, "Failed to init power domain\n");
 		goto out_domain_unmap;
 	}
 
@@ -1367,7 +1367,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
 					   &domain->genpd);
 	if (ret) {
-		dev_err(domain->dev, "Failed to add genpd provider\n");
+		dev_err_probe(domain->dev, ret, "Failed to add genpd provider\n");
 		goto out_genpd_remove;
 	}
 
-- 
2.43.0


