Return-Path: <linux-kernel+bounces-238934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE1925390
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8628465B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85429130A68;
	Wed,  3 Jul 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DCiz2Qrr"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929D4501E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987536; cv=none; b=VmsxIjmwLMmY1aDFmTZChywW0LG5d4IOsaLEFE5YJkTrR9m8qmJf4cnHcMvFlbHFlrp1iwVsoMkAynfJ31Ck533EXLA8CuHRKKTsRDTFmla7Yw/vYLUyvfkTKMGsAJdEwOPXKv+To/zGbNG9C/FIcYSj9yrJBpe8b8rUcTt4VTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987536; c=relaxed/simple;
	bh=61VB0U1/4ibLbcElNxUWDU9uLD1kPVwe53Y9CP56XCs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hADSc4Xq6TKu3Zz8dYSNtIyUubRJo1Zd1+GZk+UX0GehMAiBHhPlf0FNY9XJjwXOGDbvuy1nnhi+Imf60pmYWLbVbt4rxpSGQmQLKqi4NYQinvyyu9iPZ8gDq6SfWGkaUfuBdATadqEEwjuU0TlPVcNaubguwieAc+nTvWgHxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DCiz2Qrr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 817D93F215
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719987528;
	bh=U6QOa4p5DGjIW7VT0FAxsBUw54TL3D22ZXc+mN72UUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DCiz2QrryBqhpqOrWh7z7BD0yAbYE5dpTEewgAefp3+LAYX6nBkT29sh5jFKe20s0
	 XsQTMezvtA3Sasx430tUZOBynuWydwxsks78YTNilncKmRsd29ARwo9c5uXyvkRmsy
	 Sor0o8mM4y8zd0Q3z5D0dt9ozcHwgnnzZLWNoblUKooAulTnN2r46tg9a6Xj7WEa8i
	 jr3XM57PtRAtF2QAz1/rY0rriPxaQ3MyZFcBo1cXZdcYKYwyAst7XvQPflKV4RchND
	 3DxabVYYeYTDedqBye1srDRWOfXuHEsnMpXy5yTzpLPEuBPEKvzWpyjd8+BEFDVIZE
	 rISup4QBbKI1A==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7068f155058so4688072b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987526; x=1720592326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6QOa4p5DGjIW7VT0FAxsBUw54TL3D22ZXc+mN72UUw=;
        b=S8ucBX/UZPbHxXMJYmhZOaa1yULXcHej7j/YRZTrO7R2cH8Lz4BlKLYyoUTgAX/E+q
         DvSWxiiNcYIn/WtgCVmUHVSyvKXIPVaos8lPlkTuB8geIJik2/o5ZwnMMl9RqN6uYrb5
         KmRUt6eHd1wkhiSS4VFMv7nfuSSClenq7C1TxqkXRCD1luK/UmFpziq4QfnknF5xHcJ4
         Fptr+kb/MPdQsDFyWEeb+elbDm8zJWakDSlJMpd+CG5HhFXUa+oXrmc+bZZhdrfV8/tU
         QAslgpW8cy/0CRxAZU3Pd3rR56CK6BvwIgkbh2WG0XqVp0FIAL9+RY05rWpRi+NEk8jh
         fELw==
X-Forwarded-Encrypted: i=1; AJvYcCWWKQVKDrXS3swdiEZKuxQJYpKe4NKZ5T30+2SVI11UpzH3lwEURXR7vhFPw/pg0h3Vf04Ufu5Rqw+42RHq57ISl/KK1EVjoPpPjqNu
X-Gm-Message-State: AOJu0YypdkeC/RsExMPamhau8o72PSTDmE8cq1AymiQN0YqGoGyFUPAO
	pe3AEdmzsiaR71PZ+HAIMR/BHsxh5cWLWytvYe2LtMmhyHgzRGj2hpaKJovd3tIiS153ZddA2QE
	kpHMGUh7orlknrqcOVjJs1bmlsPys4lunA2Fi0woWHrHcoO5DXkGviwt2dC8VIrYoV+yMkaPw4Q
	3XLw==
X-Received: by 2002:a05:6a00:179e:b0:706:8e4:56a1 with SMTP id d2e1a72fcca58-70aaad608b0mr14664496b3a.18.1719987526088;
        Tue, 02 Jul 2024 23:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQC6QeXQUsDBKRVwGsKjexDIZNaCLw402fvTZemCMLNU+hjyxfH1ynCl3eSRp1HOz8hh3wqQ==
X-Received: by 2002:a05:6a00:179e:b0:706:8e4:56a1 with SMTP id d2e1a72fcca58-70aaad608b0mr14664465b3a.18.1719987525589;
        Tue, 02 Jul 2024 23:18:45 -0700 (PDT)
Received: from solution.. (125-228-254-191.hinet-ip.hinet.net. [125.228.254.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205ebbcsm9581936b3a.40.2024.07.02.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:18:45 -0700 (PDT)
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
Subject: [RESEND PATCH net] net: ethernet: mtk-star-emac: set mac_managed_pm when probing
Date: Wed,  3 Jul 2024 14:18:40 +0800
Message-ID: <20240703061840.3137496-1-jianhui.lee@canonical.com>
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
resending to add the mailing list recipient

 drivers/net/ethernet/mediatek/mtk_star_emac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 31aebeb2e285..79f8a8b72c27 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1525,6 +1525,7 @@ static int mtk_star_probe(struct platform_device *pdev)
 	struct device_node *of_node;
 	struct mtk_star_priv *priv;
 	struct net_device *ndev;
+	struct phy_device *phydev;
 	struct device *dev;
 	void __iomem *base;
 	int ret, i;
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


