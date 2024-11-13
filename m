Return-Path: <linux-kernel+bounces-408140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF119C7B92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590CFB2E02B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE53B204033;
	Wed, 13 Nov 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lodewillems.com header.i=@lodewillems.com header.b="FiJmoXtu"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E82038D4;
	Wed, 13 Nov 2024 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521913; cv=none; b=AR8qNwdHpzl1TPOc5TPLGveFcKgkGBvd4gPujEBdxfZB/LcyFoWhIBcAwLtfoj/G5k1L2gaHwm3KsfhWv5CLg3o6pQ0/cW5ctds2JYQV5OZTIZ8t83G9eooNH7VfX35pTGebVO7ffDwvM6CQPjlWJlH/UaeCJz1FNXOAI4PiMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521913; c=relaxed/simple;
	bh=rj2NLCwxfqX5S1Pk2cVGrE1lsmdAA+JKNUEah2kiwKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJR7IGxWNnMBKWr3L5Q+eDqyyav5tbjRv5yshX0ZT1AoU+TGX2yIPfBP2l6WXSpqPR0zAOJmPlPldxXENXOckY3aWuaBzuSwkaHJ97+4f1aknAnXdvmk58eG0kK4g9406Ab8kNHLlQKFDQuhU1I12GFcfQERMNc28QVkoUVBO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lodewillems.com; spf=pass smtp.mailfrom=lodewillems.com; dkim=pass (2048-bit key) header.d=lodewillems.com header.i=@lodewillems.com header.b=FiJmoXtu; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lodewillems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lodewillems.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XpWXh596yz9sdR;
	Wed, 13 Nov 2024 19:10:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lodewillems.com;
	s=MBO0001; t=1731521412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N7znE+uJkFhUaDn+LNG3BIj1Ldrazv+bL1n4aDjRP/c=;
	b=FiJmoXtuUYaeJCgGdfTqrOj7V+059o6PknX+NT8A2Z+gUizdUfKsEHagn3z3vq1dJLYpch
	gAus0lAkzq4naj0C8MsA3XYZVPedxl4wb+jgYPilWoId0mO/iAhGia6ftLfMKac6ey/qr8
	6baZ9MtbAuH6mQG0n/KGVr8kzh2ekuTCh+ZgRtGYcbyyWyQNjpWiAs+m/Davp6HSwJCvun
	4UKumkvCWqYyDWL4QHyYuIfQGRlYpFhL0lAYsJI6F5IEgsi2wtoLU6JYLScmTVdaaZEktP
	LF78XYqm3MYIpbpKKwG9Ro3TYl9sXj9t+wRN7LHH42WUtg1Z6R4C4T40l73lhA==
From: Lode Willems <me@lodewillems.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lode Willems <me@lodewillems.com>
Subject: [PATCH RESEND] USB: serial: CH341: add hardware flow control RTS/CTS
Date: Wed, 13 Nov 2024 19:08:27 +0100
Message-ID: <20241113180930.3741-1-me@lodewillems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for enabling and disabling
RTS/CTS hardware flow control.
Tested using a CH340E in combination with a CP2102.

Fixes part of the following bug report:
Link: https://bugzilla.kernel.org/show_bug.cgi?id=197109

Signed-off-by: Lode Willems <me@lodewillems.com>
---
 drivers/usb/serial/ch341.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index d10e4c4848a0..62237f657320 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -63,6 +63,7 @@
 #define CH341_REG_DIVISOR      0x13
 #define CH341_REG_LCR          0x18
 #define CH341_REG_LCR2         0x25
+#define CH341_REG_FLOW_CTL     0x27
 
 #define CH341_NBREAK_BITS      0x01
 
@@ -77,6 +78,9 @@
 #define CH341_LCR_CS6          0x01
 #define CH341_LCR_CS5          0x00
 
+#define CH341_FLOW_CTL_NONE    0x000
+#define CH341_FLOW_CTL_RTSCTS  0x101
+
 #define CH341_QUIRK_LIMITED_PRESCALER	BIT(0)
 #define CH341_QUIRK_SIMULATE_BREAK	BIT(1)
 
@@ -478,6 +482,41 @@ static int ch341_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return r;
 }
 
+static void ch341_set_flow_control(struct tty_struct *tty,
+				   struct usb_serial_port *port,
+				   const struct ktermios *old_termios)
+{
+	int r;
+
+	if (old_termios &&
+	    C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS))
+		return;
+
+	if (C_CRTSCTS(tty)) {
+		r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
+				      CH341_REG_FLOW_CTL |
+				      ((u16)CH341_REG_FLOW_CTL << 8),
+				      CH341_FLOW_CTL_RTSCTS);
+		if (r < 0) {
+			dev_err(&port->dev,
+				"%s - failed to enable flow control: %d\n",
+				__func__, r);
+			tty->termios.c_cflag &= ~CRTSCTS;
+		}
+	} else {
+		r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
+				      CH341_REG_FLOW_CTL |
+				      ((u16)CH341_REG_FLOW_CTL << 8),
+				      CH341_FLOW_CTL_NONE);
+		if (r < 0) {
+			dev_err(&port->dev,
+				"%s - failed to disable flow control: %d\n",
+				__func__, r);
+			tty->termios.c_cflag |= CRTSCTS;
+		}
+	}
+}
+
 /* Old_termios contains the original termios settings and
  * tty->termios contains the new setting to be used.
  */
@@ -546,6 +585,8 @@ static void ch341_set_termios(struct tty_struct *tty,
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	ch341_set_handshake(port->serial->dev, priv->mcr);
+
+	ch341_set_flow_control(tty, port, old_termios);
 }
 
 /*
-- 
2.47.0


