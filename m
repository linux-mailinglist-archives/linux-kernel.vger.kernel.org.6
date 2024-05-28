Return-Path: <linux-kernel+bounces-192024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F88D1763
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661C2284E25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D76E611;
	Tue, 28 May 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YIe8z07T"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FC169384
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889230; cv=none; b=iCjnOWwcvBH+OnZi98dmZ85t5+5QtyTCnb6hV1009znjR7p9/u12HCiLkesyKQIkreOntZxcufIlZG1OlDZi7fUzXSPqEVJaAzCugrjdePhSENU05A/v4bYflZnhoHvwa8vRdtMyWsIcSICur+oo07uhNj3pecreVrP+w5wZkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889230; c=relaxed/simple;
	bh=UTgk+S/ntlj4DJ7vOuWu5jP7Xc1+VOJ8hpm+1blQCDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJEm+Aaix+IwLmGuuUZhOxLMb92y1yy7k8yDdKOFTAlRJDfbB+abEzYHrUXFJwX3oeVXvHkoy43KYij+bmnoqkETSAZNzuwDCuZww24ShoDv1VW1NqIY9Ft6lzM1t1D+yK6SDz6i0GufGB87WKJurjDMN4dZcy/KN2zox1uRjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=YIe8z07T; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e974862b00so5970321fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1716889225; x=1717494025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsAir5s7syPxi7Z0jM8CWLgds717Ko20mRWI7Xd9NB8=;
        b=YIe8z07TmlB+ky4JwkuFOOfyh1XrbcY+I0WVbDO6pKph8yOYHBLpuSZuK4t6see4kl
         YvJXQoAyymRb2KkogFGyC/uAXSvflej5DSS0CL3L5TJMK4KNJLCrwJlw2LDsM373md3h
         vhJro7rWMwBi+kz/nsi7CYYtWyyUHKK0twXbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889225; x=1717494025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsAir5s7syPxi7Z0jM8CWLgds717Ko20mRWI7Xd9NB8=;
        b=emk9McICsOph54C4/7CeSltrCc+dOgQLioHx//rQlhL0RVKzpSnXXDhm3C24Ujw+3w
         XJgB6a4xOh/LwvXEgRBfYdycKcLqOog0BmA7XL0/L77hyCsWfIB708nxuVfa0uFiCACX
         gwV+vFOnF+bsv1gazkZMttp884t9wCabRCZP9frUmh3UBFrWckmhDqZwr4b4C4YumBdM
         kKfoH67cp2lg/iXS9U2boFiAlkVIUQHYwBu/O1eZgcDr0FLNDkYOGFEjFu570jKEUXfG
         GDGv6m3BnxLZfdbMJ7cYqqzuZeuO8FilHsIyB0yQG4GD2GZtOxaQso1584L28NwzOTIp
         vTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfXQl7pichQ4wIrCFL8Ve+YG5wKxao4LJG2ck2WE+9dWBummsrdsuVGd3cCwlpqEq5c6w6I1VIR5dQUpRBbLzkyGF0EPMEJnzRQtEA
X-Gm-Message-State: AOJu0YwjDQE3OOhXQH5WYydD9jbwzflloaZek0/Rcb3YiHTljhv7Wsci
	r3gkpMlMR5rilp1C/zB6qgpjID4brUFcNSro2FkiPvARdSQawmklHbrCUvh5asw=
X-Google-Smtp-Source: AGHT+IFRC5F+uRTEEAgRzPfgYmsVebb6vhnBeks8C4kTfMuV2pHXNUEYaRTsAAyEYxXGPFioV6UrSg==
X-Received: by 2002:a2e:3003:0:b0:2dc:e69a:fdbc with SMTP id 38308e7fff4ca-2e95b0702bemr72083601fa.1.1716889225287;
        Tue, 28 May 2024 02:40:25 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e98c6bc515sm55821fa.67.2024.05.28.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:40:24 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: imx: stop casting struct uart_port to struct imx_port
Date: Tue, 28 May 2024 11:40:21 +0200
Message-Id: <20240528094022.2161066-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct imx_port does have a struct uart_port as its first member, so
the current code works, but it is not how kernel code is usually
written.

Similar to many other serial drivers, introduce and use a
to_imx_port() helper based on container_of(). No functional change.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/imx.c | 41 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2eb22594960f..f5cfe5571e0e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -264,6 +264,11 @@ static const struct of_device_id imx_uart_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
 
+static inline struct imx_port *to_imx_port(struct uart_port *port)
+{
+        return container_of(port, struct imx_port, port);
+}
+
 static inline void imx_uart_writel(struct imx_port *sport, u32 val, u32 offset)
 {
 	writel(val, sport->port.membase + offset);
@@ -377,7 +382,7 @@ static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	unsigned int ucr1, ucr2;
 
 	ucr1 = imx_uart_readl(sport, UCR1);
@@ -401,7 +406,7 @@ static void imx_uart_start_rx(struct uart_port *port)
 /* called with port.lock taken and irqs off */
 static void imx_uart_stop_tx(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	u32 ucr1, ucr4, usr2;
 
 	if (sport->tx_state == OFF)
@@ -466,7 +471,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
 
 static void imx_uart_stop_rx_with_loopback_ctrl(struct uart_port *port, bool loopback)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	u32 ucr1, ucr2, ucr4, uts;
 
 	ucr1 = imx_uart_readl(sport, UCR1);
@@ -511,7 +516,7 @@ static void imx_uart_stop_rx(struct uart_port *port)
 /* called with port.lock taken and irqs off */
 static void imx_uart_enable_ms(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 
 	mod_timer(&sport->timer, jiffies);
 
@@ -662,7 +667,7 @@ static void imx_uart_dma_tx(struct imx_port *sport)
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_tx(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	struct tty_port *tport = &sport->port.state->port;
 	u32 ucr1;
 
@@ -1043,7 +1048,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
  */
 static unsigned int imx_uart_tx_empty(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	unsigned int ret;
 
 	ret = (imx_uart_readl(sport, USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0;
@@ -1058,7 +1063,7 @@ static unsigned int imx_uart_tx_empty(struct uart_port *port)
 /* called with port.lock taken and irqs off */
 static unsigned int imx_uart_get_mctrl(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	unsigned int ret = imx_uart_get_hwmctrl(sport);
 
 	mctrl_gpio_get(sport->gpios, &ret);
@@ -1069,7 +1074,7 @@ static unsigned int imx_uart_get_mctrl(struct uart_port *port)
 /* called with port.lock taken and irqs off */
 static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	u32 ucr3, uts;
 
 	if (!(port->rs485.flags & SER_RS485_ENABLED)) {
@@ -1112,7 +1117,7 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
  */
 static void imx_uart_break_ctl(struct uart_port *port, int break_state)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	unsigned long flags;
 	u32 ucr1;
 
@@ -1434,7 +1439,7 @@ static void imx_uart_disable_dma(struct imx_port *sport)
 
 static int imx_uart_startup(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	int retval;
 	unsigned long flags;
 	int dma_is_inited = 0;
@@ -1548,7 +1553,7 @@ static int imx_uart_startup(struct uart_port *port)
 
 static void imx_uart_shutdown(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	unsigned long flags;
 	u32 ucr1, ucr2, ucr4, uts;
 
@@ -1622,7 +1627,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 /* called with port.lock taken and irqs off */
 static void imx_uart_flush_buffer(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	struct scatterlist *sgl = &sport->tx_sgl[0];
 
 	if (!sport->dma_chan_tx)
@@ -1649,7 +1654,7 @@ static void
 imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		     const struct ktermios *old)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	unsigned long flags;
 	u32 ucr2, old_ucr2, ufcr;
 	unsigned int baud, quot;
@@ -1852,7 +1857,7 @@ imx_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 static int imx_uart_poll_init(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	unsigned long flags;
 	u32 ucr1, ucr2;
 	int retval;
@@ -1901,7 +1906,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 
 static int imx_uart_poll_get_char(struct uart_port *port)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	if (!(imx_uart_readl(sport, USR2) & USR2_RDR))
 		return NO_POLL_CHAR;
 
@@ -1910,7 +1915,7 @@ static int imx_uart_poll_get_char(struct uart_port *port)
 
 static void imx_uart_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	unsigned int status;
 
 	/* drain */
@@ -1932,7 +1937,7 @@ static void imx_uart_poll_put_char(struct uart_port *port, unsigned char c)
 static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termios,
 				 struct serial_rs485 *rs485conf)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 	u32 ucr2;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
@@ -1986,7 +1991,7 @@ static struct imx_port *imx_uart_ports[UART_NR];
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
-	struct imx_port *sport = (struct imx_port *)port;
+	struct imx_port *sport = to_imx_port(port);
 
 	while (imx_uart_readl(sport, imx_uart_uts_reg(sport)) & UTS_TXFULL)
 		barrier();
-- 
2.40.1.1.g1c60b9335d


