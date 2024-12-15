Return-Path: <linux-kernel+bounces-446305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F89F2256
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E5916614F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69CB49627;
	Sun, 15 Dec 2024 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmHIFa9t"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972D29CF4;
	Sun, 15 Dec 2024 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734241023; cv=none; b=pTeXSiE+3RtKWP5h9zraZNCo4bSrKHvZfD9H/sOt3dla5P3DJmJgsRU0TFGyMy/2GttOyyYDTtMEjnuaf71oKRIF1BIPtXRbgCKhMCA0FnZFnmU+sRIHfwy5dicjrgIC82hYYWWXbwNaWQGu69h07DDNF6Ao9aQ/z5a8zz72aTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734241023; c=relaxed/simple;
	bh=t+t+IBz4oAfTZnxqTy01/YU6HNzERwZQNk5FgFkvhKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6QyppJjKivJdlYcoczf7zhIGUtY1Iv4cghJ1ag688zP+xoAgfuXLdq59feGYuMAafaW+6VkfBynsu32RMsy0rpFvaDERZnHPP4G+XTcQoISqZ9Oa3SFj+HdWOoaTuhYEqwApizC9N2coZTMXkxw1GH6BnYrlxXdcKWjkSQF25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmHIFa9t; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216728b1836so22312015ad.0;
        Sat, 14 Dec 2024 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734241021; x=1734845821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKFdza2xHFDC8vmuSIt7kUvA8GVJhpwFBfkUic7sJXg=;
        b=kmHIFa9ttUrwh3oyfVPrWIjkRLdL6PGtXHWl16pAqKS52oKqQteoQfrwsCRSIgf5ih
         iSubqQ+lmMTRYxOocud00yiqiu5KFCJxM7AvAe5h3yFSwBLJCgKNfdEA9h9XtqF+ryy0
         /VzzFp+6850faREkyrpd0hfe7UBX16ntr2yPgn+j/sa113qDY1Sz1xF0lgcKHeepzscz
         sKdyxXyD4OXpqKF6vj+fd7K8cfzFoTJ00i7nwT9+LUE/oNJMEK8xfD1YfpAbkZYlLDz7
         T19dDRsoon1LJOsU6gSY8WJo/PyFS5v+aUPimgb4GxNnu91f0V6Dy2nfYqrWM4t4KvNK
         XvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734241021; x=1734845821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKFdza2xHFDC8vmuSIt7kUvA8GVJhpwFBfkUic7sJXg=;
        b=mBiM5qGexEEG2yEC4vzXGtDe4nbXIb5ZNYGKKNdqf8aOuHVo/GuIeReuxJsNguPSC8
         2O2THGUAHPx4UAaaFEEQq30bJ0Gq3zum1EsytSyaC+f4qS67n3nh6wijq7usTEYTosTe
         L6gUhO7lguP4yusJjgAoCwpg4XBYRTzSNwc0xAmYoCMnaZ6wXePtLh23tMdhMHK0oYr1
         tXZMI363Dly2uNitx4u7FI98+YKzjPK1GHF7RsyJ4BrpwewQ5bzFVviDF4y+Qx1YDJas
         RY45hlbzGivsJYpPgY//5TjQ8lRJGEU5Q3uZs7p90wj8X2740nwiGWUNCG/A0zRvUy+w
         sGaA==
X-Forwarded-Encrypted: i=1; AJvYcCUmHxHCRc4ld24NZylaycP9WKElTu9upsv3Cst1Y3sLUijDvZMj5765jhvZbZ8REQ3ur5Y6saaB/2sr@vger.kernel.org, AJvYcCWMuY1ZHMMoIf9ZNfOyTwk+Ywo48OpjZVrDXtyKvrfk5wDglKSrqOFwSWzGZqSD5PNakRXNUqS1WskH@vger.kernel.org, AJvYcCXZCeouK03d/ulW++2Bhmt+HncnMN90mcu0p3JPjcDrre68acIC9mHnIOHD+wLWUtmv06+LkRe7dabhtZZF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97iipl1uIS2c5FJCfuHRKQyMn7YjpvGiGOAd8sogzwxwwBnEq
	wjOFL1yRi8+L5wMfobo1+x05FtaVwjKkOMX5YIGXwV/RrvOXYc39
X-Gm-Gg: ASbGncuFZ6WNSrY48IABM+Gq7imfBOeKiYhZH5NDC/sdSBAjUyHVbZMuKnJ92TGPyy6
	MA4pNF4Fh4jjnSco4XPNYFq552PrmemFBr8OtuuSGPzXzNXx5TzEMKQnpIEukBF0w3o/U+OulMU
	DMKdjaQzYBLzgqhLtyDyhOdlpSPj4TC/IVLo8tJPw4aF1syUVbPB8AFQ97Aoj6HxkjUQx1UtMJi
	NaBUydHeZ/TvWK1eW9p0rSDejgCaufR4EmC6SS/P/BwE5prIg==
X-Google-Smtp-Source: AGHT+IEEzrDO6PorFmWAnRKn8AWTVLTL53SlxdJAzLW6ec4NvsVjzDB2vdV68Sh9tldHOdGI/Sk3FA==
X-Received: by 2002:a17:903:c10:b0:215:7b7b:5cc9 with SMTP id d9443c01a7336-218929f0ea8mr107798965ad.22.1734241021173;
        Sat, 14 Dec 2024 21:37:01 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:1ca9::398])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa1cf8sm5729803a91.38.2024.12.14.21.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 21:37:00 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Roman Beranek <me@crly.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 3/3] clk: sunxi-ng: a64: stop force-selecting PLL-MIPI as TCON0 parent
Date: Sat, 14 Dec 2024 21:34:59 -0800
Message-ID: <20241215053639.738890-4-anarsoul@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215053639.738890-1-anarsoul@gmail.com>
References: <20241215053639.738890-1-anarsoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Force selecting PLL-MIPI as TCON0 parent breaks video output on Pinebook
that uses RGB to eDP bridge.

TCON0 clock parent will be selected in the device tree instead.

Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 3a7d61c81667..cc8de0bfbc67 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -534,12 +534,6 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
 				 0x104, 0, 4, 24, 3, BIT(31),
 				 CLK_SET_RATE_PARENT);
 
-/*
- * DSI output seems to work only when PLL_MIPI selected. Set it and prevent
- * the mux from reparenting.
- */
-#define SUN50I_A64_TCON0_CLK_REG	0x118
-
 static const char * const tcon0_parents[] = { "pll-mipi", "pll-video0-2x" };
 static const u8 tcon0_table[] = { 0, 2, };
 static SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(tcon0_clk, "tcon0", tcon0_parents,
@@ -959,11 +953,6 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 
 	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
 
-	/* Set PLL MIPI as parent for TCON0 */
-	val = readl(reg + SUN50I_A64_TCON0_CLK_REG);
-	val &= ~GENMASK(26, 24);
-	writel(val | (0 << 24), reg + SUN50I_A64_TCON0_CLK_REG);
-
 	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a64_ccu_desc);
 	if (ret)
 		return ret;
-- 
2.47.1


