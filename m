Return-Path: <linux-kernel+bounces-393987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E839BA84D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243A4281225
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6F18DF6E;
	Sun,  3 Nov 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxbyXxD7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAD18BC15
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669197; cv=none; b=IylCw44SgVtdqN2Y8AjIc2NnIxhe7prOqLEVAsnmbgSTmJvt5yVRPOPcSVQ19cRJmYFME16K5Uw0Qb4Js0O0iWBxDRWSprwD2HmPPo5ppztBAbe0RBqS1w2HDiFAklE0FjMeyL8IUTpqVnKFhn6SaJdoVfHVme9oz2cyAD0e9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669197; c=relaxed/simple;
	bh=8tOooZSqjZLktK11SFQlQMuq3FUWL4flmY68otICPp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUoBNeqv2y22MFi2hUvXq5uhLBRh5sG/vHcY7y5bpmW22nWi5MYlHXob5vO9FRwHbuZq0aDryqQmCpkxctxcJbG6jYpBwP6ZYvqURpViX2js3rBHL1cLXYMIvdgjMUEn8cIc95eZ3u42Ozy+OyWfjjzah8dypz9SkwZtL72FwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxbyXxD7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so31471875e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669191; x=1731273991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuHJvsgGH4bf1MV0j7IEBdB41iQSPKkdiyMMwagJFNc=;
        b=gxbyXxD7ZwGHNxZMV4gMAaPPNc8t7+J47rJS0dLkW8AfzpkmoxWpIY90Rweqw80j/O
         k1Nl+85mxNBYRtGnzs9aleJ4H0R4NqQQNZR/WyWW8DVZUNJLF7m10abglszOTRWvEOhM
         WdUMkyn8z85xzRbOcL9UdesR1guUTf63qPMP3ONuT0PcJ1Fy5vh1xKhk8dw5stBb+sZq
         NdW2BJod+mbUR10EXT8IbG7bnkkwuSiuwyAs6rNxWVTDeRWJnXuhXCHmHrVOXijhXJNN
         98VF8NuH9t+tp333PFYc5m2VlwMIerePfuzVfGruCm1YmRZ13NslRNP4og9MXJZ08xO+
         HxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669191; x=1731273991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuHJvsgGH4bf1MV0j7IEBdB41iQSPKkdiyMMwagJFNc=;
        b=SAyla4ppYHPwvrSDvyYWuasZ9d2EhocBEfY6d1zkX7TzmFnLPzVC6+H9fomLU8TFJE
         xvP9kyv5wFn/pGrE9oM67I9j/fuQRISFORN9ptkNDi5++idvw4KUmD5par7X7oxdHXYF
         qUiI3MjDMChlHjKmlb9qPwVBwo3HSJ6/RmT5p6NPS5ezSzHTur+yxAhEKEHy77RWMM9Q
         j57dcnRuybZ66uBcMLHcHNNVuZwOVT7hqOC92NE01T/Q2pZVlnEFUrX/AsX7vCjlmVI/
         0AEEUuGeSKi/QhBjwEJ6crRf4/Kze0n9z2p6TY/uR4xz/M9oG8jqttsYLQ9PQRkrMUZM
         MvAA==
X-Forwarded-Encrypted: i=1; AJvYcCWYlaICw7UhPrSCdndTWst14AHsKEj3Hdj1ltoCIBD6sa6mdiKPY9Xhlm1tEsdpOlK5eckyknVRZTz8q5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSugesy+itzmU+IOuOQs78/lw4RVwyrS2SzQaRzVvSUX21eXf
	TL6hZoome1Njwm3JVgJIgnKpwgrr8gRqrYUa8TRb5S8XD0P4CxSB
X-Google-Smtp-Source: AGHT+IHkYW4ZmVsn1GpREt01QwKzE0NYJxTSHzeClAxmUqHq4hIyJSZyEVuiLvaAYQWEN9te0CejKg==
X-Received: by 2002:a05:600c:35d0:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-4327b8214aemr130432125e9.31.1730669190745;
        Sun, 03 Nov 2024 13:26:30 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:29 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 03/11] staging: gpib: Update messaging and usb_device refs in ni_usb
Date: Sun,  3 Nov 2024 22:26:09 +0100
Message-ID: <20241103212617.13076-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103212617.13076-1-dpenkler@gmail.com>
References: <20241103212617.13076-1-dpenkler@gmail.com>
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
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 376 ++++++++++++----------
 1 file changed, 204 insertions(+), 172 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index b7550a937f15..b7b6fb1be379 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -132,13 +132,13 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
 	if (timeout_msecs)
 		mod_timer(&ni_priv->bulk_timer, jiffies + msecs_to_jiffies(timeout_msecs));
 
-	//pr_err("%s: submitting urb\n", __func__);
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
@@ -146,7 +146,7 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
 	down(&context->complete);    // wait for ni_usb_bulk_complete
 	if (context->timed_out) {
 		usb_kill_urb(ni_priv->bulk_urb);
-		pr_err("%s: killed urb due to timeout\n", __func__);
+		dev_err(&usb_dev->dev, "%s: killed urb due to timeout\n", __func__);
 		retval = -ETIMEDOUT;
 	} else {
 		retval = ni_priv->bulk_urb->status;
@@ -224,7 +224,8 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 		del_timer_sync(&ni_priv->bulk_timer);
 		usb_free_urb(ni_priv->bulk_urb);
 		ni_priv->bulk_urb = NULL;
-		pr_err("%s: failed to submit bulk out urb, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: failed to submit bulk out urb, retval=%i\n",
+			__func__, retval);
 		mutex_unlock(&ni_priv->bulk_transfer_lock);
 		return retval;
 	}
@@ -249,7 +250,7 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 	}
 	if (context->timed_out) {
 		usb_kill_urb(ni_priv->bulk_urb);
-		pr_err("%s: killed urb due to timeout\n", __func__);
+		dev_err(&usb_dev->dev, "%s: killed urb due to timeout\n", __func__);
 		retval = -ETIMEDOUT;
 	} else {
 		if (ni_priv->bulk_urb->status)
@@ -315,6 +316,7 @@ static void ni_usb_soft_update_status(gpib_board_t *board, unsigned int ni_usb_i
 	static const unsigned int ni_usb_ibsta_mask = SRQI | ATN | CIC | REM | LACS | TACS | LOK;
 
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	unsigned int need_monitoring_bits = ni_usb_ibsta_monitor_mask;
 	unsigned long flags;
 
@@ -328,15 +330,14 @@ static void ni_usb_soft_update_status(gpib_board_t *board, unsigned int ni_usb_i
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
@@ -355,7 +356,6 @@ static int ni_usb_parse_status_block(const u8 *buffer, struct ni_usb_status_bloc
 
 static void ni_usb_dump_raw_block(const u8 *raw_data, int length)
 {
-	pr_info("hex block dump\n");
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 8, 1, raw_data, length, true);
 }
 
@@ -516,6 +516,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 				  const struct ni_usb_register *writes, int num_writes,
 				  unsigned int *ibsta)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	u8 *out_data, *in_data;
 	int out_data_length;
@@ -530,7 +531,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 	out_data_length = num_writes * bytes_per_write + 0x10;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)	{
-		pr_err("%s: kmalloc failed\n", __func__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	i += ni_usb_bulk_register_write_header(&out_data[i], num_writes);
@@ -540,7 +541,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 		out_data[i++] = 0x00;
 	i += ni_usb_bulk_termination(&out_data[i]);
 	if (i > out_data_length)
-		pr_err("%s: bug! buffer overrun\n", __func__);
+		dev_err(&usb_dev->dev, "%s: bug! buffer overrun\n", __func__);
 
 	mutex_lock(&ni_priv->addressed_transfer_lock);
 
@@ -548,22 +549,22 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
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
@@ -575,17 +576,18 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
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
@@ -599,6 +601,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval, parse_retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	int in_data_length;
@@ -613,7 +616,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	*bytes_read = 0;
 	if (length > max_read_length)	{
 		length = max_read_length;
-		pr_err("%s: read length too long\n", __func__);
+		dev_err(&usb_dev->dev, "%s: read length too long\n", __func__);
 	}
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
@@ -646,8 +649,8 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
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
@@ -665,8 +668,8 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 
 	if (retval == -ERESTARTSYS) {
 	} else if (retval) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, usb_bytes_read=%i\n",
-		       __func__, retval, usb_bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, usb_bytes_read=%i\n",
+			__func__, retval, usb_bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -674,14 +677,14 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
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
@@ -696,7 +699,7 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 		break;
 	case NIUSB_ATN_STATE_ERROR:
 		retval = -EIO;
-		pr_err("%s: read when ATN set\n", __func__);
+		dev_err(&usb_dev->dev, "%s: read when ATN set\n", __func__);
 		break;
 	case NIUSB_ADDRESSING_ERROR:
 		retval = -EIO;
@@ -705,12 +708,12 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
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
@@ -728,6 +731,7 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -741,7 +745,7 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	if (length > max_write_length) {
 		length = max_write_length;
 		send_eoi = 0;
-		pr_err("%s: write length too long\n", __func__);
+		dev_err(&usb_dev->dev, "%s: write length too long\n", __func__);
 	}
 	out_data_length = length + 0x10;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
@@ -773,8 +777,8 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	kfree(out_data);
 	if (retval || usb_bytes_written != i)	{
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, usb_bytes_written=%i, i=%i\n",
-		       __func__, retval, usb_bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, usb_bytes_written=%i, i=%i\n",
+			__func__, retval, usb_bytes_written, i);
 		return retval;
 	}
 
@@ -787,8 +791,8 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	mutex_unlock(&ni_priv->addressed_transfer_lock);
 
 	if ((retval && retval != -ERESTARTSYS) || usb_bytes_read != 12) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, usb_bytes_read=%i\n",
-		       __func__, retval, usb_bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, usb_bytes_read=%i\n",
+			__func__, retval, usb_bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -804,8 +808,8 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
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
@@ -815,8 +819,8 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
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
@@ -830,6 +834,7 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	int out_data_length;
 	static const int in_data_length = 0x10;
@@ -866,8 +871,8 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 	kfree(out_data);
 	if (retval || bytes_written != i) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		return retval;
 	}
 
@@ -883,8 +888,8 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
 	mutex_unlock(&ni_priv->addressed_transfer_lock);
 
 	if ((retval && retval != -ERESTARTSYS) || bytes_read != 12) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -902,12 +907,12 @@ static int ni_usb_command_chunk(gpib_board_t *board, uint8_t *buffer, size_t len
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
@@ -935,6 +940,7 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -960,15 +966,15 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
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
@@ -978,8 +984,8 @@ static int ni_usb_take_control(gpib_board_t *board, int synchronous)
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
@@ -993,6 +999,7 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -1016,15 +1023,15 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
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
@@ -1032,16 +1039,16 @@ static int ni_usb_go_to_standby(gpib_board_t *board)
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
@@ -1050,6 +1057,7 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[4];
 	unsigned int ibsta;
@@ -1083,7 +1091,7 @@ static void ni_usb_request_system_control(gpib_board_t *board, int request_contr
 	}
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return; // retval;
 	}
 	if (!request_control)
@@ -1097,6 +1105,7 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x10;
@@ -1109,7 +1118,7 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 		return;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)	{
-		pr_err("%s: kmalloc failed\n", __FILE__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return;
 	}
 	out_data[i++] = NIUSB_IBSIC_ID;
@@ -1120,8 +1129,8 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
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
@@ -1130,8 +1139,8 @@ static void ni_usb_interface_clear(gpib_board_t *board, int assert)
 
 	retval = ni_usb_receive_bulk_msg(ni_priv, in_data, in_data_length, &bytes_read, 1000, 0);
 	if (retval || bytes_read != 12) {
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		kfree(in_data);
 		return;
 	}
@@ -1144,6 +1153,7 @@ static void ni_usb_remote_enable(gpib_board_t *board, int enable)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	struct ni_usb_register reg;
 	unsigned int ibsta;
 
@@ -1155,7 +1165,7 @@ static void ni_usb_remote_enable(gpib_board_t *board, int enable)
 		reg.value = AUX_CREN;
 	retval = ni_usb_write_registers(ni_priv, &reg, 1, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return; //retval;
 	}
 	ni_priv->ren_state = enable;
@@ -1190,11 +1200,12 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
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
@@ -1203,7 +1214,7 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
 					    USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 					    0x200, 0x0, buffer, buffer_length, 1000);
 	if (retval != buffer_length) {
-		pr_err("%s: usb_control_msg returned %i\n", __FILE__, retval);
+		dev_err(&usb_dev->dev, "%s: usb_control_msg returned %i\n", __func__, retval);
 		kfree(buffer);
 		return board->status;
 	}
@@ -1216,12 +1227,13 @@ static unsigned int ni_usb_update_status(gpib_board_t *board, unsigned int clear
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
@@ -1230,7 +1242,7 @@ static void ni_usb_stop(struct ni_usb_priv *ni_priv)
 					    USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 					    0x0, 0x0, buffer, buffer_length, 1000);
 	if (retval != buffer_length) {
-		pr_err("%s: usb_control_msg returned %i\n", __FILE__, retval);
+		dev_err(&usb_dev->dev, "%s: usb_control_msg returned %i\n", __func__, retval);
 		kfree(buffer);
 		return;
 	}
@@ -1242,6 +1254,7 @@ static int ni_usb_primary_address(gpib_board_t *board, unsigned int address)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[2];
 	unsigned int ibsta;
@@ -1256,7 +1269,7 @@ static int ni_usb_primary_address(gpib_board_t *board, unsigned int address)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1296,6 +1309,7 @@ static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, i
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[3];
 	unsigned int ibsta;
@@ -1303,7 +1317,7 @@ static int ni_usb_secondary_address(gpib_board_t *board, unsigned int address, i
 	i += ni_usb_write_sad(writes, address, enable);
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1314,6 +1328,7 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x10;
 	static const int  in_data_length = 0x20;
@@ -1336,8 +1351,8 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 
 	kfree(out_data);
 	if (retval || bytes_written != i) {
-		pr_err("%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: ni_usb_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		return retval;
 	}
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
@@ -1349,8 +1364,8 @@ static int ni_usb_parallel_poll(gpib_board_t *board, uint8_t *result)
 					 &bytes_read, 1000, 1);
 
 	if (retval && retval != -ERESTARTSYS)	{
-		pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -1365,6 +1380,7 @@ static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
@@ -1375,7 +1391,7 @@ static void ni_usb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return;// retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1386,6 +1402,7 @@ static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
@@ -1399,7 +1416,7 @@ static void ni_usb_parallel_poll_response(gpib_board_t *board, int ist)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return;// retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1410,6 +1427,7 @@ static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
@@ -1420,7 +1438,7 @@ static void ni_usb_serial_poll_response(gpib_board_t *board, u8 status)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return;// retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1436,6 +1454,7 @@ static void ni_usb_return_to_local(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int i = 0;
 	struct ni_usb_register writes[1];
 	unsigned int ibsta;
@@ -1446,7 +1465,7 @@ static void ni_usb_return_to_local(gpib_board_t *board)
 	i++;
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return;// retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1457,6 +1476,7 @@ static int ni_usb_line_status(const gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	static const int  in_data_length = 0x20;
@@ -1487,15 +1507,15 @@ static int ni_usb_line_status(const gpib_board_t *board)
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
@@ -1505,8 +1525,8 @@ static int ni_usb_line_status(const gpib_board_t *board)
 
 	if (retval) {
 		if (retval != -EAGAIN)
-			pr_err("%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
-			       __func__, retval, bytes_read);
+			dev_err(&usb_dev->dev, "%s: ni_usb_receive_bulk_msg returned %i, bytes_read=%i\n",
+				__func__, retval, bytes_read);
 		kfree(in_data);
 		return retval;
 	}
@@ -1573,6 +1593,7 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	struct ni_usb_register writes[3];
 	unsigned int ibsta;
 	unsigned int actual_ns;
@@ -1581,7 +1602,7 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 	i = ni_usb_setup_t1_delay(writes, nano_sec, &actual_ns);
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return -1;	//FIXME should change return type to int for error reporting
 	}
 	board->t1_nano_sec = actual_ns;
@@ -1615,6 +1636,7 @@ static void ni_usb_free_private(struct ni_usb_priv *ni_priv)
 static int ni_usb_setup_init(gpib_board_t *board, struct ni_usb_register *writes)
 {
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	unsigned int mask, actual_ns;
 	int i = 0;
 
@@ -1712,7 +1734,7 @@ static int ni_usb_setup_init(gpib_board_t *board, struct ni_usb_register *writes
 	writes[i].value = AUX_CPPF;
 	i++;
 	if (i > NUM_INIT_WRITES) {
-		pr_err("%s: bug!, buffer overrun, i=%i\n", __func__, i);
+		dev_err(&usb_dev->dev, "%s: bug!, buffer overrun, i=%i\n", __func__, i);
 		return 0;
 	}
 	return i;
@@ -1722,6 +1744,7 @@ static int ni_usb_init(gpib_board_t *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	struct ni_usb_register *writes;
 	unsigned int ibsta;
 	int writes_len;
@@ -1737,7 +1760,7 @@ static int ni_usb_init(gpib_board_t *board)
 		return -EFAULT;
 	kfree(writes);
 	if (retval) {
-		pr_err("%s: register write failed, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: register write failed, retval=%i\n", __func__, retval);
 		return retval;
 	}
 	ni_usb_soft_update_status(board, ibsta, 0);
@@ -1748,6 +1771,7 @@ static void ni_usb_interrupt_complete(struct urb *urb)
 {
 	gpib_board_t *board = urb->context;
 	struct ni_usb_priv *ni_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	struct ni_usb_status_block status;
 	unsigned long flags;
@@ -1767,7 +1791,7 @@ static void ni_usb_interrupt_complete(struct urb *urb)
 	default: /* other error, resubmit */
 		retval = usb_submit_urb(ni_priv->interrupt_urb, GFP_ATOMIC);
 		if (retval)
-			pr_err("%s: failed to resubmit interrupt urb\n", __func__);
+			dev_err(&usb_dev->dev, "%s: failed to resubmit interrupt urb\n", __func__);
 		return;
 	}
 
@@ -1783,32 +1807,34 @@ static void ni_usb_interrupt_complete(struct urb *urb)
 
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
@@ -1844,7 +1870,8 @@ static int ni_usb_setup_urbs(gpib_board_t *board)
 	retval = usb_submit_urb(ni_priv->interrupt_urb, GFP_KERNEL);
 	mutex_unlock(&ni_priv->interrupt_transfer_lock);
 	if (retval) {
-		pr_err("%s: failed to submit first interrupt urb, retval=%i\n", __FILE__, retval);
+		dev_err(&usb_dev->dev, "%s: failed to submit first interrupt urb, retval=%i\n",
+			__func__, retval);
 		return retval;
 	}
 	return 0;
@@ -1862,6 +1889,7 @@ static void ni_usb_cleanup_urbs(struct ni_usb_priv *ni_priv)
 
 static int ni_usb_b_read_serial_number(struct ni_usb_priv *ni_priv)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	u8 *out_data;
 	u8 *in_data;
@@ -1894,20 +1922,20 @@ static int ni_usb_b_read_serial_number(struct ni_usb_priv *ni_priv)
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
@@ -1915,7 +1943,7 @@ static int ni_usb_b_read_serial_number(struct ni_usb_priv *ni_priv)
 	serial_number = 0;
 	for (j = 0; j < num_reads; ++j)
 		serial_number |= (results[j] & 0xff) << (8 * j);
-	pr_info("%s: board serial number is 0x%x\n", __func__, serial_number);
+	dev_info(&usb_dev->dev, "%s: board serial number is 0x%x\n", __func__, serial_number);
 	retval = 0;
 serial_out:
 	kfree(in_data);
@@ -1925,6 +1953,7 @@ static int ni_usb_b_read_serial_number(struct ni_usb_priv *ni_priv)
 
 static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	static const int buffer_size = 0x10;
 	static const int timeout = 50;
 	static const int msec_sleep_duration = 100;
@@ -1942,22 +1971,22 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
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
@@ -1965,7 +1994,7 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 	serial_number |= (buffer[++j] << 8);
 	serial_number |= (buffer[++j] << 16);
 	serial_number |= (buffer[++j] << 24);
-	pr_info("%s: board serial number is 0x%x\n", __func__, serial_number);
+	dev_info(&usb_dev->dev, "%s: board serial number is 0x%x\n", __func__, serial_number);
 	for (i = 0; i < timeout; ++i) {
 		int ready = 0;
 
@@ -1973,26 +2002,26 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
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
@@ -2000,22 +2029,22 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
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
@@ -2023,8 +2052,8 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
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
@@ -2033,30 +2062,30 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
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
@@ -2066,7 +2095,7 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 			break;
 		retval = msleep_interruptible(msec_sleep_duration);
 		if (retval) {
-			pr_err("ni_usb_gpib: msleep interrupted\n");
+			dev_err(&usb_dev->dev, "ni_usb_gpib: msleep interrupted\n");
 			retval = -ERESTARTSYS;
 			goto ready_out;
 		}
@@ -2075,7 +2104,7 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
 
 ready_out:
 	kfree(buffer);
-	GPIB_DPRINTK("%s: %s exit retval=%d\n", __func__, retval);
+	dev_dbg(&usb_dev->dev, "%s: exit retval=%d\n", __func__, retval);
 	return retval;
 }
 
@@ -2087,6 +2116,7 @@ static int ni_usb_hs_wait_for_ready(struct ni_usb_priv *ni_priv)
  */
 static int ni_usb_hs_plus_extra_init(struct ni_usb_priv *ni_priv)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	int retval;
 	u8 *buffer;
 	static const int buffer_size = 16;
@@ -2102,14 +2132,14 @@ static int ni_usb_hs_plus_extra_init(struct ni_usb_priv *ni_priv)
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
 
@@ -2117,14 +2147,14 @@ static int ni_usb_hs_plus_extra_init(struct ni_usb_priv *ni_priv)
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
 
@@ -2133,14 +2163,14 @@ static int ni_usb_hs_plus_extra_init(struct ni_usb_priv *ni_priv)
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
 
@@ -2191,9 +2221,9 @@ static int ni_usb_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		return -ENODEV;
 	}
 	if (usb_reset_configuration(interface_to_usbdev(ni_priv->bus_interface)))
-		pr_err("ni_usb_gpib: usb_reset_configuration() failed.\n");
+		dev_err(&usb_dev->dev, "ni_usb_gpib: usb_reset_configuration() failed.\n");
 
-	product_id = le16_to_cpu(interface_to_usbdev(ni_priv->bus_interface)->descriptor.idProduct);
+	product_id = le16_to_cpu(usb_dev->descriptor.idProduct);
 	ni_priv->product_id = product_id;
 
 	timer_setup(&ni_priv->bulk_timer, ni_usb_timeout_handler, 0);
@@ -2234,7 +2264,8 @@ static int ni_usb_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		break;
 	default:
 		mutex_unlock(&ni_usb_hotplug_lock);
-		pr_err("\tDriver bug: unknown endpoints for usb device id\n");
+		dev_err(&usb_dev->dev, "\tDriver bug: unknown endpoints for usb device id %x\n",
+			product_id);
 		return -EINVAL;
 	}
 
@@ -2263,12 +2294,13 @@ static int ni_usb_attach(gpib_board_t *board, const gpib_board_config_t *config)
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
@@ -2285,12 +2317,12 @@ static int ni_usb_shutdown_hardware(struct ni_usb_priv *ni_priv)
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
@@ -2362,35 +2394,34 @@ MODULE_DEVICE_TABLE(usb, ni_usb_driver_device_table);
 
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
@@ -2398,6 +2429,7 @@ static int ni_usb_driver_probe(struct usb_interface *interface,	const struct usb
 
 static void ni_usb_driver_disconnect(struct usb_interface *interface)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
 	int i;
 
 	mutex_lock(&ni_usb_hotplug_lock);
@@ -2424,14 +2456,15 @@ static void ni_usb_driver_disconnect(struct usb_interface *interface)
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
 
@@ -2463,7 +2496,6 @@ static int ni_usb_driver_suspend(struct usb_interface *interface, pm_message_t m
 			ni_usb_cleanup_urbs(ni_priv);
 			mutex_unlock(&ni_priv->interrupt_transfer_lock);
 		}
-		usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 		dev_info(&usb_dev->dev,
 			 "bus %d dev num %d  gpib minor %d, ni usb interface %i suspended\n",
 			 usb_dev->bus->busnum, usb_dev->devnum, board->minor, i);
@@ -2475,7 +2507,8 @@ static int ni_usb_driver_suspend(struct usb_interface *interface, pm_message_t m
 
 static int ni_usb_driver_resume(struct usb_interface *interface)
 {
-	struct usb_device *usb_dev;
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
+
 	gpib_board_t *board;
 	int i, retval;
 
@@ -2500,15 +2533,15 @@ static int ni_usb_driver_resume(struct usb_interface *interface)
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
@@ -2540,7 +2573,7 @@ static int ni_usb_driver_resume(struct usb_interface *interface)
 			break;
 		default:
 			mutex_unlock(&ni_usb_hotplug_lock);
-			pr_err("\tDriver bug: unknown endpoints for usb device id\n");
+			dev_err(&usb_dev->dev, "\tDriver bug: unknown endpoints for usb device id\n");
 			return -EINVAL;
 		}
 
@@ -2565,7 +2598,6 @@ static int ni_usb_driver_resume(struct usb_interface *interface)
 		if (ni_priv->ren_state)
 			ni_usb_remote_enable(board, 1);
 
-		usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 		dev_info(&usb_dev->dev,
 			 "bus %d dev num %d  gpib minor %d, ni usb interface %i resumed\n",
 			 usb_dev->bus->busnum, usb_dev->devnum, board->minor, i);
-- 
2.46.2


