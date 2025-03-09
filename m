Return-Path: <linux-kernel+bounces-553140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89FA5846E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE307A1D63
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389A11F099C;
	Sun,  9 Mar 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8qvqG8K"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CC1EFF9C;
	Sun,  9 Mar 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527054; cv=none; b=DAm8LWf9hVI9187wB0/JmFskA33QCprj4KcAL3K6/b6Z9fPYF4deH7z43r8xCk+0mO+jTG3axI+x8faq8PfPvxg1FERIGvsNZo5fhKtcA4YS6D/4HW/9UI4kAWk0RtCCzw3WUPo71NEw4B+w+Scto7KIgR28BpuNVCzVUpenq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527054; c=relaxed/simple;
	bh=NQneIDZjAQWiKY/f0HKL8DvxADMUc2KxOnHKOd9T4ZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsPNfnlXUXuTRQJorC4JlDq3f4+6CWUtidDphK25IZVhA0pBYIPKFn6K4D88ApyWXEI/AXWZ9NFAzdvGrvOSlPlzB8CE1+uInOBBNRRgHEW9ebmiwR28y7QPfglLN0QupgFpfDidCgRps8NvIExJxxCiQ5NZYjxs6q5oM2HK2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8qvqG8K; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913d129c1aso598413f8f.0;
        Sun, 09 Mar 2025 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527051; x=1742131851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMiZGcno+hW9tt+O9F3Zmv9JkNkMks439bcycH2JGwI=;
        b=P8qvqG8KJW3rjnft9VBHj1uARl0gEzhkCgCnwZlTuLGIQFdqVT4zNmndN/WvRdwhts
         GSc4+JZUGtKAaERXJOORTgbk0revnTPtTJAqQhDc/CZMvWiO6K1tJcgc0FWcCzQQmaQ5
         88BqE5vFb7bmFkO5UcmANJKUcoWvpkNmw1pJ972N/ODj/KLaeUBDyOreL3qs+u9Ex5px
         1wVaR4dQKz5DsqtaVjJF1FRQsXCst5vYmMTOYzTtxxkMU/ZzB6gbyx3o3e8FSKQ4/508
         rWVwIRIdv9QNx+gX/U80ZJNGN8zGZZmyUH8RPYWlmTGEU65BLChQ19127Nm5UYthODrP
         mB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527051; x=1742131851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMiZGcno+hW9tt+O9F3Zmv9JkNkMks439bcycH2JGwI=;
        b=ORmwjj7sdzwyCeQ/sTqX1zHZU+RO8uySQM+atGwgjN+K8f6C7xwOVHqEBXaPq4UjyV
         y57grTbA7woiIDbFMqPiVNk0cpQ4UGMQFUJ7b+KH3NBSCY83XsazU60qfXQYud7vOKUe
         m+VNXePLUcVzI8iJ3Otn3S+FOquHObNHr1hSQfyDD4Gxc19KgKt3E9Yn/JzymtUPhX8L
         gWanPE6zH+TbP2WCiFeASWAtIShKV2YCgUrwrAFLwvw7y6L2S2evQ56Uoqijj5YHZha+
         zTvxBXqTlCxh4SaYZXM2/kbsjDbt8dR4lx6UMZiE1f4oM1pJaEFoXT6Sm5XMlkWcnc4F
         yD/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0xKfbeZebScNqYBVRPrMFpuGcBI+6DupiybCrow19t7A8Wp0hXSOZfHBbx40K0cf7Hvtf3W18PwmG@vger.kernel.org, AJvYcCWMx2FQyC1p+OSNUhZ2lxXMqcKD2oW0mRI9GRnFhEIf/9uI50cmsL4sGw7fn1DSSGH45WACPXpC7d5wmRka@vger.kernel.org, AJvYcCXNvdoscu0kTnLbrxTEljgTHIgK/9YHd4MqIi8LOxKYyHxWrELgJ+FkvjqBtq9o8etItY+WDUGY1w2E@vger.kernel.org, AJvYcCXnMvf6ve7Dn7XHGSCiToeeM7qovaGsVUV+XuIjqZvH4b0U/hlLL766hrop/jA6Wk38fogSgC99FFO0@vger.kernel.org
X-Gm-Message-State: AOJu0YwKO9+1MMaNKi/I9Wi/8N2qar3wcgS3aD1RZnM95XW4s0MqF1Ms
	rmzUsOfmnI4u0Q8nyUuzboMLWM/QS2LdD1htXzFGU4vgfcpwiZjT
X-Gm-Gg: ASbGncs9+tGpkjzJTyZTLRNkwai8H96trLODFisYRnBSGvRbK3pc4eENXK20rScFI6l
	GL7gj/CcHDKQvA6bfLbBi6EIySjLzMfaG4pwWKfy9+lCMAvnJZ2gFbMbg5LLXAGE4N4XQ2ex4B0
	8dj0CHlcS6cwZhvNUurymoN/cE3iOk2gYsrDO3tLI72D2X4WzCwWAPdeT+PtaqasEHN3dCi8D8q
	IJww8rheRxW0vc/63z6uATJuVwxIiOgXxwaW+8GECzH4DqatZTr5EeYxea/ZiCB/MHW84zBxuLg
	Xb9543OJpY2cNeLQH8367Oe8bmETUl4iJEbcYwhQc7ZT3Wh7PrathfWlTU1wSrahaGPuCwhXCkw
	QtHzcuW5MAsHBcg==
X-Google-Smtp-Source: AGHT+IEKDnwZY7XkrfL/HLuqPzV7EZSUKsEKRaNGjzZ6iQ8qzVfwZIlEdBBipFRunBqGuf6Da3ld5w==
X-Received: by 2002:a05:6000:184b:b0:391:865:5a93 with SMTP id ffacd0b85a97d-3913af328d5mr4021842f8f.22.1741527049718;
        Sun, 09 Mar 2025 06:30:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 07/13] clk: en7523: support getting regmap from parent node for EN7581
Date: Sun,  9 Mar 2025 14:29:38 +0100
Message-ID: <20250309132959.19045-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for getting clock regmap from parent node for Airoha EN7581.

This is needed to support new implementation with SCU (System Controller
Unit) as an MFD and clock-controller node as a child node of it.

In such implementation the register regmap is provided as a syscon from
the parent node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 2a74bc8fed24..29cb7ccea29a 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -665,6 +665,7 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
+	struct device *dev = &pdev->dev;
 	struct regmap *map, *clk_map;
 	void __iomem *base;
 
@@ -672,22 +673,28 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_map = devm_regmap_init_mmio(&pdev->dev, base, &en7523_clk_regmap_config);
-	if (IS_ERR(clk_map))
-		return PTR_ERR(clk_map);
+	if (of_property_present(dev->of_node, "reg")) {
+		base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
+		clk_map = devm_regmap_init_mmio(dev, base, &en7523_clk_regmap_config);
+		if (IS_ERR(clk_map))
+			return PTR_ERR(clk_map);
+	} else {
+		clk_map = device_node_to_regmap(dev->parent->of_node);
+		if (IS_ERR(clk_map))
+			return PTR_ERR(clk_map);
+	}
 
-	en75xx_register_clocks(&pdev->dev, soc_data, clk_data, map, clk_map);
+	en75xx_register_clocks(dev, soc_data, clk_data, map, clk_map);
 
 	regmap_clear_bits(clk_map, REG_NP_SCU_SSTR,
 			  REG_PCIE_XSI0_SEL_MASK | REG_PCIE_XSI1_SEL_MASK);
 	regmap_update_bits(clk_map, REG_NP_SCU_PCIC, REG_PCIE_CTRL,
 			   FIELD_PREP(REG_PCIE_CTRL, 3));
 
-	return en7581_reset_register(&pdev->dev, clk_map);
+	return en7581_reset_register(dev, clk_map);
 }
 
 static int en7523_clk_probe(struct platform_device *pdev)
-- 
2.48.1


