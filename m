Return-Path: <linux-kernel+bounces-439027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CBD9EA9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A0A285FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA322F395;
	Tue, 10 Dec 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nNRq3IaS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417722E407
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815946; cv=none; b=ESD1tyfC5mkZyq+K6Qdv33JeFPgBC2DjJW/BhYVqiKOI0fTpYZljBYZEfFA6wOzI6B7KnfFH5PxdlPBjiWwa6CdrVAyv//S/uei99hNb0MNwDj4m0JlnoOt11QCdAPT94NDxOODxUaErbg17ztoqPkCc1znBk505vG1gl7hZGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815946; c=relaxed/simple;
	bh=NOfDh6XWMXA3bQDZgyXinaVUDZBBis7f4DQlXXXEj18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPybOntjzjZ7UnmQzjfPp7EOw028vjM4Yr5gCynLHjyOcAt939jKzZt/cNs51bu6IxQcAAMB9yWq7d3f747qRFiF+C+rDO0jqk5BGoF0zZpDmrbnsk7oKV/jrn3Pypcz2EcAUJ7ihJ2tAUgIDvf7KXYsmpsQ7kPNelrLnDQcWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nNRq3IaS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21644aca3a0so21283325ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733815944; x=1734420744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIYaaljMW1uOvyE52JKpg1mRNjsi/3D4cn4UsNQnmlk=;
        b=nNRq3IaSCDLph7zpnboRZ1+zFRDvhhk7V0FKhrFDr39iKyHno9vLzL+r4PWE15tXP5
         IS+2L49n+YGoPTZVK8axS49mFkGdK4HKUHbn5e0/Kv6RRj3DtKUH2L1Aq6Svrn8djXkf
         D4W7pHiLAxgjJMivWGHR9LiwWR5ZrgazL7Ar4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733815944; x=1734420744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIYaaljMW1uOvyE52JKpg1mRNjsi/3D4cn4UsNQnmlk=;
        b=wxkbpMEhR9D5uCqBoHSispCHu0VtuEhkWAG2Pr+OSyv7dQyU6rJJAdvWh8ylY18seR
         nJzhCZpU87VXr2AlmoywN1SpsqNxlgMs5sxO0k2g+bqejMRSyQ/EDZeWmNYH2DVTWR3p
         uqwh7j+uSn7heg0uo3PpnC57oz2Czq7Ngeg9+6llMLlXFvLizwPN0MfF5FQFqV+tXn66
         FmR7R9JDsFOKeGUGOeRJoi7tWwr1yCvI4lfiVrODVGAtZgvegOD+sUaYr9Y3yF6VVtDb
         Yl5j9fSMgNztbBDXJdvO/KuSgb6XU0RwHY/4FLh+kHF7I+BlPc/nOeyKn7uBX6EfXtOh
         NIwA==
X-Forwarded-Encrypted: i=1; AJvYcCU72MfgFmlbNDbXhFvZ3v2Y8wX9eK4A0kKou6TcjtmBPICfMNZgmnYeNvfEYseHUo5Vr9gcf/8bDo9TS+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6ppHUeBYLWZhkVxPPKFn9pMSfRS975NvE80BsoVy5zssXKHv
	gszjHwk9r4DWiMLa+ulamiKDMTB8yuhtjC6t15f+AJmwMwq7g3wE4xFHyKU8Kg==
X-Gm-Gg: ASbGncvPkB7VScI0lxBwqvDP/vbZLX8EuEg0h1j2h5hxbaif/Vyx87/AGt0dMJKiQzH
	w8n+tg8y1CBwP493qDWi2AeAEcjxr6mkICt0OIDcCvB4hfyhgt5G1YXFk82MQIGhmTv2CelGnNm
	XL0b9cLFA5XZS+5MGnU8w/0Jn/n5jAX8o/xqliQZl9HgkpZ80wOM7fkyw5N7p7kq+hBLH99hdId
	U8YQyGsoE3Ch57RKe1K0zB2h6UhfA33Ziis4Hn+Nhu0Dd6QU9FcWNls0Dlo9kqq9Sgwx7lh
X-Google-Smtp-Source: AGHT+IEljjpPjIkRAq9lZ+wjZ9Q+4usk5mFRZZW08ysh+jkDMPJ/btZlL9SUPYyzmbG9svkENmEq7A==
X-Received: by 2002:a17:902:ce88:b0:216:55a1:35a with SMTP id d9443c01a7336-2166a0097c0mr55964065ad.30.1733815943958;
        Mon, 09 Dec 2024 23:32:23 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:89ce:2db9:f7d5:156d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09146sm83693295ad.199.2024.12.09.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 23:32:23 -0800 (PST)
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
Subject: [PATCH v2 2/2] mmc: mtk-sd: Limit getting top_base to SoCs that require it
Date: Tue, 10 Dec 2024 15:32:11 +0800
Message-ID: <20241210073212.3917912-3-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241210073212.3917912-1-wenst@chromium.org>
References: <20241210073212.3917912-1-wenst@chromium.org>
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
device tree entries, and properly fail if it is missing.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


