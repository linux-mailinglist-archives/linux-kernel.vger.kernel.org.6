Return-Path: <linux-kernel+bounces-279593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5294BF68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167D11F2754C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A0190693;
	Thu,  8 Aug 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Irtz92pA"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F418EFF5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126290; cv=none; b=gM5Mb8JHbZpskndzuzCgEpcgTTEZpaCNQCjawHvc14wNTcaSBxfAboULcIa4EkLlLZhaElxbjw7lBPu/z9cDJf58RZ67TEuRnFw9rSFOml6GQ39GAcdfbMZqyHr0QihjWIJ4HRwOOZsRyrXNaLA2MLWiFr7dyipTzK2I4Bp10zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126290; c=relaxed/simple;
	bh=fgoFdUktN0AC8jt3vFeTIBwCbSQYaBCYL6rp147Iyig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnIT0qOIFf/dRheTe5dlhI+2mdwKuqXhJczdOw+OW9Nn4EpZ4aDgBbjilAGlo/ZOf+HSO1pn/Q3GQpkX2n/rsRjM8JPtu2ktp6hurojeBfV3PMafPz3uSTXrQwu+nXkMRbjun3+073gOI0Y6d/kDvEuhBTreHLHpfaucI55eCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Irtz92pA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so1130833a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126284; x=1723731084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Of9JwvhLlmcEUvlQcUj1kyU6mPikzafRwyTDPy8iQT8=;
        b=Irtz92pAANFSZ5V+MNmVaghtgvl9Ldqe8nsoP1YiH3RkcsTAwyyn0/EysHxIKYcXDN
         1+hPfh8IwOcU2BpITFQZ18fZ+7mXYGtLADG+fV4uCbwEBwod6Z+LKmFEYAh0uJ4bx7wB
         P1B1nscpekH4NlfmvXDsQ/eIh2Lxp9G2uluGRGn6U7/C29tL0rUAYEyx1qwc8b5PnWcd
         GsqutY1aLLO+DerqjW5SozEq0KVhjMMr9U6tvyzM7pIql7+HFYnuO0uht8NekigTr247
         jevv3Ex7PD1ZFtC4pLm1XBix9H3Gosx5T03LdoJQ2ZhL+iXeF38Pe621JCfbuq1V56aP
         mwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126284; x=1723731084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of9JwvhLlmcEUvlQcUj1kyU6mPikzafRwyTDPy8iQT8=;
        b=ZRLXXCcztiVvogw9RPRd1LEiWoRmMIQobpuEO5JZtsT1q13aDiXVrxmF6be8LCO1g3
         /3d2LsfdNhxrpj0F+i3k8K0G6E6qxl1dkRezTw2+dc3WRe5ft45XgVC81jaRSI6PJ6qC
         qBNXBBmIs+/sYft99MG/sADYQrj54FKmfuRQ2OkUssr2r7kQ7zo0SDoFqJ74KVW/bc3B
         YSSPYBoWc/T41t8899GMEQxcT/16X6pkcHzjSLMRDG5T6viEVeSFEZVgtnehr/ahVPHu
         qbkf4j99kz9EiDhPph9adqpKsQSxQM/BdVArG/g7e8mKjQaGm70r1OMcA9W9FLwrxJ5v
         uVEA==
X-Forwarded-Encrypted: i=1; AJvYcCUfFkTWFTIl0VGdKHUQ/3vDFTAc2c2aKGzAmDm2vO3epxK95QfAtJcXy3OawTq7DBTZJRJ1vBs23Z/SuGfGkD6morfkO+oCtGJBKQlN
X-Gm-Message-State: AOJu0YyvTGUjz3WboEN2DV12Z32VDbh05KrCZKv4jKEOgWlnCQwtrkb3
	bi4474KcGAGXcM3tDBBychJQtN/nAik2ItRzKdSm/LD94xqZeKFrsN848PsSdSM=
X-Google-Smtp-Source: AGHT+IFf3g/jYuJvYQwgVJBe8vCrF8fGufVkSyYm1tnaBSWaG5CaYQLX35KDxCAtiZcxjnLr0qD2Ng==
X-Received: by 2002:a05:6402:210f:b0:5a2:f154:95f4 with SMTP id 4fb4d7f45d1cf-5bbb21d08d1mr1734856a12.22.1723126284388;
        Thu, 08 Aug 2024 07:11:24 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:24 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:30 +0100
Subject: [PATCH v5 16/20] clk: imx: imx8mp: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-16-11cffef0634e@linaro.org>
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
 drivers/clk/imx/clk-imx8mp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 516dbd170c8a..1c128c051199 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -721,8 +721,6 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	imx_register_uart_clocks();
-
 	return 0;
 }
 

-- 
2.46.0.rc2.264.g509ed76dc8-goog


