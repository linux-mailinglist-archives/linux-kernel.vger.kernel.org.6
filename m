Return-Path: <linux-kernel+bounces-204491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90938FEFC3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB251F2350D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A01AD9D5;
	Thu,  6 Jun 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDI3lEbM"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BA198825;
	Thu,  6 Jun 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684653; cv=none; b=G+FJHJBdphqcV6u+xyGPqYauh/JoOoGz4WrT4kzN2T/qrbk8kQU9bGV0GquR06XvLr8ZH6CTZQfSIngTSmc6HS8HdnCyVcWWclw4afgOpohDLLm5kDE7w/KpCzZFjKuhCjulmv0zvsaj2CQNtnmK+BzO5XnELfYgZoEDtGjc9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684653; c=relaxed/simple;
	bh=V9iuBXE3RCPxqipBIYq+2imZhquQ1wdIjv+HQgtM/dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoO0eOFR6EJgE2z77o7X5UPQbfc/O9ZVt6hZk/ufIbV1X9DF3wqOCe+8y8WRR8X562cI++f7tSYFh94LxNDMaHGXZ0hT1WsonIaQ1eJUaJtfSch/U0KZCbknaHxjZXzuP1UkHLEYCFrp9Fxtui8nWQu5Cly7m+SkXRTI8R4/xyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDI3lEbM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e73441edf7so11036981fa.1;
        Thu, 06 Jun 2024 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684647; x=1718289447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwbtZSg+KieEl718DTPhm+GILj3m52AXbprU8PF/yug=;
        b=TDI3lEbMbSVaFDeQqCNHF1yClv2HloTqb0zLXV8oPx5b9w6uThJBbqzNU7RR3q2qIT
         0KPndiyEVvz4XTmGEfWNMs37fZ9XyJVM4rcdHfYIWg/jRRAHiAkjAgqvN8+Tr7Jws0vV
         SFAisY2tFVv+OcFLrtFcF/6uTXCJ0Z0O1YKZbVfhzi10ZZd7Yrems+cm0GrGeapWfUP1
         RL7D36B4AckLWi7UyrGThQPWyIqQgReStiSPIG4fcEECx4XCZlNcygKeonMxapCUPhvQ
         1dLzNvXBttj1Am/6bgOdsKNpiia4RauOIO9pKzAnTuok/ZrwvWgNA2iLQtX+Ub9BALvI
         KLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684647; x=1718289447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwbtZSg+KieEl718DTPhm+GILj3m52AXbprU8PF/yug=;
        b=L6LbFltel94GYha+65o/zuX99NszI8otHxGQHH6/1yy0A2dh3NWbR5N4PTthcXfonI
         p7feT83UC+YJflqLlfjIls7x1Z2hkcKWPH2VWuByB2dsriKOfwi/OvehdaEYCQvGz3YZ
         CoLE2R21vJLjRVFztS3Nm3B8B+Kz0HWwLLP3ceR2LSyPT2yZhCnzJfTy4J/NLxYyQFie
         eeyraaTY2zgsRKpH9eJatZkn4FexGiyhSxNRBmUCoJj8mpV7aWvS0duidYeVopTjeNfp
         Fb+I4xiqj5zsaTepnyg13T9ub0xFmCXuCmnztirYICz+Gx8XLOfe7gQNYtU11DtooAFA
         OyqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJpeXrLtLOjm83jNlQ4bHl11qNxdJ7toRo581CQaGr8mRKpZVe2RxOlrt6x7fvrNZRtr37hnLCnL5jlj4KCnDM2gG+D2O19d7Ms7jMWXhaQeQbELDqTgm9vTZEI1seKDo1+T3nvo7aNB09/icfWcpSZcWuIlXFq3P+hDI3b4JtFG77Gg==
X-Gm-Message-State: AOJu0Yw7pElfe7Iavmk5+6FOxr9oYrbMZtMKdLp0SyhMLhyTSCQ1hHCe
	ykg78UB55U0lMLkZajIcrfjx1Heeo19dkSApDcdHBXHcV+QEn/8=
X-Google-Smtp-Source: AGHT+IH1deup0gJuPwta9k775MNhv8GAL/BikALDm1EyiQnDESfz6dwxMRWHIj+6oNfeitvvhv7KfA==
X-Received: by 2002:a2e:9ac6:0:b0:2de:74b1:6007 with SMTP id 38308e7fff4ca-2eac7a72de1mr38708601fa.36.1717684646965;
        Thu, 06 Jun 2024 07:37:26 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:ed9f:91b7:21f2:3109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae1008adsm1190925a12.38.2024.06.06.07.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:37:26 -0700 (PDT)
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
Subject: [PATCH v3 1/5] clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
Date: Thu,  6 Jun 2024 16:33:58 +0200
Message-ID: <20240606143401.32454-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606143401.32454-2-knaerzche@gmail.com>
References: <20240606143401.32454-2-knaerzche@gmail.com>
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


