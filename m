Return-Path: <linux-kernel+bounces-568890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5891EA69BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3861188E938
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2434A222584;
	Wed, 19 Mar 2025 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="CqWGGp59"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CD21A453
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421598; cv=none; b=C4Mf27QACZKQ942+blEL4xQp3gZ3Gq1OIhXprs+2/2nB/mXAyvuibTIbdK0Au1NhXKqMQ/lQTZ+kUJ8rPR2+TRRtFzc0tjOZ5hyu1PWqhZqfwBsxJAJ2yGyayQ85RvGJHG3yKkgdM2nAbdS/jS3MjP4xUqrIs2IA9zEZTtJXtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421598; c=relaxed/simple;
	bh=K9XEcDg3hFUt+pgsnVKVSSxsUV1vpFe8NvGNg5vUA8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixZqC8zA7ZoJFWjsui3CLZGQxZfbgCyOCE1PjH9/YwsktibkEJRwOkAChhwZbmtTOTW798ZBssoQYbRBILb3k0gHdKA5TbqUM7XxyX8iYDecXTjFV+NPT9q9XzU7ZpTmtkqDBUYqbztrSOBLkDu2HETzZ0tA/7zfI71KRD0KbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=CqWGGp59; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-226185948ffso1114735ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421596; x=1743026396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yfNRF3mQsaB00u+qKr9nR2gyjzf9iruSXW29YkGkzo=;
        b=CqWGGp59TinA+C4AHxNZIKTs/yaEA1V2t9h11B4wb8jtl1L+n7MI4M+deAHm6lOLmW
         VeA3QjTjmTuy0ZLKObeklhozjVvuPxQWqYdo067kpREIgg3qp+b9YO/NslctjQj1+1mP
         SyPIbxcYeiCV9ROiGhzkEzEIfcYhoHh/BK9jmqUv/g8LUGiq9QyC6nQE9PZdyYUI1RLb
         7OkLSgV3BEj7rtI/OSEaQZhr2uitI2OODpJOwXfe75SZA1Xl1Lmkm+HJsOpw6v1mKyHh
         NHOHVm4S3EhENUqQ3l09kUl6TA67oj0J9tfS1XZjr+5lAgPGpoSEX2g11SC7RjEVdmXy
         +aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421596; x=1743026396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yfNRF3mQsaB00u+qKr9nR2gyjzf9iruSXW29YkGkzo=;
        b=Kss8eLlIeIWSIyUJazZGBoCFeUzzSOmq31Io52hAY+uaYnSXvZIrhSMETKHl0R3KoT
         kJSKDFGrI5awnTeES/8h9Kr95MsJgIk+NK1HyqNAhB6DzQnk28VxYA3GUntubZ/5vvkE
         mOq2/Ckg2j0B/JnUjJGX68Wtyh41ADGrrI3d8IDPFByFw4c2hzZxmBSnOr5Lq4FYm6X5
         zuQ49zN6B5XqgnreRpTol3VHRAqv2wq+DgrLwvrmCI5sNqarkBW5LTPi6/es6R/X8QQ/
         pZq8DLmgpJOcwN56UU3VjqBeX4e2cFn9XM+qx6kNC9tbi0jOhFgLO9aUMqyQBKgQQglE
         Jatw==
X-Forwarded-Encrypted: i=1; AJvYcCXbLA0/pMMpikJ8MS/CSWHx08MFW0qNRJmZrFizsHxVWfUFTy2BGdByFfyXaFLqgnWzqXQsKP661yAx9Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5FBnTS7JN+HEjceOCH26mXa3GUQl99NmvhKwqMrQTGYJcYmb
	3hieDC60mzHsBwVo+10B4hxkz+lCZF5hz/kgJHpgw1MExUYn5lC3zhW7j1Aoyg==
X-Gm-Gg: ASbGnctTmxQBjCGIaQJ0M0pyCWPx/1KiXzbSbmThXId1P9lvTpx1fYRYj6DcUHIUvm5
	aSvtmAKnySaNTkZTcmZf/XftRsmwfaxrgblO+yaggTL3IWf8NUX9jEH1lMAkz+4SKfgy8C4MJl+
	EIPAJQPUsdMeJ+tcp8ajexr2CDyQcj35ULc9FksQB/u3tYNm6lM4I87qiDbfqbNZMjQQ+XumYxu
	dU7rBy0rVi1rE5QvmAJc9rfwX/yzbHAWVJWPcpZ7Ag2G0WeaHSu0fNrkPasNw4YGb9gDxm8IUAt
	CmiZMqmoOsU5bx+mjpULh1Jv/n66bEKttiYGQ43FsuZ7n96gcCHQEf8oljikcy3sL2t5z2HKwlf
	8EkNWimDM5Xgic4BH0RHN
X-Google-Smtp-Source: AGHT+IHJAmkOQVHJEvYU1V5eaB5TXQD28ZTaEAxRa6QR0hq7JP7erp4VdnpMG0oIBzYFAPpuG6LTbA==
X-Received: by 2002:a05:6a00:2d95:b0:736:51a6:78b1 with SMTP id d2e1a72fcca58-7376d62b6b0mr6549394b3a.11.1742421595717;
        Wed, 19 Mar 2025 14:59:55 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e69sm12615549b3a.141.2025.03.19.14.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:55 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 15/20] staging: gpib: ni_usb_gpib: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:19 +0000
Message-ID: <20250319215924.19387-16-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319215924.19387-1-matchstick@neverthere.org>
References: <20250319215924.19387-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using Linux code style for struct gpib_board.

Adhering to Linux code style.

In general, a pointer, or a struct that has elements that can reasonably be
directly accessed should never be a typedef.

Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 70 +++++++++++------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 1f72abe9f2e4..2da5a580c6cc 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -24,7 +24,7 @@ MODULE_DESCRIPTION("GPIB driver for National Instruments USB devices");
 static struct usb_interface *ni_usb_driver_interfaces[MAX_NUM_NI_USB_INTERFACES];
 
 static int ni_usb_parse_status_block(const u8 *buffer, struct ni_usb_status_block *status);
-static int ni_usb_set_interrupt_monitor(gpib_board_t *board, unsigned int monitored_bits);
+static int ni_usb_set_interrupt_monitor(struct gpib_board *board, unsigned int monitored_bits);
 static void ni_usb_stop(struct ni_usb_priv *ni_priv);
 
 static DEFINE_MUTEX(ni_usb_hotplug_lock);
@@ -310,7 +310,7 @@ static int ni_usb_receive_control_msg(struct ni_usb_priv *ni_priv, __u8 request,
 	return retval;
 }
 
-static void ni_usb_soft_update_status(gpib_board_t *board, unsigned int ni_usb_ibsta,
+static void ni_usb_soft_update_status(struct gpib_board *board, unsigned int ni_usb_ibsta,
 				      unsigned int clear_mask)
 {
 	static const unsigned int ni_usb_ibsta_mask = SRQI | ATN | CIC | REM | LACS | TACS | LOK;
@@ -586,7 +586,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 }
 
 // interface functions
-static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int ni_usb_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 		       int *end, size_t *bytes_read)
 {
 	int retval, parse_retval;
@@ -713,7 +713,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return retval;
 }
 
-static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int ni_usb_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 			int send_eoi, size_t *bytes_written)
 {
 	int retval;
@@ -814,7 +814,7 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return retval;
 }
 
-static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int ni_usb_command_chunk(struct gpib_board *board, uint8_t *buffer, size_t length,
 				size_t *command_bytes_written)
 {
 	int retval;
@@ -904,7 +904,7 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 	return 0;
 }
 
-static int ni_usb_command(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int ni_usb_command(struct gpib_board *board, uint8_t *buffer, size_t length,
 			  size_t *bytes_written)
 {
 	size_t count;
@@ -921,7 +921,7 @@ static int ni_usb_command(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return 0;
 }
 
-static int ni_usb_take_control(gpib_board_t *board, int synchronous)
+static int ni_usb_take_control(struct gpib_board *board, int synchronous)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -979,7 +979,7 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 	return retval;
 }
 
-static int ni_usb_go_to_standby(gpib_board_t *board)
+static int ni_usb_go_to_standby(struct gpib_board *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1035,7 +1035,7 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 	return 0;
 }
 
-static void ni_usb_request_system_control(gpib_board_t *board, int request_control)
+static void ni_usb_request_system_control(struct gpib_board *board, int request_control)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1083,7 +1083,7 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 }
 
 //FIXME maybe the interface should have a "pulse interface clear" function that can return an error?
-static void ni_usb_interface_clear(gpib_board_t *board, int assert)
+static void ni_usb_interface_clear(struct gpib_board *board, int assert)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1129,7 +1129,7 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 	ni_usb_soft_update_status(board, status.ibsta, 0);
 }
 
-static void ni_usb_remote_enable(gpib_board_t *board, int enable)
+static void ni_usb_remote_enable(struct gpib_board *board, int enable)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1153,7 +1153,7 @@ static void ni_usb_remote_enable(gpib_board_t *board, int enable)
 	return;// 0;
 }
 
-static int ni_usb_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int ni_usb_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct ni_usb_priv *ni_priv = board->private_data;
 
@@ -1166,7 +1166,7 @@ static int ni_usb_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_
 	return 0;
 }
 
-static void ni_usb_disable_eos(gpib_board_t *board)
+static void ni_usb_disable_eos(struct gpib_board *board)
 {
 	struct ni_usb_priv *ni_priv = board->private_data;
 	/* adapter gets unhappy if you don't zero all the bits
@@ -1176,7 +1176,7 @@ static void ni_usb_disable_eos(gpib_board_t *board)
 	ni_priv->eos_char = 0;
 }
 
-static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int ni_usb_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1228,7 +1228,7 @@ static void ni_usb_stop(struct ni_usb_priv *ni_priv)
 	kfree(buffer);
 }
 
-static int ni_usb_primary_address(gpib_board_t *board, unsigned int address)
+static int ni_usb_primary_address(struct gpib_board *board, unsigned int address)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1283,7 +1283,7 @@ static int ni_usb_write_sad(struct ni_usb_register *writes, int address, int ena
 	return i;
 }
 
-static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int ni_usb_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1302,7 +1302,7 @@ static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, i
 	return 0;
 }
 
-static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int ni_usb_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1354,7 +1354,7 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 	return retval;
 }
 
-static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+static void ni_usb_parallel_poll_configure(struct gpib_board *board, uint8_t config)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1376,7 +1376,7 @@ static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
 	return;// 0;
 }
 
-static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
+static void ni_usb_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1401,7 +1401,7 @@ static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
 	return;// 0;
 }
 
-static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
+static void ni_usb_serial_poll_response(struct gpib_board *board, u8 status)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1423,12 +1423,12 @@ static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
 	return;// 0;
 }
 
-static uint8_t ni_usb_serial_poll_status(gpib_board_t *board)
+static uint8_t ni_usb_serial_poll_status(struct gpib_board *board)
 {
 	return 0;
 }
 
-static void ni_usb_return_to_local(gpib_board_t *board)
+static void ni_usb_return_to_local(struct gpib_board *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1450,7 +1450,7 @@ static void ni_usb_return_to_local(gpib_board_t *board)
 	return;// 0;
 }
 
-static int ni_usb_line_status(const gpib_board_t *board)
+static int ni_usb_line_status(const struct gpib_board *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1566,7 +1566,7 @@ static int ni_usb_setup_t1_delay(struct ni_usb_register *reg, unsigned int nano_
 	return i;
 }
 
-static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int ni_usb_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1587,7 +1587,7 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 	return actual_ns;
 }
 
-static int ni_usb_allocate_private(gpib_board_t *board)
+static int ni_usb_allocate_private(struct gpib_board *board)
 {
 	struct ni_usb_priv *ni_priv;
 
@@ -1610,7 +1610,7 @@ static void ni_usb_free_private(struct ni_usb_priv *ni_priv)
 }
 
 #define NUM_INIT_WRITES 26
-static int ni_usb_setup_init(gpib_board_t *board, struct ni_usb_register *writes)
+static int ni_usb_setup_init(struct gpib_board *board, struct ni_usb_register *writes)
 {
 	struct ni_usb_priv *ni_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
@@ -1717,7 +1717,7 @@ static int ni_usb_setup_init(gpib_board_t *board, struct ni_usb_register *writes
 	return i;
 }
 
-static int ni_usb_init(gpib_board_t *board)
+static int ni_usb_init(struct gpib_board *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1746,7 +1746,7 @@ static int ni_usb_init(gpib_board_t *board)
 
 static void ni_usb_interrupt_complete(struct urb *urb)
 {
-	gpib_board_t *board = urb->context;
+	struct gpib_board *board = urb->context;
 	struct ni_usb_priv *ni_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
@@ -1782,7 +1782,7 @@ static void ni_usb_interrupt_complete(struct urb *urb)
 		dev_err(&usb_dev->dev, "failed to resubmit interrupt urb\n");
 }
 
-static int ni_usb_set_interrupt_monitor(gpib_board_t *board, unsigned int monitored_bits)
+static int ni_usb_set_interrupt_monitor(struct gpib_board *board, unsigned int monitored_bits)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1813,7 +1813,7 @@ static int ni_usb_set_interrupt_monitor(gpib_board_t *board, unsigned int monito
 	return 0;
 }
 
-static int ni_usb_setup_urbs(gpib_board_t *board)
+static int ni_usb_setup_urbs(struct gpib_board *board)
 {
 	struct ni_usb_priv *ni_priv = board->private_data;
 	struct usb_device *usb_dev;
@@ -2152,7 +2152,7 @@ static inline int ni_usb_device_match(struct usb_interface *interface,
 	return 1;
 }
 
-static int ni_usb_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int ni_usb_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	int retval;
 	int i, index;
@@ -2285,7 +2285,7 @@ static int ni_usb_shutdown_hardware(struct ni_usb_priv *ni_priv)
 	return 0;
 }
 
-static void ni_usb_detach(gpib_board_t *board)
+static void ni_usb_detach(struct gpib_board *board)
 {
 	struct ni_usb_priv *ni_priv;
 
@@ -2392,7 +2392,7 @@ static void ni_usb_driver_disconnect(struct usb_interface *interface)
 	mutex_lock(&ni_usb_hotplug_lock);
 	for (i = 0; i < MAX_NUM_NI_USB_INTERFACES; i++)	{
 		if (ni_usb_driver_interfaces[i] == interface)	{
-			gpib_board_t *board = usb_get_intfdata(interface);
+			struct gpib_board *board = usb_get_intfdata(interface);
 
 			if (board) {
 				struct ni_usb_priv *ni_priv = board->private_data;
@@ -2421,7 +2421,7 @@ static void ni_usb_driver_disconnect(struct usb_interface *interface)
 static int ni_usb_driver_suspend(struct usb_interface *interface, pm_message_t message)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(interface);
-	gpib_board_t *board;
+	struct gpib_board *board;
 	int i, retval;
 
 	mutex_lock(&ni_usb_hotplug_lock);
@@ -2465,7 +2465,7 @@ static int ni_usb_driver_resume(struct usb_interface *interface)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(interface);
 
-	gpib_board_t *board;
+	struct gpib_board *board;
 	int i, retval;
 
 	mutex_lock(&ni_usb_hotplug_lock);
-- 
2.43.0


