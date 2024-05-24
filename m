Return-Path: <linux-kernel+bounces-188664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F38CE515
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607F9282305
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFBB86266;
	Fri, 24 May 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FTgMsFpF"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8028563E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552774; cv=none; b=dAOCpu7uPup4Ktt/Nrpd2fAWmk0MEYjLYLQRUbd38eat4sIQtlzkzOD68mUnvtzKtqSY+RkKlzxu8dwS9c3gSxQkhvl16IEes8VGjIeHueByKIECPCnYHn6FNNXGCvh51a4eqH/GdGTIdiWaSmUPdxL7zQnmDdHtMfbMpFXThf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552774; c=relaxed/simple;
	bh=NLkcXVJfxaNj+x/ym/nlC1R/VqgX2dj3Yj+vQmBzw2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B1/jRaVJEzI/dVID/92Kj/O/ExHqKLkgHQrODz9HxuMAAJJ1qQIdCWPXKtfpGzBfOkPGRtQWbkmRium81E6Ls92vUcQUHjQUxc8QcINDzG1JkXLDy4iZ2dsM3fJPnR1Om0btYVzwxfnzs4q2/fW1nzUQkdX6xKJAMvpC0ocdIjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=FTgMsFpF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5296232e00bso852322e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1716552770; x=1717157570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/kQluXbrS5/xKa378gCLMmIP4qg7U9JjmWwPqCAy5U=;
        b=FTgMsFpF1DvO/gln29tbOWPTW5g9uqQBYj3XWJ2iJ7ZaeobKWoPGjoTMJUurG+OAvz
         HuoI4sjXMW+1DCuP0H4mu7mUlJPtflF+UYQWwWbj61ae/UUYn62SwlqXYwn4me4mBjd+
         CSqIeSIr9tp8OaANb96atjx75+zmwF06f7Cvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716552770; x=1717157570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/kQluXbrS5/xKa378gCLMmIP4qg7U9JjmWwPqCAy5U=;
        b=HAgzoauJdRY1Xtm50D6uykrh1o/RQSHm/RqOyTyv3cjqzFGqppHbDlelrKHpfOFGo8
         3MVi590+HC0pXwbTIcgbcDGeCVV1gBkRkv9zMU2VWZrXT7QVhk5tX85BvIJohltvp9xx
         znLL3O969cxjNNgltOE+bpY18n/oq0aEv2xzrg/ukrPpSRl7QK6loaekw7IgFOMWK/zE
         5htdQ00B1gG5yDkoM0D4CLc0BtU5U7nstVSvzgiN16if/g+4ymmtwhx827MQvp3qsgr3
         5oVdiZDdNAe+pgmkDv8Eroo2zbvbY9TFSU3/Ah1/722QCVSOl728lLMnWDzzkou22SBO
         c/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz4qgy0w6Mx83aKzE3Rou4pInqWzEmDGZmOq3if1RX5oPpvM6chFLqis6qXZhVowtTFDyTcN4VIucLmgxo5lHtnBvyZOWc8cQC7LFx
X-Gm-Message-State: AOJu0Yzsu0cMDy1z+/EddQRMURIdMPXDEiPjw3alvGe+NLQ55Oauu2tG
	1hRk6KsgvH9ljxhkXS6QmAiGtmwmErWbmIZ1NYTD5+7jp+U1sQdTwBPyzqtflFs=
X-Google-Smtp-Source: AGHT+IFDzskSYUTxKkoP6SCgQgAYltT2X4VJOr36ZAkA0ExwWVFTGCSdWPvOlsTH+ENT8Hvd6LU7KA==
X-Received: by 2002:a05:6512:10ca:b0:51c:b73f:950 with SMTP id 2adb3069b0e04-529661f315emr1807735e87.43.1716552769459;
        Fri, 24 May 2024 05:12:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970c3313fsm164559e87.200.2024.05.24.05.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 05:12:49 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: imx: ensure RTS signal is not left active after shutdown
Date: Fri, 24 May 2024 14:12:45 +0200
Message-Id: <20240524121246.1896651-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a process is killed while writing to a /dev/ttymxc* device in RS485
mode, we observe that the RTS signal is left high, thus making it
impossible for other devices to transmit anything.

Moreover, the ->tx_state variable is left in state SEND, which means
that when one next opens the device and configures baud rate etc., the
initialization code in imx_uart_set_termios dutifully ensures the RTS
pin is pulled down, but since ->tx_state is already SEND, the logic in
imx_uart_start_tx() does not in fact pull the pin high before
transmitting, so nothing actually gets on the wire on the other side
of the transceiver. Only when that transmission is allowed to complete
is the state machine then back in a consistent state.

This is completely reproducible by doing something as simple as

  seq 10000 > /dev/ttymxc0

and hitting ctrl-C, and watching with a logic analyzer.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

A screen dump from a logic analyzer can be seen at:

  https://ibb.co/xCcP7Jy

This is on an imx8mp board, with /dev/ttymxc0 and /dev/ttymxc2 both
configured for rs485 and connected to each other. I'm writing to
/dev/ttymxc2. This demonstrates both bugs; that RTS is left high when
a write is interrupted, and that a subsequent write actually fails to
have RTS high while TX'ing.

I'm not sure what commit to name as a Fixes:. This certainly happens
on 6.6 and onwards, but I assume the problem exists since the tx_state
machine was introduced in cb1a60923609 (serial: imx: implement rts
delaying for rs485), and possibly even before that.


 drivers/tty/serial/imx.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2eb22594960f..35a47f4ab6ed 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1551,6 +1551,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
 	u32 ucr1, ucr2, ucr4, uts;
+	int loops;
 
 	if (sport->dma_is_enabled) {
 		dmaengine_terminate_sync(sport->dma_chan_tx);
@@ -1613,6 +1614,55 @@ static void imx_uart_shutdown(struct uart_port *port)
 	ucr4 &= ~UCR4_TCEN;
 	imx_uart_writel(sport, ucr4, UCR4);
 
+	/*
+	 * We have to ensure the tx state machine ends up in OFF. This
+	 * is especially important for rs485 where we must not leave
+	 * the RTS signal high, blocking the bus indefinitely.
+	 *
+	 * All interrupts are now disabled, so imx_uart_stop_tx() will
+	 * no longer be called from imx_uart_transmit_buffer(). It may
+	 * still be called via the hrtimers, and if those are in play,
+	 * we have to honour the delays.
+	 */
+	if (sport->tx_state == WAIT_AFTER_RTS || sport->tx_state == SEND)
+		imx_uart_stop_tx(port);
+
+	/*
+	 * In many cases (rs232 mode, or if tx_state was
+	 * WAIT_AFTER_RTS, or if tx_state was SEND and there is no
+	 * delay_rts_after_send), this will have moved directly to
+	 * OFF. In rs485 mode, tx_state might already have been
+	 * WAIT_AFTER_SEND and the hrtimer thus already started, or
+	 * the above imx_uart_stop_tx() call could have started it. In
+	 * those cases, we have to wait for the hrtimer to fire and
+	 * complete the transition to OFF.
+	 */
+	loops = port->rs485.flags & SER_RS485_ENABLED ?
+		port->rs485.delay_rts_after_send : 0;
+	while (sport->tx_state != OFF && loops--) {
+		uart_port_unlock_irqrestore(&sport->port, flags);
+		msleep(1);
+		uart_port_lock_irqsave(&sport->port, &flags);
+	}
+
+	if (dev_WARN_ONCE(sport->port.dev, sport->tx_state != OFF,
+			  "unexpected tx_state %d\n", sport->tx_state)) {
+		/*
+		 * This machine may be busted, but ensure the RTS
+		 * signal is inactive in order not to block other
+		 * devices.
+		 */
+		if (port->rs485.flags & SER_RS485_ENABLED) {
+			ucr2 = imx_uart_readl(sport, UCR2);
+			if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+				imx_uart_rts_active(sport, &ucr2);
+			else
+				imx_uart_rts_inactive(sport, &ucr2);
+			imx_uart_writel(sport, ucr2, UCR2);
+		}
+		sport->tx_state = OFF;
+	}
+
 	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	clk_disable_unprepare(sport->clk_per);
-- 
2.40.1.1.g1c60b9335d


