Return-Path: <linux-kernel+bounces-382094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C59B0925
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B5B28202C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE3B185B7B;
	Fri, 25 Oct 2024 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="naxm2wnp"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF241865E7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872280; cv=none; b=tGbMbpRYM9x+k2rHFe5l4HQZOGBTUew2+ZgmDnQENMhfSBhl39A1DAFUdsTuLx5RFyRBDkV/oJdGYxbqc6xShr/Ejy2emsh08pazhfYXtj173wo0Hd52xrbwQaWgdzZeEQZqN5nNHPCoRAAiTzgpf0NP8Wj7AE3PRMZDOJ/6zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872280; c=relaxed/simple;
	bh=rv5rJ4jmTrZ27qkbyvCgIO215qm4tAl0JboSDanP3hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2SdsZT56dW7Sz40dDvOCAtHt5Q5SW5r6f0NC1T+G93t7K7XbTVujgGVCf0edBlIg9mGuiV1JwJ84wXdwMi0Fy//u+PgryHacL6+842ikddopp9QGLWl78no6CIzySfi02QKW4OtYxNcaxlBQ5B3L/yjo/DIrmN6vKsosqIsI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=naxm2wnp; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso18099751fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729872277; x=1730477077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xCM1ACcR+e8vZp8ZeWNxMr9lABciJDnozk61Zgoap0=;
        b=naxm2wnpTOjEvHretXyAmPU1/YrO8SA7WfkGp0j0JGmIFso6pdna0poLesiQE9T9Qe
         FBH2473tdWbDsPPdPOxeGtg2pkggqhFCI8VOQGj/IulcL8wLnW5vRtRoSGhSWxtqA7ot
         5ZdQ408y21jXB4QAE77AlGZe0nVhM7ruPez+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872277; x=1730477077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xCM1ACcR+e8vZp8ZeWNxMr9lABciJDnozk61Zgoap0=;
        b=X4aglQA3Nsf5WavZaViCmD3DkiSPqJnCCKrnsOVQ8pjDj4x9+J7aF4Y4mxz/mlGo7N
         xjtGHQ3GNzCXJ3NQPsOFTpyIYftGsoff38iX2jlQrk5Tw0JqLuBnqeefVJWM7Bu7TVNn
         dzi6qxEFr07dhcClFNGGRPJNdaGVGLUj6vTwU6HLuQDSssVz+CVJ7RD5XdWmFYCw5+h4
         pF9ZK1Lotw+BpJOZbHI7oNE/1tsKHcHGKJzUDbQC0fFldfefiIaAiI7gSn+aqfbwh1Yt
         weZEAQsa6UBHup4jKRVK85jjQ5ZQItuRdZeABaESHaEvoiWPBTfcmNBH8qg1HdKbv3dx
         6zCQ==
X-Gm-Message-State: AOJu0YweeQNJaLk3xcCrJXh9VKNgX/HpgKzJAfIOMPayE+BeBgyVBYtQ
	rksCVROwDBe5J8wWiNlcY0hV+wtdWlR7ql60Yb/q5P8B/hiTxQXqLpR4xMUt6KZtfpgEiJgh851
	4ozk=
X-Google-Smtp-Source: AGHT+IE5tAGEzSGr1VKCRE9qh4Kh62Hto2hpFgEH+icsAjjqXGeOuQHrKjPabwauzhg1pQ0otdSs8A==
X-Received: by 2002:a2e:bc09:0:b0:2f7:6653:8046 with SMTP id 38308e7fff4ca-2fc9d37468fmr61995861fa.25.1729872276573;
        Fri, 25 Oct 2024 09:04:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.43.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4348sm1848614f8f.111.2024.10.25.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:04:36 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
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
Subject: [PATCH v2] pmdomain: imx: gpcv2: replace dev_err() with dev_err_probe()
Date: Fri, 25 Oct 2024 18:03:56 +0200
Message-ID: <20241025160430.4113467-1-dario.binacchi@amarulasolutions.com>
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
Note that dev_err_probe() has advantages even if the error code is not
EPROBE_DEFER, such as the symbolic output of the error code. Therefore,
it should generally be preferred over dev_err().

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

---

Changes in v2:
- Improve the commit message.
- Add 'Reviewed-by' tag of Marco Felsch.

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


