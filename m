Return-Path: <linux-kernel+bounces-243926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCD929C83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AF11C210EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE01B974;
	Mon,  8 Jul 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GM4Y2HZW"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8814267
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421547; cv=none; b=GKAnVCOjjuRxRQCeT7D8qpXxE3xzX+gAEtY9xFUHkfcnUqNd85Hs15+HpY+fByATRPFia37SRD+LBMkPu7HvcA3t7emNa3K+jp3lB0UYF53efqrxYo3VaHhNxhKbgZ1scLawMjuhRjqgSKzPDW5oFyMBb1gyyTK02un+nfVMdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421547; c=relaxed/simple;
	bh=XGAUAZ2tJFn06FQspuaDvlm800OeXNZrlzDbL5cCwhA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mXaMJZk3x7dOFLovjGRQhl+/CNVHrp0RB0NXSKze9kre+HOygjjK39abDv0W2bGHewv5yxSaedfTipdwYdlTcbNTVOQTZfPJV1MFdNGDBQzfBh5R4aDJWJPHAkFnBoB2H4JkccigWtQtKZHN861tvhpXTCGZetcHZH58B124Onk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GM4Y2HZW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8695540C83
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720421536;
	bh=HbzMAQQs0beQFPhhkJhPUz49qUwPsn+ZS8RIbID3OKs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GM4Y2HZW8SHC3Vm6rGPVn+HMAnkgWBk2iBeNy/xmVEfJEgrwDDIKX729NbkMzyWXy
	 ZeisYI6Q08bXwH6oANqYaExVXpMfnlHY9onZJXqsuOkcGji1DrvAuUt11bUEvdoQF4
	 YRoIJnzyYLhtaIc9dYzb5p/kTgyxgIf0JfTixGCScUUxT4t5JziicxhFENuoZuCFLa
	 8/QevvnQ6fvLyIpHsym8e1snbZg91S0ZYfanx/xHo8SSJWt7VDMDlFY2DsHCIvq68j
	 fxbL2XLt152SqyKd1tNqal8tWaCoc7oDknc4QC942+i00ZzgXlGsWWlL7gM5mbbK9r
	 fxFrE3WbiAmaw==
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7035ae4e205so2291730a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421535; x=1721026335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbzMAQQs0beQFPhhkJhPUz49qUwPsn+ZS8RIbID3OKs=;
        b=nHcNWn5t7GSjp0yX2hKY08JUg1bLUq9bIkbULwyp3KeAKEXJy8eZO32IByLU2+sU9h
         QNuo/u7ZCy2lFEFmOsWj9HRuHmGE/rCK4BKmajjd0srq0Zkish+As5Ssbe65hcGk1cZT
         6EiisOU9fxN9bmjSjUQSY798Wwr8+6thQG6KyGRpze4j3I1z/AzqAJKx6Y5Ao4aA5L/p
         3V/E+l+dpJlzpefJ79gJYoyyxwQ7g0+P9dqE3O5Me4VOGbjCEyzrjRqJ12hZsHBS00RS
         k01+jSljKhvQD+XxC8I8woQ9uv5b+kDer6xcoWbik3e6Pes3T1IYYwM3PpP69ki8XnEp
         KfFg==
X-Forwarded-Encrypted: i=1; AJvYcCUatm+GKUICjJa0dKQev8wS5IsW4gHSpD8sBXAl2cd/Pc5MwiL7QMXncwM4lITNaQ8QikCSVL0yL8vSl9yRDyGZAfXi/LrzWWw3z4je
X-Gm-Message-State: AOJu0Yxwg7cQ9eTrwU6XUMlnoBXclhVHk9GMgoNkDBQDkOIriYdr8Ff4
	E8u2Iu2NOiSM+UwYBs3Lzn/MKCqieGjlbICqEhhOKKllP970+SlW9X2huyHPL8//zY+xSNkeaHm
	nKZ2myLMgbikMU1Sp8NiSW7o66g6Z6Y1ZntPUAAxz6GUNjAQdBGNldy4oksHeP/gNSHgszGrAPD
	vW8A==
X-Received: by 2002:a05:6830:4121:b0:703:5be9:7eb2 with SMTP id 46e09a7af769-7035be97fb1mr10205063a34.1.1720421535288;
        Sun, 07 Jul 2024 23:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDdcN3FhbXbJhL25LGgTT9SMrkYrFZRj+Qr84KVRq4ZsIxJ4/dnZO5KZecMBqaC8bwrBJVHA==
X-Received: by 2002:a05:6830:4121:b0:703:5be9:7eb2 with SMTP id 46e09a7af769-7035be97fb1mr10205048a34.1.1720421534961;
        Sun, 07 Jul 2024 23:52:14 -0700 (PDT)
Received: from solution.. (125-228-254-191.hinet-ip.hinet.net. [125.228.254.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15e0cefcsm4484195b3a.166.2024.07.07.23.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:52:14 -0700 (PDT)
From: Jian Hui Lee <jianhui.lee@canonical.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 net] net: ethernet: mtk-star-emac: set mac_managed_pm when probing
Date: Mon,  8 Jul 2024 14:52:09 +0800
Message-ID: <20240708065210.4178980-1-jianhui.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The below commit introduced a warning message when phy state is not in
the states: PHY_HALTED, PHY_READY, and PHY_UP.
commit 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")

mtk-star-emac doesn't need mdiobus suspend/resume. To fix the warning
message during resume, indicate the phy resume/suspend is managed by the
mac when probing.

Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
Signed-off-by: Jian Hui Lee <jianhui.lee@canonical.com>
---
v2: apply reverse x-mas tree order declaration

v1: https://lore.kernel.org/netdev/20240703061840.3137496-1-jianhui.lee@canonical.com/

 drivers/net/ethernet/mediatek/mtk_star_emac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 31aebeb2e285..25989c79c92e 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1524,6 +1524,7 @@ static int mtk_star_probe(struct platform_device *pdev)
 {
 	struct device_node *of_node;
 	struct mtk_star_priv *priv;
+	struct phy_device *phydev;
 	struct net_device *ndev;
 	struct device *dev;
 	void __iomem *base;
@@ -1649,6 +1650,12 @@ static int mtk_star_probe(struct platform_device *pdev)
 	netif_napi_add(ndev, &priv->rx_napi, mtk_star_rx_poll);
 	netif_napi_add_tx(ndev, &priv->tx_napi, mtk_star_tx_poll);
 
+	phydev = of_phy_find_device(priv->phy_node);
+	if (phydev) {
+		phydev->mac_managed_pm = true;
+		put_device(&phydev->mdio.dev);
+	}
+
 	return devm_register_netdev(dev, ndev);
 }
 
-- 
2.43.0


