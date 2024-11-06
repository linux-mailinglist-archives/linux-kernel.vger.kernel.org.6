Return-Path: <linux-kernel+bounces-397890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3109BE1F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA441C22F43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF61DF97B;
	Wed,  6 Nov 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FBybwuOU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94551DF729
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883982; cv=none; b=OekyvTs2T+2JSHSo2iInuijz79XbAACdYf61eQ4nGBk/qcrTse7of8yvx3nhDhbBImtVGtRwTmkYlWLWnQ1PDC3ODyYwazkA1dOVL3iqGeVsXs3GhFuzKTqmeubh727oLGvzKUGGFPN/dAQRH1cpWvrGw7otnuDtWr42uUBPvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883982; c=relaxed/simple;
	bh=KmBueEVKme5DtcuzYm7hl+dZKGVzspxJFWdpCrLNZgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV0KrM8EqBQt/oPHh5xPB3isGzhxOrkzkQG58NqK7ENk0TQ/cn4o3Bhsx1qhILtJ9IsQP9VGFbAx7MldB9D+g56tG584ZjLYXwBcKGzRZaBCr62u/eBxZOLacH3iPVPcSigosT/ppkBGC/xXY9cDJVJDcbHc/X7lOP/DpoIkgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=FBybwuOU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so7287373a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730883978; x=1731488778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RymkxnNQTDpNcXN6Qg1uYxhHB5JeOGRw/tDAC3s4FE=;
        b=FBybwuOU/EJQTqtg7ioyfJYNXjQDIvkksy4//AmfQffG6sYnIPelLmmnL/NrjLRJqa
         Mlgbe0Y5EEL6Fg6aAolMyWcb0o7O+L09qPltwmrSdZZbR4BKF4lxlCtDOG4xpMnxqxZa
         6XRuwXur6C0yiII05IlLcoD0Y6zSdW6sxh5tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883978; x=1731488778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RymkxnNQTDpNcXN6Qg1uYxhHB5JeOGRw/tDAC3s4FE=;
        b=T1wCXzG7PO2je89cRHXHw01Qtj6ZU29ktbwGQgST/yMDjkh1EdyA+Y3S8gANhCgFXN
         xJM8o1LHVQr/iu3Uxbi6dI8J7Rc9zjK3PprEW8n0NAhoE1ydU0hS9bcPXLyO4jG6jBLn
         VuQ7JlpUT9dJK2QaO8K/47E23qKu0u2B+mYSsyORGQgbwcPf0u2bjHlGwDbAeZgPHxIq
         ZbNQy6AO/RD5l/XEb+AfrzXoyjZU3NyZbyczSSrmcxXMcdhgQvdyt/qdUKtK13uycjFY
         9x+7I/kLIKxvFtC24veu5g627dCIggL0+ZKDkPY1FWInJPIcojR2jYEbGDnqehEd7aNO
         vecg==
X-Gm-Message-State: AOJu0YzNa7/M3KobhJ87vrZ2QwoAaklMQH61afqZqR03pW0SDr6roJeX
	zmPlbwnCcYbjjktkeNDYE/5vkA9veRKqk82yYXM4SYO8zHn84U+SQfk7BK0Hie4SvR3cnPgeGhG
	7
X-Google-Smtp-Source: AGHT+IGhUhFhDLrkRIYlsMo40Cw3IMcOnJmroZfmc07tt3QFWoaWVS9zSxCeYKz7sxTPazJhdIC8uA==
X-Received: by 2002:a17:907:9724:b0:a99:ec3c:15cd with SMTP id a640c23a62f3a-a9de632bf49mr3313553366b.54.1730883978186;
        Wed, 06 Nov 2024 01:06:18 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:afb5:f524:6416:8e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f9422sm247781366b.139.2024.11.06.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:06:17 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v3 7/8] clk: imx8mp: don't lose the anatop device node
Date: Wed,  6 Nov 2024 09:58:03 +0100
Message-ID: <20241106090549.3684963-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the "clk" (clock-controller@30380000) device node caused the
reference to the "anatop" (clock-controller@30360000) device node to be
lost. This patch, similar to what was already done for the base address,
now distinguishes between the "anatop" device node and the "clk" device
node. This change is preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx8mp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 516dbd170c8a..b2778958a572 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -408,13 +408,13 @@ static struct clk_hw_onecell_data *clk_hw_data;
 static int imx8mp_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
+	struct device_node *np, *anatop_np;
 	void __iomem *anatop_base, *ccm_base;
 	int err;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
-	anatop_base = devm_of_iomap(dev, np, 0, NULL);
-	of_node_put(np);
+	anatop_np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
+	anatop_base = devm_of_iomap(dev, anatop_np, 0, NULL);
+	of_node_put(anatop_np);
 	if (WARN_ON(IS_ERR(anatop_base)))
 		return PTR_ERR(anatop_base);
 
-- 
2.43.0


