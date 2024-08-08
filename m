Return-Path: <linux-kernel+bounces-279585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CAE94BF64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC65AB2636F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BD8190662;
	Thu,  8 Aug 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xM0jLSwC"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F318EFD9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126285; cv=none; b=mFRt8Ywp4a0XDUsMQFbkpppT7G4I0GgRNXUjSGJJBWV6nyHibqN0Xhj2c9DAGTqZ4W4wjRLkoa8r11SxDWXWnI5hOthxOKi1V9ml4Dw2mtXZQx4BjlcMcm5BXYoTSnSB1tqeHZZg0JWzWOgBEmeabxt+3XuL9ILyiEAOgmszCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126285; c=relaxed/simple;
	bh=SiZ3szIGvyuxD1G7YmXCV9iLcepTAaj5c+gARHQ/bJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWjH8jX5k9NFWCufNsgAmS0gLmYy0i/ngO0BC9nyPH/fdZnIaCpmp9/hJPTtoQ2Jdqk9aVecVZRkKv0leM+6buPi0F14Fr8OqCbtyXPN7uMnhGNbpf/+zO2QMorq7B2+0iWja58KHuBx18R6vkC5CQKgzW9Kg+ua3pZ+PTlZoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xM0jLSwC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-530e2235688so1091863e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126280; x=1723731080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5MWL3cjgLEXuvIZC5lLXbB33GYudCtwZlnHK0GLdqg=;
        b=xM0jLSwCWQGHRppHb2EUw+OWOSiXp6k7TQa7ZkvmQfbWDvSznESL00MYuSIChjrLYu
         +Wa7Gr9udGeRPruXbF+uoOnvyXqSPF2ULD57YCGlmN1mgxMbTamiXK7oVOiru+vYaIfj
         Q+qVIz1vmpVoC0xQZmT6KaaM4S6/mv2mJhb5ZiZWZQM1EZafURFaa2z3snKK6ahg9n8/
         P7efCAraL7a6lGgSRyyrekdz1H3PqLrTIPt7PCuauvnHVAyWg0f+63q3Ne181daz249Y
         2poUemx7UN36ze65LAF+tH6ST5JzvgsRG/0PEwmR3SMoAysyP/Bd5eISdA+1VG28uOcl
         OrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126280; x=1723731080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5MWL3cjgLEXuvIZC5lLXbB33GYudCtwZlnHK0GLdqg=;
        b=Uy6K34UpxD3t6b1maBgYqEVkizz+tpvCY1mwQ2LaKrhFW0LXrqKWUaCY7kZYcLVc3X
         lA+Rr+UwpbUR9A0xipohcqZx6pvyyfPDmjBFJ+NzXrP0zKcsGHdNskEgaeMQjIMomjMr
         JP7nhAVLYjDvpqawY/uER4WfDXMK/eo9lgkMkpQ0gNhx54kp3VgvnLMneXHAsFQbLoXd
         M0h6PhqipsKzLKK7AlI53PDKdo01X42CY+DOvX/FK+wy6NKODXTShngNwagzWezHMO2t
         QDZkbUhkqdhXkpFXeKyCEpciXNMPQn+Mo1eO6SLalMtuSnrtF8l1cO15GyouD64rTHmr
         5sYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrG287KS8YHYwZgFk1uh1PSWPC6LxDMzPXqE3FnEUb9unp7+VbRoVXSS5Qklzn5kQAE0GDp3C9wdwNMQupmA7ykiL6Dr7bKsAkFwNh
X-Gm-Message-State: AOJu0YzwPtd1fD3/eam4uAFbRxEGiaFeLec7SzQWzvknL/JGV7f4+XGO
	gzXd6gymcplcD1odkWaE7KgJe/6BF5A5204pxIfRHt18wt3v5/KWQ9H3IhaHX2E=
X-Google-Smtp-Source: AGHT+IH5Kf6gdlRKSpC6X2ZKv/aljG4na8Kr//uvGtQcNgodFdSqi5phhv7A8UtaPZwiOthbvaQKXA==
X-Received: by 2002:a05:6512:3d18:b0:530:aa53:60f6 with SMTP id 2adb3069b0e04-530e581ffb9mr1693230e87.15.1723126280108;
        Thu, 08 Aug 2024 07:11:20 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:19 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:21 +0100
Subject: [PATCH v5 07/20] clk: imx: imx6q: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-7-11cffef0634e@linaro.org>
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


