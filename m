Return-Path: <linux-kernel+bounces-279645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDCD94C005
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA5E1C22166
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B531917DE;
	Thu,  8 Aug 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6TXc5BB"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6918F2CF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128177; cv=none; b=Yl/dj0b2hjNt6xQwUS0+0cJ1lbkdFdJltS5VL2sVPW+662376ZlrS5iK69gGBefmH3qi+r9+hLcRjcNLfSIxT5G4AbHA1pKQ2z/JjPqTnmTCGbtBbYiyqnc2+IkCDghegCp3N3PnWq0Y2fq6V6QCY5SNYBapG5lFh214VR3p8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128177; c=relaxed/simple;
	bh=SiZ3szIGvyuxD1G7YmXCV9iLcepTAaj5c+gARHQ/bJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLxb0bY8dGcZ2gIEkn5gr96pcPE+w7W6TzwNejwLtEjUUCFCl0ZPQN5JwN3y8hLRAOHFgjftITcd+Una4ZJAAC5WOWKV4mN9JYSgef+CfHJsmxhl87tRh64L8yhtrqv4uKIoQn1cF/G7tyvuGOVkuKJxlbcamhAkYZCXscMPW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y6TXc5BB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a9a369055so106375766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128171; x=1723732971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5MWL3cjgLEXuvIZC5lLXbB33GYudCtwZlnHK0GLdqg=;
        b=Y6TXc5BBPZ0bNC4WhGDrjIJBSxxgkFpQfXrDObQxdpiCsbc9u0RBoZGNgb7ctnriHV
         3mIboj+MFV9V5/JO08Fco8DVa4N59V4usyZSTPYY27TKt4dWCo9+BqcFTK4mgRA4PvN0
         OvufZh01huJeucUOBswfcKB7XflnQlf+GvjCChNHRPzskV59n99nINW8LJYxiB2Jg2Su
         4cMlg46qJInpvlPaaUlKaSoby6u6075GC+jQK6YLuZWKUtwdkvYNgXBeywmBVGiF3mCp
         bzVb2sq8NLblEMrXOGSK7QxaSHKIIXBefkKhTdm8eyGcIlWGqGiXjapUOwq9KLWro0M0
         ZtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128171; x=1723732971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5MWL3cjgLEXuvIZC5lLXbB33GYudCtwZlnHK0GLdqg=;
        b=azpazvtleXaP70CCcb6sp0dSQFg3tW1jKG9r/3MPqE2JiUVn681biJkNyIOeq6KpT1
         tfo9hMwH+apZKceKU2xSuMbA2H842xLx9bwZDFR1BZd6ThRVdQBfR7p2UO2BfsnwAhX1
         c6JE860KYId2Xd1XwLoHMsJOpPt80fcJn1JOu5d88ABK+tDhpjJuM0A3+wf/dcLT49B9
         EtCLBGqeb9uiU+m5xhUbfpRjHGMC/XW0gPIJSAyKZVcUvWJGbKr5MAghGeVhZh6ytAHr
         /KmK8M15w+w1y3K4Sa56xh4fRAd5+j/buqGnX3cByheCaVoMTez7RPZx752VrYpZAOJx
         0yQw==
X-Forwarded-Encrypted: i=1; AJvYcCUDRgjJTvFTWmYGHJcgwu+85jNnPokW+7LljesoKCduwSz/4LogrMSd6dFGHHplARIyW/uXKfzrlGocIVj4h2hjXQ0Lfx8AhGXW8UQW
X-Gm-Message-State: AOJu0YwjV5x7nU5mpc90MEqG1RX9KLCu2t/BowA4bvTPhwGZX0kd5GIW
	vtACXEVbSTp6pBJpSMKxvfleWz8XlWRr68K2d3pebOdvPGMyO6tmzPHQK98yIdc=
X-Google-Smtp-Source: AGHT+IHSewliej7ECiKs8Pj4pcmuOAg1jmAB9ryEfKa8DiqRd8T5n1QapjnGAgj9RIhKle0pBOsBOA==
X-Received: by 2002:a17:907:2d0c:b0:a6f:4f2c:1936 with SMTP id a640c23a62f3a-a8090e4057emr169860666b.44.1723128171105;
        Thu, 08 Aug 2024 07:42:51 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:48 +0100
Subject: [PATCH v6 07/20] clk: imx: imx6q: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-7-e91c537acedc@linaro.org>
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
 drivers/clk/imx/clk-imx6q.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index bf4c1d9c9928..b436463e06d4 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -986,7 +986,5 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	}
 
 	clk_set_parent(hws[IMX6QDL_CLK_ENET_REF_SEL]->clk, hws[IMX6QDL_CLK_ENET_REF]->clk);
-
-	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);

-- 
2.46.0.rc2.264.g509ed76dc8-goog


