Return-Path: <linux-kernel+bounces-392659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D89B96C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0930D1C21CF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2DC1CF2BF;
	Fri,  1 Nov 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B74va3F3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250901CDFCC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483273; cv=none; b=Ap61Y6JIazze3qAnNgqMyr7bh/Fl5PHzdQk6mawsIA4jtVPAZdL++kRwQV4b56sA0cOEr4v/lT3QKxGBE8VbAtWl5/vf9aLXQqXrf1PhnUX4ED6ZB5s/TkTj1rzzyNuGtbR6/X132v6xMgvFIjUUPRLNr2kSpxDcXUTkn+w/21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483273; c=relaxed/simple;
	bh=RrjBIOvO5VopIzFTn82GGUqfsHnTdo2WWNhITjcisAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StZT1n3OdZ9hSRTtimINMuGecm8Z6ayitjDD35lN1wxDNz8cmDlygrpiYaM8h+o994tCLhym5ZYQK/K/28WY1s+4hIS8dW4tDeE/X+uILAslWO0ij4B5wtuNHaFbW1P6VIY8iFG4GkD5v0PcVAi0j+AaeCLY0cOjFC5SjIEQHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B74va3F3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431481433bdso19404985e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483265; x=1731088065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKAmaQTd98lxmzsF7BocOvZtrmC6TIqQEZQOptmQ6yI=;
        b=B74va3F32dkBR8cIH2NY/JzJ8cUPdfhNBSH/hjCsPh7ilJ4wZQdekjNwJeO7Xw5MCb
         xQWjyuzZqVVEoDgSq8bHcgVkQOfbjWd0iflronD4yxMFwqFVDMZvJaUsUhoC/ZFo1T/s
         r/rQkcSuLaKuCtQXYaOm0txKR7kghqCwIjcpXP/CwKf+veSgy3ln5GUaJzAqxokbJ/yM
         3bCh764GaY893Ww8yAlacCY0a1O24Ue1yfWLLQ3IU3/m5MkUSnDzLEEPRdjk2mG+KV7N
         31j7YydSplncES7bVcbnhtcVVUlInVPelnTZX5SrwVnSGNPuCT3LcirdxjK0NZTYsp6n
         UVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483265; x=1731088065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKAmaQTd98lxmzsF7BocOvZtrmC6TIqQEZQOptmQ6yI=;
        b=Rzd+ltxmE25SgWd5+vxd9iGrlf7xA4K+C8C7T276k5J5qGYWSrJQabeAiiyKfaGbX6
         W9obQ4HNgy11xa2oKnBLY/He1uineARYFUf9+HNrGgsHC3lubjCIZoY50NiRZpBr6UYI
         m77fMCS4VOkUfHhOk0RGdOqwuT0ioIUB5HpRp/gIVtzRQt5RG81zVimlehj577GiEmk6
         XM7t9Dg+w/Y9VlPqiJnl7kx4wdupBvl1s5jyu2BPJ9BE5ZQNZtSZG96DVw9pV+3nhsro
         yjzJ0LY5ktLj+9xpLmc0krCCtSXvPVfvA5E+Ykcg18I35KqXumy4jZLqNHc2aveg2u7x
         kXOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFIdHcnK85WmAOHaQ6xdk49hIGmO8O54pcd8EXqSBvUBUOfRER4jBM9LsburWOI6s9aoPq4MhYSAZmIq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn13yIrtF22SLYyu04034QgUWA9bbpoEOmaWaNhi+hpmt6nDXB
	ULuMukNUvSH8RvSxmv7T/nHqsi8l2VsII3wufkiz/jmq4Zfd247MVrLeP5dL
X-Google-Smtp-Source: AGHT+IEBpYLhhENJ1c35WZfxftj53DgcwPUz3gDJUJ4MiMy6p43XFvXb44+uEqT0F/jzqAw+dkAQEA==
X-Received: by 2002:a05:600c:3507:b0:431:1512:743b with SMTP id 5b1f17b1804b1-4327b7019a5mr68312165e9.21.1730483264924;
        Fri, 01 Nov 2024 10:47:44 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm5732933f8f.112.2024.11.01.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:47:44 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 3/9] Update messaging and usb_device refs in ni_usb
Date: Fri,  1 Nov 2024 18:46:59 +0100
Message-ID: <20241101174705.12682-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101174705.12682-1-dpenkler@gmail.com>
References: <20241101174705.12682-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

      Replace GPIB_DPRINTK with dev_dbg
      Replace pr_xxx with dev_xxx wherever possible
      Use previously initialized usb_device pointer
      for usb_get_dev() and usb_put_dev().

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 377 ++++++++++++----------
 1 file changed, 205 insertions(+), 172 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 9ff56b063681..50ec934fe8be 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -132,13 +132,14 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
 	if (timeout_msecs)
 		mod_timer(&ni_priv->bulk_timer, jiffies + msecs_to_jiffies(timeout_msecs));
 
-	//pr_err("%s: submitting urb\n", __func__);
+	//dev_err(&usb_dev->dev, "%s: submitting urb\n", __func__);
 	retval = usb_submit_urb(ni_priv->bulk_urb, GFP_KERNEL);
 	if (retval) {
 		del_timer_sync(&ni_priv->bulk_timer);
 		usb_free_urb(ni_priv->bulk_urb);
 		ni_priv->bulk_urb = NULL;
-		pr_err("%s: failed to submit bulk out urb, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: failed to submit bulk out urb, retval=%i\n",
+			__func__, retval);
 		mutex_unlock(&ni_priv->bulk_transfer_lock);
 		return retval;
 	}
@@ -146,7 +147,7 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
 	down(&context->complete);    // wait for ni_usb_bulk_complete
 	if (context->timed_out) {
 		usb_kill_urb(ni_priv->bulk_urb);
-		pr_err("%s: killed urb due to timeout\n", __func__);
+		dev_err(&usb_dev->dev, "%s: killed urb due to timeout\n", __func__);
 		retval = -ETIMEDOUT;
 	} else {
 		retval = ni_priv->bulk_urb->status;
@@ -224,7 +225,8 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 		del_timer_sync(&ni_priv->bulk_timer);
 		usb_free_urb(ni_priv->bulk_urb);
 		ni_priv->bulk_urb = NULL;
-		pr_err("%s: failed to submit bulk out urb, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: failed to submit bulk out urb, retval=%i\n",
+			__func__, retval);
 		mutex_unlock(&ni_priv->bulk_transfer_lock);
 		return retval;
 	}
@@ -249,7 +251,7 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 	}
 	if (context->timed_out) {
 		usb_kill_urb(ni_priv->bulk_urb);
-		pr_err("%s: killed urb due to timeout\n", __func__);
+		dev_err(&usb_dev->dev, "%s: killed urb due to timeout\n", __func__);
 		retval = -ETIMEDOUT;
 	} else {
 		if (ni_priv->bulk_urb->status)
@@ -315,6 +317,7 @@ static void ni_usb_soft_update_status(gpib_board_t *board, unsigned int ni_usb_i
 	static const unsigned int ni_usb_ibsta_mask = SRQI | ATN | CIC | REM | LACS | TACS | LOK;
 
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	unsigned int need_monitoring_bits = ni_usb_ibsta_monitor_mask;
 	unsigned long flags;
 
@@ -328,15 +331,14 @@ static void ni_usb_soft_update_status(gpib_board_t *board, unsigned int ni_usb_i
 	ni_priv->monitored_ibsta_bits &= ~ni_usb_ibsta;
 	need_monitoring_bits &= ~ni_priv->monitored_ibsta_bits; /* mm - monitored set */
 	spin_unlock_irqrestore(&board->spinlock, flags);
-
-	GPIB_DPRINTK("%s: need_monitoring_bits=0x%x\n", __func__, need_monitoring_bits);
+	dev_dbg(&usb_dev->dev, "%s: need_monitoring_bits=0x%x\n", __func__, need_monitoring_bits);
 
 	if (need_monitoring_bits & ~ni_usb_ibsta)
 		ni_usb_set_interrupt_monitor(board, ni_usb_ibsta_monitor_mask);
 	else if (need_monitoring_bits & ni_usb_ibsta)
 		wake_up_interruptible(&board->wait);
 
-	GPIB_DPRINTK("%s: ni_usb_ibsta=0x%x\n", __func__, ni_usb_ibsta);
+	dev_dbg(&usb_dev->dev, "%s: ni_usb_ibsta=0x%x\n", __func__, ni_usb_ibsta);
 }
 
 static int ni_usb_parse_status_block(const u8 *buffer, struct ni_usb_status_block *status)
@@ -355,7 +357,6 @@ static int ni_usb_parse_status_block(const u8 *buffer, struct ni_usb_status_bloc
 
 static void ni_usb_dump_raw_block(const u8 *raw_data, int length)
 {
-	pr_info("hex block dump\n");
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 8, 1, raw_data, length, true);
 }
 
@@ -516,6 +517,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 				  const struct ni_usb_register *writes, int num_writes,
 				  unsigned int *ibsta)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	u8 *out_data, *in_data;
 	int out_data_length;
@@ -530,7 +532,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 	out_data_length = num_writes * bytes_per_write + 0x10;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)	{
-		pr_err("%s: kmalloc failed\n", __func__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	i += ni_usb_bulk_register_write_header(&out_data[i], num_writes);
@@ -540,7 +542,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 		out_data[i++] = 0x00;
 	i += ni_usb_bulk_termination(&out_data[i]);
 	if (i > out_data_length)
-		pr_err("%s: bug! buffer overrun\n", __func__);
+		dev_err(&usb_dev->dev, "%s: bug! buffer overrun\n", __func__);
 
 	mutex_lock(&ni_priv->addressed_transfer_lock);
 
@@ -548,22 +550,22 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 	kfree(out_data);
 	if (retval) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		return retval;
 	}
 
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
 	if (!in_data) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: kmalloc failed\n", __func__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	retval = ni_usb_receive_bulk_msg(ni_priv, in_data, in_data_length, &bytes_read, 1000, 0);
 	if (retval || bytes_read != 16) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		ni_usb_dump_raw_block(in_data, bytes_read);
 		kfree(in_data);
 		return retval;
@@ -575,17 +577,18 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 	//FIXME parse extra 09 status bits and termination
 	kfree(in_data);
 	if (status.id != NIUSB_REG_WRITE_ID) {
-		pr_err("%s: parse error, id=0x%x != NIUSB_REG_WRITE_ID\n",
-		       __func__, status.id);
+		dev_err(&usb_dev->dev, "%s: parse error, id=0x%x != NIUSB_REG_WRITE_ID\n",
+			__func__, status.id);
 		return -EIO;
 	}
 	if (status.error_code) {
-		pr_err("%s: nonzero error code 0x%x\n", __func__, status.error_code);
+		dev_err(&usb_dev->dev, "%s: nonzero error code 0x%x\n",
+			__func__, status.error_code);
 		return -EIO;
 	}
 	if (reg_writes_completed != num_writes) {
-		pr_err("%s: reg_writes_completed=%i, num_writes=%i\n", __func__,
-		       reg_writes_completed, num_writes);
+		dev_err(&usb_dev->dev, "%s: reg_writes_completed=%i, num_writes=%i\n",
+			__func__, reg_writes_completed, num_writes);
 		return -EIO;
 	}
 	if (ibsta)
@@ -599,6 +602,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval, parse_retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	int in_data_length;
@@ -613,7 +617,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	*bytes_read = 0;
 	if (length > max_read_length)	{
 		length = max_read_length;
-		pr_err("%s: read length too long\n", __func__);
+		dev_err(&usb_dev->dev, "%s: read length too long\n", __func__);
 	}
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
@@ -646,8 +650,8 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	if (retval || usb_bytes_written != i) {
 		if (retval == 0)
 			retval = -EIO;
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, usb_bytes_written=%i, i=%i\n",
-		       __func__, retval, usb_bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, usb_bytes_written=%i, i=%i\n",
+			__func__, retval, usb_bytes_written, i);
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
 		return retval;
 	}
@@ -665,8 +669,8 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 
 	if (retval == -ERESTARTSYS) {
 	} else if (retval) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, usb_bytes_read=%i\n",
-		       __func__, retval, usb_bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, usb_bytes_read=%i\n",
+			__func__, retval, usb_bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -674,14 +678,14 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	if (parse_retval != usb_bytes_read) {
 		if (parse_retval >= 0)
 			parse_retval = -EIO;
-		pr_err("%s: retval=%i usb_bytes_read=%i\n",
-		       __func__, parse_retval, usb_bytes_read);
+		dev_err(&usb_dev->dev, "%s: retval=%i usb_bytes_read=%i\n",
+			__func__, parse_retval, usb_bytes_read);
 		kfree(in_data);
 		return parse_retval;
 	}
 	if (actual_length != length - status.count) {
-		pr_err("%s: actual_length=%i expected=%li\n",
-		       __func__, actual_length, (long)(length - status.count));
+		dev_err(&usb_dev->dev, "%s: actual_length=%i expected=%li\n",
+			__func__, actual_length, (long)(length - status.count));
 		ni_usb_dump_raw_block(in_data, usb_bytes_read);
 	}
 	kfree(in_data);
@@ -696,7 +700,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 		break;
 	case NIUSB_ATN_STATE_ERROR:
 		retval = -EIO;
-		pr_err("%s: read when ATN set\n", __func__);
+		dev_err(&usb_dev->dev, "%s: read when ATN set\n", __func__);
 		break;
 	case NIUSB_ADDRESSING_ERROR:
 		retval = -EIO;
@@ -705,12 +709,12 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 		retval = -ETIMEDOUT;
 		break;
 	case NIUSB_EOSMODE_ERROR:
-		pr_err("%s: driver bug, we should have been able to avoid NIUSB_EOSMODE_ERROR.\n",
-		       __func__);
+		dev_err(&usb_dev->dev, "%s: driver bug, we should have been able to avoid NIUSB_EOSMODE_ERROR.\n",
+			__func__);
 		retval = -EINVAL;
 		break;
 	default:
-		pr_err("%s: unknown error code=%i\n", __func__, status.error_code);
+		dev_err(&usb_dev->dev, "%s: unknown error code=%i\n", __func__, status.error_code);
 		retval = -EIO;
 		break;
 	}
@@ -728,6 +732,7 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -741,7 +746,7 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	if (length > max_write_length) {
 		length = max_write_length;
 		send_eoi = 0;
-		pr_err("%s: write length too long\n", __func__);
+		dev_err(&usb_dev->dev, "%s: write length too long\n", __func__);
 	}
 	out_data_length = length + 0x10;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
@@ -773,8 +778,8 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	kfree(out_data);
 	if (retval || usb_bytes_written != i)	{
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, usb_bytes_written=%i, i=%i\n",
-		       __func__, retval, usb_bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, usb_bytes_written=%i, i=%i\n",
+			__func__, retval, usb_bytes_written, i);
 		return retval;
 	}
 
@@ -787,8 +792,8 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	mutex_unlock(&ni_priv->addressed_transfer_lock);
 
 	if ((retval && retval != -ERESTARTSYS) || usb_bytes_read != 12) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, usb_bytes_read=%i\n",
-		       __func__, retval, usb_bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, usb_bytes_read=%i\n",
+			__func__, retval, usb_bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -804,8 +809,8 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 		 */
 		break;
 	case NIUSB_ADDRESSING_ERROR:
-		pr_err("%s: Addressing error retval %d error code=%i\n",
-		       __func__, retval, status.error_code);
+		dev_err(&usb_dev->dev, "%s: Addressing error retval %d error code=%i\n",
+			__func__, retval, status.error_code);
 		retval = -ENXIO;
 		break;
 	case NIUSB_NO_LISTENER_ERROR:
@@ -815,8 +820,8 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 		retval = -ETIMEDOUT;
 		break;
 	default:
-		pr_err("%s: unknown error code=%i\n",
-		       __func__, status.error_code);
+		dev_err(&usb_dev->dev, "%s: unknown error code=%i\n",
+			__func__, status.error_code);
 		retval = -EPIPE;
 		break;
 	}
@@ -830,6 +835,7 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -866,8 +872,8 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 	kfree(out_data);
 	if (retval || bytes_written != i) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		return retval;
 	}
 
@@ -883,8 +889,8 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 	mutex_unlock(&ni_priv->addressed_transfer_lock);
 
 	if ((retval && retval != -ERESTARTSYS) || bytes_read != 12) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -902,12 +908,12 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 	case NIUSB_NO_BUS_ERROR:
 		return -ENOTCONN;
 	case NIUSB_EOSMODE_ERROR:
-		pr_err("%s: got eosmode error.  Driver bug?\n", __func__);
+		dev_err(&usb_dev->dev, "%s: got eosmode error.	Driver bug?\n", __func__);
 		return -EIO;
 	case NIUSB_TIMEOUT_ERROR:
 		return -ETIMEDOUT;
 	default:
-		pr_err("%s: unknown error code=%i\n", __func__, status.error_code);
+		dev_err(&usb_dev->dev, "%s: unknown error code=%i\n", __func__, status.error_code);
 		return -EIO;
 	}
 	ni_usb_soft_update_status(board, status.ibsta, 0);
@@ -935,6 +941,7 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -960,15 +967,15 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 	kfree(out_data);
 	if (retval || bytes_written != i) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		return retval;
 	}
 
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
 	if (!in_data) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: kmalloc failed\n", __func__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	retval = ni_usb_receive_bulk_msg(ni_priv, in_data, in_data_length, &bytes_read, 1000, 1);
@@ -978,8 +985,8 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 	if ((retval && retval != -ERESTARTSYS) || bytes_read != 12) {
 		if (retval == 0)
 			retval = -EIO;
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -993,6 +1000,7 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -1016,15 +1024,15 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 	kfree(out_data);
 	if (retval || bytes_written != i) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		return retval;
 	}
 
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
 	if (!in_data) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: kmalloc failed\n", __FILE__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	retval = ni_usb_receive_bulk_msg(ni_priv, in_data, in_data_length, &bytes_read, 1000, 0);
@@ -1032,16 +1040,16 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 	mutex_unlock(&ni_priv->addressed_transfer_lock);
 
 	if (retval || bytes_read != 12) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		kfree(in_data);
 		return retval;
 	}
 	ni_usb_parse_status_block(in_data, &status);
 	kfree(in_data);
 	if (status.id != NIUSB_IBGTS_ID)
-		pr_err("%s: bug: status.id 0x%x != INUSB_IBGTS_ID\n",
-		       __func__, status.id);
+		dev_err(&usb_dev->dev, "%s: bug: status.id 0x%x != INUSB_IBGTS_ID\n",
+			__func__, status.id);
 	ni_usb_soft_update_status(board, status.ibsta, 0);
 	return 0;
 }
@@ -1050,6 +1058,7 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[4];
 	unsigned int ibsta;
@@ -1083,7 +1092,7 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 	}
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return; // retval;
 	}
 	if (!request_control)
@@ -1097,6 +1106,7 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -1109,7 +1119,7 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 		return;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)	{
-		pr_err("%s: kmalloc failed\n", __FILE__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return;
 	}
 	out_data[i++] = NIUSB_IBSIC_ID;
@@ -1120,8 +1130,8 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 	retval = ni_usb_send_bulk_msg(ni_priv, out_data, i, &bytes_written, 1000);
 	kfree(out_data);
 	if (retval || bytes_written != i) {
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		return;
 	}
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
@@ -1130,8 +1140,8 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 
 	retval = ni_usb_receive_bulk_msg(ni_priv, in_data, in_data_length, &bytes_read, 1000, 0);
 	if (retval || bytes_read != 12) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		kfree(in_data);
 		return;
 	}
@@ -1144,6 +1154,7 @@ static void ni_usb_remote_enable(gpib_board_t *board, int enable)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	struct ni_usb_register reg;
 	unsigned int ibsta;
 
@@ -1155,7 +1166,7 @@ static void ni_usb_remote_enable(gpib_board_t *board, int enable)
 		reg.value = AUX_CREN;
 	retval = ni_usb_write_registers(ni_priv, &reg, 1, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return; //retval;
 	}
 	ni_priv->ren_state = enable;
@@ -1190,11 +1201,12 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	static const int buffer_length = 8;
 	u8 *buffer;
 	struct ni_usb_status_block status;
 
-	//printk("%s: receive control pipe is %i\n", __FILE__, pipe);
+	//printk("%s: receive control pipe is %i\n", __func__, pipe);
 	buffer = kmalloc(buffer_length, GFP_KERNEL);
 	if (!buffer)
 		return board->status;
@@ -1203,7 +1215,7 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
 					    USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 					    0x200, 0x0, buffer, buffer_length, 1000);
 	if (retval != buffer_length) {
-		pr_err("%s: usb_control_msg returned %i\n", __FILE__, retval);
+		dev_err(&usb_dev->dev, "%s: usb_control_msg returned %i\n", __func__, retval);
 		kfree(buffer);
 		return board->status;
 	}
@@ -1216,12 +1228,13 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
 // tells ni-usb to immediately stop an ongoing i/o operation
 static void ni_usb_stop(struct ni_usb_priv *ni_priv)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	static const int buffer_length = 8;
 	u8 *buffer;
 	struct ni_usb_status_block status;
 
-	//printk("%s: receive control pipe is %i\n", __FILE__, pipe);
+	//printk("%s: receive control pipe is %i\n", __func__, pipe);
 	buffer = kmalloc(buffer_length, GFP_KERNEL);
 	if (!buffer)
 		return;
@@ -1230,7 +1243,7 @@ static void ni_usb_stop(struct ni_usb_priv *ni_priv)
 					    USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 					    0x0, 0x0, buffer, buffer_length, 1000);
 	if (retval != buffer_length) {
-		pr_err("%s: usb_control_msg returned %i\n", __FILE__, retval);
+		dev_err(&usb_dev->dev, "%s: usb_control_msg returned %i\n", __func__, retval);
 		kfree(buffer);
 		return;
 	}
@@ -1242,6 +1255,7 @@ static int ni_usb_primary_address(gpib_board_t *board, unsigned int address)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[2];
 	unsigned int ibsta;
@@ -1256,7 +1270,7 @@ static int ni_usb_primary_address(gpib_board_t *board, unsigned int address)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1296,6 +1310,7 @@ static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, i
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[3];
 	unsigned int ibsta;
@@ -1303,7 +1318,7 @@ static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, i
 	i += ni_usb_write_sad(writes, address, enable);
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1314,6 +1329,7 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -1336,8 +1352,8 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 
 	kfree(out_data);
 	if (retval || bytes_written != i) {
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		return retval;
 	}
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
@@ -1349,8 +1365,8 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 					 &bytes_read, 1000, 1);
 
 	if (retval && retval != -ERESTARTSYS)	{
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -1365,6 +1381,7 @@ static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
@@ -1375,7 +1392,7 @@ static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return;// retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1386,6 +1403,7 @@ static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
@@ -1399,7 +1417,7 @@ static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return;// retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1410,6 +1428,7 @@ static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
@@ -1420,7 +1439,7 @@ static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return;// retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1436,6 +1455,7 @@ static void ni_usb_return_to_local(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
@@ -1446,7 +1466,7 @@ static void ni_usb_return_to_local(gpib_board_t *board)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return;// retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1457,6 +1477,7 @@ static int ni_usb_line_status(const gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	static const int  in_data_length = 0x20;
@@ -1487,15 +1508,15 @@ static int ni_usb_line_status(const gpib_board_t *board)
 	if (retval || bytes_written != i) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
 		if (retval != -EAGAIN)
-			pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-			       __func__, retval, bytes_written, i);
+			dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+				__func__, retval, bytes_written, i);
 		return retval;
 	}
 
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
 	if (!in_data) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: kmalloc failed\n", __FILE__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	retval = ni_usb_nonblocking_receive_bulk_msg(ni_priv, in_data, in_data_length,
@@ -1505,8 +1526,8 @@ static int ni_usb_line_status(const gpib_board_t *board)
 
 	if (retval) {
 		if (retval != -EAGAIN)
-			pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-			       __func__, retval, bytes_read);
+			dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+				__func__, retval, bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -1573,6 +1594,7 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	struct ni_usb_register writes[3];
 	unsigned int ibsta;
 	unsigned int actual_ns;
@@ -1581,7 +1603,7 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 	i = ni_usb_setup_t1_delay(writes, nano_sec, &actual_ns);
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return -1;	//FIXME should change return type to int for error reporting
 	}
 	board->t1_nano_sec = actual_ns;
@@ -1615,6 +1637,7 @@ static void ni_usb_free_private(struct ni_usb_priv *ni_priv)
 static int ni_usb_setup_init(gpib_board_t *board, struct ni_usb_register *writes)
 {
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	unsigned int mask, actual_ns;
 	int i = 0;
 
@@ -1712,7 +1735,7 @@ static int ni_usb_setup_init(gpib_board_t *board, struct ni_usb_register *writes
 	writes[i].value = AUX_CPPF;
 	i++;
 	if (i > NUM_INIT_WRITES) {
-		pr_err("%s: bug!, buffer overrun, i=%i\n", __func__, i);
+		dev_err(&usb_dev->dev, "%s: bug!, buffer overrun, i=%i\n", __func__, i);
 		return 0;
 	}
 	return i;
@@ -1722,6 +1745,7 @@ static int ni_usb_init(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	struct ni_usb_register *writes;
 	unsigned int ibsta;
 	int writes_len;
@@ -1737,7 +1761,7 @@ static int ni_usb_init(gpib_board_t *board)
 		return -EFAULT;
 	kfree(writes);
 	if (retval) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1748,6 +1772,7 @@ static void ni_usb_interrupt_complete(struct urb *urb)
 {
 	gpib_board_t *board = urb->context;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	struct ni_usb_status_block status;
 	unsigned long flags;
@@ -1767,7 +1792,7 @@ static void ni_usb_interrupt_complete(struct urb *urb)
 	default: /* other error, resubmit */
 		retval = usb_submit_urb(ni_priv->interrupt_urb, GFP_ATOMIC);
 		if (retval)
-			pr_err("%s: failed to resubmit interrupt urb\n", __func__);
+			dev_err(&usb_dev->dev, "%s: failed to resubmit interrupt urb\n", __func__);
 		return;
 	}
 
@@ -1783,32 +1808,34 @@ static void ni_usb_interrupt_complete(struct urb *urb)
 
 	retval = usb_submit_urb(ni_priv->interrupt_urb, GFP_ATOMIC);
 	if (retval)
-		pr_err("%s: failed to resubmit interrupt urb\n", __func__);
+		dev_err(&usb_dev->dev, "%s: failed to resubmit interrupt urb\n", __func__);
 }
 
 static int ni_usb_set_interrupt_monitor(gpib_board_t *board, unsigned int monitored_bits)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	static const int buffer_length = 8;
 	u8 *buffer;
 	struct ni_usb_status_block status;
 	unsigned long flags;
-	//printk("%s: receive control pipe is %i\n", __FILE__, pipe);
+	//printk("%s: receive control pipe is %i\n", __func__, pipe);
 	buffer = kmalloc(buffer_length, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
 	spin_lock_irqsave(&board->spinlock, flags);
 	ni_priv->monitored_ibsta_bits = ni_usb_ibsta_monitor_mask & monitored_bits;
-//	pr_err("debug: %s: monitored_ibsta_bits=0x%x\n", __func__, ni_priv->monitored_ibsta_bits);
+//	dev_err(&usb_dev->dev, "debug: %s: monitored_ibsta_bits=0x%x\n",
+//	__func__, ni_priv->monitored_ibsta_bits);
 	spin_unlock_irqrestore(&board->spinlock, flags);
 	retval = ni_usb_receive_control_msg(ni_priv, NI_USB_WAIT_REQUEST, USB_DIR_IN |
 					    USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 					    0x300, ni_usb_ibsta_monitor_mask & monitored_bits,
 					    buffer, buffer_length, 1000);
 	if (retval != buffer_length) {
-		pr_err("%s: usb_control_msg returned %i\n", __FILE__, retval);
+		dev_err(&usb_dev->dev, "%s: usb_control_msg returned %i\n", __func__, retval);
 		kfree(buffer);
 		return -1;
 	}
@@ -1844,7 +1871,8 @@ static int ni_usb_setup_urbs(gpib_board_t *board)
 	retval = usb_submit_urb(ni_priv->interrupt_urb, GFP_KERNEL);
 	mutex_unlock(&ni_priv->interrupt_transfer_lock);
 	if (retval) {
-		pr_err("%s: failed to submit first interrupt urb, retval=%i\n", __FILE__, retval);
+		dev_err(&usb_dev->dev, "%s: failed to submit first interrupt urb, retval=%i\n",
+			__func__, retval);
 		return retval;
 	}
 	return 0;
@@ -1862,6 +1890,7 @@ static void ni_usb_cleanup_urbs(struct ni_usb_priv *ni_priv)
 
 static int ni_usb_b_read_serial_number(struct ni_usb_priv *ni_priv)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	u8 *out_data;
 	u8 *in_data;
@@ -1894,20 +1923,20 @@ static int ni_usb_b_read_serial_number(struct ni_usb_priv *ni_priv)
 	i += ni_usb_bulk_termination(&out_data[i]);
 	retval = ni_usb_send_bulk_msg(ni_priv, out_data, out_data_length, &bytes_written, 1000);
 	if (retval) {
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%li\n",
-		       __func__,
-		       retval, bytes_written, (long)out_data_length);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%li\n",
+			__func__,
+			retval, bytes_written, (long)out_data_length);
 		goto serial_out;
 	}
 	retval = ni_usb_receive_bulk_msg(ni_priv, in_data, in_data_length, &bytes_read, 1000, 0);
 	if (retval) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		ni_usb_dump_raw_block(in_data, bytes_read);
 		goto serial_out;
 	}
 	if (ARRAY_SIZE(results) < num_reads) {
-		pr_err("Setup bug\n");
+		dev_err(&usb_dev->dev, "Setup bug\n");
 		retval = -EINVAL;
 		goto serial_out;
 	}
@@ -1915,7 +1944,7 @@ static int ni_usb_b_read_serial_number(struct ni_usb_priv *ni_priv)
 	serial_number = 0;
 	for (j = 0; j < num_reads; ++j)
 		serial_number |= (results[j] & 0xff) << (8 * j);
-	pr_info("%s: board serial number is 0x%x\n", __func__, serial_number);
+	dev_info(&usb_dev->dev, "%s: board serial number is 0x%x\n", __func__, serial_number);
 	retval = 0;
 serial_out:
 	kfree(in_data);
@@ -1925,6 +1954,7 @@ static int ni_usb_b_read_serial_number(struct ni_usb_priv *ni_priv)
 
 static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	static const int buffer_size = 0x10;
 	static const int timeout = 50;
 	static const int msec_sleep_duration = 100;
@@ -1942,22 +1972,22 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 					    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 					    0x0, 0x0, buffer, buffer_size, 1000);
 	if (retval < 0) {
-		pr_err("%s: usb_control_msg request 0x%x returned %i\n",
-		       __FILE__, NI_USB_SERIAL_NUMBER_REQUEST, retval);
+		dev_err(&usb_dev->dev, "%s: usb_control_msg request 0x%x returned %i\n",
+			__func__, NI_USB_SERIAL_NUMBER_REQUEST, retval);
 		goto ready_out;
 	}
 	j = 0;
 	if (buffer[j] != NI_USB_SERIAL_NUMBER_REQUEST) {
-		pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x%x\n",
-		       __func__, j, (int)buffer[j], NI_USB_SERIAL_NUMBER_REQUEST);
+		dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x%x\n",
+			__func__, j, (int)buffer[j], NI_USB_SERIAL_NUMBER_REQUEST);
 		unexpected = 1;
 	}
 	if (unexpected)
 		ni_usb_dump_raw_block(buffer, retval);
 	// NI-USB-HS+ pads the serial with 0x0 to make 16 bytes
 	if (retval != 5 && retval != 16) {
-		pr_err("%s: received unexpected number of bytes = %i, expected 5 or 16\n",
-		       __func__, retval);
+		dev_err(&usb_dev->dev, "%s: received unexpected number of bytes = %i, expected 5 or 16\n",
+			__func__, retval);
 		ni_usb_dump_raw_block(buffer, retval);
 	}
 	serial_number = 0;
@@ -1965,7 +1995,7 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 	serial_number |= (buffer[++j] << 8);
 	serial_number |= (buffer[++j] << 16);
 	serial_number |= (buffer[++j] << 24);
-	pr_info("%s: board serial number is 0x%x\n", __func__, serial_number);
+	dev_info(&usb_dev->dev, "%s: board serial number is 0x%x\n", __func__, serial_number);
 	for (i = 0; i < timeout; ++i) {
 		int ready = 0;
 
@@ -1973,26 +2003,26 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 						    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 						    0x0, 0x0, buffer, buffer_size, 100);
 		if (retval < 0) {
-			pr_err("%s: usb_control_msg request 0x%x returned %i\n",
-			       __func__, NI_USB_POLL_READY_REQUEST, retval);
+			dev_err(&usb_dev->dev, "%s: usb_control_msg request 0x%x returned %i\n",
+				__func__, NI_USB_POLL_READY_REQUEST, retval);
 			goto ready_out;
 		}
 		j = 0;
 		unexpected = 0;
 		if (buffer[j] != NI_USB_POLL_READY_REQUEST) { // [0]
-			pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x%x\n",
-			       __func__, j, (int)buffer[j], NI_USB_POLL_READY_REQUEST);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x%x\n",
+				__func__, j, (int)buffer[j], NI_USB_POLL_READY_REQUEST);
 			unexpected = 1;
 		}
 		++j;
 		if (buffer[j] != 0x1 && buffer[j] != 0x0) { // [1] HS+ sends 0x0
-			pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x1 or 0x0\n",
-			       __func__, j, (int)buffer[j]);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x1 or 0x0\n",
+				__func__, j, (int)buffer[j]);
 			unexpected = 1;
 		}
 		if (buffer[++j] != 0x0) { // [2]
-			pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x%x\n",
-			       __func__, j, (int)buffer[j], 0x0);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x%x\n",
+				__func__, j, (int)buffer[j], 0x0);
 			unexpected = 1;
 		}
 		++j;
@@ -2000,22 +2030,22 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 		// NI-USB-HS+ sends 0x0
 		if (buffer[j] != 0x1 && buffer[j] != 0x8 && buffer[j] != 0x7 && buffer[j] != 0x0) {
 			// [3]
-			pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x0, 0x1, 0x7 or 0x8\n",
-			       __func__, j, (int)buffer[j]);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x0, 0x1, 0x7 or 0x8\n",
+				__func__, j, (int)buffer[j]);
 			unexpected = 1;
 		}
 		++j;
 		// NI-USB-HS+ sends 0 here
 		if (buffer[j] != 0x30 && buffer[j] != 0x0) { // [4]
-			pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x0 or 0x30\n",
-			       __func__, j, (int)buffer[j]);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x0 or 0x30\n",
+				__func__, j, (int)buffer[j]);
 			unexpected = 1;
 		}
 		++j;
 		// MC usb-488 (and sometimes NI-USB-HS?) and NI-USB-HS+ sends 0x0 here
 		if (buffer[j] != 0x1 && buffer[j] != 0x0) { // [5]
-			pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x1 or 0x0\n",
-			       __func__, j, (int)buffer[j]);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x1 or 0x0\n",
+				__func__, j, (int)buffer[j]);
 			unexpected = 1;
 		}
 		if (buffer[++j] != 0x0) { // [6]
@@ -2023,8 +2053,8 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 			// NI-USB-HS+ sends 0xf here
 			if (buffer[j] != 0x2 && buffer[j] != 0xe && buffer[j] != 0xf &&
 			    buffer[j] != 0x16)	{
-				pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x2, 0xe, 0xf or 0x16\n",
-				       __func__, j, (int)buffer[j]);
+				dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x2, 0xe, 0xf or 0x16\n",
+					__func__, j, (int)buffer[j]);
 				unexpected = 1;
 			}
 		}
@@ -2033,30 +2063,30 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 			// MC usb-488 sends 0x5 here; MC usb-488A sends 0x6 here
 			if (buffer[j] != 0x3 && buffer[j] != 0x5 && buffer[j] != 0x6 &&
 			    buffer[j] != 0x8)	{
-				pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x3 or 0x5, 0x6 or 0x08\n",
-				       __func__, j, (int)buffer[j]);
+				dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x3 or 0x5, 0x6 or 0x08\n",
+					__func__, j, (int)buffer[j]);
 				unexpected = 1;
 			}
 		}
 		++j;
 		if (buffer[j] != 0x0 && buffer[j] != 0x2) { // [8] MC usb-488 sends 0x2 here
-			pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x0 or 0x2\n",
-			       __func__, j, (int)buffer[j]);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x0 or 0x2\n",
+				__func__, j, (int)buffer[j]);
 			unexpected = 1;
 		}
 		++j;
 		// MC usb-488A and NI-USB-HS sends 0x3 here; NI-USB-HS+ sends 0x30 here
 		if (buffer[j] != 0x0 && buffer[j] != 0x3 && buffer[j] != 0x30) { // [9]
-			pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x0, 0x3 or 0x30\n",
-			       __func__, j, (int)buffer[j]);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x0, 0x3 or 0x30\n",
+				__func__, j, (int)buffer[j]);
 			unexpected = 1;
 		}
 		if (buffer[++j] != 0x0) {
 			ready = 1;
 			if (buffer[j] != 0x96 && buffer[j] != 0x7 && buffer[j] != 0x6e) {
 // [10] MC usb-488 sends 0x7 here
-				pr_err("%s: unexpected data: buffer[%i]=0x%x, expected 0x96, 0x07 or 0x6e\n",
-				       __func__, j, (int)buffer[j]);
+				dev_err(&usb_dev->dev, "%s: unexpected data: buffer[%i]=0x%x, expected 0x96, 0x07 or 0x6e\n",
+					__func__, j, (int)buffer[j]);
 				unexpected = 1;
 			}
 		}
@@ -2066,7 +2096,7 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 			break;
 		retval = msleep_interruptible(msec_sleep_duration);
 		if (retval) {
-			pr_err("ni_usb_gpib: msleep interrupted\n");
+			dev_err(&usb_dev->dev, "ni_usb_gpib: msleep interrupted\n");
 			retval = -ERESTARTSYS;
 			goto ready_out;
 		}
@@ -2075,7 +2105,7 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 
 ready_out:
 	kfree(buffer);
-	GPIB_DPRINTK("%s: %s exit retval=%d\n", __func__, retval);
+	dev_dbg(&usb_dev->dev, "%s: exit retval=%d\n", __func__, retval);
 	return retval;
 }
 
@@ -2087,6 +2117,7 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
  */
 static int ni_usb_hs_plus_extra_init(struct ni_usb_priv *ni_priv)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	u8 *buffer;
 	static const int buffer_size = 16;
@@ -2102,14 +2133,14 @@ static int ni_usb_hs_plus_extra_init(struct ni_usb_priv *ni_priv)
 						    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 						    0x0, 0x0, buffer, transfer_size, 1000);
 		if (retval < 0) {
-			pr_err("%s: usb_control_msg request 0x%x returned %i\n",
-			       __FILE__, NI_USB_HS_PLUS_0x48_REQUEST, retval);
+			dev_err(&usb_dev->dev, "%s: usb_control_msg request 0x%x returned %i\n",
+				__func__, NI_USB_HS_PLUS_0x48_REQUEST, retval);
 			break;
 		}
 		// expected response data: 48 f3 30 00 00 00 00 00 00 00 00 00 00 00 00 00
 		if (buffer[0] != NI_USB_HS_PLUS_0x48_REQUEST)
-			pr_err("%s: unexpected data: buffer[0]=0x%x, expected 0x%x\n",
-			       __func__, (int)buffer[0], NI_USB_HS_PLUS_0x48_REQUEST);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[0]=0x%x, expected 0x%x\n",
+				__func__, (int)buffer[0], NI_USB_HS_PLUS_0x48_REQUEST);
 
 		transfer_size = 2;
 
@@ -2117,14 +2148,14 @@ static int ni_usb_hs_plus_extra_init(struct ni_usb_priv *ni_priv)
 						    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 						    0x1, 0x0, buffer, transfer_size, 1000);
 		if (retval < 0) {
-			pr_err("%s: usb_control_msg request 0x%x returned %i\n",
-			       __FILE__, NI_USB_HS_PLUS_LED_REQUEST, retval);
+			dev_err(&usb_dev->dev, "%s: usb_control_msg request 0x%x returned %i\n",
+				__func__, NI_USB_HS_PLUS_LED_REQUEST, retval);
 			break;
 		}
 		// expected response data: 4b 00
 		if (buffer[0] != NI_USB_HS_PLUS_LED_REQUEST)
-			pr_err("%s: unexpected data: buffer[0]=0x%x, expected 0x%x\n",
-			       __func__, (int)buffer[0], NI_USB_HS_PLUS_LED_REQUEST);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[0]=0x%x, expected 0x%x\n",
+				__func__, (int)buffer[0], NI_USB_HS_PLUS_LED_REQUEST);
 
 		transfer_size = 9;
 
@@ -2133,14 +2164,14 @@ static int ni_usb_hs_plus_extra_init(struct ni_usb_priv *ni_priv)
 						    USB_RECIP_INTERFACE,
 						    0x0, 0x1, buffer, transfer_size, 1000);
 		if (retval < 0) {
-			pr_err("%s: usb_control_msg request 0x%x returned %i\n",
-			       __func__, NI_USB_HS_PLUS_0xf8_REQUEST, retval);
+			dev_err(&usb_dev->dev, "%s: usb_control_msg request 0x%x returned %i\n",
+				__func__, NI_USB_HS_PLUS_0xf8_REQUEST, retval);
 			break;
 		}
 		// expected response data: f8 01 00 00 00 01 00 00 00
 		if (buffer[0] != NI_USB_HS_PLUS_0xf8_REQUEST)
-			pr_err("%s: unexpected data: buffer[0]=0x%x, expected 0x%x\n",
-			       __func__, (int)buffer[0], NI_USB_HS_PLUS_0xf8_REQUEST);
+			dev_err(&usb_dev->dev, "%s: unexpected data: buffer[0]=0x%x, expected 0x%x\n",
+				__func__, (int)buffer[0], NI_USB_HS_PLUS_0xf8_REQUEST);
 
 	} while (0);
 
@@ -2191,9 +2222,9 @@ static int ni_usb_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		return -ENODEV;
 	}
 	if (usb_reset_configuration(interface_to_usbdev(ni_priv->bus_interface)))
-		pr_err("ni_usb_gpib: usb_reset_configuration() failed.\n");
+		dev_err(&usb_dev->dev, "ni_usb_gpib: usb_reset_configuration() failed.\n");
 
-	product_id = le16_to_cpu(interface_to_usbdev(ni_priv->bus_interface)->descriptor.idProduct);
+	product_id = le16_to_cpu(usb_dev->descriptor.idProduct);
 	ni_priv->product_id = product_id;
 
 	timer_setup(&ni_priv->bulk_timer, ni_usb_timeout_handler, 0);
@@ -2234,7 +2265,8 @@ static int ni_usb_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		break;
 	default:
 		mutex_unlock(&ni_usb_hotplug_lock);
-		pr_err("\tDriver bug: unknown endpoints for usb device id\n");
+		dev_err(&usb_dev->dev, "\tDriver bug: unknown endpoints for usb device id %x\n",
+			product_id);
 		return -EINVAL;
 	}
 
@@ -2263,12 +2295,13 @@ static int ni_usb_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	}
 
 	mutex_unlock(&ni_usb_hotplug_lock);
-	pr_info("%s: attached\n", __func__);
+	dev_info(&usb_dev->dev, "%s: attached\n", __func__);
 	return retval;
 }
 
 static int ni_usb_shutdown_hardware(struct ni_usb_priv *ni_priv)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	int i = 0;
 	struct ni_usb_register writes[2];
@@ -2285,12 +2318,12 @@ static int ni_usb_shutdown_hardware(struct ni_usb_priv *ni_priv)
 	writes[i].value = 0x0;
 	i++;
 	if (i > writes_length) {
-		pr_err("%s: bug!, buffer overrun, i=%i\n", __func__, i);
+		dev_err(&usb_dev->dev, "%s: bug!, buffer overrun, i=%i\n", __func__, i);
 		return -EINVAL;
 	}
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return retval;
 	}
 	return 0;
@@ -2362,35 +2395,34 @@ MODULE_DEVICE_TABLE(usb, ni_usb_driver_device_table);
 
 static int ni_usb_driver_probe(struct usb_interface *interface,	const struct usb_device_id *id)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
 	int i;
 	char *path;
 	static const int path_length = 1024;
 
-//	printk("ni_usb_driver_probe\n");
 	mutex_lock(&ni_usb_hotplug_lock);
-	usb_get_dev(interface_to_usbdev(interface));
+	usb_get_dev(usb_dev);
 	for (i = 0; i < MAX_NUM_NI_USB_INTERFACES; i++) {
 		if (!ni_usb_driver_interfaces[i]) {
 			ni_usb_driver_interfaces[i] = interface;
 			usb_set_intfdata(interface, NULL);
-//			printk("set bus interface %i to address 0x%p\n", i, interface);
 			break;
 		}
 	}
 	if (i == MAX_NUM_NI_USB_INTERFACES) {
-		usb_put_dev(interface_to_usbdev(interface));
+		usb_put_dev(usb_dev);
 		mutex_unlock(&ni_usb_hotplug_lock);
-		pr_err("ni_usb_gpib: out of space in ni_usb_driver_interfaces[]\n");
+		dev_err(&usb_dev->dev, "%s: ni_usb_driver_interfaces[] full\n", __func__);
 		return -1;
 	}
 	path = kmalloc(path_length, GFP_KERNEL);
 	if (!path) {
-		usb_put_dev(interface_to_usbdev(interface));
+		usb_put_dev(usb_dev);
 		mutex_unlock(&ni_usb_hotplug_lock);
 		return -ENOMEM;
 	}
-	usb_make_path(interface_to_usbdev(interface), path, path_length);
-	pr_info("ni_usb_gpib: probe succeeded for path: %s\n", path);
+	usb_make_path(usb_dev, path, path_length);
+	dev_info(&usb_dev->dev, "ni_usb_gpib: probe succeeded for path: %s\n", path);
 	kfree(path);
 	mutex_unlock(&ni_usb_hotplug_lock);
 	return 0;
@@ -2398,6 +2430,7 @@ static int ni_usb_driver_probe(struct usb_interface *interface,	const struct usb
 
 static void ni_usb_driver_disconnect(struct usb_interface *interface)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
 	int i;
 
 	mutex_lock(&ni_usb_hotplug_lock);
@@ -2424,14 +2457,15 @@ static void ni_usb_driver_disconnect(struct usb_interface *interface)
 		}
 	}
 	if (i == MAX_NUM_NI_USB_INTERFACES)
-		pr_err("unable to find interface in ni_usb_driver_interfaces[]? bug?\n");
-	usb_put_dev(interface_to_usbdev(interface));
+		dev_err(&usb_dev->dev, "%s: unable to find interface in ni_usb_driver_interfaces[]? bug?\n",
+			__func__);
+	usb_put_dev(usb_dev);
 	mutex_unlock(&ni_usb_hotplug_lock);
 }
 
 static int ni_usb_driver_suspend(struct usb_interface *interface, pm_message_t message)
 {
-	struct usb_device *usb_dev;
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
 	gpib_board_t *board;
 	int i, retval;
 
@@ -2463,7 +2497,6 @@ static int ni_usb_driver_suspend(struct usb_interface *interface, pm_message_t m
 			ni_usb_cleanup_urbs(ni_priv);
 			mutex_unlock(&ni_priv->interrupt_transfer_lock);
 		}
-		usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 		dev_info(&usb_dev->dev,
 			 "bus %d dev num %d  gpib minor %d, ni usb interface %i suspended\n",
 			 usb_dev->bus->busnum, usb_dev->devnum, board->minor, i);
@@ -2475,7 +2508,8 @@ static int ni_usb_driver_suspend(struct usb_interface *interface, pm_message_t m
 
 static int ni_usb_driver_resume(struct usb_interface *interface)
 {
-	struct usb_device *usb_dev;
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
+
 	gpib_board_t *board;
 	int i, retval;
 
@@ -2500,15 +2534,15 @@ static int ni_usb_driver_resume(struct usb_interface *interface)
 			mutex_lock(&ni_priv->interrupt_transfer_lock);
 			retval = usb_submit_urb(ni_priv->interrupt_urb, GFP_KERNEL);
 			if (retval) {
-				pr_err("%s: failed to resubmit interrupt urb, retval=%i\n",
-				       __func__, retval);
+				dev_err(&usb_dev->dev, "%s: failed to resubmit interrupt urb, retval=%i\n",
+					__func__, retval);
 				mutex_unlock(&ni_priv->interrupt_transfer_lock);
 				mutex_unlock(&ni_usb_hotplug_lock);
 				return retval;
 			}
 			mutex_unlock(&ni_priv->interrupt_transfer_lock);
 		} else {
-			pr_err("%s: bug! int urb not set up\n", __func__);
+			dev_err(&usb_dev->dev, "%s: bug! int urb not set up\n", __func__);
 			mutex_unlock(&ni_usb_hotplug_lock);
 			return -EINVAL;
 		}
@@ -2540,7 +2574,7 @@ static int ni_usb_driver_resume(struct usb_interface *interface)
 			break;
 		default:
 			mutex_unlock(&ni_usb_hotplug_lock);
-			pr_err("\tDriver bug: unknown endpoints for usb device id\n");
+			dev_err(&usb_dev->dev, "\tDriver bug: unknown endpoints for usb device id\n");
 			return -EINVAL;
 		}
 
@@ -2565,7 +2599,6 @@ static int ni_usb_driver_resume(struct usb_interface *interface)
 		if (ni_priv->ren_state)
 			ni_usb_remote_enable(board, 1);
 
-		usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 		dev_info(&usb_dev->dev,
 			 "bus %d dev num %d  gpib minor %d, ni usb interface %i resumed\n",
 			 usb_dev->bus->busnum, usb_dev->devnum, board->minor, i);
-- 
2.46.2


