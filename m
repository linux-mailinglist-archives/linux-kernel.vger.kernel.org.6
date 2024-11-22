Return-Path: <linux-kernel+bounces-418796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA89D65B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B48B22738
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A51E0490;
	Fri, 22 Nov 2024 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aBwHWpdB"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431F1E0087
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313832; cv=none; b=qFYRzV0FRH8XXemu9Kp5Pct9o8fz0WxkMs5erjamJFt7hjxzHLmzrUlBt7iS92E5zXDWcTPGPoUBai6stELPyUEd2CkQATqMKTglhEfr/Fv1gU9Gm68gHJqexRW0QoWnI905wb19xpXlPpLzg9r4OMWvA0Bi3ao5m3QU7a+ZLnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313832; c=relaxed/simple;
	bh=UIfE/i9uNl2q+Mi+kE8Q7UwUe7PKkReqlrcUvsBIvQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjfWqxWDO1p2OFfhHPjkG3Q+vdvMUJGvCdRYTOO8bgd1Tk2lUX05J1InPDWxixRf4ZaTVP0UaWo6SZTeIWm8UMbLrPNPl6FGqxneVKm0POOiirYdOtfLMcEM3REjhPVkIdFP4oDojrBfFVrvxLAXbSOXIpz+rc+7r6RIUYKDDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=aBwHWpdB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so3096755e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313829; x=1732918629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIjLTiSdjHPZdtn456NOY4iL8rLUfrRnErOspsYBZzw=;
        b=aBwHWpdBYtOMzrVwIkcQU/deEsfrwLJVBYkTWRzhekbIQ0QvtOK+ZtBgEzkeW9521y
         fRJPF1n9Avbc3VXYXDNuDMMELY2bPSwgDYoGUxr7Wvz++vYndKJcKhbRS7Pksu9cp5CO
         0aaRgIsbvQEZutrle1DH36U+MIMwgh3c1tyB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313829; x=1732918629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIjLTiSdjHPZdtn456NOY4iL8rLUfrRnErOspsYBZzw=;
        b=jkYs3hQ+VsvbtYagEASuKpJ4kpOs4vzRyNGGgTiUtg/foLVFILp7KgVzf0zfvvaXN0
         nu5YhGRMYTExLhHTYeDSZ02qtyppgIedZ3clzjbtWG2R3ffoKs9Aa7ziVoK8mzIIA2Sv
         wTBRDMhoURVgvwEP4iLrFhT90vUYWJehc++wl/ccTK5G1Zbiu57EguNfp2u16xbbC+XR
         wHXu6b71mKf+GhZB8cpewHIa4NNWuS4ofhBAkK0jsJOF17Y/q2jUYM8WNF3XgZX4RoZM
         t2GrzUuZt+RfW/Mi9+P9TnmKUVwpN16HySM2VvA+UZ6u/qtXDIPWP7lSMZpOYHuKJf9N
         AdRA==
X-Gm-Message-State: AOJu0YyKQhQ1KGbeRddS639ovwN0wybl5nh0GB1Q1pxHWrpp/rdc/nBb
	69GNnHvwvwAyvW/HlPUoJ174r8LH0SqjRI2+zjORPIYJl8RvMQwjCd6dAFStnQDVWTX+y0vy89F
	S
X-Gm-Gg: ASbGncvZqgfmh8Qkf13dapKelWIyIgK+x7w3TDksRsR+aum0LOhc8hcyLpppQNmrNTk
	3H96MvNE1/WGnsELZu1FpjuYdKw6BkodVat99D+KrCrDvqg7KS5296Fa9PWK1RUlFc3o/ku0XKV
	7FPPGV452DDZRblwT5xRHv9PkjzPV/xtWlkV7FJtyuKdIXLs/PjBWqFX8+2OB44mGNMZpSQqt6C
	lDi9Tbl1e3LKIBgpYuWpFN6+UMSyT+fegktmxc6UhjwaPA2v7J97qxZYCJtCN2FtjsU/wTDrnY1
	7hoea6Ya/8spKeAF9XsjiDcsL2b0ILPZ7sQEHyXB/8xt6bVQ3G3IdCaaVtZhSlUOU9AjbJ1+VfT
	GOoGnTTGzdlZ7vBRv
X-Google-Smtp-Source: AGHT+IFzF09O/6bEbltd8l52ut4lZtd8WfeN0mrpAjDZSWj2O9HkQlqmxkwqoiHxqAM9cuMjAuwfqg==
X-Received: by 2002:ac2:51b5:0:b0:53d:d3ff:77f6 with SMTP id 2adb3069b0e04-53dd3ff77fdmr2299001e87.46.1732313829337;
        Fri, 22 Nov 2024 14:17:09 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:09 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 12/12] can: f81604: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:53 +0100
Message-ID: <20241122221650.633981-13-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The f81604_handle_can_bus_errors() function only incremented the receive
error counter and never the transmit error counter, even if the ECC_DIR
flag reported that an error had occurred during transmission. Increment
the receive/transmit error counter based on the value of the ECC_DIR
flag.

Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Fix patches 7 through 12 to ensure that statistics are updated even
  if the allocation of skb fails.
- Add five new patches (i. e. 1-5), created during the further analysis
  of the code while correcting patches from the v1 series (i. e. 7-12).
- Update statistics even if skb allocation fails

 drivers/net/can/usb/f81604.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index bc0c8903fe77..e0cfa1460b0b 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -526,7 +526,6 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 		netdev_dbg(netdev, "bus error interrupt\n");
 
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		if (skb) {
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
@@ -548,10 +547,15 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 
 			/* set error location */
 			cf->data[3] = data->ecc & F81604_SJA1000_ECC_SEG;
+		}
 
-			/* Error occurred during transmission? */
-			if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0)
+		/* Error occurred during transmission? */
+		if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0) {
+			stats->tx_errors++;
+			if (skb)
 				cf->data[2] |= CAN_ERR_PROT_TX;
+		} else {
+			stats->rx_errors++;
 		}
 
 		set_bit(F81604_CLEAR_ECC, &priv->clear_flags);
-- 
2.43.0


