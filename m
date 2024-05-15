Return-Path: <linux-kernel+bounces-179667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA888C630E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7612228447A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29553368;
	Wed, 15 May 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4+fMfuJ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9155C0A;
	Wed, 15 May 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763114; cv=none; b=mcNsZhqteWhKpAOXFMIoqoDny9M0HdFYoJoVaaERKLWkh2aCBYh1SwtaQsI1gDsmR8D8bvb4Kl6ClsD3tXPmPEWMqOoc+2EW0E76NX7Mw1N1ngyKo9vaklYNL/T3LYUmoARRqrLDJ0O+aPoXONiDV+aum9Z89ZstBTj+HMC8ihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763114; c=relaxed/simple;
	bh=Sn9x3KBarqN8uk9QfvRo0wvnCppgKzdc6SIMOMtI1uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVhZM8sba6xP2BmpQVAqc7eUd9ozz6JEiFg5+KkOt5Y4NTz7A9eSd97HL/b+5VEelnbNODfKCo1zS1jetpHPZYqt5C24LuwyR5JXH7BlrmILOKrWD8QI8adaxbyXApsyjP8JLT30sqGvdq29f6T964MatpMM2oayEDYxWf1FH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4+fMfuJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5238b5c080cso964540e87.1;
        Wed, 15 May 2024 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715763111; x=1716367911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNONLWFVXwk/7cpwqGoEsjCpkeKP9bkYNCBxgTvGBnc=;
        b=d4+fMfuJDox2oiHZOnnSVjB0yrmfyQhfxNm7Q7s4/IOqYZRCU9hAxktqSNd4dpq0/F
         76abiufKpjLUDdJh4dx41Kw1Miy81PSPgWzw18thK83DvEfEnOgSAAahq7ktv7iExsF3
         CCdGITfK2FShOjbFYQzDAVinI5jYb6Te+VS5SfrMQybmKinfpuw8RX8Fb4G9eCf2INBU
         MePTlckNWBWNkuOhtN9WxT2W49kJSpLaSeInXtXl2P8rV7gLn7iONirSgi7jfv/StDrY
         rHdQv2VUGJBFZPbrBZ6vexpVwTra2ehFLwfQZydBUlopb5XEnStpPi+iPcZklnSfrYcv
         4kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715763111; x=1716367911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNONLWFVXwk/7cpwqGoEsjCpkeKP9bkYNCBxgTvGBnc=;
        b=ccTxpQV7LZ8ehFQ9dQqI2QXIMWXzLhGyAE3yQbARGQdbQQss9et55XboiTvpqUDkOV
         eWqFArSaftn3+Pn9UAseZ/XRMHn5sv98wNq98LaimCQdA9INa1lf6oK+3rFpwWJY+Q0P
         DRxIeCqHEKU3vIm2Ym6SLDIbHb91jHrxud+R5chYJ1sZVxM54xX7rlRhFBl57F3z1kt2
         ty43cTd3BMRtWHl+iEucddzW3EqJT5wFi27m92EFzeDi7YSB/GZZbBsdxzsnQYQB0edA
         xwTQ1JAclYC4rdkRvS4p4eMDLyrcp+HJXrGAVHfQK1L6t9kK+sp4F+chCGCy/ZMcfDiO
         Shqw==
X-Forwarded-Encrypted: i=1; AJvYcCXmm0nL6JTuQSvMOEab+HWS9nmKnHqfMVNwmisZmpdA9hNZIFu1gMfXKYe2eA/WTMz2WeI+utn+x38NZf6qmumkfMVDzOKey/x0ihF5gypg5t6Nzqq2257K5TGPs/bxGiID84EThA==
X-Gm-Message-State: AOJu0YzdFCdLYWLLO0t6OnqmwOGGAM+uiI4CI7QwBb3itKHupJG2YIk+
	WIby0qBamdGY1OryABmMCGvqAxM39ZiiCnba/GHM8ELrVcFx1cnbiiUzbA==
X-Google-Smtp-Source: AGHT+IGt4iTM9rt9AiTs1z+QhdX5WFWgmL1iAw4vZzAginFakZKOg0FrZcSm21nAlwWZL2DkPx/n8A==
X-Received: by 2002:a19:4355:0:b0:51f:315c:75e0 with SMTP id 2adb3069b0e04-5220ff71049mr7480506e87.44.1715763108966;
        Wed, 15 May 2024 01:51:48 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a8454sm15825034f8f.56.2024.05.15.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:51:48 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-mediatek@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [RESEND PATCH v2 1/2] clk: mediatek: mt8173-infracfg: Handle unallocated infracfg when module
Date: Wed, 15 May 2024 11:51:04 +0300
Message-ID: <20240515085137.2842804-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8173 infracfg clock driver does initialization in two steps, via a
CLK_OF_DECLARE_DRIVER declaration. However its early init function
doesn't get to run when it's built as a module, presumably since it's
not loaded by the time it would have been called by of_clk_init(). This
causes its second-step probe() to return -ENOMEM when trying to register
clocks, as the necessary clock_data struct isn't initialized by the
first step.

MT2701 and MT6797 clock drivers also use this mechanism, but they try to
allocate the necessary clock_data structure if missing in the second
step. Mimic that for the MT8173 infracfg clock as well to make it work
as a module.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v2:
- Rewrite patch subject for consistency

v1: https://lore.kernel.org/lkml/20231108213734.140707-1-alpernebiyasak@gmail.com/

 drivers/clk/mediatek/clk-mt8173-infracfg.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
index 2f2f074e231a..ecc8b0063ea5 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -98,7 +98,17 @@ CLK_OF_DECLARE_DRIVER(mtk_infrasys, "mediatek,mt8173-infracfg",
 static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	int r;
+	int r, i;
+
+	if (!infra_clk_data) {
+		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+		if (!infra_clk_data)
+			return -ENOMEM;
+	} else {
+		for (i = 0; i < CLK_INFRA_NR_CLK; i++)
+			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
+				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
+	}
 
 	r = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
 				   ARRAY_SIZE(infra_gates), infra_clk_data);

base-commit: 6ba6c795dc73c22ce2c86006f17c4aa802db2a60
-- 
2.43.0


