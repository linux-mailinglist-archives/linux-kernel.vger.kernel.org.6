Return-Path: <linux-kernel+bounces-208998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03B902B99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F671F22E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584BE153501;
	Mon, 10 Jun 2024 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SwC2UyqD"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692B152E06
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058354; cv=none; b=QLiF45CPFHuXPVcg6XXHQEPXTlIZGRcACk7r29qNsIg7s0ZrwQ7vPhr0opVUVY29rP5+V0YtJN8/ZKF4ioRzdSUlxtqJlvpGUW8Py64PF5KYhkNHuAbZkVfbWlVMEEVSmcW5NU2AiYafOsA+x9jMvzTLVJtYxfebwKrCmxtlaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058354; c=relaxed/simple;
	bh=T5OLyywzVlFurET65GWs4Use8AE33uLe7yuCTL9LXoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrkMoQe++jlqDLKu7LWdFi9gdHM67u9aJVyPQRs9XFY49MTfNEmLpp60WNcTmkuk2el5gTjDQpHoEOZ8sq39Mswy5iq2AEV4xSLeURw8Qx87Nr2MSZqUIBomqVdX0nI7n09obWiotOvOvbtoL6cO1QCSMvUzZ4aHy+NEItFKNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SwC2UyqD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6ce533b6409so338459a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058353; x=1718663153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqognB14Qp/8L0cEa0xbpDxiXXZEj4JiNnjscQN0iLs=;
        b=SwC2UyqDeg1+AETILJREvwHFV/hRFhSC24cbCJmnaizVaHgnPDOBW6ieyYD3INYtGl
         kCD8fAN92bYH4qxDyE0tN5jR+6phTe9jWtKxvFPzzwrW/FwUtTC22oQNN8+fzehkv1YX
         /LNFX6a4Oc00wbGEobjuN0EuOZqUulsuman00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058353; x=1718663153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqognB14Qp/8L0cEa0xbpDxiXXZEj4JiNnjscQN0iLs=;
        b=mPqJZmh+Z8UtkJDukVBEFBJxX29h+yTg5duZPerus9z3/Er6qmostYrWIIBAvzu+v/
         V09YJPBRq6/ecXb0bVgLxzeEOcUNE+IaXpY7WlWrYzwRIQ8CT6vp4feWjX4IV1mOQg2s
         yRUM4ORP1NCqgclBWU3myaBRIi1fW0LIYvNkCCPOy1zcVVVlpqj+MA1Z5To6EREOqubY
         XAIVABCiVNNhzM50FAZsf3e9NfkF4/rihd7YLS+ahSRuFDXJTpfFG2jA598L6s80DJ58
         GGA4PdS9I5vH1GVdSgzBcRoc9WdXXOhk7bSpSBY/abHZ921U/1azvG6TjE19SZufu1wv
         eE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfdCV2rY+7tZEmkI7eBxtWloyNVVvg/HX7ii2xKaCuL9eX10+Q1uLqAtad2ug/By2Zu85XqUidC2CO2j3b6I6bGRYcEt5iGa0iczez
X-Gm-Message-State: AOJu0YwI5wYLGl3SOHX4hK8VH1W8DeeOW6vP6of4NRn/bxAQFxO6pkvs
	zscIBhVPQUdok3w9tiPsNG8SLhhDENJ4tSXPTTynaRbEIt+c6AngRaTbfCet0w==
X-Google-Smtp-Source: AGHT+IGRD5vE34alDO+sziMhlcJdI1lhwO848ApwoqxHcu+WdfFnr8XzF2Vq5NcxF2woJmJFfRkAAw==
X-Received: by 2002:a17:902:d4ce:b0:1f6:3721:bca with SMTP id d9443c01a7336-1f6d02db91emr149922465ad.15.1718058352746;
        Mon, 10 Jun 2024 15:25:52 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bba2:69f4:1b51:d0f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71029e223sm29212325ad.170.2024.06.10.15.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:25:52 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 6/8] serial: qcom-geni: Just set the watermark level once
Date: Mon, 10 Jun 2024 15:24:24 -0700
Message-ID: <20240610152420.v4.6.Ie02dcdf46089457026de3bd665c08f0210711966@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240610222515.3023730-1-dianders@chromium.org>
References: <20240610222515.3023730-1-dianders@chromium.org>
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
index bd03b998ed04..132669a2da34 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -391,7 +391,6 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
 static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 							unsigned char c)
 {
-	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, 1);
 	WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_TX_FIFO_WATERMARK_EN, true));
@@ -435,7 +434,6 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
 			bytes_to_send++;
 	}
 
-	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, bytes_to_send);
 	for (i = 0; i < count; ) {
 		size_t chars_to_write = 0;
@@ -663,7 +661,6 @@ static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
 	irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 	irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
 
-	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 }
 
@@ -674,7 +671,6 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
-	writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	/* Possible stop tx is called multiple times. */
 	if (!qcom_geni_serial_main_active(uport))
@@ -1126,6 +1122,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 			       false, true, true);
 	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
 	geni_se_select_mode(&port->se, port->dev_data->mode);
+	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_start_rx(uport);
 	port->setup = true;
 
-- 
2.45.2.505.gda0bf45e8d-goog


