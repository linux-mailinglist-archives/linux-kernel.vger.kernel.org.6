Return-Path: <linux-kernel+bounces-201025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82708FB851
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1675D1C2197F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2714883B;
	Tue,  4 Jun 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PHDZhjU8"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CA14830E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516908; cv=none; b=cVyBJowjUpNo4axUq/PDvKmEozuB1GVHZPc4YQKtlIhLZIbFD6W3PVcojJT5ulxVU9YWjD+4Ze4ph1zAz64e0RPnLWVMRCC6i3ot96uNAGCILKDoVl3gXxT/8ZRETeGiGXtNZrnTM95OH/1/FD1axtXB5Imz6gatg8Hyk2Inzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516908; c=relaxed/simple;
	bh=SZcj9nvPAkd/Cv7HVInVaV/p1RAb1UQMCQMy3RYGV4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHg1qcho+3uZwpPkqHH0Eo2L9ohuHdNQckTd3dXNDaWe9DIm2uUiA8wC86UpVUMDu3ZJOpQoyq7GItZH5XfIJSoJSu+I3TvP57loXbcM7CVlddIaXp//swvyBUJhTGVg+JXpBIdKXRMa80t2kPYhn0UU+aCRpSrcu/epP5PpsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PHDZhjU8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f48b825d8cso11037985ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516906; x=1718121706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L66kUAR7RZnRxdJympn4knIixZh8QJnRreM7SkXnIs=;
        b=PHDZhjU87FCa/woTn5B+LsXFc5SLP9rge/BHqrkT3JozpMrCsueD/6Q1onRGdn99QZ
         GQWlYPxTNzjkeSaD43MbarGuRa3aPMDGAa0tLXrI4Kv9P+Fd35s6t30x6kW97dl82ECx
         vK/K+RoS9ZHBT5+hPCYiGre7cYLQ2Mry62/1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516906; x=1718121706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L66kUAR7RZnRxdJympn4knIixZh8QJnRreM7SkXnIs=;
        b=b6X5L5lnUa+NM5USzlEz1XJC1/OiZc4R841XQF98tnOiNfVuUWGJTfO9O/ifroyzvt
         Be6gv1WZ3POjn4eJOir5dn9uAdN7ByKuMWT+2hlbtJstJoP0/GRwC4+8h2msI7iWXTHu
         Rm6rZ/7JZtBIpZ8lHHOsAfwsEKo2o3Is0amMur7G2EWlsNM9XVJHS23TwxVDrTuCh0kg
         uBV/uODhkoK5SsXDcJbJbSYv8nptL/bdD4C3kek+33/tEhNteCwnNVIo67Afi9raSEvr
         ubIRY6R7y3EOVTOoWecBbPaqIQ8abVU57mL30Jv1heCPHm0V6Ci3nwvHK0jnuayJr1S1
         jRJg==
X-Forwarded-Encrypted: i=1; AJvYcCVtD+LdzgnltKfQKagwmBMrayFtDtq4NLrS5H5pCP+FTxjsPuSv7ICSQRe7avV/3O3Ih9KFiW64lTCk4xlLanh1U/rmFAqavWrRIAS1
X-Gm-Message-State: AOJu0YzXjLfM/OD/PTFt2gDBVoTsQ+M2LfkxQi2QoI9cMaHy1Zt7Oe4j
	QmaBWWVLzTogPCfN9J5hevdd8JRDYAQ8OvvAkH61iO/6ziywn+3IQK2aeBDT+g==
X-Google-Smtp-Source: AGHT+IFWJPCmpq0DFcieDsuM0+aWSb9NMUBLcE0cIna9MhVfPCFPZ5c3x+pgfaV2fn4lU+Pr+8VKRg==
X-Received: by 2002:a17:903:32c4:b0:1f6:1f90:987a with SMTP id d9443c01a7336-1f636ffe77fmr169865145ad.3.1717516906396;
        Tue, 04 Jun 2024 09:01:46 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:45 -0700 (PDT)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v3 2/7] serial: qcom-geni: Fix the timeout in qcom_geni_serial_poll_bit()
Date: Tue,  4 Jun 2024 09:00:28 -0700
Message-ID: <20240604090028.v3.2.I3e1968bbeee67e28fd4e15509950805b6665484a@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604160123.2029413-1-dianders@chromium.org>
References: <20240604160123.2029413-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The qcom_geni_serial_poll_bit() is supposed to be able to be used to
poll a bit that's will become set when a TX transfer finishes. Because
of this it tries to set its timeout based on how long the UART will
take to shift out all of the queued bytes. There are two problems
here:
1. There appears to be a hidden extra word on the firmware side which
   is the word that the firmware has already taken out of the FIFO and
   is currently shifting out. We need to account for this.
2. The timeout calculation was assuming that it would only need 8 bits
   on the wire to shift out 1 byte. This isn't true. Typically 10 bits
   are used (8 data bits, 1 start and 1 stop bit), but as much as 13
   bits could be used (14 if we allowed 9 bits per byte, which we
   don't).

The too-short timeout was seen causing problems in a future patch
which more properly waited for bytes to transfer out of the UART
before cancelling.

Rather than fix the calculation, replace it with the core-provided
uart_fifo_timeout() function.

NOTE: during earlycon, uart_fifo_timeout() has the same limitations
about not being able to figure out the exact timeout that the old
function did. Luckily uart_fifo_timeout() returns the same default
timeout of 20ms in this case. We'll add a comment about it, though, to
make it more obvious what's happening.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Use uart_fifo_timeout() for timeout.

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 37 +++++++++++++--------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2bd25afe0d92..a48a15c2555e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -124,7 +124,6 @@ struct qcom_geni_serial_port {
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
 	bool setup;
-	unsigned int baud;
 	unsigned long clk_rate;
 	void *rx_buf;
 	u32 loopback;
@@ -269,24 +268,25 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 				int offset, int field, bool set)
 {
 	u32 reg;
-	struct qcom_geni_serial_port *port;
-	unsigned int baud;
-	unsigned int fifo_bits;
-	unsigned long timeout_us = 20000;
-	struct qcom_geni_private_data *private_data = uport->private_data;
+	unsigned long timeout_us;
 
-	if (private_data->drv) {
-		port = to_dev_port(uport);
-		baud = port->baud;
-		if (!baud)
-			baud = 115200;
-		fifo_bits = port->tx_fifo_depth * port->tx_fifo_width;
-		/*
-		 * Total polling iterations based on FIFO worth of bytes to be
-		 * sent at current baud. Add a little fluff to the wait.
-		 */
-		timeout_us = ((fifo_bits * USEC_PER_SEC) / baud) + 500;
-	}
+	/*
+	 * This function is used to poll bits, some of which (like CMD_DONE)
+	 * might take as long as it takes for the FIFO plus the temp register
+	 * on the geni side to drain. The Linux core calculates such a timeout
+	 * for us and we can get it from uart_fifo_timeout().
+	 *
+	 * It should be noted that during earlycon the variables that
+	 * uart_fifo_timeout() makes use of in "uport" may not be setup yet.
+	 * It's difficult to set things up for earlycon since it can't
+	 * necessarily figure out the baud rate and reading the FIFO depth
+	 * from the wrapper means some extra MMIO maps that we don't get by
+	 * default. This isn't a big problem, though, since uart_fifo_timeout()
+	 * gives back its "slop" of 20ms as a minimum and that should be
+	 * plenty of time for earlycon unless we're running at an extremely
+	 * low baud rate.
+	 */
+	timeout_us = jiffies_to_usecs(uart_fifo_timeout(uport));
 
 	/*
 	 * Use custom implementation instead of readl_poll_atomic since ktimer
@@ -1224,7 +1224,6 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	qcom_geni_serial_stop_rx(uport);
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 4000000);
-	port->baud = baud;
 
 	sampling_rate = UART_OVERSAMPLING;
 	/* Sampling rate is halved for IP versions >= 2.5 */
-- 
2.45.1.288.g0e0cd299f1-goog


