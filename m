Return-Path: <linux-kernel+bounces-430859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F929E369A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35E116933B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1AB1AF0B9;
	Wed,  4 Dec 2024 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ar8kYtfz"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB691A76CC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304550; cv=none; b=P4lhhN4rirYzAy5MDA3ULc+pQaIJnmz6dFYZG9vB5eglBTM2A1HGteNl/GRxAGWhN8rI48ab9OTwSn4zqqWnZ7iDpJrnFJxXp5IxCvYqXkN5zdIbrXRTHFIDYaSvvg5nTGClXSHgMN6l2N0BwLtCtNXrj+u3YXpARUfjmmdaVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304550; c=relaxed/simple;
	bh=ZF846tfxXQR1bjFKcFdA9ieHcqIFK6FjHRuAwd9+d9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAVWkZLZEs9HVp2U5wEUoozXNTpUfNnhpvtjr6fPrXv5Ucq5xpGUsRRF2sxryJLr5eZ9zemanLXBTGn+znZwBqjMmQcyMd8pi7AkEjDVjcTzYa3DIaJzH7eITvzSZn2HrHCYwkA0aCS4erzOs2C7dCJrVHADfapFM08b3BULJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ar8kYtfz; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fc22a88bcbso5016708a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733304547; x=1733909347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lmhyTT2gnZ9bY0N8ST8GSpbytof12mEhpjxb7D+L9U=;
        b=Ar8kYtfzscK8eQvziDDm5C8HUKZVLZbINqRj/8zmMnMCiCb0QDgALrhDm2NFPRn/VG
         stUKrgrjnA689u3jjl7kurolByZm0cJWEdk1pn/pC+CToGLevuNfWK4DHz7bBL10WQDN
         U3Cg/RmBurDghyoszvT5ZGlnlIC8D4JjR7uro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304547; x=1733909347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lmhyTT2gnZ9bY0N8ST8GSpbytof12mEhpjxb7D+L9U=;
        b=G+WU5Gibd383kH53xoqjK0uGN0zqgPjVjHQEaVujILE75FtSQB65ERPv9Okx6CZSTe
         azhXBtp0qxOHIKjwWHyV1rm5A94vz71iXKLA/2pDyohAZO5Gymlnyn9M0QRMkGS0xmnI
         sMjTeautGzrXink87Qq5FPG2a5g9W8HomB6s1cUlYz8C0w8wQByfqiA7xnwRk/rCmB+k
         BPQDcZBJKf96dR3Wk2ZJcTwSDazG9q6l0wrfYYJhij13etspCUI4FIfs7tMEwrJPBwcB
         bGZVufDbc4R2wMg45A74D46tjoP3SvupjHM9cDPV+/HSd879QPbnMa1/kOjaFc5y1FEB
         bKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdDaH4zJRMN01YnywP5iQGPQ2sUnRodH55WwejnX4VKNSLnecxWdUZ1YlO5GCN7UTh5KFHPPQiTnjycAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZ2jhh6fPW1dyuKqbODTyp9xxen2mjHsKrV04RFfjtyC932kA
	jnrzlMc+01027S+mp/Yxi0CY+G4apd8S9x5lbOsGfh2/NaLEXBtT1qFWUtYOQg==
X-Gm-Gg: ASbGncu6F7CbGNoD9X/q5mnxurKB9HsECF7ZsNjKOvELBO4hbCUv028jcBeqjeXYaKn
	YOlOky8Rhrx4XuL/stPmKymk+nDdVIt1lb629g2szGjQuQQ9QSeWx/KwPEShteIdW71vul5sULf
	bX4emytj2xqO2zoKKikZen2ysxLxhwQVpAY++ady5zSmHOdUGDTqTHvgfis4mfZbRtXlzRrb92I
	lVfmAj73cJDJggi+mwWzfA4F5ysinnp2asllucX4euZ9IXgU3IDx69nZ34YHMLfbQUv
X-Google-Smtp-Source: AGHT+IF/J9a4qflcZHiUbg+VHivDCNAN5kL5imj4FjGYpM9OWcUYV3cXUXaClbk0sydJ7WHWfxLZ0A==
X-Received: by 2002:a05:6a20:8407:b0:1db:c20f:2c4d with SMTP id adf61e73a8af0-1e1653a6515mr8672949637.2.1733304547503;
        Wed, 04 Dec 2024 01:29:07 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2eb1:a68a:2625:b944])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d38dbsm11049024a12.15.2024.12.04.01.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:29:07 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH 2/2] mmc: mtk-sd: Limit getting top_base to SoCs that require it
Date: Wed,  4 Dec 2024 17:28:53 +0800
Message-ID: <20241204092855.1365638-3-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241204092855.1365638-1-wenst@chromium.org>
References: <20241204092855.1365638-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the mtk-sd driver tries to get and map the second register
base, named top_base in the code, regardless of whether the SoC model
actually has it or not. This produces confusing big error messages on
the platforms that don't need it:

    mtk-msdc 11260000.mmc: error -EINVAL: invalid resource (null)

Limit it to the platforms that actually require it, based on their
device tree entries, and properly fail if it is missing. There is
no MMC node in the MT6779 dts, so it's currently unknown if that
platform needs it or not.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/mmc/host/mtk-sd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e2c385853eef..1bb7044f4ca1 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -414,6 +414,7 @@ struct mtk_mmc_compatible {
 	u8 clk_div_bits;
 	bool recheck_sdio_irq;
 	bool hs400_tune; /* only used for MT8173 */
+	bool needs_top_base;
 	u32 pad_tune_reg;
 	bool async_fifo;
 	bool data_tune;
@@ -587,6 +588,7 @@ static const struct mtk_mmc_compatible mt7986_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = true,
 	.hs400_tune = false,
+	.needs_top_base = true,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
 	.data_tune = true,
@@ -627,6 +629,7 @@ static const struct mtk_mmc_compatible mt8183_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = false,
 	.hs400_tune = false,
+	.needs_top_base = true,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
 	.data_tune = true,
@@ -653,6 +656,7 @@ static const struct mtk_mmc_compatible mt8196_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = false,
 	.hs400_tune = false,
+	.needs_top_base = true,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
 	.data_tune = true,
@@ -2887,9 +2891,13 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(host->base))
 		return PTR_ERR(host->base);
 
-	host->top_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(host->top_base))
-		host->top_base = NULL;
+	host->dev_comp = of_device_get_match_data(&pdev->dev);
+
+	if (host->dev_comp->needs_top_base) {
+		host->top_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(host->top_base))
+			return PTR_ERR(host->top_base);
+	}
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
@@ -2951,7 +2959,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;
-	host->dev_comp = of_device_get_match_data(&pdev->dev);
 	host->src_clk_freq = clk_get_rate(host->src_clk);
 	/* Set host parameters to mmc */
 	mmc->ops = &mt_msdc_ops;
-- 
2.47.0.338.g60cca15819-goog


