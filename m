Return-Path: <linux-kernel+bounces-221156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF4D90EF99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE961F234AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12914C580;
	Wed, 19 Jun 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="exqCXHaM"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF7D26A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805690; cv=none; b=LBz/57mwzVpWpNYtg6mo16/VsaAC72B0DNSqvMp17YhYFXl1HJ4nY0w1kT5DRwxIhT31ZKi2yaKLUllA+p9fTqCuXEDFqm+ItuRWwfN4rbJwvS/NB13+HkZhqxBmcShtzjVOUmKK2Hy+al8O9tra6Fdy5yG/6yzGAVFaexRelMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805690; c=relaxed/simple;
	bh=V2fOJErIc6JIhPZN2CR7Qs9bsJhQLclboXl8zVWZs88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ej3pvHg7g+GqBYbnBmiMvQrh8olRWI9ChDRaUiAW6Uyn/PStHgT6Ewv4J2CxX3qcqusE5QBkY1dW2K0hoS/QavsqruEUJfPQSOoGKjuOJEMiWjsRM8oXQKOF0caU+tAfl8tbovnV+hSzB1/x9YydCm4bXLlwcc9HMVXL8DZA4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=exqCXHaM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295eb47b48so7702198e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718805687; x=1719410487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+GCJmC76KcAMT5GOCDp0RSTcDnH5vcKBmbAZTLYEys=;
        b=exqCXHaMoLebCyNVa9+P36W1J5+gX6QMwWMvtK4Rw1B9JpbUmUPFtxnQz+wtLJOMj5
         qkH7KwbsEJj02RE1J3wK6rD5GmGQg7Hd42mA+bBS42uR4S5lShBBNVKg2nuhTBNFTWhX
         VLbmZ+nqs+7KxjQ8ca3VOZ3We3c2Lo9St84RUFq8mIpxnns+9yxTUERFF/RNjC4TzFKk
         g7NFQQASqWK2pzjboHgXRqd+R2FkB9YNvYn6rsNRO8IN6/dSPKmG9vHk7KBNTpJP8U9Y
         cLI4gf0RWm30oM0oZGLTsAkpC6e5GZ8b8Pc3rCwF391ux6zodrMmjjv6FTiVYL/zE1GL
         0NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805687; x=1719410487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+GCJmC76KcAMT5GOCDp0RSTcDnH5vcKBmbAZTLYEys=;
        b=k5HAt5BxEgmO26qkJ2brfUiybcP38t8TbQT3vX/A68Hla9WvO9f6qH1dk50sOCoaj7
         KeCDJXbPCdNr6fJzEq9rk2kSHL/sGdtkwjU44udR+TamLazJzyR4Mlxsngq+MdMXfKKj
         qrykxA+U9c6gkq5VyrWl3yglcIoRbwz15XMOUE+7jTtNtrTi3Ow5xe0verXA7ETVcoLp
         Xp5xR9wBLyCP1NENZa2nRuvzVS2paxM8a4YEPDy1mlSO86oLvFIR7notuCsA9VHEiEM2
         Po+z95cn2SaUBU9jQdp9+UmMXQ+BuJfxGa07FyuNINZp9B+XUMjhzFEeXTQw81j5NUu5
         lsgg==
X-Forwarded-Encrypted: i=1; AJvYcCVlUwDjG3cpduoyYlNaTWu/xTh5/z7OzvBmZSEgxXuUh/RMp+8SAOglmmJeu+2XFWroRbPzAQrnbHBZmIAoytRYHWGiTv8H2qsTx8EL
X-Gm-Message-State: AOJu0YwPtUOXxNiyr8DNn7I7cKPj9Q4nU7IhMMQbM4kMlgWTkSmjm9WU
	/aDs9TujXGRQYFWDmjxwzut7D78DYplza6LBOQVEGHIimOQEBDse+wHbuOH8CPE=
X-Google-Smtp-Source: AGHT+IHCqUJRZbuRk9MUMjYdIg9kfXdYDaI8MQjkROBkyKkQf0VyBxkiqb1nGKWXRxYCgsWEC4AjxA==
X-Received: by 2002:a05:6512:2309:b0:52c:9906:fa33 with SMTP id 2adb3069b0e04-52ccaa885ddmr2490422e87.43.1718805686415;
        Wed, 19 Jun 2024 07:01:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe92c6sm268520905e9.18.2024.06.19.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:01:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next] net: stmmac: unexport stmmac_pltfr_init/exit()
Date: Wed, 19 Jun 2024 16:01:19 +0200
Message-ID: <20240619140119.26777-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

These functions are only used within the compilation unit they're defined
in so there's no reason to export them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 10 ++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h |  5 -----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 54797edc9b38..ad868e8d195d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -764,8 +764,8 @@ EXPORT_SYMBOL_GPL(stmmac_get_platform_resources);
  * Description: Call the platform's init callback (if any) and propagate
  * the return value.
  */
-int stmmac_pltfr_init(struct platform_device *pdev,
-		      struct plat_stmmacenet_data *plat)
+static int stmmac_pltfr_init(struct platform_device *pdev,
+			     struct plat_stmmacenet_data *plat)
 {
 	int ret = 0;
 
@@ -774,7 +774,6 @@ int stmmac_pltfr_init(struct platform_device *pdev,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(stmmac_pltfr_init);
 
 /**
  * stmmac_pltfr_exit
@@ -782,13 +781,12 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_init);
  * @plat: driver data platform structure
  * Description: Call the platform's exit callback (if any).
  */
-void stmmac_pltfr_exit(struct platform_device *pdev,
-		       struct plat_stmmacenet_data *plat)
+static void stmmac_pltfr_exit(struct platform_device *pdev,
+			      struct plat_stmmacenet_data *plat)
 {
 	if (plat->exit)
 		plat->exit(pdev, plat->bsp_priv);
 }
-EXPORT_SYMBOL_GPL(stmmac_pltfr_exit);
 
 /**
  * stmmac_pltfr_probe
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index bb6fc7e59aed..72dc1a32e46d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -17,11 +17,6 @@ devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res);
 
-int stmmac_pltfr_init(struct platform_device *pdev,
-		      struct plat_stmmacenet_data *plat);
-void stmmac_pltfr_exit(struct platform_device *pdev,
-		       struct plat_stmmacenet_data *plat);
-
 int stmmac_pltfr_probe(struct platform_device *pdev,
 		       struct plat_stmmacenet_data *plat,
 		       struct stmmac_resources *res);
-- 
2.43.0


