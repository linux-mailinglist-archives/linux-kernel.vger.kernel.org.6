Return-Path: <linux-kernel+bounces-203202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C78FD7D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076FA281E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C2915F3F2;
	Wed,  5 Jun 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRSY/ch/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559AA13A890;
	Wed,  5 Jun 2024 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620735; cv=none; b=K56V1P7hvs6oPnukY8BzdQCx/VJRfd9/Fkzp+veJWSEsodzTt8AK0n5UHsmQRwv1sGNCBR8qOts8yMGgIEE8i3+mlO0UvcDmtv86KjmaD2SRypvghBus430usTsYjJMKwWK0ijNcPxmdj/NHWpNNtYCqR314LUjHyktMIm/7y2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620735; c=relaxed/simple;
	bh=T4Bf79Ruzb5YS9eT8OxHnbdxl8lURVHHqzg4nFDly2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxaClO26RZuVU0Jh6Pp5GifrJboyUZw5pPOj6j/lgDM2HJBDT4KLCPzJjxNywCD6Ad/Y6NnHhVi/2wVWGegCjKXkvNwApOhK/Sf9cwxgTcLKD7pXOcl6yoqCne0ghUkCCu8NbKlBDHjVOF08+Nwy7G5P6D3eMCwFTxp1P0M5Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRSY/ch/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b950aa47bso440803e87.1;
        Wed, 05 Jun 2024 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620732; x=1718225532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRZR2FIRT4kLU11sqM7VA2ozbtsr+hE+nmcdAqWhupg=;
        b=nRSY/ch/UhQabCeHoRIPF84CZdRuiyq6oQPpxWN7Uy4kZYwKrCcNCC6v9scNrEqK3m
         bPK+XN5Eje5jnB+kwlCXgcolB3e0kL65XAgtmygd9boiQl6z8AAOz4QhiLLTEH0Xz9Ck
         IP/rdDQI6PbQcH4X7ZEMRrUtQkn/+LThXB8DOT2Wevdsvaepy9DsteZMUJ5kZNbIvz8E
         LS0/8IBT7mJyuS6Uz8rM6kfapZBkMVqiJ5zv+p7T0ntKJz1vTau2O+8JrsmGAfltAbDQ
         u9Fr+84yfazu0ub1NeklcIKWMRsNa17xiE/qGbJCPWWR6UNsZXBm4cNHNhtbsu+aIrLC
         rlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620732; x=1718225532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRZR2FIRT4kLU11sqM7VA2ozbtsr+hE+nmcdAqWhupg=;
        b=vNWPhY5dCp3nmfvTxdEqw5gHI/TeWwB3JqOLZPJnv2NM1qTzrHP1E9DEIjTvMZ8gj7
         y4s8Oo4GbUgjDl0J8quQkdRcqYE9QCe4Cv0QdNr+XWQTQCDXkOFNQ1vFmsaGlqvLwfPL
         +XCt8vFc5PJi55zuniQ5KPorPJMqrzYWEtkO0S4Br3CIUr1tNy89QIPTN69kmfmVsIAP
         8+/rdnWdg9c7uOL34UPEnrRVbdRFyf/G0zWu0m3luthct9Y/0cqkhMnFhZeE6+FqWlLO
         LslSehDVYs31fk6Ve4cVtd9e36lcGmlYl4XhM9kYd/IuUr6HTbkf8YdxB2ixIUkHbdLG
         ynKA==
X-Forwarded-Encrypted: i=1; AJvYcCW4ngoAQhhDGec0Bo28Ret7EHw92mgG2/HSNwYUVbwxyAGcm0i88X1/oiulLI8QpZaCo4wt2SUeCM0cH610DoxwmhCepKDXoMHsB9IF6bqp1l2fM+gnJrWQXbPJuCuwET5OpNOSudyCXzyR+Fga0x2BdOiC7d8yJSdxaGiUPGFnZuAGlg==
X-Gm-Message-State: AOJu0Yynq0qACAhppR9vL/ovNGLJYKF/EoS/6TW2vciESf9DiDOK0tP6
	yEunKl6kVHr1zbR1824NfZQbgaxlPFTBiXzChESV6PnzC8uX9i5pNhL0
X-Google-Smtp-Source: AGHT+IGj0rVw+PbaW//1K6g6mF5yaX4g2jKv2yrK3ycmj8fN1glaSqwLjxl18e4/YdglcXhTAkU7pw==
X-Received: by 2002:a05:6512:3b97:b0:52b:8847:ad0f with SMTP id 2adb3069b0e04-52bab4cb7afmr2982121e87.11.1717620732322;
        Wed, 05 Jun 2024 13:52:12 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:12 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/5] clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
Date: Wed,  5 Jun 2024 22:51:59 +0200
Message-ID: <20240605205209.232005-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to
commit 2dc66a5ab2c6 ("clk: rockchip: rk3588: fix CLK_NR_CLKS usage")
this drops CLK_NR_CLKS usage from the clock driver and instead uses the
rockchip_clk_find_max_clk_id helper which was introduced for that purpose.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index d076b7971f33..40e0e4556d59 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -569,18 +569,22 @@ static const char *const rk3128_critical_clocks[] __initconst = {
 	"sclk_timer5",
 };
 
-static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device_node *np)
+static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device_node *np,
+								   unsigned long soc_nr_clks)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long common_nr_clks;
 	void __iomem *reg_base;
 
+	common_nr_clks = rockchip_clk_find_max_clk_id(common_clk_branches,
+						      ARRAY_SIZE(common_clk_branches)) + 1;
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
 		pr_err("%s: could not map cru region\n", __func__);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	ctx = rockchip_clk_init(np, reg_base, max(common_nr_clks, soc_nr_clks));
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
@@ -609,8 +613,12 @@ static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device
 static void __init rk3126_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long soc_nr_clks;
 
-	ctx = rk3128_common_clk_init(np);
+	soc_nr_clks = rockchip_clk_find_max_clk_id(rk3126_clk_branches,
+						   ARRAY_SIZE(rk3126_clk_branches)) + 1;
+
+	ctx = rk3128_common_clk_init(np, soc_nr_clks);
 	if (IS_ERR(ctx))
 		return;
 
@@ -627,8 +635,12 @@ CLK_OF_DECLARE(rk3126_cru, "rockchip,rk3126-cru", rk3126_clk_init);
 static void __init rk3128_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long soc_nr_clks;
+
+	soc_nr_clks = rockchip_clk_find_max_clk_id(rk3128_clk_branches,
+						   ARRAY_SIZE(rk3128_clk_branches)) + 1;
 
-	ctx = rk3128_common_clk_init(np);
+	ctx = rk3128_common_clk_init(np, soc_nr_clks);
 	if (IS_ERR(ctx))
 		return;
 
-- 
2.45.2


