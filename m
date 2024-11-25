Return-Path: <linux-kernel+bounces-420971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD869D84F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33B92856DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0411199FBB;
	Mon, 25 Nov 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dUnZUxij"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62719645D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535950; cv=none; b=jZdHWud/BPsWjFqTv9kJ9pq09csOpeDbHDNeQsEWHIJCCOjwaODjlPhk+8GjFT8vl5pndmFCMWmjMtW6Gimqt7VcxMfJLz4awi+IQI3Q7xP313Je5BfEVXb16QeCV/QgnrPMvlJjh4hDGeSPYjwhY3yPhbv1GOMflrHGIc8NK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535950; c=relaxed/simple;
	bh=Nqj89ZYUKmsbGkLtnnKcQvhP2tYl+KP8++ciMLWTUf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utkT3UVM5tHnBO+fNDwopohkfmrFkPU8zjcUJTo1jKxXQRkyzyJkdkXqC7o3hDMDbnrLuWOGpNaWaFDztjNxzbPRLLvET8+QGoli6tpBdjdIS9q9xQkIW1tKFRi3nyz4vVfl+t/O7a2a+6tp3Fc1cl6DptJHzuVXZQ9TveWi9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dUnZUxij; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43169902057so38341635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732535945; x=1733140745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvTqih4zuDxpRIabgMXl7QO1Llp9lafNLgIxNa0SNLQ=;
        b=dUnZUxijDEgCGZL9qxR/U5h3Wt9CbukI+wBnX0/xmU6m7TrK6Wj+a5DWv+nx3b1Ase
         k/chRXTYhiUsOJLnFWsimG23ugvjj/POx52Y64XrbnemT0pIxrBBsytIpE+Wucgg/kgG
         bwEcC9oGbovQ1ofJR5BIuNt2hZGa78Kv3ONe0xTY6XFePkcttn73rb9DMC6+FVPm6USv
         /p/qxnBO09E7mFX9N1gPvjeHtI3k6sjY+kwaB95Z2MDETRrqe7RjmmrBor0T8VBpVWOq
         7EPaYV01w/Csx8oSVKLwDG++QwpXMvog3qCe+G2UdCjdEsAFz9hjhg5t4baQEm45eK+3
         PFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732535945; x=1733140745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvTqih4zuDxpRIabgMXl7QO1Llp9lafNLgIxNa0SNLQ=;
        b=cYNCbduMiBEP+0rBNrs2mte0Y7iZ5G9eSvDQNbGbPxcEoZOHTSt8Qtmmya4NdceOYH
         GUnK2x/zQh12vhZsf16o00eBAiuRebkzcoyYioEny41HOfb375Bfgz1SLlHcR5heKX2V
         TEGFSCBlY6ZtROQEJTrcCpoq8CMxy20EMOKB5DnBYqsYhEXxnjn7r4ySKHVwoaqnoo5s
         VKZeEV9c78tlFNpTIKm8MD2mlxgZLVTA48Kk26ysjmj5nrTZlmnfOEP/Vy0LCpc/CUlA
         DPDJS1Q4HQRAeb4aNyjTRkcIeW/F99m8ZNy2UD+ZAOuZ/ulHmPeeoX1VXvnc/STzl1aO
         CxoQ==
X-Gm-Message-State: AOJu0YxmBqDEKqrUZ3cOWVK+J7ARQS+ppLIh8VYxXdZFpTdU/NwzfITy
	sMtIsUvyhBWV0p6vCXM5U45aVWXf7xLujlH53VF9GAq5UlXOPq67Vtd/1uGZcyk=
X-Gm-Gg: ASbGncsnNuvdO1FFzUd2HvXn6VTXYT/SpaSgwSpGmoakY419ePnHY72+MzkzQsgmvhx
	wqjVnTnEmxdRUDYHKY8kFdEGa582vkWIIu31CWhfu78M9qGN9BSxd5XhUqy6oVLFXRJzgg+8xw9
	ncmRd6xMKolvNomXCiIfv/9mguK2DCO9b2OaF4Z8yS72Z1E5daAYQE8OWZmC6YBhzuyxmDblVX0
	xwISi+3BqZD1UQxwGC/85DFIUzHeWfrw+JWfYpjuJxmPbQE6hfDUNBhuk2Q2j/W+ID/fDjMhbfJ
	tBo=
X-Google-Smtp-Source: AGHT+IERI7AZlN3KrYfCNnJKk/X3paLDn8H+fVm0RkY5gq03QR61gDdmNk5OamtVv2fyVuPTYoynqg==
X-Received: by 2002:a05:600c:1381:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-433ce4ab0a0mr92338485e9.22.1732535945185;
        Mon, 25 Nov 2024 03:59:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm10459677f8f.1.2024.11.25.03.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:59:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	g.liakhovetski@gmx.de,
	lethal@linux-sh.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Mon, 25 Nov 2024 13:58:56 +0200
Message-Id: <20241125115856.513642-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the Renesas RZ/G3S, when doing suspend to RAM, the uart_suspend_port()
is called. The uart_suspend_port() calls 3 times the
struct uart_port::ops::tx_empty() before shutting down the port.

According to the documentation, the struct uart_port::ops::tx_empty()
API tests whether the transmitter FIFO and shifter for the port is
empty.

The Renesas RZ/G3S SCIFA IP reports the number of data units stored in the
transmit FIFO through the FDR (FIFO Data Count Register). The data units
in the FIFOs are written in the shift register and transmitted from there.
The TEND bit in the Serial Status Register reports if the data was
transmitted from the shift register.

In the previous code, in the tx_empty() API implemented by the sh-sci
driver, it is considered that the TX is empty if the hardware reports the
TEND bit set and the number of data units in the FIFO is zero.

According to the HW manual, the TEND bit has the following meaning:

0: Transmission is in the waiting state or in progress.
1: Transmission is completed.

It has been noticed that when opening the serial device w/o using it and
then switch to a power saving mode, the tx_empty() call in the
uart_port_suspend() function fails, leading to the "Unable to drain
transmitter" message being printed on the console. This is because the
TEND=0 if nothing has been transmitted and the FIFOs are empty. As the
TEND=0 has double meaning (waiting state, in progress) we can't
determined the scenario described above.

Add a software workaround for this. This sets a variable if any data has
been sent on the serial console (when using PIO) or if the DMA callback has
been called (meaning something has been transmitted). In the tx_empty()
API the status of the DMA transaction is also checked and if it is
completed or in progress the code falls back in checking the hardware
registers instead of relying on the software variable.

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Patch was initially part of series at [1].

Changes since [1]:
- checked the s->chan_tx validity in sci_dma_check_tx_occurred()


[1] https://lore.kernel.org/all/20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/tty/serial/sh-sci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 136e0c257af1..680f0203fda4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -157,6 +157,7 @@ struct sci_port {
 
 	bool has_rtscts;
 	bool autorts;
+	bool tx_occurred;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -850,6 +851,7 @@ static void sci_transmit_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
 	unsigned int stopped = uart_tx_stopped(port);
+	struct sci_port *s = to_sci_port(port);
 	unsigned short status;
 	unsigned short ctrl;
 	int count;
@@ -885,6 +887,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		}
 
 		sci_serial_out(port, SCxTDR, c);
+		s->tx_occurred = true;
 
 		port->icount.tx++;
 	} while (--count > 0);
@@ -1241,6 +1244,8 @@ static void sci_dma_tx_complete(void *arg)
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	s->tx_occurred = true;
+
 	if (!kfifo_is_empty(&tport->xmit_fifo)) {
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
@@ -1731,6 +1736,19 @@ static void sci_flush_buffer(struct uart_port *port)
 		s->cookie_tx = -EINVAL;
 	}
 }
+
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	if (!s->chan_tx)
+		return;
+
+	status = dmaengine_tx_status(s->chan_tx, s->cookie_tx, &state);
+	if (status == DMA_COMPLETE || status == DMA_IN_PROGRESS)
+		s->tx_occurred = true;
+}
 #else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
@@ -1740,6 +1758,10 @@ static inline void sci_free_dma(struct uart_port *port)
 {
 }
 
+static void sci_dma_check_tx_occurred(struct sci_port *s)
+{
+}
+
 #define sci_flush_buffer	NULL
 #endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
@@ -2076,6 +2098,12 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 {
 	unsigned short status = sci_serial_in(port, SCxSR);
 	unsigned short in_tx_fifo = sci_txfill(port);
+	struct sci_port *s = to_sci_port(port);
+
+	sci_dma_check_tx_occurred(s);
+
+	if (!s->tx_occurred)
+		return TIOCSER_TEMT;
 
 	return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT : 0;
 }
@@ -2247,6 +2275,7 @@ static int sci_startup(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	s->tx_occurred = false;
 	sci_request_dma(port);
 
 	ret = sci_request_irq(s);
-- 
2.39.2


