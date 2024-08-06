Return-Path: <linux-kernel+bounces-276495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C608949491
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5632819B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E471A2AE99;
	Tue,  6 Aug 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHho+nBb"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737011CA9C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958200; cv=none; b=I2YTW1qjO38ixaNBHCb5BcpOkrFViX/F4+KENObKZOBZ+nTjqhqx7vu+/HuS4IrG3D+g+JfpCJFr4xEQYkYvWlIB5rABdNh3b9OxrmDf/iN4nWgTTu8Ck5jDCDJ483wl2hLxslLZzISnoAHO//vaGiop2YUVS5BwUn6RCv8T6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958200; c=relaxed/simple;
	bh=bPeZihTCF+Ow/O7uL47gsdFVGSiVkl8vSkFqcaDBcF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQkJogb4WPZQg+PeBeidbESRTwpbbAe8XZKxy8zdzm3bnKKAvSRgQ2mdKS393ZUQv6/hKHBim7JPfBxy9Hh3/H/CQ/gGg0PPeOe6nk0Jh4/IdP2qX+m1VyYDNt8JjXh+XvaWgV7GxXSDNNhwfmjCkYyWlXmfl/bCL533MO+lvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHho+nBb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso1141123e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722958196; x=1723562996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk2Awb+sGDAUp2fed+2uqRPu8RHHDA4mh3PcSw6gyEg=;
        b=FHho+nBbmIvVErziWtqg1ezzjYrPDFztv2R1cezhc4jRqjKO510g0JZE2akgrISH04
         Tc7zVLSv/oGHkwrxNpQ8j8vcxV+OOhjsbJZX3QHzdSI8Pr9PLZJlkZQu3V09Y6qrWNkJ
         SskT2xzdrTKyv9dsHg0ZTsV+FS7g/6TJjf3XDlBN8xHgj88wZSgogUF7CQE+DhGlteS6
         zhMc2HZpdiOy0EDr9h/gRuXxuEDg+OmtPvjAVGkVWcgLMZRcHvu5c4nSLILPu8HjD6UK
         pn0sNUFtVgIajWG7y4dGxoT3i+2hz/rZa1N46MWkNP54I90smA6yX7kev0LKfu1iEkyf
         6cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958196; x=1723562996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk2Awb+sGDAUp2fed+2uqRPu8RHHDA4mh3PcSw6gyEg=;
        b=bCSc7XJr8g15zgM8pXDcyyXiuoq6NGv49ghNCL2yG7xxuKRg1qm02bA5A2QCYps5qy
         7qUuhJSPn8iNOT39b27cxESbLa2oYxAM5ocVo062rx1ZBSzaN6aXfEUuoQsR72MgRfTJ
         J525uW/BtC7vPQGw8K2pcY6k6JXoI3Ehr28Sq0jbrl2zzj/d0nnJuAb8mGTmdcmAdxwG
         qqnj2ATgF2ktvkPHjfakIeJgbxrD7fFKUYeN5AZ9NTKVlfqilwTxkGDRBU43mS4YG9Fk
         lehdqjgcKaTWVIt1O53i/Ivec9M4nqPjlIz65FlLyYOekL7jZ6VLXZt44+Gx7jCP6Cal
         FLqA==
X-Forwarded-Encrypted: i=1; AJvYcCWkEYcVPP18bhheoStizYTZE1HnpifULenskvpo7mduTkFaLYCi7KCh7mRXjHRPqhR0+IhqAa2GF9lxYhG4znA8WE8YfgXGk2B1rCeO
X-Gm-Message-State: AOJu0Yx2yAM/kyhNkkg/olZQn7byQxdYYz91ef6WjZtlACTh+V0D2JaC
	GaTzDISQHcsYrgjoC9YyM1huokx4T9HLJ7C66/R4cg7Vm3FSieq/g+iFWLmpBmg=
X-Google-Smtp-Source: AGHT+IEzRSe9RZ8IZ7a79GIk6K9Ld7GIQxp37hHU2EYAuNypM9NuHuI6ejLRItdRTqLiJvXepFVECQ==
X-Received: by 2002:ac2:4c88:0:b0:530:bbe7:4db3 with SMTP id 2adb3069b0e04-530bbe74f4cmr7491016e87.39.1722958196387;
        Tue, 06 Aug 2024 08:29:56 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4294fsm555274266b.103.2024.08.06.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:29:56 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 06 Aug 2024 16:29:45 +0100
Subject: [PATCH 1/2] tty: serial: samsung_tty: drop unused argument to irq
 handlers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-samsung-tty-cleanup-v1-1-a68d3abf31fe@linaro.org>
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
In-Reply-To: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
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


