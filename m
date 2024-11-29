Return-Path: <linux-kernel+bounces-418788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE779D65A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32087B236E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED915ADA6;
	Fri, 22 Nov 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KezNprRJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4F1BD9F5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313822; cv=none; b=HUEbpojYXwm9HJ/SHg7X3uzti9zt8b6wK7OHIRsWCS8kYocnkgQ2k/TyCpu29Easno1Pt4cpHKU0nRXx9Mr0YHS0els+fmO5NPCnrwozd9iKlC/UDFMzGmGcqdPsuevVcKQ19oGoFjQspdz/hf5FGPw00rLvyDWt7+zqp7W5lnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313822; c=relaxed/simple;
	bh=efbjGTczyugw1pySOLOPhnxLKFyFbgfz1MN4+/QXZKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQohIkx58Y4CP/c5EbTr3W1oyW8F68Z3jamIaCSaxVEBeoOpHuwWzP+JVXsYaGMBstwAxbeNY7JUlF4lTO4iVwr85igxP2zIk5h5D8r4Arez6Lpz4mkns25hx/Mil0TR+ubItPQq9B2XbqnXVthKzlHmTIjqOeW7KjeVhLMZop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KezNprRJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so3580574a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313819; x=1732918619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJP+d2oKTX52rq2v9NzXxSt1l/2jtdXfEIdax2O5les=;
        b=KezNprRJDgkB/ZvtFVWa7/OaNf18HGv82uDoN6JgL5KWjlVORS0DRe5374FnknBc6v
         6i54IS2IiMhq/wTYg6r8jx6NtvQdA4Sz9Sa2KvTf1j8ZqTl4SHlTagjKlUl5fMgXjmsi
         IhwoxIvA9vziGCHKTX4oLJbE/qqoK37/aaHuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313819; x=1732918619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJP+d2oKTX52rq2v9NzXxSt1l/2jtdXfEIdax2O5les=;
        b=PhnERfcPOizFnvMS3GNL3VPBvyG3IuIpfI9sO/kUe618+btPLjaaMAq9699+OvNS5q
         k4Vvbb04dpTZi0PGJr9HrcCPgvN9BG4sxBKIWuRK7CcXNSYwhBIRVt/mz1wtIFUsCLzF
         O5shCLpCosci7CWhVfSWIaHv0it8SxjkN4zNslbrYZ+ZW1mahAisbODLRweCw1xPlbmD
         W4Pk1QZgF9jh0OfmAVEUG6c3CIvKfre3OweoIi/FzZNoZmXUECvI0oAet40C3pXvBfWq
         XIyb9CR4J3UfSekUh4URgsUUhDzF60TZ6kUYLiLJsyIFk5NEzTC8959BGkn2idvh28UZ
         54Fw==
X-Gm-Message-State: AOJu0Yy0cmL7hcvMN30KIPklrDAh8YRcDXTTApcHab3nhRyb5SUOBH7j
	wSA7U2MLDqgWoxA/NGRHtzMpmG3r3rDMogySmfHnn+No39aSd8IQeTi/a1wzfssLDGk70JKgbST
	1
X-Gm-Gg: ASbGnctCuWdDOPO4LYzQUxWVZ5jRb2WwgGhNW0HHnIyWXu96ogGCtI4LiQsE++QBaqb
	vXjPOkmX2TJsWLjcDcnXdPcVztu1UdhNfRKlz3zHLubp6hy2oCA4PN6/iNG/bdoocT6Cp40Nu3n
	LWVzhIn4dPNJnoqX0EB3LVwXRWZXiRQUO14BDb5CxmgGNgrXRIGH2rvLft+CDYxQOLahM0HXeYP
	po0LdbhSdRR5dfTA8HB/2Jg6/E7EYunpMk134Eggg4umf+0ffZ5oHf5muJtP4zpMnPEIPsymCbQ
	oM2peOqKnhdXhbBBM6AyZIBfYocr7SOqIbxbcdYa5tuLgdgN6vFX7Z4mrP9uccfRY3fftbvlmEh
	CNqToKHE4IsCxY6oo
X-Google-Smtp-Source: AGHT+IGVxTQySZsE/tv/VZESBfxk3xJJqygiRA0W4TZmeP4NEP+xLMVnae8R8ot7CiIlz9KLOHPPtA==
X-Received: by 2002:a05:6402:2554:b0:5d0:ada:e44b with SMTP id 4fb4d7f45d1cf-5d01d57df0emr4922820a12.16.1732313818928;
        Fri, 22 Nov 2024 14:16:58 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 04/12] can: hi311x: fix txerr and rxerr reporting
Date: Fri, 22 Nov 2024 23:15:45 +0100
Message-ID: <20241122221650.633981-5-dario.binacchi@amarulasolutions.com>
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

The commit a22bd630cfff ("can: hi311x: do not report txerr and rxerr
during bus-off") removed the reporting of rxerr and txerr even in case
of correct operation (i. e. not bus-off). The CAN frame is unnecessarily
set since netif_rx() has already been called. The patch fixes the issue
by postponing the netif_rx() call in case of txerr and rxerr reporting.

Fixes: a22bd630cfff ("can: hi311x: do not report txerr and rxerr during bus-off")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/spi/hi311x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 148d974ebb21..b67464df25ff 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -671,9 +671,9 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			tx_state = txerr >= rxerr ? new_state : 0;
 			rx_state = txerr <= rxerr ? new_state : 0;
 			can_change_state(net, cf, tx_state, rx_state);
-			netif_rx(skb);
 
 			if (new_state == CAN_STATE_BUS_OFF) {
+				netif_rx(skb);
 				can_bus_off(net);
 				if (priv->can.restart_ms == 0) {
 					priv->force_quit = 1;
@@ -684,6 +684,7 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 				cf->can_id |= CAN_ERR_CNT;
 				cf->data[6] = txerr;
 				cf->data[7] = rxerr;
+				netif_rx(skb);
 			}
 		}
 
-- 
2.43.0


