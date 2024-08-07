Return-Path: <linux-kernel+bounces-277854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C2D94A753
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7D2285F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF11E485D;
	Wed,  7 Aug 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2eSwrGT"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E18171E69
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031902; cv=none; b=LHsU2BfxFMY6T6QfwJLv6BlCckiS37fhHi0mrWt7qTEYckyDibOcajRNzS6oIsCsemaoakjYNgYuzm55EJ7K7QkcJ8U8sN/zeM5n/N8OtfwyjoEte0Su+k3p1ggg+z4qTOjvIbQlvTcYSDcQQMVsSqN+TlurO3QzmHnJrfzSiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031902; c=relaxed/simple;
	bh=C0WfsFjQ+8vm0W8joRCkaLKnopigm0TpDNtG9k6jpMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDzdPwm8i/JLuCmteMM7hD4uhYLdpltJK4oSaqmgLt+GqQBlc4+51cvOdFyVKqJaL8zjSlVHy6SKJ0diBVSNY+MMbQGUEHmls1x1ybLpqY18qFeTJFrngcUtqTvHGq2L3GdoM57wANAuXsnRDoW8KoOkVZnofwCINGCA4srdfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2eSwrGT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a728f74c23dso202229266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723031899; x=1723636699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMjvgficlM8E7OFHsCNQI4tsZ98VKn4/e3uEzM8rqJg=;
        b=k2eSwrGT4N10qW1QpzRMc4fNJ+UOskao7bA0kjY4HGQynu6b4FfP9Y/pCdZ9vejS3n
         UhZSueJakcbj9bE5EZYA3ZZ1S0c6B4xPsuLI0WySCC3wp5JaCLgzXNELHzcFW15pKE+2
         /dugAdewdcCbuOI9A5awbaWyxbhmuoA/bpAw0ZDs/szv/meJL5WtrkK60IJwSPJWciHM
         pu+CduJsxt3RGbnNUhMHP8dMK6TyxECk+xxei8nT/cq58QArjnn+MmcrLXo/MSbN07Da
         dh5ZOqxBabsm/rXLxhanXBQHJfsy5EmqG898G4ZKT+u8ZYKHFVdj7nnbUCK2YT3QG2Ps
         CxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031899; x=1723636699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMjvgficlM8E7OFHsCNQI4tsZ98VKn4/e3uEzM8rqJg=;
        b=HbD2gDbuz8sMJ2ckXIlUVgCgwXW3/vYYbVoW6fdZeWvNtwDW0W2oS9Hn2n60CZZFYm
         O3laJ0/BLDA9JgksoUJCzzkFvrcN0bopeS9gHFceW+omVQ3xfDiYSpuk4Rw21PTBXC/U
         MhlVwPYP4ZVgJyebbj/YYMYTSKQ3+2dZ7TWCK8ef4Awfbdbo64zr7NZPkrAElBicbJZ/
         EOiLLNP9FUlYM2jw6eXfbCllB0JXEqGCbze1OMYfCvvCE97gf8n4JCnFyspA+ivu32up
         T+F228OnRxx7+wa61+WEazmRcnTxLlobfgxDLmeQp8iDi6lFCh/sw7v9FMRDbLeV0knM
         0ZlA==
X-Forwarded-Encrypted: i=1; AJvYcCVmBjfpow//IhDcSR7O10YFzeOpEO0otBEp369xjo+omxe1eIuJBXQW0nNH1VL+srb2PtLtuqrU9rYfOG1QF1sNx7HH/UQqr3nhet3C
X-Gm-Message-State: AOJu0YwmOz/275vIW0Pii18WtMt26b+RVz267gwOWifA9m7gA4NXnxq5
	ME20RIL9DIOseF5gdiOj/G0VATuThX7hL3nosYNbu2/SxzNrkuZl16MEWCtVNaM=
X-Google-Smtp-Source: AGHT+IFX/mnj8z/gOU4S/Qjsm2FR4qQxyCrhiZEmvGKW7LyZfNdC7JaX0Q3SxwF74ucLtHDokfAeBQ==
X-Received: by 2002:a17:907:1c19:b0:a6f:4fc8:2666 with SMTP id a640c23a62f3a-a7dc506ce86mr1394858366b.44.1723031898724;
        Wed, 07 Aug 2024 04:58:18 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d45239sm631017466b.119.2024.08.07.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:58:18 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 07 Aug 2024 12:58:18 +0100
Subject: [PATCH v2 1/2] tty: serial: samsung_tty: drop unused argument to
 irq handlers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-samsung-tty-cleanup-v2-1-1db5afc9d41b@linaro.org>
References: <20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org>
In-Reply-To: <20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The 'irq' argument is not used in any of the callees, we can just drop
it and simplify the code.

No functional changes.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index dc35eb77d2ef..1c6d0ffe5649 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -855,7 +855,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t s3c24xx_serial_rx_irq(int irq, void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_irq(void *dev_id)
 {
 	struct s3c24xx_uart_port *ourport = dev_id;
 
@@ -928,7 +928,7 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
 		s3c24xx_serial_stop_tx(port);
 }
 
-static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
+static irqreturn_t s3c24xx_serial_tx_irq(void *id)
 {
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
@@ -950,11 +950,11 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 	irqreturn_t ret = IRQ_HANDLED;
 
 	if (pend & S3C64XX_UINTM_RXD_MSK) {
-		ret = s3c24xx_serial_rx_irq(irq, id);
+		ret = s3c24xx_serial_rx_irq(id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
 	}
 	if (pend & S3C64XX_UINTM_TXD_MSK) {
-		ret = s3c24xx_serial_tx_irq(irq, id);
+		ret = s3c24xx_serial_tx_irq(id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
 	}
 	return ret;
@@ -971,11 +971,11 @@ static irqreturn_t apple_serial_handle_irq(int irq, void *id)
 	if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO)) {
 		wr_regl(port, S3C2410_UTRSTAT,
 			APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO);
-		ret = s3c24xx_serial_rx_irq(irq, id);
+		ret = s3c24xx_serial_rx_irq(id);
 	}
 	if (pend & APPLE_S5L_UTRSTAT_TXTHRESH) {
 		wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_TXTHRESH);
-		ret = s3c24xx_serial_tx_irq(irq, id);
+		ret = s3c24xx_serial_tx_irq(id);
 	}
 
 	return ret;

-- 
2.46.0.rc2.264.g509ed76dc8-goog


