Return-Path: <linux-kernel+bounces-411845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DBB9D0052
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EA51F22B10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8523B1AF0A0;
	Sat, 16 Nov 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KC447fUs"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9419E982
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780195; cv=none; b=ht4FjIhU9WJF7r3gzKOIDVHiR2ZduwdXxFQxqEgLcGgjEhZpQjnq5WeOfonVd9HQLn0lkWFTdCIPms/2Y1740Ddd2YmIVNv8u6vd/BH4jWvw7ACVI+BcWTb2qxhufMaLMjFxP2Q5rypPLttUeESOJB2sQl9EIHShp5I5bkqRkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780195; c=relaxed/simple;
	bh=iVOkbe1eRnWeGsTAkh+kyxSnjEZFWE6KQVh2hr3CkMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCtU8RmJzQ8VxBmVDLciNIcKbsgJQd3GmE6Jnev+QY/OfpIjBQz+vwn0Q6tu3H439XPPAxzXgn6fsPkEfUfxW+60C1izKZkxrkyToyLXWnBSuoTCPwFb8ILsdo4XEdAD0IgshUtPNLlHEPI4lySjhQYXbISUgpI+vbL5KBE2mkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KC447fUs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ec86a67feso539944866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 10:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780192; x=1732384992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1KN5qU2y25n0Oin8u2W01ajVRL3l5JZUYgBLtna1CA=;
        b=KC447fUsL8LwnpmfucdTwo0WlrEG83Da74tIB5BsC7E8xWn47ZcNLNSUbsGSztvXdU
         zsX07uTScA+wf3aZ7U2hOhW1k+StezN0wcUHaHR9JCpEIWtrHhTkrybJszUDRj9Qf8x+
         y2YULSNNzJphGose2I52z8dYmXnv6EHq5pUJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780192; x=1732384992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1KN5qU2y25n0Oin8u2W01ajVRL3l5JZUYgBLtna1CA=;
        b=VFRj1gFYKL8JA0UiYaJXuphr4MhrRbEfLEl9s85VxZojVdFQNeFpNl49QFSmWgvM5O
         LAg8OniCJQS0Nyd479gOCpXNr59oDaGK5FnDQmoZRHHMSqlrYIjHtHsNXxwzn9wTLFA7
         nwlfYgn5GmikjYlF22PXpBfkkdiD7XIe91jBsko/2fdcOgi91LVzH1BYI4rgi1Xgmr95
         CfrkfU+OW9X6PUconepYCDV0pf7dqJTQZnmd30Ky0k0MrzA91+2Oms9/6kIEHCxDeQLg
         hOgs3UQyVk3dOxZdfIcYB8VeyAbRC4EbCGyhI+pWM7za3g1r0K3r5Kmz3a6pGp5BAllH
         OlTQ==
X-Gm-Message-State: AOJu0Yz81kxCaTIyvMVIBofPGlSmGzuqu92nZ8Yz7q64ZNrwDvNB9n1/
	h16kmENG2Whvif4ukE85P1+pgOuZ/qeBUpSkKDYb9YQQFfTRLBetm+GZ0vZyWgb4rg35B0S5wcg
	+
X-Google-Smtp-Source: AGHT+IES+ynBAJVqc7eTqNBNioplQ+TxFxR95t5P1e/kKOcra0XnT3EiiSNrB4CCUflAKPlc0RxwSg==
X-Received: by 2002:a17:907:3689:b0:a9e:8612:eeca with SMTP id a640c23a62f3a-aa48352b54bmr627153166b.48.1731780192655;
        Sat, 16 Nov 2024 10:03:12 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:11 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/7] can: hi311x: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:32 +0100
Message-ID: <20241116180301.3935879-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
References: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hi3110_can_ist() function was incorrectly incrementing only the
receive error counter, even in cases of bit or acknowledgment errors that
occur during transmission. The patch fixes the issue by incrementing the
appropriate counter based on the type of error.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/spi/hi311x.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 148d974ebb21..7a4d98037cd3 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -701,17 +701,22 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 
 				cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 				priv->can.can_stats.bus_error++;
-				priv->net->stats.rx_errors++;
-				if (eflag & HI3110_ERR_BITERR)
+				if (eflag & HI3110_ERR_BITERR) {
 					cf->data[2] |= CAN_ERR_PROT_BIT;
-				else if (eflag & HI3110_ERR_FRMERR)
+					priv->net->stats.tx_errors++;
+				} else if (eflag & HI3110_ERR_FRMERR) {
 					cf->data[2] |= CAN_ERR_PROT_FORM;
-				else if (eflag & HI3110_ERR_STUFERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_STUFERR) {
 					cf->data[2] |= CAN_ERR_PROT_STUFF;
-				else if (eflag & HI3110_ERR_CRCERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_CRCERR) {
 					cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
-				else if (eflag & HI3110_ERR_ACKERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_ACKERR) {
 					cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+					priv->net->stats.tx_errors++;
+				}
 
 				cf->data[6] = hi3110_read(spi, HI3110_READ_TEC);
 				cf->data[7] = hi3110_read(spi, HI3110_READ_REC);
-- 
2.43.0


