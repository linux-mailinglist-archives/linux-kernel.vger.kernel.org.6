Return-Path: <linux-kernel+bounces-326938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D05976ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8511C23A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA018FDD7;
	Thu, 12 Sep 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX3mVhST"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C118732B;
	Thu, 12 Sep 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158868; cv=none; b=k+9gK+SQOluPyw6Lgdl3cfG0bcIVvd6ZDo4DF2Tws+w87SziGMxg5ghsT5s5LKu5bMirRMI9tXVCY8LKA+uqGT8od7OHiFbIJsn12sUpQVQijIkgtIGZeguKHY5/ZCUOVBONVhwpQUSg3hWCDXYFhi92wqqoPmVfv3CNwZ1hy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158868; c=relaxed/simple;
	bh=iEPQ8zzcorMOzRJBRTf9fmKdtL3HliGfxkfxfwUJNsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tMjvSI9C/734oMVtw9ULpuMF19Bt9SD2oDkuFPRsqHXovQS80r7/zxKRV7JCM/9S39ooTDqrh3t0qNWyIMmfe6Pn9kijmqb9ZACQL4n0x8v0J4KObdWI4Avx9/ok1/rECCTCsR8gb063At5BolLKsPLK4PEZsDzLd3NhxZztMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX3mVhST; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1004574a12.2;
        Thu, 12 Sep 2024 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726158866; x=1726763666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=547bd2aXINcYH9WA1WmShRDK1C+/D+Dc9zpQGWKFd5Y=;
        b=ZX3mVhSTNul+S9ewxKBmEjhwoCdPOFDy9tnAux4z3nxB5uLmLwZo+oxUs1z8LgDXOe
         07NXBulfWwJt2YJrIyWtrQiF5e2hjDtS0fCQB3dSkIUsFHXxtC94NIRS9siwIO+vAODo
         m+YdU4OewZJrSW1zRwvwC/FKPCbd1Rdh1aYfnvI0bDWC4FTKxDk5mgT43JSjZFbyVdBS
         g2ZPdWLfyjMtnTmemArQGcTIaVaOCgaJo3OfZDQvOjMdr3YkyhVpPfWhGckr49kpXImc
         O5RwNIncJlKtYGpex8a/UdA9sFArqKDVOCS2f0Ob/7F/jcGwWSi/9wIaSa+HJeorVWqS
         TCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158866; x=1726763666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=547bd2aXINcYH9WA1WmShRDK1C+/D+Dc9zpQGWKFd5Y=;
        b=V2nSK6uR0AnkTKs7knrVfS+MCLQJztv3DDJmOVHXg4m5+tupOXHUrEQJfPSrreC3ws
         d9/26WM+Nn5o6DviBhKh9VIJXXscBrGgRSvIae0H6LdYdzNDtMmVB1n5dfl8nq3PTs73
         O1GDx13B0Y8vpN3DUs0J87uZTGaEutc5Q7FCTLU0behFu1pOM6BArN99Wowo8xrtZRoF
         9q/kDuAeOMswdjsLCl5ZVnMqimTzsiLX6oOFxrkqVqcrYEIBRbwhkY5o01URVBTO0p2a
         k2GtzcObpAXFfo+4IhEI72AZupxT4Mozf04UBZkhGaFwhpTr+5Hi58JYz5zGDvL/mbsX
         Im2A==
X-Forwarded-Encrypted: i=1; AJvYcCVqrqRl4R1p3MVWcH45T+btLgLee/3Me1JM0UB8ENNBO1Mvtf/7VhqZdsc4q00XNTcXFHchnpI9cJpP@vger.kernel.org, AJvYcCW7U9+DTvQ+XPaGJZ01yB1PD1j74m7z+x/j3ZgpDDELWJ+2or/B4qkCceCDI/sVZqH9WeJSkrh0diysPZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTZ33ru+JzalBj16N722xCxV1NCeLNApZ26MwI2mVr7bruk4C
	0Stw1qzmazIN+Qs8LGSuWNTWkfm7fJ74novaWDcvaVjV3fPlBVHY
X-Google-Smtp-Source: AGHT+IGahJU9/cTFpSeTVZNaeztxiBF+TKN2FP5ccEkm/2ol42zS2uyvp62hTojCAi3Bh1dsNdkbIA==
X-Received: by 2002:a05:6a21:164e:b0:1cf:4dc3:a89e with SMTP id adf61e73a8af0-1cf75c7e8a6mr4320859637.9.1726158865858;
        Thu, 12 Sep 2024 09:34:25 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8459sm4769040b3a.24.2024.09.12.09.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 09:34:25 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: gregkh@linuxfoundation.org
Cc: colin.i.king@gmail.com,
	kees@kernel.org,
	gustavo@embeddedor.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] usb: iowarrior: fix infoleak in iowarrior_read()
Date: Fri, 13 Sep 2024 01:34:13 +0900
Message-Id: <20240912163413.10019-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dev->read_queue buffer memory allocated from iowarrior_probe is
allocated in an uninitialized state, and it is possible to copy the
uninitialized memory area to the user buffer through iowarrior_read.

This has a risk of leaking important information, and even if it is
modified to initialize to NULL bytes when allocating memory, there is
no significant change in performance, so I think it is appropriate to
allocate memory through kcalloc instead of kmalloc_array.

KMSAN report:
=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:180 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:180 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 iowarrior_read+0xb02/0xdc0 drivers/usb/misc/iowarrior.c:326
 vfs_read+0x2a1/0xf60 fs/read_write.c:474
 ksys_read+0x20f/0x4c0 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x93/0xe0 fs/read_write.c:627
 x64_sys_call+0x3055/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3998 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4174
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kmalloc_array_noprof include/linux/slab.h:726 [inline]
 iowarrior_probe+0x10ea/0x1b90 drivers/usb/misc/iowarrior.c:836
 usb_probe_interface+0xd6f/0x1350 drivers/usb/core/driver.c:399
 really_probe+0x4db/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:799
 driver_probe_device+0x72/0x890 drivers/base/dd.c:829
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:957
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1029
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3682
 usb_set_configuration+0x31c9/0x38d0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:254
 usb_probe_device+0x3a7/0x690 drivers/usb/core/driver.c:294
 really_probe+0x4db/0xd90 drivers/base/dd.c:657
 __driver_probe_device+0x2ab/0x5d0 drivers/base/dd.c:799
 driver_probe_device+0x72/0x890 drivers/base/dd.c:829
 __device_attach_driver+0x568/0x9e0 drivers/base/dd.c:957
 bus_for_each_drv+0x403/0x620 drivers/base/bus.c:457
 __device_attach+0x3c1/0x650 drivers/base/dd.c:1029
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1078
 bus_probe_device+0x3dc/0x5c0 drivers/base/bus.c:532
 device_add+0x13aa/0x1ba0 drivers/base/core.c:3682
 usb_new_device+0x15f4/0x2470 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x4ffb/0x72d0 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Bytes 0-72 of 73 are uninitialized
Memory access of size 73 starts at ffff88811bbc6000
Data copied to user address 0000000020000000

CPU: 0 UID: 0 PID: 5938 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-g77f587896757 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================

Reported-by: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Tested-by: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Fixes: 23feefda2239 ("usb: iowarrior: replace kmalloc with kmalloc_array")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/usb/misc/iowarrior.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..5240e05c094e 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -831,9 +831,9 @@ static int iowarrior_probe(struct usb_interface *interface,
 			 dev->int_in_buffer, dev->report_size,
 			 iowarrior_callback, dev,
 			 dev->int_in_endpoint->bInterval);
-	/* create an internal buffer for interrupt data from the device */
+	/* create an internal buffer for interrupt data from the device and initialize it */
 	dev->read_queue =
-	    kmalloc_array(dev->report_size + 1, MAX_INTERRUPT_BUFFER,
+	    kcalloc(dev->report_size + 1, MAX_INTERRUPT_BUFFER,
 			  GFP_KERNEL);
 	if (!dev->read_queue)
 		goto error;
--

