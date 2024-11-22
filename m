Return-Path: <linux-kernel+bounces-418790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA489D65AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0389282253
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B62E1D79BB;
	Fri, 22 Nov 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KZZfyM3k"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D336E1CB337
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313824; cv=none; b=DE1FzhR4VCZXvi1DgxJj7Ex1+Z0kFE4VGi2URnp4RfYll8W+3gigPPS848rBs1a9LPzCqSSSrD61ft3tESAIprHo7e3SV+x6gcn/CxA3WsNGcbUO4OVpFi34v+ryNog07Qn1J4P28IMC+K/e5DSxan+zyxc8a6/ibN3wRaOeWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313824; c=relaxed/simple;
	bh=X5bhrWLbCQAe1csEiDvUzppWIlVR+MJIkYpWOBniS+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtEJ+cjojVqzBM7rnXSZpyiyA2mWBGJU45qpB4s3YaAxbkJ8ViVkMHcSGNXfe4ft2gyU2pTHN03NMfmY2vcRGvP9e48XSM1obqcaaqwwmlbDYZ5wBGNxjUzlyc0CdwGo/l+uu6fO7nMkhB9Q3AEwZCduqxQTiGTT14y79r0EE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KZZfyM3k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa52edbcb63so51205866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313820; x=1732918620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH36KmdYBNGOfsV00pmvqC+HZVSDrTPa9bev2FjcerA=;
        b=KZZfyM3kgN4sBMgzzvKjeWTKrcEf1uvhl0axEYrHnc8GUPjRupSI+oE4qZivkZAxGg
         5TjtCZkCPzJ7HhY6JMFwfurehnPLZuJtNEYyC/0UiG39C8JolUWpK3pGyO5fGQQB08it
         IkULMu+mozFhtfsBc8UcPCaDxfW1Kx3nhECbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313820; x=1732918620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH36KmdYBNGOfsV00pmvqC+HZVSDrTPa9bev2FjcerA=;
        b=hVUqiGJnEtc6T4gK9kFVXlJ/n+G0ax41rORdSuYwndO67z+pQIH0NmeFrVaWZroIfI
         knxhF+k0wxSxKw5ZjNR1JCbz7+HRpx+yr9oW5A5Peo9u7XVPWEbq+3GIxX1Gpdswh+dr
         7YuY8krJX0HiBk5wuGtDkgxId0lrOv3AQIVO52Itx2BlLGy9vd/6bS4qnPoCaxyAWe+T
         P9ga6IPk00kUqDXup/Eu1k3lZ+luy0wQbPlBzT6yqTpkoPAoaWBET0uVcQJO2dLYZDJ3
         G/p3QPRq8702JtHtSqKtqvlj0QZeMhT3v78UMKhBOuh3QJsS8qoDjsnwX5O0LrLLL9P0
         on2A==
X-Gm-Message-State: AOJu0Yx0LMzbGKj6plsEwSE0Nq7cyLu99e3hO28NE8nignsvk1WTU3Jq
	47/oJ99Ols1WsyXtR2GvkUFtBZgbzYetIqMD1bhTA1RJhhX2OniLD9hk3GgisDGRB2DJugdFJfJ
	y
X-Gm-Gg: ASbGncs2EoKkSHezpkzTSKUmd2wZAUsbwsb4XemQgUa+Iq4JFW/XCx2krE041nxXjYm
	PLifdRk68J0UiR9uptYS/qfZghiTq2Et4oFhefNUTLR8KSbtN2OyC+nATmKslZUog9jbDD43snw
	HWuC9iU9bINYlmxf6526o9H7bdz7jUAC0aQRDxq5XEvUdS7QJ31pb+XDn9JOobI7/u6MnV6ThP6
	s7Cx5AePx3Zy0yRdGGktLZZrEPvqOcPzLzH6ByEtsYRgFwbLj0QNEcBSOj8/LJ3JA9tb/E2sSdn
	Zl2nN8gzbZOnZ4EO0dUBcNfAJNB0Ajpsi8F1WMFjU4pqSHfJueYYaI0jg30R1Mf6GdgDIGr4hSG
	8ItcEgxn6VYq4u3TB
X-Google-Smtp-Source: AGHT+IH8FamDuZmqAUT6oJKKDvFN60oAvN/pj+lUo2fax+NOxU2EwGrNeXSVdxgLNcVN9PSpE7hbhw==
X-Received: by 2002:a17:907:aa8:b0:a91:1699:f8eb with SMTP id a640c23a62f3a-aa509d5aca6mr395581566b.28.1732313819950;
        Fri, 22 Nov 2024 14:16:59 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:59 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 05/12] can: hi311x: update state error statistics if skb allocation fails
Date: Fri, 22 Nov 2024 23:15:46 +0100
Message-ID: <20241122221650.633981-6-dario.binacchi@amarulasolutions.com>
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

This patch ensures that the statistics related to state error counters
(i. e. warning, passive, and bus-off) are updated even in case the skb
allocation fails. Additionally, the bus-off state is now also handled.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/spi/hi311x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index b67464df25ff..25d9b32f5701 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -663,8 +663,6 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			u8 rxerr, txerr;
 
 			skb = alloc_can_err_skb(net, &cf);
-			if (!skb)
-				break;
 
 			txerr = hi3110_read(spi, HI3110_READ_TEC);
 			rxerr = hi3110_read(spi, HI3110_READ_REC);
@@ -673,14 +671,15 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			can_change_state(net, cf, tx_state, rx_state);
 
 			if (new_state == CAN_STATE_BUS_OFF) {
-				netif_rx(skb);
+				if (skb)
+					netif_rx(skb);
 				can_bus_off(net);
 				if (priv->can.restart_ms == 0) {
 					priv->force_quit = 1;
 					hi3110_hw_sleep(spi);
 					break;
 				}
-			} else {
+			} else if (skb) {
 				cf->can_id |= CAN_ERR_CNT;
 				cf->data[6] = txerr;
 				cf->data[7] = rxerr;
-- 
2.43.0


