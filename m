Return-Path: <linux-kernel+bounces-279647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A7C94C007
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0A01C20F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7930191F7D;
	Thu,  8 Aug 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWlfAhV+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8518FDB9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128179; cv=none; b=uGfjFV6Q+mI1PjUrhZW/jf/ZWUGyNhYMoXMbdE6cPLqC6l2X6RfRMvsJTQlqRmJObZ2hQKHYkVc+lger6qjatQqd/7CHX7h3C57gqcjPgtXOQHA6ycjHK+oCopvH8+OpLEJQrf9ppMI5S4bEfNx6Nm5Qq9IdFI0uBXKHM0FmSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128179; c=relaxed/simple;
	bh=k4Mp7OQtKEMyYQQBprE0etTznHJ6XNdrfUzHCPYj4Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hewxZceRFiqUOGYkVnE4SWBfwEFy5LSs7znc5JDVrWBxuZW4HoF3Tamx+82C5YICDwhJD8pzKVSlNAJFtCWa8UbdFYCWDek9hxLXrOFj/7lpQtkI1QFtqn++OUmHpIb7LxCEiURoBZhuOgx8Uko5Ud0o4N7IHtsGF+kgfInwE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VWlfAhV+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so122573666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128174; x=1723732974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sTSIJgqJzgG9ZOeXhaBq4KjYwR+dgEfjYLq292FpHw=;
        b=VWlfAhV+RDk/ZrM89B0B5IHxDZIbikNC6X98SOUIqP23DC4unTpU9Ldyxumdu+mGqc
         6OzL4c+T/PaawJMX8NZdQ5C8MI7lI5nxEWXHkt2cfWxJl1UN2qjestL5Is8karaXSD4m
         r77x7GORSophzg6sR6FPmJFoVFGnehVSERqr7iN5ZL5Du8qFQpfknr6J5FD171KRFD2J
         9ctcP6pU7zAjyJtBiZMPiam7AJg+tkJ32CjZNs5BhhaTFQq4q+qLTR4mU7l1DXrxSVRv
         wZTAQZQjiV5Tfj3rni54A3OGRJDGJyOcCm/EljmuQfhV/AAZvFeaFCPgG/2WZgaUuree
         TSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128174; x=1723732974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sTSIJgqJzgG9ZOeXhaBq4KjYwR+dgEfjYLq292FpHw=;
        b=BXjfXSxb7H3zirDRJ+Dh9nQf9e0Pkuw6w6JHnZvPwUFjXNNleHuQoVxZL9VsmMEbyM
         e2vOQqikc+Fw3GbJI9xxCltAVkIfXu0kDkVDjImJIbZgyMDSKHg4r9YOXDQRwrPiYYgj
         s4/1Sa64uPBxmwA9u+JP3xETr66l1UMpkWse0j+z9bDmIJxmgYDOPHHET4XYyU/26qu9
         Xy9RIugrlO+vXxzd1mFm73x881aGlqio/6V/0CBcAyq5OOB+L+xh2sq0uPk4Q9rrxnf9
         RIzZoXtf71xCV4YpeiPLvYBygkpZdNghgUYYbyFW19HyRhNQjRgY9BQF7bt1JawoKNwa
         ByUw==
X-Forwarded-Encrypted: i=1; AJvYcCUaIRiKa1x2Hrfv0ncvqNpA9ulW7V1ZD27xSj5gZbQQUoAN3hdwPm0xYR/Y3na58I+uk8moEnREvTnePDc3AIisNKj8bFl4GEzlatMN
X-Gm-Message-State: AOJu0Yw9ZZUfNzPMD7kc02cCjtp15JpEEjo1I58WvdwmB9Pi+6BvpJSm
	8jgzJW+2ZgZcWV0ay+r0+hrj8hHwvhOsViruZQqdJb5VyiUBeWJnrpOWPgo/09k=
X-Google-Smtp-Source: AGHT+IHR8FpJNdzuqaSJlCS0dga7rPYT+WlNUnJeQS1SMhIWL9rsDOEKxbf+CirVT6VIRhxUGlibjg==
X-Received: by 2002:a17:907:2d13:b0:a7a:952b:95b1 with SMTP id a640c23a62f3a-a8090c82bdemr182009266b.24.1723128174054;
        Thu, 08 Aug 2024 07:42:54 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:53 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:53 +0100
Subject: [PATCH v6 12/20] clk: imx: imx7d: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-12-e91c537acedc@linaro.org>
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
 drivers/clk/imx/clk-imx7d.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 99adc55e3f5d..789cc3afd062 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -882,7 +882,5 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_USB1_MAIN_480M_CLK] = imx_clk_hw_fixed_factor("pll_usb1_main_clk", "osc", 20, 1);
 	hws[IMX7D_USB_MAIN_480M_CLK] = imx_clk_hw_fixed_factor("pll_usb_main_clk", "osc", 20, 1);
 
-	imx_register_uart_clocks();
-
 }
 CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);

-- 
2.46.0.rc2.264.g509ed76dc8-goog


