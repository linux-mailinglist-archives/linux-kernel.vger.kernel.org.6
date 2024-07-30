Return-Path: <linux-kernel+bounces-268134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF69420C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272C0B21C49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478A18CC1B;
	Tue, 30 Jul 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDJ0cQxz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52018CC09;
	Tue, 30 Jul 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368335; cv=none; b=NDfpU883s2xz2CtEjdNW+gQ7KDbemG73NZ/kqTGxg5ZYPf0yCjrEPZcurZWNwMt0LptXYMph+JPk6F1BRHKGAZ+1Xfk8maIz9vNmaOGhv3KYJL18LS6qr/J7bwc5pzECK6wVevKmSMjugEfJmDRLlXnjkGI0oa8UrqAwgcYMJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368335; c=relaxed/simple;
	bh=5lpKaUgX4LewI+2gJzXQuBzlVZD7Vurrl6h6fEr9DDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UHtdDjcXYz4d+X4juCIykxv404jwXCK0adGJdF6sbGBs06QyogR9z75h8sS2MGeo7Em7hWXYaikcIkbCOKv/n2WPk/EMDCRgVvrNq3TG5QcWNBRVXnqmXJ3a0xI48PXfp49yjiLgs3qC7WHJel1w1j/xaY6odHSJlZmn9/xK8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDJ0cQxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50248C4AF0F;
	Tue, 30 Jul 2024 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722368335;
	bh=5lpKaUgX4LewI+2gJzXQuBzlVZD7Vurrl6h6fEr9DDs=;
	h=From:To:Cc:Subject:Date:From;
	b=MDJ0cQxz//BRJPcyL0nrwk9o6pH0odNZ2Bz/RvGfk8pwZq4b91O3Q2DOZ8B5tJ9Ve
	 YIUFkbUBz44fXGfe9cSNX7638tkrsmZ0UUV/Fx+UG2JAY3AJ0JTjdp2k+hezcnNTh8
	 nuXiGUbgaXRAqNqCW3LAsg8tX7TuEgKNQVRdPpUmEG59hDLTUssTws7Zr7wvSzSor9
	 R/ha4if0Z0Xi14R9Wyn1jVptQyAczsc5fsGZYOMa1RI5sSn9/kwwJGJFM9VrWCpKk8
	 nUBSpcb0H1TMd7uo0w+S2AXuYa+cP7J6ovgyufMqZ55WjMGF+FDPE1iMVY2QD8B6g4
	 Q/kjMuNSYpXxw==
From: Michael Walle <mwalle@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] usb: gadget: u_serial: add .get_icount() support
Date: Tue, 30 Jul 2024 21:38:40 +0200
Message-Id: <20240730193840.2580358-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add icount support for the transmitting and receiving characters. This
will make the tty LED trigger work with the ttyGS devices.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/usb/gadget/function/u_serial.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index eec7f7a2e40f..bbc5f7617a13 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -28,6 +28,7 @@
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
 #include <linux/kfifo.h>
+#include <linux/serial.h>
 
 #include "u_serial.h"
 
@@ -126,6 +127,7 @@ struct gs_port {
 	wait_queue_head_t	close_wait;
 	bool			suspended;	/* port suspended */
 	bool			start_delayed;	/* delay start when suspended */
+	struct async_icount	icount;
 
 	/* REVISIT this state ... */
 	struct usb_cdc_line_coding port_line_coding;	/* 8-N-1 etc */
@@ -257,6 +259,7 @@ __acquires(&port->port_lock)
 			break;
 		}
 		do_tty_wake = true;
+		port->icount.tx += len;
 
 		req->length = len;
 		list_del(&req->list);
@@ -408,6 +411,7 @@ static void gs_rx_push(struct work_struct *work)
 				size -= n;
 			}
 
+			port->icount.rx += size;
 			count = tty_insert_flip_string(&port->port, packet,
 					size);
 			if (count)
@@ -851,6 +855,23 @@ static int gs_break_ctl(struct tty_struct *tty, int duration)
 	return status;
 }
 
+static int gs_get_icount(struct tty_struct *tty,
+			 struct serial_icounter_struct *icount)
+{
+	struct gs_port *port = tty->driver_data;
+	struct async_icount cnow;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->port_lock, flags);
+	cnow = port->icount;
+	spin_unlock_irqrestore(&port->port_lock, flags);
+
+	icount->rx = cnow.rx;
+	icount->tx = cnow.tx;
+
+	return 0;
+}
+
 static const struct tty_operations gs_tty_ops = {
 	.open =			gs_open,
 	.close =		gs_close,
@@ -861,6 +882,7 @@ static const struct tty_operations gs_tty_ops = {
 	.chars_in_buffer =	gs_chars_in_buffer,
 	.unthrottle =		gs_unthrottle,
 	.break_ctl =		gs_break_ctl,
+	.get_icount =		gs_get_icount,
 };
 
 /*-------------------------------------------------------------------------*/
-- 
2.39.2


