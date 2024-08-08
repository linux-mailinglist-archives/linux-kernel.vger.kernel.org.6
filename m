Return-Path: <linux-kernel+bounces-279580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBD994BF3F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5D31C25D92
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B1A18F2E1;
	Thu,  8 Aug 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJMWb8bd"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D918E760
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126282; cv=none; b=tCFSVXIqs44ZovXxlCoBkU9kMAuKCWBQ9YUp07kk6TPyA6hHWTnDSnuA6FSv1/C/gQdt9FHJGRTV9rUxoAJYjSIr81nvtNCyWlKhTVvAEZQgXwkbvSAkY3b0wBQjMGCs4nliGxxN2DK7EL9i5Hh1bEd7RnaJUl+xRn67ig1O2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126282; c=relaxed/simple;
	bh=0YLrrUzUpbGAZRD9K0JKJsJf0lqzpBPah1/3yREgZxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJxqG+czKdVDZkWOUx7SzmKuADmb2LZJvvwS84fZrip+pJtFK9EMjLA7STXa/9BxuKedON1WuuDYPqxzqBRDQ0Wr3I78hAj3Nsa1j6XTWb5U+MIdgwtjibbh+SySKmg5yJX+FFD3kKOLvGBuqjZBd/i2UK8vhVHMzFENwTk6wmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJMWb8bd; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso9932891fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126278; x=1723731078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUt9AGf6xrjDYDkMTJVYo9C6PTxCMU+FJu9o1lmsxnc=;
        b=uJMWb8bdA1qNCdrDnax4CHo20+7RtoezLbICinDLufbOMuJgUy0lRVROowrOjVewNP
         r1uaDmVepEn8SB3pXW+fPSCZ5iiVGtyUtijNGVNdFrS3QdXhyMee5rGpobA6ews0ejIN
         vFZDV5rpmj/WQ5AJOYcGCdzf1coE17FpKUIMxiYuxA/y6e/zo0Jq9l5gSIf/aIvFeaK9
         o8xcGWC0+zDsGa11L0kKH3OBFZb3KYP8G1OBqfnxak5bgSJTnz0HUfYXXYq7fMyMv2m2
         faw11b9E7BrGp1KgtTNshAoRzERZadGAAQDBBy8scPfWgDNzZCPp4vX38VAoschPhmSR
         9HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126278; x=1723731078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUt9AGf6xrjDYDkMTJVYo9C6PTxCMU+FJu9o1lmsxnc=;
        b=SfEZbWHSkGpfSnjpeKcb6pzOIcFRsmtqF+33otKuc1LRQxj5JoQQCMUoPrjsBPkWi9
         h/TwFx+HwmdRYu3mMv3ou2urwU8hh9Pfhy8Qe2zgQXPockW/5h/vfjmowr0loqDmIjdL
         Un+E9RUJ8OyV+jImQxnJIHw5DYpCu3S+UkBytf6nRuTGVU0TbJL2+cDs8zb6SBjrQLx4
         fluR+PWRnhcilNxgsZtrmzOhABZpeiVpiAosyWJ/Lh/IhrYciCNww7dUxyhsXjgAYhh5
         NznSDAU9vW56x80Iwz5HwkyBOLF42yKyHBO5LSLZKqpHoM4uI/MNdXsvsnP22CN52KGu
         /z0w==
X-Forwarded-Encrypted: i=1; AJvYcCXk6TTlOH/d9cUuhFW49nMluH+w2zZGvixhR1tlf/UawMC7DR88dJ6CtcZwDUqDKa5gg1GhWAkugMpZGkHG7l8CG5YFRNyt2d9rUQ/P
X-Gm-Message-State: AOJu0YxIuJMlO9d/NIijK9B/pM/P6LmRo5vSsmb873b8f/FkpdJ4jLHj
	UEn8FAkx/yDbTrvymok4NES/UwCD1xnY297ZXKWkKOGNLcDf+bU+89CMnZIo0uc=
X-Google-Smtp-Source: AGHT+IEY2DAUwJrjHTEH10xM6JFqkX4gRZp5wutBA8Sn+BdIuNTzPwSCN+6Nbt1OGfGJKNwnn6NPhA==
X-Received: by 2002:a2e:b04c:0:b0:2f1:8624:a4c with SMTP id 38308e7fff4ca-2f19de79f8bmr13694521fa.47.1723126278097;
        Thu, 08 Aug 2024 07:11:18 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:17 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:17 +0100
Subject: [PATCH v5 03/20] clk: imx: imx25: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-3-11cffef0634e@linaro.org>
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
 drivers/clk/imx/clk-imx25.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index c566be848c2d..0474778f988f 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -219,8 +219,6 @@ static void __init __mx25_clocks_init(void __iomem *ccm_base)
 	 */
 	clk_set_parent(clk[cko_sel], clk[ipg]);
 
-	imx_register_uart_clocks();
-
 	imx_print_silicon_rev("i.MX25", mx25_revision());
 }
 

-- 
2.46.0.rc2.264.g509ed76dc8-goog


