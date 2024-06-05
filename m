Return-Path: <linux-kernel+bounces-203220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4982F8FD7FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3AC1F22627
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5C15F409;
	Wed,  5 Jun 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SACEtrH4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456254965B;
	Wed,  5 Jun 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621254; cv=none; b=b8lKPCjB+O5SvwNRexWRoSMRvnS+dy+LfimGlP1Vt0auqH+EcgxykYGG9GITbFvdltS1QfBr9ttfbyWIdR9dZXPP2i59O6UZmSYU921n9ox3o2aQz2z1CvjeKZacfy3pKr6ONbkxBgunoOxUXQRmfGdYVPbOPSOXMBa8x95ur7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621254; c=relaxed/simple;
	bh=V9iuBXE3RCPxqipBIYq+2imZhquQ1wdIjv+HQgtM/dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJLwvKgnnHDpbFhki3tYzo+8MXLbMIVwYyJM5MfwXzuazAF5uhTJbjUtiMEGfy8YOuAD3urE2JYB+5X3nPTdxCnQHUJ7vB/P6PgJCRPj8rSlMB99h7auKDXxZIAATc42XA06yLjtkFcheKOw2V66quc6sDgQov6KPmHXho67YCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SACEtrH4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4215afa33b7so3026085e9.2;
        Wed, 05 Jun 2024 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717621251; x=1718226051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwbtZSg+KieEl718DTPhm+GILj3m52AXbprU8PF/yug=;
        b=SACEtrH41nZpDxN7QON61tORyWFn5dHuwygegc7csrK+1U9eNU3y+pjx1s2AtQhEDn
         zTV0LTOkl74Qo6MKH1QTZFANECsLKdLNaCxXfxDTcuW3gPpdT+Z7pt04xGDjBSpJT8qE
         WHwNmE3mlg1AovAm0IfQqSyUfm49EXsMN4YMFIfeOai+H5xZyCkIw0POWY4qSN2FNkDO
         2+MViKo8uBB6Zkg2KEvQ0+JKk0G+sQ2y/aWxrilYLRwXqzl7joHwcuOEQSpz35SuGxQS
         RSLKi+BjK4BBRgXIYfnfeREqbN8bCjNGBH5GceK5ZXMoEPA0dplqlrnRXOhf6TOD+8rI
         /gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621251; x=1718226051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwbtZSg+KieEl718DTPhm+GILj3m52AXbprU8PF/yug=;
        b=VHntkoHXZbi6DDGDQbXe/g5JY5FU8BFxFqKfQSmuN0R7rALZ1eolXL82JnrvChjNKP
         1NjMw9cU6m5NJXbMlU6XquF4ahKNIsvYlCV/WBAexftOYgRSw2SbnBCdrwViDSYje4nX
         aCIMdt70wkLfWDjmCBeuabDCsdZJSRfjgbTMSDxBRKeq4fBnR9LQdsSsyrMhHCzBKyic
         bK4055u3cdjbxWqd/pGG+WB+G//PjSth+7gQleuC6p4ysHTgVYa+Dpnq320CbG9Kf73w
         /HOwYCAPmNeQVCPBR8OgTgf4Qx8JIK51REBeN0QR8PyLtgyk+FyrCoffY9J6YOG+fOHL
         ++VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeFHSAEc5r90Pdnl9W2Vl26U0lMeexHZU2t5fq58I05Dv7ITph4A/hVolhGRbKg2wiYdEtUQ9sv3xkASd4eXVYeyEoglPaUzN6d47X5R3eXVm9Q0gf3KFnha/Rvs5nMoTBQ/Jf2x05x7kI77xOdC1bCOs+rq4/9NyltOGk1iABKcWa3w==
X-Gm-Message-State: AOJu0YxRERS+q6U7cC8kZr1gwttieoTtOKQgZEnZAZglCJplyJhDOcYC
	mqpXUdteSZDgzQvF8E3T7APEXKeyVroK2vBNrf7rjHa6u+LbcDg=
X-Google-Smtp-Source: AGHT+IE/9gjfgWZnYQXOAj5tp9SUA5Lk6QARVK16iFxrgqIbxjEEWBQNATeesl0pbTjRSU1L32AXIA==
X-Received: by 2002:adf:fe0d:0:b0:35e:60e6:c8a8 with SMTP id ffacd0b85a97d-35e8405dd0emr2592276f8f.10.1717621251632;
        Wed, 05 Jun 2024 14:00:51 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d77sm15955721f8f.5.2024.06.05.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:00:51 -0700 (PDT)
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
Subject: [PATCH v2 1/5 RESEND] clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
Date: Wed,  5 Jun 2024 23:00:45 +0200
Message-ID: <20240605210049.232284-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605210049.232284-1-knaerzche@gmail.com>
References: <20240605210049.232284-1-knaerzche@gmail.com>
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


