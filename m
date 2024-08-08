Return-Path: <linux-kernel+bounces-279640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96DD94BFE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D3A284758
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D118FDC7;
	Thu,  8 Aug 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhZQqbUH"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87818EFEC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128174; cv=none; b=MK1JVvACDP/3fo/ifzO9N8XP+hUJxZf/p20EKts23jA+LrsL8NeNkeKZBaIcOW1T5Avmpjy0kyKXTB7G8JtbNnlcbs0IqWO1ZlqYEiWbBk8KEeas1/epuJrWMbs0g9vwNodtWwSOP0Dwo/kxu1gSVsNqInzB8SWDZmFZZBzufNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128174; c=relaxed/simple;
	bh=F85JnWhsga2fKjX8ofqy8VS4HE5CVI70avGh7w8r0jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcqTYEg7bvtCA2/rx47V3+QbOfI0RRQi/vx3vd+x2KlC7xQPCxz8b3jJ3tly4v9RhJsOBGA0MPkTHC4TnlidFjIpa9A3vHSPiR7lQp4M678EUROVY0fQJawipvwWqDPMOroXQzXbdKJsAKyTAOaLbfDcwlfK7nPSNjrsMsfuhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IhZQqbUH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so16626691fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128170; x=1723732970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CR2/Ipvc98fbygDSdyGUwyP4a+VA03w16ijfH8oQ9sU=;
        b=IhZQqbUHqcGR57MmU5iKSugIZTAH+uUYtj8UIV713PKpX9rcIHYsCPdS9PxoatapaS
         F3b2ZpND5ehaCV7OR8qZLve7Y/Iqd3NvV4BPE8HNTTEcsuk3VDcp+CpbvO/rlphZRJ1I
         KWUVZqJ3N3VCBmO6J+LmgZOVKyylf/ZtWCpXs3iyvwpoj9pGF+Gb5WUwBT+eERZkQr8t
         UKGIDRMZTVn9t7EURDazqBrLI5FhNrrR9Z+sb0SI0ncRKi6xfMnShzFZOFgkMgBwqXbg
         2/xEWJjOD0lMCy6uTatUYWU9eINBVapona7pmvNXpIB+MveKRV5x/M050kr0h5n/E7TA
         FtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128170; x=1723732970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR2/Ipvc98fbygDSdyGUwyP4a+VA03w16ijfH8oQ9sU=;
        b=PBbR/CpKg8Ys5m3Tvu3sfgbsnXMx5TtAd4bbVBQfpuS7cIYdoDb0VwSwmVzv4M0u1H
         yt1bKh2PeQvbHZYDfJwWn5zBrvT73oewaEkHXlG8EiGmx0plg7DwtyJEJbkyKk7LbaeO
         FCs8sQcvdW++oYWPWZap2TZheMBf8zvOJ7es4/fyCGWWy/ey8tWBn9Vp6V+rdjNWZ7x3
         W6zQ4/hXcpsaXwGhRZ9C23rgeVBJqZCVhcxC/QIk121E+JfVwD+hKtXIpBeYIEWh0vpA
         xjjaDpxeCZQR2PWi3WrFUO2q2ygVITs4j0VvzqOicYcaJQdW+QslqtYnoWwimHG4ARoy
         lZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXobOYKWLgSJO5zOEXY7dR0LHwZkTMtxopyizlXszy+lzlCqqB/b0+CMN13/t3ZxbOZik69LRxeZ9MYdT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEvku9jHroa0VSh3G31eZuQsJy5ehBxe67+CudRc8DpZsIEwA
	agh5lkk4iROeiXlzOQf4GWgWBzpoc7BqQVFVpStdO8OQAG2VEJNqjuBpnjXzt74=
X-Google-Smtp-Source: AGHT+IEa8lUG5PUwt8CAXfqOk3wGRaLOx10UCEmHtPBg+F4Hg/YBNadhRZneaPV+k6P/U8cOdJlD3A==
X-Received: by 2002:a2e:4602:0:b0:2ef:2905:f36d with SMTP id 38308e7fff4ca-2f19de2c724mr15068821fa.16.1723128169710;
        Thu, 08 Aug 2024 07:42:49 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:49 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:45 +0100
Subject: [PATCH v6 04/20] clk: imx: imx27: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-4-e91c537acedc@linaro.org>
References: <20240808-gs101-non-essential-clocks-2-v6-0-e91c537acedc@linaro.org>
In-Reply-To: <20240808-gs101-non-essential-clocks-2-v6-0-e91c537acedc@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Abel Vesa <abelvesa@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 imx@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The clk core now does something similar for us as part of
of_clk_add_provider() and of_clk_add_hw_provider() and this i.MX
specific call isn't necessary anymore.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/imx/clk-imx27.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 99618ded0939..53018e80ca51 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -164,8 +164,6 @@ static void __init _mx27_clocks_init(unsigned long fref)
 
 	clk_prepare_enable(clk[IMX27_CLK_EMI_AHB_GATE]);
 
-	imx_register_uart_clocks();
-
 	imx_print_silicon_rev("i.MX27", mx27_revision());
 }
 

-- 
2.46.0.rc2.264.g509ed76dc8-goog


