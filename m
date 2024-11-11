Return-Path: <linux-kernel+bounces-404008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28CE9C3DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52AE4B22E72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E98C194136;
	Mon, 11 Nov 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsug0prW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7117C91;
	Mon, 11 Nov 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326507; cv=none; b=DPfgeCp+bcTk/gHt+Y6QHPw+4YBq6ogwUomRTLXkVELP28on7t3DqeB3u4N4ZK2Yf4ZjTAwV0OkAD61ECGmpq5gOXOa7vXb7e8/CjofgdyHJIp0L39OgYJb/GmPNZzXmIESlF/0DMdyj1ZNB+hip9Yj/SA/AFXUGDSCMBvyIKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326507; c=relaxed/simple;
	bh=8PYbB3UhG4WQUHRgPqR55J69aoM3qRSSFc6AA5VVsS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhdNaKgZCY6Ev1gh7OFb03FQGMMagyR71XFdkPOQ7IyS1RW7UtCqTaGQsWRzhOsqukRJPrBKfqi+YTKm/uYfZFgDM7534dfxlbxxuDFb/0AJHcdmjQzOBrvQg9ww6doK4PKdGSgX64/uzuXy7EFCPB2x/Bbmw8HNM6/vLqunf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsug0prW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so36073335e9.0;
        Mon, 11 Nov 2024 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731326504; x=1731931304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oZnAKGebo1Vl/ZvvJkLq5df9Ai1X51Vud6nztCpA1I=;
        b=Jsug0prWNTj8Kz6FANV1vyEDROTCQaX7vljZZaMn9ph5aPM3f9UWylueqCRQBhmJrc
         Qt/MpPvKkjr6frRxohqiO4iN0nUYh6YbGlNT24MhY6RchPNCTpuNsGJ5nsir6CSmijuz
         N5IkRFl9DdAMWHkOVGtQO1xWfLlCARJ4KfSBQwH0pfSmRWoMSkcIw+zQxkvs5TUbCdO6
         ruyDGOSJRGC5/hOcAGRGlu8vZFCeJ7kyHVbUg6OscCT8G7M53iug1NLbRVta2iY5sPwO
         ok0tCy47W2AIj+HZuk7aKOjRI+wqhdZ6rYoNnwlpl5MW1oUrywpXfrdSHy/gfVFsnnEd
         e7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731326504; x=1731931304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oZnAKGebo1Vl/ZvvJkLq5df9Ai1X51Vud6nztCpA1I=;
        b=W/0x0Di/+gPaKW8gGNHZpuBQF03ye/mvbziM3eqfZJbRv4/XC6tPQaUpF+SolNuwj2
         ru/BJqywnahmHJWEznFGAfqFyiO+jq5LUszqo5549wl9/0iH2tCMgp0S2x84GKdhAC1z
         KJuEyc0jjurantuhmSsQJcaxpYFpwtcVP1wLtctT27aGaUcikdjIfJuIHGWMRIhqfMFk
         B+upU/6JeLt+5dxTYhCdB/Ps53B4i9Y5skCJ4KybBynTxpxE1YekC+Ybt6lmmq6KninP
         wnzia/Rr7O4YehUYh9yE5ndC68xacWq9s4G/yc9x1WpKiQq25O8pHZvJcFT8CtXhL4W1
         DX0w==
X-Forwarded-Encrypted: i=1; AJvYcCWLcq8wUQSTiOM66wh55do20bAa06KTNYbD7a87fC5uXJpnLw5pmspl52ZkeR5Fz22Ajusy2/oUWQa8iJs=@vger.kernel.org, AJvYcCXo6t0+unZOa1SwK753ls9jKOziARwOtHT4An1icDEe49Z4kUoocD41HYJkR7zeZpxGC67/cxyvjGZa@vger.kernel.org
X-Gm-Message-State: AOJu0YyduPnQDHNZrgNGx8lYhB95rVWqvf8MFmrXKURxv0s+NC7Y9Yt4
	mDXoC+4MNxxyEwMxXcca83AekiE07b/u/vxPpwW+Zk5r8CDs3HeW
X-Google-Smtp-Source: AGHT+IHljxaWn/UibrMneKIAtzR793B76Pd/t1oDzAkMwnIojSoUiAZuudI8jfQF41wlqTXqOC/TjA==
X-Received: by 2002:a05:600c:3b2a:b0:431:5aea:964 with SMTP id 5b1f17b1804b1-432b7509769mr103767555e9.19.1731326504049;
        Mon, 11 Nov 2024 04:01:44 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0562860sm173490545e9.22.2024.11.11.04.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:01:43 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: snovitoll@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	oneukum@suse.com,
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v3] usb/cdc-wdm: fix memory info leak in wdm_read
Date: Mon, 11 Nov 2024 17:01:39 +0500
Message-Id: <20241111120139.3483366-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACzwLxjD0PceaD27Ya6fFxKnSQZajtG2sEArqX6toS8SjNcinw@mail.gmail.com>
References: <CACzwLxjD0PceaD27Ya6fFxKnSQZajtG2sEArqX6toS8SjNcinw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is no
reproducer and the only report for this issue.

The check:

	if (cntr > count)
		cntr = count;

only limits `cntr` to `count` (the number of bytes requested by
userspace), but it doesn't verify that `desc->ubuf` actually has `count`
bytes. This oversight can lead to situations where `copy_to_user` reads
uninitialized data from `desc->ubuf`.

This patch makes sure `cntr` respects` both the `desc->length` and the
`count` requested by userspace, preventing any uninitialized memory from
leaking into userspace.

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
Changes v2 -> v3:
- reverted kzalloc back to kmalloc as the fix is cntr related (Oliver).
- added constraint to select the min length from count and desc->length.
- refactored git commit description as the memory info leak is confirmed.

Changes v1 -> v2:
- added explanation comment above kzalloc (Greg).
- renamed patch title from memory leak to memory info leak (Greg).
---
 drivers/usb/class/cdc-wdm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 86ee39db013f..dd7349f8a97a 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -598,8 +598,9 @@ static ssize_t wdm_read
 		spin_unlock_irq(&desc->iuspin);
 	}
 
-	if (cntr > count)
-		cntr = count;
+	/* Ensure cntr does not exceed available data in ubuf. */
+	cntr = min(count, (size_t) desc->length);
+
 	rv = copy_to_user(buffer, desc->ubuf, cntr);
 	if (rv > 0) {
 		rv = -EFAULT;
-- 
2.34.1


