Return-Path: <linux-kernel+bounces-437379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0069E9278
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249AB16611D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E54224893;
	Mon,  9 Dec 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="gMaZzWO2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713721B917
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743936; cv=none; b=AsH0fzXpwkvRyfQOf//dDvo0dfKskbevJIagc+SFErNu/+Jnzw9OejOvIaESMMK59SslhD/A5AJGbCLDMP67jIK1b9g8dRSe1F/XAypqhMh4ft0Pr7KGWRBLt/tZgSPkKw/yWLGuJ5ch9P65gDutSIjzbgiWsGdXvWL+SBy2Jqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743936; c=relaxed/simple;
	bh=Tu7rGfrztaY/ub/VjfWkpCJVdvvgr4H85wEOTNfmqtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLLlQRN/l3RruABYE3TZ6SPfbQYz30PxsOZL7DvtaH9AiSUy/0IvDR2D8ZuKTHpFkMOyY4dtXWshl5fB2oUG0w8F9cxftdWT6MrkoK1uEgZjCIkN/nLB5KQCmHYNQB9Lx8wcrkksaXCYL3g8h7/kcXOREUY2uDkcBcpkIUdeJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=gMaZzWO2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5401c52000fso985903e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733743932; x=1734348732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjnBnZnhKiLLFfTJHr6XA6kr43m++51Ex2ty4jwE+CI=;
        b=gMaZzWO2vA5uyQahZszLCnzYk2llTsRKUWaWaoSgKF01Y4x5X/jwFgP3cpmmLG5BSO
         mDPDRhQcH9VUMnY4pmmM+S42THz2QfWkq3+z+5SIqH/Xcn2qVgpAPGFsGlXmy4Ism8gz
         QN2jxJ9V65TqDzk9TA6Ik00HhDlMIAOabobDgBfOxCqI10o7RV8lbGs3Q4hrNjtLTVh0
         xgOqZcXSDYkTcnEL8+oxngmajM9VE48Mr3hrlB9bQETf17mnVMDyRbgCdzxHo4dE/Ffx
         su4xqZEEjd8U+fQNcbIO+8zEHVZ/hskNZkTFpfRbN1iNhS8Rx99LUdPJ6GHKPy0U7XXe
         8D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743932; x=1734348732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjnBnZnhKiLLFfTJHr6XA6kr43m++51Ex2ty4jwE+CI=;
        b=kMpZZ8/AjIp4jDs1+tJedUEK0A8baplnWKLpSSkK4cedqf/LO74EB9XDsMq5PzTNXM
         5G+IJfIJ4qo0zP0zMjQVXC/U+RttksL22cDQrHMb2tgTqGzxlkPJgK66NSZaXcoqN8E+
         PvOIaX48j6z//sje2Xu21s85a+xCa+GH8yIFMY1ToXz63JbtRJDNSOh6E4lETIT8KjCV
         oZSKRZykLaLaCPyoJhqHx0Nh5ib3uMldw0GJPUkEUaSwAuVETmTCZmYkiY6RQAmJ0rdV
         RhpqkbnNK/1eRHxDvQOSdo69OEYRKVGLQnYitNtGMDJLJg6tv2uuoaBCNr0q8CsOE5Dz
         os0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+0ln/si2TJkpk64eL1r9rIsDC5V+S2gOuARHv41TGNXhemIdxRwziVO5+u8j+O9a3cmlPrB8vaj8X3jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9p+QPWrhQvrvbLNwbzEpe79bvBocLAdflhYwD/DYet/MZL/U
	YDQe/7ddBApNqIdVyCiGpnbCdgVR2NXiLFwW+Ddzcku5NPXcDxB8BWy4UsAhyZM=
X-Gm-Gg: ASbGncvnJUllRWXKJnhTOPG+p1pxMCTcT0HLycku5wMEUUDfZbsT6/QnM/+R3rFj4pb
	lX4JNLsjYIDbIc0PF1tv/lpankccBq6i8CblQmp1kJiSNijYQGbZ19y9zwmme5eDZgtciJbWaTi
	2U3NWHhNf9C6Vu0pvoAE7CEr23VPK+zOII6McjMDwJFGa4BPNx8Fwp53Uhd9ifbZBEww5phGy+M
	wh+jrST34WocmzfhiYXWdEe4ThclTWmBWmnjPxU7Culx+8sl8rztfC7yZGCQxHF
X-Google-Smtp-Source: AGHT+IEfD3Ubb6mME+Sci7bt7F6v/i4zSfonRA4bvFaR9n6ubOA1IjNY2tNGE/VeTd5trSFqDwDIAQ==
X-Received: by 2002:a05:6512:39ca:b0:540:1e74:5a15 with SMTP id 2adb3069b0e04-5402410d22dmr45349e87.54.1733743932343;
        Mon, 09 Dec 2024 03:32:12 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401f8365d7sm286196e87.138.2024.12.09.03.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:32:11 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net] net: renesas: rswitch: handle stop vs interrupt race
Date: Mon,  9 Dec 2024 16:32:04 +0500
Message-Id: <20241209113204.175015-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the stop routine of rswitch driver does not immediately
prevent hardware from continuing to update descriptors and requesting
interrupts.

It can happen that when rswitch_stop() executes the masking of
interrupts from the queues of the port being closed, napi poll for
that port is already scheduled or running on a different CPU. When
execution of this napi poll completes, it will unmask the interrupts.
And unmasked interrupt can fire after rswitch_stop() returns from
napi_disable() call. Then, the handler won't mask it, because
napi_schedule_prep() will return false, and interrupt storm will
happen.

This can't be fixed by making rswitch_stop() call napi_disable() before
masking interrupts. In this case, the interrupt storm will happen if
interrupt fires between napi_disable() and masking.

Fix this by checking for priv->opened_ports bit when unmasking
interrupts after napi poll. For that to be consistent, move
priv->opened_ports changes into spinlock-protected areas, and reorder
other operations in rswitch_open() and rswitch_stop() accordingly.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 33 ++++++++++++++------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 6ca5f72193eb..a33f74e1c447 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -918,8 +918,10 @@ static int rswitch_poll(struct napi_struct *napi, int budget)
 
 	if (napi_complete_done(napi, budget - quota)) {
 		spin_lock_irqsave(&priv->lock, flags);
-		rswitch_enadis_data_irq(priv, rdev->tx_queue->index, true);
-		rswitch_enadis_data_irq(priv, rdev->rx_queue->index, true);
+		if (test_bit(rdev->port, priv->opened_ports)) {
+			rswitch_enadis_data_irq(priv, rdev->tx_queue->index, true);
+			rswitch_enadis_data_irq(priv, rdev->rx_queue->index, true);
+		}
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
@@ -1582,20 +1584,20 @@ static int rswitch_open(struct net_device *ndev)
 	struct rswitch_device *rdev = netdev_priv(ndev);
 	unsigned long flags;
 
-	phy_start(ndev->phydev);
+	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
+		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDIE);
 
 	napi_enable(&rdev->napi);
-	netif_start_queue(ndev);
 
 	spin_lock_irqsave(&rdev->priv->lock, flags);
+	bitmap_set(rdev->priv->opened_ports, rdev->port, 1);
 	rswitch_enadis_data_irq(rdev->priv, rdev->tx_queue->index, true);
 	rswitch_enadis_data_irq(rdev->priv, rdev->rx_queue->index, true);
 	spin_unlock_irqrestore(&rdev->priv->lock, flags);
 
-	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
-		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDIE);
+	phy_start(ndev->phydev);
 
-	bitmap_set(rdev->priv->opened_ports, rdev->port, 1);
+	netif_start_queue(ndev);
 
 	return 0;
 };
@@ -1607,7 +1609,16 @@ static int rswitch_stop(struct net_device *ndev)
 	unsigned long flags;
 
 	netif_tx_stop_all_queues(ndev);
+
+	phy_stop(ndev->phydev);
+
+	spin_lock_irqsave(&rdev->priv->lock, flags);
+	rswitch_enadis_data_irq(rdev->priv, rdev->tx_queue->index, false);
+	rswitch_enadis_data_irq(rdev->priv, rdev->rx_queue->index, false);
 	bitmap_clear(rdev->priv->opened_ports, rdev->port, 1);
+	spin_unlock_irqrestore(&rdev->priv->lock, flags);
+
+	napi_disable(&rdev->napi);
 
 	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
 		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDID);
@@ -1620,14 +1631,6 @@ static int rswitch_stop(struct net_device *ndev)
 		kfree(ts_info);
 	}
 
-	spin_lock_irqsave(&rdev->priv->lock, flags);
-	rswitch_enadis_data_irq(rdev->priv, rdev->tx_queue->index, false);
-	rswitch_enadis_data_irq(rdev->priv, rdev->rx_queue->index, false);
-	spin_unlock_irqrestore(&rdev->priv->lock, flags);
-
-	phy_stop(ndev->phydev);
-	napi_disable(&rdev->napi);
-
 	return 0;
 };
 
-- 
2.39.5


