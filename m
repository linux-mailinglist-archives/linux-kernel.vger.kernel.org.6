Return-Path: <linux-kernel+bounces-386844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E91099B4890
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D691F23959
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB2205E2E;
	Tue, 29 Oct 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cJAgIi0/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F4205AC7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202395; cv=none; b=FwMlKUxkdhvBlNMOqJ5Xz/vHlip1oMyTZ8BbANukqM+ZwpxKgLtjxaklFme3PJdxxbBSdw58YO0Ru3LGZDCGj5ACScG18nrO25EOgpP9uEV0Sq1TYlDJPcNPZP6uRzmrzlhqmdPg2WgZ3Th2u9tHvhB/U6ZbKULrGUN/DXM14JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202395; c=relaxed/simple;
	bh=lvBH4nDZzUSZ6y5ghSyZfw8hPI3PkCQivKPs3UeNvug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+t86C2Q9T0l5Po5cwZD+0mrnEh1YSoVuw3hlHcjKux0UsfwtUYFUnYVA+we3GTF94S1dRevvecGKQzOMUgs6qTt8WSZ8WgWTv4Z9DgRYyEkoGoPs/nSYrJkWK9z7Dd6WtvtVjsRO7pskGval0YSgv3mQKgnEd0zuYvJTtfGjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=cJAgIi0/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso7286302a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202391; x=1730807191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwyMMsHa5HEUfO6bt7mbb/5lMim+t5T1aF2qtApwxpM=;
        b=cJAgIi0/7SPUxJ7HNHDysZlTDGtxTn1tz/tcmQOEyXxvPbunMzaOfZCLAAl+1AOwCR
         qFQ3DyEVD558cPGtRGsvjhyuh5S4hAm4+Zv6IIIdfimu5w/CtlslfSCE4ep5h+zlF4uN
         U3Joh581iucoGm1pHb/0/50k007fFG1v3Ezq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202391; x=1730807191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwyMMsHa5HEUfO6bt7mbb/5lMim+t5T1aF2qtApwxpM=;
        b=R6AIeVxjivBZqIN4QtdGXEx0TMSSW35zmQtTNcXo1E04pnBaD6oF13DapKors3HaZz
         Ewmz6Xi4YINkEqcOxRWs9N3exMXj7LYrTQi2yAkhuEWt03g/jGMLhA9O0f6eF6if80df
         CHhxZwUj7KpI4/B3SL6EaFRxmCPwsOI6qoAn4YQPDKmthmCyh8el5h+aGW3DISt5uAz+
         1b8xddtGZv+3VsihyFGW16HDww7T3pc16nEUAWHEW6tttidYyg5iKTGw+oTGNod/28LK
         XSmcx1iKhfoo+bqf5+GMle49FmtHcxU+8DNN5wJw2Q3sLgqWkubY3jAb3bdD+2+dARuU
         OuXQ==
X-Gm-Message-State: AOJu0Yw+PaQzBYB05plGcpE3w4Trnemqka6hJ7bJ49CzI2U0xzvnfsAk
	/HxWYCe6yeJBqp32wQwkdIONaUSP4EVDtsq54GVqt19DWR8tjJZ9DmevjlmGZGAXzQQkFMirkEr
	YgkM=
X-Google-Smtp-Source: AGHT+IEZ6J2w8U62gC+m+8rB9mJkk7F6Y/9g2nTY0WJfkMv8EwABuhHpl3lj0h7DTiCw+LecXrTl/g==
X-Received: by 2002:a05:6402:5191:b0:5cb:78b8:7056 with SMTP id 4fb4d7f45d1cf-5cbbfa9b3fbmr7045227a12.33.1730202391375;
        Tue, 29 Oct 2024 04:46:31 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:31 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v3 2/6] can: flexcan: use can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 12:45:26 +0100
Message-ID: <20241029114622.2989827-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch delegates the statistics update in case of bus error to the
can_update_bus_error_stats().

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/flexcan/flexcan-core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..790b8e162d73 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -819,7 +819,6 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	bool rx_errors = false, tx_errors = false;
 	u32 timestamp;
 	int err;
 
@@ -834,41 +833,31 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
 		netdev_dbg(dev, "BIT1_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT1;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_BIT0_ERR) {
 		netdev_dbg(dev, "BIT0_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT0;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
 		netdev_dbg(dev, "ACK_ERR irq\n");
 		cf->can_id |= CAN_ERR_ACK;
 		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
 		netdev_dbg(dev, "CRC_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT;
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
-		rx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
 		netdev_dbg(dev, "FRM_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_FORM;
-		rx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_STF_ERR) {
 		netdev_dbg(dev, "STF_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_STUFF;
-		rx_errors = true;
 	}
 
-	priv->can.can_stats.bus_error++;
-	if (rx_errors)
-		dev->stats.rx_errors++;
-	if (tx_errors)
-		dev->stats.tx_errors++;
+	can_update_bus_error_stats(dev, cf);
 
 	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
 	if (err)
-- 
2.43.0


