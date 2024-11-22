Return-Path: <linux-kernel+bounces-418786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCD9D65A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9B8282264
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA21C3F0E;
	Fri, 22 Nov 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ony2tUkd"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329818B47C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313820; cv=none; b=R287wnNVWslN3st8dwPwvf6t7FFzmu9SOORqsbPmxRxQCKB867aH38N/XG7QZxvJi4hwLM7U3Pac4pyVds5+0hXkXPxSYKr+ectVJfWc2P96h5/AlIQ9Clo82ZRxLnQtX+0HVvmx7KlEw4fvNlOSUoDR94Cx+5yCnDeLtltszms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313820; c=relaxed/simple;
	bh=cfN/Sqofe2yynbRgQXfBL6ERxMwzjmzkAWAp/j8LOdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1D8iLssP1MWJBX/uqWXRppTQomC7UcX3MUkkaZr9yCmxefHtABv4/oJyhW1t/AjkyVpiIvAIZXPAfTOqPMvRRUaSWveDUf8XYYR07/N7QxTDmtXXaC/oK8dnBR14i/pE9ijSjFYQDU1vTrXY9LDxQRtMVS3GHRp527s6KxmZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ony2tUkd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa4d257eb68so491435166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313817; x=1732918617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HrdX116se3rn9QRZsQ51ceQKyywuhiVyeVP2xiWD4c=;
        b=ony2tUkdauEIYZVEV/1jP8fiwqKeU4V4xvrVR4z5nok9zNeaZs1wGnAXaI1dj0N+tZ
         KVJj3Bg83OubPEuE7KlXnFOYjYXtGqGhBb/hK6V8a0mM4ymG271Nv9CPoxaT3a7yVgv4
         slHmejqsov+WI/jJuxWqKaCD86kYqO0FUmb38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313817; x=1732918617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HrdX116se3rn9QRZsQ51ceQKyywuhiVyeVP2xiWD4c=;
        b=EUf5uhOPQ/UigOX6Si5QGcP1GF2s75I+/N0hWl6o+KJ9jHlWctzjWE9qokdlf0myuB
         uHBZoNtcIPZ1Bf8o1ewh/GGcwJ8ojtTVIywRpra7AI75jvtf4olRO+iomWiRII4F1Rny
         27pfTMfdKm5gaQ83GeJvF+HWBD2jh7nmKX1/r4P/MqkGI01urDDmAQEwCOgw+MLdsnpS
         lshjn1xO1i6qZHB+65QR5pRY3xz0Xce3zxE1MYG5hlqqnA08rbCVVYG0zzFcfHLLpZ18
         xorcp3YkUHCmK2cEx51MdJQV+cqtyd1mbSvL63dg8ubuHMsbpk+jeM9Iq41o2RtAhh0t
         2jKw==
X-Gm-Message-State: AOJu0Yyz1ZY/VF8c3VydS6pIvvAPdshFCNHEGyiqsY5BYFScIENn5PIV
	98AFQPXJ/f10/35Miv3/t/Da/cVStR2QS1e3KfRjbyIJorh9+lXiqm+uxgMWyiT7CZOdbSOSTwO
	v
X-Gm-Gg: ASbGncsj4qSRicw7ti5GCnOSJF2C1BDxpRgj5LxBTmT8NhICi7AQmTknGjNdS/r3+bs
	0QNPUE5soti4ZqG3BNnK3LDUcmczhEZY3IqjKFofX2Sw0Yef6jrau5BAhmP4n3zdfWUj7GYMocr
	TRs2IjT2kOK99IuBFAmfMFDuMi08DzJ29S5RkjtqzaynEjcr7PszVLFal8za8G10LeUhm6Cg1vJ
	nom189zTZfeZQZMtASiDCf40uxO3RpLoIafsSqo+Gq9SzFi6ZgBU+3wYBv+vs//yOclO9APrkr8
	4wa4wvgf0Meh5QRtAic5HMeFtfeLJ6gsZGN6mjfqtJNx1UNb5WCUSFZ7Nz7QEOncbIzhgEVlGeY
	6aYknahP4iX2t+PGn
X-Google-Smtp-Source: AGHT+IHRSafR/Hd70o+h3rYpO/7VHYMjBwxEdj1MERjp9IAi6352iOe+u8OcuPheRZbM1LDn8364LQ==
X-Received: by 2002:a17:906:31c1:b0:aa5:24df:ca8 with SMTP id a640c23a62f3a-aa524df1311mr297959966b.18.1732313816670;
        Fri, 22 Nov 2024 14:16:56 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 02/12] can: sun4i_can: call can_change_state() even if cf is NULL
Date: Fri, 22 Nov 2024 23:15:43 +0100
Message-ID: <20241122221650.633981-3-dario.binacchi@amarulasolutions.com>
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

The function can_change_state() can also be called if the allocation
of the skb fails, as it handles the cf parameter when it is null.
Additionally, this ensures that the statistics related to state error
counters (i. e. warning, passive, and bus-off) are updated.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/sun4i_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 360158c295d3..17f94cca93fb 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -629,10 +629,10 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		tx_state = txerr >= rxerr ? state : 0;
 		rx_state = txerr <= rxerr ? state : 0;
 
-		if (likely(skb))
-			can_change_state(dev, cf, tx_state, rx_state);
-		else
-			priv->can.state = state;
+		/* The skb allocation might fail, but can_change_state()
+		 * handles cf == NULL.
+		 */
+		can_change_state(dev, cf, tx_state, rx_state);
 		if (state == CAN_STATE_BUS_OFF)
 			can_bus_off(dev);
 	}
-- 
2.43.0


