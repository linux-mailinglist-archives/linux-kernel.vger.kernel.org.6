Return-Path: <linux-kernel+bounces-560380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CAAA60354
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA33A8262
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DD1F4C9F;
	Thu, 13 Mar 2025 21:19:21 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5117747F;
	Thu, 13 Mar 2025 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900761; cv=none; b=dBR5JZN3/qs2BsCWwmRaom7m1iivALgngG89km+GGAlh5WiGGGUd9X+EsCXJILzz2T38Eg/1SU6bQ1eVPfsIuV6T8K1atEloGw0mxYHRzQ6mxMIcfWrSbHT1DKKx5fY5/y8uqgYAbwV4zyc5k2bEQAUqM/rrUcLHLDdJO0R1vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900761; c=relaxed/simple;
	bh=0MJzd9VskY95xlDDwzDUQR2rJ0WzgQU/F/H9pYC4Ys0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J69vWdM7PTfPIzgNLHYrP+Rb1d6a/qVijJojkwdP0e+irunAR1IrQ6MNRmQKUJ5DrnwFg0ztVgDiTmg+u3HWS2qfuKKxuRebjVTaou1VGJJp7CD/MYG6QVQl6Kne02Y4EAxIXS0Q+Mb8d7szlYiXdTdpi8bYAHU0gUF0o5t3eeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 3EF9E233CA;
	Fri, 14 Mar 2025 00:19:08 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Dave Penkler <dpenkler@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH] usbtmc: Fix slab-out-of-bounds access in usbtmc_interrupt
Date: Fri, 14 Mar 2025 00:19:07 +0300
Message-Id: <20250313211907.1179173-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent buffer overflow in usbtmc_interrupt by ensuring interrupt IN
endpoint packets are at least 2 bytes (1 byte ID + 1 byte data), as
required by the driver. Without this, short packets could lead to
out-of-bounds reads of iin_buffer.

- In usbtmc_probe(), reject devices with wMaxPacketSize < 2 bytes to
  ensure the allocated iin_buffer is large enough.
- In usbtmc_interrupt(), skip processing and log a warning if
  actual_length < 2 bytes, avoiding invalid memory access.

This fixes a KASAN slab-out-of-bounds error:

BUG: KASAN: slab-out-of-bounds in usbtmc_interrupt (drivers/usb/class/usbtmc.c:2297)
Read of size 1 at addr ffff88800a41b2e1 by task kworker/0:1/11
CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.14.0-un-def-alt0.rc6.kasan #1
Call Trace:
 <IRQ>
 dump_stack_lvl (lib/dump_stack.c:122)
 print_report (mm/kasan/report.c:521)
 kasan_report (mm/kasan/report.c:636)
 usbtmc_interrupt (drivers/usb/class/usbtmc.c:2297)
 __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1650)
 usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1735)
 dummy_timer (drivers/usb/gadget/udc/dummy_hcd.c:1995)
 __hrtimer_run_queues (kernel/time/hrtimer.c:1865)
 hrtimer_run_softirq (kernel/time/hrtimer.c:1884)
 handle_softirqs (kernel/softirq.c:561)
 __irq_exit_rcu (kernel/softirq.c:662)
 irq_exit_rcu (kernel/softirq.c:680)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049)
 </IRQ>

Found by Linux Verification Center (linuxtesting.org) with
'USB Gadget Tests'[1]:

$ make usbtmc
$ sudo src/usbtmc/usbtmc --invalid_ep_int_len

[1] Link: https://github.com/kovalev0/usb-gadget-tests
Fixes: dbf3e7f654c0 ("Implement an ioctl to support the USMTMC-USB488 READ_STATUS_BYTE operation.")
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/usb/class/usbtmc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 34e46ef308abf..8a3ba90f32455 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -47,6 +47,9 @@
  */
 #define USBTMC_MAX_READS_TO_CLEAR_BULK_IN	100
 
+/* Minimum packet size for interrupt IN endpoint */
+#define USBTMC_MIN_INT_IN_PACKET_SIZE 2	// 1 byte ID + 1 byte data
+
 static const struct usb_device_id usbtmc_devices[] = {
 	{ USB_INTERFACE_INFO(USB_CLASS_APP_SPEC, 3, 0), },
 	{ USB_INTERFACE_INFO(USB_CLASS_APP_SPEC, 3, 1), },
@@ -2291,6 +2294,14 @@ static void usbtmc_interrupt(struct urb *urb)
 
 	switch (status) {
 	case 0: /* SUCCESS */
+		/* check for valid length */
+		if (urb->actual_length < USBTMC_MIN_INT_IN_PACKET_SIZE) {
+			dev_warn(dev, "short interrupt packet: %d bytes, min %d required\n",
+				 urb->actual_length,
+				 USBTMC_MIN_INT_IN_PACKET_SIZE);
+			goto exit;
+		}
+
 		/* check for valid STB notification */
 		if (data->iin_buffer[0] > 0x81) {
 			data->bNotify1 = data->iin_buffer[0];
@@ -2426,6 +2437,15 @@ static int usbtmc_probe(struct usb_interface *intf,
 		dev_err(&intf->dev, "can't read capabilities\n");
 
 	if (data->iin_ep_present) {
+		if (data->iin_wMaxPacketSize < USBTMC_MIN_INT_IN_PACKET_SIZE) {
+			dev_err(&intf->dev,
+				"Int in endpoint wMaxPacketSize too small: %d, minimum %d required\n",
+				data->iin_wMaxPacketSize,
+				USBTMC_MIN_INT_IN_PACKET_SIZE);
+			retcode = -EINVAL;
+			goto error_register;
+		}
+
 		/* allocate int urb */
 		data->iin_urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!data->iin_urb) {
-- 
2.42.2


