Return-Path: <linux-kernel+bounces-221627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7A90F66A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE7A1F23BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9F915B578;
	Wed, 19 Jun 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="d36WjO41"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57B15A84D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822772; cv=none; b=dh5BUQSBCsDG9/Jpgmjyk+6EN1ihCB8rSkvytChMQLqiNs5ACcjfRjTCHAQLtzAtSkABKFXf427uw6Q3Lk/cVAeRZ1STH4pTaa2y85QXu+zIjCkaZ2tBKVIyCCHJMaj/2VaxK9IUDt4Iq6O+QHvZSjS60dLU3uEhpqxxWGiHosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822772; c=relaxed/simple;
	bh=U9n10pz1cTilOrioSLcCAr+HHxqK2c88JZBv18C3XGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3qBqVhP82iS95CyDnzujGRjWzaLc0bjKVRrhG67ZQkV3zvn98DZ7QWaBP6Fu4AgT/6cEmqzdVU9TRNm/OEAt5JRsSRvC7MjI9L6Vy//2h+GY/WMSJGchFLpvk5CS7k3thD5P8QCJZrB5xIW/PJgjrZpPnxYBt1dj4JLFcHcElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=d36WjO41; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e724bc466fso626951fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718822768; x=1719427568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuxLK+Kt4TA0IWlhERRNrzNbAxkSoJre0Y5sVJZCXq0=;
        b=d36WjO41GWIfGPKpslb2Mvn4pkYRYwQb/s2L90KmixpMwAw/d9v8ZESx4LsQphPLdi
         0nXiPokKLiDi0827E5IS1VyDYqEwJL09FHX0oUPVDkJF7AWyfJqf4o8d+7LR4PDp4xar
         LkGhLXMUSD0+v4ECPrgwVLjTv27ExaoWRec+USlQmWBz1zQN1uuP91L81XlZBtlVKw1v
         s1KLB4bNxx8lhaDtrbL/dik4TQc0smEnoj6pFomazYcq6LoolhxrS2cwGDf54LgcjQIS
         QRrDmOWcS4KEyiLsGdCf+xwKxrpGQ3E6aUF4UV+UtOGUkSle/TCGk/5qLsv6V8+451VR
         Omng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822768; x=1719427568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuxLK+Kt4TA0IWlhERRNrzNbAxkSoJre0Y5sVJZCXq0=;
        b=wA3/zYe37mf+INniyZ8qN0alsL9gFcLKibk4kCy+5nMnDQVg1U+Li7chXFdbPf/Oet
         yuMpBVFcEZLaaHJEiy/93lmw6nitoLaUa+mV4CDP+2WUQebkZuM1mzkct7GBe/H+UE9v
         8v1drVhqLc75helBN6g65PfaW4g2ZrmiTXoshvKMUuQO4bvIiV/iLPbEapV8hv8Kjt4h
         MzUkrgBtMGivqpkQt0JDdy8VdYiD8I0eUN9ZH55OKIYojjsSIEQmrGSTrCVqIlRwNrhA
         ld35hLt9eW8QUYy3PAkaDM23v75ZnNde5/yrD5wnavYbGmZCwQJcmY19tdn7+ttpb+1J
         atuA==
X-Forwarded-Encrypted: i=1; AJvYcCVwXo64E5PrA+s+fgZ1Fm2BM2IYPiI4go54WPupQvh8Nl1J2U3/pjTw3nOKC3OabXFTHGFnVn/TVPfScyzfz0b4AI31oeRP7DenBoLd
X-Gm-Message-State: AOJu0Ywrc9g1Ox6xWE7MmpoUXjRTs2W+Ex2Bw71BIwcprmVp3Vj3W2ZP
	mny4XD8IoStjBTJv+jaehw9HQPLVgZY+X/sUUnHB3pFcr2oTOx+/zNI1HdZnTck=
X-Google-Smtp-Source: AGHT+IE2yoi8eN59Efp4Zw4hc/t75lfTyLZp0Zgl91poYr5lN48FBw2FLHnhRe8TwdlAiWGWq9mpew==
X-Received: by 2002:a2e:9d05:0:b0:2ec:efb:8b66 with SMTP id 38308e7fff4ca-2ec3cfe12acmr21926691fa.53.1718822768357;
        Wed, 19 Jun 2024 11:46:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36098c8c596sm7594156f8f.14.2024.06.19.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:46:08 -0700 (PDT)
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
Subject: [PATCH net-next 6/8] net: stmmac: provide the link_up() callback
Date: Wed, 19 Jun 2024 20:45:47 +0200
Message-ID: <20240619184550.34524-7-brgl@bgdev.pl>
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

Provide drivers with means to react to link-up events in the form of
another platform callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 include/linux/stmmac.h                            | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5ddbb0d44373..644bc8a24661 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1006,6 +1006,9 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 	u32 old_ctrl, ctrl;
 
+	if (priv->plat->link_up)
+		priv->plat->link_up(priv->dev, priv->plat->bsp_priv);
+
 	if ((priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
 	    priv->plat->serdes_powerup)
 		priv->plat->serdes_powerup(priv->dev, priv->plat->bsp_priv);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 9c54f82901a1..9dc54d6d65ae 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -271,6 +271,7 @@ struct plat_stmmacenet_data {
 	void (*dump_debug_regs)(void *priv);
 	int (*pcs_init)(struct stmmac_priv *priv);
 	void (*pcs_exit)(struct stmmac_priv *priv);
+	void (*link_up)(struct net_device *ndev, void *priv);
 	struct phylink_pcs *(*select_pcs)(struct stmmac_priv *priv,
 					  phy_interface_t interface);
 	void *bsp_priv;
-- 
2.43.0


