Return-Path: <linux-kernel+bounces-568877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30019A69BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C067A999A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C113213E6A;
	Wed, 19 Mar 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="fZHp03Kl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB521A457
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421583; cv=none; b=sGGR7Qu2CEYA9REsnjdbQpahqwFZh5uHDmevh8CGW/8fe1ckfaq2Pvkh2Idnxl/dfJr0C86sluYaaQKzIUQJN6gMzWnPsstHOy89PDmoBhwjbjythUc7bkY9yTd249QEI+TQMbMG56K38XmbJ6Ckx1fnH8SKa8wyFEKqWsWhUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421583; c=relaxed/simple;
	bh=N1HKkuxG1bE2v1BdEkRER6ufX3Om7ctf6FOYachWE4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5ntWayOJFgzCaEgk4srxrSC+yAwUqhRgxf0CrxkTlWd0QAk0Zjmi/4D5F+39atxGBVWnaGx/2MwbHQo++9KmjkJtRpS6Ybm9WD3gaHQIKuzyNIUUNcF0sPXzcZRtfwQq6vuwZcaGZbajYB9aFgO7Ril4/7rRUBu/DIKlh/7FIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=fZHp03Kl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239c066347so877075ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421580; x=1743026380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Htv0WV+K2Gnen6DZUmspEXU595vjMhnsIFhE4ehhG2I=;
        b=fZHp03Kl/hazlyg29qX8nGjW2DXPS+UO3PL2B5uK2ZVVD5VLay47Gf6+nEZtueSNMa
         W34pDNHI3YHm8vxL6dR6cxgjHL20tOeJ7wmoupMKPTX+QMwAMyRuQLvNvlbUjr5MZGUv
         jlfBVDxdBM3UTZ4b18IHbZbYhhZJ1p709Z/Qf+MTZC3jlq1b3BONeFA0u8X8f4P2PtWM
         tYELqvvL2W44Z/o4lJ+ws/4yHMmyd4y6Ir8to0v9Njb5oE8wnLltQ+UpQC+Q+HBc4rJr
         7MTRDB79XxYR83mJqozGb/RPTDtRik+CcxTTsQzdfZ5p7YgtFiJpiF5rvCJLsCVpsgPL
         Q4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421580; x=1743026380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Htv0WV+K2Gnen6DZUmspEXU595vjMhnsIFhE4ehhG2I=;
        b=haH0Gv1M8uTwNzT7Fs2J59ZG7XQu36DoIjkJx+4FNjeJK5uyPo/ywbdQW9McEJJZAC
         /13is8GTW7aH3rQahxxsmhEMuej756rJt4nLRm7rgFUTZgMvgLRn8RLuSiCufHXTPg8D
         aN2KqajLOKGag3oRJkcsH9cAgSuPGvSMsQ4xaL4XFcNOLld0N6wKMd6WrrxKa+6tVuUP
         8QWg8x12rPVZzQgMq5mz1BJnsCzCnucT38MuFA1PGWRDQIeDxSkYgUZRapo8AlJoIG0i
         x+CKbI16d0k+DXg6Hp4Mv9t9X15F5IkRGPA4ZR0wpRvgPRDEPE4IJdtT6EQN2SQ/yb+5
         42Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXk47B+8eLdENFi9iT5Ewh1I4a0CpwyeXyNvVTYwlV7ovVkidUb6BP/49oubmly35VT7rWMVWCV5QE/eSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWv/5K1MmxUN0kslR2c78dSLqbZdvIsJ9JS3cBeDZw7vYj7HKg
	2lnGC0/NvH9JH2s3ej5PYcg4moftY68YCOufCiLa/DhFyjxk0EHwAwIrwkT2WnDUzYQ8HYhARAI
	=
X-Gm-Gg: ASbGncv86+nBn/wImPqDfLxcy1sqbW80Bs7Y6xMg+fZuh+lS6iN4Ij2rxkqhzWd5EsB
	81eJO6ROjp43d02HOd9hVFOsNb3ZrV00Nf5ErcPInXCOqnXFVHZh2jfvbD3B7+SNx5FC0lixblm
	wOtSSJExgMvBvIRahc3emmtsmu5Na6irCVTu40CkdJHdGNT7uSx/5kMuhDvOuxJbrJ64ZsP++qN
	jatDu2zJdnoBl+suC+nNd9DkeCtIw6FmI4x6IjRq3odqreTnsA21lU9near3NfLHrDLUf9KHh15
	PARhtHPXkukIJcOYf9CPSfjMmi36IGiuUbNwguXAz8MZ4pmWFbncInVzSMwA1E8ikqkDyFeOyj7
	HfxIQdx/9FQ==
X-Google-Smtp-Source: AGHT+IFqgTSMZQqnbkKdylyk/FzKX7HUs7NWNYBKz0uuuCCNwYXKCOHO37RiTzZhZE5O1becrsYXCQ==
X-Received: by 2002:a17:903:1c4:b0:21f:6546:9af0 with SMTP id d9443c01a7336-22649cb44fbmr67294105ad.44.1742421580561;
        Wed, 19 Mar 2025 14:59:40 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a8796sm120102805ad.99.2025.03.19.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:40 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 03/20] staging: gpib: agilent_82357a: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:07 +0000
Message-ID: <20250319215924.19387-4-matchstick@neverthere.org>
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
 .../gpib/agilent_82357a/agilent_82357a.c      | 85 ++++++++++---------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 5b5b55e90435..702a3071bd58 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -25,9 +25,10 @@ MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapters");
 static struct usb_interface *agilent_82357a_driver_interfaces[MAX_NUM_82357A_INTERFACES];
 static DEFINE_MUTEX(agilent_82357a_hotplug_lock); // protect board insertion and removal
 
-static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned int clear_mask);
+static unsigned int agilent_82357a_update_status(struct gpib_board *board,
+						unsigned int clear_mask);
 
-static int agilent_82357a_take_control_internal(gpib_board_t *board, int synchronous);
+static int agilent_82357a_take_control_internal(struct gpib_board *board, int synchronous);
 
 static void agilent_82357a_bulk_complete(struct urb *urb)
 {
@@ -419,10 +420,10 @@ static int agilent_82357a_abort(struct agilent_82357a_priv *a_priv, int flush)
 }
 
 // interface functions
-int agilent_82357a_command(gpib_board_t *board, uint8_t *buffer, size_t length,
+int agilent_82357a_command(struct gpib_board *board, uint8_t *buffer, size_t length,
 			   size_t *bytes_written);
 
-static int agilent_82357a_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
+static int agilent_82357a_read(struct gpib_board *board, uint8_t *buffer, size_t length, int *end,
 			       size_t *nbytes)
 {
 	int retval;
@@ -529,8 +530,10 @@ static int agilent_82357a_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 	return retval;
 }
 
-static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer, size_t length,
-					    int send_commands, int send_eoi, size_t *bytes_written)
+static ssize_t agilent_82357a_generic_write(struct gpib_board *board,
+					    uint8_t *buffer, size_t length,
+					    int send_commands, int send_eoi,
+					    size_t *bytes_written)
 {
 	int retval;
 	struct agilent_82357a_priv *a_priv = board->private_data;
@@ -664,19 +667,19 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 	return 0;
 }
 
-static int agilent_82357a_write(gpib_board_t *board, uint8_t *buffer, size_t length,
-				int send_eoi, size_t *bytes_written)
+static int agilent_82357a_write(struct gpib_board *board, uint8_t *buffer,
+				size_t length, int send_eoi, size_t *bytes_written)
 {
 	return agilent_82357a_generic_write(board, buffer, length, 0, send_eoi, bytes_written);
 }
 
-int agilent_82357a_command(gpib_board_t *board, uint8_t *buffer, size_t length,
+int agilent_82357a_command(struct gpib_board *board, uint8_t *buffer, size_t length,
 			   size_t *bytes_written)
 {
 	return agilent_82357a_generic_write(board, buffer, length, 1, 0, bytes_written);
 }
 
-int agilent_82357a_take_control_internal(gpib_board_t *board, int synchronous)
+int agilent_82357a_take_control_internal(struct gpib_board *board, int synchronous)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -695,7 +698,7 @@ int agilent_82357a_take_control_internal(gpib_board_t *board, int synchronous)
 	return retval;
 }
 
-static int agilent_82357a_take_control(gpib_board_t *board, int synchronous)
+static int agilent_82357a_take_control(struct gpib_board *board, int synchronous)
 {
 	const int timeout = 10;
 	int i;
@@ -720,7 +723,7 @@ static int agilent_82357a_take_control(gpib_board_t *board, int synchronous)
 	return 0;
 }
 
-static int agilent_82357a_go_to_standby(gpib_board_t *board)
+static int agilent_82357a_go_to_standby(struct gpib_board *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -736,7 +739,8 @@ static int agilent_82357a_go_to_standby(gpib_board_t *board)
 }
 
 //FIXME should change prototype to return int
-static void agilent_82357a_request_system_control(gpib_board_t *board, int request_control)
+static void agilent_82357a_request_system_control(struct gpib_board *board,
+						  int request_control)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -764,7 +768,7 @@ static void agilent_82357a_request_system_control(gpib_board_t *board, int reque
 	return;// retval;
 }
 
-static void agilent_82357a_interface_clear(gpib_board_t *board, int assert)
+static void agilent_82357a_interface_clear(struct gpib_board *board, int assert)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -782,7 +786,7 @@ static void agilent_82357a_interface_clear(gpib_board_t *board, int assert)
 		dev_err(&usb_dev->dev, "write_registers() returned error\n");
 }
 
-static void agilent_82357a_remote_enable(gpib_board_t *board, int enable)
+static void agilent_82357a_remote_enable(struct gpib_board *board, int enable)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -800,7 +804,8 @@ static void agilent_82357a_remote_enable(gpib_board_t *board, int enable)
 	return;// 0;
 }
 
-static int agilent_82357a_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int agilent_82357a_enable_eos(struct gpib_board *board, uint8_t eos_byte,
+				     int compare_8_bits)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 
@@ -812,14 +817,15 @@ static int agilent_82357a_enable_eos(gpib_board_t *board, uint8_t eos_byte, int
 	return 0;
 }
 
-static void agilent_82357a_disable_eos(gpib_board_t *board)
+static void agilent_82357a_disable_eos(struct gpib_board *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 
 	a_priv->eos_mode &= ~REOS;
 }
 
-static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int agilent_82357a_update_status(struct gpib_board *board,
+						 unsigned int clear_mask)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -878,7 +884,7 @@ static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned i
 	return board->status;
 }
 
-static int agilent_82357a_primary_address(gpib_board_t *board, unsigned int address)
+static int agilent_82357a_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -896,14 +902,15 @@ static int agilent_82357a_primary_address(gpib_board_t *board, unsigned int addr
 	return retval;
 }
 
-static int agilent_82357a_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int agilent_82357a_secondary_address(struct gpib_board *board,
+					    unsigned int address, int enable)
 {
 	if (enable)
 		return	-EOPNOTSUPP;
 	return 0;
 }
 
-static int agilent_82357a_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int agilent_82357a_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -942,37 +949,37 @@ static int agilent_82357a_parallel_poll(gpib_board_t *board, uint8_t *result)
 	return 0;
 }
 
-static void agilent_82357a_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+static void agilent_82357a_parallel_poll_configure(struct gpib_board *board, uint8_t config)
 {
 	//board can only be system controller
 	return;// 0;
 }
 
-static void agilent_82357a_parallel_poll_response(gpib_board_t *board, int ist)
+static void agilent_82357a_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	//board can only be system controller
 	return;// 0;
 }
 
-static void agilent_82357a_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void agilent_82357a_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	//board can only be system controller
 	return;// 0;
 }
 
-static uint8_t agilent_82357a_serial_poll_status(gpib_board_t *board)
+static uint8_t agilent_82357a_serial_poll_status(struct gpib_board *board)
 {
 	//board can only be system controller
 	return 0;
 }
 
-static void agilent_82357a_return_to_local(gpib_board_t *board)
+static void agilent_82357a_return_to_local(struct gpib_board *board)
 {
 	//board can only be system controller
 	return;// 0;
 }
 
-static int agilent_82357a_line_status(const gpib_board_t *board)
+static int agilent_82357a_line_status(const struct gpib_board *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -1022,7 +1029,7 @@ static unsigned short nanosec_to_fast_talker_bits(unsigned int *nanosec)
 	return bits;
 }
 
-static unsigned int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int nanosec)
+static unsigned int agilent_82357a_t1_delay(struct gpib_board *board, unsigned int nanosec)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -1039,7 +1046,7 @@ static unsigned int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int na
 
 static void agilent_82357a_interrupt_complete(struct urb *urb)
 {
-	gpib_board_t *board = urb->context;
+	struct gpib_board *board = urb->context;
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	int retval;
@@ -1077,7 +1084,7 @@ static void agilent_82357a_interrupt_complete(struct urb *urb)
 		dev_err(&usb_dev->dev, "failed to resubmit interrupt urb\n");
 }
 
-static int agilent_82357a_setup_urbs(gpib_board_t *board)
+static int agilent_82357a_setup_urbs(struct gpib_board *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev;
@@ -1141,7 +1148,7 @@ static void agilent_82357a_release_urbs(struct agilent_82357a_priv *a_priv)
 	}
 }
 
-static int agilent_82357a_allocate_private(gpib_board_t *board)
+static int agilent_82357a_allocate_private(struct gpib_board *board)
 {
 	struct agilent_82357a_priv *a_priv;
 
@@ -1156,14 +1163,14 @@ static int agilent_82357a_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void agilent_82357a_free_private(gpib_board_t *board)
+static void agilent_82357a_free_private(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
 }
 
 #define INIT_NUM_REG_WRITES 18
-static int agilent_82357a_init(gpib_board_t *board)
+static int agilent_82357a_init(struct gpib_board *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -1253,7 +1260,7 @@ static inline int agilent_82357a_device_match(struct usb_interface *interface,
 	return 1;
 }
 
-static int agilent_82357a_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int agilent_82357a_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	int retval;
 	int i;
@@ -1329,7 +1336,7 @@ static int agilent_82357a_attach(gpib_board_t *board, const gpib_board_config_t
 	return retval;
 }
 
-static int agilent_82357a_go_idle(gpib_board_t *board)
+static int agilent_82357a_go_idle(struct gpib_board *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
@@ -1358,7 +1365,7 @@ static int agilent_82357a_go_idle(gpib_board_t *board)
 	return 0;
 }
 
-static void agilent_82357a_detach(gpib_board_t *board)
+static void agilent_82357a_detach(struct gpib_board *board)
 {
 	struct agilent_82357a_priv *a_priv;
 
@@ -1466,7 +1473,7 @@ static void agilent_82357a_driver_disconnect(struct usb_interface *interface)
 
 	for (i = 0; i < MAX_NUM_82357A_INTERFACES; ++i) {
 		if (agilent_82357a_driver_interfaces[i] == interface) {
-			gpib_board_t *board = usb_get_intfdata(interface);
+			struct gpib_board *board = usb_get_intfdata(interface);
 
 			if (board) {
 				struct agilent_82357a_priv *a_priv = board->private_data;
@@ -1502,7 +1509,7 @@ static int agilent_82357a_driver_suspend(struct usb_interface *interface, pm_mes
 
 	for (i = 0; i < MAX_NUM_82357A_INTERFACES; ++i) {
 		if (agilent_82357a_driver_interfaces[i] == interface)	{
-			gpib_board_t *board = usb_get_intfdata(interface);
+			struct gpib_board *board = usb_get_intfdata(interface);
 
 			if (board) {
 				struct agilent_82357a_priv *a_priv = board->private_data;
@@ -1538,7 +1545,7 @@ static int agilent_82357a_driver_suspend(struct usb_interface *interface, pm_mes
 static int agilent_82357a_driver_resume(struct usb_interface *interface)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(interface);
-	gpib_board_t *board;
+	struct gpib_board *board;
 	int i, retval;
 
 	mutex_lock(&agilent_82357a_hotplug_lock);
-- 
2.43.0


