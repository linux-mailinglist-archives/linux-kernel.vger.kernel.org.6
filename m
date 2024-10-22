Return-Path: <linux-kernel+bounces-375756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC189A9A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156D51F22CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185914D2A7;
	Tue, 22 Oct 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHL2140y"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1956450EE;
	Tue, 22 Oct 2024 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580561; cv=none; b=qY6CAgtMPrQFP5W5HEo8BnOpjMfZokH5fd0YP+hFOprI91+t12dnsmz+3FOByxn9UA4em6aq/Fhrne1koI7+5oLjmWTSVVIzcOPTgBWnqDjeni8I3kdJCksf4NE/KZIpi6RjG4SoVMd72DTcVCuOeXEx9w2UlQUTiVzXTcNYQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580561; c=relaxed/simple;
	bh=YrEQcx+aJDhMk4a59FJVVWmHWXLsHjHmBfjhyJcnUdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sR052XTg6QpS8Mn1D4afg/BZcxPMg2fKNikoOlEq0NmSiknWkIAMmsCr6ut6RZdacuEEuv/aJ4tkc2wswol8C7AbwcxGNl2GlIjtn/DLhFt54qkdj/7WeN9vriU7ak4mKA2nYmUcYG+wiHApLZJjjzKolU2jMbPlzqGEseBGJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHL2140y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso4034452b3a.0;
        Tue, 22 Oct 2024 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729580559; x=1730185359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wt3Zk0ySZ7Vr9pBPcVdVsRMbrRuG+XiuG9Q5Chqr7KE=;
        b=cHL2140yTf11FgWhvRXSj9qvMRU1Tzu0+2+5gm7wuRTVIfYHf0hbcYHIRve3lU+gBe
         zlXrPVl96guxPKx8Bz3Fp4WFJc7PmZOweC4ZNk8rlkCU7wyybYnUsiP6RoNJULQY+35D
         78KMjLErJJCz5L7Wd4mRfRMSO01+GrY6Yv8zPxPXkJ80xsbiEBmGe8ky/R+ZhWSSlvm9
         6iwtOw11CzIPpHLvhN942d23wxTtDLrrUcbN+5zMWp5kc8BKTsx0rCsSuIPuYT/HSdoW
         iYLfx8L/p8+jiFiw5PTuE57HBkNjlFfLwCTsrlXezgsYXr3DLfO+GbHJ/SQRuVhAUxA/
         ykaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580559; x=1730185359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wt3Zk0ySZ7Vr9pBPcVdVsRMbrRuG+XiuG9Q5Chqr7KE=;
        b=ud2yomvHLv3TqU5Qk2ZUGdFOeFe8W/uQarS0fgqcGYhzQzzSKOWrcoVLnRfzACxdFJ
         W05Y5RPuVwKTfkLg/BhGJiGGtHPm/BuJ7xEyNrVHGGiofG2TcAuDbEZp3DLqNqaf1Loj
         dhlXOpi4Pv9wcHVbVABDd18jyqeai3fX9ciCioz6P7maH72l0qUsxzNbmw/W71DT5x1P
         l0sjKFzb/Wd6v76AhuBpcSerkkFx7G91nsOvbKPv1M8KdhZ/luKiX9VSMr3EEdumfzCI
         d8TXGEdIMebhBcb8HELtv+bpaUsBplhNqX4p7xqSShtdVPC9kRbGQTNWnY21nQ8+21R0
         JxsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyd1Wgus0NXnUN0v4vTS7MdskyWhzwdbpjW8B55rSXlcUjHBCLYKe5M7WdArLCAudRScC/n0CYaSWObLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvlhXcgAy9O/oKAYH70S6rH1DiQNNsHICmHcxv6liHwkjZc2E
	CHFh43Go4OqtBLiyDNpZMMd9QHCbGTzj4pJ2lMe1k6q8mD5c7Ype4WSoZxSN6fc=
X-Google-Smtp-Source: AGHT+IHCYmwE828eIOTW0k4tonyB9j00P5yP18LfM1gkRnl3biyjBrZ7SCiV/K+ixRKlsHqFdoFPjA==
X-Received: by 2002:a05:6a00:2302:b0:71d:fd28:70a3 with SMTP id d2e1a72fcca58-71ea331cf9emr20292457b3a.24.1729580558677;
        Tue, 22 Oct 2024 00:02:38 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:5f03:e344:fc14:f963:5d41:9c55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312c84sm4028187b3a.6.2024.10.22.00.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:02:38 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH] usb: serial: mos7840: Add more kinds of baud rate
Date: Tue, 22 Oct 2024 15:01:28 +0800
Message-Id: <20241022070127.66083-1-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds more kinds of baud rate support.
also fix all the coding style errors & warnings shown by /scripts/checkpatch.pl

The mos7840 hardware had several clock source which can be selected from registers below.
1. Clk_Select_Reg: 30M, 96M, External Clock
2. SP_Reg[6:4]: 1.846M, 3.692M, 4.615M, 7.384M, 12.923M, 14.769M, 24M, 48M
and the maximum boudrate can be set to 6Mbits with 96M clock source.

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 323 +++++++++++++++++++++++++++++++----
 1 file changed, 288 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index ca3da79af..3ced3d4e5 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -144,6 +144,10 @@
 
 #define SERIAL_LCR_DLAB            ((__u16)(0x0080))
 
+#define CLOCK_SELECT_REG1          ((__u16)(0x13))
+#define CLOCK_SELECT_REG2          ((__u16)(0x14))
+
+
 /*
  * URB POOL related defines
  */
@@ -173,6 +177,7 @@ static const struct usb_device_id id_table[] = {
 	{ MCS_DEVICE(0x9710, 0x7820, MCS_PORTS(2)) },	/* MosChip MCS7820 */
 	{ MCS_DEVICE(0x9710, 0x7840, MCS_PORTS(4)) },	/* MosChip MCS7840 */
 	{ MCS_DEVICE(0x9710, 0x7843, MCS_PORTS(3)) },	/* ASIX MCS7840 3 port */
+	{ MCS_DEVICE(0x9710, 0x7841, MCS_PORTS(4)) },	/* ASIX MCS7840 4 port */
 	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_2) },
 	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_2P) },
 	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_4) },
@@ -220,16 +225,17 @@ struct moschip_port {
 
 /*
  * mos7840_set_reg_sync
- * 	To set the Control register by calling usb_fill_control_urb function
- *	by passing usb_sndctrlpipe function as parameter.
+ *  To set the Control register by calling usb_fill_control_urb function
+ *  by passing usb_sndctrlpipe function as parameter.
  */
 
 static int mos7840_set_reg_sync(struct usb_serial_port *port, __u16 reg,
 				__u16 val)
 {
 	struct usb_device *dev = port->serial->dev;
+
 	val = val & 0x00ff;
-	dev_dbg(&port->dev, "mos7840_set_reg_sync offset is %x, value %x\n", reg, val);
+	dev_dbg(&port->dev, "%s offset is %x, value %x\n", __func__, reg, val);
 
 	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0), MCS_WRREQ,
 			       MCS_WR_RTYPE, val, reg, NULL, 0,
@@ -238,8 +244,8 @@ static int mos7840_set_reg_sync(struct usb_serial_port *port, __u16 reg,
 
 /*
  * mos7840_get_reg_sync
- * 	To set the Uart register by calling usb_fill_control_urb function by
- *	passing usb_rcvctrlpipe function as parameter.
+ *  To set the Uart register by calling usb_fill_control_urb function by
+ *  passing usb_rcvctrlpipe function as parameter.
  */
 
 static int mos7840_get_reg_sync(struct usb_serial_port *port, __u16 reg,
@@ -278,11 +284,12 @@ static int mos7840_get_reg_sync(struct usb_serial_port *port, __u16 reg,
 static int mos7840_set_uart_reg(struct usb_serial_port *port, __u16 reg,
 				__u16 val)
 {
-
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
@@ -448,6 +455,7 @@ static void mos7840_bulk_in_callback(struct urb *urb)
 
 	if (urb->actual_length) {
 		struct tty_port *tport = &mos7840_port->port->port;
+
 		tty_insert_flip_string(tport, data, urb->actual_length);
 		tty_flip_buffer_push(tport);
 		port->icount.rx += urb->actual_length;
@@ -742,6 +750,7 @@ static unsigned int mos7840_chars_in_buffer(struct tty_struct *tty)
 	for (i = 0; i < NUM_URBS; ++i) {
 		if (mos7840_port->busy[i]) {
 			struct urb *urb = mos7840_port->write_urb_pool[i];
+
 			chars += urb->transfer_buffer_length;
 		}
 	}
@@ -915,8 +924,9 @@ static int mos7840_write(struct tty_struct *tty, struct usb_serial_port *port,
 
 	if (status) {
 		mos7840_port->busy[i] = 0;
-		dev_err_console(port, "%s - usb_submit_urb(write bulk) failed "
-			"with status = %d\n", __func__, status);
+		dev_err_console(port,
+			"%s - usb_submit_urb(write bulk) failed with status = %d\n",
+			__func__, status);
 		bytes_sent = status;
 		goto exit;
 	}
@@ -943,6 +953,7 @@ static void mos7840_throttle(struct tty_struct *tty)
 	/* if we are implementing XON/XOFF, send the stop character */
 	if (I_IXOFF(tty)) {
 		unsigned char stop_char = STOP_CHAR(tty);
+
 		status = mos7840_write(tty, port, &stop_char, 1);
 		if (status <= 0)
 			return;
@@ -972,6 +983,7 @@ static void mos7840_unthrottle(struct tty_struct *tty)
 	/* if we are implementing XON/XOFF, send the start character */
 	if (I_IXOFF(tty)) {
 		unsigned char start_char = START_CHAR(tty);
+
 		status = mos7840_write(tty, port, &start_char, 1);
 		if (status <= 0)
 			return;
@@ -1060,11 +1072,147 @@ static int mos7840_calc_baud_rate_divisor(struct usb_serial_port *port,
 {
 	dev_dbg(&port->dev, "%s - %d\n", __func__, baudRate);
 
-	if (baudRate <= 115200) {
+	// divisor = (256*DLM)+DLL
+	// baudrate = InputCLK/(16*Divisor)
+	if (baudRate == 50) {
+		*divisor = (256*0x09)+0x04; // DLM=0x09, DLL=0x04
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 75) {
+		*divisor = (256*0x06)+0x02; // DLM=0x06, DLL=0x02
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 110) {
+		*divisor = (256*0x04)+0x19; // DLM=0x04, DLL=0x19
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 134) {
+		*divisor = (256*0x03)+0x5d; // DLM=0x03, DLL=0x5d
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 150) {
+		*divisor = (256*0x03)+0x01; // DLM=0x03, DLL=0x01
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 300) {
+		*divisor = (256*0x01)+0x81; // DLM=0x01, DLL=0x81
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 600) {
+		*divisor = 0xc0;		// DLM=0, DLL=0xc0
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 1200) {
+		*divisor = 0x60;		// DLM=0, DLL=0x60
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 1800) {
+		*divisor = 0x40;		// DLM=0, DLL=0x40
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 2400) {
+		*divisor = 0x30;		// DLM=0, DLL=0x30
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 4800) {
+		*divisor = 0x18;		// DLM=0, DLL=0x18
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 7200) {
+		*divisor = 0x10;		// DLM=0, DLL=0x10
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 9600) {
+		*divisor = 0x0c;		// DLM=0, DLL=0x0c
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 14400) {
+		*divisor = 0x08;		// DLM=0, DLL=0x08
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 19200) {
+		*divisor = 0x06;		// DLM=0, DLL=0x06
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 28800) {
+		*divisor = 0x04;		// DLM=0, DLL=0x04
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 38400) {
+		*divisor = 0x03;		// DLM=0, DLL=0x03
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 57600) {
+		*divisor = 0x02;		// DLM=0, DLL=0x02
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 115200) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 230400) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x10;	// clock source = 3.692307692M
+	} else if (baudRate == 460800) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x30;	// clock source = 7.384615384M
+	} else if (baudRate == 806400) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x40;	// clock source = 12.923076922M
+	} else if (baudRate == 921600) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x50;	// clock source = 14.769230768M
+	} else if (baudRate == 25000) {
+		*divisor = 0x78;		// DLM=0, DLL=0x78
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 50000) {
+		*divisor = 0x3c;		// DLM=0, DLL=0x3c
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 75000) {
+		*divisor = 0x28;		// DLM=0, DLL=0x28
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 100000) {
+		*divisor = 0x1e;		// DLM=0, DLL=0x1e
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 250000) {
+		*divisor = 0x0c;		// DLM=0, DLL=0x0c
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 300000) {
+		*divisor = 0x0a;		// DLM=0, DLL=0x0a
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 500000) {
+		*divisor = 0x06;		// DLM=0, DLL=0x06
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 600000) {
+		*divisor = 0x05;		// DLM=0, DLL=0x05
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 1000000) {
+		*divisor = 0x03;		// DLM=0, DLL=0x03
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 3000000) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x70;	// clock source=48M
+
+	} else if (baudRate == 1500000) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x60;	// clock source=24M
+
+	/* below are using 96M or 30M clock source
+	 * will determine the clock source later
+	 * in function mos7840_send_cmd_write_baud_rate
+	 */
+	} else if (baudRate == 6000000) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+	} else if (baudRate == 2000000) {
+		*divisor = 0x03;		// DLM=0, DLL=0x03
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+	} else if (baudRate == 403200) {
+		*divisor = 0x0f;		// DLM=0, DLL=0x0f
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+	} else if (baudRate == 225000) {
+		*divisor = 0x1b;		// DLM=0, DLL=0x1b
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+	} else if (baudRate == 153600) {
+		*divisor = 0x27;		// DLM=0, DLL=0x27
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 96M
+
+	} else if (baudRate == 10000) {
+		*divisor = 0xbb;		// DLM=0, DLL=0xbb
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 30M
+	} else if (baudRate == 125000) {
+		*divisor = 0x0f;		// DLM=0, DLL=0x0f
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 30M
+	} else if (baudRate == 625000) {
+		*divisor = 0x03;		// DLM=0, DLL=0x03
+		*clk_sel_val = 0x80;	// DUMMY val, clock source = 30M
+
+
+	} else if (baudRate <= 115200) {
 		*divisor = 115200 / baudRate;
 		*clk_sel_val = 0x0;
-	}
-	if ((baudRate > 115200) && (baudRate <= 230400)) {
+	} else if ((baudRate > 115200) && (baudRate <= 230400)) {
 		*divisor = 230400 / baudRate;
 		*clk_sel_val = 0x10;
 	} else if ((baudRate > 230400) && (baudRate <= 403200)) {
@@ -1085,6 +1233,9 @@ static int mos7840_calc_baud_rate_divisor(struct usb_serial_port *port,
 	} else if ((baudRate > 1572864) && (baudRate <= 3145728)) {
 		*divisor = 3145728 / baudRate;
 		*clk_sel_val = 0x70;
+	} else {
+		dev_dbg(&port->dev, "func: %s -baudrate %d not supported.\n", __func__, baudRate);
+		return -1;
 	}
 	return 0;
 }
@@ -1135,24 +1286,122 @@ static int mos7840_send_cmd_write_baud_rate(struct moschip_port *mos7840_port,
 
 	}
 
-	if (1) {		/* baudRate <= 115200) */
+	if (1) {
 		clk_sel_val = 0x0;
 		Data = 0x0;
 		status = mos7840_calc_baud_rate_divisor(port, baudRate, &divisor,
-						   &clk_sel_val);
-		status = mos7840_get_reg_sync(port, mos7840_port->SpRegOffset,
-								 &Data);
+					   &clk_sel_val);
 		if (status < 0) {
-			dev_dbg(&port->dev, "reading spreg failed in set_serial_baud\n");
+			dev_dbg(&port->dev, "mos7840_calc_baud_rate_divisor failed in set_serial_baud\n");
 			return -1;
 		}
-		Data = (Data & 0x8f) | clk_sel_val;
-		status = mos7840_set_reg_sync(port, mos7840_port->SpRegOffset,
-								Data);
-		if (status < 0) {
-			dev_dbg(&port->dev, "Writing spreg failed in set_serial_baud\n");
-			return -1;
+
+		/* Write clk_sel_val to SP_Reg or Clk_Select_Reg*/
+		// check clk_sel_val before setting the clk_sel_val
+		if (clk_sel_val == 0x80) { // clk_sel_val is DUMMY value -> Write the corresponding value to Clk_Select_Reg
+			// 0x01:30M, 0x02:96M, 0x05:External Clock
+			if (baudRate == 125000 || baudRate == 625000 || baudRate == 10000) {
+				clk_sel_val = 0x01;
+			} else if (baudRate == 153600 || baudRate == 225000 || baudRate == 403200 ||
+					baudRate == 2000000 || baudRate == 6000000) {
+				clk_sel_val = 0x02;
+			} else {
+				clk_sel_val = 0x05; // externel clk for custom case.
+			}
+
+			// needs to set clock source through Clk_Select_Reg1(offset 0x13) & Clk_Select_Reg2(offset 0x14)
+			// Clk_Select_Reg1 for port1,2		Clk_Select_Reg2 for port3,4
+			if (mos7840_port->port_num <= 2) {
+				status = mos7840_get_reg_sync(port, CLOCK_SELECT_REG1, &Data);
+				if (status < 0) {
+					dev_dbg(&port->dev, "reading Clk_Select_Reg failed in set_serial_baud\n");
+					return -1;
+				}
+				if (mos7840_port->port_num == 1) {
+					Data = (Data & 0xf8) | clk_sel_val;
+					status = mos7840_set_reg_sync(port, CLOCK_SELECT_REG1, Data);
+				} else if (mos7840_port->port_num == 2) {
+					Data = (Data & 0xc7) | (clk_sel_val<<3);
+					status = mos7840_set_reg_sync(port, CLOCK_SELECT_REG1, Data);
+				}
+				if (status < 0) {
+					dev_dbg(&port->dev, "setting Clk_Select_Reg failed\n");
+					return -1;
+				}
+			} else if (mos7840_port->port_num <= 4) {
+				status = mos7840_get_reg_sync(port, CLOCK_SELECT_REG2, &Data);
+				if (status < 0) {
+					dev_dbg(&port->dev, "reading Clk_Select_Reg failed in set_serial_baud\n");
+					return -1;
+				}
+				if (mos7840_port->port_num == 3) {
+					Data = (Data & 0xf8) | clk_sel_val;
+					status = mos7840_set_reg_sync(port, CLOCK_SELECT_REG2, Data);
+				} else if (mos7840_port->port_num == 4) {
+					Data = (Data & 0xc7) | (clk_sel_val<<3);
+					status = mos7840_set_reg_sync(port, CLOCK_SELECT_REG2, Data);
+				}
+				if (status < 0) {
+					dev_dbg(&port->dev, "setting Clk_Select_Reg failed\n");
+					return -1;
+				}
+			}
+		} else { 
+			// needs to set default value to Clk_Select_Reg
+			// Clk_Select_Reg1 for port1,2		Clk_Select_Reg2 for port3,4
+			if (mos7840_port->port_num <= 2) {
+				status = mos7840_get_reg_sync(port, CLOCK_SELECT_REG1, &Data);
+				if (status < 0) {
+					dev_dbg(&port->dev, "reading Clk_Select_Reg failed in set_serial_baud\n");
+					return -1;
+				}
+				if (mos7840_port->port_num == 1) {
+					Data = (Data & 0xf8) | 0x00;
+					status = mos7840_set_reg_sync(port, CLOCK_SELECT_REG1, Data);
+				} else if (mos7840_port->port_num == 2) {
+					Data = (Data & 0xc7) | (0x00<<3);
+					status = mos7840_set_reg_sync(port, CLOCK_SELECT_REG1, Data);
+				}
+				if (status < 0) {
+					dev_dbg(&port->dev, "setting Clk_Select_Reg failed\n");
+					return -1;
+				}
+			} else if (mos7840_port->port_num <= 4) {
+				status = mos7840_get_reg_sync(port, CLOCK_SELECT_REG2, &Data);
+				if (status < 0) {
+					dev_dbg(&port->dev, "reading Clk_Select_Reg failed in set_serial_baud\n");
+					return -1;
+				}
+				if (mos7840_port->port_num == 3) {
+					Data = (Data & 0xf8) | 0x00;
+					status = mos7840_set_reg_sync(port, CLOCK_SELECT_REG2, Data);
+				} else if (mos7840_port->port_num == 4) {
+					Data = (Data & 0xc7) | (0x00<<3);
+					status = mos7840_set_reg_sync(port, CLOCK_SELECT_REG2, Data);
+				}
+				if (status < 0) {
+					dev_dbg(&port->dev, "setting Clk_Select_Reg failed\n");
+					return -1;
+				}
+			}
+			// select clock source by writing clk_sel_val to SPx_Reg
+			status = mos7840_get_reg_sync(port, mos7840_port->SpRegOffset,
+									 &Data);
+			if (status < 0) {
+				dev_dbg(&port->dev, "reading spreg failed in set_serial_baud\n");
+				return -1;
+			}
+			Data = (Data & 0x8f) | clk_sel_val;
+			status = mos7840_set_reg_sync(port, mos7840_port->SpRegOffset,
+									Data);
+			if (status < 0) {
+				dev_dbg(&port->dev, "Writing spreg failed in set_serial_baud\n");
+				return -1;
+			}
 		}
+////.....................................................
+
+
 		/* Calculate the Divisor */
 
 		if (status) {
@@ -1194,7 +1443,7 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 {
 	struct usb_serial_port *port = mos7840_port->port;
 	int baud;
-	unsigned cflag;
+	unsigned int cflag;
 	__u8 lData;
 	__u8 lParity;
 	__u8 lStop;
@@ -1356,11 +1605,11 @@ static void mos7840_set_termios(struct tty_struct *tty,
  * mos7840_get_lsr_info - get line status register info
  *
  * Purpose: Let user call ioctl() to get info when the UART physically
- * 	    is emptied.  On bus types like RS485, the transmitter must
- * 	    release the bus after transmitting. This must be done when
- * 	    the transmit shift register is empty, not be done when the
- * 	    transmit holding register is empty.  This functionality
- * 	    allows an RS485 driver to be written in user space.
+ *    is emptied.  On bus types like RS485, the transmitter must
+ *    release the bus after transmitting. This must be done when
+ *    the transmit shift register is empty, not be done when the
+ *    transmit holding register is empty.  This functionality
+ *    allows an RS485 driver to be written in user space.
  *****************************************************************************/
 
 static int mos7840_get_lsr_info(struct tty_struct *tty,
@@ -1539,8 +1788,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 	int pnum;
 	__u16 Data;
 
-	/* we set up the pointers to the endpoints in the mos7840_open *
-	 * function, as the structures aren't created yet.             */
+	/* we set up the pointers to the endpoints in the mos7840_open */
+	/* function, as the structures aren't created yet.             */
 
 	pnum = port->port_number;
 
@@ -1551,14 +1800,16 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 
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
@@ -1591,7 +1842,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 		dev_dbg(&port->dev, "ControlReg Reading success val is %x, status%d\n", Data, status);
 	Data |= 0x08;	/* setting driver done bit */
 	Data |= 0x04;	/* sp1_bit to have cts change reflect in
-			   modem status reg */
+					 * modem status reg
+					 */
 
 	/* Data |= 0x20; //rx_disable bit */
 	status = mos7840_set_reg_sync(port,
@@ -1603,7 +1855,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
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


