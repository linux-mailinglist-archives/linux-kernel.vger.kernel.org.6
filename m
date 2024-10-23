Return-Path: <linux-kernel+bounces-377737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 635599AC346
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB968B24F71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61910194C89;
	Wed, 23 Oct 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0PZYVyA"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053E13D2BE;
	Wed, 23 Oct 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674923; cv=none; b=f0AUs/7jLhl4qRRsGcSF2gybfGRUHdw+WI8lGIuBFtgRK4XSSTIzJGDHdmf1NLd7A1no39rSpY3dYgb3nFjHCcri/jQs90loa1IpXjjWHDyptCwxsxt3fqOftcFOpgpFB48YGmDxJofdXNDCizaGV7q4SMP2fqc5MlS5sgnw2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674923; c=relaxed/simple;
	bh=K5SFh3QJNbK+421n8LZrnYzMvgiaMri/DMTIsejTOXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MEv1wDaHnnaqwlF5SiF/aRoPRRfJLiex7dSc4AuED05dAtkBOLqpgcWVQZjhvec/bzm86Kbe6UVoZ3pb5mh8JRG+2p16GdNjhPwdxnwyrtfeIxoGYrc8+Hay7YQzmKQqPiTjgcDaQaTelKP5o/LJpXwm7XTUYD0vno6I58sulkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0PZYVyA; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e6010a3bbfso2838079b6e.2;
        Wed, 23 Oct 2024 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729674921; x=1730279721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDPCBnT1kDnB7ATOCumf/lrJTWFSwVfmDd1LM2wc5lY=;
        b=V0PZYVyA2nnrWlnj6Cx2XtFn6SFpIUcA/c3R87Hh679tmg3XrKASiXF+qCM7nY2QTz
         7WkyIh6ycbXz2udIl4mgGV4ApwWxio2aZu1sCjEdT7hdqbZymNZVw4kWbLJmKa387bDa
         On14JsrqVFGPD+4wVuasHNa2ELgz6l7nQ3lHIxfbWet5BhqSgMHWCKlQAakvU+Yzldet
         Xl86VOhkBbKfGmZkempTd6w+OQ3t+NfX1v1Gt+gZabrpxSCEtxCj5g7VChE4D75dZrgN
         2s5xBOa425seXWLra4tuhrg6TwEYMX8hnMX/tzpedQvDxK2twdKS0+BZ+xMLMoFz03NH
         9OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674921; x=1730279721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDPCBnT1kDnB7ATOCumf/lrJTWFSwVfmDd1LM2wc5lY=;
        b=Bbq2JIQFVRnrr7juFXZxlEC/l5OZHL3IEaMG93qw+9n8Xif3j0GMVW96CDvKdManNQ
         1+956X2e17GTPbL/ViIWfkn4KeZnkXUotHR8I3jUSWAsHCidK2wfdrwZIuSFaUUQIwHG
         12czDndMZR24qYzfigz1OoDRC96mcs2sTN44IptkC0dziE1ZF1sVFEOvgynGWqErn3Uu
         N3kFAXtvhcdiAQ/vTKhE7sBmeiFYu6ZZ35+5cUO6KZcdbIVgOG5qGnKr7k5K5pBVE+KP
         vljENYt+FN5EHezIDCvgCtfLZfxPwti3rV7vhXpYF+xFzFL8o8jqkteWFH89qMGDgrPG
         rkcg==
X-Forwarded-Encrypted: i=1; AJvYcCUAAMlHofVxEufzSq4sa1OuFFmpPYbBD1mpciiIClXGJLW+vJ2Xl0gwJDDOd1Lihs1Yf4CHLlGJ3Tqf@vger.kernel.org, AJvYcCUcDjTEVXaQfatwu0BmGjInRBlkVvcHMHoiX7wtVvKfqiyZbYF7lhZFSCb89JhrkG2qlCk5NILWIKQMV30=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvkuuE2wJ2OjQKzpRT/zi4l4AwX2j4BOjIxyWZBTtatygPEXH
	EFmdYcq2kJ7NX1C/IDOrW1mQJZ/lKt5fLQhft1Z0aEphltn041QL
X-Google-Smtp-Source: AGHT+IET47yF1muGpa4utGgqIOzdVM4jfNyKigXTTusy6A1ZX6QySA5M+IebGmTdmteT9+WS0DG3lg==
X-Received: by 2002:a05:6808:229f:b0:3e6:27c6:352f with SMTP id 5614622812f47-3e627c63b7fmr654746b6e.4.1729674920856;
        Wed, 23 Oct 2024 02:15:20 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:5f03:e344:771b:b26a:7070:ea03])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab53749sm6359768a12.46.2024.10.23.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:15:20 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH] usb: serial: mos7840: Fix coding style warnings
Date: Wed, 23 Oct 2024 17:14:15 +0800
Message-Id: <20241023091414.18098-1-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fix the coding style warnings shown by checkpatch.pl

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 50 ++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index ca3da79af..2de5974d4 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -220,7 +220,7 @@ struct moschip_port {
 
 /*
  * mos7840_set_reg_sync
- * 	To set the Control register by calling usb_fill_control_urb function
+ *	To set the Control register by calling usb_fill_control_urb function
  *	by passing usb_sndctrlpipe function as parameter.
  */
 
@@ -228,8 +228,9 @@ static int mos7840_set_reg_sync(struct usb_serial_port *port, __u16 reg,
 				__u16 val)
 {
 	struct usb_device *dev = port->serial->dev;
+
 	val = val & 0x00ff;
-	dev_dbg(&port->dev, "mos7840_set_reg_sync offset is %x, value %x\n", reg, val);
+	dev_dbg(&port->dev, "%s offset is %x, value %x\n", __func__, reg, val);
 
 	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0), MCS_WRREQ,
 			       MCS_WR_RTYPE, val, reg, NULL, 0,
@@ -238,7 +239,7 @@ static int mos7840_set_reg_sync(struct usb_serial_port *port, __u16 reg,
 
 /*
  * mos7840_get_reg_sync
- * 	To set the Uart register by calling usb_fill_control_urb function by
+ *	To set the Uart register by calling usb_fill_control_urb function by
  *	passing usb_rcvctrlpipe function as parameter.
  */
 
@@ -280,9 +281,11 @@ static int mos7840_set_uart_reg(struct usb_serial_port *port, __u16 reg,
 {
 
 	struct usb_device *dev = port->serial->dev;
+
 	val = val & 0x00ff;
 	/* For the UART control registers, the application number need
-	   to be Or'ed */
+	 * to be Or'ed
+	 */
 	if (port->serial->num_ports == 2 && port->port_number != 0)
 		val |= ((__u16)port->port_number + 2) << 8;
 	else
@@ -448,6 +451,7 @@ static void mos7840_bulk_in_callback(struct urb *urb)
 
 	if (urb->actual_length) {
 		struct tty_port *tport = &mos7840_port->port->port;
+
 		tty_insert_flip_string(tport, data, urb->actual_length);
 		tty_flip_buffer_push(tport);
 		port->icount.rx += urb->actual_length;
@@ -742,6 +746,7 @@ static unsigned int mos7840_chars_in_buffer(struct tty_struct *tty)
 	for (i = 0; i < NUM_URBS; ++i) {
 		if (mos7840_port->busy[i]) {
 			struct urb *urb = mos7840_port->write_urb_pool[i];
+
 			chars += urb->transfer_buffer_length;
 		}
 	}
@@ -915,8 +920,8 @@ static int mos7840_write(struct tty_struct *tty, struct usb_serial_port *port,
 
 	if (status) {
 		mos7840_port->busy[i] = 0;
-		dev_err_console(port, "%s - usb_submit_urb(write bulk) failed "
-			"with status = %d\n", __func__, status);
+		dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
+			with status = %d\n", __func__, status);
 		bytes_sent = status;
 		goto exit;
 	}
@@ -943,6 +948,7 @@ static void mos7840_throttle(struct tty_struct *tty)
 	/* if we are implementing XON/XOFF, send the stop character */
 	if (I_IXOFF(tty)) {
 		unsigned char stop_char = STOP_CHAR(tty);
+
 		status = mos7840_write(tty, port, &stop_char, 1);
 		if (status <= 0)
 			return;
@@ -972,6 +978,7 @@ static void mos7840_unthrottle(struct tty_struct *tty)
 	/* if we are implementing XON/XOFF, send the start character */
 	if (I_IXOFF(tty)) {
 		unsigned char start_char = START_CHAR(tty);
+
 		status = mos7840_write(tty, port, &start_char, 1);
 		if (status <= 0)
 			return;
@@ -1194,7 +1201,7 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 {
 	struct usb_serial_port *port = mos7840_port->port;
 	int baud;
-	unsigned cflag;
+	unsigned int cflag;
 	__u8 lData;
 	__u8 lParity;
 	__u8 lStop;
@@ -1352,16 +1359,16 @@ static void mos7840_set_termios(struct tty_struct *tty,
 	}
 }
 
-/*****************************************************************************
+/*
  * mos7840_get_lsr_info - get line status register info
  *
  * Purpose: Let user call ioctl() to get info when the UART physically
- * 	    is emptied.  On bus types like RS485, the transmitter must
- * 	    release the bus after transmitting. This must be done when
- * 	    the transmit shift register is empty, not be done when the
- * 	    transmit holding register is empty.  This functionality
- * 	    allows an RS485 driver to be written in user space.
- *****************************************************************************/
+ *	is emptied.  On bus types like RS485, the transmitter must
+ *	release the bus after transmitting. This must be done when
+ *	the transmit shift register is empty, not be done when the
+ *	transmit holding register is empty.  This functionality
+ *	allows an RS485 driver to be written in user space.
+ */
 
 static int mos7840_get_lsr_info(struct tty_struct *tty,
 				unsigned int __user *value)
@@ -1540,7 +1547,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 	__u16 Data;
 
 	/* we set up the pointers to the endpoints in the mos7840_open *
-	 * function, as the structures aren't created yet.             */
+	 * function, as the structures aren't created yet.
+	 */
 
 	pnum = port->port_number;
 
@@ -1551,14 +1559,16 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 
 	/* Initialize all port interrupt end point to port 0 int
 	 * endpoint. Our device has only one interrupt end point
-	 * common to all port */
+	 * common to all port
+	 */
 
 	mos7840_port->port = port;
 	spin_lock_init(&mos7840_port->pool_lock);
 
 	/* minor is not initialised until later by
 	 * usb-serial.c:get_free_serial() and cannot therefore be used
-	 * to index device instances */
+	 * to index device instances
+	 */
 	mos7840_port->port_num = pnum + 1;
 	dev_dbg(&port->dev, "port->minor = %d\n", port->minor);
 	dev_dbg(&port->dev, "mos7840_port->port_num = %d\n", mos7840_port->port_num);
@@ -1591,7 +1601,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 		dev_dbg(&port->dev, "ControlReg Reading success val is %x, status%d\n", Data, status);
 	Data |= 0x08;	/* setting driver done bit */
 	Data |= 0x04;	/* sp1_bit to have cts change reflect in
-			   modem status reg */
+			 * modem status reg
+			 */
 
 	/* Data |= 0x20; //rx_disable bit */
 	status = mos7840_set_reg_sync(port,
@@ -1603,7 +1614,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 		dev_dbg(&port->dev, "ControlReg Writing success(rx_disable) status%d\n", status);
 
 	/* Write default values in DCR (i.e 0x01 in DCR0, 0x05 in DCR2
-	   and 0x24 in DCR3 */
+	 * and 0x24 in DCR3
+	 */
 	Data = 0x01;
 	status = mos7840_set_reg_sync(port,
 			(__u16) (mos7840_port->DcrRegOffset + 0), Data);
-- 
2.34.1


