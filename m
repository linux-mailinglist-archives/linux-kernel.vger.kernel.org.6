Return-Path: <linux-kernel+bounces-209974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB292903D91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117A6B266E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B6D17D884;
	Tue, 11 Jun 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VmPMlWNT"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593617CA0A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112927; cv=none; b=RcK0hQe1hI0DwcvmHv+xAvCqO8Y527bfMo9hzybh3pEtW2ZzrFBV4520IUMvEWsnZ04zfCp4GZsHnSeSpjakIKvbDyYOMKU8v3C/p1y9EuSBdTN3FHjY506/KV5VL32cm8AwEcnU7APAwQ0B8vgAyu1J2Wt7oZlX+Z8onhFcgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112927; c=relaxed/simple;
	bh=4a3scLvYXkuJsnLKn89qlgPibWnIiRsl52VCCdkhGOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuXKspKyPfibQu6EYhn7Br9UqcF9Tdmn630YKrmxu46lcSWZiyxPpgp1JgQ0rsmd4U7OlBbyGj4CKBARwIxdGFIjHqj0cAKGHq7jDxP3IJITnUE3c9j9Xup8KQFwszSvZ2id44moFjE+UbPg2ifPtHwMyrgFiNj6/NOTsaQtJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VmPMlWNT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebdfe26242so29312411fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718112922; x=1718717722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8QDeS52Z8AMlWRKMLQ8N+MaKcddL0RJGmQ+tlm1Cp0=;
        b=VmPMlWNTvkcDqEHjZvvlvmXueamzUl+JB3YGgZn1cT7xBrT6AHrcOrkClxTdlMLbf3
         QlhcAl5IIhueqqdjK20O3lePfclzKfoIRSwS963WD7Bl0DA+XGriHy3Q+o9JwoPGcHuB
         Kq52eEx1SFiapMD037JMDBe22rqkyuf3vHrSl2rpbl4W6RBcDqCaCoVOswRg8qZ3f8G8
         CyzeVozM+m0/aq3KVYN8Vs9D2ZqukGduCZJqMlmsP5v9xsmz5Jf3irdI+dJN/9tm08Yb
         NR5SL05qaBFf8MoA41EQWX0o239aDyA/lPlIR5YA75e+RHXZ3b5tpHnGAcYgNyODeI4X
         3fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112922; x=1718717722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8QDeS52Z8AMlWRKMLQ8N+MaKcddL0RJGmQ+tlm1Cp0=;
        b=QVeXUI1BfSb+1PiRwn/PxjCQQTMHVvyqhTvy3wM9VUEPqtDlB4RZUpTU+Ez2mET3iE
         /cpj4G8WRjMvQ+sadDKgTaU8PQlZrBX4ZN54x0J5EoWvizWxC+RGKQ8CsVwU1sq3PCkj
         B+vi/9E/TfXosw+Hv6tQLEAIoKmpPP9E91L9SRHeVauRxT27eOVPZN6ocnKDCht47+gM
         LX3bv77L03nSIgYLteg+rBGRIwDtSEU/ZRUKjZu/yNtThDIe8oQyZOwl9WNTLclmUwgL
         QigkCKb2OUih+AuDLYNqZVx3dvDkzSywdEkCU6RSHo2WmrixRe5nAMgdnLhRKTp7YYru
         SXlg==
X-Forwarded-Encrypted: i=1; AJvYcCWqu6dgjHhbBTwWfkLn+binLUTxKEWT2JYhpme3+4TRgVEGjAZo619uOUPMFoTTIjjIuaRVr/843fNKZlG0L0jHlSxI1YRxjhEmcTE1
X-Gm-Message-State: AOJu0YzAkNjT+IBeq25AEXMyAezlAPUatySF1rpl3XrLaLw8P+CYw4l/
	u0STfjRhYmvaeIw/32Y03ISvDDlCGvRjIesuxJuu1/0o8yCc09BU1HFftRJdDcrIeEjE4EGOWKo
	Y
X-Google-Smtp-Source: AGHT+IFYXJL8gSHUGZhhV7TvyGBajrxwHaxnUpJkWCNrjteJ0gG8Kk8wjsEIGqil2U66IxgDoS/SNA==
X-Received: by 2002:a2e:7a06:0:b0:2eb:dba0:6772 with SMTP id 38308e7fff4ca-2ebdba071a5mr53285941fa.37.1718112922031;
        Tue, 11 Jun 2024 06:35:22 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:6945:4110:d128:827])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa1desm179497315e9.11.2024.06.11.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:35:21 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH] clk: meson: add missing MODULE_DESCRIPTION() macros
Date: Tue, 11 Jun 2024 15:35:08 +0200
Message-ID: <20240611133512.341817-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add the missing MODULE_DESCRIPTION() in the Amlogic clock modules missing
it.

Reported-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Closes: https://lore.kernel.org/linux-clk/964210f1-671f-4ecc-bdb7-3cf53089c327@quicinc.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/a1-peripherals.c   | 3 ++-
 drivers/clk/meson/a1-pll.c           | 3 ++-
 drivers/clk/meson/axg-aoclk.c        | 3 ++-
 drivers/clk/meson/axg.c              | 3 ++-
 drivers/clk/meson/c3-peripherals.c   | 3 ++-
 drivers/clk/meson/c3-pll.c           | 3 ++-
 drivers/clk/meson/g12a-aoclk.c       | 3 ++-
 drivers/clk/meson/g12a.c             | 3 ++-
 drivers/clk/meson/gxbb-aoclk.c       | 2 ++
 drivers/clk/meson/gxbb.c             | 3 ++-
 drivers/clk/meson/meson-aoclk.c      | 2 ++
 drivers/clk/meson/meson-clkc-utils.c | 1 +
 drivers/clk/meson/meson-eeclk.c      | 2 ++
 drivers/clk/meson/s4-peripherals.c   | 3 ++-
 drivers/clk/meson/s4-pll.c           | 3 ++-
 15 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index 621af1e6e4b2..99b5bc450446 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -2240,8 +2240,9 @@ static struct platform_driver a1_periphs_clkc_driver = {
 		.of_match_table = a1_periphs_clkc_match_table,
 	},
 };
-
 module_platform_driver(a1_periphs_clkc_driver);
+
+MODULE_DESCRIPTION("Amlogic A1 Peripherals Clock Controller driver");
 MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
 MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index 90b0aeeb049c..a16e537d139a 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -354,8 +354,9 @@ static struct platform_driver a1_pll_clkc_driver = {
 		.of_match_table = a1_pll_clkc_match_table,
 	},
 };
-
 module_platform_driver(a1_pll_clkc_driver);
+
+MODULE_DESCRIPTION("Amlogic S4 PLL Clock Controller driver");
 MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
 MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index e4d0f46f47f5..fa1dcb7f91e4 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -338,6 +338,7 @@ static struct platform_driver axg_aoclkc_driver = {
 		.of_match_table = axg_aoclkc_match_table,
 	},
 };
-
 module_platform_driver(axg_aoclkc_driver);
+
+MODULE_DESCRIPTION("Amlogic AXG Always-ON Clock Controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 52d610110e44..065b5f198297 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -2183,6 +2183,7 @@ static struct platform_driver axg_driver = {
 		.of_match_table = clkc_match_table,
 	},
 };
-
 module_platform_driver(axg_driver);
+
+MODULE_DESCRIPTION("Amlogic AXG Main Clock Controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
index ff17abe6a999..56b33d23c317 100644
--- a/drivers/clk/meson/c3-peripherals.c
+++ b/drivers/clk/meson/c3-peripherals.c
@@ -2359,7 +2359,8 @@ static struct platform_driver c3_peripherals_driver = {
 		.of_match_table = c3_peripherals_clkc_match_table,
 	},
 };
-
 module_platform_driver(c3_peripherals_driver);
+
+MODULE_DESCRIPTION("Amlogic C3 Peripherals Clock Controller driver");
 MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
index 44b20bf4deac..6d5271c61d14 100644
--- a/drivers/clk/meson/c3-pll.c
+++ b/drivers/clk/meson/c3-pll.c
@@ -740,7 +740,8 @@ static struct platform_driver c3_pll_driver = {
 		.of_match_table = c3_pll_clkc_match_table,
 	},
 };
-
 module_platform_driver(c3_pll_driver);
+
+MODULE_DESCRIPTION("Amlogic C3 PLL Clock Controller driver");
 MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index 58976ed8b92a..a5f4d15d8396 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -473,6 +473,7 @@ static struct platform_driver g12a_aoclkc_driver = {
 		.of_match_table = g12a_aoclkc_match_table,
 	},
 };
-
 module_platform_driver(g12a_aoclkc_driver);
+
+MODULE_DESCRIPTION("Amlogic G12A Always-ON Clock Controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 56e66ecc306e..4647e84d2502 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -5612,6 +5612,7 @@ static struct platform_driver g12a_driver = {
 		.of_match_table = clkc_match_table,
 	},
 };
-
 module_platform_driver(g12a_driver);
+
+MODULE_DESCRIPTION("Amlogic G12/SM1 Main Clock Controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index dbda563729db..33fafbdf65c4 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -300,4 +300,6 @@ static struct platform_driver gxbb_aoclkc_driver = {
 	},
 };
 module_platform_driver(gxbb_aoclkc_driver);
+
+MODULE_DESCRIPTION("Amlogic GXBB Always-ON Clock Controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 29507b8c4304..d3175e4335bb 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -3567,6 +3567,7 @@ static struct platform_driver gxbb_driver = {
 		.of_match_table = clkc_match_table,
 	},
 };
-
 module_platform_driver(gxbb_driver);
+
+MODULE_DESCRIPTION("Amlogic GXBB Main Clock Controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index b8a9d59e6726..2dd064201fae 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -89,4 +89,6 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
 }
 EXPORT_SYMBOL_GPL(meson_aoclkc_probe);
+
+MODULE_DESCRIPTION("Amlogic Always-ON Clock Controller helpers");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/meson-clkc-utils.c b/drivers/clk/meson/meson-clkc-utils.c
index 7370644e8092..4dd5948b7ae4 100644
--- a/drivers/clk/meson/meson-clkc-utils.c
+++ b/drivers/clk/meson/meson-clkc-utils.c
@@ -22,4 +22,5 @@ struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_da
 }
 EXPORT_SYMBOL_GPL(meson_clk_hw_get);
 
+MODULE_DESCRIPTION("Amlogic Clock Controller Utilities");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
index 3cbc7f233bba..570992eece86 100644
--- a/drivers/clk/meson/meson-eeclk.c
+++ b/drivers/clk/meson/meson-eeclk.c
@@ -58,4 +58,6 @@ int meson_eeclkc_probe(struct platform_device *pdev)
 	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
 }
 EXPORT_SYMBOL_GPL(meson_eeclkc_probe);
+
+MODULE_DESCRIPTION("Amlogic Main Clock Controller Helpers");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 73340c7e815e..130c50554290 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -3809,7 +3809,8 @@ static struct platform_driver s4_driver = {
 		.of_match_table = clkc_match_table,
 	},
 };
-
 module_platform_driver(s4_driver);
+
+MODULE_DESCRIPTION("Amlogic S4 Peripherals Clock Controller driver");
 MODULE_AUTHOR("Yu Tu <yu.tu@amlogic.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index 707c107a5291..c2afade24f9f 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -868,7 +868,8 @@ static struct platform_driver s4_driver = {
 		.of_match_table = clkc_match_table,
 	},
 };
-
 module_platform_driver(s4_driver);
+
+MODULE_DESCRIPTION("Amlogic S4 PLL Clock Controller driver");
 MODULE_AUTHOR("Yu Tu <yu.tu@amlogic.com>");
 MODULE_LICENSE("GPL");
-- 
2.43.0


