Return-Path: <linux-kernel+bounces-221628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17C90F66B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC51C244CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9715B988;
	Wed, 19 Jun 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YmaJGgaG"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8A15B111
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822772; cv=none; b=WhbwuztN0lTvKA+mKfpCflyBDqkgK77WT/YSN8X8KK135LlKy88TD1rtK9KkWk/1scmDIbaQrelbOhOMscToaBaqHL0BFyu2+yxaPN8XpN1BNtibp5lzldT4jxbmCc5PVJG4sfB+iX0TMYLo8Nr4J1QsA//hPH6D4t9ebxuZO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822772; c=relaxed/simple;
	bh=7OGbLgVO2+0kFwF5zKOoOkaXLuP+flIZCfQXgfpZrfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4xKYU/G0Qb67xUc8GsrJ8x/6HEJm2V61jLOyaJBumSoxq8xDNL7RZvMB5cYwy2xGXQRk3xsojpsjab/4/08TAEZ6XD5p/av4E3KiFXaOCXkMHyIHZVgOxQJsgMIom4PgBOwO4D+7k8jnOb9zcp3TgpgwZzpmIIyF8AR4qNVs+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YmaJGgaG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so77192f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718822769; x=1719427569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQB6Cx2g3Hd80tsoqIkz/xMhmvkJf1bvi8aoKUzsHuk=;
        b=YmaJGgaGxMj2rsPghWPabrVOBmPVBiskBEpcGL5OI6+7QU1PHRG/DeyjMvNSsJxA8o
         ebbU57Mk3t937Gh9AqMNnoe2w16WklHeToOUWheCZD2d6YO4/LhEafSaa4sOu011SeGO
         HXtRvId6js2V23RY4rFlLmVISKYI4JvM1eCSaTl6BVwfHe7lG+FgOnan1LIuQfuuCil3
         rQdTj19QAieX3z0mjvwTy8isweC+11/s3Gq7PXw8IvNVRD/3tN5QEjc3H8+fclqoaMKt
         y81gOsdq4vGQNpNMMIYBAtLZQat27Ou0STQQcE0PMZrt28cBxAX9PW8bKFC29jKRn+tp
         YKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822769; x=1719427569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQB6Cx2g3Hd80tsoqIkz/xMhmvkJf1bvi8aoKUzsHuk=;
        b=cy50/pHxwA5ArEJXpJD6YDu9zpbhr8aF7PVjHhSOtSFUWeeU2TIfTUG5/aO0xNHx1S
         28SB6ga5hAa8AaYjSE7q8FjxvvuoYMeSP1Juf++DkLBvzq/zUg3sVVFSTTQ3ldFn8sm7
         LRfrYOmz6O8Xgm9mGH7FJk7IHOIVS/Tv2p5tU3jrEYqcmbNNF8gL3lW02hwCAe6enCvq
         SRFQ7cp1V78o/W1GAUACdkLZc88l5pD96CoRFqtMEZEA/DNJnVbJjMgdt5T43UDV813Z
         BJiP8c3vgquE2CBSnBruEjNO16zpKLaTEIis7Ha5IMwhJ/srvh3EH2dcRSG8aQtbqxbO
         nLZw==
X-Forwarded-Encrypted: i=1; AJvYcCV7V37sa+r+ZzSstRY3dDTgprF+Y21rJGZ0QbwuxFNv+VEe4wuK3jxuP+jZnZPFDTv70XNjCjnoQZ6IuJo4ZQ74ZITleNudCDEtnhhi
X-Gm-Message-State: AOJu0YyW81+t/inB6ounx6v4t9eAemHWCX2zPzCNsLyFHkI+AuJj+gNs
	E7BbkJzMKtQZail+y8eZ2Xbb7h7U+lO27VZypmKydF4HyjshsAZ6ylgi51hQV/87W8u48t7LXs3
	w
X-Google-Smtp-Source: AGHT+IFc10tmtmw3xb52p2cInNEHf/dEPq+PJZ9vw9EtMnLBEOS8Dh29bqwtYNyT87EfbHfTnNwe9A==
X-Received: by 2002:a5d:4902:0:b0:35f:2002:3033 with SMTP id ffacd0b85a97d-36317d75626mr2704226f8f.37.1718822769540;
        Wed, 19 Jun 2024 11:46:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36098c8c596sm7594156f8f.14.2024.06.19.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:46:09 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 7/8] net: stmmac: provide the open() callback
Date: Wed, 19 Jun 2024 20:45:48 +0200
Message-ID: <20240619184550.34524-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619184550.34524-1-brgl@bgdev.pl>
References: <20240619184550.34524-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide drivers with means of injecting additional code into the
stmmac_open() function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 include/linux/stmmac.h                            | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 644bc8a24661..5f628176d994 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3953,6 +3953,9 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (priv->plat->open)
+		priv->plat->open(dev, priv->plat->bsp_priv);
+
 	if ((!priv->hw->xpcs ||
 	     xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73)) {
 		ret = stmmac_init_phy(dev);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 9dc54d6d65ae..59991b38cadb 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -262,6 +262,7 @@ struct plat_stmmacenet_data {
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
 	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
+	void (*open)(struct net_device *ndev, void *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
 	struct mac_device_info *(*setup)(void *priv);
-- 
2.43.0


