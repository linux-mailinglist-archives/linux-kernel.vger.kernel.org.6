Return-Path: <linux-kernel+bounces-279581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292494BF43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFAE1C25F04
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508C18F2FC;
	Thu,  8 Aug 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5859u+C"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04E18E768
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126283; cv=none; b=SSinWGELu7LoZlLn8tGohDC7CLJ+/r03p7/u+vOoBbv0kWW5xzboY5fcyc8BZUTtCG2xabLx5PtLJQld++goKAweIpOtHhOn8TvYVg3umPbpFwvJ2urmG1ct1mJ/W5AFs4OpNoKUNy9zkIrjgj5y89Amqnk+rXsLKHt/1WT66o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126283; c=relaxed/simple;
	bh=F85JnWhsga2fKjX8ofqy8VS4HE5CVI70avGh7w8r0jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KetNweRBT6B3RcPxuck+GiY14m67Vwg2usdquK2uqmynzQ1zp02Xx3xDgVWfjmser0BldNGtxqNJoKXuGdAha+afelCZimlP3G58nL7t/EI4yIkJw+09T3KmObOiq+yu+S0awOHVSFXYEycThOsF2iSusGGlzx5qO8R5hcvng1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W5859u+C; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so1174871a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126279; x=1723731079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CR2/Ipvc98fbygDSdyGUwyP4a+VA03w16ijfH8oQ9sU=;
        b=W5859u+CH0L/PqibEEfL0OhVE+FZMxmr4XSX6NRh4zWaU7S8Qz+AfUQTraRAQQ7zxm
         bGd8wlOvxwBhnSWJ2TFiMPCx7AUrBpp40pt4ZOMpPE2ihRZyKsChPsxhoFn4wf3ujXUq
         grr1hWltmXSWCNTqH8r77d/LUaGR8zw4MenC1VA0/sLeS2lBpoXtANlXilbPVHLB7Z5R
         R6apdvgVsV+ZkpLMtnK6cgQhNREUJ9pWVaeN//pmm0xStBL4vRxgTDZ9BZuWhkYwjJVk
         gaemE119+zG4j2ebI0ubcU22Zy1s3CgkG1ztOXrMOHc/Q4ocHu/cx8nxODkA69WGy1dh
         Pgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126279; x=1723731079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR2/Ipvc98fbygDSdyGUwyP4a+VA03w16ijfH8oQ9sU=;
        b=UdwZp0Wwn0UNS4Hh74h9LMQu2AapEsJZ4Lo01tt1MXWQvGF2hK/wMj8VYvMYmcIXG3
         AzPQaaBvwb0KZRYcy1OqA8287jWCRMzoZY+3OOnckXCHXEv4SA+x02jFMWwfTg5smT67
         bh2v99NgdJDJCB7aRQN67H1dLPd+ZMCjjUc+7OMlCmYNo9OHo4nUFVzz1JmyqaSDSwS+
         P5pAHeLvPooWcbMOs2KNSLRFnDX/gcTYKTZl5mmUi6LlK4bjBQFfZH2/Ccspc+PWpOAY
         nKVyD3tkbP2oZn2/QtXkZq5hCfAwmppH0T9TImLf9u64jYDozfPe4V7YrVFka36+nt7P
         0heA==
X-Forwarded-Encrypted: i=1; AJvYcCXJzH2h7yZBLuRYLwB60sHAZZrI4B36FkzpChdJV+MyCGfjyHF09d0uLwJKJv8DRW7M44yYydYJ/OrlITYqzWDrGXh7nI5zZ5eqaBkj
X-Gm-Message-State: AOJu0YwUedlwhywUN/U302hyFRoIAvrg6G2WRh0jQ8YK/eNF6ODOBIcJ
	Dx/BuIdXBL5qJCXhkeNtzbjeF8oqKeWoZrSLCnRcSemDg1V1ERLWOD0GKwAWoMw=
X-Google-Smtp-Source: AGHT+IGQvljBuJxnonICHpQDY/uQkKK/KV1ck0021rT8j6xJghx/FmB4/M4YPS1UIlFmnkBzuBf0oQ==
X-Received: by 2002:a05:6402:208a:b0:5a1:6c50:a35 with SMTP id 4fb4d7f45d1cf-5bbb2411412mr1631283a12.37.1723126278581;
        Thu, 08 Aug 2024 07:11:18 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:18 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:18 +0100
Subject: [PATCH v5 04/20] clk: imx: imx27: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-4-11cffef0634e@linaro.org>
References: <20240808-gs101-non-essential-clocks-2-v5-0-11cffef0634e@linaro.org>
In-Reply-To: <20240808-gs101-non-essential-clocks-2-v5-0-11cffef0634e@linaro.org>
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


