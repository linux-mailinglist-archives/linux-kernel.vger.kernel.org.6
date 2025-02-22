Return-Path: <linux-kernel+bounces-527374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CBA40A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0883BD21E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195A82063FF;
	Sat, 22 Feb 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRBeJFzf"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0917B1FF7AD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243508; cv=none; b=qQZ6a5xiNrzCi+af1TboqIQ7IBj28+pAt+3NPOscssfGPG7AwCYsy9qiT2awiFlTDpjrUlhLKYYwLYmJbcYUomFUprVDG3190/UnkQ9aMwTSeOY0GY1Z1K3AKXcEa4mRJS0GXOCJ6vTBH/yu4zUHBfmKUQNwJ4HQQxeYjySWzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243508; c=relaxed/simple;
	bh=9cXDSDnENp4H/HLN2Zyn294tvtZmp1yTNglarYDJNTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4aZ+CDCcA095WkNPk70gNcMYQe90lyXOtTj6iNMV0ImrMK5eSy1gU/HJRd533LIvKsahVJ5oxpykMEl37fNrIyZUG0qS11OaPa20vXxOcrbomoXYMs3oHJu9zVYSL283bOr1qehKmtQRaHGGm/jNtJ8Q2/FS1TxsW7ptsHbA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRBeJFzf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f406e9f80so2836888f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740243504; x=1740848304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElKpJZjs0Rhr1JGVDOup4onv4KFiTndyT/JONx2XSVs=;
        b=aRBeJFzfh4A9oxlNOJwZz4EY3HJ1LAlhrwZYHqOFH11C+xJJdLr5j/F9A02FWA6ljx
         J3KUE9etg90WuR1cusc3BurvAU2dSXDMVn8Irx1dCiw5ptZvhc8mazLqJ+inJBDjetAu
         C/G6o+A+bHlDiVKdqQOZIUYd3YfLG8dBLtH3KKYeEr09zBA7sBM7x0hxD5jOBbJPdyD7
         dNFg5ziXlScZzKW1NFJx4uWqBncOYVPgn3yY4KOkt24YUqTbnWp9xG4lWyCbNCCL3ibH
         rrnYpTiVxMrAr8hI7FdwzG4YjxI8mVoQt7cKsUKdtw1yEaAa6CRmrrqo2WFl25v4iWj3
         jQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740243504; x=1740848304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElKpJZjs0Rhr1JGVDOup4onv4KFiTndyT/JONx2XSVs=;
        b=LZutazhSRZMUDcNmOhH5uHe6CmPesNBlZe4Efed/J/wcTjbBNkITi6tFJlUI9vV9rO
         FuXEyWHbihK/ZYav3HoWtCGwypWuk/vuV4U2Mwoz21uPaVraI4VKXp/P5tta/ugUNi/F
         VcDxQzJtwDP5QMguMcfkmUiEApggv9977UOBKCScjIJO93ndA0/C9wBig7ecE9Y+2Hop
         p/iNerMN1eFsJBr3fgk62T3wMt/KXsxzgf+I6dXFcN25WvJ1+t1JC1X0yHz6eu/wJpQT
         UECTJqAtqux2JcPuUxxUN2GzJ9wYIyr9GUK3rPomp5w6zStPcOdjs/bZnvKWe0RgNmvm
         c76g==
X-Forwarded-Encrypted: i=1; AJvYcCUbWXSKNg++zrt1pnFi1zttqWBBE7i/lzKpFFubdeOxuV6mIDeF1ro3xwuy0j/Kib2Ho0m7wQuDQ+QeBFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68lZcaX1SGDlKXoo0O+1wOJ7hf5CV1tV3/CBDpfG6iZX9G4E7
	wdbjyXC8S2g/TZ889oi1RIGtvbOFJflir+uNBqvEJ0owzVlk/dI+
X-Gm-Gg: ASbGncunGl/J7qfpoCeuap0A8dfl9HvHKzIMnt5maTJr/vZFmRIXbi38Qd2l74ic4+k
	SIMoZASVlj3sO1TcNAOGmf6CHqoCmOuRsSWPftuamFFc5K0vb6HNjOZooR2T1hnn+OXYCZpSLeH
	ZY7GLASSWueh7DTrA//uZRCJSNpzdnMaF4fo5eel+2jLG4jkgk2TuEWMZ1Clvy2HwWs9BzUYL9h
	Cq67BvNNELoxOflT04yhSgeisx0e2LV67wjd/U/zTuPIGJtV4k8UrFtKm+QuFtcDGYGilrTTf7A
	Vm+0nyGL8Bf501PkGDrqncOicjtt8SD7JmMPNDpM0j+iXYgUH+3AgE6mjQrlZA==
X-Google-Smtp-Source: AGHT+IFCSFYw/2mRx1r87C5MsrNtcWT7m25gwWIdkfn3/dfr17YyWGtrO5oqJd9Q90hWyrTjy7eXvA==
X-Received: by 2002:a05:6000:144e:b0:38f:2b54:58dd with SMTP id ffacd0b85a97d-38f6e95ef77mr6748962f8f.21.1740243504025;
        Sat, 22 Feb 2025 08:58:24 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f69b3ca41sm7002796f8f.27.2025.02.22.08.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:58:23 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] staging: gpib: Fix Oops after disconnect in ni_usb
Date: Sat, 22 Feb 2025 17:58:17 +0100
Message-ID: <20250222165817.12856-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the usb dongle is disconnected subsequent calls to the
driver cause a NULL dereference Oops as the bus_interface
is set to NULL on disconnect.

This problem was introduced by setting usb_dev from the bus_interface
for dev_xxx messages.

Previously bus_interface was checked for NULL only in the the functions
directly calling usb_fill_bulk_urb or usb_control_msg.

Check for valid bus_interface on all interface entry points
and return -ENODEV if it is NULL.

Fixes: 4934b98bb243 ("staging: gpib: Update messaging and usb_device refs in ni_usb")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 93 ++++++++++++++++++-----
 1 file changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 61b15b19e134..62fbc78204ce 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -591,7 +591,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval, parse_retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	int in_data_length;
@@ -604,8 +604,11 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	struct ni_usb_register reg;
 
 	*bytes_read = 0;
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
 	if (length > max_read_length)
 		return -EINVAL;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -718,7 +721,7 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -728,9 +731,11 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	struct ni_usb_status_block status;
 	static const int max_write_length = 0xffff;
 
-	*bytes_written = 0;
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
 	if (length > max_write_length)
 		return -EINVAL;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data_length = length + 0x10;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
@@ -819,7 +824,7 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -831,8 +836,11 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 	static const int max_command_length = 0x10;
 
 	*command_bytes_written = 0;
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
 	if (length > max_command_length)
 		length = max_command_length;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data_length = length + 0x10;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
@@ -925,7 +933,7 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -933,6 +941,9 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 	int i = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -983,7 +994,7 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -991,6 +1002,9 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 	int i = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1039,11 +1053,14 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[4];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	if (request_control) {
 		writes[i].device = NIUSB_SUBDEV_TNT4882;
 		writes[i].address = CMDR;
@@ -1087,7 +1104,7 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -1095,7 +1112,10 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 	int i = 0;
 	struct ni_usb_status_block status;
 
-	// FIXME: we are going to pulse when assert is true, and ignore otherwise
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+// FIXME: we are going to pulse when assert is true, and ignore otherwise
 	if (assert == 0)
 		return;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
@@ -1133,10 +1153,13 @@ static void ni_usb_remote_enable(gpib_board_t *board, int enable)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct ni_usb_register reg;
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	reg.device = NIUSB_SUBDEV_TNT4882;
 	reg.address = nec7210_to_tnt4882_offset(AUXMR);
 	if (enable)
@@ -1180,11 +1203,14 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	static const int buffer_length = 8;
 	u8 *buffer;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	buffer = kmalloc(buffer_length, GFP_KERNEL);
 	if (!buffer)
 		return board->status;
@@ -1232,11 +1258,14 @@ static int ni_usb_primary_address(gpib_board_t *board, unsigned int address)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[2];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(ADR);
 	writes[i].value = address;
@@ -1287,11 +1316,14 @@ static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, i
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[3];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	i += ni_usb_write_sad(writes, address, enable);
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
@@ -1306,7 +1338,7 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -1315,6 +1347,9 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 	int j = 0;
 	struct ni_usb_status_block status;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1358,11 +1393,14 @@ static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(AUXMR);
 	writes[i].value = PPR | config;
@@ -1380,11 +1418,14 @@ static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(AUXMR);
 	if (ist)
@@ -1405,11 +1446,14 @@ static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(SPMR);
 	writes[i].value = status;
@@ -1432,11 +1476,14 @@ static void ni_usb_return_to_local(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
 
+	if (!ni_priv->bus_interface)
+		return; // -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	writes[i].device = NIUSB_SUBDEV_TNT4882;
 	writes[i].address = nec7210_to_tnt4882_offset(AUXMR);
 	writes[i].value = AUX_RTL;
@@ -1454,7 +1501,7 @@ static int ni_usb_line_status(const gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	static const int  in_data_length = 0x20;
@@ -1464,6 +1511,9 @@ static int ni_usb_line_status(const gpib_board_t *board)
 	int line_status = ValidALL;
 	// NI windows driver reads 0xd(HSSEL), 0xc (ARD0), 0x1f (BSR)
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1570,12 +1620,15 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct ni_usb_register writes[3];
 	unsigned int ibsta;
 	unsigned int actual_ns;
 	int i;
 
+	if (!ni_priv->bus_interface)
+		return -ENODEV;
+	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	i = ni_usb_setup_t1_delay(writes, nano_sec, &actual_ns);
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-- 
2.48.1


