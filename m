Return-Path: <linux-kernel+bounces-514878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA89EA35CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25FA16CE1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE5264A60;
	Fri, 14 Feb 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+jxO+lR"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121A2627E5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533664; cv=none; b=HDTPTIzYL6Vx1NulDK2mhYfPd/A7MfBQ7xRZzIxeuis8ITACPk+g7BdN0809MqltN7hR+t3AbqLCJij+V6Fni6dOdbxtV4ArVSJ7dfouHU4dtEcSMjFJR9A/2sC1ogKIi8Sr0Vt5g0UptmM8DZ2ZkoZYEYNuRSweuspeITd/Yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533664; c=relaxed/simple;
	bh=ZywxOrYgvHFFiQ/8GDS8TfmtpXo4vJhcFhYY/yQLh4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxSsG4X/zJ0NlCMlnH0DgChji+qyuaRihTG1h28Yuj2sK9fYdLAN7QgjFiVqmKNqGwL3ah26DCC/11qwT8Cr5yhXGSZ/sJrRtAoFMMDxbyEHDiE1p7J3arAp5YvbCKhmJiBuTIhHagjHnzgFOvdFtircFKEwPDv+tHRHrLScDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+jxO+lR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4395f81db4dso11939275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533660; x=1740138460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXyrKlOrfR3q5Ztt5mPFoThAT1sW/ZsLF0+k90uvq1I=;
        b=C+jxO+lRuc28/CoD4l6AWxnwe5E9qE061EiePmq1/vG8T9d7iRq+xaKKcZzWTsnJws
         JgDuqpVnuaSBFFOFxE763uXI1IuUnEqZ8ENluzXucI72fUqjUjG+5D7191m+YMNxe/rm
         3vFEB5gQa8epiI0OMOUezA16edq2qHNFA5yVWToIe0IMwKw3udvvJ0bFwLlTUfFqlbZE
         yvYF8VMaSgf6jRg2JwbbmhtK1yicGuDoiWsAtIeLcUvcZ10PcgW8zZjVLJU1bv/B7HNH
         9DQJfLkZe7xyCYr/qvSdD7VU/5cmDxclgwQXk0+JzrfxbgMEKk9Hyd9FoYPrO6VoMA/h
         4H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533660; x=1740138460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXyrKlOrfR3q5Ztt5mPFoThAT1sW/ZsLF0+k90uvq1I=;
        b=u02p99c+cqeC2k5lXu1pwfW7EV+ZwJONzd4imbc0yF12XsCrVXTyKQC6DbF81OEc3s
         R7GCSCgtcor4gcNBTEGoDkNr0/kN7/LORNzSGK62/25ksDFYdTOP9kcEMzWeL5DsodMj
         85HxkaPizZ5YkjGnoh5nl99xUoDk6JmnCADOXnjk3Kdi0iS/YZTJ/bwvtORez5CIRfRN
         QfGDBxGy3Y+Ch7vGUM58yXT3dToUyhHJ9D0ovsPNBGwOiUKk9gAJuggf0OCOjAc1KtxP
         5/0HTfMZbAYEjsVUbDWlE1IbAQZynRdS7y54BaR/86WUxjGZ6xqsFapqbEpnvVI2lpgq
         OZog==
X-Forwarded-Encrypted: i=1; AJvYcCUTxNs+Qeyw7vur5GEKUWgPex/6UEmVmnKus57UrQuEKq6WVyCjDwqXFqGlsX+syFbLKJQrbvegLvEvQi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BpoTtZbdL+ZHi9j8VbFdMtWzpkt/f5Oawmq4cCXuzjDZQcFx
	CUdoBNAvgGBJEgfBSs/kE63PFI9hCNFjzuFU8tgGFG1DVgG85yt+q+xBTw==
X-Gm-Gg: ASbGncuzhaLhVBv6SLJRRRPUef1DcrYYNm/3v7/TgqROpfvGF+AszFRqljMIA9bk/Fm
	MAaHCkcwbfOxuAtf/XJ7Zc7PUDrDXEvDaZaqvaPIGLah+sK6XzGxWokDALebBTwtG/zrdtKA5SI
	1OqqWyCxflLCeIVp4/BoKghKgcZzxX47Pa3KMwMW3L26x3cunSevnvxpNAu079COo56DWIsl3my
	p1bIhJ4TyvzEnsvH7vqZJdW3+dMTo/XTi4uhAXiD5HOI7II/oCQAtZeZJYXRs8tpKR0oRZfBCb1
	Z9wBMDj1yE8M+w9LbINlu+wSs9OM7yPgFqxA3E+GWqRsOjsrCfk=
X-Google-Smtp-Source: AGHT+IHWR2BBjTJ2Y2EAhBzpRZh9XEXRCPHOfzYuef9eGKtrToLwMZcWdJBDL3bC9QEUvtNPd7mOQw==
X-Received: by 2002:a05:600c:1d20:b0:438:e521:1a4d with SMTP id 5b1f17b1804b1-43960e81a94mr72325745e9.5.1739533659455;
        Fri, 14 Feb 2025 03:47:39 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:38 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 05/17] staging: gpib: common core console messaging cleanup
Date: Fri, 14 Feb 2025 12:46:56 +0100
Message-ID: <20250214114708.28947-6-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214114708.28947-1-dpenkler@gmail.com>
References: <20250214114708.28947-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable module name to be printed in pr_xxx and dev_xxx

Change pr_err to dev_err wherever possible.

Remove dev_dbg messages on entry to some functions.

Remove error messages where userland can figure out
what went wrong through errno.

Remove __func__ and pid parameters in dev_dbg messages as
these can be enabled by dynamic debug.

Remove minor and "gpib" from dev_err and dev_dbg messages
since this information is printed by the dev name.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/common/gpib_os.c | 127 ++++++++++----------------
 drivers/staging/gpib/common/iblib.c   | 109 ++++++++--------------
 2 files changed, 85 insertions(+), 151 deletions(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 4901e660242e..301c8a1a62c2 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -5,6 +5,9 @@
  ***************************************************************************
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+
 #include "ibsys.h"
 #include <linux/module.h>
 #include <linux/wait.h>
@@ -90,7 +93,7 @@ void os_start_timer(gpib_board_t *board, unsigned int usec_timeout)
 /* Starts the timeout task  */
 {
 	if (timer_pending(&board->timer)) {
-		pr_err("gpib: bug! timer already running?\n");
+		dev_err(board->gpib_dev, "bug! timer already running?\n");
 		return;
 	}
 	clear_bit(TIMO_NUM, &board->status);
@@ -140,7 +143,7 @@ static void pseudo_irq_handler(struct timer_list *t)
 int gpib_request_pseudo_irq(gpib_board_t *board, irqreturn_t (*handler)(int, void *))
 {
 	if (timer_pending(&board->pseudo_irq.timer) || board->pseudo_irq.handler) {
-		pr_err("gpib: only one pseudo interrupt per board allowed\n");
+		dev_err(board->gpib_dev, "only one pseudo interrupt per board allowed\n");
 		return -1;
 	}
 
@@ -260,8 +263,6 @@ int get_serial_poll_byte(gpib_board_t *board, unsigned int pad, int sad, unsigne
 {
 	gpib_status_queue_t *device;
 
-	dev_dbg(board->gpib_dev, "%s:()\n", __func__);
-
 	device = get_gpib_status_queue(board, pad, sad);
 	if (num_status_bytes(device))
 		return pop_status_byte(board, device, poll_byte);
@@ -273,7 +274,6 @@ int autopoll_all_devices(gpib_board_t *board)
 {
 	int retval;
 
-	dev_dbg(board->gpib_dev, "entering %s()\n", __func__);
 	if (mutex_lock_interruptible(&board->user_mutex))
 		return -ERESTARTSYS;
 	if (mutex_lock_interruptible(&board->big_gpib_mutex)) {
@@ -290,7 +290,7 @@ int autopoll_all_devices(gpib_board_t *board)
 		return retval;
 	}
 
-	dev_dbg(board->gpib_dev, "%s complete\n", __func__);
+	dev_dbg(board->gpib_dev, "complete\n");
 	/* need to wake wait queue in case someone is
 	 * waiting on RQS
 	 */
@@ -308,8 +308,6 @@ static int setup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
 	size_t bytes_written;
 	int ret;
 
-	dev_dbg(board->gpib_dev, "entering %s()\n", __func__);
-
 	os_start_timer(board, usec_timeout);
 	ret = ibcac(board, 1, 1);
 	if (ret < 0) {
@@ -326,7 +324,7 @@ static int setup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
 
 	ret = board->interface->command(board, cmd_string, i, &bytes_written);
 	if (ret < 0 || bytes_written < i) {
-		pr_err("gpib: failed to setup serial poll\n");
+		dev_dbg(board->gpib_dev, "failed to setup serial poll\n");
 		os_remove_timer(board);
 		return -EIO;
 	}
@@ -344,7 +342,7 @@ static int read_serial_poll_byte(gpib_board_t *board, unsigned int pad,
 	int i;
 	size_t nbytes;
 
-	dev_dbg(board->gpib_dev, "entering %s(), pad=%i sad=%i\n", __func__, pad, sad);
+	dev_dbg(board->gpib_dev, "entering  pad=%i sad=%i\n", pad, sad);
 
 	os_start_timer(board, usec_timeout);
 	ret = ibcac(board, 1, 1);
@@ -361,7 +359,7 @@ static int read_serial_poll_byte(gpib_board_t *board, unsigned int pad,
 
 	ret = board->interface->command(board, cmd_string, i, &nbytes);
 	if (ret < 0 || nbytes < i) {
-		pr_err("gpib: failed to setup serial poll\n");
+		dev_err(board->gpib_dev, "failed to setup serial poll\n");
 		os_remove_timer(board);
 		return -EIO;
 	}
@@ -371,7 +369,7 @@ static int read_serial_poll_byte(gpib_board_t *board, unsigned int pad,
 	// read poll result
 	ret = board->interface->read(board, result, 1, &end_flag, &nbytes);
 	if (ret < 0 || nbytes < 1) {
-		pr_err("gpib: serial poll failed\n");
+		dev_err(board->gpib_dev, "serial poll failed\n");
 		os_remove_timer(board);
 		return -EIO;
 	}
@@ -386,8 +384,6 @@ static int cleanup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
 	int ret;
 	size_t bytes_written;
 
-	dev_dbg(board->gpib_dev, "entering %s()\n", __func__);
-
 	os_start_timer(board, usec_timeout);
 	ret = ibcac(board, 1, 1);
 	if (ret < 0) {
@@ -399,7 +395,7 @@ static int cleanup_serial_poll(gpib_board_t *board, unsigned int usec_timeout)
 	cmd_string[1] = UNT;
 	ret = board->interface->command(board, cmd_string, 2, &bytes_written);
 	if (ret < 0 || bytes_written < 2) {
-		pr_err("gpib: failed to disable serial poll\n");
+		dev_err(board->gpib_dev, "failed to disable serial poll\n");
 		os_remove_timer(board);
 		return -EIO;
 	}
@@ -435,8 +431,6 @@ int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
 	u8 result;
 	unsigned int num_bytes = 0;
 
-	dev_dbg(board->gpib_dev, "entering %s()\n", __func__);
-
 	head = &board->device_list;
 	if (head->next == head)
 		return 0;
@@ -482,12 +476,12 @@ int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
 	int retval;
 
 	if ((status & CIC) == 0) {
-		pr_err("gpib: not CIC during serial poll\n");
+		dev_err(board->gpib_dev, "not CIC during serial poll\n");
 		return -1;
 	}
 
 	if (pad > MAX_GPIB_PRIMARY_ADDRESS || sad > MAX_GPIB_SECONDARY_ADDRESS || sad < -1) {
-		pr_err("gpib: bad address for serial poll");
+		dev_err(board->gpib_dev, "bad address for serial poll");
 		return -1;
 	}
 
@@ -544,20 +538,16 @@ int ibopen(struct inode *inode, struct file *filep)
 	priv = filep->private_data;
 	init_gpib_file_private((gpib_file_private_t *)filep->private_data);
 
-	dev_dbg(board->gpib_dev, "pid %i, gpib: opening minor %d\n", current->pid, minor);
-
 	if (board->use_count == 0) {
 		int retval;
 
 		retval = request_module("gpib%i", minor);
-		if (retval) {
-			dev_dbg(board->gpib_dev, "pid %i, gpib: request module returned %i\n",
-				current->pid, retval);
-		}
+		if (retval)
+			dev_dbg(board->gpib_dev, "request module returned %i\n", retval);
 	}
 	if (board->interface) {
 		if (!try_module_get(board->provider_module)) {
-			pr_err("gpib: try_module_get() failed\n");
+			dev_err(board->gpib_dev, "try_module_get() failed\n");
 			return -EIO;
 		}
 		board->use_count++;
@@ -580,21 +570,19 @@ int ibclose(struct inode *inode, struct file *filep)
 
 	board = &board_array[minor];
 
-	dev_dbg(board->gpib_dev, "pid %i, closing minor %d\n", current->pid, minor);
-
 	if (priv) {
 		desc = handle_to_descriptor(priv, 0);
 		if (desc) {
 			if (desc->autopoll_enabled) {
-				dev_dbg(board->gpib_dev, "pid %i, decrementing autospollers\n",
-					current->pid);
+				dev_dbg(board->gpib_dev, "decrementing autospollers\n");
 				if (board->autospollers > 0)
 					board->autospollers--;
 				else
-					pr_err("gpib: Attempt to decrement zero autospollers\n");
+					dev_err(board->gpib_dev,
+						"Attempt to decrement zero autospollers\n");
 			}
 		} else {
-			pr_err("gpib: Unexpected null gpib_descriptor\n");
+			dev_err(board->gpib_dev, "Unexpected null gpib_descriptor\n");
 		}
 
 		cleanup_open_devices(priv, board);
@@ -630,8 +618,8 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	if (mutex_lock_interruptible(&board->big_gpib_mutex))
 		return -ERESTARTSYS;
 
-	dev_dbg(board->gpib_dev, "pid %i, ioctl %d, interface=%s, use=%d, onl=%d\n",
-		current->pid, cmd & 0xff,
+	dev_dbg(board->gpib_dev, "ioctl %d, interface=%s, use=%d, onl=%d\n",
+		cmd & 0xff,
 		board->interface ? board->interface->name : "",
 		board->use_count,
 		board->online);
@@ -647,13 +635,13 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	if (!board->interface) {
-		pr_err("gpib: no gpib board configured on /dev/gpib%i\n", minor);
+		dev_err(board->gpib_dev, "no gpib board configured\n");
 		retval = -ENODEV;
 		goto done;
 	}
 	if (file_priv->got_module == 0)	{
 		if (!try_module_get(board->provider_module)) {
-			pr_err("gpib: try_module_get() failed\n");
+			dev_err(board->gpib_dev, "try_module_get() failed\n");
 			retval = -EIO;
 			goto done;
 		}
@@ -699,8 +687,6 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	}
 
 	if (!board->online) {
-		pr_err("gpib: ioctl %i invalid for offline board\n",
-		       cmd & 0xff);
 		retval = -EINVAL;
 		goto done;
 	}
@@ -737,8 +723,6 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	spin_lock(&board->locking_pid_spinlock);
 	if (current->pid != board->locking_pid)	{
 		spin_unlock(&board->locking_pid_spinlock);
-		pr_err("gpib: need to hold board lock to perform ioctl %i\n",
-		       cmd & 0xff);
 		retval = -EPERM;
 		goto done;
 	}
@@ -830,10 +814,8 @@ static int board_type_ioctl(gpib_file_private_t *file_priv, gpib_board_t *board,
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (board->online) {
-		pr_err("gpib: can't change board type while board is online.\n");
+	if (board->online)
 		return -EBUSY;
-	}
 
 	retval = copy_from_user(&cmd, (void __user *)arg, sizeof(board_type_ioctl_t));
 	if (retval)
@@ -1140,8 +1122,8 @@ static int increment_open_device_count(gpib_board_t *board, struct list_head *he
 	for (list_ptr = head->next; list_ptr != head; list_ptr = list_ptr->next) {
 		device = list_entry(list_ptr, gpib_status_queue_t, list);
 		if (gpib_address_equal(device->pad, device->sad, pad, sad)) {
-			dev_dbg(board->gpib_dev, "pid %i, incrementing open count for pad %i, sad %i\n",
-				current->pid, device->pad, device->sad);
+			dev_dbg(board->gpib_dev, "incrementing open count for pad %i, sad %i\n",
+				device->pad, device->sad);
 			device->reference_count++;
 			return 0;
 		}
@@ -1158,8 +1140,7 @@ static int increment_open_device_count(gpib_board_t *board, struct list_head *he
 
 	list_add(&device->list, head);
 
-	dev_dbg(board->gpib_dev, "pid %i, opened pad %i, sad %i\n",
-		current->pid, device->pad, device->sad);
+	dev_dbg(board->gpib_dev, "opened pad %i, sad %i\n", device->pad, device->sad);
 
 	return 0;
 }
@@ -1173,23 +1154,23 @@ static int subtract_open_device_count(gpib_board_t *board, struct list_head *hea
 	for (list_ptr = head->next; list_ptr != head; list_ptr = list_ptr->next) {
 		device = list_entry(list_ptr, gpib_status_queue_t, list);
 		if (gpib_address_equal(device->pad, device->sad, pad, sad)) {
-			dev_dbg(board->gpib_dev, "pid %i, decrementing open count for pad %i, sad %i\n",
-				current->pid, device->pad, device->sad);
+			dev_dbg(board->gpib_dev, "decrementing open count for pad %i, sad %i\n",
+				device->pad, device->sad);
 			if (count > device->reference_count) {
-				pr_err("gpib: bug! in %s()\n", __func__);
+				dev_err(board->gpib_dev, "bug! in %s()\n", __func__);
 				return -EINVAL;
 			}
 			device->reference_count -= count;
 			if (device->reference_count == 0) {
-				dev_dbg(board->gpib_dev, "pid %i, closing pad %i, sad %i\n",
-					current->pid, device->pad, device->sad);
+				dev_dbg(board->gpib_dev, "closing pad %i, sad %i\n",
+					device->pad, device->sad);
 				list_del(list_ptr);
 				kfree(device);
 			}
 			return 0;
 		}
 	}
-	pr_err("gpib: bug! tried to close address that was never opened!\n");
+	dev_err(board->gpib_dev, "bug! tried to close address that was never opened!\n");
 	return -EINVAL;
 }
 
@@ -1306,8 +1287,6 @@ static int serial_poll_ioctl(gpib_board_t *board, unsigned long arg)
 	serial_poll_ioctl_t serial_cmd;
 	int retval;
 
-	dev_dbg(board->gpib_dev, "pid %i, entering %s()\n", current->pid, __func__);
-
 	retval = copy_from_user(&serial_cmd, (void __user *)arg, sizeof(serial_cmd));
 	if (retval)
 		return -EFAULT;
@@ -1639,11 +1618,12 @@ static int autospoll_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 				board->autospollers--;
 				retval = 0;
 			} else {
-				pr_err("gpib: tried to set number of autospollers negative\n");
+				dev_err(board->gpib_dev,
+					"tried to set number of autospollers negative\n");
 				retval = -EINVAL;
 			}
 		} else {
-			pr_err("gpib: autopoll disable requested before enable\n");
+			dev_err(board->gpib_dev, "autopoll disable requested before enable\n");
 			retval = -EINVAL;
 		}
 	}
@@ -1661,10 +1641,8 @@ static int mutex_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 
 	if (lock_mutex)	{
 		retval = mutex_lock_interruptible(&board->user_mutex);
-		if (retval) {
-			pr_warn("gpib: ioctl interrupted while waiting on lock\n");
+		if (retval)
 			return -ERESTARTSYS;
-		}
 
 		spin_lock(&board->locking_pid_spinlock);
 		board->locking_pid = current->pid;
@@ -1672,13 +1650,12 @@ static int mutex_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 
 		atomic_set(&file_priv->holding_mutex, 1);
 
-		dev_dbg(board->gpib_dev, "pid %i, locked board %d mutex\n",
-			current->pid, board->minor);
+		dev_dbg(board->gpib_dev, "locked board mutex\n");
 	} else {
 		spin_lock(&board->locking_pid_spinlock);
 		if (current->pid != board->locking_pid) {
-			pr_err("gpib: bug! pid %i tried to release mutex held by pid %i\n",
-			       current->pid, board->locking_pid);
+			dev_err(board->gpib_dev, "bug! pid %i tried to release mutex held by pid %i\n",
+				current->pid, board->locking_pid);
 			spin_unlock(&board->locking_pid_spinlock);
 			return -EPERM;
 		}
@@ -1688,8 +1665,7 @@ static int mutex_ioctl(gpib_board_t *board, gpib_file_private_t *file_priv,
 		atomic_set(&file_priv->holding_mutex, 0);
 
 		mutex_unlock(&board->user_mutex);
-		dev_dbg(board->gpib_dev, "pid %i, unlocked board %i mutex\n",
-			current->pid, board->minor);
+		dev_dbg(board->gpib_dev, "unlocked board mutex\n");
 	}
 	return 0;
 }
@@ -1704,7 +1680,7 @@ static int timeout_ioctl(gpib_board_t *board, unsigned long arg)
 		return -EFAULT;
 
 	board->usec_timeout = timeout;
-	dev_dbg(board->gpib_dev, "pid %i, timeout set to %i usec\n", current->pid, timeout);
+	dev_dbg(board->gpib_dev, "timeout set to %i usec\n", timeout);
 
 	return 0;
 }
@@ -1744,10 +1720,8 @@ static int set_local_ppoll_mode_ioctl(gpib_board_t *board, unsigned long arg)
 	if (retval)
 		return -EFAULT;
 
-	if (!board->interface->local_parallel_poll_mode)	{
-		pr_warn("gpib: local/remote parallel poll mode not supported by driver.");
-		return -EIO;
-	}
+	if (!board->interface->local_parallel_poll_mode)
+		return -ENOENT;
 	board->local_ppoll_mode = cmd != 0;
 	board->interface->local_parallel_poll_mode(board, board->local_ppoll_mode);
 
@@ -1887,7 +1861,7 @@ static int push_gpib_event_nolock(gpib_board_t *board, short event_type)
 	event = kmalloc(sizeof(gpib_event_t), GFP_ATOMIC);
 	if (!event) {
 		queue->dropped_event = 1;
-		pr_err("gpib: failed to allocate memory for event\n");
+		dev_err(board->gpib_dev, "failed to allocate memory for event\n");
 		return -ENOMEM;
 	}
 
@@ -2007,10 +1981,8 @@ static int t1_delay_ioctl(gpib_board_t *board, unsigned long arg)
 	unsigned int delay;
 	int retval;
 
-	if (!board->interface->t1_delay)	{
-		pr_warn("gpib: t1 delay not implemented in driver!\n");
-		return -EIO;
-	}
+	if (!board->interface->t1_delay)
+		return -ENOENT;
 
 	retval = copy_from_user(&cmd, (void __user *)arg, sizeof(cmd));
 	if (retval)
@@ -2087,7 +2059,6 @@ void gpib_unregister_driver(gpib_interface_t *interface)
 			kfree(entry);
 		}
 	}
-	pr_info("gpib: unregistered %s interface\n", interface->name);
 }
 EXPORT_SYMBOL(gpib_unregister_driver);
 
@@ -2184,7 +2155,7 @@ static int __init gpib_common_init_module(void)
 {
 	int i;
 
-	pr_info("Linux-GPIB core driver\n");
+	pr_info("GPIB core driver\n");
 	init_board_array(board_array, GPIB_MAX_NUM_BOARDS);
 	if (register_chrdev(GPIB_CODE, "gpib", &ib_fops)) {
 		pr_err("gpib: can't get major %d\n", GPIB_CODE);
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index 5f6fa135f505..fd2874c2fff4 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -4,6 +4,8 @@
  *    copyright            : (C) 2001, 2002 by Frank Mori Hess
  ***************************************************************************/
 
+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "ibsys.h"
 #include <linux/delay.h>
 #include <linux/kthread.h>
@@ -24,10 +26,8 @@ int ibcac(gpib_board_t *board, int sync, int fallback_to_async)
 	int status = ibstatus(board);
 	int retval;
 
-	if ((status & CIC) == 0) {
-		pr_err("gpib: not CIC during %s()\n", __func__);
-		return -1;
-	}
+	if ((status & CIC) == 0)
+		return -EINVAL;
 
 	if (status & ATN)
 		return 0;
@@ -76,13 +76,6 @@ static int check_for_command_acceptors(gpib_board_t *board)
 	if (lines < 0)
 		return lines;
 
-	if (lines & ValidATN) {
-		if ((lines & BusATN) == 0) {
-			pr_err("gpib: ATN not asserted in %s()?", __func__);
-			return 0;
-		}
-	}
-
 	if ((lines & ValidNRFD) && (lines & ValidNDAC))	{
 		if ((lines & BusNRFD) == 0 && (lines & BusNDAC) == 0)
 			return -ENOTCONN;
@@ -112,10 +105,8 @@ int ibcmd(gpib_board_t *board, uint8_t *buf, size_t length, size_t *bytes_writte
 
 	status = ibstatus(board);
 
-	if ((status & CIC) == 0) {
-		pr_err("gpib: cannot send command when not controller-in-charge\n");
-		return -EIO;
-	}
+	if ((status & CIC) == 0)
+		return -EINVAL;
 
 	os_start_timer(board, board->usec_timeout);
 
@@ -145,14 +136,10 @@ int ibgts(gpib_board_t *board)
 	int status = ibstatus(board);
 	int retval;
 
-	if ((status & CIC) == 0) {
-		pr_err("gpib: not CIC during %s()\n", __func__);
-		return -1;
-	}
+	if ((status & CIC) == 0)
+		return -EINVAL;
 
 	retval = board->interface->go_to_standby(board);    /* go to standby */
-	if (retval < 0)
-		pr_err("gpib: error while going to standby\n");
 
 	board->interface->update_status(board, 0);
 
@@ -200,16 +187,15 @@ static int autospoll_thread(void *board_void)
 			retval = autopoll_all_devices(board);
 			module_put(board->provider_module);
 		} else {
-			pr_err("gpib%i: %s: try_module_get() failed!\n", board->minor, __func__);
+			dev_err(board->gpib_dev, "try_module_get() failed!\n");
 		}
 		if (retval <= 0) {
-			pr_err("gpib%i: %s: stuck SRQ\n", board->minor, __func__);
+			dev_err(board->gpib_dev, "stuck SRQ\n");
 
 			atomic_set(&board->stuck_srq, 1);	// XXX could be better
 			set_bit(SRQI_NUM, &board->status);
 		}
 	}
-	pr_info("gpib%i: exiting autospoll thread\n", board->minor);
 	return retval;
 }
 
@@ -230,7 +216,6 @@ int ibonline(gpib_board_t *board)
 	retval = board->interface->attach(board, &board->config);
 	if (retval < 0) {
 		board->interface->detach(board);
-		pr_err("gpib: interface attach failed\n");
 		return retval;
 	}
 	/* nios2nommu on 2.6.11 uclinux kernel has weird problems
@@ -241,13 +226,13 @@ int ibonline(gpib_board_t *board)
 					    "gpib%d_autospoll_kthread", board->minor);
 	retval = IS_ERR(board->autospoll_task);
 	if (retval) {
-		pr_err("gpib: failed to create autospoll thread\n");
+		dev_err(board->gpib_dev, "failed to create autospoll thread\n");
 		board->interface->detach(board);
 		return retval;
 	}
 #endif
 	board->online = 1;
-	dev_dbg(board->gpib_dev, "gpib: board online\n");
+	dev_dbg(board->gpib_dev, "board online\n");
 
 	return 0;
 }
@@ -265,14 +250,14 @@ int iboffline(gpib_board_t *board)
 	if (board->autospoll_task && !IS_ERR(board->autospoll_task)) {
 		retval = kthread_stop(board->autospoll_task);
 		if (retval)
-			pr_err("gpib: kthread_stop returned %i\n", retval);
+			dev_err(board->gpib_dev, "kthread_stop returned %i\n", retval);
 		board->autospoll_task = NULL;
 	}
 
 	board->interface->detach(board);
 	gpib_deallocate_board(board);
 	board->online = 0;
-	dev_dbg(board->gpib_dev, "gpib: board offline\n");
+	dev_dbg(board->gpib_dev, "board offline\n");
 
 	return 0;
 }
@@ -320,10 +305,8 @@ int ibrd(gpib_board_t *board, uint8_t *buf, size_t length, int *end_flag, size_t
 
 	*nbytes = 0;
 	*end_flag = 0;
-	if (length == 0) {
-		pr_warn("gpib: %s() called with zero length?\n",  __func__);
+	if (length == 0)
 		return 0;
-	}
 
 	if (board->master) {
 		retval = ibgts(board);
@@ -338,10 +321,9 @@ int ibrd(gpib_board_t *board, uint8_t *buf, size_t length, int *end_flag, size_t
 
 	do {
 		ret = board->interface->read(board, buf, length - *nbytes, end_flag, &bytes_read);
-		if (ret < 0) {
-			pr_err("gpib read error\n");
+		if (ret < 0)
 			goto ibrd_out;
-		}
+
 		buf += bytes_read;
 		*nbytes += bytes_read;
 		if (need_resched())
@@ -370,10 +352,8 @@ int ibrpp(gpib_board_t *board, uint8_t *result)
 	if (retval)
 		return -1;
 
-	if (board->interface->parallel_poll(board, result)) {
-		pr_err("gpib: parallel poll failed\n");
-		retval = -1;
-	}
+	retval =  board->interface->parallel_poll(board, result);
+
 	os_remove_timer(board);
 	return retval;
 }
@@ -392,10 +372,8 @@ int ibrsv2(gpib_board_t *board, uint8_t status_byte, int new_reason_for_service)
 	int board_status = ibstatus(board);
 	const unsigned int MSS = status_byte & request_service_bit;
 
-	if ((board_status & CIC)) {
-		pr_err("gpib: interface requested service while CIC\n");
+	if ((board_status & CIC))
 		return -EINVAL;
-	}
 
 	if (MSS == 0 && new_reason_for_service)
 		return -EINVAL;
@@ -424,19 +402,15 @@ int ibrsv2(gpib_board_t *board, uint8_t status_byte, int new_reason_for_service)
  */
 int ibsic(gpib_board_t *board, unsigned int usec_duration)
 {
-	if (board->master == 0)	{
-		pr_err("gpib: tried to assert IFC when not system controller\n");
-		return -1;
-	}
+	if (board->master == 0)
+		return -EINVAL;
 
 	if (usec_duration < 100)
 		usec_duration = 100;
-	if (usec_duration > 1000) {
+	if (usec_duration > 1000)
 		usec_duration = 1000;
-		pr_warn("gpib: warning, shortening long udelay\n");
-	}
 
-	dev_dbg(board->gpib_dev, "sending interface clear\n");
+	dev_dbg(board->gpib_dev, "sending interface clear, delay = %ius\n", usec_duration);
 	board->interface->interface_clear(board, 1);
 	udelay(usec_duration);
 	board->interface->interface_clear(board, 0);
@@ -444,14 +418,12 @@ int ibsic(gpib_board_t *board, unsigned int usec_duration)
 	return 0;
 }
 
+	/* FIXME make int */
 void ibrsc(gpib_board_t *board, int request_control)
 {
 	board->master = request_control != 0;
-	if (!board->interface->request_system_control)	{
-		pr_err("gpib: bug! driver does not implement request_system_control()\n");
-		return;
-	}
-	board->interface->request_system_control(board, request_control);
+	if (board->interface->request_system_control)
+		board->interface->request_system_control(board, request_control);
 }
 
 /*
@@ -460,10 +432,8 @@ void ibrsc(gpib_board_t *board, int request_control)
  */
 int ibsre(gpib_board_t *board, int enable)
 {
-	if (board->master == 0)	{
-		pr_err("gpib: tried to set REN when not system controller\n");
-		return -1;
-	}
+	if (board->master == 0)
+		return -EINVAL;
 
 	board->interface->remote_enable(board, enable);	/* set or clear REN */
 	if (!enable)
@@ -479,10 +449,9 @@ int ibsre(gpib_board_t *board, int enable)
  */
 int ibpad(gpib_board_t *board, unsigned int addr)
 {
-	if (addr > MAX_GPIB_PRIMARY_ADDRESS) {
-		pr_err("gpib: invalid primary address %u\n", addr);
-		return -1;
-	}
+	if (addr > MAX_GPIB_PRIMARY_ADDRESS)
+		return -EINVAL;
+
 	board->pad = addr;
 	if (board->online)
 		board->interface->primary_address(board, board->pad);
@@ -498,10 +467,8 @@ int ibpad(gpib_board_t *board, unsigned int addr)
  */
 int ibsad(gpib_board_t *board, int addr)
 {
-	if (addr > MAX_GPIB_SECONDARY_ADDRESS) {
-		pr_err("gpib: invalid secondary address %i\n", addr);
-		return -1;
-	}
+	if (addr > MAX_GPIB_SECONDARY_ADDRESS)
+		return -EINVAL;
 	board->sad = addr;
 	if (board->online) {
 		if (board->sad >= 0)
@@ -523,10 +490,8 @@ int ibeos(gpib_board_t *board, int eos, int eosflags)
 {
 	int retval;
 
-	if (eosflags & ~EOS_MASK) {
-		pr_err("bad EOS modes\n");
+	if (eosflags & ~EOS_MASK)
 		return -EINVAL;
-	}
 	if (eosflags & REOS) {
 		retval = board->interface->enable_eos(board, eos, eosflags & BIN);
 	} else {
@@ -717,10 +682,8 @@ int ibwrt(gpib_board_t *board, uint8_t *buf, size_t cnt, int send_eoi, size_t *b
 	int ret = 0;
 	int retval;
 
-	if (cnt == 0) {
-		pr_warn("gpib: %s() called with zero length?\n", __func__);
+	if (cnt == 0)
 		return 0;
-	}
 
 	if (board->master) {
 		retval = ibgts(board);
-- 
2.48.1


