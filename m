Return-Path: <linux-kernel+bounces-393989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B299BA84F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F19A1C208EC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3718E02E;
	Sun,  3 Nov 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e770Dnga"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB018C009
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669198; cv=none; b=PB6PfuIkVjw92rEywO/1D0EH9pqDMNLnKOik4n30i4x3dB+6HTcCcZYGVADxoOPfYolhs546KXy0Qgno67TwKLjv7CW2rt2PU0iCgaCHO9s6qqb/97HvCUhvI5QcY33hu6b/BFJ2mOc5BkMarCWajIN2ZtqbNJdX91cbJgtPJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669198; c=relaxed/simple;
	bh=tyF/tkkq0ode+3XoBmHOVLqZeaUsXsr5YNVhW5ykwt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/e1j22qaotiwEyPed2PougKS4EJwD/TTqz+RDL9GAUD/WE/i5wtYVBUyUKEmQxaaBTtvwDRpVAhI0n/T3nWdVODcFRgveq3B9pTV1QOrLDUXYFQ1TzdB4O582ljXa4db/AtDe2fmaJtJQWxfZU5DzTRC4yOUTfOfJzq+l3LCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e770Dnga; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d533b5412so2066110f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669193; x=1731273993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUy0R3eXiLa29ETn6DgdOhIEEP6/w5DcQyqQiU4TqzM=;
        b=e770Dnga2QoMzUPeEoAiQT4KyM7n/QD9kbk1so4homlOvZzhLjmDFY5oOd/VXYzmtd
         NYDXMitlbT16KqRL0Aca5G2A1hokrBNZN2tTnnjTWVEaYnXZjX1eV7N7vq14c6+dywfX
         RlKMPyWDaWSqUhNxukUtGzHL4AQUdk4fd8f+8/uCJlS0zbnbK18LKtLSGbsoESpimigq
         U/Rt7H7ogG+33r9Zj/tsPJJJHnNVJWfK+epEIFqwWO/v6s1Who2ILqaCPEHR5wz3t5rW
         ZrvNKys1O45vRD9DGN9V/CDKlzQCrrjRBtGYElIJVvLJraXJR1H17W29EnGNVpmZKSyM
         Q7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669193; x=1731273993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUy0R3eXiLa29ETn6DgdOhIEEP6/w5DcQyqQiU4TqzM=;
        b=G2AItRoUXhnzNtsc16vvQXfNMzkbLrrw+kxyUDoIBr+MoYBX62LRgKZ/MMxVlcM3ee
         Te3VCTwoq7HzXwsBegP3oQopyktv3iA+jA7f8Jd8/7HmmYhxVw7hICksqrZQAK0dvSVV
         Jy1Yt4pEh4mMNCCw+DnXHBlyTki7xJIoki9uH/jmvq/1R0iSH7ctDvRFFHOFo1h00toq
         wOYFtwOY7vjyF5vk0Kj+mLZxn28YBw6nT/3V6Ly5j8ey/htcbQ245qxcpuyznBH6lS+8
         lg3Gys/3kHY6ZT98flEnljkHQF3ECqSe5GuJDqORTu7NEcRfOi81b/yVWa/6AEn+e9nw
         F/5w==
X-Forwarded-Encrypted: i=1; AJvYcCV1DDBs7RjnYdOIdcTYPsPgpg30fpfRTDY4hsRt5vLcduLu3DnWrPsbw6Qa9alvyREdIavEjwEHyPr2rSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRi5rynWlgyUzmHc3HIfNVUHmbeIjLzOBlEtxwd5vxTDUgMrPY
	a2Kjr3+E/a4uaeojnYdaELSeSmPrH5gFffFB3KIzOTRLL7DUNgd+80OBfwpy
X-Google-Smtp-Source: AGHT+IFQslb6Bn98BfmuhVKLodIuyCBIF8rVY3m+Y857egZcrLtoeViImIVsiyL1z/BgJQiGoIiuQw==
X-Received: by 2002:a5d:55c4:0:b0:37d:47fe:7c59 with SMTP id ffacd0b85a97d-3806100cecemr21934406f8f.0.1730669192668;
        Sun, 03 Nov 2024 13:26:32 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:31 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 04/11] staging: gpib: Update messaging and usb_device refs in agilent_usb
Date: Sun,  3 Nov 2024 22:26:10 +0100
Message-ID: <20241103212617.13076-5-dpenkler@gmail.com>
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
Use previously initialized usb_device pointer for usb_put_dev()

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 .../gpib/agilent_82357a/agilent_82357a.c      | 266 ++++++++++--------
 1 file changed, 156 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 748aadc5cebc..68b40831b9ad 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -15,11 +15,11 @@
 #include "tms9914.h"
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapter");
+MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapters");
 
 #define MAX_NUM_82357A_INTERFACES 128
 static struct usb_interface *agilent_82357a_driver_interfaces[MAX_NUM_82357A_INTERFACES];
-DEFINE_MUTEX(agilent_82357a_hotplug_lock);
+DEFINE_MUTEX(agilent_82357a_hotplug_lock); // protect board insertion and removal
 
 static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned int clear_mask);
 
@@ -29,9 +29,6 @@ static void agilent_82357a_bulk_complete(struct urb *urb)
 {
 	struct agilent_82357a_urb_ctx *context = urb->context;
 
-//	printk("debug: %s: status=0x%x, error_count=%i, actual_length=%i\n", __func__,
-//		urb->status, urb->error_count, urb->actual_length);
-
 	up(&context->complete);
 }
 
@@ -80,16 +77,17 @@ static int agilent_82357a_send_bulk_msg(struct agilent_82357a_priv *a_priv, void
 	if (timeout_msecs)
 		mod_timer(&a_priv->bulk_timer, jiffies + msecs_to_jiffies(timeout_msecs));
 
-	//printk("%s: submitting urb\n", __func__);
+	//dev_dbg(&usb_dev->dev, "%s: submitting urb\n", __func__);
 	retval = usb_submit_urb(a_priv->bulk_urb, GFP_KERNEL);
 	if (retval) {
-		pr_err("%s: failed to submit bulk out urb, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: failed to submit bulk out urb, retval=%i\n",
+			__func__, retval);
 		mutex_unlock(&a_priv->bulk_alloc_lock);
 		goto cleanup;
 	}
 	mutex_unlock(&a_priv->bulk_alloc_lock);
 	if (down_interruptible(&context->complete)) {
-		pr_err("%s: interrupted\n", __func__);
+		dev_err(&usb_dev->dev, "%s: interrupted\n", __func__);
 		retval = -ERESTARTSYS;
 		goto cleanup;
 	}
@@ -150,16 +148,17 @@ static int agilent_82357a_receive_bulk_msg(struct agilent_82357a_priv *a_priv, v
 	if (timeout_msecs)
 		mod_timer(&a_priv->bulk_timer, jiffies + msecs_to_jiffies(timeout_msecs));
 
-	//printk("%s: submitting urb\n", __func__);
+	//dev_dbg(&usb_dev->dev, "%s: submitting urb\n", __func__);
 	retval = usb_submit_urb(a_priv->bulk_urb, GFP_KERNEL);
 	if (retval) {
-		pr_err("%s: failed to submit bulk out urb, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: failed to submit bulk out urb, retval=%i\n",
+			__func__, retval);
 		mutex_unlock(&a_priv->bulk_alloc_lock);
 		goto cleanup;
 	}
 	mutex_unlock(&a_priv->bulk_alloc_lock);
 	if (down_interruptible(&context->complete)) {
-		pr_err("%s: interrupted\n", __func__);
+		dev_err(&usb_dev->dev, "%s: interrupted\n", __func__);
 		retval = -ERESTARTSYS;
 		goto cleanup;
 	}
@@ -216,6 +215,7 @@ static int agilent_82357a_write_registers(struct agilent_82357a_priv *a_priv,
 					  const struct agilent_82357a_register_pairlet *writes,
 					  int num_writes)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	int retval;
 	u8 *out_data, *in_data;
 	int out_data_length, in_data_length;
@@ -227,13 +227,13 @@ static int agilent_82357a_write_registers(struct agilent_82357a_priv *a_priv,
 	static const int max_writes = 31;
 
 	if (num_writes > max_writes) {
-		pr_err("%s: bug! num_writes=%i too large\n", __func__, num_writes);
+		dev_err(&usb_dev->dev, "%s: bug! num_writes=%i too large\n", __func__, num_writes);
 		return -EIO;
 	}
 	out_data_length = num_writes * bytes_per_write + header_length;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data) {
-		pr_err("%s: kmalloc failed\n", __func__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	out_data[i++] = DATA_PIPE_CMD_WR_REGS;
@@ -243,7 +243,7 @@ static int agilent_82357a_write_registers(struct agilent_82357a_priv *a_priv,
 		out_data[i++] = writes[j].value;
 	}
 	if (i > out_data_length)
-		pr_err("%s: bug! buffer overrun\n", __func__);
+		dev_err(&usb_dev->dev, "%s: bug! buffer overrun\n", __func__);
 	retval = mutex_lock_interruptible(&a_priv->bulk_transfer_lock);
 	if (retval) {
 		kfree(out_data);
@@ -252,15 +252,15 @@ static int agilent_82357a_write_registers(struct agilent_82357a_priv *a_priv,
 	retval = agilent_82357a_send_bulk_msg(a_priv, out_data, i, &bytes_written, 1000);
 	kfree(out_data);
 	if (retval) {
-		pr_err("%s: agilent_82357a_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		mutex_unlock(&a_priv->bulk_transfer_lock);
 		return retval;
 	}
 	in_data_length = 0x20;
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
 	if (!in_data) {
-		pr_err("%s: kmalloc failed\n", __func__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		mutex_unlock(&a_priv->bulk_transfer_lock);
 		return -ENOMEM;
 	}
@@ -269,20 +269,20 @@ static int agilent_82357a_write_registers(struct agilent_82357a_priv *a_priv,
 	mutex_unlock(&a_priv->bulk_transfer_lock);
 
 	if (retval) {
-		pr_err("%s: agilent_82357a_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		agilent_82357a_dump_raw_block(in_data, bytes_read);
 		kfree(in_data);
 		return -EIO;
 	}
 	if (in_data[0] != (0xff & ~DATA_PIPE_CMD_WR_REGS)) {
-		pr_err("%s: error, bulk command=0x%x != ~DATA_PIPE_CMD_WR_REGS\n",
-		       __func__, in_data[0]);
+		dev_err(&usb_dev->dev, "%s: error, bulk command=0x%x != ~DATA_PIPE_CMD_WR_REGS\n",
+			__func__, in_data[0]);
 		return -EIO;
 	}
 	if (in_data[1])	{
-		pr_err("%s: nonzero error code 0x%x in DATA_PIPE_CMD_WR_REGS response\n",
-		       __func__, in_data[1]);
+		dev_err(&usb_dev->dev, "%s: nonzero error code 0x%x in DATA_PIPE_CMD_WR_REGS response\n",
+			__func__, in_data[1]);
 		return -EIO;
 	}
 	kfree(in_data);
@@ -293,6 +293,7 @@ static int agilent_82357a_read_registers(struct agilent_82357a_priv *a_priv,
 					 struct agilent_82357a_register_pairlet *reads,
 					 int num_reads, int blocking)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	int retval;
 	u8 *out_data, *in_data;
 	int out_data_length, in_data_length;
@@ -303,12 +304,12 @@ static int agilent_82357a_read_registers(struct agilent_82357a_priv *a_priv,
 	static const int max_reads = 62;
 
 	if (num_reads > max_reads)
-		pr_err("%s: bug! num_reads=%i too large\n", __func__, num_reads);
+		dev_err(&usb_dev->dev, "%s: bug! num_reads=%i too large\n", __func__, num_reads);
 
 	out_data_length = num_reads + header_length;
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data) {
-		pr_err("%s: kmalloc failed\n", __func__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		return -ENOMEM;
 	}
 	out_data[i++] = DATA_PIPE_CMD_RD_REGS;
@@ -316,7 +317,7 @@ static int agilent_82357a_read_registers(struct agilent_82357a_priv *a_priv,
 	for (j = 0; j < num_reads; j++)
 		out_data[i++] = reads[j].address;
 	if (i > out_data_length)
-		pr_err("%s: bug! buffer overrun\n", __func__);
+		dev_err(&usb_dev->dev, "%s: bug! buffer overrun\n", __func__);
 	if (blocking) {
 		retval = mutex_lock_interruptible(&a_priv->bulk_transfer_lock);
 		if (retval) {
@@ -333,15 +334,15 @@ static int agilent_82357a_read_registers(struct agilent_82357a_priv *a_priv,
 	retval = agilent_82357a_send_bulk_msg(a_priv, out_data, i, &bytes_written, 1000);
 	kfree(out_data);
 	if (retval) {
-		pr_err("%s: agilent_82357a_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		mutex_unlock(&a_priv->bulk_transfer_lock);
 		return retval;
 	}
 	in_data_length = 0x20;
 	in_data = kmalloc(in_data_length, GFP_KERNEL);
 	if (!in_data) {
-		pr_err("%s: kmalloc failed\n", __func__);
+		dev_err(&usb_dev->dev, "%s: kmalloc failed\n", __func__);
 		mutex_unlock(&a_priv->bulk_transfer_lock);
 		return -ENOMEM;
 	}
@@ -350,21 +351,21 @@ static int agilent_82357a_read_registers(struct agilent_82357a_priv *a_priv,
 	mutex_unlock(&a_priv->bulk_transfer_lock);
 
 	if (retval) {
-		pr_err("%s: agilent_82357a_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		agilent_82357a_dump_raw_block(in_data, bytes_read);
 		kfree(in_data);
 		return -EIO;
 	}
 	i = 0;
 	if (in_data[i++] != (0xff & ~DATA_PIPE_CMD_RD_REGS)) {
-		pr_err("%s: error, bulk command=0x%x != ~DATA_PIPE_CMD_RD_REGS\n",
-		       __func__, in_data[0]);
+		dev_err(&usb_dev->dev, "%s: error, bulk command=0x%x != ~DATA_PIPE_CMD_RD_REGS\n",
+			__func__, in_data[0]);
 		return -EIO;
 	}
 	if (in_data[i++]) {
-		pr_err("%s: nonzero error code 0x%x in DATA_PIPE_CMD_RD_REGS response\n",
-		       __func__, in_data[1]);
+		dev_err(&usb_dev->dev, "%s: nonzero error code 0x%x in DATA_PIPE_CMD_RD_REGS response\n",
+			__func__, in_data[1]);
 		return -EIO;
 	}
 	for (j = 0; j < num_reads; j++)
@@ -375,6 +376,7 @@ static int agilent_82357a_read_registers(struct agilent_82357a_priv *a_priv,
 
 static int agilent_82357a_abort(struct agilent_82357a_priv *a_priv, int flush)
 {
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	int retval = 0;
 	int receive_control_retval;
 	u16 wIndex = 0;
@@ -394,13 +396,14 @@ static int agilent_82357a_abort(struct agilent_82357a_priv *a_priv, int flush)
 								    wIndex, status_data,
 								    status_data_len, 100);
 	if (receive_control_retval < 0)	{
-		pr_err("%s: agilent_82357a_receive_control_msg() returned %i\n",
-		       __func__, receive_control_retval);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_receive_control_msg() returned %i\n",
+			__func__, receive_control_retval);
 		retval = -EIO;
 		goto cleanup;
 	}
 	if (status_data[0] != (~XFER_ABORT & 0xff)) {
-		pr_err("%s: error, major code=0x%x != ~XFER_ABORT\n", __func__, status_data[0]);
+		dev_err(&usb_dev->dev, "%s: error, major code=0x%x != ~XFER_ABORT\n",
+			__func__, status_data[0]);
 		retval = -EIO;
 		goto cleanup;
 	}
@@ -416,7 +419,8 @@ static int agilent_82357a_abort(struct agilent_82357a_priv *a_priv, int flush)
 		fallthrough;
 	case UGP_ERR_FLUSHING_ALREADY:
 	default:
-		pr_err("%s: abort returned error code=0x%x\n", __func__, status_data[1]);
+		dev_err(&usb_dev->dev, "%s: abort returned error code=0x%x\n",
+			__func__, status_data[1]);
 		retval = -EIO;
 		break;
 	}
@@ -435,6 +439,7 @@ static int agilent_82357a_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 {
 	int retval;
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	u8 *out_data, *in_data;
 	int out_data_length, in_data_length;
 	int bytes_written, bytes_read;
@@ -470,8 +475,8 @@ static int agilent_82357a_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 	retval = agilent_82357a_send_bulk_msg(a_priv, out_data, i, &bytes_written, msec_timeout);
 	kfree(out_data);
 	if (retval || bytes_written != i) {
-		pr_err("%s: agilent_82357a_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
-		       __func__, retval, bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			__func__, retval, bytes_written, i);
 		mutex_unlock(&a_priv->bulk_transfer_lock);
 		if (retval < 0)
 			return retval;
@@ -500,18 +505,18 @@ static int agilent_82357a_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 		extra_bytes_retval = agilent_82357a_receive_bulk_msg(a_priv, in_data + bytes_read,
 								     in_data_length - bytes_read,
 								     &extra_bytes_read, 100);
-		//printk("%s: agilent_82357a_receive_bulk_msg timed out, bytes_read=%i,
-		// extra_bytes_read=%i\n",
-		//	__func__, bytes_read, extra_bytes_read);
+		//dev_err(&usb_dev->dev, "%s: agilent_82357a_receive_bulk_msg timed out,
+		// bytes_read=%i, extra_bytes_read=%i\n",
+		// __func__, bytes_read, extra_bytes_read);
 		bytes_read += extra_bytes_read;
 		if (extra_bytes_retval)	{
-			pr_err("%s: extra_bytes_retval=%i, bytes_read=%i\n", __func__,
-			       extra_bytes_retval, bytes_read);
+			dev_err(&usb_dev->dev, "%s: extra_bytes_retval=%i, bytes_read=%i\n",
+				__func__, extra_bytes_retval, bytes_read);
 			agilent_82357a_abort(a_priv, 0);
 		}
 	} else if (retval) {
-		pr_err("%s: agilent_82357a_receive_bulk_msg returned %i, bytes_read=%i\n",
-		       __func__, retval, bytes_read);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_receive_bulk_msg returned %i, bytes_read=%i\n",
+			__func__, retval, bytes_read);
 		agilent_82357a_abort(a_priv, 0);
 	}
 	mutex_unlock(&a_priv->bulk_transfer_lock);
@@ -519,7 +524,7 @@ static int agilent_82357a_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 		bytes_read = length + 1;
 		pr_warn("%s: bytes_read > length? truncating", __func__);
 	}
-	//printk("%s: received response:\n", __func__);
+	//dev_dbg(&usb_dev->dev, "%s: received response:\n", __func__);
 	// agilent_82357a_dump_raw_block(in_data, bytes_read);
 	if (bytes_read >= 1) {
 		memcpy(buffer, in_data, bytes_read - 1);
@@ -545,6 +550,7 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 {
 	int retval;
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	u8 *out_data = NULL;
 	u8 *status_data = NULL;
 	int out_data_length;
@@ -574,7 +580,8 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 	out_data[i++] = (length >> 24) & 0xff;
 	for (j = 0; j < length; j++)
 		out_data[i++] = buffer[j];
-	//printk("%s: sending bulk msg(), send_commands=%i\n", __func__, send_commands);
+	//dev_dbg(&usb_dev->dev, "%s: sending bulk msg(), send_commands=%i\n",
+	//__func__, send_commands);
 
 	clear_bit(AIF_WRITE_COMPLETE_BN, &a_priv->interrupt_flags);
 
@@ -589,28 +596,28 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 	kfree(out_data);
 	if (retval || raw_bytes_written != i) {
 		agilent_82357a_abort(a_priv, 0);
-		pr_err("%s: agilent_82357a_send_bulk_msg returned %i, raw_bytes_written=%i, i=%i\n",
-		       __func__, retval, raw_bytes_written, i);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_send_bulk_msg returned %i, raw_bytes_written=%i, i=%i\n",
+			__func__, retval, raw_bytes_written, i);
 		mutex_unlock(&a_priv->bulk_transfer_lock);
 		if (retval < 0)
 			return retval;
 		return -EIO;
 	}
-	//printk("%s: waiting for write complete\n", __func__);
+	//dev_dbg(&usb_dev->dev, "%s: waiting for write complete\n", __func__);
 	retval = wait_event_interruptible(board->wait,
 					  test_bit(AIF_WRITE_COMPLETE_BN,
 						   &a_priv->interrupt_flags) ||
 					  test_bit(TIMO_NUM, &board->status));
 	if (retval) {
-		pr_err("%s: wait write complete interrupted\n", __func__);
+		dev_err(&usb_dev->dev, "%s: wait write complete interrupted\n", __func__);
 		agilent_82357a_abort(a_priv, 0);
 		mutex_unlock(&a_priv->bulk_transfer_lock);
 		return -ERESTARTSYS;
 	}
 
 	if (test_bit(AIF_WRITE_COMPLETE_BN, &a_priv->interrupt_flags) == 0) {
-		GPIB_DPRINTK("%s: write timed out ibs %i, tmo %i\n", __func__,
-			     test_bit(TIMO_NUM, &board->status), msec_timeout);
+		dev_dbg(&usb_dev->dev, "write timed out ibs %i, tmo %i\n",
+			test_bit(TIMO_NUM, &board->status), msec_timeout);
 
 		agilent_82357a_abort(a_priv, 0);
 
@@ -619,16 +626,17 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 		read_reg.address = BSR;
 		retval = agilent_82357a_read_registers(a_priv, &read_reg, 1, 1);
 		if (retval) {
-			pr_err("%s: agilent_82357a_read_registers() returned error\n",	__func__);
+			dev_err(&usb_dev->dev, "%s: agilent_82357a_read_registers() returned error\n",
+				__func__);
 			return -ETIMEDOUT;
 		}
 
 		bsr = read_reg.value;
-		GPIB_DPRINTK("%s: write aborted bsr 0x%hx\n", __func__, bsr);
+		dev_dbg(&usb_dev->dev, "write aborted bsr 0x%x\n", bsr);
 
 		if (send_commands) {/* check for no listeners */
 			if ((bsr & BSR_ATN_BIT) && !(bsr & (BSR_NDAC_BIT | BSR_NRFD_BIT))) {
-				GPIB_DPRINTK("%s: No listener on command\n", __func__);
+				dev_dbg(&usb_dev->dev, "No listener on command\n");
 				clear_bit(TIMO_NUM, &board->status);
 				return -ENOTCONN; // no listener on bus
 			}
@@ -636,13 +644,13 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 			read_reg.address = ADSR;
 			retval = agilent_82357a_read_registers(a_priv, &read_reg, 1, 1);
 			if (retval) {
-				pr_err("%s: agilent_82357a_read_registers() returned error\n",
-				       __func__);
+				dev_err(&usb_dev->dev, "%s: agilent_82357a_read_registers() returned error\n",
+					__func__);
 				return -ETIMEDOUT;
 			}
 			adsr = read_reg.value;
 			if ((adsr & HR_TA) && !(bsr & (BSR_NDAC_BIT | BSR_NRFD_BIT))) {
-				GPIB_DPRINTK("%s: No listener on write\n", __func__);
+				dev_dbg(&usb_dev->dev, "No listener on write\n");
 				clear_bit(TIMO_NUM, &board->status);
 				return -ECOMM;
 			}
@@ -657,14 +665,15 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 		return -ENOMEM;
 	}
 
-	// printk("%s: receiving control msg\n", __func__);
+	// dev_dbg(&usb_dev->dev, "%s: receiving control msg\n", __func__);
 	retval = agilent_82357a_receive_control_msg(a_priv, agilent_82357a_control_request,
 						    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 						    XFER_STATUS, 0, status_data, STATUS_DATA_LEN,
 						    100);
 	mutex_unlock(&a_priv->bulk_transfer_lock);
 	if (retval < 0)	{
-		pr_err("%s: agilent_82357a_receive_control_msg() returned %i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_receive_control_msg() returned %i\n",
+			__func__, retval);
 		kfree(status_data);
 		return -EIO;
 	}
@@ -674,7 +683,8 @@ static ssize_t agilent_82357a_generic_write(gpib_board_t *board, uint8_t *buffer
 	*bytes_written |= status_data[5] << 24;
 
 	kfree(status_data);
-	//printk("%s: write completed, bytes_written=%i\n", __func__, (int)*bytes_written);
+	//dev_dbg(&usb_dev->dev, "%s: write completed, bytes_written=%i\n",
+	//__func__, (int)*bytes_written);
 	return 0;
 }
 
@@ -693,6 +703,7 @@ int agilent_82357a_command(gpib_board_t *board, uint8_t *buffer, size_t length,
 int agilent_82357a_take_control_internal(gpib_board_t *board, int synchronous)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
@@ -703,7 +714,8 @@ int agilent_82357a_take_control_internal(gpib_board_t *board, int synchronous)
 		write.value = AUX_TCA;
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
 	if (retval)
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 
 	return retval;
 }
@@ -736,6 +748,7 @@ static int agilent_82357a_take_control(gpib_board_t *board, int synchronous)
 static int agilent_82357a_go_to_standby(gpib_board_t *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
@@ -743,7 +756,8 @@ static int agilent_82357a_go_to_standby(gpib_board_t *board)
 	write.value = AUX_GTS;
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
 	if (retval)
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 	return 0;
 }
 
@@ -751,6 +765,7 @@ static int agilent_82357a_go_to_standby(gpib_board_t *board)
 static void agilent_82357a_request_system_control(gpib_board_t *board, int request_control)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet writes[2];
 	int retval;
 	int i = 0;
@@ -771,13 +786,15 @@ static void agilent_82357a_request_system_control(gpib_board_t *board, int reque
 	++i;
 	retval = agilent_82357a_write_registers(a_priv, writes, i);
 	if (retval)
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 	return;// retval;
 }
 
 static void agilent_82357a_interface_clear(gpib_board_t *board, int assert)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
@@ -789,12 +806,14 @@ static void agilent_82357a_interface_clear(gpib_board_t *board, int assert)
 	}
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
 	if (retval)
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 }
 
 static void agilent_82357a_remote_enable(gpib_board_t *board, int enable)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
@@ -804,7 +823,8 @@ static void agilent_82357a_remote_enable(gpib_board_t *board, int enable)
 		write.value |= AUX_CS;
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
 	if (retval)
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 	a_priv->ren_state = enable;
 	return;// 0;
 }
@@ -832,6 +852,7 @@ static void agilent_82357a_disable_eos(gpib_board_t *board)
 static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned int clear_mask)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet address_status, bus_status;
 	int retval;
 
@@ -844,7 +865,8 @@ static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned i
 	retval = agilent_82357a_read_registers(a_priv, &address_status, 1, 0);
 	if (retval) {
 		if (retval != -EAGAIN)
-			pr_err("%s: agilent_82357a_read_registers() returned error\n", __func__);
+			dev_err(&usb_dev->dev, "%s: agilent_82357a_read_registers() returned error\n",
+				__func__);
 		return board->status;
 	}
 	// check for remote/local
@@ -876,7 +898,8 @@ static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned i
 	retval = agilent_82357a_read_registers(a_priv, &bus_status, 1, 0);
 	if (retval) {
 		if (retval != -EAGAIN)
-			pr_err("%s: agilent_82357a_read_registers() returned error\n", __func__);
+			dev_err(&usb_dev->dev, "%s: agilent_82357a_read_registers() returned error\n",
+				__func__);
 		return board->status;
 	}
 	if (bus_status.value & BSR_SRQ_BIT)
@@ -890,6 +913,7 @@ static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned i
 static int agilent_82357a_primary_address(gpib_board_t *board, unsigned int address)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
@@ -898,7 +922,8 @@ static int agilent_82357a_primary_address(gpib_board_t *board, unsigned int addr
 	write.value = address & ADDRESS_MASK;
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
 	if (retval) {
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 		return retval;
 	}
 	return retval;
@@ -914,6 +939,7 @@ static int agilent_82357a_secondary_address(gpib_board_t *board, unsigned int ad
 static int agilent_82357a_parallel_poll(gpib_board_t *board, uint8_t *result)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet writes[2];
 	struct agilent_82357a_register_pairlet read;
 	int retval;
@@ -925,14 +951,16 @@ static int agilent_82357a_parallel_poll(gpib_board_t *board, uint8_t *result)
 	writes[1].value = a_priv->hw_control_bits & ~NOT_PARALLEL_POLL;
 	retval = agilent_82357a_write_registers(a_priv, writes, 2);
 	if (retval) {
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 		return retval;
 	}
 	udelay(2);	//silly, since usb write will take way longer
 	read.address = CPTR;
 	retval = agilent_82357a_read_registers(a_priv, &read, 1, 1);
 	if (retval) {
-		pr_err("%s: agilent_82357a_read_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_read_registers() returned error\n",
+			__func__);
 		return retval;
 	}
 	*result = read.value;
@@ -943,7 +971,8 @@ static int agilent_82357a_parallel_poll(gpib_board_t *board, uint8_t *result)
 	writes[1].value = AUX_RPP;
 	retval = agilent_82357a_write_registers(a_priv, writes, 2);
 	if (retval) {
-		pr_err("%s: agilent_82357a_write_registers() returned error\n",	 __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 		return retval;
 	}
 	return 0;
@@ -982,6 +1011,7 @@ static void agilent_82357a_return_to_local(gpib_board_t *board)
 static int agilent_82357a_line_status(const gpib_board_t *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet bus_status;
 	int retval;
 	int status = ValidALL;
@@ -990,7 +1020,8 @@ static int agilent_82357a_line_status(const gpib_board_t *board)
 	retval = agilent_82357a_read_registers(a_priv, &bus_status, 1, 0);
 	if (retval) {
 		if (retval != -EAGAIN)
-			pr_err("%s: agilent_82357a_read_registers() returned error\n", __func__);
+			dev_err(&usb_dev->dev, "%s: agilent_82357a_read_registers() returned error\n",
+				__func__);
 		return retval;
 	}
 	if (bus_status.value & BSR_REN_BIT)
@@ -1031,6 +1062,7 @@ static unsigned short nanosec_to_fast_talker_bits(unsigned int *nanosec)
 static unsigned int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int nanosec)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
@@ -1038,7 +1070,8 @@ static unsigned int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int na
 	write.value = nanosec_to_fast_talker_bits(&nanosec);
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
 	if (retval)
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 	return nanosec;
 }
 
@@ -1046,6 +1079,7 @@ static void agilent_82357a_interrupt_complete(struct urb *urb)
 {
 	gpib_board_t *board = urb->context;
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	int retval;
 	u8 *transfer_buffer = urb->transfer_buffer;
 	unsigned long interrupt_flags;
@@ -1062,7 +1096,7 @@ static void agilent_82357a_interrupt_complete(struct urb *urb)
 	default: /* other error, resubmit */
 		retval = usb_submit_urb(a_priv->interrupt_urb, GFP_ATOMIC);
 		if (retval)
-			pr_err("%s: failed to resubmit interrupt urb\n", __func__);
+			dev_err(&usb_dev->dev, "%s: failed to resubmit interrupt urb\n", __func__);
 		return;
 	}
 
@@ -1078,7 +1112,7 @@ static void agilent_82357a_interrupt_complete(struct urb *urb)
 
 	retval = usb_submit_urb(a_priv->interrupt_urb, GFP_ATOMIC);
 	if (retval)
-		pr_err("%s: failed to resubmit interrupt urb\n", __func__);
+		dev_err(&usb_dev->dev, "%s: failed to resubmit interrupt urb\n", __func__);
 }
 
 static int agilent_82357a_setup_urbs(gpib_board_t *board)
@@ -1114,7 +1148,8 @@ static int agilent_82357a_setup_urbs(gpib_board_t *board)
 	if (retval) {
 		usb_free_urb(a_priv->interrupt_urb);
 		a_priv->interrupt_urb = NULL;
-		pr_err("%s: failed to submit first interrupt urb, retval=%i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: failed to submit first interrupt urb, retval=%i\n",
+			__func__, retval);
 		goto setup_exit;
 	}
 	mutex_unlock(&a_priv->interrupt_alloc_lock);
@@ -1130,6 +1165,7 @@ static int agilent_82357a_setup_urbs(gpib_board_t *board)
 static int agilent_82357a_reset_usb_configuration(gpib_board_t *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct usb_device *usb_dev;
 	int retval;
 
@@ -1138,7 +1174,8 @@ static int agilent_82357a_reset_usb_configuration(gpib_board_t *board)
 	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	retval = usb_reset_configuration(usb_dev);
 	if (retval)
-		pr_err("%s: usb_reset_configuration() returned %i\n", __func__, retval);
+		dev_err(&usb_dev->dev, "%s: usb_reset_configuration() returned %i\n",
+			__func__, retval);
 	return retval;
 }
 #endif
@@ -1179,6 +1216,7 @@ static void agilent_82357a_free_private(struct agilent_82357a_priv *a_priv)
 static int agilent_82357a_init(gpib_board_t *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet hw_control;
 	struct agilent_82357a_register_pairlet writes[0x20];
 	int retval;
@@ -1194,7 +1232,8 @@ static int agilent_82357a_init(gpib_board_t *board)
 	++i;
 	retval = agilent_82357a_write_registers(a_priv, writes, i);
 	if (retval) {
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 		return -EIO;
 	}
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -1259,18 +1298,20 @@ static int agilent_82357a_init(gpib_board_t *board)
 	writes[i].value = FIRMWARE_LED_CONTROL;
 	++i;
 	if (i > ARRAY_SIZE(writes)) {
-		pr_err("%s: bug! writes[] overflow\n", __func__);
+		dev_err(&usb_dev->dev, "%s: bug! writes[] overflow\n", __func__);
 		return -EFAULT;
 	}
 	retval = agilent_82357a_write_registers(a_priv, writes, i);
 	if (retval) {
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 		return -EIO;
 	}
 	hw_control.address = HW_CONTROL;
 	retval = agilent_82357a_read_registers(a_priv, &hw_control, 1, 1);
 	if (retval) {
-		pr_err("%s: agilent_82357a_read_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_read_registers() returned error\n",
+			__func__);
 		return -EIO;
 	}
 	a_priv->hw_control_bits = (hw_control.value & ~0x7) | NOT_TI_RESET | NOT_PARALLEL_POLL;
@@ -1338,7 +1379,7 @@ static int agilent_82357a_attach(gpib_board_t *board, const gpib_board_config_t
 		a_priv->interrupt_in_endpoint = AGILENT_82357B_INTERRUPT_IN_ENDPOINT;
 		break;
 	default:
-		pr_err("bug, unhandled product_id in switch?\n");
+		dev_err(&usb_dev->dev, "bug, unhandled product_id in switch?\n");
 		return -EIO;
 	}
 #ifdef RESET_USB_CONFIG
@@ -1365,7 +1406,7 @@ static int agilent_82357a_attach(gpib_board_t *board, const gpib_board_config_t
 		return retval;
 	}
 
-	pr_info("%s: attached\n", __func__);
+	dev_info(&usb_dev->dev, "%s: attached\n", __func__);
 	mutex_unlock(&agilent_82357a_hotplug_lock);
 	return retval;
 }
@@ -1373,6 +1414,7 @@ static int agilent_82357a_attach(gpib_board_t *board, const gpib_board_config_t
 static int agilent_82357a_go_idle(gpib_board_t *board)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
+	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	struct agilent_82357a_register_pairlet writes[0x20];
 	int retval;
 	int i;
@@ -1399,12 +1441,13 @@ static int agilent_82357a_go_idle(gpib_board_t *board)
 	writes[i].value = 0;
 	++i;
 	if (i > ARRAY_SIZE(writes)) {
-		pr_err("%s: bug! writes[] overflow\n", __func__);
+		dev_err(&usb_dev->dev, "%s: bug! writes[] overflow\n", __func__);
 		return -EFAULT;
 	}
 	retval = agilent_82357a_write_registers(a_priv, writes, i);
 	if (retval) {
-		pr_err("%s: agilent_82357a_write_registers() returned error\n", __func__);
+		dev_err(&usb_dev->dev, "%s: agilent_82357a_write_registers() returned error\n",
+			__func__);
 		return -EIO;
 	}
 	return 0;
@@ -1413,10 +1456,12 @@ static int agilent_82357a_go_idle(gpib_board_t *board)
 static void agilent_82357a_detach(gpib_board_t *board)
 {
 	struct agilent_82357a_priv *a_priv;
+	struct usb_device *usb_dev;
 
 	mutex_lock(&agilent_82357a_hotplug_lock);
 
 	a_priv = board->private_data;
+	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	if (a_priv) {
 		if (a_priv->bus_interface) {
 			agilent_82357a_go_idle(board);
@@ -1428,7 +1473,7 @@ static void agilent_82357a_detach(gpib_board_t *board)
 		agilent_82357a_cleanup_urbs(a_priv);
 		agilent_82357a_free_private(a_priv);
 	}
-	pr_info("%s: detached\n", __func__);
+	dev_info(&usb_dev->dev, "%s: detached\n", __func__);
 	mutex_unlock(&agilent_82357a_hotplug_lock);
 }
 
@@ -1476,32 +1521,35 @@ static int agilent_82357a_driver_probe(struct usb_interface *interface,
 	int i;
 	char *path;
 	static const int path_length = 1024;
+	struct usb_device *usb_dev;
 
 	if (mutex_lock_interruptible(&agilent_82357a_hotplug_lock))
 		return -ERESTARTSYS;
-	usb_get_dev(interface_to_usbdev(interface));
+	usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	for (i = 0; i < MAX_NUM_82357A_INTERFACES; ++i) {
 		if (!agilent_82357a_driver_interfaces[i]) {
 			agilent_82357a_driver_interfaces[i] = interface;
 			usb_set_intfdata(interface, NULL);
-			GPIB_DPRINTK("set bus interface %i to address 0x%p\n", i, interface);
+			dev_dbg(&usb_dev->dev, "set bus interface %i to address 0x%p\n",
+				i, interface);
 			break;
 		}
 	}
 	if (i == MAX_NUM_82357A_INTERFACES) {
-		usb_put_dev(interface_to_usbdev(interface));
+		usb_put_dev(usb_dev);
 		mutex_unlock(&agilent_82357a_hotplug_lock);
-		pr_err("%s: out of space in agilent_82357a_driver_interfaces[]\n", __func__);
+		dev_err(&usb_dev->dev, "%s: out of space in agilent_82357a_driver_interfaces[]\n",
+			__func__);
 		return -1;
 	}
 	path = kmalloc(path_length, GFP_KERNEL);
 	if (!path) {
-		usb_put_dev(interface_to_usbdev(interface));
+		usb_put_dev(usb_dev);
 		mutex_unlock(&agilent_82357a_hotplug_lock);
 		return -ENOMEM;
 	}
-	usb_make_path(interface_to_usbdev(interface), path, path_length);
-	pr_info("probe succeeded for path: %s\n", path);
+	usb_make_path(usb_dev, path, path_length);
+	dev_info(&usb_dev->dev, "probe succeeded for path: %s\n", path);
 	kfree(path);
 	mutex_unlock(&agilent_82357a_hotplug_lock);
 	return 0;
@@ -1510,6 +1558,7 @@ static int agilent_82357a_driver_probe(struct usb_interface *interface,
 static void agilent_82357a_driver_disconnect(struct usb_interface *interface)
 {
 	int i;
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
 
 	mutex_lock(&agilent_82357a_hotplug_lock);
 
@@ -1531,22 +1580,22 @@ static void agilent_82357a_driver_disconnect(struct usb_interface *interface)
 					mutex_unlock(&a_priv->control_alloc_lock);
 				}
 			}
-			GPIB_DPRINTK("nulled agilent_82357a_driver_interfaces[%i]\n", i);
+			dev_dbg(&usb_dev->dev, "nulled agilent_82357a_driver_interfaces[%i]\n", i);
 			agilent_82357a_driver_interfaces[i] = NULL;
 			break;
 		}
 	}
 	if (i == MAX_NUM_82357A_INTERFACES)
-		pr_err("unable to find interface in agilent_82357a_driver_interfaces[]? bug?\n");
-	usb_put_dev(interface_to_usbdev(interface));
+		dev_err(&usb_dev->dev, "unable to find interface in agilent_82357a_driver_interfaces[]? bug?\n");
+	usb_put_dev(usb_dev);
 
 	mutex_unlock(&agilent_82357a_hotplug_lock);
 }
 
 static int agilent_82357a_driver_suspend(struct usb_interface *interface, pm_message_t message)
 {
-	struct usb_device *usb_dev;
 	int i, retval;
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
 
 	mutex_lock(&agilent_82357a_hotplug_lock);
 
@@ -1562,15 +1611,14 @@ static int agilent_82357a_driver_suspend(struct usb_interface *interface, pm_mes
 					agilent_82357a_abort(a_priv, 0);
 					retval = agilent_82357a_go_idle(board);
 					if (retval) {
-						pr_err("%s: failed to go idle, retval=%i\n",
-						       __func__, retval);
+						dev_err(&usb_dev->dev, "%s: failed to go idle, retval=%i\n",
+							__func__, retval);
 						mutex_unlock(&agilent_82357a_hotplug_lock);
 						return retval;
 					}
 					mutex_lock(&a_priv->interrupt_alloc_lock);
 					agilent_82357a_cleanup_urbs(a_priv);
 					mutex_unlock(&a_priv->interrupt_alloc_lock);
-					usb_dev = interface_to_usbdev(a_priv->bus_interface);
 					dev_info(&usb_dev->dev,
 						 "bus %d dev num %d  gpib minor %d, agilent usb interface %i suspended\n",
 						 usb_dev->bus->busnum, usb_dev->devnum,
@@ -1588,7 +1636,7 @@ static int agilent_82357a_driver_suspend(struct usb_interface *interface, pm_mes
 
 static int agilent_82357a_driver_resume(struct usb_interface *interface)
 {
-	struct usb_device *usb_dev;
+	struct usb_device *usb_dev = interface_to_usbdev(interface);
 	gpib_board_t *board;
 	int i, retval;
 
@@ -1611,8 +1659,8 @@ static int agilent_82357a_driver_resume(struct usb_interface *interface)
 			mutex_lock(&a_priv->interrupt_alloc_lock);
 			retval = usb_submit_urb(a_priv->interrupt_urb, GFP_KERNEL);
 			if (retval) {
-				pr_err("%s: failed to resubmit interrupt urb, retval=%i\n",
-				       __func__, retval);
+				dev_err(&usb_dev->dev, "%s: failed to resubmit interrupt urb, retval=%i\n",
+					__func__, retval);
 				mutex_unlock(&a_priv->interrupt_alloc_lock);
 				mutex_unlock(&agilent_82357a_hotplug_lock);
 				return retval;
@@ -1635,7 +1683,6 @@ static int agilent_82357a_driver_resume(struct usb_interface *interface)
 		// assert/unassert REN
 		agilent_82357a_remote_enable(board, a_priv->ren_state);
 
-		usb_dev = interface_to_usbdev(a_priv->bus_interface);
 		dev_info(&usb_dev->dev,
 			 "bus %d dev num %d  gpib minor %d, agilent usb interface %i resumed\n",
 			 usb_dev->bus->busnum, usb_dev->devnum, board->minor, i);
@@ -1678,4 +1725,3 @@ static void __exit agilent_82357a_exit_module(void)
 
 module_init(agilent_82357a_init_module);
 module_exit(agilent_82357a_exit_module);
-
-- 
2.46.2


