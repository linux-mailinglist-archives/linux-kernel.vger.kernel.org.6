Return-Path: <linux-kernel+bounces-403114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87E9C3130
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 09:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AF31F21528
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A214D2A3;
	Sun, 10 Nov 2024 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBt/VfrA"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03156233D62;
	Sun, 10 Nov 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731226914; cv=none; b=McWZoB6ljPc8tprgAOdClZM3n0fSQ2QO2koLr6vtEqLReiSlGxt1RyWQcf2u4uPp6NBsir/lUHgEtIPyUNYMAFJ+A/flgo45tWXcCVK01rkBcX5AfEXJ5tuBiPJIzFVJ8Bg6cUBa9SVuwroX+T81x/Ioa5faKRY9rncxe4IE654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731226914; c=relaxed/simple;
	bh=mS0NJvmkNJJqCVQvumHueIccoHc3eb+ixHeylEtjIbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kaKLQBkf0RmOeXCNLIrVuKC2tzThIxCcEmQ2LKqSW5goos59vrXpRxxiJ/75VK7ZakDoCVA+Z1t9NISxPZFna0ouc7HYKgMwFdLYgWsaVu+h7JVZgajMjYoutSSM4D8/j6kD7Jkf8d313mWZQg0ugFybgkA0XykbFo0QfLkmuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBt/VfrA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37f52925fc8so2309733f8f.1;
        Sun, 10 Nov 2024 00:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731226911; x=1731831711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS6ya7rSrjhzx/kP8eWMzhEijgroI+Me6kt4/h0PLaY=;
        b=gBt/VfrAX/vZTbPIrr2X+gUhAj5AsbmlWQ8bKSSuVJJP5gNyF9drou/NmA7ae7H4Or
         qpwynp05IYmhek4UJkyjh2rcu0hENxiIm79qb+YorJS2tEVkL4nAbxS8FNqmfOyGBlus
         up6nPuMtM+8jNQm80BDaoG36IJ132gY0OUwqadgZtzQt9bXibOK/xe+qKRurQ3rsiHwZ
         1LP4xFwqWU15R9WZBu4Qhz2FPG1BhlQwHPeoHY40rEMdBUj6xluRkNSuRDjs/Ugz1Hz4
         BguxS2QeJ772b2PYCubZm3W77Vth4Q0WeU32ZsN3TZsDz3X90JJ6+W7L1Sjqq5pIz50F
         3n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731226911; x=1731831711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS6ya7rSrjhzx/kP8eWMzhEijgroI+Me6kt4/h0PLaY=;
        b=fdvZvGgkQRxD1N7p0x53PZZVqf9LlAwxbRoeXE667P254noX4NkxNeGiORcNNUSm0w
         ZID1Km2PtBJiehd2jvztA979dzQksVbMyLpsz82TpC+b6u1FkmilzWh/rCsK5GOsXK4d
         qSeSDLOyszz57zrQvUiSG9tXQ0U7Lz4an1QpEIII7zZNhLISHQHdTLpI/AZmMXNunn5V
         IIFws1shfT9GrPLKKkpZph17cQ9GcXd5N4JOjRdOn6G5Hh16x/gmFQuXPmBNdLuiW13O
         SZhFVmD6yW74TEWHvOiDAlZKOYUNeytU2j/+qw944ilA+XSmbgp1b+zTKYD0JAR2UMso
         CzGg==
X-Forwarded-Encrypted: i=1; AJvYcCVxvKQhz7y63uGgpaEKbwVHZgrThgU5EX1sv6iH85uVeESlEoplxCgzbPfa2ybk4mQ6iuKKdQIAXho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhW5DHiqv2PQU41R3rAkulPgzhutYoBuUppSdEmXSDesaupUmo
	i4KNhf0Dp7VCK8lRmXt62UcZG05t0sqBS/oPtkqepIolrlE70qVrCv8Vd5owZk4=
X-Google-Smtp-Source: AGHT+IHEjbcibLi89EPmzRIQ/mMnYWTDUqTE/3kS4OCeppruMmHxBgnedgWpE4CGx8HzGwH3VY2Yaw==
X-Received: by 2002:a05:6000:460a:b0:381:d9cf:c023 with SMTP id ffacd0b85a97d-381f18850damr6401388f8f.55.1731226911061;
        Sun, 10 Nov 2024 00:21:51 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce27sm9760262f8f.29.2024.11.10.00.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 00:21:50 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	oneukum@suse.com,
	snovitoll@gmail.com,
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] usb/cdc-wdm: fix memory info leak in wdm_read
Date: Sun, 10 Nov 2024 13:21:44 +0500
Message-Id: <20241110082144.3480163-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024111053-henchman-unsecured-cd6f@gregkh>
References: <2024111053-henchman-unsecured-cd6f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is no
reproducer and the only report for this issue. This might be
a false-positive, but while the reading the code, it seems,
there is the way to leak kernel memory.

Here what I understand so far from the report happening
with ubuf in drivers/usb/class/cdc-wdm.c:

1. kernel buffer "ubuf" is allocated during cdc-wdm device creation in
   the "struct wdm_device":

        static int wdm_create()
        {
           ...
           desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
           ...
           usb_fill_control_urb(
              ...
              wdm_in_callback,
              ...
           );

        }

2. during wdm_create() it calls wdm_in_callback() which MAY fill "ubuf"
   for the first time via memmove if conditions are met.

        static void wdm_in_callback()
        {
           ...
           if (length + desc->length > desc->wMaxCommand) {
             ...
        } else {
           /* we may already be in overflow */
           if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
              memmove(desc->ubuf + desc->length, desc->inbuf, length);
              desc->length += length;
              desc->reslength = length;
           }
        }
           ...
        }

3. if conditions are not fulfilled in step 2., then calling read() syscall
   which calls wdm_read(), should leak the random kernel memory via
   copy_to_user() from "ubuf" buffer which is allocated in kmalloc-256.

        static ssize_t wdm_read()
        {
            ...
            struct wdm_device *desc = file->private_data;
            cntr = READ_ONCE(desc->length);
            ...
            if (cntr > count)
                cntr = count;
            rv = copy_to_user(buffer, desc->ubuf, cntr);
           ...
        }

        , where wMaxCommand is 256, AFAIU.

syzbot report
=============
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:180 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:180 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 wdm_read+0x227/0x1270 drivers/usb/class/cdc-wdm.c:603
 vfs_read+0x2a1/0xf60 fs/read_write.c:474
 ksys_read+0x20f/0x4c0 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x93/0xe0 fs/read_write.c:627
 x64_sys_call+0x3055/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9760fbbd535cee131f81
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes v1 -> v2:
- added explanation comment above kzalloc (Greg).
- renamed patch title from memory leak to memory info leak (Greg).
---
 drivers/usb/class/cdc-wdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 86ee39db013f..59176e91ff9b 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -1063,7 +1063,8 @@ static int wdm_create(struct usb_interface *intf, struct usb_endpoint_descriptor
 	if (!desc->command)
 		goto err;
 
-	desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
+	/* Need to zero this out because it could expose data to userspace. */
+	desc->ubuf = kzalloc(desc->wMaxCommand, GFP_KERNEL);
 	if (!desc->ubuf)
 		goto err;
 
-- 
2.34.1


