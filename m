Return-Path: <linux-kernel+bounces-201028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1418FB858
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C3C1F2189E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220F149C53;
	Tue,  4 Jun 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lpffwFK2"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71550149009
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516917; cv=none; b=m73PKYcXG7SLwuNZ8tFDEIf1ZyQ+aRYxxlNatsQJlm/yGGUh0R1aplpIR7lUn9mNG5cumlkJfpwVwi4zpeV6ThZVPa2VEEncqF2iYcQqMcvsRpqoTdcMwfGT5c51DqiD30ztS2RIdSkyOYsx+Yv8BPwi4yddqpeey/DUrO3L1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516917; c=relaxed/simple;
	bh=15DzlyVMUcTOkeXAubhI5pLAwA7wvcRYCR8M+MhF4rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quJrGAXcmNX/7EhWlaSrj+DI2xMGl5XiHl8xktfIJKSjWcA2LvbnkOqoDHYo9QrJQkt9n8sbSJo6ofAOl+KIan9YIcFGqfF9FB9IyHoCruewpH0je7kIXKzL3n2vYsgO0NBDTPIQ6A0iZzd2v3H/z/xT+eCB2mrEJp3HfkL/jVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lpffwFK2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f68834bfdfso10243515ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516916; x=1718121716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE0jSu3gNAz5TfFVSt4q33fv9zdqOZE0PPbSpjByTxM=;
        b=lpffwFK2xfCt1/gc9dKE32ALQEER2WrcsSL0cecueJF+gnoxkLsPFhV2YbOR7A41Kg
         hlE4Ss2STBgIddxikhB2efH5CmPnpNs1RXVLPaHRf11OTD48qAN3F4FChu6+OanGyHZX
         RfBeAEkZtahGJo1Xk7FcDDkf8+Ra+vSQ9Q7iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516916; x=1718121716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE0jSu3gNAz5TfFVSt4q33fv9zdqOZE0PPbSpjByTxM=;
        b=Za5cKqoH4nrJxY7jmcbq2fOTZiRAdpgJ6SmNeO8q9Y77xVepyEiUDIrfEluEtuyMDz
         nwwuUZCGEwYzTQPJsAvV7NrZTtEG++xqfFChMrJ88qSyNDPZJOAFkPhkCtaJFz7yxJtf
         CGaXqmfVE8Q8wUgj3GSnSaF2DYSvFafXeOS/e15dFSUEsE9vA1eHi++7BV38161sKxc5
         OeGyl8uRSvD4ubhZUAYt+uMbVy8OKOCw862LQXIikBkBHb4mNMtKM2uSF/3z6nf1wPt2
         RPKc2avvQNI54svDs3BPVFshn9rhuwBt3VlaYtjNUFmxCVj99zv0lfmGyeaad6p7m9/v
         k+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/3pJoZr8rgkw26GXJTZE5ZVOsd+2Z620sbDAKNL+LU+8E9C7/NZwO0Zu2WyQQMQw3ct4tngdICZD04MkHYD7iOZUfW3CrDjBx0Sii
X-Gm-Message-State: AOJu0YyGSLUAAWdXkGWYXHLKEzFm8YeQmPfcpFIPp4dIPr2R2+xi2uR5
	lu8Taq/XikJsKjt4H31WhvPsjttZ3FDWy6JaDw0b7PHld7GN5KQPXNndqa1SCw==
X-Google-Smtp-Source: AGHT+IFkIwPtOoypvgPqLNqXAQBGQokER/5fhFdY+L+D7rn8exKZ8pBPYZy4Fs9smBGqvwO1LGphxQ==
X-Received: by 2002:a17:903:41ce:b0:1f6:7ee8:8935 with SMTP id d9443c01a7336-1f67ee88adfmr68395605ad.59.1717516915589;
        Tue, 04 Jun 2024 09:01:55 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:54 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v3 5/7] serial: qcom-geni: Just set the watermark level once
Date: Tue,  4 Jun 2024 09:00:31 -0700
Message-ID: <20240604090028.v3.5.Ie02dcdf46089457026de3bd665c08f0210711966@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604160123.2029413-1-dianders@chromium.org>
References: <20240604160123.2029413-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no reason to set the TX watermark level to 0 when we disable
TX since we're disabling the interrupt anyway. Just set the watermark
level once at init time and leave it alone.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index c4c54359d32d..4dbc59873b34 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -392,7 +392,6 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
 static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 							unsigned char c)
 {
-	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, 1);
 	WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_TX_FIFO_WATERMARK_EN, true));
@@ -436,7 +435,6 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
 			bytes_to_send++;
 	}
 
-	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, bytes_to_send);
 	for (i = 0; i < count; ) {
 		size_t chars_to_write = 0;
@@ -664,7 +662,6 @@ static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
 	irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 	irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
 
-	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 }
 
@@ -675,7 +672,6 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
-	writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	/* Possible stop tx is called multiple times. */
 	if (!qcom_geni_serial_main_active(uport))
@@ -1127,6 +1123,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 			       false, true, true);
 	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
 	geni_se_select_mode(&port->se, port->dev_data->mode);
+	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_start_rx(uport);
 	port->setup = true;
 
-- 
2.45.1.288.g0e0cd299f1-goog


