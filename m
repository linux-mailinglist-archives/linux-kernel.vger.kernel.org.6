Return-Path: <linux-kernel+bounces-279592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF7294BF69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8B21C22E83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEEA190698;
	Thu,  8 Aug 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZTIxwAM"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6918FC68
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126290; cv=none; b=FResFu/SEmgFwVsGkUvcHLMDXizq4130yEo67EZJj+ZqWJCfp1928jCJx2j55oMJdWy0oJajtIms0cYiI/UHJApEUBk4N+zPqpEy2ez34svfz4Ksvs0mAru0RBt1tDVo8fwyIlujNh8T53Mdr36AXQJTNMpScJ33Cibyb82blq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126290; c=relaxed/simple;
	bh=e8jx8xmkdW6YnrISThEmwGeUauedgdSxxNVyoc0/+CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FAmbMTXwWR0ToWEMkX51gdi7nJT1hYRxJWRoINmPgbAfhQns8o1xEESU3ENH1mONRJ6WCy+43PqilSPeYsNj4oIQzA104HFxh+ovCfeglJxnLPZ25GHmszpIeujYUL4l/BLE3uNvxmME6JWTR1eGbMBq0oE7RvUY38bL5CW/OrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SZTIxwAM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so1082525a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126284; x=1723731084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1BcegJWI56BA/X7kHTU13cyTVS8Z7HSnW1uFBI1IcY=;
        b=SZTIxwAMJVh80WSMV2rq9bAF4YFp/BH7RfsKvsLCTjFbzRp6JiEvGlOQC4CuMABTZ4
         hXz8yr1eDiGFUL5gcguYSk5CyPj7EMzD/7gtpFNitTIoN1QRLWIyUzov6Bq4oRWNcnNV
         0FsmQIbAfBNsBFbsVB2vIAd8azeDM/l7TbMreKZQIhhEt9MFQxaoTGp8U4WR/oW5bsLa
         u3KKEhiK57ZYOzeDFKeMAl6j72wF5EM77CyoQzE/PLFPm4PLWiPSlmnfAFh5DSTiq+Et
         1kVwysWz7OheRgyLZiwZsTLuKgZJ0dhgy+ZeptcuaHBElpLHBu/6xPNWelvNoTz7T0aJ
         f53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126284; x=1723731084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1BcegJWI56BA/X7kHTU13cyTVS8Z7HSnW1uFBI1IcY=;
        b=RIXuUUGxKb/26qFTP84E8UJm3rjD3RZCt81wgOkVWPPwuebKnuByjCfcnGcV+gAde2
         TjiPjklyk7/qWipl5gRztn4Rvd38CC6sWWB6caGbJj+oPravdKee6issa1qpleSnFbQm
         DG+fnuBc5poiv7Aie8nb9Kx3aYaHhIiCSD6vOrjAAO9CS9wcjR4/tcWBezU4T2VtwRta
         uzcVj3GGNpWYhWAxy/Ds2DSwWZoNSmRzjvFhIbVyl9qbGOYpd4ovRSPHEfVuyJmQaLRC
         29INVFK+YzZtcdm7HwWt11TjWWNs0Er3ebZKG7z93nmBCBAmcMSQk1pjuP0w8WWm6mTZ
         mYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK0IagyfATFJxj1NfgvPQdmQRCnk+w+/zlNvnA0br4yo9Bb7Hhw9aVDjqqomD6KLm4a+YHkix232QP+f4NPriwjnpRY8iXIxK2PbNh
X-Gm-Message-State: AOJu0YwxgDP3BiwvrKXafaKpBMyNB3V2OCA+sw2AseBZLujQrFEE5AqB
	eqKjvj9v+SUEPYZv1s6QMQjHmUKcttDvv8IGLxlTJkpaesix1lStaTF0M391/jc=
X-Google-Smtp-Source: AGHT+IFDQ4xO+7IdMcxAQOisAYakQnBCgmZLgpWTWFQiC5OifaIDp2UC1DBibihQ4Kt2Bm/3m4eP0Q==
X-Received: by 2002:a05:6402:1ed0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5bbb2231a48mr1923760a12.18.1723126283922;
        Thu, 08 Aug 2024 07:11:23 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:23 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:29 +0100
Subject: [PATCH v5 15/20] clk: imx: imx8mn: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-15-11cffef0634e@linaro.org>
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
 drivers/clk/imx/clk-imx8mn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index ab77e148e70c..af7f4c6b51e9 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -603,8 +603,6 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	imx_register_uart_clocks();
-
 	return 0;
 
 unregister_hws:

-- 
2.46.0.rc2.264.g509ed76dc8-goog


