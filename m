Return-Path: <linux-kernel+bounces-263705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982DA93D980
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98351C23749
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792115535A;
	Fri, 26 Jul 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lz5sOQO9"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E0153812
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024012; cv=none; b=MB9SGRBPqCChWm5yPKKZkHzFqE9HEe684x2nyh583/W3hVjpHgq09jXZ9cMtHOj7TqHIOapOOQCpzlBZx4YDth0DXcxGjc+5gTx7ojgqqZlZtUvia059w/wlsmrj5bEQXopwau2YjkRn4V/lC23ttURoinCcVzlR30NEiFjtJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024012; c=relaxed/simple;
	bh=PqLeQmAqctIEHugxsI29m+1Hl3ds83kYxxQINp0RkQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbtzQuUKCB5c86kpTOn59FjatZkZ7EKZkbWy3OlspBbq776I3ifaRlf7rXGZ+1HAU2dm0SvlhsiJzNq8ES8zUf8xineKot2tgYBvsB87PXpkvhfseb5fmikOE0NSLgJMLZagbU6KP8i+f1cT4oqnEJXFUmdm6K1fbh4KaqxVBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lz5sOQO9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so2581862a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024009; x=1722628809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAD0QrgAhMaN+Loo56/InWrP52EhZGGkh8jgEKYZ7JE=;
        b=lz5sOQO9FnX+k5p+LKcHqWXL5IYMPYuBBD6uBS5Ib3dS1vBt04gBPJ7/lfOXl4sZBe
         1EkHWpU5sDg24xifWfon3ziO9KH8czZeav8gOZ7CcAYOnTmF0DY+okwRwVjLOkC03Dok
         WpSe1sE848qkJsJ5qDkCWJ2f6g2HqLxpCGNLpuMIJhynCav23SPxVd4lOhvFGcAytdtd
         ab/VQoSX5AunENzwUI3oLQqEe8ZssLv3DozW29aLmnZ1D/QVDbvhAcVriSdET0b6kUQZ
         DdFhsu++v4udXngApgfY4xf+v+VRyC3/VwEPZgaLdyfv9XFF4WE3UboQPzFg8lDUnsnn
         VuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024009; x=1722628809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAD0QrgAhMaN+Loo56/InWrP52EhZGGkh8jgEKYZ7JE=;
        b=ukkc5qj0VveWtGAIcqqKTzJUOu9z6qGYOVNSqBR1xEHlkeLrZNT2qZH65XzDJhV8lB
         1uHLShyHmFPlcefyPagfCAM/auq3nG89toIVXTKUSmR2X55+gIcAzEnZE/KkdnCAUvam
         jwDLomp48zVK5ei1HN71rleOkS8mpmsr5JG/SwN6Uw8HAetYSyXG+O2GOJIruNHvnQQx
         Zy9r6SQT86a6ll3bVfigtYIH4PHrF9eSn488GilEUcbPTg3n/mMdfs7rSZF+ESZCSMaI
         MK+8WEDcuaESaBQAbUlTJmTcSX+DGEzhnXLsv4Eb7ANGTPUMLulfoBweMJjgoLaET5Zi
         JYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh6sd5tg659mEAuyCSNwkApWl+KLzw3paJGlbVObo0B518+LC3JnF9QtoAuEIN54Id9TLyztSm/3ws2780x3nOiC9oDHKTICbaUYFT
X-Gm-Message-State: AOJu0YwqHmcK1LtXTtQDAekoPgGkeghqMXrD4lT1pX/ATNhli0hsqv8i
	Y4K/v7R6F1KkXxK9hOZtoejdKuZ9EbbZDAz+QkzkjLzLubIRwRt/JScWW8qjP0g=
X-Google-Smtp-Source: AGHT+IEEzUyGNvBusd6G8ilz3PdSiFX7wBdFiW9IWqA0E01M8aJkR571/CYCOKrUufcdbTMsQmFD1w==
X-Received: by 2002:a17:907:1c19:b0:a7a:a7b8:adae with SMTP id a640c23a62f3a-a7d3fdb7dc9mr45197666b.4.1722024009219;
        Fri, 26 Jul 2024 13:00:09 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:08 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] can: m_can: Limit coalescing to peripheral instances
Date: Fri, 26 Jul 2024 21:59:44 +0200
Message-ID: <20240726195944.2414812-8-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726195944.2414812-1-msp@baylibre.com>
References: <20240726195944.2414812-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of coalescing for non-peripheral chips in the current
implementation is limited to non-existing. Disable the possibility to
set coalescing through ethtool.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7c9ad9f7174e..663eb4247029 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2182,7 +2182,7 @@ static int m_can_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static const struct ethtool_ops m_can_ethtool_ops = {
+static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
 		ETHTOOL_COALESCE_TX_USECS_IRQ |
@@ -2193,18 +2193,20 @@ static const struct ethtool_ops m_can_ethtool_ops = {
 	.set_coalesce = m_can_set_coalesce,
 };
 
-static const struct ethtool_ops m_can_ethtool_ops_polling = {
+static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
 };
 
-static int register_m_can_dev(struct net_device *dev)
+static int register_m_can_dev(struct m_can_classdev *cdev)
 {
+	struct net_device *dev = cdev->net;
+
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
-	if (dev->irq)
-		dev->ethtool_ops = &m_can_ethtool_ops;
+	if (dev->irq && cdev->is_peripheral)
+		dev->ethtool_ops = &m_can_ethtool_ops_coalescing;
 	else
-		dev->ethtool_ops = &m_can_ethtool_ops_polling;
+		dev->ethtool_ops = &m_can_ethtool_ops;
 
 	return register_candev(dev);
 }
@@ -2390,7 +2392,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	if (ret)
 		goto rx_offload_del;
 
-	ret = register_m_can_dev(cdev->net);
+	ret = register_m_can_dev(cdev);
 	if (ret) {
 		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
 			cdev->net->name, ret);
-- 
2.45.2


