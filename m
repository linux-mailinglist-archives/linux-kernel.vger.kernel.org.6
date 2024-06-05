Return-Path: <linux-kernel+bounces-203208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB048FD7E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E1B1C244D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B42161304;
	Wed,  5 Jun 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr9hY5BD"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483E15FA74;
	Wed,  5 Jun 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620739; cv=none; b=GLE4dKJPc2giqOfmHeMGgfro2XcCz5l8qKkVM05dqXhNtPlHlRh+m4XxC7ssiLH4M4He6g9BdzeaiOrqpjICbkKgZEviZKNKEaDqDX/urjvhJFXWTdXHt7bQiHakQW2fIk6F/Nu2tRM6L7YFpITPVEptqKFKTyR4hOZWtVqwV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620739; c=relaxed/simple;
	bh=V9iuBXE3RCPxqipBIYq+2imZhquQ1wdIjv+HQgtM/dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfRzdWOkmLc/YVByFYK7yMkcra7++BLP2Mrvo4d5Etza7GhLwX+AcjHGOYm2S1IZWHy2XtPEzH8hexJzX2HXpuc+Dy8rOECvBR6eI07GwriCA39eoghXJGflu2pTQ+ki91lde84fJwwmVZTABPb/OvL2u+qsSq/gTqtC+eIpqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr9hY5BD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6267778b3aso22779066b.3;
        Wed, 05 Jun 2024 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620736; x=1718225536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwbtZSg+KieEl718DTPhm+GILj3m52AXbprU8PF/yug=;
        b=Dr9hY5BDyRI3agLAkF9IqjfFrP55AYnoQxIRiZnSSppEb2xZEPx/aKLhue2ERebEYo
         X/Igv5fupO39WAzB9VUGeGUnZddc51U2Jp1u1KacQRUe128epl5uQNm4e29DripeqydU
         uK2ARFSUW+PJinXBdWqBLh2+YcJuBc9YVAJyNOWzftcNeyDTfopBNXoPdW+yB+RhPtar
         DE93kF6wm0LadriKJ7dLcIlp+Qu3Vb7aoWncWoo+HFk2EmKYBwtSmlW8HaDi7KfzifUK
         1jfimZYgDikjhEaf+XLaMx0rbwGZCwx3F5/2krOaNHWl2coyECLXZHBDULgbNFkBx5Qw
         j3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620736; x=1718225536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwbtZSg+KieEl718DTPhm+GILj3m52AXbprU8PF/yug=;
        b=GkvIqyHjtg01fQeUgxqJY+vNDa5fLyZejzmpyGbzf3UjQfXNUmtWSkEjOn6QYGVHjq
         y+cEhjBvHHv3HlR8qzwXQBRqKcoviR+DfS1ok0VTtJK4e60u1ystmj1anpc8lLiVTHJ7
         HgaG+WbmIW/SpXgSNgQFT2fuflBHZaZHxPx+bXjwMoc89FIKPktmECzFsxwlCHmIk/GD
         DBn+or9H4MzrhqWePi7M5Xzo+u/NlUqOFfEAjpdf9FxFD6hgpleV30yUQS4Dd6BeQykR
         cu+tUJDILlUqDdUVokaHXiefzcIWYL76bJSJebFc99prg/tqsVznp7T4+GpRI4F/Jxv1
         AN/A==
X-Forwarded-Encrypted: i=1; AJvYcCXJhSGuiHQsI/M2dZV8sTKMZcM00+gN2gnOTqYz7kK53XKLUNZXBeyeUxoCjTk0Ru6T8kiyCZXKSkPNpiQMNaMqN1F8ryRJIwwHW0LUZrQLMkyHmANXnYMQ0cq7kBeGYivv9rZNjNclOPPwt7kPuT/0sjKZ64R2zQ8thx+Q6Zh1XyBCOg==
X-Gm-Message-State: AOJu0Yx6beB8dppihzVDGLvBxW81FZ/jRFV8dbVG2aejrcnypz4QWGj5
	SADrGHS1KuwTWoJCzl9sbcnpo0MMZxNpYI9XWJtc702IcERFmEM=
X-Google-Smtp-Source: AGHT+IGUnMdIVufGuJqx2NAVZkDmWMS51VfiKdCE/FwjeZA4u1Q5WF1rgZ2eBaMEhn+7c3tMJ6YzAQ==
X-Received: by 2002:a17:906:384c:b0:a61:c462:c612 with SMTP id a640c23a62f3a-a69a002e316mr235653566b.53.1717620736131;
        Wed, 05 Jun 2024 13:52:16 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:15 -0700 (PDT)
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
Subject: [PATCH v2 1/5] clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
Date: Wed,  5 Jun 2024 22:52:05 +0200
Message-ID: <20240605205209.232005-7-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to get rid of CLK_NR_CLKS and be able to drop it from the
bindings, use rockchip_clk_find_max_clk_id helper to find the highest
clock id.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - new patch

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


