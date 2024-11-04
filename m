Return-Path: <linux-kernel+bounces-395319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E169BBC59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A651C21BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C0A1CBE84;
	Mon,  4 Nov 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw6nIomi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DEF1CB9E7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742632; cv=none; b=AfgOTVjbUEtX+12+CRaSx9eoqS1XhsyLS68loWWq9u1lBrJzfhpA4QtwqzbCVf8iCUZ78YjnSGdisNu+SmwTAUj0sZU0nFtWBAwgK4Rql2iBZPyr/DN+e0xrRQys85NfPX5lMURTDzUcOIWVVzklptViHG5LV/nPvr69DxSe0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742632; c=relaxed/simple;
	bh=4bXC7gHunxqx86ZI+obzML20ntlCMxcJ1/rIythKv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLrpsCUhRwV0KCsuSkw432YdqEafidpJ9WcXuw8GqAU9ezplu9G2BT7s5CrWYLpKitltpf5E5RihbuWJxzpeKmuScjrBl3IAFN2+e5bnlIi6RGRHMeQgzFc+icVVgrF2vjy5uJkTuzLd0ksE6RT7P7mga4KhLwlTO4v70883Hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw6nIomi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43155afca99so33655215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742624; x=1731347424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWV3uTs5Bqe8KmLy/isy9CcoAf9srWI0SgOaSFqPZAk=;
        b=jw6nIomiAhLYGRdosahNI6Noh3zrMPUCrwnnMxuqXvVf30YP5R6AdZQXvpD0iZFwqG
         q9rleMzX0V4P2InUd1fhE0qBtSIOSJgznBLPOLVswQZeZOcp6sP837r8wdm7tSGdrJqW
         NzucsLHekJOV37QzEnPEPhiAk3noXcCQ1Qd2lDSwbOhE9vUPKpO8nz5dxJJ9AsHDpWFE
         EMmRPmwlcY8yx0pcKsj3nG5CT2naTPSKnI83SA305EGStpc8TmqEDAa+QyztA5OXbUpd
         KvKkzPQy9X1So8U/xU+NqmvqAZp8DuaqLvXEKdRpaHdySM/2CvXn1Ctp0ILPAP3SPMIP
         ALaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742624; x=1731347424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWV3uTs5Bqe8KmLy/isy9CcoAf9srWI0SgOaSFqPZAk=;
        b=q0E8om7HZyOLXcQMyCxmZsNOitTHx4CiNMjhxYqeZSSbKoJOSB42zXqH1YatoC5s0W
         vFpOc3g7Y9hpE+SMQ/l+DboaSJYHq790onGTkKcro44gN2/oWrIEhbgLVHk9KQPJtRjp
         zWws7cRa1AORl0Ab6L0YDq64nCdbFxJh4AZhWGMNSAjBp9OxbK8OhBmdbGE5AlpiK/VU
         2vJQT3PN0XThxluzfFEJ2m+0242zk5bW9rA8QBnx80iqRG2fXanBaKz2S8+celCRn5Pe
         tmP7D6oyGlVO7+oO3KU7C8rkp9eG0oOJ5g3zM6wRX9ruTbULLUwEFShZ1Kd8FJIlzbSH
         vVPg==
X-Forwarded-Encrypted: i=1; AJvYcCUEAK1kR8+9u1pFcZWv7qAlsq4LdLPpjWz6sMC6Hr5RGvV9QkYtGIWJv2OE3sOFFM1PgaM8HEjmzSfUaUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEe3uoGKx9+Ub8IIPiahA38a4EiEplTELJJFZRptAcw7v504x
	tG5wk7/Gpvw0AlBKEMZhpgmxwuQjpZC0zlLSxNwjAYEnzDSkxUpcY3fpOz/0
X-Google-Smtp-Source: AGHT+IH9iDsxVf2t4T9q9hL4FVR1/ZfpDJs23A/r+d0dLAJEUTrrgVHlhRnADnshNxUghvtdVihlIg==
X-Received: by 2002:a05:6000:718:b0:37c:f561:1130 with SMTP id ffacd0b85a97d-381c149f129mr12911474f8f.18.1730742623837;
        Mon, 04 Nov 2024 09:50:23 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:22 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 02/12] staging: gpib: Replace custom debug with dev_dbg
Date: Mon,  4 Nov 2024 18:50:03 +0100
Message-ID: <20241104175014.12317-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove GPIB_KERNEL_DEBUG config option
Remove GPIB_DEBUG reference
Replace GPIB_DPRINTK with dev_dbg
Change pr_alert to dev_alert

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Kconfig                  |  10 --
 drivers/staging/gpib/Makefile                 |   1 -
 drivers/staging/gpib/cb7210/cb7210.c          |   2 +-
 drivers/staging/gpib/common/gpib_os.c         | 138 +++++++++---------
 drivers/staging/gpib/common/iblib.c           |  16 +-
 drivers/staging/gpib/common/ibsys.h           |   4 +-
 drivers/staging/gpib/eastwood/fluke_gpib.c    |   2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      |   4 +-
 drivers/staging/gpib/include/gpibP.h          |   8 +-
 drivers/staging/gpib/ines/ines_gpib.c         |   2 +-
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        |  69 +++++----
 drivers/staging/gpib/nec7210/nec7210.c        |  34 ++---
 drivers/staging/gpib/tms9914/tms9914.c        |   8 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   |   7 +-
 14 files changed, 147 insertions(+), 158 deletions(-)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 999e7adacd82..0ea9a276c389 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -12,16 +12,6 @@ menuconfig GPIB
 
 if GPIB
 
-config GPIB_KERNEL_DEBUG
-	bool "GPIB debugging"
-	depends on BROKEN
-	help
-	  This is an option for use by developers; most people should
-	  say N here.
-
-	  It enables gpib core and driver debugging
-	  messages to be printed on the console.
-
 config GPIB_COMMON
 	tristate "GPIB core"
 	help
diff --git a/drivers/staging/gpib/Makefile b/drivers/staging/gpib/Makefile
index a5bf32320b21..d0e88f5c0844 100644
--- a/drivers/staging/gpib/Makefile
+++ b/drivers/staging/gpib/Makefile
@@ -1,5 +1,4 @@
 
-subdir-ccflags-$(CONFIG_GPIB_KERNEL_DEBUG) := -DGPIB_DEBUG
 subdir-ccflags-y += -I$(src)/include -I$(src)/uapi
 
 obj-$(CONFIG_GPIB_AGILENT_82350B) += agilent_82350b/
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index c827d03dacf5..63df7f3eb3f3 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -479,7 +479,7 @@ irqreturn_t cb7210_internal_interrupt(gpib_board_t *board)
 	status2 = read_byte(nec_priv, ISR2);
 	nec7210_interrupt_have_status(board, nec_priv, status1, status2);
 
-	GPIB_DPRINTK("cb7210: status 0x%x, mode 0x%x\n", hs_status, priv->hs_mode_bits);
+	dev_dbg(board->gpib_dev, "cb7210: status 0x%x, mode 0x%x\n", hs_status, priv->hs_mode_bits);
 
 	clear_bits = 0;
 
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 6b12404efe7d..e84097ac8f69 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -69,7 +69,7 @@ static int t1_delay_ioctl(gpib_board_t *board, unsigned long arg);
 
 static int cleanup_open_devices(gpib_file_private_t *file_priv, gpib_board_t *board);
 
-static int pop_gpib_event_nolock(gpib_event_queue_t *queue, short *event_type);
+static int pop_gpib_event_nolock(gpib_board_t *board, gpib_event_queue_t *queue, short *event_type);
 
 /*
  * Timer functions
@@ -225,7 +225,7 @@ unsigned int num_status_bytes(const gpib_status_queue_t *dev)
 }
 
 // push status byte onto back of status byte fifo
-int push_status_byte(gpib_status_queue_t *device, u8 poll_byte)
+int push_status_byte(gpib_board_t *board, gpib_status_queue_t *device, u8 poll_byte)
 {
 	struct list_head *head = &device->status_bytes;
 	status_byte_t *status;
@@ -236,7 +236,7 @@ int push_status_byte(gpib_status_queue_t *device, u8 poll_byte)
 		u8 lost_byte;
 
 		device->dropped_byte = 1;
-		retval = pop_status_byte(device, &lost_byte);
+		retval = pop_status_byte(board, device, &lost_byte);
 		if (retval < 0)
 			return retval;
 	}
@@ -252,14 +252,14 @@ int push_status_byte(gpib_status_queue_t *device, u8 poll_byte)
 
 	device->num_status_bytes++;
 
-	GPIB_DPRINTK("pushed status byte 0x%x, %i in queue\n",
-		     (int)poll_byte, num_status_bytes(device));
+	dev_dbg(board->gpib_dev, "pushed status byte 0x%x, %i in queue\n",
+		(int)poll_byte, num_status_bytes(device));
 
 	return 0;
 }
 
 // pop status byte from front of status byte fifo
-int pop_status_byte(gpib_status_queue_t *device, u8 *poll_byte)
+int pop_status_byte(gpib_board_t *board, gpib_status_queue_t *device, u8 *poll_byte)
 {
 	struct list_head *head = &device->status_bytes;
 	struct list_head *front = head->next;
@@ -284,8 +284,8 @@ int pop_status_byte(gpib_status_queue_t *device, u8 *poll_byte)
 
 	device->num_status_bytes--;
 
-	GPIB_DPRINTK("popped status byte 0x%x, %i in queue\n",
-		     (int)*poll_byte, num_status_bytes(device));
+	dev_dbg(board->gpib_dev, "popped status byte 0x%x, %i in queue\n",
+		(int)*poll_byte, num_status_bytes(device));
 
 	return 0;
 }
@@ -310,11 +310,11 @@ int get_serial_poll_byte(gpib_board_t *board, unsigned int pad, int sad, unsigne
 {
 	gpib_status_queue_t *device;
 
-	GPIB_DPRINTK("%s:()\n", __func__);
+	dev_dbg(board->gpib_dev, "%s:()\n", __func__);
 
 	device = get_gpib_status_queue(board, pad, sad);
 	if (num_status_bytes(device))
-		return pop_status_byte(device, poll_byte);
+		return pop_status_byte(board, device, poll_byte);
 	else
 		return dvrsp(board, pad, sad, usec_timeout, poll_byte);
 }
@@ -323,7 +323,7 @@ int autopoll_all_devices(gpib_board_t *board)
 {
 	int retval;
 
-	GPIB_DPRINTK("entering %s()\n", __func__);
+	dev_dbg(board->gpib_dev, "entering %s()\n", __func__);
 	if (mutex_lock_interruptible(&board->user_mutex))
 		return -ERESTARTSYS;
 	if (mutex_lock_interruptible(&board->big_gpib_mutex)) {
@@ -331,7 +331,7 @@ int autopoll_all_devices(gpib_board_t *board)
 		return -ERESTARTSYS;
 	}
 
-	GPIB_DPRINTK("autopoll has board lock\n");
+	dev_dbg(board->gpib_dev, "autopoll has board lock\n");
 
 	retval = serial_poll_all(board, serial_timeout);
 	if (retval < 0)	{
@@ -340,7 +340,7 @@ int autopoll_all_devices(gpib_board_t *board)
 		return retval;
 	}
 
-	GPIB_DPRINTK("%s complete\n", __func__);
+	dev_dbg(board->gpib_dev, "%s complete\n", __func__);
 	/* need to wake wait queue in case someone is
 	 * waiting on RQS
 	 */
@@ -358,7 +358,7 @@ static int setup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
 	size_t bytes_written;
 	int ret;
 
-	GPIB_DPRINTK("entering %s()\n", __func__);
+	dev_dbg(board->gpib_dev, "entering %s()\n", __func__);
 
 	os_start_timer(board, usec_timeout);
 	ret = ibcac(board, 1, 1);
@@ -394,7 +394,7 @@ static int read_serial_poll_byte(gpib_board_t *board, unsigned int pad,
 	int i;
 	size_t nbytes;
 
-	GPIB_DPRINTK("entering %s(), pad=%i sad=%i\n", __func__, pad, sad);
+	dev_dbg(board->gpib_dev, "entering %s(), pad=%i sad=%i\n", __func__, pad, sad);
 
 	os_start_timer(board, usec_timeout);
 	ret = ibcac(board, 1, 1);
@@ -436,7 +436,7 @@ static int cleanup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
 	int ret;
 	size_t bytes_written;
 
-	GPIB_DPRINTK("entering %s()\n", __func__);
+	dev_dbg(board->gpib_dev, "entering %s()\n", __func__);
 
 	os_start_timer(board, usec_timeout);
 	ret = ibcac(board, 1, 1);
@@ -485,7 +485,7 @@ int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
 	u8 result;
 	unsigned int num_bytes = 0;
 
-	GPIB_DPRINTK("entering %s()\n", __func__);
+	dev_dbg(board->gpib_dev, "entering %s()\n", __func__);
 
 	head = &board->device_list;
 	if (head->next == head)
@@ -502,7 +502,7 @@ int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
 		if (retval < 0)
 			continue;
 		if (result & request_service_bit) {
-			retval = push_status_byte(device, result);
+			retval = push_status_byte(board, device, result);
 			if (retval < 0)
 				continue;
 			num_bytes++;
@@ -596,15 +596,15 @@ int ibopen(struct inode *inode, struct file *filep)
 	priv = filep->private_data;
 	init_gpib_file_private((gpib_file_private_t *)filep->private_data);
 
-	GPIB_DPRINTK("pid %i, gpib: opening minor %d\n", current->pid, minor);
+	dev_dbg(board->gpib_dev, "pid %i, gpib: opening minor %d\n", current->pid, minor);
 
 	if (board->use_count == 0) {
 		int retval;
 
 		retval = request_module("gpib%i", minor);
 		if (retval) {
-			GPIB_DPRINTK("pid %i, gpib: request module returned %i\n",
-				     current->pid, retval);
+			dev_dbg(board->gpib_dev, "pid %i, gpib: request module returned %i\n",
+				current->pid, retval);
 		}
 	}
 	if (board->interface) {
@@ -630,16 +630,16 @@ int ibclose(struct inode *inode, struct file *filep)
 		return -ENODEV;
 	}
 
-	GPIB_DPRINTK("pid %i, gpib: closing minor %d\n", current->pid, minor);
-
 	board = &board_array[minor];
 
+	dev_dbg(board->gpib_dev, "pid %i, closing minor %d\n", current->pid, minor);
+
 	if (priv) {
 		desc = handle_to_descriptor(priv, 0);
 		if (desc) {
 			if (desc->autopoll_enabled) {
-				GPIB_DPRINTK("pid %i, gpib: decrementing autospollers\n",
-					     current->pid);
+				dev_dbg(board->gpib_dev, "pid %i, decrementing autospollers\n",
+					current->pid);
 				if (board->autospollers > 0)
 					board->autospollers--;
 				else
@@ -682,11 +682,11 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	if (mutex_lock_interruptible(&board->big_gpib_mutex))
 		return -ERESTARTSYS;
 
-	GPIB_DPRINTK("pid %i, minor %i, ioctl %d, interface=%s, use=%d, onl=%d\n",
-		     current->pid, minor, cmd & 0xff,
-		     board->interface ? board->interface->name : "",
-		     board->use_count,
-		     board->online);
+	dev_dbg(board->gpib_dev, "pid %i, ioctl %d, interface=%s, use=%d, onl=%d\n",
+		current->pid, cmd & 0xff,
+		board->interface ? board->interface->name : "",
+		board->use_count,
+		board->online);
 
 	switch (cmd) {
 	case CFCBOARDTYPE:
@@ -870,7 +870,7 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 
 done:
 	mutex_unlock(&board->big_gpib_mutex);
-	GPIB_DPRINTK("ioctl done status = 0x%lx\n", board->status);
+	dev_dbg(board->gpib_dev, "ioctl done status = 0x%lx\n", board->status);
 	return retval;
 }
 
@@ -1180,7 +1180,8 @@ static int status_bytes_ioctl(gpib_board_t *board, unsigned long arg)
 	return 0;
 }
 
-static int increment_open_device_count(struct list_head *head, unsigned int pad, int sad)
+static int increment_open_device_count(gpib_board_t *board, struct list_head *head,
+				       unsigned int pad, int sad)
 {
 	struct list_head *list_ptr;
 	gpib_status_queue_t *device;
@@ -1191,8 +1192,8 @@ static int increment_open_device_count(struct list_head *head, unsigned int pad,
 	for (list_ptr = head->next; list_ptr != head; list_ptr = list_ptr->next) {
 		device = list_entry(list_ptr, gpib_status_queue_t, list);
 		if (gpib_address_equal(device->pad, device->sad, pad, sad)) {
-			GPIB_DPRINTK("pid %i, incrementing open count for pad %i, sad %i\n",
-				     current->pid, device->pad, device->sad);
+			dev_dbg(board->gpib_dev, "pid %i, incrementing open count for pad %i, sad %i\n",
+				current->pid, device->pad, device->sad);
 			device->reference_count++;
 			return 0;
 		}
@@ -1209,14 +1210,14 @@ static int increment_open_device_count(struct list_head *head, unsigned int pad,
 
 	list_add(&device->list, head);
 
-	GPIB_DPRINTK("pid %i, opened pad %i, sad %i\n",
-		     current->pid, device->pad, device->sad);
+	dev_dbg(board->gpib_dev, "pid %i, opened pad %i, sad %i\n",
+		current->pid, device->pad, device->sad);
 
 	return 0;
 }
 
-static int subtract_open_device_count(struct list_head *head, unsigned int pad, int sad,
-				      unsigned int count)
+static int subtract_open_device_count(gpib_board_t *board, struct list_head *head,
+				      unsigned int pad, int sad, unsigned int count)
 {
 	gpib_status_queue_t *device;
 	struct list_head *list_ptr;
@@ -1224,16 +1225,16 @@ static int subtract_open_device_count(struct list_head *head, unsigned int pad,
 	for (list_ptr = head->next; list_ptr != head; list_ptr = list_ptr->next) {
 		device = list_entry(list_ptr, gpib_status_queue_t, list);
 		if (gpib_address_equal(device->pad, device->sad, pad, sad)) {
-			GPIB_DPRINTK("pid %i, decrementing open count for pad %i, sad %i\n",
-				     current->pid, device->pad, device->sad);
+			dev_dbg(board->gpib_dev, "pid %i, decrementing open count for pad %i, sad %i\n",
+				current->pid, device->pad, device->sad);
 			if (count > device->reference_count) {
 				pr_err("gpib: bug! in %s()\n", __func__);
 				return -EINVAL;
 			}
 			device->reference_count -= count;
 			if (device->reference_count == 0) {
-				GPIB_DPRINTK("pid %i, closing pad %i, sad %i\n",
-					     current->pid, device->pad, device->sad);
+				dev_dbg(board->gpib_dev, "pid %i, closing pad %i, sad %i\n",
+					current->pid, device->pad, device->sad);
 				list_del(list_ptr);
 				kfree(device);
 			}
@@ -1244,9 +1245,10 @@ static int subtract_open_device_count(struct list_head *head, unsigned int pad,
 	return -EINVAL;
 }
 
-static inline int decrement_open_device_count(struct list_head *head, unsigned int pad, int sad)
+static inline int decrement_open_device_count(gpib_board_t *board, struct list_head *head,
+					      unsigned int pad, int sad)
 {
-	return subtract_open_device_count(head, pad, sad, 1);
+	return subtract_open_device_count(board, head, pad, sad, 1);
 }
 
 static int cleanup_open_devices(gpib_file_private_t *file_priv, gpib_board_t *board)
@@ -1262,7 +1264,7 @@ static int cleanup_open_devices(gpib_file_private_t *file_priv, gpib_board_t *bo
 			continue;
 
 		if (desc->is_board == 0) {
-			retval = decrement_open_device_count(&board->device_list, desc->pad,
+			retval = decrement_open_device_count(board, &board->device_list, desc->pad,
 							     desc->sad);
 			if (retval < 0)
 				return retval;
@@ -1306,7 +1308,7 @@ static int open_dev_ioctl(struct file *filep, gpib_board_t *board, unsigned long
 	file_priv->descriptors[i]->is_board = open_dev_cmd.is_board;
 	mutex_unlock(&file_priv->descriptors_mutex);
 
-	retval = increment_open_device_count(&board->device_list, open_dev_cmd.pad,
+	retval = increment_open_device_count(board, &board->device_list, open_dev_cmd.pad,
 					     open_dev_cmd.sad);
 	if (retval < 0)
 		return retval;
@@ -1339,7 +1341,7 @@ static int close_dev_ioctl(struct file *filep, gpib_board_t *board, unsigned lon
 	if (!file_priv->descriptors[cmd.handle])
 		return -EINVAL;
 
-	retval = decrement_open_device_count(&board->device_list,
+	retval = decrement_open_device_count(board, &board->device_list,
 					     file_priv->descriptors[cmd.handle]->pad,
 					     file_priv->descriptors[cmd.handle]->sad);
 	if (retval < 0)
@@ -1356,7 +1358,7 @@ static int serial_poll_ioctl(gpib_board_t *board, unsigned long arg)
 	serial_poll_ioctl_t serial_cmd;
 	int retval;
 
-	GPIB_DPRINTK("pid %i, entering %s()\n", __func__, current->pid);
+	dev_dbg(board->gpib_dev, "pid %i, entering %s()\n", current->pid, __func__);
 
 	retval = copy_from_user(&serial_cmd, (void *)arg, sizeof(serial_cmd));
 	if (retval)
@@ -1521,13 +1523,15 @@ static int pad_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 		if (retval < 0)
 			return retval;
 	} else {
-		retval = decrement_open_device_count(&board->device_list, desc->pad, desc->sad);
+		retval = decrement_open_device_count(board, &board->device_list, desc->pad,
+						     desc->sad);
 		if (retval < 0)
 			return retval;
 
 		desc->pad = cmd.pad;
 
-		retval = increment_open_device_count(&board->device_list, desc->pad, desc->sad);
+		retval = increment_open_device_count(board, &board->device_list, desc->pad,
+						     desc->sad);
 		if (retval < 0)
 			return retval;
 	}
@@ -1555,13 +1559,15 @@ static int sad_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 		if (retval < 0)
 			return retval;
 	} else {
-		retval = decrement_open_device_count(&board->device_list, desc->pad, desc->sad);
+		retval = decrement_open_device_count(board, &board->device_list, desc->pad,
+						     desc->sad);
 		if (retval < 0)
 			return retval;
 
 		desc->sad = cmd.sad;
 
-		retval = increment_open_device_count(&board->device_list, desc->pad, desc->sad);
+		retval = increment_open_device_count(board, &board->device_list, desc->pad,
+						     desc->sad);
 		if (retval < 0)
 			return retval;
 	}
@@ -1717,7 +1723,8 @@ static int mutex_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 
 		atomic_set(&file_priv->holding_mutex, 1);
 
-		GPIB_DPRINTK("pid %i, locked board %d mutex\n", current->pid, board->minor);
+		dev_dbg(board->gpib_dev, "pid %i, locked board %d mutex\n",
+			current->pid, board->minor);
 	} else {
 		spin_lock(&board->locking_pid_spinlock);
 		if (current->pid != board->locking_pid) {
@@ -1732,7 +1739,8 @@ static int mutex_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 		atomic_set(&file_priv->holding_mutex, 0);
 
 		mutex_unlock(&board->user_mutex);
-		GPIB_DPRINTK("pid %i, unlocked board %i mutex\n", current->pid, board->minor);
+		dev_dbg(board->gpib_dev, "pid %i, unlocked board %i mutex\n",
+			current->pid, board->minor);
 	}
 	return 0;
 }
@@ -1747,7 +1755,7 @@ static int timeout_ioctl(gpib_board_t *board, unsigned long arg)
 		return -EFAULT;
 
 	board->usec_timeout = timeout;
-	GPIB_DPRINTK("pid %i, timeout set to %i usec\n", current->pid, timeout);
+	dev_dbg(board->gpib_dev, "pid %i, timeout set to %i usec\n", current->pid, timeout);
 
 	return 0;
 }
@@ -1922,7 +1930,7 @@ static int push_gpib_event_nolock(gpib_board_t *board, short event_type)
 		short lost_event;
 
 		queue->dropped_event = 1;
-		retval = pop_gpib_event_nolock(queue, &lost_event);
+		retval = pop_gpib_event_nolock(board, queue, &lost_event);
 		if (retval < 0)
 			return retval;
 	}
@@ -1941,8 +1949,8 @@ static int push_gpib_event_nolock(gpib_board_t *board, short event_type)
 
 	queue->num_events++;
 
-	GPIB_DPRINTK("pushed event %i, %i in queue\n",
-		     (int)event_type, num_gpib_events(queue));
+	dev_dbg(board->gpib_dev, "pushed event %i, %i in queue\n",
+		(int)event_type, num_gpib_events(queue));
 
 	return 0;
 }
@@ -1966,7 +1974,7 @@ int push_gpib_event(gpib_board_t *board, short event_type)
 }
 EXPORT_SYMBOL(push_gpib_event);
 
-static int pop_gpib_event_nolock(gpib_event_queue_t *queue, short *event_type)
+static int pop_gpib_event_nolock(gpib_board_t *board, gpib_event_queue_t *queue, short *event_type)
 {
 	struct list_head *head = &queue->event_head;
 	struct list_head *front = head->next;
@@ -1993,20 +2001,20 @@ static int pop_gpib_event_nolock(gpib_event_queue_t *queue, short *event_type)
 
 	queue->num_events--;
 
-	GPIB_DPRINTK("popped event %i, %i in queue\n",
-		     (int)*event_type, num_gpib_events(queue));
+	dev_dbg(board->gpib_dev, "popped event %i, %i in queue\n",
+		(int)*event_type, num_gpib_events(queue));
 
 	return 0;
 }
 
 // pop event from front of event queue
-int pop_gpib_event(gpib_event_queue_t *queue, short *event_type)
+int pop_gpib_event(gpib_board_t *board, gpib_event_queue_t *queue, short *event_type)
 {
 	unsigned long flags;
 	int retval;
 
 	spin_lock_irqsave(&queue->lock, flags);
-	retval = pop_gpib_event_nolock(queue, event_type);
+	retval = pop_gpib_event_nolock(board, queue, event_type);
 	spin_unlock_irqrestore(&queue->lock, flags);
 	return retval;
 }
@@ -2017,7 +2025,7 @@ static int event_ioctl(gpib_board_t *board, unsigned long arg)
 	int retval;
 	short event;
 
-	retval = pop_gpib_event(&board->event_queue, &event);
+	retval = pop_gpib_event(board, &board->event_queue, &event);
 	if (retval < 0)
 		return retval;
 
@@ -2199,7 +2207,7 @@ void gpib_deallocate_board(gpib_board_t *board)
 		board->buffer_length = 0;
 	}
 	while (num_gpib_events(&board->event_queue))
-		pop_gpib_event(&board->event_queue, &dummy);
+		pop_gpib_event(board, &board->event_queue, &dummy);
 }
 
 static void init_board_array(gpib_board_t *board_array, unsigned int length)
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index 83795e7f5cf1..fc57e760c144 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -178,13 +178,13 @@ static int autospoll_thread(void *board_void)
 	gpib_board_t *board = board_void;
 	int retval = 0;
 
-	GPIB_DPRINTK("entering autospoll thread\n");
+	dev_dbg(board->gpib_dev, "entering autospoll thread\n");
 
 	while (1) {
 		wait_event_interruptible(board->wait,
 					 kthread_should_stop() ||
 					 autospoll_wait_should_wake_up(board));
-		GPIB_DPRINTK("autospoll wait satisfied\n");
+		dev_dbg(board->gpib_dev, "autospoll wait satisfied\n");
 		if (kthread_should_stop())
 			break;
 
@@ -247,7 +247,7 @@ int ibonline(gpib_board_t *board)
 	}
 #endif
 	board->online = 1;
-	GPIB_DPRINTK("gpib: board online\n");
+	dev_dbg(board->gpib_dev, "gpib: board online\n");
 
 	return 0;
 }
@@ -272,7 +272,7 @@ int iboffline(gpib_board_t *board)
 	board->interface->detach(board);
 	gpib_deallocate_board(board);
 	board->online = 0;
-	GPIB_DPRINTK("gpib: board offline\n");
+	dev_dbg(board->gpib_dev, "gpib: board offline\n");
 
 	return 0;
 }
@@ -436,7 +436,7 @@ int ibsic(gpib_board_t *board, unsigned int usec_duration)
 		pr_warn("gpib: warning, shortening long udelay\n");
 	}
 
-	GPIB_DPRINTK("sending interface clear\n");
+	dev_dbg(board->gpib_dev, "sending interface clear\n");
 	board->interface->interface_clear(board, 1);
 	udelay(usec_duration);
 	board->interface->interface_clear(board, 0);
@@ -486,7 +486,7 @@ int ibpad(gpib_board_t *board, unsigned int addr)
 	board->pad = addr;
 	if (board->online)
 		board->interface->primary_address(board, board->pad);
-	GPIB_DPRINTK("set primary addr to %i\n", board->pad);
+	dev_dbg(board->gpib_dev, "set primary addr to %i\n", board->pad);
 	return 0;
 }
 
@@ -509,7 +509,7 @@ int ibsad(gpib_board_t *board, int addr)
 		else
 			board->interface->secondary_address(board, 0, 0);
 	}
-	GPIB_DPRINTK("set secondary addr to %i\n", board->sad);
+	dev_dbg(board->gpib_dev, "set secondary addr to %i\n", board->sad);
 
 	return 0;
 }
@@ -683,7 +683,7 @@ int ibwait(gpib_board_t *board, int wait_mask, int clear_mask, int set_mask,
 
 	if (wait_event_interruptible(board->wait, wait_satisfied(&winfo, status_queue,
 								 wait_mask, status, desc))) {
-		GPIB_DPRINTK("wait interrupted\n");
+		dev_dbg(board->gpib_dev, "wait interrupted\n");
 		retval = -ERESTARTSYS;
 	}
 	remove_wait_timer(&winfo);
diff --git a/drivers/staging/gpib/common/ibsys.h b/drivers/staging/gpib/common/ibsys.h
index 3f53a808a9b9..b78ca5ea4da1 100644
--- a/drivers/staging/gpib/common/ibsys.h
+++ b/drivers/staging/gpib/common/ibsys.h
@@ -20,8 +20,8 @@ int gpib_allocate_board(gpib_board_t *board);
 void gpib_deallocate_board(gpib_board_t *board);
 
 unsigned int num_status_bytes(const gpib_status_queue_t *dev);
-int push_status_byte(gpib_status_queue_t *device, uint8_t poll_byte);
-int pop_status_byte(gpib_status_queue_t *device, uint8_t *poll_byte);
+int push_status_byte(gpib_board_t *board, gpib_status_queue_t *device, uint8_t poll_byte);
+int pop_status_byte(gpib_board_t *board, gpib_status_queue_t *device, uint8_t *poll_byte);
 gpib_status_queue_t *get_gpib_status_queue(gpib_board_t *board, unsigned int pad, int sad);
 int get_serial_poll_byte(gpib_board_t *board, unsigned int pad, int sad,
 			 unsigned int usec_timeout, uint8_t *poll_byte);
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index b528405f33e0..3f938ab0c84d 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -430,7 +430,7 @@ static int fluke_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib write interrupted!\n");
+		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 73409b066727..62791db1c34a 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -440,7 +440,7 @@ static int fmh_gpib_dma_write(gpib_board_t *board, uint8_t *buffer, size_t lengt
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib write interrupted!\n");
+		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -634,7 +634,7 @@ static int fmh_gpib_fifo_write_countable(gpib_board_t *board, uint8_t *buffer,
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib write interrupted!\n");
+		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
diff --git a/drivers/staging/gpib/include/gpibP.h b/drivers/staging/gpib/include/gpibP.h
index 0129fd29e704..5fc42b645ab7 100644
--- a/drivers/staging/gpib/include/gpibP.h
+++ b/drivers/staging/gpib/include/gpibP.h
@@ -26,7 +26,7 @@ struct pci_dev *gpib_pci_get_subsys(const gpib_board_config_t *config, unsigned
 				    unsigned int ss_device, struct pci_dev *from);
 unsigned int num_gpib_events(const gpib_event_queue_t *queue);
 int push_gpib_event(gpib_board_t *board, short event_type);
-int pop_gpib_event(gpib_event_queue_t *queue, short *event_type);
+int pop_gpib_event(gpib_board_t *board, gpib_event_queue_t *queue, short *event_type);
 int gpib_request_pseudo_irq(gpib_board_t *board, irqreturn_t (*handler)(int, void *));
 void gpib_free_pseudo_irq(gpib_board_t *board);
 int gpib_match_device_path(struct device *dev, const char *device_path_in);
@@ -35,12 +35,6 @@ extern gpib_board_t board_array[GPIB_MAX_NUM_BOARDS];
 
 extern struct list_head registered_drivers;
 
-#ifdef GPIB_DEBUG
-#define GPIB_DPRINTK(format, args...) pr_info("gpib debug: " format, ## args)
-#else
-#define GPIB_DPRINTK(arg...)
-#endif
-
 #include <linux/io.h>
 
 void writeb_wrapper(unsigned int value, void *address);
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index e98a114a9570..9d8387c3bf01 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -202,7 +202,7 @@ static int ines_write_wait(gpib_board_t *board, struct ines_priv *ines_priv,
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib write interrupted\n");
+		dev_dbg(board->gpib_dev, "gpib write interrupted\n");
 		return -ERESTARTSYS;
 	}
 	if (test_bit(BUS_ERROR_BN, &nec_priv->state))
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 4c580137043f..796c3a5be545 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -68,11 +68,8 @@ MODULE_DEVICE_TABLE(usb, skel_table);
  *	      At module loading:  modprobe lpvo_usb_gpib debug={0,1,2}
  *	      On the fly: echo {0,1,2} > /sys/modules/lpvo_usb_gpib/parameters/debug
  */
-#ifdef GPIB_DEBUG
-static int debug = 1;
-#else
+
 static int debug;
-#endif
 module_param(debug, int, 0644);
 
 #define DIA_LOG(level, format, ...)					\
@@ -366,10 +363,10 @@ static int one_char(gpib_board_t *board, struct char_buf *b)
 		DIA_LOG(2, "--> %x\n", b->inbuf[b->last - b->nchar]);
 		return b->inbuf[b->last - b->nchar--];
 	} else if (b->nchar == 0) {
-		pr_alert("%s:%s - read returned EOF\n", NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - read returned EOF\n", NAME, __func__);
 		return -EIO;
 	}
-	pr_alert("%s:%s - read error %d\n", NAME, __func__, b->nchar);
+	dev_alert(board->gpib_dev, "%s:%s - read error %d\n", NAME, __func__, b->nchar);
 	TTY_LOG("\n *** %s *** Read Error - %s\n", NAME,
 		"Reset the adapter with 'gpib_config'\n");
 	return -EIO;
@@ -412,8 +409,8 @@ static void set_timeout(gpib_board_t *board)
 	}
 
 	if (val != ACK) {
-		pr_alert("%s:%s - error in timeout set: <%s>\n",
-			 NAME, __func__, command);
+		dev_alert(board->gpib_dev, "%s:%s - error in timeout set: <%s>\n",
+			  NAME, __func__, command);
 	} else {
 		data->timeout = board->usec_timeout;
 	}
@@ -456,8 +453,8 @@ static int usb_gpib_attach(gpib_board_t *board, const gpib_board_config_t *confi
 
 	if (config->device_path) {
 		/* if config->device_path given, try that first */
-		pr_alert("%s:%s - Looking for device_path: %s\n",
-			 NAME, __func__, config->device_path);
+		dev_alert(board->gpib_dev, "%s:%s - Looking for device_path: %s\n",
+			  NAME, __func__, config->device_path);
 		for (j = 0 ; j < MAX_DEV ; j++) {
 			if ((assigned_usb_minors & 1 << j) == 0)
 				continue;
@@ -492,7 +489,8 @@ static int usb_gpib_attach(gpib_board_t *board, const gpib_board_config_t *confi
 	mutex_unlock(&minors_lock);
 
 	if (j == MAX_DEV) {
-		pr_alert("%s:%s - Requested device is not registered.\n", NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - Requested device is not registered.\n",
+			  NAME, __func__);
 		return -EIO;
 	}
 
@@ -737,7 +735,8 @@ static int usb_gpib_line_status(const gpib_board_t *board)
 	buffer = send_command((gpib_board_t *)board, USB_GPIB_STATUS, 0);
 
 	if (buffer < 0) {
-		pr_alert("%s:%s - line status read failed with %d\n", NAME, __func__, buffer);
+		dev_alert(board->gpib_dev, "%s:%s - line status read failed with %d\n",
+			  NAME, __func__, buffer);
 		return -1;
 	}
 
@@ -777,7 +776,7 @@ static int usb_gpib_parallel_poll(gpib_board_t *board, uint8_t *result)
 
 	retval = set_control_line(board, IB_BUS_EOI, 1);
 	if (retval != ACK) {
-		pr_alert("%s:%s - assert EOI failed\n", NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - assert EOI failed\n", NAME, __func__);
 		return -EIO;
 	}
 
@@ -787,7 +786,7 @@ static int usb_gpib_parallel_poll(gpib_board_t *board, uint8_t *result)
 
 	retval = set_control_line(board, IB_BUS_EOI, 0);
 	if (retval != 0x06) {
-		pr_alert("%s:%s - unassert EOI failed\n", NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - unassert EOI failed\n", NAME, __func__);
 		return -EIO;
 	}
 
@@ -869,8 +868,8 @@ static int usb_gpib_read(gpib_board_t *board,
 		goto read_return;
 
 	if (one_char(board, &b) != DLE || one_char(board, &b) != STX) {
-		pr_alert("%s:%s - wrong <DLE><STX> sequence\n",
-			 NAME, __func__);
+		dev_alert(board->gpib_dev, "%s:%s - wrong <DLE><STX> sequence\n",
+			  NAME, __func__);
 		retval = -EIO;
 		goto read_return;
 	}
@@ -910,15 +909,15 @@ static int usb_gpib_read(gpib_board_t *board,
 					retval = 0;
 					goto read_return;
 				} else {
-					pr_alert("%s:%s - %s %x\n",
-						 NAME, __func__,
-						 "Wrong end of message", c);
+					dev_alert(board->gpib_dev, "%s:%s - %s %x\n",
+						  NAME, __func__,
+						  "Wrong end of message", c);
 					retval = -ETIME;
 					goto read_return;
 				}
 			} else {
-				pr_alert("%s:%s - %s\n", NAME, __func__,
-					 "lone <DLE> in stream");
+				dev_alert(board->gpib_dev, "%s:%s - %s\n", NAME, __func__,
+					  "lone <DLE> in stream");
 				retval = -EIO;
 				goto read_return;
 			}
@@ -937,8 +936,8 @@ static int usb_gpib_read(gpib_board_t *board,
 			c = one_char(board, &b);
 			if (c == ACK) {
 				if (MAX_READ_EXCESS - read_count > 1)
-					pr_alert("%s:%s - %s\n", NAME, __func__,
-						 "small buffer - maybe some data lost");
+					dev_alert(board->gpib_dev, "%s:%s - %s\n", NAME, __func__,
+						  "small buffer - maybe some data lost");
 				retval = 0;
 				goto read_return;
 			}
@@ -946,8 +945,8 @@ static int usb_gpib_read(gpib_board_t *board,
 		}
 	}
 
-	pr_alert("%s:%s - no input end - GPIB board in odd state\n",
-		 NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - no input end - GPIB board in odd state\n",
+		  NAME, __func__);
 	retval = -EIO;
 
 read_return:
@@ -973,8 +972,8 @@ static void usb_gpib_remote_enable(gpib_board_t *board, int enable)
 
 	retval = set_control_line(board, IB_BUS_REN, enable ? 1 : 0);
 	if (retval != ACK)
-		pr_alert("%s:%s - could not set REN line: %x\n",
-			 NAME, __func__, retval);
+		dev_alert(board->gpib_dev, "%s:%s - could not set REN line: %x\n",
+			  NAME, __func__, retval);
 
 	DIA_LOG(1, "done with %x\n", retval);
 }
@@ -1072,21 +1071,21 @@ static int usb_gpib_write(gpib_board_t *board,
 static void usb_gpib_parallel_poll_configure(gpib_board_t *board,
 					     uint8_t configuration)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 }
 
 /* parallel_poll_response */
 
 static void usb_gpib_parallel_poll_response(gpib_board_t *board, int ist)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 }
 
 /* primary_address */
 
 static int  usb_gpib_primary_address(gpib_board_t *board, unsigned int address)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
 }
 
@@ -1094,7 +1093,7 @@ static int  usb_gpib_primary_address(gpib_board_t *board, unsigned int address)
 
 static	void usb_gpib_return_to_local(gpib_board_t *board)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 }
 
 /* secondary_address */
@@ -1103,7 +1102,7 @@ static int usb_gpib_secondary_address(gpib_board_t *board,
 				      unsigned int address,
 				      int enable)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
 }
 
@@ -1111,14 +1110,14 @@ static int usb_gpib_secondary_address(gpib_board_t *board,
 
 static void usb_gpib_serial_poll_response(gpib_board_t *board, uint8_t status)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 }
 
 /* serial_poll_status */
 
 static uint8_t usb_gpib_serial_poll_status(gpib_board_t *board)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
 }
 
@@ -1126,7 +1125,7 @@ static uint8_t usb_gpib_serial_poll_status(gpib_board_t *board)
 
 static unsigned int usb_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
-	pr_alert("%s:%s - currently a NOP\n", NAME, __func__);
+	dev_alert(board->gpib_dev, "%s:%s - currently a NOP\n", NAME, __func__);
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/staging/gpib/nec7210/nec7210.c
index 1330743d05fd..1d9951035497 100644
--- a/drivers/staging/gpib/nec7210/nec7210.c
+++ b/drivers/staging/gpib/nec7210/nec7210.c
@@ -53,7 +53,7 @@ int nec7210_parallel_poll(gpib_board_t *board, struct nec7210_priv *priv, uint8_
 	// wait for result FIXME: support timeouts
 	ret = wait_event_interruptible(board->wait, test_bit(COMMAND_READY_BN, &priv->state));
 	if (ret) {
-		GPIB_DPRINTK("gpib: parallel poll interrupted\n");
+		dev_dbg(board->gpib_dev, "gpib: parallel poll interrupted\n");
 		return -ERESTARTSYS;
 	}
 	*result = read_byte(priv, CPTR);
@@ -198,7 +198,7 @@ unsigned int nec7210_update_status_nolock(gpib_board_t *board, struct nec7210_pr
 		priv->srq_pending = 0;
 		set_bit(SPOLL_NUM, &board->status);
 	}
-//	GPIB_DPRINTK("status 0x%x, state 0x%x\n", board->status, priv->state);
+//	dev_dbg(board->gpib_dev, "status 0x%x, state 0x%x\n", board->status, priv->state);
 
 	/* we rely on the interrupt handler to set the
 	 * rest of the status bits
@@ -430,7 +430,7 @@ int nec7210_command(gpib_board_t *board, struct nec7210_priv *priv, uint8_t
 					     test_bit(COMMAND_READY_BN, &priv->state) ||
 					     test_bit(BUS_ERROR_BN, &priv->state) ||
 					     test_bit(TIMO_NUM, &board->status))) {
-			GPIB_DPRINTK("gpib command wait interrupted\n");
+			dev_dbg(board->gpib_dev, "gpib command wait interrupted\n");
 			retval = -ERESTARTSYS;
 			break;
 		}
@@ -455,11 +455,11 @@ int nec7210_command(gpib_board_t *board, struct nec7210_priv *priv, uint8_t
 	if (wait_event_interruptible(board->wait, test_bit(COMMAND_READY_BN, &priv->state) ||
 				     test_bit(BUS_ERROR_BN, &priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib command wait interrupted\n");
+		dev_dbg(board->gpib_dev, "gpib command wait interrupted\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))	{
-		GPIB_DPRINTK("gpib command timed out\n");
+		dev_dbg(board->gpib_dev, "gpib command timed out\n");
 		retval = -ETIMEDOUT;
 	}
 	if (test_and_clear_bit(BUS_ERROR_BN, &priv->state)) {
@@ -484,7 +484,7 @@ static int pio_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buf
 					     test_bit(READ_READY_BN, &priv->state) ||
 					     test_bit(DEV_CLEAR_BN, &priv->state) ||
 					     test_bit(TIMO_NUM, &board->status))) {
-			GPIB_DPRINTK("nec7210: pio read wait interrupted\n");
+			dev_dbg(board->gpib_dev, "nec7210: pio read wait interrupted\n");
 			retval = -ERESTARTSYS;
 			break;
 		}
@@ -503,12 +503,12 @@ static int pio_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buf
 				break;
 		}
 		if (test_bit(TIMO_NUM, &board->status)) {
-			GPIB_DPRINTK("interrupted by timeout\n");
+			dev_dbg(board->gpib_dev, "interrupted by timeout\n");
 			retval = -ETIMEDOUT;
 			break;
 		}
 		if (test_bit(DEV_CLEAR_BN, &priv->state)) {
-			GPIB_DPRINTK("interrupted by device clear\n");
+			dev_dbg(board->gpib_dev, "interrupted by device clear\n");
 			retval = -EINTR;
 			break;
 		}
@@ -558,7 +558,7 @@ static ssize_t __dma_read(gpib_board_t *board, struct nec7210_priv *priv, size_t
 				     test_bit(DMA_READ_IN_PROGRESS_BN, &priv->state) == 0 ||
 				     test_bit(DEV_CLEAR_BN, &priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("nec7210: dma read wait interrupted\n");
+		dev_dbg(board->gpib_dev, "nec7210: dma read wait interrupted\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -639,19 +639,19 @@ static int pio_write_wait(gpib_board_t *board, struct nec7210_priv *priv,
 				     (wake_on_lacs && test_bit(LACS_NUM, &board->status)) ||
 				     (wake_on_atn && test_bit(ATN_NUM, &board->status)) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib write interrupted\n");
+		dev_dbg(board->gpib_dev, "gpib write interrupted\n");
 		return -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))	{
-		GPIB_DPRINTK("nec7210: write timed out\n");
+		dev_dbg(board->gpib_dev, "nec7210: write timed out\n");
 		return -ETIMEDOUT;
 	}
 	if (test_bit(DEV_CLEAR_BN, &priv->state)) {
-		GPIB_DPRINTK("nec7210: write interrupted by clear\n");
+		dev_dbg(board->gpib_dev, "nec7210: write interrupted by clear\n");
 		return -EINTR;
 	}
 	if (wake_on_bus_error && test_and_clear_bit(BUS_ERROR_BN, &priv->state)) {
-		GPIB_DPRINTK("nec7210: bus error on write\n");
+		dev_dbg(board->gpib_dev, "nec7210: bus error on write\n");
 		return -EIO;
 	}
 	return 0;
@@ -677,7 +677,7 @@ static int pio_write(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *bu
 		if (retval == -EIO) {
 			/* resend last byte on bus error */
 			*bytes_written = last_count;
-			GPIB_DPRINTK("resending %c\n", buffer[*bytes_written]);
+			dev_dbg(board->gpib_dev, "resending %c\n", buffer[*bytes_written]);
 			/* we can get unrecoverable bus errors,
 			 * so give up after a while
 			 */
@@ -734,7 +734,7 @@ static ssize_t __dma_write(gpib_board_t *board, struct nec7210_priv *priv, dma_a
 				     test_bit(BUS_ERROR_BN, &priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib write interrupted!\n");
+		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -969,8 +969,8 @@ irqreturn_t nec7210_interrupt_have_status(gpib_board_t *board,
 	    (status2 & (priv->reg_bits[IMR2] & IMR2_ENABLE_INTR_MASK)) ||
 	    nec7210_atn_has_changed(board, priv))	{
 		nec7210_update_status_nolock(board, priv);
-		GPIB_DPRINTK("minor %i, stat %lx, isr1 0x%x, imr1 0x%x, isr2 0x%x, imr2 0x%x\n",
-			     board->minor, board->status, status1, priv->reg_bits[IMR1], status2,
+		dev_dbg(board->gpib_dev, "minor %i, stat %lx, isr1 0x%x, imr1 0x%x, isr2 0x%x, imr2 0x%x\n",
+			board->minor, board->status, status1, priv->reg_bits[IMR1], status2,
 			     priv->reg_bits[IMR2]);
 		wake_up_interruptible(&board->wait); /* wake up sleeping process */
 		retval = IRQ_HANDLED;
diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index 6452757f0a2a..152b243b845b 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -382,7 +382,7 @@ static unsigned int update_status_nolock(gpib_board_t *board, struct tms9914_pri
 			clear_bit(SRQI_NUM, &board->status);
 	}
 
-	GPIB_DPRINTK("status 0x%lx, state 0x%lx\n", board->status, priv->state);
+	dev_dbg(board->gpib_dev, "status 0x%lx, state 0x%lx\n", board->status, priv->state);
 
 	return board->status;
 }
@@ -549,7 +549,7 @@ static int pio_write_wait(gpib_board_t *board, struct tms9914_priv *priv)
 				     test_bit(BUS_ERROR_BN, &priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib write interrupted!\n");
+		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
 		return -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -774,7 +774,7 @@ irqreturn_t tms9914_interrupt_have_status(gpib_board_t *board, struct tms9914_pr
 	}
 
 	if (status1 & HR_ERR) {
-		GPIB_DPRINTK("gpib bus error\n");
+		dev_dbg(board->gpib_dev, "gpib bus error\n");
 		set_bit(BUS_ERROR_BN, &priv->state);
 	}
 
@@ -807,7 +807,7 @@ irqreturn_t tms9914_interrupt_have_status(gpib_board_t *board, struct tms9914_pr
 	}
 
 	if ((status0 & priv->imr0_bits) || (status1 & priv->imr1_bits))	{
-//		GPIB_DPRINTK("isr0 0x%x, imr0 0x%x, isr1 0x%x, imr1 0x%x\n",
+//		dev_dbg(board->gpib_dev, "isr0 0x%x, imr0 0x%x, isr1 0x%x, imr1 0x%x\n",
 //			status0, priv->imr0_bits, status1, priv->imr1_bits);
 		update_status_nolock(board, priv);
 		wake_up_interruptible(&board->wait);
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index 4d702c4452e8..e49a952fa0d8 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -491,7 +491,7 @@ static int write_wait(gpib_board_t *board, struct tnt4882_priv *tnt_priv,
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		GPIB_DPRINTK("gpib write interrupted\n");
+		dev_dbg(board->gpib_dev, "gpib write interrupted\n");
 		return -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))	{
@@ -637,9 +637,8 @@ irqreturn_t tnt4882_internal_interrupt(gpib_board_t *board)
 	if (isr3_bits & HR_DONE)
 		priv->imr3_bits &= ~HR_DONE;
 	if (isr3_bits & (HR_INTR | HR_TLCI)) {
-		GPIB_DPRINTK("tnt4882: minor %i isr0 0x%x imr0 0x%x isr3 0x%x imr3 0x%x\n",
-			     board->minor,
-			     isr0_bits, priv->imr0_bits, isr3_bits, imr3_bits);
+		dev_dbg(board->gpib_dev, "tnt4882: minor %i isr0 0x%x imr0 0x%x isr3 0x%x imr3 0x%x\n",
+			board->minor, isr0_bits, priv->imr0_bits, isr3_bits, imr3_bits);
 		tnt_writeb(priv, priv->imr3_bits, IMR3);
 		wake_up_interruptible(&board->wait);
 	}
-- 
2.46.2


