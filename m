Return-Path: <linux-kernel+bounces-318437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C998E96EDDB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882BF285065
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808CE158DC3;
	Fri,  6 Sep 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LrwR39eW"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD4158548;
	Fri,  6 Sep 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611123; cv=none; b=mSEB2wtDw6hnlTGru0XG8iaLLS3fb6qlDhI2bXFYeXaFh23Bp708G3jAJr4XAGEY9tv1Cp+78Mycafg7MBjQh28xSZVPTMokdLBxLNTG2VfAh/TtnGy1UwHqUUokIHFmmlaU/4AsgicLV3uscfGQPPgNJcLwbpT6uzgShZ5zuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611123; c=relaxed/simple;
	bh=O8N26FIu+js1B7eU91uGZOCbPHACJf17XHhbShcXMoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTvYwSSMJcjxTnWa8FYztcVZZMiEEGsKoJmpNZ7hB/9wHBaBttKbK4O6oBpuAekaxi1k9MWnUocTODOjnluNioM4BeoeI5MiT4DDZCkqogkCv8Nvklr548Ufg9fSkGKxb4ui13cxoabj1ysCqXsw+zNAXKVDbRwXYRz/RdjLqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LrwR39eW; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TqxynQHVtMcMYcTlZ9c4J6WTyfOvhuPEE/JTjaFof8c=; b=LrwR39eWNErCClWorqwywiKGQ/
	1GEu1mZ94vd80Hw7neS0f8eUCbl3DgBfeBqcdxTnKpTKQL28GB1vF5QWgDCqewuxA3KsR5Wxl0Izk
	my12JGWFhQqsVU+SDODqWcMVUOPVL13eMDsqWdbQVK7Pcs/hOBYThYJBme8dzGX6slp767eMHngMk
	Szz2KFavkd9JuLMHV4di7wPMs91JjUjr1Eu1nfgMtYFls1jGqRN9ygN7zkdPSrJZv8YQ4p6K8FTFz
	SutLlTk9IhKQxaGvV6ZrVhCXm4mot1uNguWCU/SLCZB2F/YGiqUyHfRbsxMAWHaRVnc/Ldyh7IzWP
	TPcCTkAw==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1smUHP-0000jF-R6; Fri, 06 Sep 2024 10:25:19 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v4 3/5] clk: clk-gpio: use dev_err_probe for gpio-get failure
Date: Fri,  6 Sep 2024 10:25:09 +0200
Message-ID: <20240906082511.2963890-4-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906082511.2963890-1-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a real driver and dev_err_probe will hide the distinction between
EPROBE_DEFER and other errors automatically, so there is no need to
open-code this.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-gpio.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 98415782f9a2..cda362a2eca0 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -200,7 +200,6 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 	struct gpio_desc *gpiod;
 	struct clk_hw *hw;
 	bool is_mux;
-	int ret;
 
 	is_mux = of_device_is_compatible(node, "gpio-mux-clock");
 
@@ -212,17 +211,9 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 
 	gpio_name = is_mux ? "select" : "enable";
 	gpiod = devm_gpiod_get(dev, gpio_name, GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod)) {
-		ret = PTR_ERR(gpiod);
-		if (ret == -EPROBE_DEFER)
-			pr_debug("%pOFn: %s: GPIOs not yet available, retry later\n",
-					node, __func__);
-		else
-			pr_err("%pOFn: %s: Can't get '%s' named GPIO property\n",
-					node, __func__,
-					gpio_name);
-		return ret;
-	}
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod),
+				     "Can't get '%s' named GPIO property\n", gpio_name);
 
 	if (is_mux)
 		hw = clk_hw_register_gpio_mux(dev, gpiod);
-- 
2.43.0


